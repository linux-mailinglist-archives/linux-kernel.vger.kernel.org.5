Return-Path: <linux-kernel+bounces-9128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E96281C0F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14A71C22568
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2D77F32;
	Thu, 21 Dec 2023 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="rwOmRmKv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bFmVs5qV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D1577F10;
	Thu, 21 Dec 2023 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E38625C012A;
	Thu, 21 Dec 2023 17:25:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Dec 2023 17:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1703197508;
	 x=1703283908; bh=eH8YlOHbyQF9nz7myzuZh9BOJuRmKavlURr+Ne9G3Js=; b=
	rwOmRmKvfbDKKnZKykFLnnXxny/Pt9hSZ0mjRJNW8nGu7G9kVvB1GwD6qT7c5qdT
	fkpz2pxofb05LgQd1nSj4CTr5tz7FkErqJdKFbxIXbyFXhOW0PW/IKP2kmVgQulP
	m3wpPyOm/8Tj58azIC7dICkj/qUp+9c2XDWxGmAw5tyTMimdFeCkpD1WAzXKx5pc
	Bjt7E5zIWEqjNe4yQe7U2MBOY7a8lIe/RbSxY1K2olmql/Vp21FBmEmXcZ+gNiNZ
	5MTA7FrjvVbLMnuEpayNZxgF9sFDyL3jhTkqFmJD7LY9tew6wvCGF1ozGrQPQrIy
	pmaMsMOcMpWfgrGwL1C97Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703197508; x=
	1703283908; bh=eH8YlOHbyQF9nz7myzuZh9BOJuRmKavlURr+Ne9G3Js=; b=b
	FmVs5qVIdMVjg5r7l2zjyENguY0VWijM/7Mj25tb/Y2UQZYkFMAFL9cGishPVJ7E
	vWuqJsSCs/KsULp1IV7QSo2PdRaDyLU3yOCut5ueHFM96GOs5SRAEGX58Tbyzzwl
	/ybskaDf5kv8o6sN3J5FEZytg1yzxCHXi06OWjVfNJST4oAerwJZJslLz2NuQS2i
	0XVqsoi6btNeZkg4H+nPyQmHZGE4Cwmv0lLEfKK19mFOGbDBrIg0ulkITCRBVyCk
	PntZ5VSZmad2Ww4KbJW4nM+ov0wPHrrHga24DBiP/KL2nsN7WvPyIPpE1YqbFewV
	shQMXK/akkn4GMEdgy2Vw==
X-ME-Sender: <xms:RLuEZcPMRA8wlKfj3gYgh47VvopXsX-gL1eMUM693K_HFoXFCdwyjQ>
    <xme:RLuEZS99_HUGfkOjAFnTAnUCzZCHTs-QYnWlO5OFHZgMG9Zk8VcyrHqcJbRYzysgE
    mxW6KHJh2aLDb7u4zc>
X-ME-Received: <xmr:RLuEZTTfrTW3qrMZrKmwZXURBEcUmZpm_iysv-5YTJywv2wqzre-7bhX6Py2U4964CRv7XxWYaTVzsDbgyGwpKCyHyH3V3SVZOvCGSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeelueffheehgeeluedvlefghfeukeejteeuveeuhffftdfg
    uefhgefgueekffeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:RLuEZUstZDJ-HGB4M97Waz3w3cD18pKPPEZNW5QuBm1gHL4kKI-AAw>
    <xmx:RLuEZUdvwHyYn6uyqca-_WHPqfaD_D87lUHQVGJGZdAj75WDZXzT-Q>
    <xmx:RLuEZY3HQ6rf5gLnDlKm_UhaECW7cvjTSYlDXNj_p_zP5lk1LF8ygw>
    <xmx:RLuEZY3XPk1vTKNEEJfOB5m8Sas-a0-9_bm4AuGmAWzV_pPq7gx6hg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 17:25:06 -0500 (EST)
Message-ID: <ea28ac87-1043-4a65-a762-a7ac8d7e02b2@flygoat.com>
Date: Thu, 21 Dec 2023 22:25:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/22] Add support for the Mobileye EyeQ5 SoC
Content-Language: en-US
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
 <878r5vctdg.fsf@BL-laptop> <ZYNhbQjMbAH6I0kI@alpha.franken.de>
 <87frzwasxo.fsf@BL-laptop> <ZYRR7zIZax7yUgsZ@alpha.franken.de>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <ZYRR7zIZax7yUgsZ@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/12/21 14:55, Thomas Bogendoerfer 写道:
> On Thu, Dec 21, 2023 at 08:57:55AM +0100, Gregory CLEMENT wrote:
>> I do not oppose the addition of a new platform, even though, like
>> Jiaxun, I would prefer to avoid duplicating code. The only thing
>> preventing the use of the same kernel for EyeQ5 and other platforms is
>> the starting address.
> there shouldn't be code duplication.
>
> My rough idea would be something like
>
> diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
> index af2967bffb73..d683993ed331 100644
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
> diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
> index e37a59bae0a6..56011d738441 100644
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
>   obj-$(CONFIG_YAMON_DT_SHIM)            += yamon-dt.o
>   obj-$(CONFIG_LEGACY_BOARD_SEAD3)       += board-sead3.o
>
> so everyboady needing these parts of a generic kernel is able
> to take it.
>
>> Therefore, if it were possible to have a relocatable kernel, this
>> issue would disappear.
> yes. There is support for relocatable kernel, so what are we missing
> there ?

It does not handle 64 bit relocations currently.
I tried to look into it and it's not a easy fix.

Thanks
- Jiaxun
> Thomas.
>


