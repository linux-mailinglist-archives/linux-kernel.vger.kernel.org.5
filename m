Return-Path: <linux-kernel+bounces-104413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F12787CD71
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AE8285402
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CB724B52;
	Fri, 15 Mar 2024 12:52:09 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F8324A1F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507128; cv=none; b=r8MCKSQEGDQYRq/g8pzdPRAGBU/1UlHeGbSUYqZjQg5gDaMENANV8Nng7E/P/dsatF09kxe8mNSllPVxwAzm1DXHsqSOARlEvwmMqLxFPiJU7bFSho70WZ4zg7q5Wrl1fVXTX9lp1lb88m45wH53DnnCDSF+0mQcGsYwTjosiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507128; c=relaxed/simple;
	bh=5hRpu+BSHB2aXC7FAAHOgQkNNSuLw3DUTtsD/VhVvPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B/XvG1iu5P0s3Kn8vNXPXYsmChgA7QkGTmt4Gg05gdlDxMk+fnGcJBvfIYpQ51QRnILjn8T1v14ivqHw4KddPR2DL8RAh7VlV2PAqrRq5U/cygGmFJtiUtOeMR9LqJHn7KHTT4Z3kJnbombqFPZqKge5tPeiuvM20j8d8pSu0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tx3wn3M8jz2BgQ1;
	Fri, 15 Mar 2024 20:49:29 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 91EE51A0172;
	Fri, 15 Mar 2024 20:51:58 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Mar 2024 20:51:58 +0800
Message-ID: <dc3dad0c-d444-4ea0-8d6f-0a0d850d948d@huawei.com>
Date: Fri, 15 Mar 2024 20:51:58 +0800
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
 <31f3a3fe-b16f-47a9-8c41-80fc0a236d52@huawei.com>
 <CAMj1kXEgQLizmzUwvw79DQ9zkq2L5ed5576MzmYX6uHA5QUh1Q@mail.gmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <CAMj1kXEgQLizmzUwvw79DQ9zkq2L5ed5576MzmYX6uHA5QUh1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/3/15 20:46, Ard Biesheuvel wrote:
> On Fri, 15 Mar 2024 at 13:22, liuyuntao (F) <liuyuntao12@huawei.com> wrote:
>>
>>
>>
>> On 2024/3/15 20:13, Ard Biesheuvel wrote:
>>> On Fri, 15 Mar 2024 at 13:10, liuyuntao (F) <liuyuntao12@huawei.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024/3/15 19:51, Arnd Bergmann wrote:
>>>>> On Fri, Mar 15, 2024, at 12:48, liuyuntao (F) wrote:
>>>>>> On 2024/3/15 18:46, Ard Biesheuvel wrote:
>>>>>>> @@ -28,6 +28,7 @@
>>>>>>>                                        -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>>>>>>>                                        -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>>>>>>>                                        $(call cc-option,-mno-single-pic-base)
>>>>>>> +cflags-$(CONFIG_ARM)           := $(filter-out -fdata-sections, $(CFLAGS-y))
>>>>>>>      cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
>>>>>>>      cflags-$(CONFIG_LOONGARCH)     += -fpie
>>>>>>
>>>>>> Another error:
>>>>>> cannot initialize array of ‘short unsigned int’ from a string literal
>>>>>> with type array of ‘unsigned int’
>>>>>>      17 | static const efi_char16_t shim_MokSBState_name[] = L"MokSBStateRT";
>>>>>
>>>>> The line sets cflags-y to an empty string.
>>>>>
>>>>> It probably should have been
>>>>>
>>>>> cflags-$(CONFIG_ARM)           := $(filter-out -fdata-sections, $(cflags-y))
>>>>>
>>>>> (small cflags instead of CFLAGS).
>>>>>
>>>
>>> Oops indeed.
>>>
>>>> Oh, my mistake, after fixed this bug, still this error:
>>>>> arm-linux-gnueabi-ld: warning: orphan section `.data.efi_loglevel' from `drivers/firmware/efi/libstub/printk.stub.o' being placed in section `.data.efi_loglevel'
>>>>> arm-linux-gnueabi-ld: warning: orphan section `.data.screen_info_guid' from `drivers/firmware/efi/libstub/screen_info.stub.o' being placed in section `.data.screen_info_guid'
>>>>> arm-linux-gnueabi-ld: warning: orphan section `.data.cpu_state_guid' from `drivers/firmware/efi/libstub/arm32-stub.stub.o' being placed in section `.data.cpu_state_guid'
>>>>> arm-linux-gnueabi-ld: warning: orphan section `.data.efi_nokaslr' from `drivers/firmware/efi/libstub/efi-stub-helper.stub.o' being placed in section `.data.efi_nokaslr'
>>>>
>>>> The -fdata-sections option is present in the KBUILD_CFLAGS_KERNEL
>>>> variable; altering cflags-y only affect the KBUILD_CFLAGS variable.
>>>> It seems that the -fdata-sections option needs to be removed from the
>>>> KBUILD_CFLAGS_KERNEL variable.
>>>
>>> Indeed.
>>>
>>> So
>>>
>>> KBUILD_CFLAGS_KERNEL := $(filter-out -fdata-sections,$(KBUILD_CFLAGS_KERNEL))
>>>
>>> (assuming I got it right this time without build testing)
>>
>> Um, it not worked,too, same error.
> 
> Aren't you missing a 'L' ?
> 
>>> --- a/drivers/firmware/efi/libstub/Makefile
>>> +++ b/drivers/firmware/efi/libstub/Makefile
>>> @@ -28,6 +28,7 @@ cflags-$(CONFIG_ARM)          += -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
>>>                                     -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>>>
> 
>>> ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
>>> KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
>>> KBUILD_RUSTFLAGS_KERNEL += -Zfunction-sections=y
>>> LDFLAGS_vmlinux += --gc-sections
>>> endif
>>
>>                                    -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>>>                                     $(call cc-option,-mno-single-pic-base)
>>> +KBUILD_CFLAGS_KERNE            := $(filter-out -fdata-sections, $(KBUILD_CFLAGS_KERNE))
>>>   cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
>>>   cflags-$(CONFIG_LOONGARCH)     += -fpie
>>
>>
Sorry, I was too careless.
How about reset KBUILD_CFLAGS_KERNEL?

> +# KBUILD_CFLAGS_KERNEL is is set by CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
> +# not need here, just reset it.
> +KBUILD_CFLAGS_KERNEL :=
> +
>  # non-x86 reuses KBUILD_CFLAGS, x86 does not
>  cflags-y                       := $(KBUILD_CFLAGS)


