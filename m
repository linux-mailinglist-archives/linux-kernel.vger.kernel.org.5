Return-Path: <linux-kernel+bounces-108414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022C3880A36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FD21C213C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996811C83;
	Wed, 20 Mar 2024 03:51:01 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AACB11712
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906660; cv=none; b=kUM+3tEfh0T1U8wsxYxLrD/1+jc0wc1QNPBXYLK02udTHyvRO5dKOtiLw+gpy1pF2kperbtm9IhpAMPMs5/lzpL42+bc+crIxWBFFdz1ggxfcMZoc0/QDp0PjYzwG01+B1mawmylr393y79Zz6vAjfvykgymnwhVT/r8FfhwYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906660; c=relaxed/simple;
	bh=gRj6ZPy0mZ2x9b+RuAzXtz+CTfqjk6gliIeOYr/1DrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtJp8Xw0lxYI0D3mmyZYZaEFo4c+kUK0SCe+6KEcF7ynGUER1QH0OF0uHIdsb3irGeUTLvf3G8a12N/yBwymNW7yKeWjygwuBW95TZDq6NSZdzZEU4em2UT1jVkPhqdEVaDENrgGqLzxRMMjgkTs7gK/ivUX8I6SNArdvZlr8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp65t1710906586tp2f6pfr
X-QQ-Originating-IP: ox81Nrupdyl0zdBekLqxnqdZYKJsG+1Wmht5/U+355Y=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Mar 2024 11:49:45 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 5q30pvLz2icV16dWzMxpWQz4znvu9bgI4WfLqgyFYlBMRPt7iNpzyVaIbczF9
	WEZ0DOJGNY/yB6zSpkD1wyoKcUhQ0Pgcl03s2EUIGazZ5Ou0r7cxHxgN7uunmKu4KEn2XvV
	0Flj3o72P6eEL7vRjvM6+ADVrG1AQPPU/YLqtIIc9IhuI1Si9zrZFjRbEzTzbNGBeFStUK5
	t37xAgb7zTyZ5im0JCDI4dDgtR2C5hZFZyeZMPVgeRoQ+x/tJuen+0nENoBY6+kOqpYGexw
	HTsQgn2K4Q0EjYGtMcCz6vTAnxFHYuITAGlOf0VpISBoPtX9mk7iTSjo1gy5Coj5NiTYPAD
	KkvkU4lAPEGHAfKkEiohcyqlO1ftieofiW3j+02jbEgANQ4e1BAIrusRRUkzg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11659824290670290864
Date: Wed, 20 Mar 2024 11:49:44 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com
Subject: Re: [PATCH] riscv: Remove redundant CONFIG_64BIT from
 pgtable_l{4,5}_enabled
Message-ID: <1F5AC099870F5765+Zfpc2MoIn7EU38rs@centos8>
References: <20240312085005.298657-1-dawei.li@shingroup.cn>
 <112ac071-71cc-466e-ab13-f624edb77bb9@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112ac071-71cc-466e-ab13-f624edb77bb9@ghiti.fr>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Alex,

Thanks for review.

On Tue, Mar 19, 2024 at 01:36:13PM +0100, Alexandre Ghiti wrote:
> Hi Dawei,
> 
> On 12/03/2024 09:50, Dawei Li wrote:
> > IS_ENABLED(CONFIG_64BIT) in assignment of pgtable_l{4,5}_enabled is
> > redundant, remove it.
> > 
> > While at it, annotate pgtable_l{4,5}_enabled with __ro_after_init.
> 
> 
> I guess this comment ^ implies that you need to split this patch into 2 :)

Indeed. I Will respin v2 as you suggested.

> 
> Feel free to add on both:
> 
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> Thanks,
> 
> Alex

Thanks,

	Dawei
> 
> 
> > 
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >   arch/riscv/mm/init.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index fa34cf55037b..204cdf5b829d 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -50,8 +50,8 @@ u64 satp_mode __ro_after_init = SATP_MODE_32;
> >   EXPORT_SYMBOL(satp_mode);
> >   #ifdef CONFIG_64BIT
> > -bool pgtable_l4_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
> > -bool pgtable_l5_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
> > +bool pgtable_l4_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL);
> > +bool pgtable_l5_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL);
> >   EXPORT_SYMBOL(pgtable_l4_enabled);
> >   EXPORT_SYMBOL(pgtable_l5_enabled);
> >   #endif
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

