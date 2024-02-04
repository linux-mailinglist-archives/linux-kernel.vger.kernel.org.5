Return-Path: <linux-kernel+bounces-51372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8025848A4E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CF11C22CE0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2878C10F5;
	Sun,  4 Feb 2024 01:52:53 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136F10EB;
	Sun,  4 Feb 2024 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707011572; cv=none; b=pxXhzkz+TtuPBhlNln7LUwXVuhSmkzVp8Nk7nR/9/YRtkCn/NiVIqfPl7hK3WKejeAYTWHXG0a6Zyx67+QgEZD5uPDUVAV2CqAJMbBBySXyC133f8XgBR8+5Pb8ZOufuu8OdzMzc1fNI0IWu2WafZzjpAOlwkm1BplxZBcIdEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707011572; c=relaxed/simple;
	bh=oE4L/+SIwj1YnhEh0Z69Zeulu/L7Qo8g7er8gO/zOX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZySGn02cb9TZ/eFl0j93oE7LRuAA3LQN+Gd6+L/KnynEwEQTi4YISxoJzHycaxjTh3IdcvwoUFp3oxKdtPnfMkwfNp24M0a5CIXkxHQeAoRyPQD7RSCquVdjJlQpA6vF9F8sEtu/H/OkwgfDGYk7PX4sqz1jhaZsuU0IbPMtgNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TSCCt3V3Nz1Q8gk;
	Sun,  4 Feb 2024 09:51:22 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D9D31404FE;
	Sun,  4 Feb 2024 09:52:39 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 09:52:37 +0800
Message-ID: <90576a70-9ab3-dca7-f5cc-67e430dbe460@huawei.com>
Date: Sun, 4 Feb 2024 09:52:36 +0800
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
To: Borislav Petkov <bp@alien8.de>
CC: "Luck, Tony" <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "wangkefeng.wang@huawei.com"
	<wangkefeng.wang@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Guohanjun <guohanjun@huawei.com>
References: <3009aadd-69d6-c797-20b4-95cf926b6dd9@huawei.com>
 <20240201142016.GFZbuooG9CRoK90U2C@fat_crate.local>
 <39c1e4d2-b1d0-91ae-595e-1add4698dd7f@huawei.com>
 <20240202133911.GBZbzwf-M37M-J3EJX@fat_crate.local>
 <SJ1PR11MB6083A60DE19FBFB1B0CA6B3DFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240202194257.GFZb1FwcPPO8WXF86H@fat_crate.local>
 <SJ1PR11MB6083BDC3A0596FA87BC25259FC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240202222220.GIZb1rHG3NiZKmdRXu@fat_crate.local>
 <SJ1PR11MB6083FDC9D4661A9D94E26ABDFC422@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <4d974c1e-b3a8-8b21-88f4-e5f20b2fb654@huawei.com>
 <20240203094309.GDZb4KrS2GWa5XtGeZ@fat_crate.local>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20240203094309.GDZb4KrS2GWa5XtGeZ@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/2/3 17:43, Borislav Petkov 写道:
> On Sat, Feb 03, 2024 at 03:56:04PM +0800, Tong Tiangen wrote:
>> The goal of this patch:
>>    When #MC is triggered by copy_mc_user_highpage(), #MC is directly
>> processed in the synchronously triggered do_machine_check() ->
>> kill_me_never() -> memory_failure().
>>
>> And the current handling is to call memory_failure_queue() ->
>> schedule_work_on() in the execution context, I think that's what
>> "scheduling someone else to handle it at some future point is risky."
> 
> Ok, now take everything that was discussed on the thread and use it to
> rewrite all your commit messages to explain *why* you're doing this, not
> *what* you're doing - that is visible from the diff.
> 
> A possible way to structure them is:
> 
> 1. Prepare the context for the explanation briefly.
> 
> 2. Explain the problem at hand.
> 
> 3. "It happens because of <...>"
> 
> 4. "Fix it by doing X"
> 
> 5. "(Potentially do Y)."
> 
> And some of those above are optional depending on the issue being
> explained.
> 
> For more detailed info, see
> Documentation/process/submitting-patches.rst,
> Section "2) Describe your changes".
> 
> Also, to the tone, from Documentation/process/submitting-patches.rst:
> 
>   "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>    instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>    to do frotz", as if you are giving orders to the codebase to change
>    its behaviour."
> 
> Also, do not talk about what your patch does - that should (hopefully) be
> visible from the diff itself. Rather, talk about *why* you're doing what
> you're doing.

OK, will improved next version.

Thank.
Tong.

> 
> Thx.
> 

