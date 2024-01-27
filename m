Return-Path: <linux-kernel+bounces-41382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14E183EFD8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0174A1C228DB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE31864A;
	Sat, 27 Jan 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Ynmg5jif";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFZf5DrC"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98B414AB0;
	Sat, 27 Jan 2024 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706385064; cv=none; b=i88kxMEn16FfL9BMw8OKBUTM8BZXoWLJYn/CYxZEp+DvDedXFP5e1RL1P8QDUlLMlmby4lVicMgXeACHr9m7Ltj8Dgtx/h5wSlsvtLlV96XD+gHd4VFRdmU+MdEct0vd4cWfuhKEaMGHH4OCYarZpCVBnlFMMq8/gy9EU4zopzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706385064; c=relaxed/simple;
	bh=wrKLrNOoOGi1Scl6PQrNxqhLPOyWttVYNowKaTpIVJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrxG6/yOohL/ihurC6958eAmB6K5MRPyyyZuq1PZKJgZSp3UQH8TAiC46COiqSGdFgPgQ6yBuQhzQPkgXKOTavd1Kf8d2ZoK7bmihFmkdb/pmkSpHVlBDPX+6l6bShlTGn+vxBzpzRUQ3OfiucKwv0/WAqrrAB0rUOShTAV4DK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Ynmg5jif; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFZf5DrC; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 9ABA45C00B9;
	Sat, 27 Jan 2024 14:51:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 27 Jan 2024 14:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706385060;
	 x=1706471460; bh=ZSWlcrKfahlCoAOYqiTq12Gh5vrCNnHbyzpOV80pl2E=; b=
	Ynmg5jifNzoYkXlKSZe9FVYS4z8xCnWGyUMxseXvEIQ12wylvdUiZewN0Ug/tVJa
	A7eY1/ypYU0SYKcSuT5kVM5pSqF1JSXQ/QYB2AqrS7d3weDtlDN63GKpK0t8JSR2
	1rw/UITThr6VV9A4xs+4dbF+gSY0y6TOWf3lprC7VO79+pQuXWQ3q5eWsNC5RHlU
	wR9vJ80UGnkFPBSbgBWsh4V7kRkrl9LpubSIVcMew+Nmrxul1gqxrKYjFbemygeh
	9/xIi9RfDUV1xJaFproMeqg9Qnm5yh/gdNXAKZnPi1Pi++HUAK80hdTZu+1m1D0m
	AOUVKsEIsJ2e6Ee//byLtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706385060; x=
	1706471460; bh=ZSWlcrKfahlCoAOYqiTq12Gh5vrCNnHbyzpOV80pl2E=; b=Q
	FZf5DrCulON30Hxz+AnI/LNo3x2kjIO7jTyePrdr8Ie0+iURiqBMLYmo0bKXl9wC
	drGghd0vIVrFIDmRrKx5bT0HNLPqKcGUt9AojvJSwSo1cJLppb/tvFzZtZpX0++v
	RIRBYSSmv6qFDn9Y6xRudTvM9ZupBFE1FrPMzDR+YArP6Z3zhgG0I13FOharv3sV
	1G/u3211S0GK0htGZzYqzVGCBu16MS8uw1xb2Pu86/pn/IV/0BUVN4Q1UnSjOj17
	mOZeBQGP4culZ0UzcPsHGcA5WFnBsrNY9FT3jLsJI5sLkhAL3kwwVc8fwkxY/W0l
	kDJAMZqTMPhrk4VBozbOw==
X-ME-Sender: <xms:pF61ZXuto2mHOWAYm4HbHdib5LdHcAZY3WGspbxyToNHO4BdWZJoFw>
    <xme:pF61ZYd75-eep0lPE0UvFQMMu-NrwqJdof4PYSsXTaPNTk7wp3YC1kSUUnIrYZiP5
    TyzeGb6Nm8KPzIvrpw>
X-ME-Received: <xmr:pF61Zaw6X6C8o9NGQNVQRYT37P8bATmfCe-vA2shjIK9fEz7-4StyDAtAPUbjOchIZ4FQVUHxYlK1KB5UDzBA02LdaA0WZr30JhfRHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelledguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeelueffheehgeeluedvlefghfeukeejteeuveeuhffftdfg
    uefhgefgueekffeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:pF61ZWPvtVqcwXdSG-Anb95CpZNt9qQ0m-CvnUlt6EIizI6-vtnJoA>
    <xmx:pF61ZX-jEdqZEcjF5Z9WScizyw1S1nbHpvlEC_j69t1L50QIDRP6sQ>
    <xmx:pF61ZWVTYQ6DuaQZ5DZDei4EKM3lMlz2YmYCCaIy5GwlVIMV4l-nxw>
    <xmx:pF61ZabgmPs9Ibt2vh3muRYqZOVGYYuwieHaeZHcs6fHLNmuPrcIpg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jan 2024 14:50:59 -0500 (EST)
Message-ID: <b365fa0a-845c-4698-bf37-9b8a15fd9f98@flygoat.com>
Date: Sat, 27 Jan 2024 19:50:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MIPS: move unselectable entries out of the "CPU type"
 choice
To: Masahiro Yamada <masahiroy@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240127162309.1026549-1-masahiroy@kernel.org>
 <20240127162309.1026549-2-masahiroy@kernel.org>
Content-Language: en-US
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com;
 keydata= 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
 HVO98ZmbMeg=
In-Reply-To: <20240127162309.1026549-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/1/27 16:23, Masahiro Yamada 写道:
> Move the following entries out of the "CPU type" choice:
>
>   - LOONGSON3_ENHANCEMENT
>   - CPU_LOONGSON3_WORKAROUNDS
>   - CPU_LOONGSON3_CPUCFG_EMULATION
>
> These entries cannot be selected from the choice because they depend on
> CPU_LOONGSON64, which is also located in the same choice.
>
> In fact, Kconfig does not consider them as choice values because they
> become children of CPU_LOOONGSON64 due to the automatic submenu creation
> in menu_finalize().
>
> However, it is hard to understand this behavior unless you are familiar
> with the Kconfig internals.
>
> "choice" should contain only selectable entries.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks!
> ---
>
>   arch/mips/Kconfig | 76 +++++++++++++++++++++++------------------------
>   1 file changed, 38 insertions(+), 38 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 797ae590ebdb..a70b4f959fb1 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1269,44 +1269,6 @@ config CPU_LOONGSON64
>   	  3B1000, 3B1500, 3A2000, 3A3000 and 3A4000) processors. However, old
>   	  Loongson-2E/2F is not covered here and will be removed in future.
>   
> -config LOONGSON3_ENHANCEMENT
> -	bool "New Loongson-3 CPU Enhancements"
> -	default n
> -	depends on CPU_LOONGSON64
> -	help
> -	  New Loongson-3 cores (since Loongson-3A R2, as opposed to Loongson-3A
> -	  R1, Loongson-3B R1 and Loongson-3B R2) has many enhancements, such as
> -	  FTLB, L1-VCache, EI/DI/Wait/Prefetch instruction, DSP/DSPr2 ASE, User
> -	  Local register, Read-Inhibit/Execute-Inhibit, SFB (Store Fill Buffer),
> -	  Fast TLB refill support, etc.
> -
> -	  This option enable those enhancements which are not probed at run
> -	  time. If you want a generic kernel to run on all Loongson 3 machines,
> -	  please say 'N' here. If you want a high-performance kernel to run on
> -	  new Loongson-3 machines only, please say 'Y' here.
> -
> -config CPU_LOONGSON3_WORKAROUNDS
> -	bool "Loongson-3 LLSC Workarounds"
> -	default y if SMP
> -	depends on CPU_LOONGSON64
> -	help
> -	  Loongson-3 processors have the llsc issues which require workarounds.
> -	  Without workarounds the system may hang unexpectedly.
> -
> -	  Say Y, unless you know what you are doing.
> -
> -config CPU_LOONGSON3_CPUCFG_EMULATION
> -	bool "Emulate the CPUCFG instruction on older Loongson cores"
> -	default y
> -	depends on CPU_LOONGSON64
> -	help
> -	  Loongson-3A R4 and newer have the CPUCFG instruction available for
> -	  userland to query CPU capabilities, much like CPUID on x86. This
> -	  option provides emulation of the instruction on older Loongson
> -	  cores, back to Loongson-3A1000.
> -
> -	  If unsure, please say Y.
> -
>   config CPU_LOONGSON2E
>   	bool "Loongson 2E"
>   	depends on SYS_HAS_CPU_LOONGSON2E
> @@ -1644,6 +1606,44 @@ config CPU_BMIPS
>   
>   endchoice
>   
> +config LOONGSON3_ENHANCEMENT
> +	bool "New Loongson-3 CPU Enhancements"
> +	default n
> +	depends on CPU_LOONGSON64
> +	help
> +	  New Loongson-3 cores (since Loongson-3A R2, as opposed to Loongson-3A
> +	  R1, Loongson-3B R1 and Loongson-3B R2) has many enhancements, such as
> +	  FTLB, L1-VCache, EI/DI/Wait/Prefetch instruction, DSP/DSPr2 ASE, User
> +	  Local register, Read-Inhibit/Execute-Inhibit, SFB (Store Fill Buffer),
> +	  Fast TLB refill support, etc.
> +
> +	  This option enable those enhancements which are not probed at run
> +	  time. If you want a generic kernel to run on all Loongson 3 machines,
> +	  please say 'N' here. If you want a high-performance kernel to run on
> +	  new Loongson-3 machines only, please say 'Y' here.
> +
> +config CPU_LOONGSON3_WORKAROUNDS
> +	bool "Loongson-3 LLSC Workarounds"
> +	default y if SMP
> +	depends on CPU_LOONGSON64
> +	help
> +	  Loongson-3 processors have the llsc issues which require workarounds.
> +	  Without workarounds the system may hang unexpectedly.
> +
> +	  Say Y, unless you know what you are doing.
> +
> +config CPU_LOONGSON3_CPUCFG_EMULATION
> +	bool "Emulate the CPUCFG instruction on older Loongson cores"
> +	default y
> +	depends on CPU_LOONGSON64
> +	help
> +	  Loongson-3A R4 and newer have the CPUCFG instruction available for
> +	  userland to query CPU capabilities, much like CPUID on x86. This
> +	  option provides emulation of the instruction on older Loongson
> +	  cores, back to Loongson-3A1000.
> +
> +	  If unsure, please say Y.
> +
>   config CPU_MIPS32_3_5_FEATURES
>   	bool "MIPS32 Release 3.5 Features"
>   	depends on SYS_HAS_CPU_MIPS32_R3_5

-- 
---
Jiaxun Yang


