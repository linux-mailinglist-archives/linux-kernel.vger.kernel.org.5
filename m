Return-Path: <linux-kernel+bounces-4003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC40E81768A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475671C22CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E242349895;
	Mon, 18 Dec 2023 15:59:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCF2E57C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 935F72F4;
	Mon, 18 Dec 2023 07:59:45 -0800 (PST)
Received: from [10.57.75.230] (unknown [10.57.75.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A7E53F5A1;
	Mon, 18 Dec 2023 07:58:59 -0800 (PST)
Message-ID: <01dac739-ad20-44bf-8280-5c3595773837@arm.com>
Date: Mon, 18 Dec 2023 15:58:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/39] mm/migrate: page_add_file_rmap() ->
 folio_add_file_rmap_pte()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-11-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231211155652.131054-11-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2023 15:56, David Hildenbrand wrote:
> Let's convert remove_migration_pte().
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index de9d94b99ab7..efc19f53b05e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -262,7 +262,7 @@ static bool remove_migration_pte(struct folio *folio,
>  				page_add_anon_rmap(new, vma, pvmw.address,
>  						   rmap_flags);
>  			else
> -				page_add_file_rmap(new, vma, false);
> +				folio_add_file_rmap_pte(folio, new, vma);
>  			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
>  		}
>  		if (vma->vm_flags & VM_LOCKED)


