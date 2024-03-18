Return-Path: <linux-kernel+bounces-106656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81887F197
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CC91F22276
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585EC56B7F;
	Mon, 18 Mar 2024 20:53:50 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E726AC7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795229; cv=none; b=nzrdIuEniUST5mxGcl7ZZRwhGwbt8guTjU7DTm1UCbDJZZwIyoehkgzM4alznGXoszpiw9P06QseRD2PmHZ66dLDoX1lrqGIvw/qQmj1Wd+Hf+u9A6a3+i1L2q7vUIKCr4eNWScRvp24cTVGA6AyGExOKGj0ln3PH+gwNR14388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795229; c=relaxed/simple;
	bh=SIy/tUuY7q66cY1sM9aARvm5DKIXY/vZ/C96YA2Pv7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSvsiYedeBFFwXsKL6v/f0v+vonlqV1MScMLsplBsLmBRC0dXC9YKJLIvlhpT3A0Ipt5i7wbeD4qgqgIbdkeICx4FoPjPMz+jLYgelZZdfSf22bXCkNHdvBc56nkJCLZslYUShBOHTzMwIM+kZjIXbh8LMdiNQZhuYF0PON+Vys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA8C01BF205;
	Mon, 18 Mar 2024 20:53:42 +0000 (UTC)
Message-ID: <1a1bf141-9fbf-4d30-bdd3-fd20f6170c3f@ghiti.fr>
Date: Mon, 18 Mar 2024 21:53:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: compat_vdso: install compat_vdso.so.dbg to
 /lib/modules/*/vdso/
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231117125807.1058477-1-masahiroy@kernel.org>
 <CAK7LNAStoCja1gnoFmsKikbzGZmKTcTu+Vc7v9zg8B9hwsH+iQ@mail.gmail.com>
 <CAK7LNATVAcj-pa_G-NGBTr9doCACGk1nKCNbxM50-M0mi9q=7w@mail.gmail.com>
 <ca097f2a-59ec-4945-9860-5e380e1665e4@ghiti.fr>
 <CAK7LNARShVA953-U+p6=wzq3GFsKx4GwpRiqmqftjQz3VkE2VA@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAK7LNARShVA953-U+p6=wzq3GFsKx4GwpRiqmqftjQz3VkE2VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Masahiro,

On 15/03/2024 05:06, Masahiro Yamada wrote:
> On Thu, Mar 7, 2024 at 5:12 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Hi Masahiro,
>>
>> On 24/02/2024 04:37, Masahiro Yamada wrote:
>>> Ping x 2 ?
>>>
>>>
>>>
>>>
>>>
>>> On Sun, Jan 21, 2024 at 6:48 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>> On Fri, Nov 17, 2023 at 9:58 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>>> 'make vdso_install' installs debug vdso files to /lib/modules/*/vdso/.
>>>>>
>>>>> Only for the compat vdso on riscv, the installation destination differs;
>>>>> compat_vdso.so.dbg is installed to /lib/module/*/compat_vdso/.
>>>>>
>>>>> To follow the standard install destination and simplify the vdso_install
>>>>> logic, change the install destination to standard /lib/modules/*/vdso/.
>>>>>
>>>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>>>> ---
>>>> Ping?
>>>> (in case "yet more RISC-V updates" happens)
>>>>
>>>>
>>>>
>>>>
>>>>>    arch/riscv/Makefile | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>>>>> index a74be78678eb..5cbe596345c1 100644
>>>>> --- a/arch/riscv/Makefile
>>>>> +++ b/arch/riscv/Makefile
>>>>> @@ -146,7 +146,7 @@ endif
>>>>>    endif
>>>>>
>>>>>    vdso-install-y                 += arch/riscv/kernel/vdso/vdso.so.dbg
>>>>> -vdso-install-$(CONFIG_COMPAT)  += arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg:../compat_vdso/compat_vdso.so
>>>>> +vdso-install-$(CONFIG_COMPAT)  += arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
>>>>>
>>>>>    ifneq ($(CONFIG_XIP_KERNEL),y)
>>>>>    ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
>>>>> --
>>>>> 2.40.1
>>>>>
>>>> --
>>>> Best Regards
>>>> Masahiro Yamada
>>>
>>> --
>>> Best Regards
>>> Masahiro Yamada
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>> Couldn't changing this library install path break some existing
>> application? I mean it kind of breaks where the library is expected to
>> be right?
>
> Do you have a particular library in mind?


None in particular.


>
>
> RISV-V is the only architecture that installs a debug vdso
> to a different location than the
> standard lib/modules/*/vdso/.
>
>
> I regard this as a fix.


You're probably right, I don't see why the search path would be 
different on riscv, unless it was fixed in userspace but I think this is 
the right thing to do, so:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


>
>
>
>
>

