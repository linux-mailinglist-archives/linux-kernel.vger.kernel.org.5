Return-Path: <linux-kernel+bounces-162486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 207938B5BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBB01F23031
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE2D823A8;
	Mon, 29 Apr 2024 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MThFsg/T"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70DC7EF1C;
	Mon, 29 Apr 2024 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402188; cv=none; b=HlIIr5Nr0u52yRpartJoN5hVOxkEzP0MP6uOCU4qpgb6Qe6asXCML+oTgMCIgSHSo+vwrq0OU4NQJ37L3ww9zf+tvBvbfAnjMSH4JmuqWwl/beYt2pfVzauvNtFI1Q0BbxMKDiNQiH7tA1YWCBFWb5kmgR8kdBrSjC+0LPBXSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402188; c=relaxed/simple;
	bh=qdnrieP7xQy7d5/UHTh9VvZfK9UpC01YfOtyW0mTLow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvV1LnZ5uaO+HZBXg66IDr6MN9kDUFUiXbVchdr6mN0yIT6Um9hG74aohgIquaK2eNUBYgNmKMIj+rgHUnAQlwsNIwNFfcHiaGlCG1n36SVSrbt6N12qAP0wVEH6CpWoOWeJUFdUUmyOE6vgv4NWht0pIVHF7f/8yOKpKTRwwJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MThFsg/T; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34d1adeffbfso729958f8f.0;
        Mon, 29 Apr 2024 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714402185; x=1715006985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfyRjOuSPcP/8vf1MVxXT/xq8HK5zEuNahOzWkgZ0UE=;
        b=MThFsg/TwjCaGtugok/piU1oKe/EHDCHCUHbL35EcwI1jeklXsOHGiv4nhr25MvdVW
         RoGwU2e1TznKT9Qc3qCDWTIzapvVE6kgkB0mv8dA7KbOGSUC2DDvSNiOcBDCk3DGQtnf
         3PheJr3IDXMFWQPtDb2tTAYO3h7Hx0f82+9hkeCDTjMPua3uYcUeGBuZC2S+idYY9FXp
         19rH9Lj9kwpjl2tI6NKkx4Q3DGjo8fXNUyYPGsa5wlLvbQdR/4LKb4zwfP0syPsFteor
         3ytHbY2eavp/Tr4Sso9CAu6QHadz80FoK8GrAL5nPS06vQBfmOtGKuemwMfyKed5ziug
         UDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714402185; x=1715006985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfyRjOuSPcP/8vf1MVxXT/xq8HK5zEuNahOzWkgZ0UE=;
        b=EgqlfPT4x/5dw7hkFnza3V12roBsX57qSUWILtblaliHcEqB7xVeO6+hL2KjwA6yuh
         IdhRMli/9SisYGMv49I2mbNvZ8/MkSpPuCOGuxRYFXniW8TNXaoI5aYA55z+jDYYPqpR
         5G0KRaZx+KthVUZlSWoV9tm36jdKluaOd32EIZjWMbiHIrPZBmD70MM9Xm9RnT4egDYs
         9f+uwU5cSCggS6dEGEv8RHpcCfgxUmMglcmEi9wun1smIZugeM9S23l4nzWzL6iTHf7r
         fVlAPV0ohbN0wmekEqWdjsxv3YDTnyrKwDiKBZFB+mP/gELx/9d4hMpjqXDCMRh/tf7Y
         q9fg==
X-Forwarded-Encrypted: i=1; AJvYcCXIZdsDoPl7Q+u3xn+eN0SaK5vhRpz5CtbU6kdWbng+0NXldUA4SfLKyL5YOs4S2fEKXu7m1wWZLGLyiZb7OV7sJJVRUqPjIamNXv2Jv91mReycSDLVMzCEiwW6FKD3wilbeTls
X-Gm-Message-State: AOJu0YwAIe0a3w8rjuGgLe/CF12MfBNZD0drKl+wqeXiKFChiTcIsMzG
	nJCxL+hfribHeJeZ2ZGKwTA08UPhXt3AD3LqYJ6xfneh7synQ1SZLK5tnXcDY6HcrLEy/Tn42WP
	y3CVIlAgsbQcnQLKpa0CdIDSWQNs=
X-Google-Smtp-Source: AGHT+IHN6ERBx3BZ2D7GhtOhaTlbSbZAY8hX8akybIxOVIxZINp7QT5r+1i/VyK3jejhfRJu2FkKq+RQtBYoZpfzVdM=
X-Received: by 2002:adf:e111:0:b0:345:ca71:5ddb with SMTP id
 t17-20020adfe111000000b00345ca715ddbmr4826030wrz.66.1714402185017; Mon, 29
 Apr 2024 07:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-10-linyunsheng@huawei.com> <37d012438d4850c3d7090e784e09088d02a2780c.camel@gmail.com>
 <8b7361c2-6f45-72e8-5aca-92e8a41a7e5e@huawei.com> <17066b6a4f941eea3ef567767450b311096da22b.camel@gmail.com>
 <c45fdd75-44be-82a6-8e47-42bbc5ee4795@huawei.com> <efd21f1d-8c67-b060-5ad2-0d500fac2ba6@huawei.com>
In-Reply-To: <efd21f1d-8c67-b060-5ad2-0d500fac2ba6@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 29 Apr 2024 07:49:08 -0700
Message-ID: <CAKgT0UfQWEkaWM_mfk=FhCErTL_ZS3RL6x3iMzPdEP3FD+9zZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/15] mm: page_frag: reuse MSB of 'size'
 field for pfmemalloc
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:38=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/4/18 17:39, Yunsheng Lin wrote:
>
> ...
>
> >
> >> combining the pagecnt_bias with the va. I'm wondering if it wouldn't
> >> make more sense to look at putting together the structure something
> >> like:
> >>
> >> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >> typedef u16 page_frag_bias_t;
> >> #else
> >> typedef u32 page_frag_bias_t;
> >> #endif
> >>
> >> struct page_frag_cache {
> >>      /* page address and offset */
> >>      void *va;
> >
> > Generally I am agreed with combining the virtual address with the
> > offset for the reason you mentioned below.
> >
> >>      page_frag_bias_t pagecnt_bias;
> >>      u8 pfmemalloc;
> >>      u8 page_frag_order;
> >> }
> >
> > The issue with the 'page_frag_order' I see is that we might need to do
> > a 'PAGE << page_frag_order' to get actual size, and we might also need
> > to do 'size - 1' to get the size_mask if we want to mask out the offset
> > from the 'va'.
> >
> > For page_frag_order, we need to:
> > size =3D PAGE << page_frag_order
> > size_mask =3D size - 1
> >
> > For size_mask, it seem we only need to do:
> > size =3D size_mask + 1
> >
> > And as PAGE_FRAG_CACHE_MAX_SIZE =3D 32K, which can be fitted into 15 bi=
ts
> > if we use size_mask instead of size.
> >
> > Does it make sense to use below, so that we only need to use bitfield
> > for SIZE < PAGE_FRAG_CACHE_MAX_SIZE in 32 bits system? And 'struct
> > page_frag' is using a similar '(BITS_PER_LONG > 32)' checking trick.
> >
> > struct page_frag_cache {
> >       /* page address and offset */
> >       void *va;
> >
> > #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
> >       u16 pagecnt_bias;
> >       u16 size_mask:15;
> >       u16 pfmemalloc:1;
> > #else
> >       u32 pagecnt_bias;
> >       u16 size_mask;
> >       u16 pfmemalloc;
> > #endif
> > };
> >
>
> After considering a few different layouts for 'struct page_frag_cache',
> it seems the below is more optimized:
>
> struct page_frag_cache {
>         /* page address & pfmemalloc & order */
>         void *va;

I see. So basically just pack the much smaller bitfields in here.

>
> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
>         u16 pagecnt_bias;
>         u16 size;
> #else
>         u32 pagecnt_bias;
>         u32 size;
> #endif
> }
>
> The lower bits of 'va' is or'ed with the page order & pfmemalloc instead
> of offset or pagecnt_bias, so that we don't have to add more checking
> for handling the problem of not having enough space for offset or
> pagecnt_bias for PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE and 32 bits system.
> And page address & pfmemalloc & order is unchanged for the same page
> in the same 'page_frag_cache' instance, it makes sense to fit them
> together.
>
> Also, it seems it is better to replace 'offset' with 'size', which indica=
tes
> the remaining size for the cache in a 'page_frag_cache' instance, and we
> might be able to do a single 'size >=3D fragsz' checking for the case of =
cache
> being enough, which should be the fast path if we ensure size is zoro whe=
n
> 'va' =3D=3D NULL.

I'm not sure the rename to size is called for as it is going to be
confusing. Maybe something like "remaining"?

> Something like below:
>
> #define PAGE_FRAG_CACHE_ORDER_MASK      GENMASK(1, 0)
> #define PAGE_FRAG_CACHE_PFMEMALLOC_BIT  BIT(2)

The only downside is that it is ossifying things so that we can only
ever do order 3 as the maximum cache size. It might be better to do a
full 8 bytes as on x86 it would just mean accessing the low end of a
16b register. Then you can have pfmemalloc at bit 8.

> struct page_frag_cache {
>         /* page address & pfmemalloc & order */
>         void *va;
>

When you start combining things like this we normally would convert va
to an unsigned long.

> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
>         u16 pagecnt_bias;
>         u16 size;
> #else
>         u32 pagecnt_bias;
>         u32 size;
> #endif
> };
>
>
> static void *__page_frag_cache_refill(struct page_frag_cache *nc,
>                                       unsigned int fragsz, gfp_t gfp_mask=
,
>                                       unsigned int align_mask)
> {
>         gfp_t gfp =3D gfp_mask;
>         struct page *page;
>         void *va;
>
> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>         /* Ensure free_unref_page() can be used to free the page fragment=
 */
>         BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_ALLOC_COSTLY_ORDER)=
;
>
>         gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>                    __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>         page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>                                 PAGE_FRAG_CACHE_MAX_ORDER);
>         if (likely(page)) {
>                 nc->size =3D PAGE_FRAG_CACHE_MAX_SIZE - fragsz;

I wouldn't pass fragsz here. Ideally we keep this from having to get
pulled directly into the allocator and can instead treat this as a
pristine page. We can do the subtraction further down in the actual
frag alloc call.

>                 va =3D page_address(page);
>                 nc->va =3D (void *)((unsigned long)va |
>                                   PAGE_FRAG_CACHE_MAX_ORDER |
>                                   (page_is_pfmemalloc(page) ?
>                                    PAGE_FRAG_CACHE_PFMEMALLOC_BIT : 0));
>                 page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>                 nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE;
>                 return va;
>         }
> #endif
>         page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>         if (likely(page)) {
>                 nc->size =3D PAGE_SIZE - fragsz;
>                 va =3D page_address(page);
>                 nc->va =3D (void *)((unsigned long)va |
>                                   (page_is_pfmemalloc(page) ?
>                                    PAGE_FRAG_CACHE_PFMEMALLOC_BIT : 0));
>                 page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>                 nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE;
>                 return va;
>         }
>
>         nc->va =3D NULL;
>         nc->size =3D 0;
>         return NULL;
> }
>
> void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>                                  unsigned int fragsz, gfp_t gfp_mask,
>                                  unsigned int align_mask)
> {
> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>         unsigned long page_order;
> #endif
>         unsigned long page_size;
>         unsigned long size;
>         struct page *page;
>         void *va;
>
>         size =3D nc->size & align_mask;
>         va =3D nc->va;
> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>         page_order =3D (unsigned long)va & PAGE_FRAG_CACHE_ORDER_MASK;
>         page_size =3D PAGE_SIZE << page_order;
> #else
>         page_size =3D PAGE_SIZE;
> #endif

So I notice you got rid of the loops within the function. One of the
reasons for structuring it the way it was is to enable better code
caching. By unfolding the loops you are increasing the number of
instructions that have to be fetched and processed in order to
allocate the buffers.

>
>         if (unlikely(fragsz > size)) {
>                 if (unlikely(!va))
>                         return __page_frag_cache_refill(nc, fragsz, gfp_m=
ask,
>                                                         align_mask);
>
>                 /* fragsz is not supposed to be bigger than PAGE_SIZE as =
we are
>                  * allowing order 3 page allocation to fail easily under =
low
>                  * memory condition.
>                  */
>                 if (WARN_ON_ONCE(fragsz > PAGE_SIZE))
>                         return NULL;
>
>                 page =3D virt_to_page(va);
>                 if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>                         return __page_frag_cache_refill(nc, fragsz, gfp_m=
ask,
>                                                         align_mask);
>
>                 if (unlikely((unsigned long)va &
>                              PAGE_FRAG_CACHE_PFMEMALLOC_BIT)) {
>                         free_unref_page(page, compound_order(page));
>                         return __page_frag_cache_refill(nc, fragsz, gfp_m=
ask,
>                                                         align_mask);
>                 }
>
>                 /* OK, page count is 0, we can safely set it */
>                 set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>
>                 /* reset page count bias and offset to start of new frag =
*/
>                 nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
>                 size =3D page_size;
>         }
>
>         va =3D (void *)((unsigned long)va & PAGE_MASK);
>         va =3D va + (page_size - size);
>         nc->size =3D size - fragsz;
>         nc->pagecnt_bias--;
>
>         return va;
> }
> EXPORT_SYMBOL(__page_frag_alloc_va_align);
>

