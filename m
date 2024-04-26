Return-Path: <linux-kernel+bounces-160733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149C38B421F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5754282498
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908B538DD6;
	Fri, 26 Apr 2024 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YsT4k/Bi"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646F54A3F;
	Fri, 26 Apr 2024 22:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714170079; cv=none; b=XjUBtm6aC/j/dqhpQfNyZF8s6oQFvt6UnDEr5Ex/TWqVxVcAXjj5rcDXGw3EF8nlYcQDIHDSNgZ7kZtXjP6LV8gv4dVdGiMDUTgQf4bgMncS0nOXkOPLKkl3M0cntLv2a0lhfTyNUYrcTRzKcwd2TqgKimSzonWbVcq7V5q8NEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714170079; c=relaxed/simple;
	bh=EUlizgcxso2aTQ6uS+9xKMyAIGjtTlvv0YMID19KswU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pnvl9JkJAuGMkdSdNTNZUhE8cIyk1dDh6zy9EF98ZpYTw6FHHEjWct9hzcUFX80olR2kGbaL409Azgr/dhBu8HKNW7v+3zCPT35eObcc43XOPy39qJfammwt7hqX/+rnSTJZOlKmSBlY0f137A9bEqX1w/XySVl7GOoojW3J1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YsT4k/Bi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BMXP4QZNQ05xhxi1ioEEoKbUgZFGoJ2UMN7lYCFxZkI=; b=YsT4k/BiBL+2lnyXGBxnG8mQmY
	RHJLNhdQf4eExpNidikEjhlocI1JUa3v+DNy1DezPkLnUzA9b+2dupSLcChNOXfXmfFzwuaKkJ0mI
	uH5pvNtBSGCcS58wt9slKCH3DoEC1ovycFJAfelcW/smKfxgrvo0BOeM2drDMEVc9ujY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s0TwF-00E70Q-9F; Sat, 27 Apr 2024 00:21:03 +0200
Date: Sat, 27 Apr 2024 00:21:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: wwan: Add net device name for error message
 print
Message-ID: <6f7c4b67-a6bd-4fc2-a7da-e4bb0c2b6f50@lunn.ch>
References: <20240426080733.819633-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426080733.819633-1-slark_xiao@163.com>

>  	if (skb->len < sizeof(struct usb_cdc_ncm_nth16) +
>  			sizeof(struct usb_cdc_ncm_ndp16)) {
> -		net_err_ratelimited("frame too short\n");
> +		net_err_ratelimited("mbim: frame too short\n");

I don't know this code at all, but i think you can do

dev_err_ratelimited(&mbim->mdev->dev, "frame too short\n");

That way, it tells you which of the 42 mhi devices has received too
short a frame.

      Andrew

