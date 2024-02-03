Return-Path: <linux-kernel+bounces-50968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F04E84846C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 08:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7363282441
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EA44EB2A;
	Sat,  3 Feb 2024 07:56:19 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F84EB20;
	Sat,  3 Feb 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706946978; cv=none; b=GW5YQWnF27clD2dUdpRhTa3fUem/e1i8CRbyp3k7aW7aeQjgZYZPUnGZoIMS9TZyDNPP+pfeAVsDEx/gWucf/RceRH+M8MiS+cK68oKbkEKu2KmTzYAWraOlA1BFCBeJnyBswh7NyQTD6WlV0xKNvDE+jstWwDuDcvDtXbbE6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706946978; c=relaxed/simple;
	bh=rknbrWqyTFoylMQcgohFkhB2XHIIcjYldwe8/qcVMG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qjZrNc+1bt9iB6/tadlCO/5dqlATiGt49VHCFfn5Rz18w/6Qp9/iY4ANG6VCGEXAXO/plTeaJ5O2lSSmkz5VPAc7hsNSOdX9c+315L2x4egaygOBuZFo2BSne60tUK6rSRRdZ4ZmQ5UngzvUdUYkg4E/GGBCiTJxivo8RsfQBlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TRlFy2szwz1FK0t;
	Sat,  3 Feb 2024 15:51:34 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DE5914025A;
	Sat,  3 Feb 2024 15:56:06 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 3 Feb 2024 15:56:05 +0800
Message-ID: <4d974c1e-b3a8-8b21-88f4-e5f20b2fb654@huawei.com>
Date: Sat, 3 Feb 2024 15:56:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to
 MCE_IN_KERNEL_COPY_MC
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Naoya
 Horiguchi <naoya.horiguchi@nec.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Guohanjun <guohanjun@huawei.com>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <20240111135548.3207437-3-tongtiangen@huawei.com>
 <20240131070258.GGZbnwov0g918F-FGz@fat_crate.local>
 <3009aadd-69d6-c797-20b4-95cf926b6dd9@huawei.com>
 <20240201142016.GFZbuooG9CRoK90U2C@fat_crate.local>
 <39c1e4d2-b1d0-91ae-595e-1add4698dd7f@huawei.com>
 <20240202133911.GBZbzwf-M37M-J3EJX@fat_crate.local>
 <SJ1PR11MB6083A60DE19FBFB1B0CA6B3DFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240202194257.GFZb1FwcPPO8WXF86H@fat_crate.local>
 <SJ1PR11MB6083BDC3A0596FA87BC25259FC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240202222220.GIZb1rHG3NiZKmdRXu@fat_crate.local>
 <SJ1PR11MB6083FDC9D4661A9D94E26ABDFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <SJ1PR11MB6083FDC9D4661A9D94E26ABDFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/2/3 6:46, Luck, Tony 写道:
>> Now, since you're explaining things today :) pls explain to me what this
>> patchset is all about? You having reviewed patch 3 and all?
>>
>> Why is this pattern:
>>
>>        if (copy_mc_user_highpage(dst, src, addr, vma)) {
>>                memory_failure_queue(page_to_pfn(src), 0);
>>
>> not good anymore?
>>
>> Or is the goal here to poison straight from the #MC handler and not
>> waste time and potentially get another #MC while memory_failure_queue()
>> on the source address is done?
>>
>> Or something completely different?
> 
> See the comment above memory_failure_queue()
> 
> * The function is primarily of use for corruptions that
>   * happen outside the current execution context (e.g. when
>   * detected by a background scrubber)
> 
> In the copy_mc_user_highpage() case the fault happens in
> the current execution context. So scheduling someone else
> to handle it at some future point is risky. Just deal with it
> right away.
> 
> -Tony

The goal of this patch:
   When #MC is triggered by copy_mc_user_highpage(), #MC is directly
processed in the synchronously triggered do_machine_check() ->
kill_me_never() -> memory_failure().

And the current handling is to call memory_failure_queue() ->
schedule_work_on() in the execution context, I think that's what
"scheduling someone else to handle it at some future point is risky."

Thanks.
Tong.

