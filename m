Return-Path: <linux-kernel+bounces-73504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD7485C394
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027EB28527D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F6078660;
	Tue, 20 Feb 2024 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="LEJqjYNq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KDGogIFL"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D0177655;
	Tue, 20 Feb 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453572; cv=none; b=t3dIUlwNgQa5WnsKhxskFho5JSZl0c0gwfPpYEsr/wWmTSXKcSyz7QJtuyuoWanVQ8OgZkUwv/VpmwI6y7/79OWYvjJYqQahiiciltCitvDXRO+MoAnNJ4JKDW2LS7cLn1u8QLfdkzJnP4ze/lwFIQ8Wt5J1GwDc3CSZYNysFoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453572; c=relaxed/simple;
	bh=Yu6Ek05D3XzEDulx15fqOxq47ljcIO0qY4zVYkB+TuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hh2PTAx3lyeYTwzayoEYoV0bffF1OxADQFyQFv+ktYq5j57kNnty8jZiAFage79Oflzw+n+WyDC9RUIumdkxXANEpQ4OP3Lijho3tB9blzhgetp0f5BHAH3Cmhr+NLowKQ7tb5/VJCeFLDWot7wCDsDsYIqbhP5M/ZlE/PLnlDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=LEJqjYNq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KDGogIFL; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D72D811400A2;
	Tue, 20 Feb 2024 13:26:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 20 Feb 2024 13:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1708453567;
	 x=1708539967; bh=NPcyX8ulrhJ0Mc5gTBoXB3xhQTF03OhSShONl72kdLc=; b=
	LEJqjYNqNDTSM6cSSwwJMevo8m2reOKPCryJEKhgqG47I5U1w17kaU9RZaw1bMB9
	q3EYciGDg7QgkzEG09gRKj5AlbatK8QrXpSlvgl2rYNxxYJHYC0Df05x0a6vDJDb
	kO2MXzAwmwvutcAKfvzyY7mre8uop8VrnRTAAgYZ6GpSrkgJPwVta3x6/p9CYkz6
	W2B78ORNvRQffbETToNoODJg4fLYIAgtcCURgsAu7xiypubMa4nPRN5QA8C6K8H6
	4zahwuqy4Z66jHOXHQZPAJn8a1fOjjumieeor8O9EZi4mdsyppiv5yzA8RlP7XBT
	Hdyha7OtFq45Aqdgvscsxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708453567; x=
	1708539967; bh=NPcyX8ulrhJ0Mc5gTBoXB3xhQTF03OhSShONl72kdLc=; b=K
	DGogIFLfPkqkIlar005cdaMKUMM/IhWvjQpsA+WD3DGBk27Oihj0xWUqvmR3yGqK
	WCpF3A/kYj6P8huvzj+km8KljYfyvwWku9IfkYD6AZ+Y1NvojGurtpN6lYPO0B/+
	SbCC9YjC6gdYwadXGWtb7/pLbGvZsVxrcK+lmdK9xxkCL58QghnDQg2frCjvcfoT
	umsVxuBBKSKjHxwS5noVvmwUXlEDi8TxN4m/P7SrdeMzbf7nmH2sR1MYt5X1T+xM
	Qh05Ul8S+WhiPKz2WN/qV+aS8ixlx/YDXuXnwS0Uisn4U3YQ2R3mNQyfjjF97int
	tfuQ2XhXR9v7qCU7ieISA==
X-ME-Sender: <xms:v-7UZYKWrba4NqRKD0JQsUASdIM3wh__fXvFFfc8fdv2xHsufknlaQ>
    <xme:v-7UZYL974AsrkO3MAdgbj-NP52Sw1IxiiGxsaZtwhy2mn5ONvG7wVEy6ygae3LGl
    DyYkYfDD7KY9lsBL-Q>
X-ME-Received: <xmr:v-7UZYsUKutwD3PNTyzVR0Wu5RP0KYQIPVhkWWse_z8zA04GTins3TqLVlBsr9oqvsRQeMkVPV_6p-4yAycw3oYLvuXhdseIyqPu8l4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleeuffehheegleeuvdelgffhueekjeetueevuefhffdtgfeu
    hfeggfeukefffedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:v-7UZVYNZ66XnHkHJv3oIs-ihoRSllAHUd-3zmBbSeN8ZFkOPfgmcA>
    <xmx:v-7UZfa1Z_PUi9IrHvxiIy86Nhf4CF8-_FyQ9DCldUr6kd5iz4TOCA>
    <xmx:v-7UZRAaUmT5_fWCBJyyuTu6WufDYaKAPf_nTDX7OmtikFBVPbYmpQ>
    <xmx:v-7UZZkvUn4q6Ga5bnydde5B4wfleNj59gwUoVO2IQTIs3FbbnAr8g>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 13:26:05 -0500 (EST)
Message-ID: <8b46e25b-fd3c-4fbc-9f41-c8ac7f4d89e6@flygoat.com>
Date: Tue, 20 Feb 2024 18:26:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] MIPS: Aggregate build fixes
Content-Language: en-US
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>
References: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com;
 keydata= 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
 HVO98ZmbMeg=
In-Reply-To: <20240202-llvm-msym32-v1-0-52f0631057d6@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/2 18:21, Jiaxun Yang 写道:
> Hi all,
>
> This series is a collection of build fixes that have been lying
> at my local trees for a while, some of them are for Clang built
> linux and others are for some wiredo configurations.

A gentle ping on this series :-)

Thanks
- Jiaxun

>
> Please review.
>
> Thanks
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (8):
>        MIPS: Probe toolchain support of -msym32
>        MIPS: Remove cc-option checks for -march=octeon
>        MIPS: Fallback CPU -march flag to ISA level if unsupported
>        MIPS: BMIPS: Drop unnecessary assembler flag
>        MIPS: Loongson64: test for -march=loongson3a cflag
>        MIPS: Limit MIPS_MT_SMP support by ISA reversion
>        MIPS: Implement microMIPS MT ASE helpers
>        MIPS: mipsregs: Set proper ISA level for virt extensions
>
>   arch/mips/Kconfig                  |   3 +-
>   arch/mips/Makefile                 |  46 ++++---
>   arch/mips/include/asm/asmmacro.h   |  22 ++--
>   arch/mips/include/asm/mipsmtregs.h | 256 ++++++++++++++++++++++---------------
>   arch/mips/include/asm/mipsregs.h   |  22 +++-
>   arch/mips/kernel/vpe-mt.c          |   4 +-
>   6 files changed, 211 insertions(+), 142 deletions(-)
> ---
> base-commit: 076d56d74f17e625b3d63cf4743b3d7d02180379
> change-id: 20240202-llvm-msym32-6392d410f650
>
> Best regards,

-- 
---
Jiaxun Yang


