Return-Path: <linux-kernel+bounces-23042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC8982A699
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A053F2828D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218521C31;
	Thu, 11 Jan 2024 03:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jaPkQKwS"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1034F184D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fb688bd2-f669-4407-b7c0-d50da7df7118@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704944693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+CspYEcNwuvAfYHCq77jqt2mm1/5Jx/MXmX2v4wHTA=;
	b=jaPkQKwSulNW+6GDnxLN4KdvaU6ETidV9TpYvT13JhBsYwSTeKxFBJhZyPMj2LpKB2tBDS
	neQPOGGy61txQzZ20StvoMeJ7gAmtUec8rKDsTMqKDEdnZm8Euc43nxUMGCrVIEG1413Ey
	VrYFBp9uA50wTh3dwu9bKYivXM9BJXo=
Date: Thu, 11 Jan 2024 11:44:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/7] hugetlb: split hugetlb_hstate_alloc_pages
Content-Language: en-US
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>, linux-kernel@vger.kernel.org,
 David Rientjes <rientjes@google.com>, David Hildenbrand <david@redhat.com>,
 ligang.bdlg@bytedance.com, Muchun Song <muchun.song@linux.dev>,
 Gang Li <gang.li@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
 <20240102131249.76622-3-gang.li@linux.dev>
 <9b95c0ac0e5d560f1482af3753df54211a057b9d.camel@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <9b95c0ac0e5d560f1482af3753df54211a057b9d.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/11 07:12, Tim Chen wrote:
> On Tue, 2024-01-02 at 21:12 +0800, Gang Li wrote:
>> +static unsigned long __init hugetlb_hstate_alloc_pages_gigantic(struct hstate *h)
>> +{
>> +	unsigned long i;
>> +
>> +	for (i = 0; i < h->max_huge_pages; ++i) {
>> +		/*
>> +		 * gigantic pages not added to list as they are not
>> +		 * added to pools now.
>> +		 */
> 
> This comment unnecessary as now we don't have mix gigantic and non-gigantic code,
> which uses foilio list.  And folio_list is not in this routine.
> 
> Can be removed.
> 
> Otherwise Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> 

Thanks!

