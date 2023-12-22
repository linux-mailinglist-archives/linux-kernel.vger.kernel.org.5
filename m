Return-Path: <linux-kernel+bounces-9861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB82581CC7F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781F3284AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4123249F1;
	Fri, 22 Dec 2023 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="L+wsFcMc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmCx2J0m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694762420E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id C5D733200A04;
	Fri, 22 Dec 2023 11:01:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 22 Dec 2023 11:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1703260906;
	 x=1703347306; bh=M1tjCvjXqFax0LN2CzOpX/zS+U5B5Gyb2YsaY1tLXjg=; b=
	L+wsFcMcWp8klqBnr9ffs7VxUkRRQCKTQ8vgsURTa4JMmkhBqoq9d/jU0abuWdCC
	weY8e1lPb3SAO6YGvsyHecxgtIpLv1RDJD+IA+b1nCyUQ2YRYO2NAMFU6t1d/gJH
	NpXsFVlqWVMfJ//kw6Bp1L2HONJ6qMpuuTJSyVqPPabx2ZDGKTi2u/cwIkU5Q0/Q
	dyZxJ9JD86iRQNTI+dWtKIaFGeViw6AbrFVjWRUj+6gfowcG64rSKWmEiHCfLtzu
	R9ek6kC46xjoa4DCG4ez+RjkNkEC1HVPrVoPMj9IcSpJ864txYHqrgIT2ij1LRzL
	Pb4oBTuF5yvWXOXhJ31v1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703260906; x=
	1703347306; bh=M1tjCvjXqFax0LN2CzOpX/zS+U5B5Gyb2YsaY1tLXjg=; b=k
	mCx2J0mdUsPR3XI8sF9I0GQVzVjKofWu4PcoGChB7wbsfZGwBdEPhzHtZEGpb6xN
	FcYy9aViZwekcEfZjaqiM8rxYlStkxd24Y17a0FlYjJGdynDZ8j55NXhHx+s1N4A
	FdH/XohUyLeOo05GqC6Q51Nye/WZGvKYVEw4QMLZxVdQ/ErfddcW1sbKfXyrFTla
	43dnPTTzJIDRgXX1XkLGdoioWiT3dRQ9TyXaQynBak8AvcAARt65hQEbOgm2mDb0
	W07baEtc2i4T7jWfn1tMTIrsZtvq9dwilUYUqjjbK86tB3jEUh3qJM6pA5Vk9YLw
	AWgXpgaI3Aw7Q/7au7FiQ==
X-ME-Sender: <xms:6bKFZeKos-zuKrZAdOJJckG7k3CLlKvQFb5D8VEXKIyGS81ziojlLg>
    <xme:6bKFZWIQiCYLvC9360hTiYgIzEy1wr2uq_MBAlNU6Nx6Bpp_aixsJI3bg5tFDH6kr
    ipm2U-GpY-8PEmDPbo>
X-ME-Received: <xmr:6bKFZetdX7TTKKtV26cRvV3kVfLBdJ_tR7B6FDHkVoxMZ85WVFIIDjERrUkQDy-gwD-YoH3tZcx7BUAAVx05WfnEldrFf8pAFkYsxzc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddujedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleeuffehheegleeuvdelgffhueekjeetueevuefhffdtgfeu
    hfeggfeukefffedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:6bKFZTaLgx4DG9vmg3NHFHShNH4O7KEl1mPuyiq8p7qMF92TxJdnFg>
    <xmx:6bKFZVaOIJMPzFRop3ZBknCWwo-OWLUP5O_NNSdGfU-zzgmp59ugZQ>
    <xmx:6bKFZfB67DCDSJFsNsWAXaqz7qgpdIxur9_Agxe5ZT0rRTeTPZ-pRw>
    <xmx:6rKFZTOXHXHXWIAqDvOwC1WzySlmzsCNVjTDdqrSxjcJgXtD1-cFEQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Dec 2023 11:01:43 -0500 (EST)
Message-ID: <a25d3736-f6ca-478d-8e58-69a7c0e529f7@flygoat.com>
Date: Fri, 22 Dec 2023 16:01:43 +0000
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
To: Maxim Kochetkov <fido_max@inbox.ru>, Conor Dooley <conor@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, mpe@ellerman.id.au,
 aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com
References: <20231221185152.327231-1-fido_max@inbox.ru>
 <20231221-discount-decade-e306e5878c46@spud>
 <f31d929c-fa0a-4046-be05-38e92afa5d92@flygoat.com>
 <20231222041428.GA2803@lst.de>
 <c53c22dd-c482-4808-bdd7-e81c01c04f9e@inbox.ru>
 <20231222-outburst-spoiling-75082a7826dd@spud>
 <be10eb21-a0ef-416e-9c0c-d53326996fba@inbox.ru>
 <7bc138f7-d5e9-471a-ae82-d6c490645623@flygoat.com>
 <6fe34090-656d-491f-8173-217d20144166@inbox.ru>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <6fe34090-656d-491f-8173-217d20144166@inbox.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/12/22 15:53, Maxim Kochetkov 写道:
> 
> 
> On 22.12.2023 18:45, Jiaxun Yang wrote:
>>
>>
>> 在 2023/12/22 15:38, Maxim Kochetkov 写道:
>>>
>>>
>>> On 22.12.2023 17:54, Conor Dooley wrote:
>>>
>>>>> etc..) do not have this feature. These devices will use value from
>>>>> device_initialize(). And we have no possibility to change
>>>>> dma_default_coherent value by disabling ARCH_DMA_DEFAULT_COHERENT.
>>>>> Moreover, changing dma_default_coherent from false to true may cause
>>>>> regression for other devices.
>>>>
>>>> How can there be a regression when dma has been coherent by default for
>>>> the RISC-V kernel from day 1?
>>>
>>> Before ARCH_DMA_DEFAULT_COHERENT patch dma_default_coherent was used 
>>> unassigned as "false" in device_initialize():
>>> ..........
>>> #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>>>     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>>>     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>>>     dev->dma_coherent = dma_default_coherent;
>>> #endif
>>> ..........
>>> And now it becomes "true". It may change behavior of other non-DT 
>>> drivers.
>> I don't see any problem here, default is default.
>> Actually leaving those device with  dev->dma_coherent = false is 
>> risky, because
>> we can't guarantee underlying cache flush functions are here.
>>
>> If a non-dt device do need to override it, it should be done in 
>> arch_setup_dma_ops.
> 
> But arch_setup_dma_ops() is called only from of_dma_configure_id() and 
> acpi_dma_configure_id(). So it works only for DT and ACPI devices. What 
> about platform_device?

Ah I see, that's the problem, in MIPS's use case all DMA capable devices
are following platform's default coherency. For RISC-V we assume all 
device are enabled by ACPI or DT.

Perhaps you can override it in driver, but that will make drivers 
platform dependent.

I'll leave this question to Christoph.

Thanks
- Jiaxun

