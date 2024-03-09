Return-Path: <linux-kernel+bounces-97790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FEC876F6E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 07:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569FA28229C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E6936133;
	Sat,  9 Mar 2024 06:56:58 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661D1D558
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709967417; cv=none; b=SrU3oTBtEZSo5EgYOsmXSac8Hju2l7jfNQEytLJM8/jv9wMCUAjRYHBvcK6AvROn5r5CIpnYQDpg7538R7CdO5K6NcW51sRCfBtm7+bNl3ZxK4dpaCXbXrpvas3TAU9bb62qBDRbUuXQdgFw1g/LUGe0J4ZcmUS9sk9vzlSlaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709967417; c=relaxed/simple;
	bh=1qsQHg57H1LKQe3m/sT4lhmQzJvIZGKeFT5OHy8I0tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LMgK1autTOkRZd3s1rrHf95YODA0RiH4sHvB+zwbZozIwZbodG0cO25DFfEFgkdxSlboVH2wblqjxS3xq4ht6qZ6Pq52ubnIS+GptliHEsanwrSK1pOZGfoznQZM/vnTwiBSYmH84xn+Vuhfmk/vkCUV4MSpvG2vJA+9l1JBrlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TsDKq3tgmz2BfPp;
	Sat,  9 Mar 2024 14:54:23 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F95C1A016C;
	Sat,  9 Mar 2024 14:56:47 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 9 Mar 2024 14:56:46 +0800
Message-ID: <cbf5f847-a5c7-443d-9c6f-57a9678a8d2e@huawei.com>
Date: Sat, 9 Mar 2024 14:56:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v2] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fangrui Song <maskray@google.com>, Russell King <linux@armlinux.org.uk>,
	Andrew Davis <afd@ti.com>, Andrew Morton <akpm@linux-foundation.org>, "Kirill
 A. Shutemov" <kirill.shutemov@linux.intel.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, Mike Rapoport
	<rppt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
	<llvm@lists.linux.dev>
References: <20240307151231.654025-1-liuyuntao12@huawei.com>
 <58cc1053-7208-4b22-99cb-210fdf700569@app.fastmail.com>
 <CAMj1kXFEdRZsy8FovGrfWotoaws1KoKbFv5q+7yKL=pRV8zkZw@mail.gmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <CAMj1kXFEdRZsy8FovGrfWotoaws1KoKbFv5q+7yKL=pRV8zkZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/3/8 22:27, Ard Biesheuvel wrote:
> On Fri, 8 Mar 2024 at 14:16, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Thu, Mar 7, 2024, at 16:12, Yuntao Liu wrote:
>>> The current arm32 architecture does not yet support the
>>> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
>>> embedded scenarios, and enabling this feature would be beneficial for
>>> reducing the size of the kernel image.
>>>
>>> In order to make this work, we keep the necessary tables by annotating
>>> them with KEEP, also it requires further changes to linker script to KEEP
>>> some tables and wildcard compiler generated sections into the right place.
>>>
>>> It boots normally with defconfig, vexpress_defconfig and tinyconfig.
>>>
>>> The size comparison of zImage is as follows:
>>> defconfig       vexpress_defconfig      tinyconfig
>>> 5137712         5138024                 424192          no dce
>>> 5032560         4997824                 298384          dce
>>> 2.0%            2.7%                    29.7%           shrink
>>>
>>> When using smaller config file, there is a significant reduction in the
>>> size of the zImage.
>>>
>>> We also tested this patch on a commercially available single-board
>>> computer, and the comparison is as follows:
>>> a15eb_config
>>> 2161384         no dce
>>> 2092240         dce
>>> 3.2%            shrink
>>>
>>> The zImage size has been reduced by approximately 3.2%, which is 70KB on
>>> 2.1M.
>>>
>>> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
>>
>> I've retested with both gcc-13 and clang-18, and so no
>> more build issues. Your previous version already worked
>> fine for me.
>>
>> I did some tests combining this with CONFIG_TRIM_UNUSED_KSYMS,
>> which showed a significant improvement as expected. I also
>> tried combining it with an experimental CONFIG_LTO_CLANG
>> patch, but that did not show any further improvements.
>>
>> Tested-by: Arnd Bergmann <arnd@arndb.de>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Adding Ard Biesheuvel and Fangrui Song to Cc, so they can comment
>> on the ARM_VECTORS_TEXT workaround. I don't understand enough of
>> the details of what is going on here.
>>
> 
> Thanks for the cc
> 
>> Full quote of the patch below so they can see the whole thing.
>>
>> If they are also happy with the patch, I think you can send it
>> into Russell's patch tracker at
>> https://www.armlinux.org.uk/developer/patches/info.php
>>
> 
> No, not happy at all :-)
> 
> The resulting kernel does not boot (built with GCC or Clang). And the
> patch is buggy (see below)
> 
After applying .reloc .text, R_ARM_NONE, ., the resulting kernel boots 
well in QEMU. I tested it with the latest linux-next master branch and 
the mainline master branch.
By the way, I used vexpress_defconfig for testing, it worked.


