Return-Path: <linux-kernel+bounces-9851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E4581CC5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C914284EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E40E2377E;
	Fri, 22 Dec 2023 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="CE0wOMBN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dNC8d1TP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B04323760
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id B8A963200A28;
	Fri, 22 Dec 2023 10:45:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 22 Dec 2023 10:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1703259939;
	 x=1703346339; bh=6zFESOLYOJ1DDdmVNp/WKfFuDXzWx4mPHU++2AdAS2g=; b=
	CE0wOMBNfNkM5XslHkcIoMwIII73hgIWhectOKaBavXEURdejv5SkIt/AmUEIOB2
	VtmlXetJnVsIHm3YBTV9/tIHkVigfANDBoYL3zy2lQv3PyH1+106swdLJ6ehpYwV
	p2ilAP65ViFjfUgwsG2xxUZ9pIY4K3nHxEEIpIvGGDsa4coB7E+So2RrUnCxLiRu
	n9r4yRdJV8XJCmFK5TAnRLWxdIWJ0ttpO/NNcNlg6xec8M5KuDwhQyHXNpXP40Rb
	q9EKE8Io399D5T2sWn6g0dUIOpNCHJAzUTkyTP0BrWxa5obBkbo3smNJZsCVCxZm
	wATeiKpkEee0ifRPtnuv6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703259939; x=
	1703346339; bh=6zFESOLYOJ1DDdmVNp/WKfFuDXzWx4mPHU++2AdAS2g=; b=d
	NC8d1TPuieHSHEmdIbIcvr2O+PE//rfojR7jBxJ/WYHaXsWaS4tL3k6Cdc+bRTmb
	O3CkS+Ks11zxOYFYN0Fcu6DfswY1MvhB2aWCpfT5Hp+mdvNW6bkoAFxq2Nvnj57f
	eJBNsf7hKi7wVuirD/ylgYjQ2n0PQkGIx+pBwB6ntyDudwUwz/+UdhQKd1QfTtBY
	MMQF+UdI+L+Vcn1KddVtPQxUmGR2pkHdZQf3Mne+kyxLKdQfWLCVzSI5nqP7aOAF
	pG6XaUZpwy20qEUCx3Z/Xf9FH9ymSb9jE4fCdjzyiOIgoPh7dc9ToQ08x55/E4mq
	oFBkEhE51zpAeEFd2P1tQ==
X-ME-Sender: <xms:Iq-FZURllPKgBOomqiMAhfu9aKti6eNbtYgqTEE1xWN8b0cnlwoIDg>
    <xme:Iq-FZRxS0DZee4IrEVYusWN3Dd8p0EEVOkCFewyNR9po8l9ARfRv31pAFXCRQC0Qj
    RpknJXnNAGZV0n-p_8>
X-ME-Received: <xmr:Iq-FZR12qHFDu8wKjatdfM79IYLK5SEX9P-Br2Z7qXY-ebzZD_R9V1WNzlQ38ifFV6Pt-GezQ6jua9TOcIc-s4SpMWfPgXbmeYaXQuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddujedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleeuffehheegleeuvdelgffhueekjeetueevuefhffdtgfeu
    hfeggfeukefffedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:Iq-FZYDEdwwZguPqfbjO7AIZgBDlLphTFnLyoBLXVOGZ5mrWXR7GdQ>
    <xmx:Iq-FZdhuzUtWFCr-PMFMNvq_4x-01mLZlUYqjlUPSXBXUof7xBFQXA>
    <xmx:Iq-FZUreFNisdHnuDNDZwlfppZQQkWSB6qoA8_pcYBDKbRXdYD0W9g>
    <xmx:I6-FZeUfhclh-2Ufph8NW4PbJuI8Yal-6qyE6rxEJV7nTKj8ML54uw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Dec 2023 10:45:37 -0500 (EST)
Message-ID: <7bc138f7-d5e9-471a-ae82-d6c490645623@flygoat.com>
Date: Fri, 22 Dec 2023 15:45:34 +0000
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
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <be10eb21-a0ef-416e-9c0c-d53326996fba@inbox.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/12/22 15:38, Maxim Kochetkov 写道:
>
>
> On 22.12.2023 17:54, Conor Dooley wrote:
>
>>> etc..) do not have this feature. These devices will use value from
>>> device_initialize(). And we have no possibility to change
>>> dma_default_coherent value by disabling ARCH_DMA_DEFAULT_COHERENT.
>>> Moreover, changing dma_default_coherent from false to true may cause
>>> regression for other devices.
>>
>> How can there be a regression when dma has been coherent by default for
>> the RISC-V kernel from day 1?
>
> Before ARCH_DMA_DEFAULT_COHERENT patch dma_default_coherent was used 
> unassigned as "false" in device_initialize():
> ..........
> #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>     dev->dma_coherent = dma_default_coherent;
> #endif
> ..........
> And now it becomes "true". It may change behavior of other non-DT 
> drivers.
I don't see any problem here, default is default.
Actually leaving those device with  dev->dma_coherent = false is risky, 
because
we can't guarantee underlying cache flush functions are here.

If a non-dt device do need to override it, it should be done in 
arch_setup_dma_ops.

Thanks
- Jiaxun

