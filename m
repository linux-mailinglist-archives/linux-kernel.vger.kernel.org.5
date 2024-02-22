Return-Path: <linux-kernel+bounces-76400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A453785F6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909FFB24682
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4826441760;
	Thu, 22 Feb 2024 11:24:38 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B24208A2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601077; cv=none; b=oZTv0G3XStfA/kCmuCMUaLkrdjzDFdFaofSWByJOCmIuWM8vU8xbHFmsw5iXJDjdc2nERRIWh36bE7Rk9/pLNXSfV2+eHOLuLjLWlaGZvAzn0C/sbPRVBmmolNrixyt+FK0DcEhGpI06wm8vsakTFwPay3WW5YrEKz9SvNQjw0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601077; c=relaxed/simple;
	bh=XSWrT4vhDDZQQFkdf5r2ThuCC+DV6wwXukBRRgo6keg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=loyrCNphr0AwnIySM96gepK5fRVmwCO/ReFFIeE2pEmGqYo36D1MY31HSNbLNm5ZqJByodamyZbEZUBZxIAqPu2eUReA5n4Jw9wqNoAwZjVVZMFzq8iQwg6SqM5An+uyjHLnRZxGc4L38/PHZ7GFgoanRitX+K8EqnLgMFbg9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TgW2N6nZWz1X3C5;
	Thu, 22 Feb 2024 19:22:20 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 13A1314011F;
	Thu, 22 Feb 2024 19:24:31 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Thu, 22 Feb 2024 19:24:30 +0800
Message-ID: <4e9396ca-460b-49ca-818e-73f0a8997b15@huawei.com>
Date: Thu, 22 Feb 2024 19:24:30 +0800
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
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <30b01c65-12f2-4ee0-81d5-c7a2da2c36b4@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/2/21 23:51, Arnd Bergmann wrote:
> I have given your patch some build testing with random
> configurations in my build setup and it seems to work
> fine with gcc/binutils, but unfortunately I came across
> a link failure using clang/lld:
> 
> ld.lld: error: ./arch/arm/kernel/vmlinux.lds:35: ( expected, but got }
>>>>   __vectors_lma = .; OVERLAY 0xffff0000 : AT(__vectors_lma) { .vectors { KEEP(*(.vectors)) } .vectors.bhb.loop8 { KEEP(*(.vectors.bhb.loop8)) } .vectors.bhb.bpiall { KEEP(*(.vectors.bhb.bpiall)) } } __vectors_start = LOADADDR(.vectors); __vectors_end = LOADADDR(.vectors) + SIZEOF(.vectors); __vectors_bhb_loop8_start = LOADADDR(.vectors.bhb.loop8); __vectors_bhb_loop8_end = LOADADDR(.vectors.bhb.loop8) + SIZEOF(.vectors.bhb.loop8); __vectors_bhb_bpiall_start = LOADADDR(.vectors.bhb.bpiall); __vectors_bhb_bpiall_end = LOADADDR(.vectors.bhb.bpiall) + SIZEOF(.vectors.bhb.bpiall); . = __vectors_lma + SIZEOF(.vectors) + SIZEOF(.vectors.bhb.loop8) + SIZEOF(.vectors.bhb.bpiall); __stubs_lma = .; .stubs ADDR(.vectors) + 0x1000 : AT(__stubs_lma) { *(.stubs) } __stubs_start = LOADADDR(.stubs); __stubs_end = LOADADDR(.stubs) + SIZEOF(.stubs); . = __stubs_lma + SIZEOF(.stubs); PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
>>>>                                                                                            ^
> 
> I don't immediately see what the problem is here, I hope you
> can address it before you send a v2.
> 
>       Arnd

I reproduced this issue with make LLVM=1 ARCH=arm -j320 > ../make.txt.
Based on the position of the caret, I speculate that the issue arises from
lld's inability to recognize the KEEP() command preceding the OUTPUT
section in the OVERLAY command.
 >
The full syntax of the OVERLAY command is as follows: OVERLAY [start] : 
[NOCROSSREFS] [AT ( ldaddr )] { secname1 { output-section-command 
output-section-command … } [:phdr…] [=fill] secname2 { 
output-section-command output-section-command … } [:phdr…] [=fill] … } 
[>region] [:phdr…] [=fill] [,]
 >
I attempted to modify KEEP(*(.vectors)) to KEEP(*(.vectors))(.vectors),
and received the following error message:
ld.lld: error: ./arch/arm/kernel/vmlinux.lds:36: ( expected, but got } > 
__vectors_lma = .; OVERLAY 0xffff0000 : AT(__vectors_lma) { .vectors { 
KEEP(*(.vectors))(.vectors) } .vectors.bhb.loop8 { 
KEEP(*(.vectors.bhb.loop8)) } .vectors.bhb.bpiall { 
KEEP(*(.vectors.bhb.bpiall)) } } __vectors_start = LOADADDR(.vectors); 
__vectors_end = LOADADDR(.vectors) + SIZEOF(.vectors); 
__vectors_bhb_loop8_start = LOADADDR(.vectors.bhb.loop8); 
__vectors_bhb_loop8_end = LOADADDR(.vectors.bhb.loop8) + 
SIZEOF(.vectors.bhb.loop8); __vectors_bhb_bpiall_start = 
LOADADDR(.vectors.bhb.bpiall); __vectors_bhb_bpiall_end = 
LOADADDR(.vectors.bhb.bpiall) + SIZEOF(.vectors.bhb.bpiall); . = 
__vectors_lma + SIZEOF(.vectors) + SIZEOF(.vectors.bhb.loop8) + 
SIZEOF(.vectors.bhb.bpiall); __stubs_lma = .; .stubs ADDR(.vectors) + 
0x1000 : AT(__stubs_lma) { *(.stubs) } __stubs_start = LOADADDR(.stubs); 
__stubs_end = LOADADDR(.stubs) + SIZEOF(.stubs); . = __stubs_lma + 
SIZEOF(.stubs); PROVIDE(vector_fiq_offset = vector_fiq - 
ADDR(.vectors)); > ^
The position of the caret has been moved below the right brace
of { KEEP(*(.vectors.bhb.loop8)) }, indicating that lld is treating
the entire `KEEP(*(.vectors))` as a file name. This could potentially be 
a bug in lld. Perhaps we can temporarily
enable the DCE option only when option LD_IS_LLD is disabled,
like risc-v:
`select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD`.

