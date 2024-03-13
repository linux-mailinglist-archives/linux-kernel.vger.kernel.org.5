Return-Path: <linux-kernel+bounces-101049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CE387A198
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43311C21F06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE81C122;
	Wed, 13 Mar 2024 02:22:35 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29938BA3F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710296555; cv=none; b=Sdv1ErluBz6jwDRaKtMn4IDUDutOSLplw4AWzQdeFxnWiACaELHa+Dw+wKtX8ntMyHzkjb7NmE1ZiO/VFKsALkAaLO54xS0bQF/+gnMCpuYOwKXt5GTKWcIkvNSN51RMMf639lg/qKT9c+tkQmFNa4/FqaAYaLlGsv/WdlbPLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710296555; c=relaxed/simple;
	bh=HxWnPd4EDKxqzl/N4z6qGCEoGNGUxJts3AUa+k3zarc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=um5ghG3ehdtY1gduYRixYzGgftDa1H29gPeHkuMp4AYmidJmaaWuH8drdSxKYYf8ZusSFRUaVtpFOdKOQYfCxmhv1zmi8DN17kIttctrGCReoBFT3pzpU6yQNgQo4RTHME48BBxfgHmLWcVZKwkdgKuvmyXwoZ7onMyPBxYtjBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TvZ6646Rkz4f3kFW
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:22:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 480D01A0232
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:22:28 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7gDfFlw48hGw--.4220S3;
	Wed, 13 Mar 2024 10:22:25 +0800 (CST)
Subject: Re: ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function
 kallsyms_lookup_name: .text+0x90): relocation R_RISCV_PCREL_HI20 out of
 range: -524416 is not in [-524288, 524287]; references kallsyms_seqs_of_names
To: Yujie Liu <yujie.liu@intel.com>
Cc: kernel test robot <lkp@intel.com>, Zhen Lei <thunder.leizhen@huawei.com>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <202402061302.HkByW9x0-lkp@intel.com>
 <bd30f81c-9e6a-578e-d496-6b7f355a3b79@huaweicloud.com>
 <efdec661-628f-2f6e-cd3e-c66a915d3aa2@huaweicloud.com>
 <Ze/t4Ks0VfCBCXP0@yujie-X299>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <c3cab829-7568-c1b7-bf59-6aa7646cb809@huaweicloud.com>
Date: Wed, 13 Mar 2024 10:22:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Ze/t4Ks0VfCBCXP0@yujie-X299>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAn9g7gDfFlw48hGw--.4220S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1ruw4Uuw4ftFyktw15twb_yoW7GFWDpr
	4kJayqyF4kJr1avwnrtw4Y9FW3tw4kJr4fWa4DKr1UArZ0vr1vvwn2q3y5Cr9xCrn7tw10
	vwsaqFy2kFyUAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/



On 2024/3/12 13:53, Yujie Liu wrote:
> Hi Zhen,
> 
> On Tue, Feb 20, 2024 at 08:27:15PM +0800, Leizhen (ThunderTown) wrote:
>>> On 2024/2/6 13:19, kernel test robot wrote:
>>>> Hi Zhen,
>>>>
>>>> FYI, the error/warning still remains.
>>>
>>> I'm trying to reproduce it. But I'm having a little trouble getting
>>> the environment ready.
>>
>> Sorry, I tried but it was not reproduced. I made the following two changes
>> to the steps in the 'reproduce' link:
>> 1. Put linux and lkp-tests in two directories of the same level. Because:
>>    $ git fetch --no-tags linus master
>>    error: RPC failed; HTTP 403 curl 22 The requested URL returned error: 403
>>    fatal: error reading section header 'acknowledgments'
>> 2. Compiler was specified by following the prompts.
>>    COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang-17 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
>>    COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang-17 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
>>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Sorry for our late reply. We rechecked this case and noticed that this
> issue can be reproduced by clang-15, but can't be reproduced by newer
> version of clang. Not sure if this is a flaw in old version of LLVM
> toolchain, just for your information.

Well, I was able to reproduce it, too, after changing to clang-15.
It should be a problem with the LLVM toolchain. After all, the Linux
source code has not changed. The problem occurs in the linking phase
of Linux, not in the execution phase of Linux. In addition to the few
symbols I added that failed to relocate, the original ones also failed
to relocate. I am not familiar with the source code of the compiler,
so I cannot further analyze the root cause.

Here is a brief description of how kallsyms works. This may help you
understand the problem.
1. Build Linux source code, generate a symbol table.
2. Run tool kallsyms to read above symbol table, rearranges symbol
   information as needed for lookup by name and lookup by address. Record
   these new information into kallsyms_seqs_of_names[], etc. Insert the new
   variables into a new C file.
3. Rebuild Linux with the new C file. The problem is at this stage, for
   those symbols added by tool kallsyms, the relocation fails.

> 
> $ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang-15 ~/lkp-tests/kbuild/make.cross W=1 ARCH=riscv
> ..
>   LD      .tmp_vmlinux.kallsyms1
> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_name: .text+0x70): relocation R_RISCV_PCREL_HI20 out of range: -524416 is not in [-524288, 524287]; references kallsyms_num_syms
>>>> referenced by kallsyms.c
>>>> defined in vmlinux.a(kernel/kallsyms.o)
> 
> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_name: .text+0x90): relocation R_RISCV_PCREL_HI20 out of range: -524416 is not in [-524288, 524287]; references kallsyms_seqs_of_names
>>>> referenced by kallsyms.c
>>>> defined in vmlinux.a(kernel/kallsyms.o)
> ..
> 
> Thanks,
> Yujie
> 
>>
>> Image is finally generated, so there should be no problem with the above steps being adjusted:
>> $ ls build_dir/arch/riscv/boot/
>> dts  Image  loader  loader.bin  loader.lds  loader.o
>>
>> By the way, all the symbols to be reported "relocation R_RISCV_PCREL_HI20 out of range" is
>> generated by the tool kallsyms (scripts/kallsyms.c). So, it seems that the tool kallsyms
>> have not been executed. And this error is not caused by my patches.
>>
>>>
>>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
>>>> commit: 60443c88f3a89fd303a9e8c0e84895910675c316 kallsyms: Improve the performance of kallsyms_lookup_name()
>>>> date:   1 year, 3 months ago
>>>> config: riscv-randconfig-r064-20240120 (https://download.01.org/0day-ci/archive/20240206/202402061302.HkByW9x0-lkp@intel.com/config)
>>>> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
>>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240206/202402061302.HkByW9x0-lkp@intel.com/reproduce)
>>>>
>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>> the same patch/commit), kindly add following tags
>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202402061302.HkByW9x0-lkp@intel.com/
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_name: .text+0x90): relocation R_RISCV_PCREL_HI20 out of range: -524416 is not in [-524288, 524287]; references kallsyms_seqs_of_names
>>>>    >>> referenced by kallsyms.c
>>>>    >>> defined in vmlinux.a(kernel/kallsyms.o)
>>>>
>>>
> 
> .
> 

-- 
Regards,
  Zhen Lei


