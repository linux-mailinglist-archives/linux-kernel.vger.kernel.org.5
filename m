Return-Path: <linux-kernel+bounces-14055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E5782176C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB7D282286
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909BD28F6;
	Tue,  2 Jan 2024 05:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dq8FNNmO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491812574
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704173858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCnGZSmn0Xbft/VvC3w27VmkfIRRQMc7XVfvoJNmfHo=;
	b=Dq8FNNmOnV48ZkdI9nIP8ZaEECWQWJJPsSsTjcWCFWAYYdRYbtMlGXp4tHUWi+FhbqWx1k
	z+n24TLq8OyU160IYIOqiYNJgGoPJoFQlfZaLmqa9Gx2MA4kex5l7z925JNvprPY7rzCh/
	nEJNSBM00vBlK2S4GPoZOZXHVhYglx8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-NyMTX97DNN2BYlz5lYB9pw-1; Tue, 02 Jan 2024 00:37:32 -0500
X-MC-Unique: NyMTX97DNN2BYlz5lYB9pw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28bea0ff98cso2090990a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704173851; x=1704778651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCnGZSmn0Xbft/VvC3w27VmkfIRRQMc7XVfvoJNmfHo=;
        b=QzIM+EbVM3sAITPT5RCb2V/EiX4fFIZoB44V4IW6s21rJ8YpYbIyTy0g/905h7x0/R
         LmPFuEnohH6ZpafJDJyTdRch0AulC3D6w2V6fBq65dA1io8J8IUpjnwG2tQQpf3FLlSm
         ix9OW9Ljx55O1EpgCTLvcHoPmK0Stxq3tjnVKVJnXoTHnIxLiJ3Lpk/9reYLz5+vDcWa
         dgCUrr1t1vK7plDDwtkgA5iBkNKcBVQJs1UsE7vl/YGD0xeG+/IGWaMXTFANyv+kQfeP
         gxhfPcP79P10fDf05fBVBlpL83y15ThyCXwBsh13SMo1qKJwC/XYAHw9QpXtSwJE3ulk
         o10Q==
X-Gm-Message-State: AOJu0YxAoMhd50VN2JXgLNfnfXY3lpRhCZz9KeBxIJCdiml9w0R1JRFf
	AkpKMlaUDPV0JSBvpPQECmJjs6kOtoe13933oMFtwz4EoSg44IvV1gnSWPRgzgBOFts0o657Vok
	9I6Rb62ww6cKyV9QzF6k5c8nthPxCWw2r
X-Received: by 2002:a17:902:ce86:b0:1d3:eecd:b296 with SMTP id f6-20020a170902ce8600b001d3eecdb296mr33590830plg.6.1704173851407;
        Mon, 01 Jan 2024 21:37:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHENzr2M0aJyyZm2vt3XzuVCeWLevZs5IuWsUdjc1ZzU9FWxHr/jzg4D3MMktI1x4ptpcHyFg==
X-Received: by 2002:a17:902:ce86:b0:1d3:eecd:b296 with SMTP id f6-20020a170902ce8600b001d3eecdb296mr33590810plg.6.1704173851161;
        Mon, 01 Jan 2024 21:37:31 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090331c400b001d49c0daf60sm6900347ple.265.2024.01.01.21.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:37:30 -0800 (PST)
Date: Tue, 2 Jan 2024 13:37:14 +0800
From: Peter Xu <peterx@redhat.com>
To: Muchun Song <muchun.song@linux.dev>
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
	James Houghton <jthoughton@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 03/13] mm: Provide generic pmd_thp_or_huge()
Message-ID: <ZZOhCuuozrBscdRC@x1n>
References: <20231219075538.414708-1-peterx@redhat.com>
 <20231219075538.414708-4-peterx@redhat.com>
 <135b3189-f459-4b57-9861-bb8acb999d91@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <135b3189-f459-4b57-9861-bb8acb999d91@linux.dev>

On Mon, Dec 25, 2023 at 02:29:53PM +0800, Muchun Song wrote:
> > @@ -1355,6 +1355,10 @@ static inline int pmd_write(pmd_t pmd)
> >   #endif /* pmd_write */
> >   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > +#ifndef pmd_thp_or_huge
> 
> I think it may be the time to rename to pmd_thp_or_hugetlb,
> the "huge" is really confusing. thp is not huge? Actually,
> it is huge. It is better to make it more specific from now on, like
> "hugetlb".

The rename will need to touch ARM code, which I wanted to avoid, see:

arch/arm64/include/asm/pgtable.h:#define pmd_thp_or_huge(pmd)   (pmd_huge(pmd) || pmd_trans_huge(pmd))

So far this series only touches generic code.  Would you mind I keep this
patch as-is, and leave renaming to later?

> 
> BTW, please cc me via the new email (muchun.song@linux.dev) next edition.

Sure.  Thanks for taking a look.

-- 
Peter Xu


