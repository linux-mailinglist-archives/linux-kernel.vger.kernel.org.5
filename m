Return-Path: <linux-kernel+bounces-77693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7928860911
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF9A285B05
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FB3BE66;
	Fri, 23 Feb 2024 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JFYy3VQW"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC68BF3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657014; cv=none; b=VVMDpTp7N/CspX8wA4wVhWvMNdJ6O0NA+Jyf9BV2xhGt0fJP7+N0nsZsihu4Sy0/G/394pErOqZKS2XMoxJA1ijIsF0Ql6YYIjKJDPgjAMFZWvDr3bNO/M8oX30Vfjogkb6dSNfJgU9ok7/uv6BS2vxW2P3qE1YYIt70KGaQDNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657014; c=relaxed/simple;
	bh=AsQe8YHFakY+W7qziBagNIwO3Xi1BaBkuNhXCvDFN1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihlo/k+t4YwA7iTh3gB/1QN2pjrCk5VT23IyWQNGHo1Ha8se7B7g2IUHekH3w9SYsqKfkH6tiKytPjjIaLXaTAjDtOBiHdyjDEevyqGi23lSmygVfQHDSYxNGoySoP3sSp1YyJ8AfYYJjv4e9wfuvL6jvNx643lKhylTlYfaReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JFYy3VQW; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708657010; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8Gbmb7+SsvWd9sjeydPNyaYMmZF329Ozpf1CxFHjYyk=;
	b=JFYy3VQW/mM7F56rbcbzK3Ft1bygNtXdZQw1gmx9/fm22/RTR70j2+4Au9QadtLzMHn4CjRsk2c31wW/sU7XwLCOg/t2Ev21NUyhinTw3Y0TNVMlm/YF2V1bHy/YTu6B+CBq5UoV+N/aNiFeO/yMmnHHE0djtrRJymnEELRTCZw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W12cKo1_1708657008;
Received: from 30.97.56.55(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W12cKo1_1708657008)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 10:56:49 +0800
Message-ID: <0a06dc7f-3a49-42ba-8221-0b4a3777ac0b@linux.alibaba.com>
Date: Fri, 23 Feb 2024 10:56:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] mm: hugetlb: make the hugetlb migration strategy
 consistent
To: Oscar Salvador <osalvador@suse.de>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
 linmiaohe@huawei.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1708507022.git.baolin.wang@linux.alibaba.com>
 <0514e5139b17ecf3cd9e09d86c93e586c56688dc.1708507022.git.baolin.wang@linux.alibaba.com>
 <ZdfHi142dvQuN7B-@localhost.localdomain>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZdfHi142dvQuN7B-@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/23 06:15, Oscar Salvador wrote:
> On Wed, Feb 21, 2024 at 05:27:54PM +0800, Baolin Wang wrote:
>> Based on the analysis of the various scenarios above, determine whether fallback is
>> permitted according to the migration reason in alloc_hugetlb_folio_nodemask().
> 
> Hi Baolin,
> 
> The high level reasoning makes sense to me, taking a step back and
> thinking about all cases and possible outcomes makes sense to me.
> 
> I plan to look closer, but I something that caught my eye:

Thanks for reviewing.

>>   	}
>>   	spin_unlock_irq(&hugetlb_lock);
>>   
>> +	if (gfp_mask & __GFP_THISNODE)
>> +		goto alloc_new;
>> +
>> +	/*
>> +	 * Note: the memory offline, memory failure and migration syscalls can break
>> +	 * the per-node hugetlb pool. Other cases can not allocate new hugetlb on
>> +	 * other nodes.
>> +	 */
>> +	switch (reason) {
>> +	case MR_MEMORY_HOTPLUG:
>> +	case MR_MEMORY_FAILURE:
>> +	case MR_SYSCALL:
>> +	case MR_MEMPOLICY_MBIND:
>> +		allowed_fallback = true;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (!allowed_fallback)
>> +		gfp_mask |= __GFP_THISNODE;
> 
> I think it would be better if instead of fiddling with gfp here,
> have htlb_alloc_mask() have a second argument with the MR_reason,
> do the switch there and enable GFP_THISNODE.
> Then alloc_hugetlb_folio_nodemask() would already get the right mask. >
> I think that that might be more clear as it gets encapsulated in the
> function that directly gives us the gfp.
> 
> Does that makes sense?

I previously considered passing the MR_reason argument to the 
htlb_modify_alloc_mask(), which is only used by hugetlb migration.
But in alloc_hugetlb_folio_nodemask(), if there are available hugetlb on 
other nodes, we should allow migrating, that will not break the per-node 
hugetlb pool.

That's why I just change the gfp_mask for allocating a new hguetlb when 
migration, that can break the pool.

struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int 
preferred_nid,
		nodemask_t *nmask, gfp_t gfp_mask)
{
	spin_lock_irq(&hugetlb_lock);
	if (available_huge_pages(h)) {
		struct folio *folio;

		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
						preferred_nid, nmask);
		if (folio) {
			spin_unlock_irq(&hugetlb_lock);
			return folio;
		}
	}
.....

