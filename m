Return-Path: <linux-kernel+bounces-127383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0E5894A8E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF57B234B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FC617C67;
	Tue,  2 Apr 2024 04:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R/cS9EBR"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598012581;
	Tue,  2 Apr 2024 04:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032983; cv=none; b=VT5jqNVaJeqFCssMHUhP3ktmA7p3Z6DVC3gCYjNEj6GjLCEneFwtdyBNdclv4bd1ntlO4UdQ84n3juexabD/lC2KmgqtRtXFhlkEbZWtWECQ1lqVP3e26t3oV323pnHm2rGY9Q6Bmxob4YtYwbWr12h10DSX1BnRAM0L7VSo+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032983; c=relaxed/simple;
	bh=VY23z033UnkfMFSKC7qGity31SFRLGUYYweOjQ/nK54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyXu03vA67sWzRDf+iXlOFKKxVMzc8UpxVsmB6fUaJBQppjEJ3HASUjDmzcYvUMk1oIWoc9UzzcbkM7npoLk+5SeEsz1jQWY4xDeMqqMqyTUBvF0EFVwfXQW1qnhbbQV2Ps8AhicfxWd7ehjCSv9FTh4+wwLlLDgS9cXELwv/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R/cS9EBR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=zalD8cbpimqALrAnhU1MWxa0W1J+AI9zH7OB+CRpPSc=; b=R/cS9EBRYUnM4DUW2L+dBpBzHP
	3CFf/FIwz7bEtUrbvMoOTa6p/Tu2IIWE9DLthRDasfNtKxmToM1E1hCq3fVbYiVv9ZCUk+yt0OmEB
	M+9ab6kAVXgfAOj5nIsevvB6BBU8uR/1UO4yxCYQLAX9yM4eLYJk6f5ptFXibEmpQ5bTlcg3BVKcx
	QtquFm/WheleB72QpICoaV6xtHXfpT4xNB37YTH28POVHfy3kunIMew26EfL+VnKZ9htPINjPmM/D
	WlNj7xL8QvZ/FUCE7ZAlgFdVM6BUBjBRxyNR4Uxn2gkfrdEfY8oZ4BWSzwfs4xW/R6ql4lDiwHX88
	flU5LD+A==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrVz8-00000009hUR-1LGs;
	Tue, 02 Apr 2024 04:42:58 +0000
Message-ID: <fb49e921-a765-4828-bcfe-b2b4e623c5ea@infradead.org>
Date: Mon, 1 Apr 2024 21:42:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: dfl: fme: fix kernel-doc comments for some
 functions
To: Xu Yilun <yilun.xu@linux.intel.com>,
 Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Alan Tull <atull@kernel.org>, Shiva Rao <shiva.rao@intel.com>,
 Kang Luwei <luwei.kang@intel.com>, Enno Luebbers <enno.luebbers@intel.com>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 Russ Weight <russ.weight@linux.dev>, Marco Pagani <marpagan@redhat.com>,
 Matthew Gerlach <matthew.gerlach@linux.intel.com>,
 kernel test robot <lkp@intel.com>
References: <20240329001542.8099-1-peter.colberg@intel.com>
 <Zgt/wftzm4xthfio@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Zgt/wftzm4xthfio@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/1/24 8:47 PM, Xu Yilun wrote:
> On Thu, Mar 28, 2024 at 08:15:42PM -0400, Peter Colberg wrote:
>> From: Xu Yilun <yilun.xu@intel.com>
> 
> I didn't remember I wrote this exact patch, but anyway the patch itself
> is confusing.
> 
>>
>> lkp reported 2 build warnings:
>>
>>    drivers/fpga/dfl/dfl-fme-pr.c:175: warning: Function parameter or member 'feature' not described in 'dfl_fme_create_mgr'
>>
>>>> drivers/fpga/dfl/dfl-fme-pr.c:280: warning: expecting prototype for
>>>> dfl_fme_destroy_bridge(). Prototype was for dfl_fme_destroy_bridges()
>>>> instead
>>
>> Fixes: 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature support")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>> Signed-off-by: Peter Colberg <peter.colberg@intel.com>

All kernel-doc issues with this source file are already fixed in linux-next
by this commit:

commit 782d8e61b5d6
Author: Randy Dunlap <rdunlap@infradead.org>
Date:   Thu Jan 12 22:37:20 2023 -0800

    fpga: dfl: kernel-doc corrections
    
    Fix W=1 kernel-doc warnings in drivers/fpga/:


>> ---
>>  drivers/fpga/dfl-fme-pr.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
>> index cdcf6dea4cc9..96cb24787ab1 100644
>> --- a/drivers/fpga/dfl-fme-pr.c
>> +++ b/drivers/fpga/dfl-fme-pr.c
>> @@ -166,6 +166,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>>   * dfl_fme_create_mgr - create fpga mgr platform device as child device
>>   * @feature: sub feature info
> 
> The member 'feature' is described here. It still causes build warning?
> 
>>   * @pdata: fme platform_device's pdata
>> + * @feature: the dfl fme PR sub feature
> 
> Why adding a duplicated item would fix the warning?
> 
>>   *
>>   * Return: mgr platform device if successful, and error code otherwise.
>>   */
>> @@ -273,7 +274,7 @@ static void dfl_fme_destroy_bridge(struct dfl_fme_bridge *fme_br)
>>  }
>>  
>>  /**
>> - * dfl_fme_destroy_bridges - destroy all fpga bridge platform device
> 
> The prototype is for dfl_fme_destroy_bridges(), why the warning?
> 
>> + * dfl_fme_destroy_bridges - destroy all fpga bridge platform devices
> 
> Correct the plural form in description would fix the warning?
> 
>>   * @pdata: fme platform device's pdata
>>   */
>>  static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pdata)
>> -- 
>> 2.44.0
>>
>>
> 

-- 
#Randy

