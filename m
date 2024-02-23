Return-Path: <linux-kernel+bounces-77643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B9D860867
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D829280721
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2168831;
	Fri, 23 Feb 2024 01:39:40 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0EEAD4C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652380; cv=none; b=RqOJo+hcsC/HKXbStmIDRVpiWioi4i2DPCNyQL0cp5uyaai2uu9Yp53Z3TEYTqdqVVzyB/AG6U5puFIcE/H+GeyrYs8lawbNTSF4LQ68PMb8jdqSwZaWDJkVh/a48Zh70JwO18MndvvbITHKQTulh6jO3QHntUhRYd6HaDBCxgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652380; c=relaxed/simple;
	bh=w6a/lM4JOOIkaLGjwoIWUqUMup/m3aYFAur7x35KVXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ceiFJDn5bGNnDBBFnkG7HqQLeMmvSPN2Qd46Bdq+/XHLUBg6EKKg2RifaxEtYnID1AFrt6ZyA0tffZ7ASSLDy/rrLn88yqF7OZ77vIRqNupYrqLuBKT8DElyUsxD+dU9lLBSMtnEYseLXAwNIHKAbgeM1bKacYMSyp63cS2wGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tgsxm2fPGz1FLGY;
	Fri, 23 Feb 2024 09:34:36 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id D2FDA1A016B;
	Fri, 23 Feb 2024 09:39:29 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 23 Feb 2024 09:39:29 +0800
Message-ID: <7396cdc0-e878-48fe-85b9-d88611d28444@huawei.com>
Date: Fri, 23 Feb 2024 09:39:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>, Andrew
 Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, Mike Rapoport
	<rppt@kernel.org>, Eric DeVolder <eric.devolder@oracle.com>, Rob Herring
	<robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij
	<linus.walleij@linaro.org>
References: <20240220081527.23408-1-liuyuntao12@huawei.com>
 <1342759e-b967-4ec4-98d5-48146f81f695@app.fastmail.com>
 <38c09a4b-69cc-4dc5-8a68-e5f5597613ac@huawei.com>
 <30b01c65-12f2-4ee0-81d5-c7a2da2c36b4@app.fastmail.com>
 <4e9396ca-460b-49ca-818e-73f0a8997b15@huawei.com>
 <58297ee9-4f33-4b3b-bd00-b44e86965892@app.fastmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <58297ee9-4f33-4b3b-bd00-b44e86965892@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/2/23 0:04, Arnd Bergmann wrote:
> On Thu, Feb 22, 2024, at 12:24, liuyuntao (F) wrote:
>>
>> The position of the caret has been moved below the right brace
>> of { KEEP(*(.vectors.bhb.loop8)) }, indicating that lld is treating
>> the entire `KEEP(*(.vectors))` as a file name. This could potentially be
>> a bug in lld. Perhaps we can temporarily
>> enable the DCE option only when option LD_IS_LLD is disabled,
>> like risc-v:
>>
>> `select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD`.
> 
> I would really like to see this working with lld if at all
> possible, as it allows the combination of gc-sections with
> lto and CONFIG_TRIM_UNUSED_KSYMS.
> 
> I experimented with lld myself now and I did get a booting
> kernel even without the the KEEP() on the vectors. I also

When the kernel booted up successfully, was config DCE enabled?

> see that this is the only use of OVERLAY in the kernel, so
> I hope that we can find a way to make it work with existing
> lld after all, either without the KEEP or without the OVERLAY.

Yeah, i will try other way to make it work.

> 
> Did you see any problems without the KEEP() on the vectors?
> 
>       Arnd

Without the KEEP(),disable DCE, qemu boots well,
enable DCE,qemu hangs on startup.
I experimented with lld using vexpress_defconfig.

