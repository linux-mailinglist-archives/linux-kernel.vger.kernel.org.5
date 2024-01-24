Return-Path: <linux-kernel+bounces-36626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A683A3FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A191C2993F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BE717BA4;
	Wed, 24 Jan 2024 08:19:26 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD83179AB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084366; cv=none; b=pu+54HoKPNoaK8ioEad7qnG3+pDStZpUjnRuSj/aLz7CffWJ1gVr7eoFXE3c5AceclXXYbkOHGJj/OsDu1PqrOnw89lmtwPvAYC/2a6gVyovBwecfx7TZbrlDP5g/MTATL3H1J+VS31j1r4wNx2JS/jUfcaMAQYvkj2Z8hou3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084366; c=relaxed/simple;
	bh=X3LD9CJ0SLrKuOVPnWjQdhvQZYQI+xVAgK5XAco9Vm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1R4dLjRbs6bKMuzBC2j82ngQqWmOkQIE2pAPL94DyRmTDyD0YyCP5p4WI0/RVMd5tLVPgK6ciMNRbu4SpB7Aqiz4S6y5Ai1XbtMx/Y7MI0zDFytWr77NudG5BHxRsYKonMeYo+8Q0ODdMN1DUOb7H0KDAi/zk7q6dJKbV3oaA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d71207524dso21018585ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706084364; x=1706689164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBK6o6GnY6AtPw3FK1bbWWcrmikSYA/tE1QF6tcz4rQ=;
        b=ecue5RUeObfOds11m9FsZnK2awA5h6d8KpYwjpFKYj7IGT11HfmQ/0fagy5FVGU1No
         /YgZarOWlHlU+lvaRsfYmF/TfrqIZVWUmz8AHxTMzajSVr3JPZa6Xnp/nVHAxpai/eN1
         pXUE5QyIBep4NsZ8qYYXCYzsqS++h2kJo1RfdyZKHkDoPLBbGBwGlV1sv0VOU+1QqTsK
         k/KorcLXlR8PFRaMAwmj/xoCixqMWQwt4iihFKOrca9puRD3BcPXdjXqiCwVgMZ8b8G1
         RYP1SEXl5QbAu+NXpACC09mw/APwK6F1quhH0IqI8kpeZ5cffKzKjZmNPREWyjE1BgjB
         qL4w==
X-Gm-Message-State: AOJu0Yxkt0imRel2/wlxPuWUUIWCGTNKOavJgIiuRv/oGhU9gOgDwnyR
	O1TGsjH3pjPkSwakoZusAX8QL4/yFXMFlUApwGhcLqiUYMncxUeN
X-Google-Smtp-Source: AGHT+IHGYSTBITu5TdF72Mqb7p/EFgLgmwcQH5OP/zO5BiOYdJdq9HCi0fQxs2Uu9CxsF44i0Po/pQ==
X-Received: by 2002:a17:902:f68e:b0:1d7:88f7:678a with SMTP id l14-20020a170902f68e00b001d788f7678amr187989plg.10.1706084364211;
        Wed, 24 Jan 2024 00:19:24 -0800 (PST)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902d64400b001d7465c213bsm5106477plh.197.2024.01.24.00.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:19:23 -0800 (PST)
Date: Wed, 24 Jan 2024 00:19:21 -0800
From: Dennis Zhou <dennis@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [External] [PATCH] riscv: Fix wrong size passed to
 local_flush_tlb_range_asid()
Message-ID: <ZbDICZkatO3/lGf/@snowbird>
References: <20240123132730.2297719-1-alexghiti@rivosinc.com>
 <CAEEQ3wk5edUFTuE3H3KDGkCXj0+=i7Z1BM2M+6X-Tk9_m8X_iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wk5edUFTuE3H3KDGkCXj0+=i7Z1BM2M+6X-Tk9_m8X_iQ@mail.gmail.com>

Hello,

On Wed, Jan 24, 2024 at 10:44:12AM +0800, yunhui cui wrote:
> Hi Alexandre,
> 
> On Tue, Jan 23, 2024 at 9:31 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >
> > local_flush_tlb_range_asid() takes the size as argument, not the end of
> > the range to flush, so fix this by computing the size from the end and
> > the start of the range.
> >
> > Fixes: 7a92fc8b4d20 ("mm: Introduce flush_cache_vmap_early()")
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/mm/tlbflush.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index 8d12b26f5ac3..9619965f6501 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -68,7 +68,7 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
> >
> >  void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
> >  {
> > -       local_flush_tlb_range_asid(start, end, PAGE_SIZE, FLUSH_TLB_NO_ASID);
> > +       local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_TLB_NO_ASID);
> >  }
> 

Well this was a miss during code review.. I'm going to take another look
tomorrow and then likely pull this into a fixes branch.

> What makes me curious is that this patch has not been tested?
> BTW, It is best to keep the parameter order of all functions in
> tlbflush.c consistent: cpumask, start, size, stride, asid.
> 

I can't speak to the riscv communities testing/regression suites, but
this would only be caught in a performance regression test.

That being said, Alexandre, can you please lmk what level of testing
this has gone through?

Thanks,
Dennis

