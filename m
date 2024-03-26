Return-Path: <linux-kernel+bounces-118706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BB388BE3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF651F3323F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581D36BFAB;
	Tue, 26 Mar 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OuKLU3Qu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PpyYnb3L"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F436027D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446226; cv=none; b=JmTPJM4t/aj9fe2+RQrQOnJcGhJC79kvswbbVcbHsljYtc2po+Wgd7SlNYCoL7AxVspljBtxF25DAhFFw6VbdKzvvRLst2n7LPrMl5JP90qcboYha+I0/j/R/cn1B8brzQgACggxTBRyBMJUEGBvx5PjTSbQFifru5xbs0oUScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446226; c=relaxed/simple;
	bh=9QP1nsOz1d1JuzdQZZRMvSHxrlpB/bzI85CEhXi9mAk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=f0R1I9CYxbihoQMQxMh5eibxvHVD8/yWNaiqAP5tz+CUSq0ptddAG9nFLo/sRc8MyVURDkZeKiSbf+cZ2rlal0uNVWBxphN26vv1w9HhtRuXck6ymxBVqSdQ43ufXEQr472jkkLsEbxMtvv+no2s4nRH5uoR0jwHSfnXbMjNyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OuKLU3Qu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PpyYnb3L; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7747711400F5;
	Tue, 26 Mar 2024 05:43:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 05:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711446223; x=1711532623; bh=3LqOQeorRq
	VxwortoMJ5JQKfcQyoSTQmX4p96tNt/c8=; b=OuKLU3QuihiiwgBCbZEQK7A45K
	B3lVzNmYyadgFqMqA2Q4hC8brf2EqPlDL/DGSaK21DCyriVX+bjsYBrtROhZILKq
	2d95iG2GV5K1D4CJlgLYX7SWq0/RFP9UJKXBK3hALRAZ3f6Hub453qWFS6bFNhkV
	WoNyr4AdiRyUk5CG2OyTslRnZEHmvY5uUzyRhGWm5oKSkPaGISwfMAPPqNp1+plj
	FQfqP4+YQZrGquZsB0nrvWqaktHwY7gG4qOurqj53cl6csvSWPyZxyLKUds39Ok9
	onV6FEKuOzWsy2ynfY33q6/fyGmjyzVcP8J+oJrqGNT3oy6WHYbcP4RtYHZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711446223; x=1711532623; bh=3LqOQeorRqVxwortoMJ5JQKfcQyo
	STQmX4p96tNt/c8=; b=PpyYnb3LrY/7ZTDL4rfJTuXaxMWpw+VlRhYObKM6qF9/
	Ueux2FolnCugyuwE/t8TsHLSASnOzmzv2h6cc76sE6GMqRNPWFybek8nLU9iAbYE
	oAQUHRwJpvIzqCZ5NVkW+u//F5bn2PZeytmK+qPVe0eUeSfj1/d4kDda4aSp91jO
	SOFOppLTffK/PrnUfmuW7kvYHsXVftDnpC1s0ZhEWs+D2NYrPK22WmWQjmf68Upa
	EvX/b5X/BrGh8ryLD/rDY4GmJceCCVkvPVxwVXhd9a3FDyA/slViMgBGBREA9Yrx
	pefb5Aiqv/PJjZnA1tdCKBAJPeNeK3jWVEQzoH7cnA==
X-ME-Sender: <xms:zpgCZo6JxGzhphLUrwvlaiJUIt6cx6n_d4tKEA_qhdCelC0J7JiLxA>
    <xme:zpgCZp5BIh7cfvFmNZpKhMjHMi2xeE03GihrGzjw9CYi7wrPWga07ZW6EZaPI_BaZ
    Q6YVf3imjQUxTaQlUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:zpgCZnc8khQa_YThgTSrkoHei3u-A9mq-p7XU6TA4QCVRGQAkMwmfQ>
    <xmx:zpgCZtIULllRD9QKzOCBNTDkHdPy9ou3SdG6JfpiyPloPY1pwISX9A>
    <xmx:zpgCZsJNL-km_EcGp2AJqMLyqsj4l3b-SIyxVNTBAPXmr1eQ-1iNQA>
    <xmx:zpgCZuwDvzRJUFec_HltzNtrD04RFEOhOC5pojft76QBjYhJrlfUQQ>
    <xmx:z5gCZugwjlS8gsJszGD2lFD_Z40D7LRhh3QaQjxYqUHluhIgxBA37w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5E83DB6008D; Tue, 26 Mar 2024 05:43:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b7b0b2fa-b092-45dd-b93e-0d59e8d40442@app.fastmail.com>
In-Reply-To: <20240326-ep93xx-v9-32-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
 <20240326-ep93xx-v9-32-156e2ae5dfc8@maquefel.me>
Date: Tue, 26 Mar 2024 10:43:22 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nikita Shubin" <nikita.shubin@maquefel.me>,
 "Russell King" <linux@armlinux.org.uk>,
 "Hartley Sweeten" <hsweeten@visionengravers.com>,
 "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
 "Andrew Davis" <afd@ti.com>, "Nicolas Schier" <nicolas@fjasle.eu>,
 "Daniel Golle" <daniel@makrotopia.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Cc: "Bjorn Andersson" <andersson@kernel.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 32/38] ARM: ep93xx: DT for the Cirrus ep93xx SoC platforms
Content-Type: text/plain

On Tue, Mar 26, 2024, at 10:18, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>
> Add compulsory device tree support to the Cirrus ep93xx ARMv4 platform.
>
> - select PINCTRL_EP93xx
> - select COMMON_CLK_EP93XX, as clock driver moved out of platform code
> - select ARCH_HAS_RESET_CONTROLLER
>
> Select ARM_ATAG_DTB_COMPAT to update device tree with information
> about memory passed from bootloader.
>
> We have to leave all MACH options as they are used for board checking
> before decomp, to turn off watchdog and ethernet DMA.
>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  	select ARCH_SPARSEMEM_ENABLE
>  	select ARM_AMBA
>  	select ARM_VIC
> +	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
> +	select ARM_ATAG_DTB_COMPAT # we need this to update dt memory node

I would drop these two 'select' statements: while it is
a reasonable assumption that the boot loaders are never going
to be fixed, this is not something that's up to the kernel.

We have other platforms that are in the same situation, and they
just enable those options through the defconfig, as they are
user-visible.

> +	select COMMON_CLK_EP93XX
> +	select EP93XX_TIMER
>  	select CLKSRC_MMIO
>  	select CPU_ARM920T
>  	select GPIOLIB
> +	select PINCTRL
> +	select PINCTRL_EP93XX

If these options are user visible, I would prefer to leave
these up to the defconfig as well, but that's not as important
and something we do in other platforms as well. In general,
I'd prefer to keep 'select' statements to a minimum though.

> -obj-y			:= core.o clock.o timer-ep93xx.o
> -
> -obj-$(CONFIG_EP93XX_DMA)	+= dma.o
> -
> -obj-$(CONFIG_MACH_EDB93XX)	+= edb93xx.o
> -obj-$(CONFIG_MACH_TS72XX)	+= ts72xx.o
> -obj-$(CONFIG_MACH_VISION_EP9307)+= vision_ep9307.o

The Makefile changes should be grouped together with
whichever patch removes the individual files.

      Arnd

