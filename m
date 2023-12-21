Return-Path: <linux-kernel+bounces-9178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B5381C1F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E86D1F26C81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A703179485;
	Thu, 21 Dec 2023 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kvP9wjFW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3356676DC3;
	Thu, 21 Dec 2023 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8FYhv/qb+6/MBCl737xyFJbR/0xxh2L787E/+trTVXo=; b=kvP9wjFWyiraV1SOjfOPVNjTjS
	oqlBA+ejSgPpDEbhyNjpSGI+/CfpCQOz7/briNvxNOhMAqiz1Strqjm9jwG6C8kaIJ63SPChOt7xr
	4GW0jDHKWYE6Gh0uUvhRTGDqOEHBQt+az6dl5nWfOZVbYglDtQ9oJqr306rVExdqBke/lbVf857SB
	5Y8B/GV/nGqHgs3slEolu4B4EpernRodgCifB1uSCA2qC/ISBcXn/D7PjFIowDmP/TICdxfsQkt9j
	4JWMOf9LDtZimdw74lRIvu1md4PAnFI91qoEVi18cNKu1RsFi21Xtfvc8DUwGV6U27Bm0OzyCN/kH
	3aG0aCrQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGSQW-004Qlx-1J;
	Thu, 21 Dec 2023 23:26:04 +0000
Message-ID: <dad49b21-f7f5-435a-88fd-6505add3acf4@infradead.org>
Date: Thu, 21 Dec 2023 15:26:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvdimm/namespace: fix kernel-doc for function params
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 nvdimm@lists.linux.dev
References: <20231207210545.24056-1-rdunlap@infradead.org>
 <20231207210545.24056-3-rdunlap@infradead.org>
 <6584bce9d01cc_55802294dc@iweiny-mobl.notmuch>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6584bce9d01cc_55802294dc@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/21/23 14:32, Ira Weiny wrote:
> Randy Dunlap wrote:
> 
> [snip]
> 
>> @@ -1656,8 +1664,10 @@ static int select_pmem_id(struct nd_regi
>>  /**
>>   * create_namespace_pmem - validate interleave set labelling, retrieve label0
>>   * @nd_region: region with mappings to validate
>> - * @nspm: target namespace to create
>> + * @nd_mapping: container of dpa-resource-root + labels
>>   * @nd_label: target pmem namespace label to evaluate
>> + *
>> + * Returns: the created &struct device on success or -errno on error
> 
> NIT: should this be ERR_PTR(-errno) on error?

Oh, for sure. Thanks for catching that.

> Generally good to me though.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
>>   */
>>  static struct device *create_namespace_pmem(struct nd_region *nd_region,
>>  					    struct nd_mapping *nd_mapping,

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

