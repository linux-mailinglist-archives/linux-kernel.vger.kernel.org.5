Return-Path: <linux-kernel+bounces-93703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFA587338F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5921F21D57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA275F56A;
	Wed,  6 Mar 2024 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElKlC7nn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717045D8FF;
	Wed,  6 Mar 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719547; cv=none; b=qE5LgkgUJ1BOfvgCGQd3UxCsLrxH30OA16uW7VJtN8xWMu8TkooPu1g2OtMZ4FHE0Be+hb+/lp6GU8R7nB77R/nkb9mARrX/LRWK2AFGDXZbqWBkER2HXFqt5DQQULwXxWflupRFHnZYvUMhbwJvzU+FI0/I/90O49T0k7RpkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719547; c=relaxed/simple;
	bh=TvUCt+4q4dZnUG+ar51M/roVvEKXMk1nhtmDZYicaCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrjrAAzBbTD46OOurxYxEVEFsy/NhkTIli1GupHRA30irZuwVWNsGzW26lo1EY9zuL7HQU8ACxsr9enGCn8P6GEUXaZQsBLlE0X+nveGzdDHt+oUdJuQil8IIFNrecS80GqFnpT1L71nJ64pvKFZpoRggasdva5S9uuAui+fFWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElKlC7nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08867C433C7;
	Wed,  6 Mar 2024 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709719547;
	bh=TvUCt+4q4dZnUG+ar51M/roVvEKXMk1nhtmDZYicaCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElKlC7nnVQVcuCVzpd5Jem3sGDNE0/bkU3hO08aCz9vw5oiDh2Spk0QT7DQiCw+lj
	 rdqFN7HdaE/9zSRJNfXu3VPHUzBzqck4/crjgzX9XgWoFbqlYWP74PCuUuogDKy3pM
	 EdIaBT3pKRYakpGwdDbcjjB16e6Il4YAI/M1uZUAe2TToIE6QVEe6SzT3yuz9BtSD0
	 3JL3A7QVYHoc6LurvpX/MiBBJNFsl4WI5mwW9+iZa2+5sU91iUU5nDL2xxodFOe0Dl
	 qyr1P8k1RH9q6a5z9X7kNyy/d2pUwjZaTAc4M/C7/BQKNOJki9wDTm2l+Veh+eUmL3
	 p1pHafh4fYRTA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rho9q-000000001gI-2hFw;
	Wed, 06 Mar 2024 11:05:54 +0100
Date: Wed, 6 Mar 2024 11:05:54 +0100
From: Johan Hovold <johan@kernel.org>
To: bolan wang <bolan.wang@fibocom.com>
Cc: gregkh@linuxfoundation.org, larsm17@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Fibocom FM135-GL variants
Message-ID: <ZehAAmM3PHGRLIP4@hovoldconsulting.com>
References: <20240306093533.1313241-1-bolan.wang@fibocom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306093533.1313241-1-bolan.wang@fibocom.com>

On Wed, Mar 06, 2024 at 05:35:33PM +0800, bolan wang wrote:
> Update the USB serial option driver support for the Fibocom
> FM135-GL LTE modules.
> - VID:PID 2cb7:0115, FM135-GL for laptop debug M.2 cards(with MBIM
> interface for /Linux/Chrome OS)
> 
> 0x0115: mbim, diag, at, pipe

Please include the output of usb-devices for this device here in the
commit message.

> Signed-off-by: bolan wang <bolan.wang@fibocom.com>
> ---

Also, this is v3 of this patch and this needs to be indicated in the
patch summary ("PATCH v3") and by including a short changelog here after
the '---' line.

Please fix in a v4.

Johan

