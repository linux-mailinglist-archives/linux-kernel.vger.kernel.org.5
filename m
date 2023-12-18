Return-Path: <linux-kernel+bounces-3830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5E4817379
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBFA2B22F81
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF53134DF;
	Mon, 18 Dec 2023 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iig9a0gC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f/cVLNJL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C21D148
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id DF4B05C01A1;
	Mon, 18 Dec 2023 09:22:05 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 18 Dec 2023 09:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702909325; x=1702995725; bh=80hApuyvNl
	9yOSjCP0iH0vkOW+LFkGuu0dMrxsMPNow=; b=iig9a0gClrFChL0nRRAviiTnmI
	CeLHUUI0H4vi1IELQnIoUyi4N0vdRHF/l3ZxaklJ6AnOgfDB1YLL3TGPCA7miGoc
	5ZkT45OZZFu/Oc0qYZC23OWs2IEsRTpC8MZk/9AyutL/a9WfUX/LmXUqJIH29nsI
	Ujd+Wh507GB721pvowdDXYyJycShUomqG4xE5ZsLV8gSbswGnETuh8ixhGlF1otl
	x8V2HDdOX+UAOWq5+NOBDwlivj8fwVYAlkRjfk1maiLVjXE5B0ZDy2RGnLyDWs/Q
	mVkC06q1Q9B7Ow/Se9UmI2duCkJDq7C8tkVaewchfRQZmkOC6D8mj9WdQ5PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702909325; x=1702995725; bh=80hApuyvNl9yOSjCP0iH0vkOW+LF
	kGuu0dMrxsMPNow=; b=f/cVLNJLF7FcJ4S9MyeCKTZD33teYy/FXeG9KlimNhvU
	U/hR0CpKUcdZSvhLq5/Nwb1vTAJgiLG3oMPX7KrRhM0UKrxaEM2cfeuGSBMP/bvP
	fbqhr2tnpdMX7Bv8c1BFIIJcnMUZHd3nPlMZ+tpOmeMvmTAzazy7Zwd3hX23OlbW
	KYd6oxVruKDjfHHA1ZDi/eKgkSyzAFHUDvt0VKpiTp4tTlI+UTT33pgC2AXc4Ww4
	CLbnVMp38FXg+vsMHEkKfYgd8C9ON1fd1HllgtW1PJFHaDysTiZvbxFIJ/m/Wt5U
	ZAbb5B2/Z3KjgArvvCdyAhpZUcEeEpsV/wceW+f0VA==
X-ME-Sender: <xms:jFWAZY53EFfWxV-LS-L9k4Vdl2XBCEk9HOW7Kkc-4SMwP_2WKW4CpA>
    <xme:jFWAZZ6XSoArW47ua4xnH5TxTHBntYzF_DcHhrNstyTrzsb8T_pGj3_fXNbx6Gwi4
    p4n-oLzzYusjiyKaWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeeigfehhfffveejiedvgeduudetfedvgeeuuefhffevlefgteelveefudei
    heffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpohhpvghnfihrthdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:jFWAZXfaAmWJP-LVWgy5GQpEqluM9zxfYvvenauLA5zB90rHjMq1MA>
    <xmx:jFWAZdJaFW_g-LvVeivAAn6MGhssXhexnikp92vxe1ctDel-Apqmng>
    <xmx:jFWAZcIbjI0ru85uMrmGMCc0mZQxMUK4LmAeyJKurKEtZE1WxDQofw>
    <xmx:jVWAZRXUXmOKE9o4G4KrBqggd1Inx84cAbnBerlz7ru7bzevYUDwAA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BF086B6008F; Mon, 18 Dec 2023 09:22:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <24e92cfc-8dc8-47b8-b379-ed8b1b776fba@app.fastmail.com>
In-Reply-To: <20231218134532.50599-1-krzysztof.kozlowski@linaro.org>
References: <20231218134532.50599-1-krzysztof.kozlowski@linaro.org>
Date: Mon, 18 Dec 2023 14:21:41 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 arm <arm@kernel.org>, soc@kernel.org, "Olof Johansson" <olof@lixom.net>
Cc: "Lennert Buytenhek" <kernel@wantstofly.org>,
 "Steve Sakoman" <sakoman@gmail.com>,
 "Mark F . Brown" <mark.brown314@gmail.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Florian Fainelli" <florian@openwrt.org>,
 "Simtec Linux Team" <linux@simtec.co.uk>
Subject: Re: [PATCH] ARM: MAINTAINERS: drop empty entries for removed boards
Content-Type: text/plain

On Mon, Dec 18, 2023, at 13:45, Krzysztof Kozlowski wrote:
> Drop empty and redundant maintainer entries for boards which were
> removed to fix `scripts/get_maintainer.pl --self-test=sections` errors
> like:
>
>   ./MAINTAINERS:2021: warning: section without file pattern	ARM/CIRRUS 
> LOGIC EDB9315A MACHINE SUPPORT

Good catch, I wonder if I missed these in last year's board removal
or if they were already broken back then. Some of these 

> @@ -2171,11 +2166,6 @@ T:	git 
> git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
>  F:	arch/arm/boot/dts/nxp/vf/
>  F:	arch/arm/mach-imx/*vf610*
> 
> -ARM/GUMSTIX MACHINE SUPPORT
> -M:	Steve Sakoman <sakoman@gmail.com>
> -L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:	Maintained

I don't know if Steve still cares, but the board is still there
in arch/arm/mach-pxa/{gumstix,am200epd.c,am300epd.c}
 
> -ARM/INTEL XSC3 (MANZANO) ARM CORE
> -M:	Lennert Buytenhek <kernel@wantstofly.org>
> -L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:	Maintained

Same here, the code is still there and used by pxa3xx:

arch/arm/mm/*xsc3l2*

>  ARM/LG1K ARCHITECTURE
>  M:	Chanho Min <chanho.min@lge.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> @@ -2840,11 +2825,6 @@ F:	arch/arm/boot/dts/synaptics/
>  F:	arch/arm/mach-berlin/
>  F:	arch/arm64/boot/dts/synaptics/
> 
> -ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
> -M:	Lennert Buytenhek <kernel@wantstofly.org>
> -L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:	Maintained

arch/arm/mach-ep93xx/ts72xx.c is about to be obsoleted by the ongoing
DT conversion.


> @@ -17674,14 +17649,6 @@ L:	linux-gpio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/gpio/gpio-pxa.c
> 
> -PXA MMCI DRIVER
> -S:	Orphan
> -
> -PXA RTC DRIVER
> -M:	Robert Jarzmik <robert.jarzmik@free.fr>
> -L:	linux-rtc@vger.kernel.org
> -S:	Maintained
> -

drivers/mmc/host/pxamci.c and drivers/rtc/rtc-pxa.c
are still in use.

> 
> -RDC R-321X SoC
> -M:	Florian Fainelli <florian@openwrt.org>
> -S:	Maintained
> -

This is still supported and it's x86 rather than arm.

There is a good chance that we /should/ remove it for being obsolete,
but that has to be a separate series and remove the drivers and
architecture support if we decide to go that way.

I'm fairly sure this platform was originally added for use with
OpenWRT but not everything was merged and OpenWRT stopped
carrying the required patches in 2016:

https://git.openwrt.org/?p=openwrt/openwrt.git;a=commitdiff;h=fed29fa36bf9ff387ff6e96522b1b5423fed3581

Some of the drivers might still be in use on the related
vortex86 cores, so maybe we keep the support and add

N:     rdc321x

      Arnd

