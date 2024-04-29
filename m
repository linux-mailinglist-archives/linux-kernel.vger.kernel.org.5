Return-Path: <linux-kernel+bounces-162134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC658B566A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E801F22D43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA423FE28;
	Mon, 29 Apr 2024 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml7PDV8t"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA3F3FB84;
	Mon, 29 Apr 2024 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389828; cv=none; b=YHWY8oW3Hz85owL23+ThT6ofyLQxTP28SFU1SgK/yiJENYnkXP5fR4aftyIDxWdxdPNJELe0+CiMPGHMUiK2bLhQkm1bBjiwT611fozqPDmJnfkwKWiSQ2R8oGJk0QMaLoby3i2KYQYpyOj9GyuIexnhAZV7x+Ao5j8U2VOsv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389828; c=relaxed/simple;
	bh=aqXHscrRfcuVMryQ0VmPAD470hPq8NqBWV6Twu76Fgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOpBpyqmT3tjQE13WRO9jbVTn9kvAOsQBnuidhXl7MP/PzI+bVDLT/jYkf8ECMtV/F08X3fwCDd2pbqn4booe5e3WH87rDMR/uBRdRNdYehq2myT9eTlt2fxxzZJUzbWgPbfFhRYanjoHjnoiGdywf0ZMXu8JThndyaPu7AhuJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml7PDV8t; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-571bddddbc2so5147274a12.1;
        Mon, 29 Apr 2024 04:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714389824; x=1714994624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KI8jwSeT1iJj/UBYCVNCpYpjMdWJYZrUv0ljjTWL48=;
        b=Ml7PDV8tDafrW5jNE6i8WI8B/0iL0aVC9zBl3C7Tr8sItZGleq4DiDtnfGHfZI+s5u
         Zk/DisMMnVjmS1LMCPiKMTuBKdKhlI8qUiOghy/+tKu7aINxWuyr6Srv0cVGbWecW2gv
         kC3Tzq0qGreqCJHIT3/GCGcmjfwPoUP5vYHvHf4Q+hPDqMQnyroEO/woQzraAhmWQz//
         zq1StHTdIzo98WsPbxHcxyOCYYQ/oulOb4huHaChFhKexjhj/lI2OXdina5+5V2Q6Rae
         ot5xp4TcEXMVE0hAnaBkssHQSwvr8q4Xqj7cOxoLc7JV240uwLSDzqT/FzthQAVK1lub
         NFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714389824; x=1714994624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KI8jwSeT1iJj/UBYCVNCpYpjMdWJYZrUv0ljjTWL48=;
        b=wSVpWzCl5suZ00ma+VmbhbRPYaXSR0cGJt5mxwbX9mkm5U2P9q+DoWW3atnycBuziB
         qwiiKJ8cMbqnVaO3ELdzRgO30l4wkhRQlJTSK394pBgTPJiURJoK/4woxgabv0lB8wut
         dXIyPfzOuMtfkipe5WAspHcrOkMYx4snCu4TPQocTmz8x1dpacybLljHmyUJI+1xIRXz
         cJXdBCxWscIPYx3oRpCUasTc1/ewA7JqYc1LQ0zNRDgVMMNboUmvQTI++WIl0Az/KiHV
         y1nUR01l6DPCVbP9N5fKQQPzUbzkTwtoGtx6pen4WhVQRtqApckVIzGOJWz9P0pNBzcI
         xu1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9m3Bvf+v6+KizI8QI5y2bV6medG6/KhXWX6bFP1g/n/HnMhDFFZ4GoMvuDezUS+oW3Wla1O09HEUYyW7npIHPHsFril4R+GpSRwajrTLs9GqGLPVKwhvLoRUFZG6BNZkmCK0bjgE/fQ==
X-Gm-Message-State: AOJu0YwTu39aIWOLN8Kfcw2ZF+zsfh1pgCJAeNmFmr2LlrGIUUcsgnje
	pZ2yj0/sGDJHb7VflXIXLnhcV/GU5oudDqBPXVnSfiU0PCzzsvKu+HH5pFEF/yI+T2Ji7sIANGH
	WnJhx+lv6WTH0OWC6mYs6k/my3Hw=
X-Google-Smtp-Source: AGHT+IG2L6VHSgjPSI/ILsTX8RnUhW7ZCUeTXF2zruE9lvX81lsZxzWjLYduBB8ybTFePpHpcWjpPPLOGxbnBtFwaHY=
X-Received: by 2002:a50:8a89:0:b0:568:a30c:2db5 with SMTP id
 j9-20020a508a89000000b00568a30c2db5mr5612851edj.40.1714389824240; Mon, 29 Apr
 2024 04:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429103346.59115-1-libang.li@antgroup.com> <20240429103346.59115-6-libang.li@antgroup.com>
In-Reply-To: <20240429103346.59115-6-libang.li@antgroup.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 29 Apr 2024 19:23:32 +0800
Message-ID: <CAK1f24n4usJm4=e0+jrTxGtRjqTJZvn4gBp8d_vU=p2CrU=TsA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] mm: Add update_mmu_tlb_range()
To: Bang Li <libang.li@antgroup.com>
Cc: akpm@linux-foundation.org, chenhuacai@kernel.org, 
	tsbogend@alpha.franken.de, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	chris@zankel.net, jcmvbkbc@gmail.com, david@redhat.com, ryan.roberts@arm.com, 
	libang.linux@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Bang,

On Mon, Apr 29, 2024 at 6:36=E2=80=AFPM Bang Li <libang.li@antgroup.com> wr=
ote:
>
> After the commit 19eaf44954df ("mm: thp: support allocation of anonymous
> multi-size THP"), it may need to batch update tlb of an address range
> through the update_mmu_tlb function. We can simplify this operation by
> adding the update_mmu_tlb_range function, which may also reduce the
> execution of some unnecessary code in some architectures.
>
> Signed-off-by: Bang Li <libang.li@antgroup.com>
> ---
>  include/linux/pgtable.h | 5 +++++
>  mm/memory.c             | 4 +---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 18019f037bae..73411dfebf7a 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -734,6 +734,11 @@ static inline void update_mmu_tlb(struct vm_area_str=
uct *vma,
>                                 unsigned long address, pte_t *ptep)
>  {
>  }
> +
> +static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
> +                               unsigned long address, pte_t *ptep, unsig=
ned int nr)
> +{
> +}
>  #define __HAVE_ARCH_UPDATE_MMU_TLB
>  #endif

IMO, it might be better to use a separate definition to determine whether
update_mmu_tlb_range() is overridden by a specific architecture.

Thanks,
Lance

>
> diff --git a/mm/memory.c b/mm/memory.c
> index 6647685fd3c4..1f0ca362b82a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4396,7 +4396,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>         vm_fault_t ret =3D 0;
>         int nr_pages =3D 1;
>         pte_t entry;
> -       int i;
>
>         /* File mapping without ->vm_ops ? */
>         if (vma->vm_flags & VM_SHARED)
> @@ -4465,8 +4464,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>                 update_mmu_tlb(vma, addr, vmf->pte);
>                 goto release;
>         } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> -               for (i =3D 0; i < nr_pages; i++)
> -                       update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pt=
e + i);
> +               update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>                 goto release;
>         }
>
> --
> 2.19.1.6.gb485710b
>

