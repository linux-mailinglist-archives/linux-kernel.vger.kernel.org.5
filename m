Return-Path: <linux-kernel+bounces-128834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FC389603A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C33B22FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4D8487BE;
	Tue,  2 Apr 2024 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SernlilP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F9208B6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100953; cv=none; b=Ji7+SB1l4lit82cm/kplZWkJSCF3/zhMpPpRPfz6qBnW5NA3CtHN6RTiQYSe7Hfk5EtigdN8an+u0h5lvsI1hYbCcI86P2ty3Q0RItXxITwGT0PnP4hVVK/akRUP2a+oQykAVsz4kgVgtkXrR/oAdQMDdTbY0LfeCoSOlpV4wfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100953; c=relaxed/simple;
	bh=dCoRqma6yqwIrFc2Ju/9ocy+ca8jMOV5zqLtsYm4O98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5pLASKpV+QzEwKoWmrDij3miwGh/0SBQKuQsSTYdJh07FeAtwyK5SXTiXA3SwsH7hxwID8PXOMkzOATUWqnDXFxbf0JPepRjrMttrZlyl6W40jndhXowva8YJzH011jhnVWJ7GBGGOrwvVaYQeed4wzZ63GBP3mg0KevGN/1o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SernlilP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712100951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HP6iCpNSGY021srGiNxOfFS1yawEzwYl7dLs1n/YW+Y=;
	b=SernlilPx0ivm1TcTtzb7+vEpxjwHEyJDuDBqj8+JyXykNsdXTQ+HHACBTxSxQ11VzxUqg
	jMuV5q7ipH+LXIHpJd2lJTYx1H59Z9EHIpua3K+zyajwImDVX1FQE30CKeZ9C+Rah+Uo9E
	gk69vgrtq6qhJefGuiVsjjtP3HkkVbM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-Iy4ky1w-MWCd6zocw9lK8Q-1; Tue, 02 Apr 2024 19:35:50 -0400
X-MC-Unique: Iy4ky1w-MWCd6zocw9lK8Q-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6e6cb8055b8so1936328a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 16:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712100949; x=1712705749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HP6iCpNSGY021srGiNxOfFS1yawEzwYl7dLs1n/YW+Y=;
        b=Z9nRAUnQo+e02+TYWjgawM88xopFDyKyym7a3zbg4F8OboLKbAaElBcmFt+Z6Iv1Cu
         RGWeYJmRsZv7r/Ltuu8Z5mM7PeWC06pIrQZVzImKVaTDj9gHuxIz+DvAS/76eKkev/vO
         BNvDpCnyruuMQEdzBhQcN6n0+9Jd8zPn0PnYyOx2yA5ug4nz0mjJKngtjY6R6JEtH/do
         EujFyGloCLn/iFdFSsqbnd06LUIl6tHaubM9qigdvsqevFb8gGBEzHy4+lr7WjT5esed
         3g6FIPMJ6Lae+Uc7YpWjzYMLEixVxciyUMvoXoqhuRVLNYvk2Vz0QDK5oZ/3YNGBSnGw
         8X1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoOMVIkDSi9I6k6i0dLK/tIL7tsKlB/ZSbH0Lk0PJFEMBJaIBGnQcDW7RSEECb4gaFxoj/ITX0VdYLKzSyYZXNEJk7TgtPTqjY6IEZ
X-Gm-Message-State: AOJu0YyTmahq96pSOETJUYMdklnacRTCnvkywYQPtb3f4Sxq8GdTcAQx
	Oz28bdPhdoXDtaoYN8kudoMPewFT/7kLbIQvywLX9wlkFCsKz0/NHY1D2RuUTqorrWtWxNpWiHY
	QtDUT9jT4T/0++zAUAi46rcNttBDO6HmgVJUcnnnJgi1tAzaSJ7/8f0JCovq+Sg==
X-Received: by 2002:a9d:4c86:0:b0:6e7:7ef6:10da with SMTP id m6-20020a9d4c86000000b006e77ef610damr13684097otf.1.1712100949125;
        Tue, 02 Apr 2024 16:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvGEFvbrAiLdQh8lUIUnqC+uQoSnGXUScHs/S+SFU0VVogBN2f5CbF/OzNKGljOo4S/t2faA==
X-Received: by 2002:a9d:4c86:0:b0:6e7:7ef6:10da with SMTP id m6-20020a9d4c86000000b006e77ef610damr13684059otf.1.1712100948622;
        Tue, 02 Apr 2024 16:35:48 -0700 (PDT)
Received: from xz-m1.local ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id ob12-20020a0562142f8c00b0069046d929a3sm5893803qvb.145.2024.04.02.16.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 16:35:48 -0700 (PDT)
Date: Tue, 2 Apr 2024 19:35:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 05/13] mm/arch: Provide pud_pfn() fallback
Message-ID: <ZgyWUYVdUsAiXCC4@xz-m1.local>
References: <20240327152332.950956-1-peterx@redhat.com>
 <20240327152332.950956-6-peterx@redhat.com>
 <20240402190549.GA706730@dev-arch.thelio-3990X>
 <ZgyKLLVZ4vN56uZE@x1n>
 <20240402225320.GU946323@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240402225320.GU946323@nvidia.com>

On Tue, Apr 02, 2024 at 07:53:20PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 02, 2024 at 06:43:56PM -0400, Peter Xu wrote:
> 
> > I actually tested this without hitting the issue (even though I didn't
> > mention it in the cover letter..).  I re-kicked the build test, it turns
> > out my "make alldefconfig" on loongarch will generate a config with both
> > HUGETLB=n && THP=n, while arch/loongarch/configs/loongson3_defconfig has
> > THP=y (which I assume was the one above build used).  I didn't further
> > check how "make alldefconfig" generated the config; a bit surprising that
> > it didn't fetch from there.
> 
> I suspect it is weird compiler variations.. Maybe something is not
> being inlined.
> 
> > (and it also surprises me that this BUILD_BUG can trigger.. I used to try
> >  triggering it elsewhere but failed..)
> 
> As the pud_leaf() == FALSE should result in the BUILD_BUG never being
> called and the optimizer removing it.

Good point, for some reason loongarch defined pud_leaf() without defining
pud_pfn(), which does look strange.

#define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)

But I noticed at least MIPS also does it..  Logically I think one arch
should define either none of both.

> 
> Perhaps the issue is that the pud_leaf() is too far from the pud_pfn?

My understanding is follow_pud_mask() should completely get optimized and
follow_huge_pud() will be dropped in the compiler output if pud_leaf()==false.

Thanks,

-- 
Peter Xu


