Return-Path: <linux-kernel+bounces-154414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB198ADBCC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4571C21217
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987191757E;
	Tue, 23 Apr 2024 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rVhOOc49"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A9B171A4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713838102; cv=none; b=VEvt86JYm8afbf/eqF1ElMm23A/vx/1oTckNw3lnhO4PEkAvk4+d8PbIGBzGJNlj+F2qJOs2rI9kpEX5VGDfmPN0+LjaFARN2eDtQDubDyUY8FNtof4pwS/pjLBuAYNjyvTwDVVScy2VjegQHvkfAZ0oeGvJ3gD4YKwL6p5qaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713838102; c=relaxed/simple;
	bh=cwzx2c1RdbSzHJPOZaM3YD22K1SuePF0SZcDVWEHT+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFolQvU7X8DTEhHng15EUj0e+wF/oGB4wT6KMAThse5m5ghYe5j7lkfA1NFnzA2jhK2yFV1IrnQS2RflM44gsX2d7qdpmhnTe2C1Qwtdd77/Jvq1asAvVeonOfAxhCh3rkAqdGR8xE6uLfegqtKCyp7Hn1vvB4chDUiPQgd73jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rVhOOc49; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713838090; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JQs1c1jzpb91mhq216H2pWWxZ2UC8kVx2WWVmJ8vFXQ=;
	b=rVhOOc490kP5Ud23BeFhtErXHoQ1MS/tzJcAmoCpQCNRzWxOwQSG91ofmYcNb9ORJiKMIp6xi9FyTRlYk2vmONortCY6KCFFLAQTfV5nJ40ebwVKukVVRfWR5vHnkCkUeMI20V1FSWym7OlmaAt3T31wt9bdNlLPEm1xq1GhUDk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W57ATDw_1713838087;
Received: from 30.97.56.65(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W57ATDw_1713838087)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 10:08:09 +0800
Message-ID: <7380659d-4aa4-4214-abe9-48fb7f1abd00@linux.alibaba.com>
Date: Tue, 23 Apr 2024 10:08:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/huge_memory: improve
 split_huge_page_to_list_to_order() return value documentation
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
References: <20240422194217.442933-1-david@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240422194217.442933-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/23 03:42, David Hildenbrand wrote:
> The documentation is wrong and relying on it almost resulted in BUGs in
> new callers: ever since fd4a7ac32918 ("mm: migrate: try again
> if THP split is failed due to page refcnt") we return -EAGAIN on
> unexpected folio references, not -EBUSY.
> 
> Let's fix that and also document which other return values we can
> currently see and why they could happen.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2:
> * Also document concurrent removal from the page cache (likely we should
>    return -EBUSY -- but likely it doesn't really matter).
> * Reference fd4a7ac32918 in patch description
> 
> ---
>   mm/huge_memory.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ee12726291f1b..a7406267323ed 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2956,7 +2956,7 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
>    *
>    * 3) The folio must not be pinned. Any unexpected folio references, including
>    *    GUP pins, will result in the folio not getting split; instead, the caller
> - *    will receive an -EBUSY.
> + *    will receive an -EAGAIN.
>    *
>    * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
>    *    supported for non-file-backed folios, because folio->_deferred_list, which
> @@ -2975,8 +2975,16 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
>    *
>    * Returns 0 if the huge page was split successfully.
>    *
> - * Returns -EBUSY if @page's folio is pinned, or if the anon_vma disappeared
> - * from under us.
> + * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
> + * the folio was concurrently removed from the page cache.
> + *
> + * Returns -EBUSY when trying to split the huge zeropage, if the folio is
> + * under writeback, if fs-specific folio metadata cannot currently be
> + * released, or if some unexpected race happened (e.g., anon VMA disappeared,
> + * truncation).
> + *
> + * Returns -EINVAL when trying to split to an order that is incompatible
> + * with the folio. Splitting to order 0 is compatible with all folios.
>    */
>   int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   				     unsigned int new_order)

LGTM. Thanks for fixing the document that I missed:)
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

