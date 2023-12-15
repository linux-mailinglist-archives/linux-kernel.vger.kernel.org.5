Return-Path: <linux-kernel+bounces-429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C8B814102
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5ABB1F22F13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A5563A6;
	Fri, 15 Dec 2023 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CR7pUuB7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0EA46A0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 04:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702615085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NHvMCv6YkH8t/QRo0SbRImBU6lAoyTpBnJFZNJq+tn8=;
	b=CR7pUuB7BoVAGfvLF2wS8kjCAGqR2OYUtrokteFYTqEyzvHiycEImdRlGLrPMubmh5ObKu
	TgDtW9AX9K+sQz01DngB/+NjVwpfvxCLZ6XHJEhCKJQJfiIUT1Wi13J70fZ8RdZAIxOQ3r
	NgJ/oVQCZ59VfvbaFHNnsNy1Jm37Okk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 3/3] arm64: mm: Re-enable OPTIMIZE_HUGETLB_VMEMMAP
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231214073912.1938330-4-sunnanyong@huawei.com>
Date: Fri, 15 Dec 2023 12:37:29 +0800
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 linux-arm-kernel@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: 7bit
Message-Id: <3D3CFB4D-E3DD-41A5-8FF7-51D61D9F9C73@linux.dev>
References: <20231214073912.1938330-1-sunnanyong@huawei.com>
 <20231214073912.1938330-4-sunnanyong@huawei.com>
To: Nanyong Sun <sunnanyong@huawei.com>
X-Migadu-Flow: FLOW_OUT



> On Dec 14, 2023, at 15:39, Nanyong Sun <sunnanyong@huawei.com> wrote:
> 
> Now update of vmemmap page table can follow the rule of
> break-before-make safely for arm64 architecture, re-enable
> HVO on arm64.
> 
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.


