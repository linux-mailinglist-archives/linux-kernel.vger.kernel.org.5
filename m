Return-Path: <linux-kernel+bounces-59207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F4284F33C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969E61F2436F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A4B6994D;
	Fri,  9 Feb 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oosSjFvC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38036774E;
	Fri,  9 Feb 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474040; cv=none; b=NTvd0f19Gr5GjX2rcZs/WlmhTDSZ4TzrwkY36UOEFhVNYes6CvYXnkoz1wX6FDjYjNJNbjH2+MXlcFEruDT/8iJus4zKX4e8zpa+6arvFLv0OBb+mIbGeBPfAA8s/j7Ft1w5KOuYY+4LEw2lkaeRFN2qZy5syMFBsyp1sutF87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474040; c=relaxed/simple;
	bh=4lgbDPmTsi0HF0ppwR3s76JThiYAeUNtCaOzdFBIPxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sa5RUnU9ojHpeMlWTTENrE+HlWTZED5RWYswXiasVXhrMs/pgomnjLeGp6hNPeOuSJ8yQfAroUvFmIUe0YLmbO0LI/JRE7gXIG9V0cq97valet6N1J8PeGmK+PFN8GJbz2sxoeuA1c+Qijt1GNcYNl9EluCW/RuBNbhoSH53OGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oosSjFvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B06C433F1;
	Fri,  9 Feb 2024 10:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707474039;
	bh=4lgbDPmTsi0HF0ppwR3s76JThiYAeUNtCaOzdFBIPxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oosSjFvCtYMVZK5VNjKbI/h8k6RoXOGncXecgbTJW0Zjt9b1c0Rgsa/3QQgFQJH6S
	 jiLcmsCYk4IualaYNeC+YPhjGxhv2QRyTw4kxADApFu01Wx/jXTkGZ52KC7roiYiIe
	 KglyBDdE6Ccj8tkP++NxzHJEjhZRXX0Lg7f7bme0=
Date: Fri, 9 Feb 2024 10:20:36 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Rengarajan.S@microchip.com, linux-serial@vger.kernel.org,
	Kumaravel.Thiagarajan@microchip.com, linux-kernel@vger.kernel.org,
	Tharunkumar.Pasumarthi@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Add Burst mode
 transmission support in uart driver for reading from FIFO
Message-ID: <2024020916-barrette-okay-60f7@gregkh>
References: <20240125100006.153342-1-rengarajan.s@microchip.com>
 <b8325c3f-bf5b-4c55-8dce-ef395edce251@kernel.org>
 <e7f29dd64829b597f3881abcf4da653156c1fe59.camel@microchip.com>
 <fa17f083805e46079bfb4ed89b83d372cfe7e77c.camel@microchip.com>
 <0c1e8d38-4b00-4738-bd05-7e36ce736681@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c1e8d38-4b00-4738-bd05-7e36ce736681@kernel.org>

On Fri, Feb 09, 2024 at 07:38:49AM +0100, Jiri Slaby wrote:
> On 09. 02. 24, 5:52, Rengarajan.S@microchip.com wrote:
> > Hi Jiri Slaby,
> > 
> > The patch has been accepted and added in the tty-git tree and will be
> > merged during the next merged window. Should the changes be given as a
> > seperate incremental patch or should we re-submit this patch again.
> 
> Hi,
> 
> as you write, you cannot change the patch as it is already queued. PLease
> submit changes on top.

Or, if the original is so bad, we can revert them now and wait for new
ones later, just let me know.

thanks,

greg k-h

