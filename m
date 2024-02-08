Return-Path: <linux-kernel+bounces-57761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C0584DD1D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DF41F21272
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FEE6BFB8;
	Thu,  8 Feb 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="qhH84FVz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pvB/VrnQ"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8FE6A03A;
	Thu,  8 Feb 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385087; cv=none; b=AVbnSpjY8xHl+c9kCv0VmMkJwPN4kLEHCqxO2tMX1LlgwVG9WupxmFBrABEKf7ykJzLHknyKXe3S+xEtDkvAJ21oLj4054/MSN0Ilr1kb4Pb9X1jBo1bVXPWicsMtKSoXhWrBSa3QTNQUEoM84ZLw6GMOJ1d6Dtkdc+FqkHOnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385087; c=relaxed/simple;
	bh=KenGFnO8V0sQCx2w3bRvDG2ZWIiPIufLamD4iu2CQCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ii3bpD2PktdNJs1DFAZrA/ENCHtbEbjZwa68MnaVAGiQkT8w8Fr1KMKe0NnRi2kkFQulJ8Ny/gwvES8eH3IaSYG0otT21YJL0d1S6//lZZ463KjyMRBe5cYPURXsDhJi3rbtzk0c3NVOfKiBNoeG5jEt/eZyrmg0BR++1yIthQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=qhH84FVz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pvB/VrnQ; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 2A7C45C014B;
	Thu,  8 Feb 2024 04:38:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 08 Feb 2024 04:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1707385085;
	 x=1707471485; bh=CtbWDd3+TzkoLPwwunkgdRlj99pZzuVSHHCYDHMn/68=; b=
	qhH84FVzUTJh9XebWTQFbO6NX77+WhPzit5IDV2+MRnsh81Q29yoE/Kl5AOjDkJe
	a3/PWVlkQYP8Vaxl5PEd+II19BneLoABpRELqEKGs5+F4iAESqAdrbehBsCIRCIu
	SESRvGww0SkTD8q19qS+nq7fpS/OMoLe4NCmtHN7Umvszz8Pcu/+zpR/rWhCXkuZ
	lpK9ChYv6PRlKsajiTvN5BPDYtqqQa/IKmMP6fEzj16gDBgsIfgcmLRBkiyYFfUY
	8a2R1HzIF+LgxKSfBLpNLvzr+eiTmNIE7uZjB9gzjsI3/ecHNeafnzkGZJRn/DPR
	pN3JtJQ03Dgc8zTs+1q1vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707385085; x=
	1707471485; bh=CtbWDd3+TzkoLPwwunkgdRlj99pZzuVSHHCYDHMn/68=; b=p
	vB/VrnQkypUQ39IhkDvl7Y2tRQjEJTG74bNIapjp5SMTajzYA7hed0Yi/k7q4MDD
	uA8XzzlH+AKju8RzSnivTtDH4y/XM8i5CTj89Tj71Bhcl+BaVELs01qGKJiwC0AW
	jQNLIVw4f2+4s61DQvaXLGgSW8KB5gInE8sHr3DHeAiMprACSQ8yNLZR56clgSxh
	dcbVIPkpcPu/80JdW1pN3MN/g4KIGXM4HMeoSlRGp65Bj3uBzhcCd+p70lwIN2TY
	JdxodqGsKx/7Y/hD/KJC2wHxcQF9tY62RAW5CFmw7C4C3FH6QNmBNkd/TATy3XNc
	tg7ZEZb/9EUxIwlMGNAVA==
X-ME-Sender: <xms:_KDEZZJ9ewiyLPl3BX0hk-M6P7u0TGRKIAcv6VHlU3aK_rd6UOUiXw>
    <xme:_KDEZVK_8zUiLFWDTwGDjR2A1ko7fIK5tfEKA8PAChjxhb5viU2R7HgFCPshGFnM9
    gg4vsy9E5_qO8K1X8E>
X-ME-Received: <xmr:_KDEZRt6pGl8ZxIl7DCY_NA395dnNllyqcScM4Mudti213CApfaQoLiCmqWdWKezOqLLa9GGM-Q_tWnIntDF0GC8jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeggddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeelueffheehgeeluedvlefghfeukeejteeuveeuhffftdfguefh
    gefgueekffeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:_KDEZaargwB1zfQlnERK6yHbjjOYhDYaG3TLFuOt_2UQqcwTWFNg4A>
    <xmx:_KDEZQb-kvGrjSTXUXwdUPJc4S-LV-5GPnNmFPEkt-GW2sdXU-h0JA>
    <xmx:_KDEZeAoPs5ASihJxCZb1Rb7DFfsjN_drgHi1WK9B_CJ9nhduf78_w>
    <xmx:_aDEZcQ-Mun3Z4TW8nrGLPs1bCHRdHwrhobB7ETFZ40Ho8YuzIWeCA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 04:38:03 -0500 (EST)
Message-ID: <ce16e86b-59d0-4aac-8e62-b0c89a852e26@flygoat.com>
Date: Thu, 8 Feb 2024 09:38:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/14] MIPS: Share generic kernel code with other
 architecture
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
References: <20240205153503.574468-1-gregory.clement@bootlin.com>
 <20240205153503.574468-13-gregory.clement@bootlin.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com;
 keydata= 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
 HVO98ZmbMeg=
In-Reply-To: <20240205153503.574468-13-gregory.clement@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/5 15:34, Gregory CLEMENT 写道:
> Some architectures might seek to utilize a significant portion of the
> generic kernel code while maintaining independence from the generic
> kernel due to specific peculiarities.
>
> This patch allows for the reuse of core code, preventing unnecessary
> duplication.
>
> Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks!
- Jiaxun
> ---
>   arch/mips/Kbuild           | 1 +
>   arch/mips/Kconfig          | 3 +++
>   arch/mips/generic/Makefile | 6 +++---
>   3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
> index af2967bffb73d..d683993ed331c 100644
> --- a/arch/mips/Kbuild
> +++ b/arch/mips/Kbuild
> @@ -17,6 +17,7 @@ obj- := $(platform-y)
>   # mips object files
>   # The object files are linked as core-y files would be linked
>   
> +obj-y += generic/
>   obj-y += kernel/
>   obj-y += mm/
>   obj-y += net/
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 797ae590ebdba..5549d26448941 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -109,6 +109,9 @@ config MIPS_FIXUP_BIGPHYS_ADDR
>   config MIPS_GENERIC
>   	bool
>   
> +config MACH_GENERIC_CORE
> +	bool
> +
>   config MACH_INGENIC
>   	bool
>   	select SYS_SUPPORTS_32BIT_KERNEL
> diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
> index e37a59bae0a62..56011d738441f 100644
> --- a/arch/mips/generic/Makefile
> +++ b/arch/mips/generic/Makefile
> @@ -4,9 +4,9 @@
>   # Author: Paul Burton <paul.burton@mips.com>
>   #
>   
> -obj-y += init.o
> -obj-y += irq.o
> -obj-y += proc.o
> +obj-$(CONFIG_MACH_GENERIC_CORE) += init.o
> +obj-$(CONFIG_MACH_GENERIC_CORE) += irq.o
> +obj-$(CONFIG_MACH_GENERIC_CORE) += proc.o
>   
>   obj-$(CONFIG_YAMON_DT_SHIM)		+= yamon-dt.o
>   obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o

-- 
---
Jiaxun Yang


