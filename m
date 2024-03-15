Return-Path: <linux-kernel+bounces-104254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFD787CB4B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C123A1C20DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0A418639;
	Fri, 15 Mar 2024 10:23:55 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405317C60
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498234; cv=none; b=FyCD2LoGnNTLcj+Ooo/9lTsTe1Sx0CDAQOtZ7ZJYFM6m6mAPBwgd0ymOL6Ptpi60DE1zgVdEuOhDI1IvYw8r/T5dEO7r1BsIEspF+NH/RLOHn+bIKZRGxtsSGDQxmJoNLrWk6NK65kAxDChNvsmJ+MoU20EMLVVP0Ea10nanCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498234; c=relaxed/simple;
	bh=vfHuvWzpTK5NOf8madoPPjwSObeXKLTo+T8TMTxCGgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Goic9zKJVdkp9FCNYmG8zyLZeLpF6SsY2D2+HUbaVh6+L65TJH8tTYMLf9URpjD2LeBlyiyFjMUlkO4FDA6LNQm9op1k4WmDm+13ylX/OTKOcussrOuUe51jOp6Umcn5IrROYS2zhoJgtDW8O+rukHfd1FYbmfomR1GYWKmSu5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tx0hL2S5jz1FMbw;
	Fri, 15 Mar 2024 18:23:30 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F4E8180061;
	Fri, 15 Mar 2024 18:23:48 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Mar 2024 18:23:47 +0800
Message-ID: <d7a1996f-f558-4cea-b8ca-eb071d02c6d4@huawei.com>
Date: Fri, 15 Mar 2024 18:23:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v3] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<arnd@arndb.de>, <geert@linux-m68k.org>, <linux@armlinux.org.uk>,
	<afd@ti.com>, <akpm@linux-foundation.org>, <kirill.shutemov@linux.intel.com>,
	<geert+renesas@glider.be>, <corbet@lwn.net>, <rppt@kernel.org>,
	<robh@kernel.org>, <tglx@linutronix.de>, <linus.walleij@linaro.org>,
	<maskray@google.com>
References: <20240315063154.696633-1-liuyuntao12@huawei.com>
 <CAMj1kXH+FaddHV5--kqB_wVgw_M682MvchPB1BoCuDuA6vVyvg@mail.gmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <CAMj1kXH+FaddHV5--kqB_wVgw_M682MvchPB1BoCuDuA6vVyvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/3/15 16:06, Ard Biesheuvel wrote:
> On Fri, 15 Mar 2024 at 07:37, Yuntao Liu <liuyuntao12@huawei.com> wrote:
>>
>> The current arm32 architecture does not yet support the
>> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
>> embedded scenarios, and enabling this feature would be beneficial for
>> reducing the size of the kernel image.
>>
>> In order to make this work, we keep the necessary tables by annotating
>> them with KEEP, also it requires further changes to linker script to KEEP
>> some tables and wildcard compiler generated sections into the right place.
>> When using ld.lld for linking, the KEEP keyword is not recognized within
>> the OVERLAY command, Ard proposed a concise method to solve this problem.
>>
>> It boots normally with defconfig, vexpress_defconfig and tinyconfig.
>> The size comparison of zImage is as follows:
>> defconfig       vexpress_defconfig      tinyconfig
>> 5137712         5138024                 424192          no dce
>> 5032560         4997824                 298384          dce
>> 2.0%            2.7%                    29.7%           shrink
>>
>> When using smaller config file, there is a significant reduction in the
>> size of the zImage.
>>
>> We also tested this patch on a commercially available single-board
>> computer, and the comparison is as follows:
>> a15eb_config
>> 2161384         no dce
>> 2092240         dce
>> 3.2%            shrink
>>
>> The zImage size has been reduced by approximately 3.2%, which is 70KB on
>> 2.1M.
>>
>> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
>> Tested-by: Arnd Bergmann <arnd@arndb.de>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> v3:
>>     - A better way to KEEP .vectors section for ld.lld linking.
>>
>> v2:
>>     - Support config XIP_KERNEL.
>>     - Support LLVM compilation.
>>     - https://lore.kernel.org/all/20240307151231.654025-1-liuyuntao12@huawei.com/
>>
>> v1: https://lore.kernel.org/all/20240220081527.23408-1-liuyuntao12@huawei.com/
>> ---
>>   arch/arm/Kconfig                       | 1 +
>>   arch/arm/boot/compressed/vmlinux.lds.S | 6 +++++-
>>   arch/arm/include/asm/vmlinux.lds.h     | 2 +-
>>   arch/arm/kernel/entry-armv.S           | 3 +++
>>   arch/arm/kernel/vmlinux-xip.lds.S      | 4 ++--
>>   arch/arm/kernel/vmlinux.lds.S          | 6 +++---
>>   6 files changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index b14aed3a17ab..45f25f6e7a62 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -114,6 +114,7 @@ config ARM
>>          select HAVE_KERNEL_XZ
>>          select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
>>          select HAVE_KRETPROBES if HAVE_KPROBES
>> +       select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>>          select HAVE_MOD_ARCH_SPECIFIC
>>          select HAVE_NMI
>>          select HAVE_OPTPROBES if !THUMB2_KERNEL
>> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
>> index 3fcb3e62dc56..affd30714f01 100644
>> --- a/arch/arm/boot/compressed/vmlinux.lds.S
>> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
>> @@ -89,7 +89,11 @@ SECTIONS
>>        * The EFI stub always executes from RAM, and runs strictly before the
>>        * decompressor, so we can make an exception for its r/w data, and keep it
>>        */
>> +#ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
>> +    *(.data.* .bss.*)
>> +#else
>>       *(.data.efistub .bss.efistub)
>> +#endif
>>       __pecoff_data_end = .;
>>
> 
> This is still not right.
> 
> Can you just add -fno-data-sections to cflags-$(CONFIG_ARM) in
> drivers/firmware/efi/libstub/Makefile?
> 

I rebuild kernel in such way:
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -28,6 +28,7 @@ cflags-$(CONFIG_ARM)          += -DEFI_HAVE_STRLEN 
-DEFI_HAVE_STRNLEN \
                                    -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
                                    -DEFI_HAVE_STRCMP -fno-builtin -fpic \
                                    $(call cc-option,-mno-single-pic-base)
+cflags-$(CONFIG_ARM)           += -fno-data-sections
  cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
  cflags-$(CONFIG_LOONGARCH)     += -fpi
but I am still encountering this error:
arm-linux-gnueabi-ld: warning: orphan section `.data.efi_loglevel' from 
`drivers/firmware/efi/libstub/printk.stub.o' being placed in section 
`.data.efi_loglevel'
arm-linux-gnueabi-ld: warning: orphan section `.data.screen_info_guid' 
from `drivers/firmware/efi/libstub/screen_info.stub.o' being placed in 
section `.data.screen_info_guid'
arm-linux-gnueabi-ld: warning: orphan section `.data.cpu_state_guid' 
from `drivers/firmware/efi/libstub/arm32-stub.stub.o' being placed in 
section `.data.cpu_state_guid'
arm-linux-gnueabi-ld: warning: orphan section `.data.efi_nokaslr' from 
`drivers/firmware/efi/libstub/efi-stub-helper.stub.o' being placed in 
section `.data.efi_nokaslr'
arm-linux-gnueabi-ld: error: zImage file size is incorrect

I am puzzled because I could not find any option named 
-fno-data-sections for GCC.


