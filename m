Return-Path: <linux-kernel+bounces-104391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A847D87CD2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B0E1C21006
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED8C1C2A0;
	Fri, 15 Mar 2024 12:22:06 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F491BC2C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505326; cv=none; b=JQ9Z3PLRJsiw24oLeMTNdQnJMbeiWE12UbYS71QcMuaEBfUsYPszx+0z0qBhiexozWEWbiYssvyMdKtzcgIFFuD0DtJaa242YerT+0t80BfeYvcbAxTHlLj1IGB/KdpVKGdLN0ZLkB1eKLkNBN3cJf/Nj9PcmLDdXrJHZjJCr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505326; c=relaxed/simple;
	bh=bI0PhVqBa5hSvI5R28R4JKjzn0Em27kPqJgc0vQSNmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U0cUcn0t+wz5jk5PvDPZ7Ru63qhKo+QBX5ex7GCkHnzXbHneeZ1hHvmdBVFt/DMDuaj8vBkz4v915bo3JpET5zSq6O1m86TpVzwxxmBw+7+FvGSFkKhNkn1c8J26goLeKCuzc7pXp2wMA4N4pxyCPTvP8GhsqcHtNuyNMGj7MqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tx3G63jnDz1QBbP;
	Fri, 15 Mar 2024 20:19:26 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id E8F82140124;
	Fri, 15 Mar 2024 20:21:55 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Mar 2024 20:21:55 +0800
Message-ID: <31f3a3fe-b16f-47a9-8c41-80fc0a236d52@huawei.com>
Date: Fri, 15 Mar 2024 20:21:55 +0800
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
CC: Arnd Bergmann <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>, Andrew
 Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, Mike Rapoport
	<rppt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Fangrui Song
	<maskray@google.com>
References: <20240315063154.696633-1-liuyuntao12@huawei.com>
 <CAMj1kXH+FaddHV5--kqB_wVgw_M682MvchPB1BoCuDuA6vVyvg@mail.gmail.com>
 <d7a1996f-f558-4cea-b8ca-eb071d02c6d4@huawei.com>
 <CAMj1kXHP-M7hTsCmorgzvDiPB1jRXHciJrXjJR82zmkxUTD-5Q@mail.gmail.com>
 <b3e3f664-f8ad-41d7-b8d5-3c83818ff489@huawei.com>
 <d91cf190-e583-422f-884d-79552b674f72@app.fastmail.com>
 <baed1e49-d854-4517-8219-2a5bb0b3cd1b@huawei.com>
 <CAMj1kXG5dHsdGn0_hSv2vPyMJbe1zOf4HLprLUSKJ+Dy2e_DzQ@mail.gmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <CAMj1kXG5dHsdGn0_hSv2vPyMJbe1zOf4HLprLUSKJ+Dy2e_DzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/3/15 20:13, Ard Biesheuvel wrote:
> On Fri, 15 Mar 2024 at 13:10, liuyuntao (F) <liuyuntao12@huawei.com> wrote:
>>
>>
>>
>> On 2024/3/15 19:51, Arnd Bergmann wrote:
>>> On Fri, Mar 15, 2024, at 12:48, liuyuntao (F) wrote:
>>>> On 2024/3/15 18:46, Ard Biesheuvel wrote:
>>>>> @@ -28,6 +28,7 @@
>>>>>                                       -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>>>>>                                       -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>>>>>                                       $(call cc-option,-mno-single-pic-base)
>>>>> +cflags-$(CONFIG_ARM)           := $(filter-out -fdata-sections, $(CFLAGS-y))
>>>>>     cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
>>>>>     cflags-$(CONFIG_LOONGARCH)     += -fpie
>>>>
>>>> Another error:
>>>> cannot initialize array of ‘short unsigned int’ from a string literal
>>>> with type array of ‘unsigned int’
>>>>     17 | static const efi_char16_t shim_MokSBState_name[] = L"MokSBStateRT";
>>>
>>> The line sets cflags-y to an empty string.
>>>
>>> It probably should have been
>>>
>>> cflags-$(CONFIG_ARM)           := $(filter-out -fdata-sections, $(cflags-y))
>>>
>>> (small cflags instead of CFLAGS).
>>>
> 
> Oops indeed.
> 
>> Oh, my mistake, after fixed this bug, still this error:
>>> arm-linux-gnueabi-ld: warning: orphan section `.data.efi_loglevel' from `drivers/firmware/efi/libstub/printk.stub.o' being placed in section `.data.efi_loglevel'
>>> arm-linux-gnueabi-ld: warning: orphan section `.data.screen_info_guid' from `drivers/firmware/efi/libstub/screen_info.stub.o' being placed in section `.data.screen_info_guid'
>>> arm-linux-gnueabi-ld: warning: orphan section `.data.cpu_state_guid' from `drivers/firmware/efi/libstub/arm32-stub.stub.o' being placed in section `.data.cpu_state_guid'
>>> arm-linux-gnueabi-ld: warning: orphan section `.data.efi_nokaslr' from `drivers/firmware/efi/libstub/efi-stub-helper.stub.o' being placed in section `.data.efi_nokaslr'
>>
>> The -fdata-sections option is present in the KBUILD_CFLAGS_KERNEL
>> variable; altering cflags-y only affect the KBUILD_CFLAGS variable.
>> It seems that the -fdata-sections option needs to be removed from the
>> KBUILD_CFLAGS_KERNEL variable.
> 
> Indeed.
> 
> So
> 
> KBUILD_CFLAGS_KERNEL := $(filter-out -fdata-sections,$(KBUILD_CFLAGS_KERNEL))
> 
> (assuming I got it right this time without build testing)

Um, it not worked,too, same error.
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -28,6 +28,7 @@ cflags-$(CONFIG_ARM)          += -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
>                                    -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>                                    -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>                                    $(call cc-option,-mno-single-pic-base)
> +KBUILD_CFLAGS_KERNE            := $(filter-out -fdata-sections, $(KBUILD_CFLAGS_KERNE))
>  cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
>  cflags-$(CONFIG_LOONGARCH)     += -fpie



