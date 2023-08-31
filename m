Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2DF78E4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 04:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbjHaCab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 22:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242302AbjHaCa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 22:30:29 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72371BF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 19:30:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RblWJ6jYlz4f3m6t
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:30:20 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBH16k8++9kWev3Bw--.61986S3;
        Thu, 31 Aug 2023 10:30:22 +0800 (CST)
Subject: Re: [PATCH v2 2/8] crash_core: change the prototype of function
 parse_crashkernel()
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        samuel.holland@sifive.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-3-bhe@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <77c34c98-f6b1-75e1-dbf3-a148691e7f9d@huaweicloud.com>
Date:   Thu, 31 Aug 2023 10:30:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230829121610.138107-3-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBH16k8++9kWev3Bw--.61986S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFW5uw17JF4kAw1xGr45Wrg_yoWfZFykpr
        1UAF4rKr4jyFykCa4xAr93urWrJ3Wv9a47WFyUAr95tF9rXF15tr4rW3W7WrWjqrs093WI
        yasYqFsaga10gaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/29 20:16, Baoquan He wrote:
> Add two parameters 'low_size' and 'high' to function parse_crashkernel(),
> later crashkernel=,high|low parsing will be added. Make adjustments in all
> call sites of parse_crashkernel() in arch.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm/kernel/setup.c              |  3 ++-
>  arch/arm64/mm/init.c                 |  2 +-
>  arch/ia64/kernel/setup.c             |  2 +-
>  arch/loongarch/kernel/setup.c        |  4 +++-
>  arch/mips/kernel/setup.c             |  3 ++-
>  arch/powerpc/kernel/fadump.c         |  2 +-
>  arch/powerpc/kexec/core.c            |  2 +-
>  arch/powerpc/mm/nohash/kaslr_booke.c |  2 +-
>  arch/riscv/mm/init.c                 |  2 +-
>  arch/s390/kernel/setup.c             |  4 ++--
>  arch/sh/kernel/machine_kexec.c       |  2 +-
>  arch/x86/kernel/setup.c              |  3 ++-
>  include/linux/crash_core.h           |  3 ++-
>  kernel/crash_core.c                  | 15 ++++++++++++---
>  14 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index c66b560562b3..e2bb7afd0683 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -1010,7 +1010,8 @@ static void __init reserve_crashkernel(void)
>  
>  	total_mem = get_total_mem();
>  	ret = parse_crashkernel(boot_command_line, total_mem,
> -				&crash_size, &crash_base);
> +				&crash_size, &crash_base,
> +				NULL, NULL);
>  	/* invalid value specified or crashkernel=0 */
>  	if (ret || !crash_size)
>  		return;
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 4fcb88a445ef..4ad637508b75 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -142,7 +142,7 @@ static void __init reserve_crashkernel(void)
>  
>  	/* crashkernel=X[@offset] */
>  	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> -				&crash_size, &crash_base);
> +				&crash_size, &crash_base, NULL, NULL);
>  	if (ret == -ENOENT) {
>  		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
>  		if (ret || !crash_size)
> diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
> index 5a55ac82c13a..4faea2d2cf07 100644
> --- a/arch/ia64/kernel/setup.c
> +++ b/arch/ia64/kernel/setup.c
> @@ -277,7 +277,7 @@ static void __init setup_crashkernel(unsigned long total, int *n)
>  	int ret;
>  
>  	ret = parse_crashkernel(boot_command_line, total,
> -			&size, &base);
> +			&size, &base, NULL, NULL);
>  	if (ret == 0 && size > 0) {
>  		if (!base) {
>  			sort_regions(rsvd_region, *n);
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index 9d830ab4e302..776a068d8718 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -267,7 +267,9 @@ static void __init arch_parse_crashkernel(void)
>  	unsigned long long crash_base, crash_size;
>  
>  	total_mem = memblock_phys_mem_size();
> -	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> +	ret = parse_crashkernel(boot_command_line, total_mem,
> +				&crash_size, &crash_base,
> +				NULL, NULL);
>  	if (ret < 0 || crash_size <= 0)
>  		return;
>  
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index cb871eb784a7..08321c945ac4 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -460,7 +460,8 @@ static void __init mips_parse_crashkernel(void)
>  
>  	total_mem = memblock_phys_mem_size();
>  	ret = parse_crashkernel(boot_command_line, total_mem,
> -				&crash_size, &crash_base);
> +				&crash_size, &crash_base,
> +				NULL, NULL);
>  	if (ret != 0 || crash_size <= 0)
>  		return;
>  
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index ea0a073abd96..7dbdeba56e74 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -313,7 +313,7 @@ static __init u64 fadump_calculate_reserve_size(void)
>  	 * memory at a predefined offset.
>  	 */
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> -				&size, &base);
> +				&size, &base, NULL, NULL);
>  	if (ret == 0 && size > 0) {
>  		unsigned long max_size;
>  
> diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
> index de64c7962991..9346c960b296 100644
> --- a/arch/powerpc/kexec/core.c
> +++ b/arch/powerpc/kexec/core.c
> @@ -109,7 +109,7 @@ void __init reserve_crashkernel(void)
>  	total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
>  	/* use common parsing */
>  	ret = parse_crashkernel(boot_command_line, total_mem_sz,
> -			&crash_size, &crash_base);
> +			&crash_size, &crash_base, NULL, NULL);
>  	if (ret == 0 && crash_size > 0) {
>  		crashk_res.start = crash_base;
>  		crashk_res.end = crash_base + crash_size - 1;
> diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
> index 2fb3edafe9ab..b4f2786a7d2b 100644
> --- a/arch/powerpc/mm/nohash/kaslr_booke.c
> +++ b/arch/powerpc/mm/nohash/kaslr_booke.c
> @@ -178,7 +178,7 @@ static void __init get_crash_kernel(void *fdt, unsigned long size)
>  	int ret;
>  
>  	ret = parse_crashkernel(boot_command_line, size, &crash_size,
> -				&crash_base);
> +				&crash_base, NULL, NULL);
>  	if (ret != 0 || crash_size == 0)
>  		return;
>  	if (crash_base == 0)
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index e4c35ac2357f..a9ef0824f905 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1332,7 +1332,7 @@ static void __init reserve_crashkernel(void)
>  	}
>  
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> -				&crash_size, &crash_base);
> +				&crash_size, &crash_base, NULL, NULL);
>  	if (ret || !crash_size)
>  		return;
>  
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index c744104e4a9c..98204a5f62b1 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -626,8 +626,8 @@ static void __init reserve_crashkernel(void)
>  	phys_addr_t low, high;
>  	int rc;
>  
> -	rc = parse_crashkernel(boot_command_line, ident_map_size, &crash_size,
> -			       &crash_base);
> +	rc = parse_crashkernel(boot_command_line, ident_map_size,
> +			       &crash_size, &crash_base, NULL, NULL);
>  
>  	crash_base = ALIGN(crash_base, KEXEC_CRASH_MEM_ALIGN);
>  	crash_size = ALIGN(crash_size, KEXEC_CRASH_MEM_ALIGN);
> diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
> index 223c14f44af7..fa3a7b36190a 100644
> --- a/arch/sh/kernel/machine_kexec.c
> +++ b/arch/sh/kernel/machine_kexec.c
> @@ -154,7 +154,7 @@ void __init reserve_crashkernel(void)
>  	int ret;
>  
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> -			&crash_size, &crash_base);
> +			&crash_size, &crash_base, NULL, NULL);
>  	if (ret == 0 && crash_size > 0) {
>  		crashk_res.start = crash_base;
>  		crashk_res.end = crash_base + crash_size - 1;
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index fd975a4a5200..382c66d2cf71 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -558,7 +558,8 @@ static void __init reserve_crashkernel(void)
>  	total_mem = memblock_phys_mem_size();
>  
>  	/* crashkernel=XM */
> -	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> +	ret = parse_crashkernel(boot_command_line, total_mem,
> +				&crash_size, &crash_base, NULL, NULL);
>  	if (ret != 0 || crash_size <= 0) {
>  		/* crashkernel=X,high */
>  		ret = parse_crashkernel_high(boot_command_line, total_mem,
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e..2e76289699ff 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -78,7 +78,8 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  void final_note(Elf_Word *buf);
>  
>  int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
> -		unsigned long long *crash_size, unsigned long long *crash_base);
> +		unsigned long long *crash_size, unsigned long long *crash_base,
> +		unsigned long long *low_size, bool *high);
>  int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
>  int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index f27b4e45d410..f6a5c219e2e1 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -280,10 +280,19 @@ static int __init __parse_crashkernel(char *cmdline,
>  int __init parse_crashkernel(char *cmdline,
>  			     unsigned long long system_ram,
>  			     unsigned long long *crash_size,
> -			     unsigned long long *crash_base)
> +			     unsigned long long *crash_base,
> +			     unsigned long long *low_size,
> +			     bool *high)
>  {
> -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> -				NULL);
> +	int ret;
> +
> +	/* crashkernel=X[@offset] */
> +	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
> +				crash_base, NULL);
> +	if (!high)
> +		return ret;
> +
> +	return 0;
>  }
>  
>  int __init parse_crashkernel_high(char *cmdline,
> 

-- 
Regards,
  Zhen Lei

