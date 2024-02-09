Return-Path: <linux-kernel+bounces-59718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D344A84FAE2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9594A285133
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705F57EF12;
	Fri,  9 Feb 2024 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LHznyKEG"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4457BB02;
	Fri,  9 Feb 2024 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499159; cv=none; b=bKuWRekmQVJ4pAlVMpNE5kbvuQoTUMblm/Fbx1SEjFjgeIWPMrxA7GJOtS48flIBqpVg4ONvAHYAQM8odYntbTFU7EI1sUavJueMSBWCM96HYCMSr/k+K5WLDgauoA8eJB8e407FtgAyArOUcW66+tqFPpqirGKfNTzJuq14hKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499159; c=relaxed/simple;
	bh=5chEcUoZy69N+Njxway//+D9Qq97cnHEhm7OTKP1+z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZRwM9QXziM55KyrVvGaxtBb3Pl3yfnYJcWt1AYTWc5WFxlXDGBbUw2uPNYj0W2yIkRqnLgIGuati1b3yPQWMX7Q446lc1vvFueuJYSdFlmJpIcmgOSLy5EnigIOZFyaoU+8SVHWh+YRoz1Y1nGxHMOXwO6cQuKc3lhH2msIuw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LHznyKEG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mCTkf7Uhk05htdUngOFotI43lknoNa0E5lP/jBopk84=; b=LHznyKEGKRt7UxP+B/ChINmYVD
	fZWLUuYEyPS5FhCXMRw/ImIQBWn503zlvLefjzwSgOG+QwOlAnW06F8p38bPX+ksKWjDOi9ORuN+3
	LWP4qJOtgpJ10JjchxgOVW4PEHkw4jZY/a4xnYq7ss0K3AJ62uOBJUjcntUZYILHyJaA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYUWo-007P7U-3P; Fri, 09 Feb 2024 18:19:06 +0100
Date: Fri, 9 Feb 2024 18:19:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jon Maxwell <jmaxwell37@gmail.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v2] intel: make module parameters readable in sys
 filesystem
Message-ID: <135d4123-29f5-46dd-b06e-d5a66bd7f598@lunn.ch>
References: <20240208221802.131087-1-jmaxwell37@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208221802.131087-1-jmaxwell37@gmail.com>

On Fri, Feb 09, 2024 at 09:18:02AM +1100, Jon Maxwell wrote:
> v2: Remove the "debug" module parameter as per Andrew Lunns suggestion.
>     It's not really needed as ethtool msglvl can control that.

It is normal to places comments like the above under the ---. In its
current place, it will be part of the commit message. Under the --- it
gets dropped when the patch is applied.

    Andrew

---
pw-bot: cr

