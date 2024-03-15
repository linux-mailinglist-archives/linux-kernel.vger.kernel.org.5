Return-Path: <linux-kernel+bounces-104380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332CF87CD0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8CD1F22F36
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE7C1C28B;
	Fri, 15 Mar 2024 12:10:13 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D6F1AAD0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710504612; cv=none; b=nNWK62IMD2CoA14ScBCntbnWK8HUukIqRlixoM95kyPN8Fqnv8hO1BYQmY/+ssAcbDm2I++cgIkEchHVhsBowqKUdLXi5NsiPxfpjWUe1nn0MjBEc4qyPVTE2zD2pUP8QcxyxoxFLO6gVLWOG54AVKDK+/XoITJIt1MMRZ9Omxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710504612; c=relaxed/simple;
	bh=q/8fKxBpy2WLKGEdc5597DHiRCg+9LU28fhtHRHJkRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QaNn8yg0N8wvBek3LGokbwIy8FP87GwmQ/IJCHsSb2efZAdi6WtwbXZDxQBxYzrVR8wfCj5O7+kg3BGSoQD3rbN2H3GyK84p7w5+OetpxeHGeL4/Os2k/31e6/ECeQvIRON6lgvJ2UGPf6ys0Xyi0JLKfVkeiPgHWbDEzU9IuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tx30S6j0zz1h2Q9;
	Fri, 15 Mar 2024 20:07:36 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id CDD7B140124;
	Fri, 15 Mar 2024 20:10:05 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Mar 2024 20:10:05 +0800
Message-ID: <baed1e49-d854-4517-8219-2a5bb0b3cd1b@huawei.com>
Date: Fri, 15 Mar 2024 20:10:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v3] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Russell King
	<linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Kirill A. Shutemov"
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
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <d91cf190-e583-422f-884d-79552b674f72@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/3/15 19:51, Arnd Bergmann wrote:
> On Fri, Mar 15, 2024, at 12:48, liuyuntao (F) wrote:
>> On 2024/3/15 18:46, Ard Biesheuvel wrote:
>>> @@ -28,6 +28,7 @@
>>>                                      -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>>>                                      -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>>>                                      $(call cc-option,-mno-single-pic-base)
>>> +cflags-$(CONFIG_ARM)           := $(filter-out -fdata-sections, $(CFLAGS-y))
>>>    cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
>>>    cflags-$(CONFIG_LOONGARCH)     += -fpie
>>
>> Another error:
>> cannot initialize array of ‘short unsigned int’ from a string literal
>> with type array of ‘unsigned int’
>>    17 | static const efi_char16_t shim_MokSBState_name[] = L"MokSBStateRT";
> 
> The line sets cflags-y to an empty string.
> 
> It probably should have been
> 
> cflags-$(CONFIG_ARM)           := $(filter-out -fdata-sections, $(cflags-y))
> 
> (small cflags instead of CFLAGS).
> 
>       Arnd

Oh, my mistake, after fixed this bug, still this error:
> arm-linux-gnueabi-ld: warning: orphan section `.data.efi_loglevel' from `drivers/firmware/efi/libstub/printk.stub.o' being placed in section `.data.efi_loglevel'
> arm-linux-gnueabi-ld: warning: orphan section `.data.screen_info_guid' from `drivers/firmware/efi/libstub/screen_info.stub.o' being placed in section `.data.screen_info_guid'
> arm-linux-gnueabi-ld: warning: orphan section `.data.cpu_state_guid' from `drivers/firmware/efi/libstub/arm32-stub.stub.o' being placed in section `.data.cpu_state_guid'
> arm-linux-gnueabi-ld: warning: orphan section `.data.efi_nokaslr' from `drivers/firmware/efi/libstub/efi-stub-helper.stub.o' being placed in section `.data.efi_nokaslr'

The -fdata-sections option is present in the KBUILD_CFLAGS_KERNEL 
variable; altering cflags-y only affect the KBUILD_CFLAGS variable.
It seems that the -fdata-sections option needs to be removed from the 
KBUILD_CFLAGS_KERNEL variable.
> ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
> KBUILD_RUSTFLAGS_KERNEL += -Zfunction-sections=y
> LDFLAGS_vmlinux += --gc-sections
> endif



