Return-Path: <linux-kernel+bounces-72749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F7F85B84A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169391C2376A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B22612D6;
	Tue, 20 Feb 2024 09:53:08 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA29D612CB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422787; cv=none; b=qkP5596y3zqj6k8+3bBGbMEfgjnPmzvAdku4l4N5Zr5/KN8bsv7sRdjrcMbcV/U/Jv8qk5EMxELU42M9zbQ+7KXAzqscOUXzXy3kLkxV30vPhWLfPYE9Wf286szK9XQR85raIwO7Cz7+rBNjcTRuQPbJwvRNESNT9EO3ytZ2XC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422787; c=relaxed/simple;
	bh=EqZc8nDomBp+9zFhAQ4weco20HpKIImPlI4qOduJTAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A8KYyO6x8/ci4HxRkuGhZUSUew3tWDoaCz5kcJixtPvdubo1YrTGjIDDa9RA+NNv4vxK/IRP25h79LszYVZ2vckA78IbfGk9UykpkcsDecJ1GCcROxUhp0AjdsL6yjPty9BI6jqGpJfi/iw0b8xylYXCy0GUk5scYFDNiCoKuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TfF6M2GjYz1Q8rx;
	Tue, 20 Feb 2024 17:51:23 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B556140154;
	Tue, 20 Feb 2024 17:53:01 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 20 Feb 2024 17:53:01 +0800
Message-ID: <38c09a4b-69cc-4dc5-8a68-e5f5597613ac@huawei.com>
Date: Tue, 20 Feb 2024 17:53:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
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
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <1342759e-b967-4ec4-98d5-48146f81f695@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd100004.china.huawei.com (7.185.36.20)



在 2024/2/20 16:40, Arnd Bergmann 写道:
> On Tue, Feb 20, 2024, at 09:15, Yuntao Liu wrote:
>> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S
>> b/arch/arm/boot/compressed/vmlinux.lds.S
>> index 3fcb3e62dc56..da21244aa892 100644
>> --- a/arch/arm/boot/compressed/vmlinux.lds.S
>> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
>> @@ -89,7 +89,7 @@ SECTIONS
>>        * The EFI stub always executes from RAM, and runs strictly before
>> the
>>        * decompressor, so we can make an exception for its r/w data, and
>> keep it
>>        */
>> -    *(.data.efistub .bss.efistub)
>> +    *(.data.* .bss.*)
>>       __pecoff_data_end = .;
>>
>>       /*
> 
> This doesn't seem right to me, or maybe I misunderstand what
> the original version does. Have you tested with both
> CONFIG_EFI_STUB on and off, and booting with and without
> UEFI?

Yes, I have tested with CONFIG_EFI_STUB on and off, and booting with 
UEFI on a single-board computer, and it boots well.


> 
> If I read this right, you would move all .data and .bss
> into the stub here, not just the parts we actually want?

In the file "drivers/firmware/efi/libstub/Makefile", it is written:

---

#
# ARM discards the .data section because it disallows r/w data in the
# decompressor. So move our .data to .data.efistub and .bss to .bss.efistub,
# which are preserved explicitly by the decompressor linker script.
#
STUBCOPY_FLAGS-$(CONFIG_ARM)	+= --rename-section .data=.data.efistub	\
				   --rename-section .bss=.bss.efistub,load,alloc

---

I think that .data.efistub represents the entire .data section, the same 
applies to .bss as well,

so i move all .data and .bss into the stub here.


> 
>> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
>> index bd9127c4b451..de373c6c2ae8 100644
>> --- a/arch/arm/kernel/vmlinux.lds.S
>> +++ b/arch/arm/kernel/vmlinux.lds.S
>> @@ -74,7 +74,7 @@ SECTIONS
>>   	. = ALIGN(4);
>>   	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
>>   		__start___ex_table = .;
>> -		ARM_MMU_KEEP(*(__ex_table))
>> +		ARM_MMU_KEEP(KEEP(*(__ex_table)))
>>   		__stop___ex_table = .;
>>   	}
>>
>> @@ -116,7 +116,7 @@ SECTIONS
>>   #endif
>>   	.init.pv_table : {
>>   		__pv_table_begin = .;
>> -		*(.pv_table)
>> +		KEEP(*(.pv_table))
>>   		__pv_table_end = .;
>>   	}
> 
> I guess this prevents discarding any function that has a reference
> from pv_table or ex_table, even if there are no other references,
> right?

Indeed so, if not keep ex_table,  the compilation process will result in

an error:

     no __ex_table in file: vmlinux

     Failed to sort kernel tables

and if not keep pv_table, It can be compiled successfully, but the QEMU 
boots will fail.

> 
> I don't know how to solve this other than forcing all the
> uaccess and virt_to_phys functions to be out of line
> helpers. For uaccess, there are probably very few functions
> that need this, so it should make little difference.
> 
> You might want to try changing CONFIG_ARM_PATCH_PHYS_VIRT
> into a method that just always adds an offset from C code
> instead of the boot time patching. That way the code would
> be a bit less efficient but you might be able to get
> a larger size reduction by dropping additional unused code.
> 
> Maybe test your patch both with and without
> ARM_PATCH_PHYS_VIRT to see what the best-case impact would
> be.
> 

This is a very good idea, I will give it a try.

>        Arnd

