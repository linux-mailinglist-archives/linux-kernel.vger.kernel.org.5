Return-Path: <linux-kernel+bounces-80918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64D7866E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151451C23C18
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A6E51C46;
	Mon, 26 Feb 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikUJzs2o"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ADA4F61C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936645; cv=none; b=uOyT2IrcYoJI4v8X3tX2POG1j3o1AIAcJm9/LDESjk1sQhJMe6IhxGEDqGPtjY86k7bjOZHJdKpQiwc8OIUdf2iz4I8b142QfoWprSXo76k2qX/Iio67mrRwX4SaIxFEa7VfNc3wnJ99nr4ey860eX6uirYVHZ4x7gHwsIBOmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936645; c=relaxed/simple;
	bh=Gr+T58Zh48qA+jtZmWx0Vis3HMAq2VC+JICII0pVHjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjunwkyAg7CWv54Mkqe1DWf5kOju9MNBS9qFXgdvKyMLI8WhB628ALVrPAc26fKo88Nucp60DtQlGvOJ+t80aEVtCOWlYJdrza+lYH7Jy1eiRUXQ4k/ERqJVaOlkMe6zDo2fLns3vx5i8Pu9jcWAhVfd29+ytVTc+WIzlij91YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikUJzs2o; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd72353d9fso1881186b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708936642; x=1709541442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCF/aSx//6Xp/J5AVRDOXx1snfpNyCHhXSfd5XU/Gpw=;
        b=ikUJzs2omU9egGcueHE2DhaJ/UkX5gmo/sBbbCw38pFeiTiJSDCTvAUCiJc0sN4Uwa
         0U82Pu5SJo03J+sahGWxP1MDZK5lZdGv2a5DOx+mox7gt/8J0cHjk38tr9/O0g6miZYi
         1aQG6QjYivznOGObGcd8jC0YZXSimRkOqYiuKEkm2e4PAxS7T0VH2G1Q7th2G0POPc/B
         k77PVvtqPtNq5ogfBjHXEyr5ZetkIvtbAM9ljzT/1zfjs/675cxiaMJn6uwhP5GO8Se/
         cxI/T0WutJ/csQZvfQCrQvb0QiQ5WVk7FUvHJiM4XkC19wVUyXqPj0NBpSk19lhUD6sT
         K64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936642; x=1709541442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCF/aSx//6Xp/J5AVRDOXx1snfpNyCHhXSfd5XU/Gpw=;
        b=jEpTUpTsttpYNwmEqrt1a1uFrGJJpjpy60HmOQl61Es8I6E2elSC/VDlZJ1Alk2FcJ
         C6uQsWOePu1hdUNB2uYkyp8FOE+UDmsztqn5svSBxrKxkr28BEyySdt1XRL6dpPDndnH
         yvjrpHPN0Qfp7u/d6JM8W4z97D/jE6aO5Zl220aSVirosssf8Gbybe9hCFqygptY3vnw
         BWF5KzoK+QHQURKWJxHOenEPcRR3QSelsLje5zPmlj0mKN0YCqi/WDX4W28BzLdKN5NE
         RHBUkhlVKnJsv9/rMDCAI+HF8DousdX7xkDZYcL4Y83iswcYxAqoUOXP3gOPT+MGNC4A
         lBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI1DiHZduZz7fign10vDpJy7GTcgJOuDqcIGIBTN14LsMcQiAs/XE8e9zw6e7p5Y9hfkutlIBJEGGA2TPlSbD2cvbxAg1v+3/2v7YK
X-Gm-Message-State: AOJu0Yz0y3p+bjDl9C2ieqKa5nww6GXRJ1n+FMkYMBCaWzkeRyGLNGqv
	XePOP2EsCKqx0BS0B5ouXlNUMukWpe6VF1l+Hxv8PDggTzO2kVqR
X-Google-Smtp-Source: AGHT+IEiA2ApdBnCUs64epb1lN7FXFCqRB5g7ItE4oAr7lRYDlq7uFBqz+gfICk8iLjOF4Cx8Zc6Mg==
X-Received: by 2002:a05:6808:2014:b0:3bf:db6a:7614 with SMTP id q20-20020a056808201400b003bfdb6a7614mr8861753oiw.42.1708936642635;
        Mon, 26 Feb 2024 00:37:22 -0800 (PST)
Received: from LancedeMBP.lan ([112.10.225.117])
        by smtp.gmail.com with ESMTPSA id l2-20020a056a00140200b006e4e93f4f17sm3479647pfu.117.2024.02.26.00.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:37:22 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: 21cnbao@gmail.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	minchan@kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	songmuchun@bytedance.com,
	wangkefeng.wang@huawei.com,
	zokeefe@google.com,
	fengwei.yin@intel.com
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
Date: Mon, 26 Feb 2024 16:37:14 +0800
Message-Id: <20240226083714.26187-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Barry,

Thanks for taking time to review!

On Mon, Feb 26, 2024 at 12:00 PM Barry Song <21cnbao@gmail.com> wrote:
[...]
> On Mon, Feb 26, 2024 at 1:33 AM Lance Yang <ioworker0@gmail.com> wrote:
[...]
> We did something similar on MADV_PAGEOUT[1]
> [1] https://lore.kernel.org/linux-mm/20240118111036.72641-7-21cnbao@gmail.com/

Thanks for providing the link above.

[...]
> > +                        * Avoid unnecessary folio splitting if the large
> > +                        * folio is entirely within the given range.
> > +                        */
> > +                       folio_test_clear_dirty(folio);
> > +                       folio_unlock(folio);
> > +                       for (; addr != next_addr; pte++, addr += PAGE_SIZE) {
> > +                               ptent = ptep_get(pte);
> > +                               if (pte_young(ptent) || pte_dirty(ptent)) {
> > +                                       ptent = ptep_get_and_clear_full(
> > +                                               mm, addr, pte, tlb->fullmm);
> > +                                       ptent = pte_mkold(ptent);
> > +                                       ptent = pte_mkclean(ptent);
> > +                                       set_pte_at(mm, addr, pte, ptent);
> > +                                       tlb_remove_tlb_entry(tlb, pte, addr);
> > +                               }
>
> The code works under the assumption the large folio is entirely mapped
> in all PTEs in the range. This is not always true.
>
> This won't work in some cases as some PTEs might be mapping to the
> large folios. some others might have been unmapped or mapped
> to different folios.
>
> so in MADV_PAGEOUT, we have a function to check the folio is
> really entirely mapped:
>
> +static inline bool pte_range_cont_mapped(unsigned long start_pfn,
> + pte_t *start_pte, unsigned long start_addr, int nr)
> +{
> +              int i;
> +              pte_t pte_val;
> +
> +              for (i = 0; i < nr; i++) {
> +                           pte_val = ptep_get(start_pte + i);
> +
> +                           if (pte_none(pte_val))
> +                                        return false;
> +
> +                           if (pte_pfn(pte_val) != (start_pfn + i))
> +                                        return false;
> +              }
> +
> +              return true;
> +}

Thanks for providing the information; it's very helpful to me!
I made some changes. Would you mind taking another look, please?

As a diff against this patch.

diff --git a/mm/madvise.c b/mm/madvise.c
index bcbf56595a2e..255d2f329be4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -616,6 +616,18 @@ static long madvise_pageout(struct vm_area_struct *vma,
 	return 0;
 }
 
+static inline bool pte_range_cont_mapped(pte_t *pte, unsigned long nr)
+{
+	pte_t pte_val;
+	unsigned long pfn = pte_pfn(pte);
+	for (int i = 0; i < nr; i++) {
+		pte_val = ptep_get(pte + i);
+		if (pte_none(pte_val) || pte_pfn(pte_val) != (pfn + i))
+			return false;
+	}
+	return true;
+}
+
 static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 
@@ -676,20 +688,25 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		 */
 		if (folio_test_large(folio)) {
 			int err;
-			unsigned long next_addr, align;
+			unsigned long nr, next_addr, align;
 
 			if (folio_estimated_sharers(folio) != 1 ||
 			    !folio_trylock(folio))
 				goto skip_large_folio;
 
-			align = folio_nr_pages(folio) * PAGE_SIZE;
+			nr = folio_nr_pages(folio);
+			align = nr * PAGE_SIZE;
 			next_addr = ALIGN_DOWN(addr + align, align);
 
 			/*
-			 * If we mark only the subpages as lazyfree,
-			 * split the large folio.
+			 * If we mark only the subpages as lazyfree, or
+			 * if there is a cow folio associated with this folio,
+			 * or if this folio is not really entirely mapped,
+			 * then split the large folio.
 			 */
-			if (next_addr > end || next_addr - addr != align)
+			if (next_addr > end || next_addr - addr != align ||
+			    folio_total_mapcount(folio) != nr ||
+			    pte_range_cont_mapped(pte, nr))
 				goto split_large_folio;
 
 			/*
---

Thanks again for your time!

Best,
Lance

