Return-Path: <linux-kernel+bounces-30988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6524E83272C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8BE1F23BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724BA3C468;
	Fri, 19 Jan 2024 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="DKhszfyI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H3rALSDP"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9823C467;
	Fri, 19 Jan 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658364; cv=none; b=W4TcwB2de2MEVekZa9K6CLxL2mk2pWhgzEQTT3c0nkhNUSFluRaVT80bvt9N2TGkONqWV2OsS5KI9aLGMOq+76mHpax64OS4h3FzaTvI1UnOdscHjbmGafjO+s+jVO9ncthgneCP1u0c/CNICtE/3TafZI6z8yvTvPXVnFtLfQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658364; c=relaxed/simple;
	bh=OqluU7mDwHc9epkbxaNnqsb8DVstYRlLRstztPdHOZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUb1n8gGtVKrLdytJ94ApWvWc3Az2n6xYLYJg9JC+lCOaAR6J8obTYKH4Ev4m9k/uqEVpsnRse+50XWXTtVmksCeCkxnRfRfcJ912dqoYchPG97yhwc5FTrf3KbSbjonZ/zN70ywDuNRcufaKzT+cOU/4sKTuaZl8eNWg/msgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=DKhszfyI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H3rALSDP; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 5C8FB5C016A;
	Fri, 19 Jan 2024 04:59:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 19 Jan 2024 04:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1705658362;
	 x=1705744762; bh=iDZNgMSyVfB+3uX66ztDG+g8Lgb/fIB6/4hKx4kafVk=; b=
	DKhszfyIO1cEG8lYumUlem3C4TtR6xz5NgPqhSt62H1s+wdIalY8i3JG67Y7uq8F
	Uy3lB2o0X1Qk6n+Dius7m7cllPiW+0qCK3UxSwyUL/osnjCCyXmb45soBiv8DF0M
	v/gnA7GSWl9+QghduzLOUDdIXVmcHeN97zuurLgpCbbZMaV8qilfATXEL1gP97Ok
	Szp+KYWSo5HPbug2Z4/aQBou1QR4KGkXKlWkHCzQE7lOVJTYcPcM4li5cP5itIvT
	Q5+D/otA7JY+HUewPcL7cufmRi8kEsQo9GMoHWlZQ0CUgEWxITKz/ETAOBj88rzt
	isyUipcRyUBAZNLucjYhxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705658362; x=
	1705744762; bh=iDZNgMSyVfB+3uX66ztDG+g8Lgb/fIB6/4hKx4kafVk=; b=H
	3rALSDPEsh/TSjVx473PzDjYCQBrBYBaaH0nW8P23Ur1caHzfdddLle3v7TjaeAw
	W+ZN/Ds84R/PX3GMw6ziI1LXQ8DeRcykVeJUHUc9LHwc1O2nfFmdSM7VVlk8OkBT
	HSiA24+tao90hidUCF48x4tDLim96GL9udLesvIf9wWACpksM0mlSYRinwDgtTnv
	4KvPGDC3ZUgwAlCOF44M/jpeXGbiEGIgFEt78UA92qjrrkqDHjY7R08WCM0kiodC
	LBuDDfxoaw46ImcQayRHZTZxUZZqFTZAAp84eLakQQOXNy5je40ofk4shk0/amJZ
	YC4U1XEh/rLtKQHCDc/vA==
X-ME-Sender: <xms:-UeqZanYe8DjV_oeW3qIgn4fAmgUZGYq4d-0K0QyWE8__14qjUBXZQ>
    <xme:-UeqZR0yJcvzuVpbgc-1f4F-JFwGzUfK3tB4lKaFaOA5d-7_iC5NJGeS587A8hW1Y
    ldE3bXUU36TLzgsGkc>
X-ME-Received: <xmr:-UeqZYq8-DmuSM-JnA7ogy6ntU0o0Nskrb2gLd3L3Pi2thqRtp2Vphzb_xOUA16U9wl63zRpvnM6-6FxjhHHz1TDznaq25w_CIs0wo4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleeuffehheegleeuvdelgffhueekjeetueevuefhffdtgfeu
    hfeggfeukefffedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:-UeqZemuZ-g4AoRwi5zlRzJOgK3oR4DhILBXUdb39r3UhD9ti4U-Xg>
    <xmx:-UeqZY2TWqTSblYKwqRLa5A1WPy-VbYTuG9kQCs9h-JLiwEj9hlrPw>
    <xmx:-UeqZVsdBChdf6khZZj4a_rW0IoEbcowrcnvGCLZebvF842zjqyrDA>
    <xmx:-keqZds8GN30sWeAiZ31OMUxDnm58m0izeHnK75AoXKTi-cN9Up0Ew>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 04:59:20 -0500 (EST)
Message-ID: <76c4a1ac-88f0-4f02-aee9-d07b027ea097@flygoat.com>
Date: Fri, 19 Jan 2024 09:59:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/15] MIPS: mobileye: Add EPM5 device tree
Content-Language: en-US
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
 Paul Burton <paulburton@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240118155252.397947-1-gregory.clement@bootlin.com>
 <20240118155252.397947-13-gregory.clement@bootlin.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com;
 keydata= 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
 HVO98ZmbMeg=
In-Reply-To: <20240118155252.397947-13-gregory.clement@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/1/18 15:52, Gregory CLEMENT 写道:
> Add a device tree for the Mobileye EPM5 evaluation board.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/mips/boot/dts/mobileye/Makefile       |  4 ++++
>   arch/mips/boot/dts/mobileye/eyeq5-epm5.dts | 24 ++++++++++++++++++++++
>   2 files changed, 28 insertions(+)
>   create mode 100644 arch/mips/boot/dts/mobileye/Makefile
>   create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
>
> diff --git a/arch/mips/boot/dts/mobileye/Makefile b/arch/mips/boot/dts/mobileye/Makefile
> new file mode 100644
> index 0000000000000..01c01c3aad81d
> --- /dev/null
> +++ b/arch/mips/boot/dts/mobileye/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright 2023 Mobileye Vision Technologies Ltd.
> +
> +dtb-$(CONFIG_MACH_EYEQ5)		+= eyeq5-epm5.dtb
> diff --git a/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
> new file mode 100644
> index 0000000000000..ff16c3c760a19
> --- /dev/null
> +++ b/arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright 2023 Mobileye Vision Technologies Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "eyeq5.dtsi"
> +
> +/ {
> +	compatible = "mobileye,eyeq5-epm5", "mobileye,eyeq5";
> +	model = "Mobile EyeQ5 MP5 Evaluation board";
> +
> +	chosen {
> +		bootargs = "earlycon";
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x08000000 0x0 0x08000000>,
> +		      <0x8 0x00000000 0x0 0x78000000>;
> +	};
> +};

-- 
---
Jiaxun Yang


