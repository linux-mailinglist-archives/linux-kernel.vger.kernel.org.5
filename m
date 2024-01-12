Return-Path: <linux-kernel+bounces-24410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFD282BC2F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F21428633A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF6E5D747;
	Fri, 12 Jan 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j3rSbpLE"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99532C62
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2296235e-b15a-445d-b867-125c6d85a8a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705046901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHHljA0oQNzdAwnrcBdcmTqIurHhJV7HJIprweZM2NI=;
	b=j3rSbpLE9NGNOEkTBHFouF0sqQj4U/xScJxrT07bH6resfKDDYy7dboO6ZV8Vx5HTTKPfI
	WRZ8EJOTNRBnOi4DqRNNw3MvwQyQfzHUxG/qfZlx8Auhe2M0c/uQhJmODfzN1o8SinNCWy
	W9yWQMtlJYpL/Zoykz3sxthJsA8uYa8=
Date: Fri, 12 Jan 2024 16:07:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/7] hugetlb: pass *next_nid_to_alloc directly to
 for_each_node_mask_to_alloc
Content-Language: en-US
To: Tim Chen <tim.c.chen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
References: <20240102131249.76622-1-gang.li@linux.dev>
 <20240102131249.76622-5-gang.li@linux.dev>
 <66af5bce84c9b6480feaa2ddaff199cd5722fcde.camel@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <66af5bce84c9b6480feaa2ddaff199cd5722fcde.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/12 06:21, Tim Chen wrote:
> On Tue, 2024-01-02 at 21:12 +0800, Gang Li wrote:
>> The parallelization of hugetlb allocation leads to errors when sharing
>> h->next_nid_to_alloc across different threads. To address this, it's
> 
> Suggest you say
> With parallelization of hugetlb allocation across different threads,
> each thread works on a differnet node to allocate pages from, instead
> of all allocating from a common node h->next_nid_to_alloc.  To address this, it's
> 
>> necessary to assign a separate next_nid_to_alloc for each thread.

LGTM, thanks.

