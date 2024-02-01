Return-Path: <linux-kernel+bounces-47997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1777A8455ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26BB2887CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06BA15D5A0;
	Thu,  1 Feb 2024 11:02:45 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E79915CD56;
	Thu,  1 Feb 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785365; cv=none; b=kVQQe0EHgEUSkSvgpdgu5gBX8nYil1xMm/Oikdo+wOWq4N11UmZ5VL8NdGv7fmyj43yJ0h2FIk8keLGxG8GuOkrLbVinMNcGBC6LqzQ2HrpgtPkCI+aZy+EINIEaXBukL93IUzagX4HgzqyqMQyZqWzbh19Me3qG3ThESXC0GSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785365; c=relaxed/simple;
	bh=rNRuMMSbWJkzUzT3LGX+S4XIK4AHjMbsn++vP0q8UXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ojOrPX9ekWVVKa/HJ6JybH0+qFj1Pfg39ZuJ4DBiPWvBnscD2TzoCuhV4JboXr6KcgStla0VytoIPermaRA6UvBT/6OMU7GlIrniVIJ2Cu+HtJLAnZpS9h8d7KPyqRMtLMCz9ESZf1h1SnEphlrZpUJ76gdtf97VNadZdW4h4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TQbZB5CzVz1xn1G;
	Thu,  1 Feb 2024 19:01:38 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id BFB5E140412;
	Thu,  1 Feb 2024 19:02:39 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 19:02:38 +0800
Message-ID: <b8a0c361-3dc7-256f-e2f5-359a31b8975d@huawei.com>
Date: Thu, 1 Feb 2024 19:02:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v4 1/3] x86/mce: remove redundant fixup type
 EX_TYPE_COPY
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	<wangkefeng.wang@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck
	<tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Naoya
 Horiguchi <naoya.horiguchi@nec.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-mm@kvack.org>, Guohanjun
	<guohanjun@huawei.com>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <20240111135548.3207437-2-tongtiangen@huawei.com>
 <20240130210918.GFZbllfs4jUcd_QHL2@fat_crate.local>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20240130210918.GFZbllfs4jUcd_QHL2@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/1/31 5:09, Borislav Petkov 写道:
> On Thu, Jan 11, 2024 at 09:55:46PM +0800, Tong Tiangen wrote:
>> In commit 034ff37d3407 ("x86: rewrite '__copy_user_nocache' function"),
>> rewrited __copy_user_nocache() uses EX_TYPE_UACCESS instead of
>> EX_TYPE_COPY，this change does not broken the MC safe copy for
>> __copy_user_nocache(), but as a result, there's no place for EX_TYPE_COPY
>> to use. Therefore, we remove the definition of EX_TYPE_COPY.
> 
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.
> 
> Also, pls read section "2) Describe your changes" in
> Documentation/process/submitting-patches.rst for more details.
> 
> Also, see section "Changelog" in
> Documentation/process/maintainer-tip.rst

OK, thanks, Improved in the next release.

> 
>> diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
>> index fe6312045042..787916ec1e12 100644
>> --- a/arch/x86/include/asm/extable_fixup_types.h
>> +++ b/arch/x86/include/asm/extable_fixup_types.h
>> @@ -36,18 +36,17 @@
>>   #define	EX_TYPE_DEFAULT			 1
>>   #define	EX_TYPE_FAULT			 2
>>   #define	EX_TYPE_UACCESS			 3
>> -#define	EX_TYPE_COPY			 4
>> -#define	EX_TYPE_CLEAR_FS		 5
>> -#define	EX_TYPE_FPU_RESTORE		 6
>> -#define	EX_TYPE_BPF			 7
>> -#define	EX_TYPE_WRMSR			 8
>> -#define	EX_TYPE_RDMSR			 9
>> -#define	EX_TYPE_WRMSR_SAFE		10 /* reg := -EIO */
>> -#define	EX_TYPE_RDMSR_SAFE		11 /* reg := -EIO */
>> -#define	EX_TYPE_WRMSR_IN_MCE		12
>> -#define	EX_TYPE_RDMSR_IN_MCE		13
>> -#define	EX_TYPE_DEFAULT_MCE_SAFE	14
>> -#define	EX_TYPE_FAULT_MCE_SAFE		15
>> +#define	EX_TYPE_CLEAR_FS		 4
>> +#define	EX_TYPE_FPU_RESTORE		 5
>> +#define	EX_TYPE_BPF			 6
>> +#define	EX_TYPE_WRMSR			 7
>> +#define	EX_TYPE_RDMSR			 8
>> +#define	EX_TYPE_WRMSR_SAFE		 9 /* reg := -EIO */
>> +#define	EX_TYPE_RDMSR_SAFE		10 /* reg := -EIO */
>> +#define	EX_TYPE_WRMSR_IN_MCE		11
>> +#define	EX_TYPE_RDMSR_IN_MCE		12
>> +#define	EX_TYPE_DEFAULT_MCE_SAFE	13
>> +#define	EX_TYPE_FAULT_MCE_SAFE		14
> 
> You don't need to renumber them - all you need to do is to comment it
> out:
> 
> /* unused, was: #define EX_TYPE_COPY 		4 */

OK.

Thanks.
Tong.

> 

