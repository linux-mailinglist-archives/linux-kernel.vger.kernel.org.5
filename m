Return-Path: <linux-kernel+bounces-9129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4682D81C107
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB85B1F253A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B7578E64;
	Thu, 21 Dec 2023 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ajp0ZrzO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="daLkiNZe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1DB6519C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id C24FD5C011A;
	Thu, 21 Dec 2023 17:27:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Dec 2023 17:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1703197656;
	 x=1703284056; bh=D3XrcpmwSUo4Jh0flb6Uu5UWPtnHv0fDYb0xkIsdRag=; b=
	ajp0ZrzORgYya9RxrSC/ZBpVlPkUGrydFB9a1C+Gca7EalgQtn7FiKb9R6Odhy7J
	i8kvMh8/kcjR0gORarpO5NYUepVVHH1E+rCRWr7fbrBe42mOoAHaN38taZmWd4nP
	teNmi6NTfY4WZbLiNi3XSopXBJpsRSFwHtiG46STDydYXnyNIQrMOEWY0tuUdU/9
	kGy0OXlT0EQWicbrMmuhIwot0mUTsBu7AmeTxQ7YwcbY4SSHyh+SCjedZ9V7WRDT
	0SNX8m1iSAyMcYZM0lCZ1Ye5/DPCHAzbDf/XHyabnt80gA/1Pcj5WB4nrInI6CEt
	tuMdl17WUq3scRUQ0pcPUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703197656; x=
	1703284056; bh=D3XrcpmwSUo4Jh0flb6Uu5UWPtnHv0fDYb0xkIsdRag=; b=d
	aLkiNZeElD4ukKPg/YCO1frIjgShagfukeUV8psUNAy/UzDB3ZFAcFjtZShvACNN
	o5KcC1zX2m/YQv+k1q+eZj6ryK3zfbaOHghRKytJqH/0SK4+VlCzjOGPQYK+GS2U
	v9xmURPfylN6VLoAapHJbeDZJhdBjcDQ3Nw+tNKL+lM4XbKDb4HPkH30OSJ1+Y6w
	A/2B7W+8AaWXj64lkw0L7ZVDIFeGEExk+Lt2mzOOwI4UJ1eOviNRsrY72/kz26XX
	ObF4FDZYiFaKZUQDYrxfinuginoTMO69ZTZkAiHeIAxUha3kqUmHK2AXznNOujn+
	qkUCa87FZPwiQFu9e9InA==
X-ME-Sender: <xms:17uEZRaZxFCc_FeZ-aGkI6jRraVGGGlQ0-4mFDtN6Ltq6lgOroTStA>
    <xme:17uEZYYOfYHllnQ3ixOcpHjeePW7kPUj8M6FTuuiJ7ew-2JlwPnn1NeL_AAL3gVXz
    fJCwFq6GedQAXFMEI4>
X-ME-Received: <xmr:17uEZT_rMwx0TakRM0FnlG4uWXTObDLepqD1Xr8sYLD6aDKIEzsF1RFw1gtkNYAua65_kt43b40F-aKvnz7qagi5ET8rKNZdvUnnfqk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeekffevjeffffejffetffejhffhtedugfejvdeiudfftedv
    udelhedtjeffgeffkeenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdr
    higrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:17uEZfovbZw7oktEs-T-41hPO-Q6_tdt7m4vescoLjJPV2Rkafij0Q>
    <xmx:17uEZcrNU_YumQyMsSxmc7kod10T7Uimk-Km_rhYQD-74XnEi2qtjw>
    <xmx:17uEZVS3sI8axrqdgucivL6mvz-aa_scdGI1YKJTbgvQBOQ2wcUvBQ>
    <xmx:2LuEZYchQPEzr_areAYHbz5WJz-8WHI4ATdtrKSgqxhTVPO1DB_tdQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 17:27:34 -0500 (EST)
Message-ID: <f31d929c-fa0a-4046-be05-38e92afa5d92@flygoat.com>
Date: Thu, 21 Dec 2023 22:27:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: set ARCH_DMA_DEFAULT_COHERENT if
 RISCV_DMA_NONCOHERENT is not set
Content-Language: en-US
To: Maxim Kochetkov <fido_max@inbox.ru>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, mpe@ellerman.id.au, aou@eecs.berkeley.edu,
 palmer@dabbelt.com, paul.walmsley@sifive.com, Conor Dooley
 <conor@kernel.org>, hch@lst.de
References: <20231221185152.327231-1-fido_max@inbox.ru>
 <20231221-discount-decade-e306e5878c46@spud>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20231221-discount-decade-e306e5878c46@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/12/21 20:29, Conor Dooley 写道:
> + Christoph
>
> I don't think this patch is correct. Regardless of whether we support
> cache management operations, DMA is assumed to be coherent unless
> peripherals etc are specified to otherwise in DT (or however ACPI deals
> with that kind of thing).
>
> What problem are you trying to solve here?
>
> On Thu, Dec 21, 2023 at 09:51:52PM +0300, Maxim Kochetkov wrote:
>> Not all the RISCV are DMA coherent by default.

Sorry for chime in here.
IMO if your platform is not coherent by default, just insert 
"dma-noncoherent"
at devicetree root node.

Thanks
- Jiaxun

> What is a "RISCV"? I believe this sentence should be "not all RISC-V
> systems are DMA coherent." but that is provided for by the
> "dma-noncoherent" property, set for peripherals (or buses) that are not
> DMA coherent.
>
>> Moreover we have
>> RISCV_DMA_NONCOHERENT option.
>> So set ARCH_DMA_DEFAULT_COHERENT only when RISCV_DMA_NONCOHERENT is not set
>>
>> Fixes: c00a60d6f4a1 ("of: address: always use dma_default_coherent for default coherency")
>> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
>> ---
>>   arch/riscv/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index d6824bec2c00..111c5d92d503 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -14,7 +14,7 @@ config RISCV
>>   	def_bool y
>>   	select ACPI_GENERIC_GSI if ACPI
>>   	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>> -	select ARCH_DMA_DEFAULT_COHERENT
>> +	select ARCH_DMA_DEFAULT_COHERENT if !RISCV_DMA_NONCOHERENT
> I think this is actually buggy, for things like distro kernels
> RISCV_DMA_COHERENT will always be set, but those kernels are expected
> to be used on systems that are cache coherent also.
>
> Thanks,
> Conor.
>
>>   	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>>   	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>>   	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>> -- 
>> 2.40.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


