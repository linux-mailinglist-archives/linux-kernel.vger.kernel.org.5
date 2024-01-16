Return-Path: <linux-kernel+bounces-27115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A837E82EAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1C51F23B04
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9D511714;
	Tue, 16 Jan 2024 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zgxj1qBV"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2F11701
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba5a88d7-0cd3-4f9c-aae9-beeb7d64dbaa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705392593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stmod4gMLQl5awDuuOKkSLLgiRIpKv0xEIhh1LQdtmg=;
	b=Zgxj1qBVWiqbB1I1nOZrqaiMvlvXAEAGehrdmZHerqFa3IsyBcM61rTo7Ag8rb6mul+rrD
	O3kJxh5BdL9NLy7C+EcrZKmJN3nIn25Etp+ojp9GCIw5kKAHBLEItGmz14dX+vJBQ1LYjF
	nAKuTEUxVFegTtOl8yA2zv47pMRFCIg=
Date: Tue, 16 Jan 2024 16:09:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/7] hugetlb: split hugetlb_hstate_alloc_pages
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, ligang.bdlg@bytedance.com,
 Gang Li <gang.li@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
 <20240102131249.76622-3-gang.li@linux.dev>
 <2ae5ec3f-4a96-4819-af65-5f04df0c2ebd@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <2ae5ec3f-4a96-4819-af65-5f04df0c2ebd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/16 15:02, Muchun Song wrote:
> On 2024/1/2 21:12, Gang Li wrote:
>> hugetlb_hstate_alloc_pages_gigantic(struct hstate *h)
> 
> The name is so long, how about hugetlb_gigantic_pages_alloc_boot?
> 
>> hugetlb_hstate_alloc_pages_non_gigantic(struct hstate *h)
> 
> hugetlb_pages_alloc_boot?
LGTM.

> It it unnecessary to reverse the condition. A little sime like following:
> 
> if (hstate_is_gigantic(h))
>     /* gigantic pages */
> else
>     /* normal pages */

Will take it in next version.

