Return-Path: <linux-kernel+bounces-111868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D2B8871E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 751E9B21D86
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EA35FBB1;
	Fri, 22 Mar 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="jdYGucEV"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25D47793
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711128809; cv=none; b=WRId1cNvYmfSkx8aimB4QxPEcRzI+RIy1eaunUZ8DqZyoQWpwaV2AUyP+CUXy0wabBOZTCIKi1P/aiN8P2isaDSdBcbdNIWqCL4lc2W7l9R6ccCD8CCNT6pQ7y3usj45M+Ib524fZazvG6IbuizGNDQoTI17zMbgdcoeYh/k8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711128809; c=relaxed/simple;
	bh=Yq6TPIOySs5SbkTECG8fTC9rHi3vyaMmLcUMisKVIDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7GaP+tq4vqPL87zH/KrErkyUdlTi/0NMwxeRk6xD1i/0siEsqkHP0guKU6WJH71eroQishi7LQqKmzNbSnIwjNnmG0tGE7J1yczdL7T1zaoITY4FOVRlZydM59z4PXMW2LxDqhWSZb/ZgiboXNjhdEramVSVgZheQr+44PnOr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=jdYGucEV; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-b985-910f-39e1-703f.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:b985:910f:39e1:703f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id B25D71AA455;
	Fri, 22 Mar 2024 18:33:16 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1711128796; bh=uSujtAeKaM3ubzxeNWEHiD7u5zka7YhzUm+SfYHNOq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jdYGucEVaESbR0fs1Ior9j0PrsOWd3/gK8UJHLlP/YuvCgjL/L3Yol+RFfoh4ECyq
	 MFs8QxbkGQRCFZsbo1rMYejOwzUmzIukrhUVr6bV7E29oaXKRgZdu4o7gjVS+7x077
	 I0vJYRoyo1NEt6GrWM7giiZr5yNIgtaQXGF2qHMDOT9qnMx/3tprgDw3lkaljVcYU2
	 e7YxG9ehmgRTtQRyljUekEyMuNe1XOhjqRR4KbY1Fs83pNBltviMhrCbEdaS5L5CYi
	 r1YMjqfZvPQZI+tj/eloS/zk8sbfcr+tAh0CFxrp/aXWopaF36oOXOKvu8XjLRnHGr
	 sZKxeTaedaplA==
Date: Fri, 22 Mar 2024 18:33:15 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Michael Kelley
 <mhklinux@outlook.com>, open list <linux-kernel@vger.kernel.org>, "open
 list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v3 2/2] bug: introduce ASSERT_VAR_CAN_HOLD()
Message-ID: <20240322183302.197c9b5f@meshulam.tesarici.cz>
In-Reply-To: <20240322153738.GC5634@willie-the-truck>
References: <20240321171902.85-1-petrtesarik@huaweicloud.com>
	<20240321171902.85-3-petrtesarik@huaweicloud.com>
	<20240322153738.GC5634@willie-the-truck>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 15:37:38 +0000
Will Deacon <will@kernel.org> wrote:

> On Thu, Mar 21, 2024 at 06:19:02PM +0100, Petr Tesarik wrote:
> > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > 
> > Introduce an ASSERT_VAR_CAN_HOLD() macro to check at build time that a
> > variable can hold the given value.
> > 
> > Use this macro in swiotlb to make sure that the list and pad_slots fields
> > of struct io_tlb_slot are big enough to hold the maximum possible value of
> > IO_TLB_SEGSIZE.
> > 
> > Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > ---
> >  include/linux/build_bug.h | 10 ++++++++++
> >  kernel/dma/swiotlb.c      |  2 ++
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
> > index 3aa3640f8c18..6e2486508af0 100644
> > --- a/include/linux/build_bug.h
> > +++ b/include/linux/build_bug.h
> > @@ -86,4 +86,14 @@
> >  		"Offset of " #field " in " #type " has changed.")
> >  
> >  
> > +/*
> > + * Compile time check that a variable can hold the given value
> > + */
> > +#define ASSERT_VAR_CAN_HOLD(var, value) ({		\
> > +	typeof(value) __val = (value);			\
> > +	typeof(var) __tmp = __val;			\
> > +	BUILD_BUG_ON_MSG(__tmp != __val,		\
> > +		#var " cannot hold " #value ".");	\
> > +})  
> 
> nit, but I think this prevents putting negative values into unsigned
> types. Not sure whether we care? Arguably it's even correct to complain.
> 
> e.g.
> 
> 	u16 s;
> 	ASSERT_VAR_CAN_HOLD(s, -1);
> 
> explodes for me.

Then it works as intended. I specifically aimed at making a macro that
checks at build time whether a given constant is within the value range
of a variable, so it explodes for a signed overflow (in either
direction).

To check the size of a variable, I could have gone with something
simpler like BUG_ON(sizeof(var) < sizeof(val)).

Petr T

