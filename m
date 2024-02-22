Return-Path: <linux-kernel+bounces-76412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2635F85F6FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD3FB2481A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568714177B;
	Thu, 22 Feb 2024 11:32:14 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D82BB1B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601533; cv=none; b=QBmDKsQQHaUPf8mUwowspMG7RIxcXUGDHOP/NDYvry7nMVfFBUpOcQsRYfkiXdN/4ZIn3nSgPeJnOxj+f4llDSHaXjXg/hwMOxDSYcRUX25slQMC8yPdp2+QeARP/PNdJgYhjPyer2bjXbT8OUExmc7X9YMDQzNBeAIksGc4DFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601533; c=relaxed/simple;
	bh=Ru97uhW4Mp0Hm1f4Ldn5NpBPEkuvDi/mpVqHh4WabRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MB3MpZ5ORUI1oAbc4Lxcl1hUtLrSenWDwFf5aEnfNTeGz/Fs8zNFt3XJbsjH5PuMmEKSuM7PzEu36hzNzX+DIdaavPpyCvKhHjgjT7uql+IA0q+MJ4fRNV5IDurOKZQrpc2Qfmd1tnhHUc/pFlobWNtpOqfGNKb/xjyFMF3ncW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TgWCf6PgVzWv2H;
	Thu, 22 Feb 2024 19:30:22 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id CB500140153;
	Thu, 22 Feb 2024 19:32:03 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Thu, 22 Feb 2024 19:32:03 +0800
Message-ID: <1ae25437-b190-418d-a4e0-aa17d6de59bf@huawei.com>
Date: Thu, 22 Feb 2024 19:32:03 +0800
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
 <f5326293-b446-49e5-9cc0-78c9009af136@app.fastmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <f5326293-b446-49e5-9cc0-78c9009af136@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/2/22 17:52, Arnd Bergmann wrote:
> On Wed, Feb 21, 2024, at 16:51, Arnd Bergmann wrote:
>> I have given your patch some build testing with random
>> configurations in my build setup and it seems to work
>> fine with gcc/binutils, but unfortunately I came across
>> a link failure using clang/lld:
> 
> I ran into another bug now, this time with CONFIG_XIP_KERNEL=y:
> 
> no __ex_table in file: vmlinux
> Failed to sort kernel tables
> make[4]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
> 
> Essentially you have to modify arch/arm/kernel/vmlinux-xip.lds.S
> the same way as vmlinux.lds.S:
>
Thanks a lot. I didn't consider this situation. I will take your advice. 
Thanks again.

> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -63,7 +63,7 @@ SECTIONS
>          . = ALIGN(4);
>          __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
>                  __start___ex_table = .;
> -               ARM_MMU_KEEP(*(__ex_table))
> +               ARM_MMU_KEEP(KEEP(*(__ex_table)))
>                  __stop___ex_table = .;
>          }
>   
> @@ -83,7 +83,7 @@ SECTIONS
>          }
>          .init.arch.info : {
>                  __arch_info_begin = .;
> -               *(.arch.info.init)
> +               KEEP(*(.arch.info.init))
>                  __arch_info_end = .;
>          }
>          .init.tagtable : {
> 
> 
> The pv_table is not needed for XIP_KERNEL=y because that
> requires not patching the kernel.
> 
>      Arnd

