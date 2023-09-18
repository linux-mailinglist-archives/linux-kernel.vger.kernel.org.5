Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF027A4A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 15:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbjIRNAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 09:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242058AbjIRM7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:59:52 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C375CDF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:59:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rq4cH2H3Rz4f3khb
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:58:55 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgD3gtKRSQhloRYiAw--.63961S3;
        Mon, 18 Sep 2023 20:58:59 +0800 (CST)
Subject: Re: [PATCH v3 5/9] crash_core: move crashk_*res definition into
 crash_core.c
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, thunder.leizhen@huawei.com,
        catalin.marinas@arm.com, chenjiahao16@huawei.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
References: <20230914033142.676708-1-bhe@redhat.com>
 <20230914033142.676708-6-bhe@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <69346bd7-1dc6-8202-f5d1-dbcf4ccac096@huaweicloud.com>
Date:   Mon, 18 Sep 2023 20:58:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230914033142.676708-6-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgD3gtKRSQhloRYiAw--.63961S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCryDAryxtr1xJryfuryfWFg_yoWrWFWUpF
        n3Ca1UCayUGF1DWrsxCr92yayFqw4FkFyI9rZrJr1rAa43tr1vgw4DWr12vF1qkFW5KFya
        qrWrur9Fk3yDXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUOyCJDUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/14 11:31, Baoquan He wrote:
> Both crashk_res and crashk_low_res are used to mark the reserved
> crashkernel regions in iomem_resource tree. And later the generic
> crashkernel resrvation will be added into crash_core.c. So move
> crashk_res and crashk_low_res definition into crash_core.c to avoid
> compiling error if CONFIG_CRASH_CORE=on while CONFIG_KEXEC_CORE is
> unset.
> 
> Meanwhile include <asm/crash_core.h> in <linux/crash_core.h> if generic
> reservation is needed. In that case, <asm/crash_core.h> need be added
> by ARCH. In asm/crash_core.h, ARCH can provide its own macro definitions
> to override macros in <linux/crash_core.h> if needed. Wrap the including
> into CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION ifdeffery scope to
> avoid compiling error in other ARCH-es which don't take the generic
> reservation way yet.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/crash_core.h |  8 ++++++++
>  include/linux/kexec.h      |  4 ----
>  kernel/crash_core.c        | 16 ++++++++++++++++
>  kernel/kexec_core.c        | 17 -----------------
>  4 files changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 4dbd6565e0ff..3c735a7e33fb 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -5,6 +5,14 @@
>  #include <linux/linkage.h>
>  #include <linux/elfcore.h>
>  #include <linux/elf.h>
> +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +#include <asm/crash_core.h>
> +#endif
> +
> +/* Location of a reserved region to hold the crash kernel.
> + */
> +extern struct resource crashk_res;
> +extern struct resource crashk_low_res;
>  
>  #define CRASH_CORE_NOTE_NAME	   "CORE"
>  #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 32c78078552c..8227455192b7 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -22,10 +22,6 @@
>  #include <uapi/linux/kexec.h>
>  #include <linux/verification.h>
>  
> -/* Location of a reserved region to hold the crash kernel.
> - */
> -extern struct resource crashk_res;
> -extern struct resource crashk_low_res;
>  extern note_buf_t __percpu *crash_notes;
>  
>  #ifdef CONFIG_KEXEC_CORE
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index ca66b5f41dc7..ad7dc03f3993 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -35,6 +35,22 @@ u32 *vmcoreinfo_note;
>  /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
>  static unsigned char *vmcoreinfo_data_safecopy;
>  
> +/* Location of the reserved area for the crash kernel */
> +struct resource crashk_res = {
> +	.name  = "Crash kernel",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
> +};
> +struct resource crashk_low_res = {
> +	.name  = "Crash kernel",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
> +};
> +
>  /*
>   * parsing the "crashkernel" commandline
>   *
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 9dc728982d79..be5642a4ec49 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -52,23 +52,6 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
>  /* Flag to indicate we are going to kexec a new kernel */
>  bool kexec_in_progress = false;
>  
> -
> -/* Location of the reserved area for the crash kernel */
> -struct resource crashk_res = {
> -	.name  = "Crash kernel",
> -	.start = 0,
> -	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> -	.desc  = IORES_DESC_CRASH_KERNEL
> -};
> -struct resource crashk_low_res = {
> -	.name  = "Crash kernel",
> -	.start = 0,
> -	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> -	.desc  = IORES_DESC_CRASH_KERNEL
> -};
> -
>  int kexec_should_crash(struct task_struct *p)
>  {
>  	/*
> 

-- 
Regards,
  Zhen Lei

