Return-Path: <linux-kernel+bounces-95860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060DA875432
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A104B22CB4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8AC12F5B3;
	Thu,  7 Mar 2024 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dZ+7Sd3G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KXkoNNq4"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C066347A2;
	Thu,  7 Mar 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829165; cv=none; b=KCFSRAao0/tQGBwMFRhfu3JYtpmY97SFNPF/wCoagWOlRwhDNhlFGPYe0Mcv2r1o5dh1Bc5f9ZeFGFgksEWg0u1VROG5MK1SSk7xxVxHS/a9cqq2wD2DBNyRLaAJDEGIFGRf31BAtXyE/aOzA1NGLtOf4O6fLwmVEoe1UIDZi5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829165; c=relaxed/simple;
	bh=iElcAMRHWg3AIENdNnS8XqLOBLe79zitIgveRh8WpWY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=MP1/emsnrknZ6lH3mUGXvvysI4TwNqyVOLJVBATL2+Q87a85wW7k7dv3OFlAlFKjCnmvltUC+REDPhidn1j+iNIq6jQwLzp9ImQsVZficaGBF6s/euD4NHoiOLqCegOZuvKTnHA/E5900FBbGK1piC8SIvw4fpKpaRBnBGhPGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dZ+7Sd3G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KXkoNNq4; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id E462D1C0009A;
	Thu,  7 Mar 2024 11:32:41 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 11:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709829161; x=1709915561; bh=s69aR939oj
	uP89aqvaOQNMGjfx31Iz5HIu+XZvWaPE8=; b=dZ+7Sd3GH+r3i4XsbhfgnLMlNQ
	KlwummQ/Jv1W5SKwyB30yWWzklGHzT41WWiG7MP6jAZYqvl5QkSbD6vZccGY3hoP
	Ut/mUdzCQcbFcHkJZ8srivb2rZLypc87vpzFPf3Mg/QeDbfY7XRqPbvm1xvgzEZP
	k13O5Quz9EZAQKXWF/ZzTiupqnyS5wy5xPwMPSYtOKLcYCyieD44q1IKm2vy36Pp
	y3RUyKgOSz5Ry6EldgPjgG7UenETdmMYltzaR8n8BukzP1G2TvG6rx9yP19MYwYe
	q2oFwAoQj2rrxwC9AWqyXa3gMiMfgdh6uurX19qUNqvH2Ou1oxk83eXPeH1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709829161; x=1709915561; bh=s69aR939ojuP89aqvaOQNMGjfx31
	Iz5HIu+XZvWaPE8=; b=KXkoNNq4idoMiFT8pEyHJZ5I3q6dF6IMS/+exQuoDqNu
	N5cxAtelIWGM7UyPaeCPfyGifKY6eqMmggq2Fx4hKX6nJHMIQ4YebmPXLR1BDdU+
	Yj4sOQIDeaYrQ102PfKRyqVLwmJ6LpqFcVhsze88ZyAQuDwxE0lIwl6iKbV2wqtj
	wH+CQ5bQwdFXgsp1tmvBnyFQ+leJDZiGJ1uENO+nbl9lVras299fWV/mcA4kjJuU
	q3tI9yHawhzCRM+m5oLG9t3His6N5XQFdu8dlbNN9MUuiePPiYja5c4tCcODsEHM
	nTxdTIWW83Ro5o/P7FlHoLptP8Pm+3D7Frl7nP1h5w==
X-ME-Sender: <xms:KOzpZX02MBIn5ry0MasiApi4wW_emEnrIeI3Z0cPuJls3Q3lSfDukA>
    <xme:KOzpZWGdrfi_vCBEvKTvcSMvaZtRZHo7T9v2IeVLG5EeD8crBDtj0Ks4VrOMvVcFQ
    Sx9L9tMdCH3aZbEUQM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:KezpZX6AHQhWEHpnQEbSvY1WoT7YhPN-aRzPoMz4otV3vJhMlIAYVQ>
    <xmx:KezpZc1VDPMNUuRd5w7WQ3yP15WRpcZ9ExrAPW_bs3DO1gn1zI25ZQ>
    <xmx:KezpZaF6lqxbmv1spvU5ih3cCPNAiPNJKxb9wRbFdc72yw94-R4l6g>
    <xmx:KezpZYaERftISt1-s7qkBQgOmprFu43_9YTQjmA7S-Nmn-tpIZmRLkRE2Lc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D56ABB60092; Thu,  7 Mar 2024 11:32:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e2581ba-f7ce-43ad-8e32-c62601c8f5c9@app.fastmail.com>
In-Reply-To: <20240307160823.3800932-2-andriy.shevchenko@linux.intel.com>
References: <20240307160823.3800932-1-andriy.shevchenko@linux.intel.com>
 <20240307160823.3800932-2-andriy.shevchenko@linux.intel.com>
Date: Thu, 07 Mar 2024 17:30:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Cc: "Daniel Mack" <daniel@zonque.org>,
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Russell King" <linux@armlinux.org.uk>, "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH v1 1/2] spi: pxa2xx: Kill pxa2xx_set_spi_info()
Content-Type: text/plain

On Thu, Mar 7, 2024, at 17:07, Andy Shevchenko wrote:
> There is the only one user of the pxa2xx_set_spi_info(). Unexport it
> and inline to the actual user.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I have no idea why you care about this, but it's a nice cleanup,
so I'm happy to see this get merged through the spi tree if
that helps. Let me know if I should take it through the soc
tree instead.

> -/* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1 */

This comment might still be useful.

> @@ -592,7 +595,15 @@ static void __init spitz_spi_init(void)
> 
>  	gpiod_add_lookup_table(&spitz_ads7846_gpio_table);
>  	gpiod_add_lookup_table(&spitz_spi_gpio_table);
> -	pxa2xx_set_spi_info(2, &spitz_spi_info);
> +
> +	pd = platform_device_alloc("pxa2xx-spi", id);
> +	if (pd == NULL) {
> +		pr_err("pxa2xx-spi: failed to allocate device id %d\n", id);
> +	} else {
> +		pd->dev.platform_data = info;
> +		platform_device_add(pd);
> +	}
> +
>  	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));

I think the normal interface these days would be
platform_device_register_data(), which does it all in one step.

      Arnd

