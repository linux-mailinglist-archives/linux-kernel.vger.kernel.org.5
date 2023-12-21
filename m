Return-Path: <linux-kernel+bounces-7870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D5381AE82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2511C22F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10D8BA4B;
	Thu, 21 Dec 2023 05:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V1Sdgytx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CCABA30
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703137659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoopr+ccNsQyXfz/YUalVeZvDB+jSnnz+aOkdBpWeU0=;
	b=V1Sdgytx1Nwd2uNmlTnQaQ+xhip20uNc/DB/VFV6TjM1CbAernGsYjcKqpbioQHmELDDvz
	vWexG8icTH1CE/sFCW1/irRY6i/mDg/oa7Pz/wz9L3LL2roWytU5ZslpeYJlI2mMh+Iqcr
	uuI5N17JNexTHXbTozmaub+p5p7jPoo=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 04/40] mm/rmap: introduce and use
 hugetlb_try_dup_anon_rmap()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231220224504.646757-5-david@redhat.com>
Date: Thu, 21 Dec 2023 13:47:01 +0800
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Peter Xu <peterx@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <7A77CCE2-92F1-47D5-BCCC-C520210ED3EF@linux.dev>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-5-david@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Dec 21, 2023, at 06:44, David Hildenbrand <david@redhat.com> wrote:
> 
> hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
> For example, hugetlb currently only supports entire mappings, and treats
> any mapping as mapped using a single "logical PTE". Let's move it out
> of the way so we can overhaul our "ordinary" rmap.
> implementation/interface.
> 
> So let's introduce and use hugetlb_try_dup_anon_rmap() to make all
> hugetlb handling use dedicated hugetlb_* rmap functions.
> 
> Add sanity checks that we end up with the right folios in the right
> functions.
> 
> Note that is_device_private_page() does not apply to hugetlb.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

