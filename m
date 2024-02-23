Return-Path: <linux-kernel+bounces-77879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25D1860B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF9F286A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEA114AA5;
	Fri, 23 Feb 2024 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qN3T5YTA"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702714A97;
	Fri, 23 Feb 2024 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674137; cv=none; b=cqAcjrqZGaYacROGRAoUM2srcZpMUGhu5M/izH8GaCF8dMm0NEW3fuVBaTaIeqPdzWHvulkf4pWDoGgoLlHB5L77cW5lRz6e89fzKQdGKJJcU0gYLmQ0Ngr/u77C8gzGF1FFh20JM7wPhLG41GC67l221tSGRZ4gyR0tKPOWey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674137; c=relaxed/simple;
	bh=X/HfkNoIsZIA2WUiUQsTtGrTYosTOeh3e7DouVdGKdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uycxif/jQ8Jih5jRdmvfGxoAIKwP2zrWCQvW/nhF1jb962prU87XAjFwxeoPnOJGcG9gz5fiDLxepSCp0652+A4nnVLiwXdmBhRnF73yJutPSPKiPgpDi2TxKAA9PZ7m+FqUO6gJG/oPW4bo52xQG1zcux0RAberPRM8dUrO+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qN3T5YTA; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708674128; bh=YXnG5fEDtM+6RtdjP87+kyRIjzeA5LXBtWsYu4f14e0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=qN3T5YTAcysxpY8Rcm/DnVpNldg9XVRg195403N9I0AZDR+53Oe+FglsEx2MelWo6
	 1702VX19TCP3ukFJ4IYJKSHLJs5ECrni9L8k0R0Q7v551ZLVNpsyg6LuXl5EEtgAFH
	 HOW5Cmdzu27GrsmZt4jilYIQ2YToIEipVPFXejxY=
Received: from [IPV6:240e:379:2240:ef00:31b1:ab4c:ce31:8de] ([240e:379:2240:ef00:31b1:ab4c:ce31:8de])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id A85A68C5; Fri, 23 Feb 2024 15:42:05 +0800
X-QQ-mid: xmsmtpt1708674125t1nearaiv
Message-ID: <tencent_AF1B1DF96C041FB57D1C4770356254431E09@qq.com>
X-QQ-XMAILINFO: MtZ6QPwsmM9XG2lZC8wPC+kOglompLuyy3Hs3xP4ictaHpjCY2eWtvnfejiMUL
	 mLhFgpqsPFFQ9Vgiqo3bRyheW+Rsfw+9lU1oD68pVJvF4evnnYe5SB+RkMmcEcg+D9dP3pIEMSRF
	 69C+yzlU9KF2oLDzhBYK0Y3wBsaqFG4wYzT9Z9sNvnZ1X4GDverPVrAwfAWEr9nP8eBtKWCFOb1q
	 VOsaJNOnoI4dFtM/+r31M0R0uRCo9xrvUsshC8YJifWTFXXzA+mhjjMlLBEWeMXINvOw81BFeX+D
	 qF1QAdV5aySQRgVqyDw5dRwusrqOlOFr9EkqlraxOtuwOwPW6NAne0RftmNJ3MzamCbP6HyQe/MC
	 2/59j6EW5wb+tYaiei8dzMU6Mp3ajKrk0z4A8TDV0M9Q8x8GANt8B/+r6YKgU+75pTOhISsTEMRR
	 NxpRaKvulLrXQgcvxFxs2mE2dNoFGbUrejfNl1wsdfEYTooDKGqEDSS/1yHrM3g3jPiwseeouVyD
	 3ToBs+C2lYVgoI28erXvRLSL0ghJvoWRohYyRdTC7LleiWt/uuuGe2iqbvbZmUyROk4vMCC3H0Su
	 eqex1rpufPXgRowmruuZmtprHp+4gxqUn9SEoA+Qz87tAY9JLq7MFi84ZjrY0eFGOXIVpVg7ww4p
	 DNeofRyakw2pgjgR0/LrMxdsXCk9uZ+/cehISvg9uY5drKi++/6rbMj8MIgHc/jiB86tc+G3gr9s
	 zlTOI3rBfn9Xpi/Coq4+/IxOTJEnSmX3u2WwqFXr3FzuX8BcBUlNX1hzPIJPfJYCpriIhDdIviqH
	 +dyePRI1QUyVgax/lzuiKjgNbXLBvqxUKgS6D2tIsI8afVx/hEKamBkuJDk4Yau2GnZTSceusPJp
	 mbVeIFucIcQgYm/+LcFpA1PjO3u5MYtSev8JzVhvcPhvBl+Zrp4hEWwvcu28rqAWPUIDw7ILYadv
	 9PGzlUHd4kFBIkIOrul7TynMKZ8kRFo6ltvgMA6PE8HdIYSoQQCjI1Ge/0ZQyf
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-OQ-MSGID: <8d86901e-af15-46a0-b307-c491efce85e3@cyyself.name>
Date: Fri, 23 Feb 2024 15:42:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] riscv: dts: Allow BUILTIN_DTB for all socs
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
 <20240221-islamic-quartered-3863e44bc862@spud>
 <tencent_DF3D7C2E8248DA188E3FB8DF31FE21478D08@qq.com>
 <20240222-crawlers-prankish-ecf425d1f0b5@spud>
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240222-crawlers-prankish-ecf425d1f0b5@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/23 04:59, Conor Dooley wrote:
> On Wed, Feb 21, 2024 at 10:28:08PM +0800, Yangyu Chen wrote:
>> On Wed, 2024-02-21 at 11:30 +0000, Conor Dooley wrote:
>>> Hey,
>>>
>>> On Wed, Feb 21, 2024 at 03:01:53AM +0800, Yangyu Chen wrote:
>>>> The BUILTIN_DTB kernel feature on RISC-V only works on K210 SoC
>>>> only. This
>>>> patch moved this configuration to entire riscv.
>>>
>>> To be honest, I would rather delete BUILTIN_DTB (and the
>>> configurations
>>> that depend on it) than expand its usefulness.
>>>
>>
>> I agree it’s useless for most platforms because we need to start SBI
>> before kernel on RISC-V except NOMMU M-Mode Linux and SBI also need a
>> DT to work. However, it has been there for M-Mode K210 and it is set by
>> default for XIP kernel. So there might eventually be another patch to
>> support some new soc that will do this like this patch.
> 
> To be clear, I was not suggesting that it was useless. I was saying that
> I would rather reduce the number of configurations that use builtin dtbs
> than increase the level of support for it.
> 

I see.

>>
>>>> Although BUILTIN_DTB is not a good choice for most platforms, it is
>>>> likely
>>>> to be a debug feature when some bootloader will always override
>>>> something
>>>> like the memory node in the device tree to adjust the memory size
>>>> from SPD
>>>> or configuration resistor, which makes it hard to do some
>>>> debugging.
>>>
>>> My inclination here is to say "fix your bootloader" and if that's not
>>> possible, chainload a bootloader that allows you control over
>>> modifications to your devicetree.
>>>
>>
>> Chainload a bootloader like S-Mode U-Boot on some platforms is hard due
>> to some drivers like pcie controller does not come to the mainline repo
>> of the bootloader, and some bootloader source repos provided by the
>> vendor may require specific versions of the compiler to work, which
>> makes users not easy to do some kernel debugging if change DT is
>> needed. The simplest way to do this I can imagine is to write a simple
>> bootloader by myself link the kernel binary and the dtb I want to it
>> and replace the a1 register point to the dtb address before jumping to
>> the kernel. However, kernel has this feature, why should I do it
>> manually rather than provide a more generic patch for everyone with
>> this need to use?
>>
>>>> As an
>>>> example, some platforms with numa like sg2042 only support sv39
>>>> will fail
>>>> to boot when there is no ZONE_HIGHMEM patch with 128G memory. If we
>>>> want
>>>> a kernel without this patch to boot, we need to write the memory
>>>> nodes
>>>> in the DT manually.
>>>
>>> If, as Alex suggests, there's a way to gain support some more memory
>>> in
>>> sv39, we should do so - but it is worth mentioning that highmem is on
>>> the
>>> removal list for the kernel, so mainline support for that is highly
>>> unlikely.
>>>
>>
>> Yes. But I’m debugging some mm performance issues on the sg2042 kernel.
>> Specifically, it’s about the IPI latency when doing rfence on
>> sfence.vma or fence.i. I would like to reduce the memory size and allow
>> the mainline kernel to boot and test without taking some out-of-tree
>> kernel patches. If I remove some DIMM modules from the board to reduce
>> the memory size, it will also lose some memory channels and even leave
>> some numa nodes with zero memory, and the compatible DIMM module is
>> hard to find.
> 
> I'm not really sure how this relates to my comment about HIGHMEM. If
> Alex is able to give you the extra 4 GiB of memory that he says there is
> space for in the memory map, will the device boot properly?
> 

That is I said I want "mainline kernel to boot and test without taking 
some out-of-tree kernel patches" as it doesn't come to mainline now. And 
I don't see any performance issues on sifive socs with the mainline 
kernel, but it doesn't have many cores like sg2042 either. Whatever, it 
is a reason for simplifying the debug process on performance, not for 
getting 128G memory on sg2042 boot properly.

>>>> Also, changing DT on some platforms is not easy. For Milk-V
>>>> Pioneer, the
>>>> boot procedure is ZSBL -> OpenSBI -> LinuxBoot -> Linux. If DT gets
>>>> changed, OpenSBI or LinuxBoot may refuse to boot. And there is some
>>>> bug on
>>>> LinuxBoot now which does not consume --dtb argument on kexec and
>>>> always
>>>> uses DT from memory.
>>>
>>> I don't use Linuxboot, but let me try to understand. Linuxboot uses
>>> kexec
>>> to boot the main Linux kernel, but the dtb you want to use is not
>>> used, and
>>> instead the one that Linuxboot itself was booted with is used?
>>>
>>> It sounds like Linuxboot has a --dtb argumet that is meant to be used
>>> to
>>> set the dtb for the next stage, but that argument is being ignored?
>>>
>>
>> Yes. That’s correct.
>>
>>> That sounds like a pretty serious issue with Linuxboot which should
>>> be
>>> fixed - what am I missing?
>>>
>>
>> Sure, that should be fixed in the LinuxBoot. However, I think not every
>> kernel developer should fix some complex bootloader like LinuxBoot
>> which is built upon the linux kernel with a huge initrd rootfs and runs
>> some userspace tools to support the boot process. If something is hard
>> to control, skip it, and doing some override for debugging will be a
>> better choice.
> 
> Has anyone even /reported/ the issues with LinuxBoot to the LinuxBoot
> developers? Without that being fixed, there's unlikely to ever be
> mainstream distro support for it, since they're going to have to build
> kernels for it alone.
> 

I created a github issue on sophgo/bootloader-riscv [1] . Seems no body 
reported it before. Yeah it will be better to fix LinuxBoot to solve my 
own need for debugging.

>>>> So I would like to do debugging on DT using
>>>> BUILTIN_DTB, which makes it very simple,
>>>
>>>> I can even install the kernel in
>>>> the distro's way and provide a kernel package for other users to
>>>> test.
>>>
>>> I'm not sure what you mean by this, other distros manage to create
>>> kernel packages without using builtin dtbs.
>>>
>>
>> I mean I can provide a distro package like Debian .deb and distribute
>> it to other users to test without changing their dtb from the entire
>> boot process.
> 
> Other distros, like Ubuntu, manage to do this without relying on builtin
> dtbs. I suppose this comes down to having bootloaders that
> 
>> Because changing the DT from the entire boot process
>> might prevent their vendor-provided OpenSBI or LinuxBoot from working.
>> Some vendor kernels may be developed out-of-tree and do not use the dt-
>> binding from mainline. Even for very basic CLINT and PLIC dt bindings.
> 
> Which is verging on ridiculous at this point. Does the sg2042 also have
> a version of OpenSBI that is not capable of booting a mainline kernel?
> 

Yes, their vendor provided old OpenSBI can not parse aclint dt binding 
from the mainline dts, so there will be no timer for OpenSBI and refused 
to boot. That can be solved if I change the dt and use mainline opensbi 
and cherry-pick some vendor patches to get this work.

>> It is only for testing, not for the production environment.
> 
> If things are just for testing, I'm not particularly keen on merging on
> that basis alone. We all have various bits of testing code that doesn't
> end up being merged to mainline. That said, it is broken at present and
> its hard to argue against fixing it and any patch fixing it would
> ultimately look very similar to your patch here.
> 

OK. You convinced me for this reason.

>> I want this feature to allow more people to participate in debugging
>> some kernel issues without taking a huge amount of time to deal with
>> bootloader issues about changing the DT. I think it will be good for
>> our under-development RISC-V community.
> 
> And on the other hand, it provides no incentive for vendors to fix
> broken bootloaders or firmware, which is some we suffer from on RISC-V,
> in particular vendors that ship T-Head's vendor copy of OpenSBI.
> 

That's true.

>> Imagine we hardly change the
>> ACPI table for x86 machines but we sometimes change the DT for
>> ARM/RISC-V board, right?
> 
> Usually we change them because nobody gets things "right" and we end up
> having different stuff in mainline to what the vendor did. Usually also
> a vendor has a relatively complete description in their vendor tree, but
> things only trickle into mainline, so mainline ends up requiring regular
> dtb updates until a platform stabilises. More infrequently, changes are
> needed for bugfixes.
> 
> The other thing you do is compare to the ACPI table. I don't think it is
> quite apples to apples there - those machines mostly have devices on
> discoverable buses etc. If they had the same number of non discoverable
> devices, I think you'd end up having to do more BIOS updates etc.
> 

OK.

>> Also, some SoCs that run M-Mode NOMMU Linux
>> may need it in the future like K210 for XIP without a prior bootloader.
> 
> And the k210 is one of the things that is on the chopping block at the
> moment. It's removal was discussed at LPC this year, with Damien
> surprisingly agreeing to its removal. FWIW, builtin dtb is not required
> for XIP.
> 
> BTW, I noticed that your patch only removes one of the $(addsuffix)
> calls in a platform makefile.
> Thanks,
> Conor.

To sum up, I agree with the reasons to refuse it for debugging purposes. 
I am wondering what to do next. After reviewing the code carefully, I 
found this feature not only for K210 but also for other SoCs. But for 
other SoCs, it is broken as it will link multiple dtbs to the kernel, 
but the kernel will always pick up the first dtb to use as discussed on 
this thread [2]. That is because SOC_BUILTIN_DTB_DECLARE is removed from 
this patch [3] then no code to select for multiple dtbs now. And 
makefiles on other soc which is on the mainline kernel currently will 
build every dtb object file from this patch [4]. So this feature for 
other SoCs is broken now.

Choices might be one of the following:

1. Remove BUILTIN_DTB feature if K210 support get removed
2. Continue to add this feature to get this work for other socs

I prefer to continue to get this feature to work. Not only for my 
debugging purposes but also for fixes.

[1] https://github.com/sophgo/bootloader-riscv/issues/73
[2] 
https://lore.kernel.org/linux-riscv/CAK7LNATt_56mO2Le4v4EnPnAfd3gC8S_Sm5-GCsfa=qXy=8Lrg@mail.gmail.com/
[3] 
https://lore.kernel.org/linux-riscv/20201208073355.40828-5-damien.lemoal@wdc.com/
[4] 
https://lore.kernel.org/linux-riscv/20210604120639.1447869-1-alex@ghiti.fr/


