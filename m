Return-Path: <linux-kernel+bounces-65363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CFD854BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983541C216BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBFE5A7B6;
	Wed, 14 Feb 2024 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="gyQBbXH2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TWECDkEP"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A25579B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922201; cv=none; b=AYV3UYURgQdPCqiCx77kFtpatbZCoUvJljxiNDX5P5MOURe/svrtRsCRUZJmBJK9RoB2OF0xXfq+nzxDOS6m51DTUJpa0agbGHOQsxXvaSHF3wjVdwV5N1XjfbydoHFHUrr54Oexl5DFAH+mbrnMY/HQfen9bw1ajod23+F1dSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922201; c=relaxed/simple;
	bh=B1yFHfeHqpqZavgAJ56fxZmHRfqRxaiP53AMO42YAk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0qOCV1FTndOYCCD5gDYv2YGD9WrHImAFeJMhubnsbSDcM9zbb8IH1ZgUDrctv5rWFpjolRXhg7AO9ljcpTxwp48mFJDZ1JJPlB8AslQ89FJ/uFYxsnoftlOZkZ/rnmx2SsZxphbtq5Cqg7KTLa3VsAEb4117s4WTnWcg8jmjLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=gyQBbXH2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TWECDkEP; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5ECD2180007C;
	Wed, 14 Feb 2024 09:49:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 14 Feb 2024 09:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707922195; x=
	1708008595; bh=epVZw1x9FVt2elh8jYLSX6PiqT6PpjnxqNeFSeq1Zwo=; b=g
	yQBbXH2Nd0+K8dm+BcBfX5h1iijUIOSpznBIPpqcSiWFGBi4uy+ekQkVEtz4utnl
	RC8WyKwJOIUYe5ltvS5CAV+nY0oL7R6qmfPLy89cXJDUfEcV6QuVgXY6HOBcoTPE
	IQuz8RItCSO8eg6jjCJnd8bgwu7h45n25lgd7Z3a0PHioW7afFmpMQdlr+rD2xEz
	MPUyK8Y/nzYX7ovkxetOJuRLvdBfO5ImGrS4gFLl08+oXTfEk6Rlm2GCLHS5ezJR
	B8LCU0r4c2Q+Kpolz6HDeASuRuILF687s2ny91S+eXAr10vzUppyIYhZ9TaUXxIu
	KUhOEnig/MnY4J5ySkMcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707922195; x=1708008595; bh=epVZw1x9FVt2elh8jYLSX6PiqT6P
	pjnxqNeFSeq1Zwo=; b=TWECDkEPyM+sYaRC5S/kgrLIwNlmMN5vk78TViGP+uG9
	sV19jQS/pZDH4VVyghDBnXnQeLbpl1oHNGtkc3b/KaF9+eOyZw8LVVBdHg8HarEe
	fxc9m704DTG9dzstJOSIgSC0v8gBAAUYNpTIDGOqvmxJLzJDtxyd8MhUVA84+6Dq
	VUJNWPDOJSCI7cUVBgvFHDPYb5A127XlJLexkbUWAddoJ4Z1KTdrogLR55ErvDia
	+rk09aBQcQMq815rtwAMzyqDPMcaU99rsptGwady+fZc67+o5+OF2IBcl9iXNqnL
	fydkw+UZqln/W0ihd9dwmd65wNdWU1wpL1lZbAJyeA==
X-ME-Sender: <xms:E9PMZX54oyMKaAaJ_yd4U6z8deSTfX2VjxyII9T6oyFqWDT-VmqR1Q>
    <xme:E9PMZc6d-aqCG-k5tlYpGO8Jj8vd_mU482uidZ4ns0uLHBAeHSO9zjPpeSX1rSUsL
    xMCWALJfyqh_m6mzrs>
X-ME-Received: <xmr:E9PMZeecVyW9Weif_91PgXCD17To5gU9JRvdVVTHnPpNba-1Uy8mGg6SeMpgZPtUS-opmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepffdvveeuteduhffhffevlefhteefveevkeelveej
    udduvedvuddvleetudevhfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:E9PMZYLEHNnCXh7Lx4P7KqbQWT0tTqd8hEYZyFHflgl86FQLOcl8Aw>
    <xmx:E9PMZbI76GkVpmnx_IE0boGvmj1BCkv5F__Yoni-YXjxJp7Z6YFz8g>
    <xmx:E9PMZRzzgaJxAaeZGGZvPtYcKP1GTtrA2EsR8rh_Bdipdm5GmLHtdg>
    <xmx:E9PMZYj5w7fKoEtOhFuSYQhLi5HWBZVcSmJyPzQtJmPhHvhCrKLFGZJS86M>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 09:49:46 -0500 (EST)
Date: Wed, 14 Feb 2024 16:49:43 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Vishal Annapurve <vannapurve@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	rientjes@google.com, bgardon@google.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com, 
	michael.roth@amd.com, thomas.lendacky@amd.com, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com, bp@suse.de, 
	rostedt@goodmis.org, iommu@lists.linux.dev
Subject: Re: [RFC V1 1/5] swiotlb: Support allocating DMA memory from SWIOTLB
Message-ID: <etvf2mon464whscbxqktdd7bputnqmmwmoeg7ssixsk4kljfek@4wngbgzbbmck>
References: <20240112055251.36101-1-vannapurve@google.com>
 <20240112055251.36101-2-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112055251.36101-2-vannapurve@google.com>

On Fri, Jan 12, 2024 at 05:52:47AM +0000, Vishal Annapurve wrote:
> Modify SWIOTLB framework to allocate DMA memory always from SWIOTLB.
> 
> CVMs use SWIOTLB buffers for bouncing memory when using dma_map_* APIs
> to setup memory for IO operations. SWIOTLB buffers are marked as shared
> once during early boot.
> 
> Buffers allocated using dma_alloc_* APIs are allocated from kernel memory
> and then converted to shared during each API invocation. This patch ensures
> that such buffers are also allocated from already shared SWIOTLB
> regions. This allows enforcing alignment requirements on regions marked
> as shared.

But does it work in practice? 

Some devices (like GPUs) require a lot of DMA memory. So with this approach
we would need to have huge SWIOTLB buffer that is unused in most VMs.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

