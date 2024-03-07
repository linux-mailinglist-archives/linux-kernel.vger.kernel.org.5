Return-Path: <linux-kernel+bounces-94909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977CB874690
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7B8B222D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4FCDDA0;
	Thu,  7 Mar 2024 03:09:59 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9A63C7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780998; cv=none; b=RRr/mSn3yRXWd0lRgIBjuFYoFOPHpDwXpQ0TmbHSBwpo76S8Be92Kj72aTTnOYczgip905x6w4XJpt8HpJxZvyvlUSFKQFo4GXh6SfKJTvef3eYY+Jlqy6AhQVnLtgHRbrxlkimg6UCHkNrvs1Dlw+InewLjXbnVB6d8PPwYwMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780998; c=relaxed/simple;
	bh=3xrolTwPIE/Z1Jhq2oxb8I7qqfZb26/VHY/X4xLSSQI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=RR4c8qpmMYU9UrZW3DVSZK2BGi1/TQytYLVbJv2gh7PDehZpEjmxnSWH2gxBjG8eOqYin/xuXNAfRk6G/EvGOU2wJgH8lT5B4Vg2MlAJM/6QZwDnmYGqzjd5Z5U3lWw0c4DzhUwHh03pwCmbR9jvG/I+ixwOqCG6W38ewyMiNV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TqvP53rsMzXhtb;
	Thu,  7 Mar 2024 11:07:37 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 12B9A1402D0;
	Thu,  7 Mar 2024 11:09:54 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 11:09:53 +0800
Message-ID: <0255a8e9-d973-497c-9011-5651e0002a9c@huawei.com>
Date: Thu, 7 Mar 2024 11:09:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>, Andrew
 Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, Mike Rapoport
	<rppt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>
References: <20240220081527.23408-1-liuyuntao12@huawei.com>
 <1342759e-b967-4ec4-98d5-48146f81f695@app.fastmail.com>
 <38c09a4b-69cc-4dc5-8a68-e5f5597613ac@huawei.com>
 <30b01c65-12f2-4ee0-81d5-c7a2da2c36b4@app.fastmail.com>
 <4e9396ca-460b-49ca-818e-73f0a8997b15@huawei.com>
 <58297ee9-4f33-4b3b-bd00-b44e86965892@app.fastmail.com>
 <2397d8dd-8053-4167-9aac-f5d7c05a98da@huawei.com>
In-Reply-To: <2397d8dd-8053-4167-9aac-f5d7c05a98da@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/2/27 16:06, liuyuntao (F) wrote:
> 
> 
> On 2024/2/23 0:04, Arnd Bergmann wrote:
>> On Thu, Feb 22, 2024, at 12:24, liuyuntao (F) wrote:
>>>
>>> The position of the caret has been moved below the right brace
>>> of { KEEP(*(.vectors.bhb.loop8)) }, indicating that lld is treating
>>> the entire `KEEP(*(.vectors))` as a file name. This could potentially be
>>> a bug in lld. Perhaps we can temporarily
>>> enable the DCE option only when option LD_IS_LLD is disabled,
>>> like risc-v:
>>>
>>> `select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD`.
>>
>> I would really like to see this working with lld if at all
>> possible, as it allows the combination of gc-sections with
>> lto and CONFIG_TRIM_UNUSED_KSYMS.
> 
Another way to preserve .vector sections without using KEEP annotation.
It boots well. How do you feel about this approach? and, could I submit 
a v2 patch?

1: Define ARM_VECTORS_TEXT to explicitly preserve .vectors section.

 > --- a/arch/arm/include/asm/vmlinux.lds.h
 > +++ b/arch/arm/include/asm/vmlinux.lds.h
 > @@ -87,6 +87,13 @@
 >                 *(.vfp11_veneer)                                \
 >                 *(.v4_bx)
 >
 > +#define ARM_VECTORS_TEXT                                       \
 > +       .vectors.text : {                                       \
 > +               KEEP(*(.vectors))                               \
 > +               KEEP(*(.vectors.bhb.loop8))                     \
 > +               KEEP(*(.vectors.bhb.bpiall))                    \
 > +       }
 > +
 >  #define ARM_TEXT                                               \
 >                 IDMAP_TEXT                                      \
 >                 __entry_text_start = .;                         \

2: Ref ARM_VECTORS_TEXT if config HAVE_LD_DEAD_CODE_DATA_ELIMINATION is 
enabled, and the same to arch/arm/kernel/vmlinux.lds.S

 > --- a/arch/arm/kernel/vmlinux-xip.lds.S 

 > +++ b/arch/arm/kernel/vmlinux-xip.lds.S 

 > @@ -135,6 +135,10 @@ SECTIONS 

 >         ARM_TCM 

 >  #endif 

 > 

 > +#ifdef HAVE_LD_DEAD_CODE_DATA_ELIMINATION 

 > +       ARM_VECTORS_TEXT 

 > +#endif 

 > + 

 >         /* 

 >          * End of copied data. We need a dummy section to get its 
LMA.
 >          * Also located before final ALIGN() as trailing padding is
 > not stored


