Return-Path: <linux-kernel+bounces-158318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0018B1E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13041C2150C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B34784E12;
	Thu, 25 Apr 2024 09:41:56 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8B82C63;
	Thu, 25 Apr 2024 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038116; cv=none; b=FsuyhnoESDf8WsYOGRwKpUujmFGFWusZuRXCkGMI/DhtSuszr/Ojj/phixxfOBvoyc91C4YO4+UXPUza0L8DY9hok3qBIUwniHJhaPjLGFo83hIHlEQg51JfI4hMGy2KIG+WpvhvR71UzXExeGXUpce2UEnqLne92toNn7YD1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038116; c=relaxed/simple;
	bh=wW/rEmQa/FQzNN3B8HIL7yKrYiJF1G+LyBR+i/qBJxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AFIIHwDkuvAG3X2q6idL18cebnkuWHIKELsmshWeBj74HSKrPJSi55R69j4NhQxJnXqU20lMyGnD2kajX4Y2gpV6Pyc3/as65uqJ+ZHmbDon7ym7HjBv9XMiQHN0ghFSA9gipsc70eEAWT4NJLNxKolA9LxIlaR59s/B0wpkae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VQ9lW3xq3zwSQj;
	Thu, 25 Apr 2024 17:38:31 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F092140257;
	Thu, 25 Apr 2024 17:41:43 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:41:43 +0800
Message-ID: <75734e13-1f46-4cd4-85b5-d4074c242606@huawei.com>
Date: Thu, 25 Apr 2024 17:41:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <masahiroy@kernel.org>,
	<nathan@kernel.org>, <nicolas@fjasle.eu>, <peterz@infradead.org>,
	<jpoimboe@kernel.org>, <leitao@debian.org>, <petr.pavlu@suse.com>,
	<richard.weiyang@gmail.com>, <ruanjinjie@huawei.com>,
	<ndesaulniers@google.com>, <jgross@suse.com>
References: <20240422060556.1226848-1-liuyuntao12@huawei.com>
 <8cb7f43e-0ee9-423d-ad27-93b3c69809f5@intel.com>
 <d129733e-6c53-41b9-ae23-4a97c4eb5a30@huawei.com>
 <fa7f3c1b-7693-465c-9f24-e6176074a818@intel.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <fa7f3c1b-7693-465c-9f24-e6176074a818@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/4/25 17:21, Alexander Lobakin wrote:
> From: Liuyuntao (F) <liuyuntao12@huawei.com>
> Date: Thu, 25 Apr 2024 14:37:19 +0800
> 
>>
>>
>> On 2024/4/24 19:06, Alexander Lobakin wrote:
>>> From: Yuntao Liu <liuyuntao12@huawei.com>
>>> Date: Mon, 22 Apr 2024 06:05:56 +0000
>>>
>>>> The current x86 architecture does not yet support the
>>>> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. x86 is widely used in
>>>> embedded scenarios, and enabling this feature would be beneficial for
>>>> reducing the size of the kernel image.
>>>>
>>>> In order to make this work, we keep the necessary tables by annotating
>>>> them with KEEP, also it requires further changes to linker script to
>>>> KEEP
>>>> some tables and wildcard compiler generated sections into the right
>>>> place.
>>>>
>>>> Enabling CONFIG_UNWINDER_ORC or CONFIG_MITIGATION_RETPOLINE will enable
>>>> the objtool's --orc and --retpoline parameters, which will alter the
>>>> layout of the binary file, thereby preventing gc-sections from
>>>> functioning
>>>> properly. Therefore, HAVE_LD_DEAD_CODE_DATA_ELIMINATION should only be
>>>> selected when they are not enabled.
>>>
>>> Dunno, I have DCE enabled for years on my home kernel, see commit [0]
>>> with both ORC and retpolines enabled, and I didn't have any issues.
>>> vmlinux still shrinks well, even with Clang LTO.
>>>
>>>>
>>>> Enabling CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT will use vmlinux.o
>>>> instead of performing the slow LTO link again. This can also prevent
>>>> gc-sections from functioning properly. Therefore, using this
>>>> optimization
>>>> when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled.
>>>>
>>>> The size comparison of zImage is as follows:
>>>> x86_def_defconfig  i386_defconfig    tinyconfig
>>>> 10892288           10826240          607232          no dce
>>>> 10748928           10719744          529408          dce
>>>> 1.3%               0.98%             12.8%           shrink
>>>>
>>>> When using smaller config file, there is a significant reduction in the
>>>> size of the zImage.
>>>
>>> [0] https://github.com/solbjorn/linux/commit/25c4953ea73d
>>>
>>> Thanks,
>>> Olek
>>
>> I apply your patch, and use LLVM toolchain to compile the kernel, it not
>> boot on QEMU.
>> I use the following command.
>>> qemu-system-x86_64  -smp 2 -m 1024M -nographic -kernel
>>> mainline_linux/arch/x86/boot/bzImage -hda rootfs.img -append
>>> "root=/dev/sda console=ttyS0 rootfstype=ext4 init=/linuxrc rw"
>> Have you tested your patch on the latest mainline version?
> 
> Nope, it was a year ago and I haven't touched it since then. Did the
> low-level code change a lot?
> 
No, I'm not yet certain what changes have had an impact on it compared 
to a year ago.

