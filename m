Return-Path: <linux-kernel+bounces-19136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A1882688C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B8F1C219A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D218BF3;
	Mon,  8 Jan 2024 07:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICVyQ4vv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8C8BEB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704698851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++HIVa+fUHc7mVxMPbgRezSHjTqa6qZR6U7zKUbz7Hc=;
	b=ICVyQ4vvWaweiGQQeg9cd9GTYQ0qgjJnb+zxvLHcmc+5VCVvmN80VpdO4hYiPbEfvFyjK3
	1r7mA272zVQtL4jQGMGciDza4oL1C7XLIwL97P48LpnyQN+8JA5TXTywvw7TZqIqYxVh7M
	3HT5rjWwuYN3xsybTA1XKx8sJez1VTU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-MuXJ6G9bMKqDOnSYcoDnSg-1; Mon, 08 Jan 2024 02:27:30 -0500
X-MC-Unique: MuXJ6G9bMKqDOnSYcoDnSg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28bd331cb57so744078a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 23:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704698849; x=1705303649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++HIVa+fUHc7mVxMPbgRezSHjTqa6qZR6U7zKUbz7Hc=;
        b=OasseItHmYlmthzmh5F80cVFaKhAfzHTPztM6Z7OfbHRD+yOva/AwKd3z1IQg8mhOF
         K8f5+KEaZymioXFo9SnQc2NsSlf5boYF63W7OPZ7TFCR2+DEkhxoO7LlJjdXpw8HAlms
         R2b8KO0s/As4aF1Z2O9sfsczxo6BE3tuhE3DUT3bIAU6Sy68HdrXc+wAlQkt+SJroXlh
         ljACmIb49lUsO5QPjZv0PUBQe4xlCTAdW+/ARK+8sDIN/NDR8aZX84ZaSNvfzpNJFYoC
         J2AkdaU4LvbrFIczLA/2o9buqGoZgpvo7R2pz4Laqn4yGo8ztFmIJEt25aqO2ej/hBo2
         2SKQ==
X-Gm-Message-State: AOJu0YxnzKJBjAU0BK368WGIOn9X3U9fgJGu/x1NofXbjXhbULms02Oa
	uC6qOqqwuVbTknKjr7bSFEkYUwUO46eKYJbaLvGXOM5GZHNF6dzhEB6nFFEY3MFekzB+Zp+RLBV
	zpA+yMt39Mva5G/gxT+3W7OmzWeDTmm4G
X-Received: by 2002:a05:6a20:3cab:b0:199:c866:1d46 with SMTP id b43-20020a056a203cab00b00199c8661d46mr931060pzj.6.1704698848995;
        Sun, 07 Jan 2024 23:27:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCAavyxZcZwU5CLY8vR5nixlH4bDIz/ZGJUz9tbspcbUqeK+w5R+Hs85r/f/cHobBdBUdCsQ==
X-Received: by 2002:a05:6a20:3cab:b0:199:c866:1d46 with SMTP id b43-20020a056a203cab00b00199c8661d46mr931031pzj.6.1704698848614;
        Sun, 07 Jan 2024 23:27:28 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090a8d8500b0028c2de909e4sm5617976pjo.50.2024.01.07.23.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 23:27:28 -0800 (PST)
Date: Mon, 8 Jan 2024 15:27:17 +0800
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Yang Shi <shy828301@gmail.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Mike Rapoport <rppt@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Jones <andrew.jones@linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 00/13] mm/gup: Unify hugetlb, part 2
Message-ID: <ZZuj1Q3k9hX0IlK3@x1n>
References: <20240103091423.400294-1-peterx@redhat.com>
 <591c59d6-dedb-4399-8a6f-c574fd2ad9cc@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <591c59d6-dedb-4399-8a6f-c574fd2ad9cc@csgroup.eu>

Hi, Christophe,

On Wed, Jan 03, 2024 at 11:14:54AM +0000, Christophe Leroy wrote:
> > Test Done
> > =========
> > 
> > This v1 went through the normal GUP smoke tests over different memory
> > types on archs (using VM instances): x86_64, aarch64, ppc64le.  For
> > aarch64, tested over 64KB cont_pte huge pages.  For ppc64le, tested over
> > 16MB hugepd entries (Power8 hash MMU on 4K base page size).
> > 
> 
> Can you tell how you test ?
> 
> I'm willing to test this series on powerpc 8xx (PPC32).

My apologies, for some reason I totally overlooked this email..

I only tested using run_vmtests.sh, with:

  $ bash ./run_vmtests.sh -t gup_test -a

It should cover pretty much lots of tests of GUP using gup_test program.  I
think the ones that matters here is "-H" over either "-U/-b".

For ppc8xx, even though kernel mapping uses hugepd, I don't expect anything
should change before/after this series, because the code that I touched
(slow gup only) only affects user pages, so it shouldn't change anything
over kernel mappings.  Said so, please feel free to smoke over whatever
type of kernel hugepd mappings, and I'd trust you're the expert on how to
trigger those paths.

Since I got your attention, when working on this series I talked to David
Gibson and just got to know that hugepd is actually a pure software idea.
IIUC it means there's no PPC hardware that really understands the hugepd
format at all, but only a "this is a huge page" hint for Linux.

Considering that it _seems_ to play a similar role of cont_pXX here: do you
think hugepd can have any chance to be implemented similarly like cont_pXX,
or somehow share the code?

For example, if hugepd is recognized only by Linux kernel itself, maybe
there can be some special pgtable hint that can be attached to the cont_*
entries, showing whether it's a "real cont_*" entry or a "hugepd" entry?
IIUC it can be quite flexible because if hugepd only works for hash MMU so
no hardware will even walk that radix table.  But I can overlook important
things here.

It'll be definitely great if hugepd can be merged into some existing forms
like a generic pgtable (IMHO cont_* is such case: it's the same as no
cont_* entries for softwares, while hardware can accelerate with TLB hits
on larger ranges).  But I can be asking a very silly question here too, as
I can overlook very important things.

Thanks,

-- 
Peter Xu


