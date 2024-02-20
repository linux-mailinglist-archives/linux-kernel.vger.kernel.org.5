Return-Path: <linux-kernel+bounces-73011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7950D85BC11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189631F2323A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317EA67E92;
	Tue, 20 Feb 2024 12:27:27 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B2667C71
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432046; cv=none; b=MlSBLWjx6uv4lMhRDasoqcdOUWlxSFNgEffwqRCj/n3rBx74UxxZSqP9rHQExEZLp1KQgDq+A/txDePs6LoGkSX9rI7ePzt4v5Zxjj4uZgTc3Zz8s4pVhqfMqYiJFIBRGM7Yw6+0NLE1u/JR2h2vw+y59lwgFvZJXUvSA+cQadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432046; c=relaxed/simple;
	bh=71ZA9CBF48Rq8EQ+Tvb9rXsWDLMMNDTL1iz93c3jvkc=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AzLzp/4hcxckLKq65nAKtr2NjrnZxc+tPfU9GOu3F3OnK4flC9eNxSXD0DJtXCI5BA+Daq//7FYapC8IyXTB+vSqTlVMZ1n4B3/wu5niftP46L5W6QN4oGFx/7ju5IO8TjU13L4CSkZoPLIjvhxNRNqMWgCulxUB/Tayxom46Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TfJZC5L5Gz4f3jXP
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:27:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AD51C1A0172
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:27:20 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBGkmtRlQcBmEg--.23538S3;
	Tue, 20 Feb 2024 20:27:17 +0800 (CST)
Subject: Re: ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function
 kallsyms_lookup_name: .text+0x90): relocation R_RISCV_PCREL_HI20 out of
 range: -524416 is not in [-524288, 524287]; references kallsyms_seqs_of_names
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
To: kernel test robot <lkp@intel.com>, Zhen Lei <thunder.leizhen@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <202402061302.HkByW9x0-lkp@intel.com>
 <bd30f81c-9e6a-578e-d496-6b7f355a3b79@huaweicloud.com>
Message-ID: <efdec661-628f-2f6e-cd3e-c66a915d3aa2@huaweicloud.com>
Date: Tue, 20 Feb 2024 20:27:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bd30f81c-9e6a-578e-d496-6b7f355a3b79@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXKBGkmtRlQcBmEg--.23538S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF48Wr15Kw4DAryDtw45GFg_yoW5WFy5pF
	4DJa90yF4kKr1Syws7K398Ca45tw4DJa1fGa4DJr1UZrWDZr10va4Igw45AF9Fkrn2krWr
	Zrs2qa4SkFyUZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/



On 2024/2/18 10:08, Leizhen (ThunderTown) wrote:
> 
> 
> On 2024/2/6 13:19, kernel test robot wrote:
>> Hi Zhen,
>>
>> FYI, the error/warning still remains.
> 
> I'm trying to reproduce it. But I'm having a little trouble getting
> the environment ready.

Sorry, I tried but it was not reproduced. I made the following two changes
to the steps in the 'reproduce' link:
1. Put linux and lkp-tests in two directories of the same level. Because:
   $ git fetch --no-tags linus master
   error: RPC failed; HTTP 403 curl 22 The requested URL returned error: 403
   fatal: error reading section header 'acknowledgments'
2. Compiler was specified by following the prompts.
   COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang-17 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
   COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang-17 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Image is finally generated, so there should be no problem with the above steps being adjusted:
$ ls build_dir/arch/riscv/boot/
dts  Image  loader  loader.bin  loader.lds  loader.o

By the way, all the symbols to be reported "relocation R_RISCV_PCREL_HI20 out of range" is
generated by the tool kallsyms (scripts/kallsyms.c). So, it seems that the tool kallsyms
have not been executed. And this error is not caused by my patches.

> 
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
>> commit: 60443c88f3a89fd303a9e8c0e84895910675c316 kallsyms: Improve the performance of kallsyms_lookup_name()
>> date:   1 year, 3 months ago
>> config: riscv-randconfig-r064-20240120 (https://download.01.org/0day-ci/archive/20240206/202402061302.HkByW9x0-lkp@intel.com/config)
>> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240206/202402061302.HkByW9x0-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202402061302.HkByW9x0-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_name: .text+0x90): relocation R_RISCV_PCREL_HI20 out of range: -524416 is not in [-524288, 524287]; references kallsyms_seqs_of_names
>>    >>> referenced by kallsyms.c
>>    >>> defined in vmlinux.a(kernel/kallsyms.o)
>>
> 

-- 
Regards,
  Zhen Lei


