Return-Path: <linux-kernel+bounces-6260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C357819674
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6DC1F26393
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AB56FA9;
	Wed, 20 Dec 2023 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diGvaTyW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393286101
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703036608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vjm4paNMTWlCFosQbpjmCNgYAmudj3J1TP/uI6GNhCE=;
	b=diGvaTyW6XeuU1GaY0AmpaXnCpqQvj/F25/3wbmtu8O1iQEiX2qDOJ8P37f++ny6GTH8AP
	RxuKl03fDc2v4J27hA9O3nfyP36XtpaJ83vzTh4dF4RaaGdPkTB1D5HRLJ5LMsql28f+zy
	Hgt+WhrNxVWRlHblLX2rij+ylH3ord8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-E_6KYQtFPiazGAROpKh46A-1; Tue, 19 Dec 2023 20:43:26 -0500
X-MC-Unique: E_6KYQtFPiazGAROpKh46A-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6d2fbfb1d5eso1239035b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703036605; x=1703641405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vjm4paNMTWlCFosQbpjmCNgYAmudj3J1TP/uI6GNhCE=;
        b=fnsHCb9Jy+A3LqckRIbsSzR7PFXkh7+SCoJMMRqxNUgSp6XM9bf1oXmJG/6QWSLPfy
         D29yAkb9xkogtvbsN/A1zB6St/OKYBxghcvUwuu2tbHPSUwiACXycz6crQhDGJGDOap6
         nMfJtPYnWu8EUgoHMMQ0PMcmLzeelXUwos4hFabeeA7jXcgyY13Tfwz/8+lG1MUOiFoS
         81vMs1ONHBTexkmuriIWgcLI6NJwfuMg5RLbGxKhfAlI7M670+Y4CUkSv83YN0CnRI4p
         lsXpbz11nSycBnhj9UEiBtm7ec9i/ob5SyaMttpsfrL0tY6jJhOgSc6kMZmXlu9A6ZAo
         2OLg==
X-Gm-Message-State: AOJu0YxicPakKPbNktud7AMNFtlhNMUk7TeqmQNW6BCIAZM15LNliCNC
	knGUo92JhIafoTsfiZwf+MCTTAxA22bPBWvpN1vkqGtqOLUWph1yf81o7i02aiCasXAuryKixyT
	C4Dwzii41p+xXFO90Z4ZyDPn4
X-Received: by 2002:aa7:9315:0:b0:6d9:383b:d91a with SMTP id cz21-20020aa79315000000b006d9383bd91amr3546106pfb.1.1703036605331;
        Tue, 19 Dec 2023 17:43:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjZoAHkiq7HghdaqdRhR063HFqKc6lsGbuFn9XpaDzkEyDZOV38MaudRUa/eRKBEBtF5qDgg==
X-Received: by 2002:aa7:9315:0:b0:6d9:383b:d91a with SMTP id cz21-20020aa79315000000b006d9383bd91amr3546076pfb.1.1703036604916;
        Tue, 19 Dec 2023 17:43:24 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fe16-20020a056a002f1000b006d3dd365a76sm6585222pfb.2.2023.12.19.17.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 17:43:24 -0800 (PST)
Date: Wed, 20 Dec 2023 09:43:13 +0800
From: Peter Xu <peterx@redhat.com>
To: James Houghton <jthoughton@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org, Rik van Riel <riel@surriel.com>,
	linux-riscv@lists.infradead.org, Yang Shi <shy828301@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 09/13] mm/gup: Cache *pudp in follow_pud_mask()
Message-ID: <ZYJGsUWpmF1P1Nd0@x1n>
References: <20231219075538.414708-1-peterx@redhat.com>
 <20231219075538.414708-10-peterx@redhat.com>
 <CADrL8HVu8=-DdAwXN_pO91g1A1+F7bKfBRpm6jYfYMk1QZcRFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HVu8=-DdAwXN_pO91g1A1+F7bKfBRpm6jYfYMk1QZcRFA@mail.gmail.com>

On Tue, Dec 19, 2023 at 11:28:54AM -0500, James Houghton wrote:
> On Tue, Dec 19, 2023 at 2:57 AM <peterx@redhat.com> wrote:
> >
> > From: Peter Xu <peterx@redhat.com>
> >
> > Introduce "pud_t pud" in the function, so the code won't dereference *pudp
> > multiple time.  Not only because that looks less straightforward, but also
> > because if the dereference really happened, it's not clear whether there
> > can be race to see different *pudp values if it's being modified at the
> > same time.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/gup.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 6c0d82fa8cc7..97e87b7a15c3 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -753,26 +753,27 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
> >                                     unsigned int flags,
> >                                     struct follow_page_context *ctx)
> >  {
> > -       pud_t *pud;
> > +       pud_t *pudp, pud;
> >         spinlock_t *ptl;
> >         struct page *page;
> >         struct mm_struct *mm = vma->vm_mm;
> >
> > -       pud = pud_offset(p4dp, address);
> > -       if (pud_none(*pud))
> > +       pudp = pud_offset(p4dp, address);
> > +       pud = *pudp;
> 
> I think you might want a READ_ONCE() on this so that the compiler
> doesn't actually read the pud multiple times.

Makes sense.  I probably only did the "split" part which Christoph
requested, without thinking futher than that. :)

> 
> > +       if (pud_none(pud))
> >                 return no_page_table(vma, flags, address);
> > -       if (pud_devmap(*pud)) {
> > -               ptl = pud_lock(mm, pud);
> > -               page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
> > +       if (pud_devmap(pud)) {
> > +               ptl = pud_lock(mm, pudp);
> > +               page = follow_devmap_pud(vma, address, pudp, flags, &ctx->pgmap);
> >                 spin_unlock(ptl);
> >                 if (page)
> >                         return page;
> >                 return no_page_table(vma, flags, address);
> >         }
> > -       if (unlikely(pud_bad(*pud)))
> > +       if (unlikely(pud_bad(pud)))
> >                 return no_page_table(vma, flags, address);
> 
> Not your change, but reading this, it's not clear to me that
> `pud_present(*pudp)` (and non-leaf) would necessarily be true at this
> point -- like, I would prefer to see `!pud_present(pud)` instead of
> `pud_bad()`. Thank you for adding that in the next patch. :)

I think the assumption here is it is expected to be a directory entry when
reaching here, and for a valid directory entry pud_present() should always
return true (a side note: pud_present() may not mean "PRESENT bit set", see
m68k's implementation for example).

Yeah I added that in the next patch, my intention was to check
!pud_present() for all cases without the need to take pgtable lock, though.

> 
> Feel free to add:
> 
> Acked-by: James Houghton <jthoughton@google.com>

Thanks,

-- 
Peter Xu


