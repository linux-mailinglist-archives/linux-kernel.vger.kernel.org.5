Return-Path: <linux-kernel+bounces-161050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEFE8B466D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7234E2829AC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104DF4F1E0;
	Sat, 27 Apr 2024 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rUV84ovs"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A82032A;
	Sat, 27 Apr 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714224164; cv=none; b=VLoA7mMe/q9zpQofw8RG3Q5Pf9MwiHxXs6jLnnEfBfAwPIPVwJuvGMBjDJOw/WuERvb75FgqAOen99OM+KBHT6YR1acY12iSOEMr4QPrfuIltTRWpUDlOtyCX+uiShzlOn6IBom8kKdNtriwBAeuCZJBohrCE9axhODounHWp2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714224164; c=relaxed/simple;
	bh=0RgdNbqY5OmtO6lnbA+EATz/8l3MncfCfEd7jcYF6jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U521cGuftJ8AzWeds3xWdVs3TbmlVqZwEN7MO8NDksgl2ziMbEXkvPI1py+KA33cmuJSGYyh9TG53OdPG82gHxdj+kxo8xlosNJTeb3flW8bHv5NFRw7/JZZGSM7esIPiOo/zLuW5qyEGTLJLP5cuSq826660W3W5N1+zgN9Fsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rUV84ovs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UN8sjUbj9W0OtZnCnQkLCROZCAo3ON6bY0D+KpYWEOQ=; b=rUV84ovse88jrzaIQysRpRhFe3
	9nALNf8MgFWtijYpR8srHa69VDEe9uNb4LpXA+yAGAxaB0hDNc+xWnDWA3wBOmlkHb09a4BudDnae
	LAqad1cvfNk3yHQpZVs0geXP2buKlVekilAeA9cLBm8/T93vCiFi8v9cs2aitQr/CfrU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s0i0X-00E8ye-Ae; Sat, 27 Apr 2024 15:22:25 +0200
Date: Sat, 27 Apr 2024 15:22:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH net] net: wwan: Add net device name for error message
 print
Message-ID: <56b839fb-6a69-4dff-b412-1960e98fcbf2@lunn.ch>
References: <20240426080733.819633-1-slark_xiao@163.com>
 <6f7c4b67-a6bd-4fc2-a7da-e4bb0c2b6f50@lunn.ch>
 <c5a7151.250c.18f1e4425f4.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a7151.250c.18f1e4425f4.Coremail.slark_xiao@163.com>

> At 2024-04-27 06:21:03, "Andrew Lunn" <andrew@lunn.ch> wrote:
> >>  	if (skb->len < sizeof(struct usb_cdc_ncm_nth16) +
> >>  			sizeof(struct usb_cdc_ncm_ndp16)) {
> >> -		net_err_ratelimited("frame too short\n");
> >> +		net_err_ratelimited("mbim: frame too short\n");
> >
> >I don't know this code at all, but i think you can do
> >
> >dev_err_ratelimited(&mbim->mdev->dev, "frame too short\n");
> >
> >That way, it tells you which of the 42 mhi devices has received too
> >short a frame.
> >
> >      Andrew
> I tried in my case, and it will print:
> mhi_wwan_mbim mhio_IP_HW0_MBIM: frame too short
> 
> I think it's much more complicated, isn't it?

As i said, this is about making it clear which device has problems.
mhio_IP_HW0_MBI is not a particularly good name, but it should be
unique. The question is, is this built into the silicon, and can there
only be one? The name is them pointless.

It is also not too unusual to see drivers define macros

mbim_err_ratelimited(mbin, "frame too short")

	Andrew


