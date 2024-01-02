Return-Path: <linux-kernel+bounces-14082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B95EA8217B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D9F1F21CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F232101;
	Tue,  2 Jan 2024 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qmR26i0D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9B1879
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704177036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jogtFHqhtts+BmygiI65vHy3Sj9utOue/9xvsVCOd+4=;
	b=qmR26i0D49H8PdwABxnbTA/6T904fWdmEzd6KXl0wQjHSIy3X5dP4pqW+94RX26mni1cHM
	zLdOEu9mc1bcFwLhhpZo4RoOBAfeSKwJqgOB6pBH35ufB+EB7ejL7hIrrJnPQxw9YsHs3+
	RCHR/4odGFPxiCJ2mnjlJCWZAb9aI3E=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 05/13] mm: Introduce vma_pgtable_walk_{begin|end}()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ZZOhlB-KK4hF3PgY@x1n>
Date: Tue, 2 Jan 2024 14:29:56 +0800
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
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
 linuxppc-dev@lists.ozlabs.org,
 Rik van Riel <riel@surriel.com>,
 linux-riscv@lists.infradead.org,
 Yang Shi <shy828301@gmail.com>,
 James Houghton <jthoughton@google.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Axel Rasmussen <axelrasmussen@google.com>
Content-Transfer-Encoding: 7bit
Message-Id: <B82206E4-2C43-40EE-8337-0DC9FF37F7E9@linux.dev>
References: <20231219075538.414708-1-peterx@redhat.com>
 <20231219075538.414708-6-peterx@redhat.com>
 <0D9E28F4-AFA8-479C-8311-093DAFD9DF41@linux.dev> <ZZOhlB-KK4hF3PgY@x1n>
To: Peter Xu <peterx@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Jan 2, 2024, at 13:39, Peter Xu <peterx@redhat.com> wrote:
> 
> On Mon, Dec 25, 2023 at 02:34:48PM +0800, Muchun Song wrote:
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 
> You're using the old email address here.  Do you want me to also use the
> linux.dev one that you suggested me to use?

Either is OK for the RB tag.

> 
> -- 
> Peter Xu
> 


