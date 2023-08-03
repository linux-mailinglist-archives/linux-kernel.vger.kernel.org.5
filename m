Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EA076EE33
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbjHCPe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbjHCPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:34:25 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B671730FF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:34:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGsxF1JF7z9xGWx
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 23:20:49 +0800 (CST)
Received: from [10.81.221.240] (unknown [10.81.221.240])
        by APP1 (Coremail) with SMTP id LxC2BwBXC7vUyMtkePU6AA--.360S2;
        Thu, 03 Aug 2023 16:33:52 +0100 (CET)
Message-ID: <f4d8f17e-384d-866b-5905-94339d41e8ef@huaweicloud.com>
Date:   Thu, 3 Aug 2023 17:33:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] riscv/purgatory: do not link with string.o and its
 dependencies
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Conor Dooley <conor.dooley@microchip.com>,
        lihuafei1@huawei.com, liaochang1@huawei.com, masahiroy@kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org, heiko@sntech.de,
        ribalda@chromium.org, hi@alyssa.is, lizhengyu3@huawei.com,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, duwe@suse.de,
        roberto.sassu@huaweicloud.com, petr@tesarici.cz
References: <mhng-45e67c5d-6969-43da-9147-b53dc9a78612@palmer-ri-x1c9>
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <mhng-45e67c5d-6969-43da-9147-b53dc9a78612@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBXC7vUyMtkePU6AA--.360S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyUGrWDGFWDuFy8uFW8Crg_yoWrGryrpF
        4vkF1DKrW8Gr18Cr1Dtr1UZryUtw4UGw1UJryUWFyjyr4Utr1jqF4DWr12gr1DJr48Gr1U
        JFy7Wr15ur1UZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7
        UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/2023 5:13 PM, Palmer Dabbelt wrote:
> On Wed, 26 Jul 2023 09:33:49 PDT (-0700), Conor Dooley wrote:
>> On Wed, Jul 26, 2023 at 11:54:00AM +0200, Petr Tesarik wrote:
>>> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>>>
>>> Linking with this object file makes kexec_file_load(2) fail because of
>>> multiple unknown relocation types:
>>>
>>> - R_RISCV_ADD16, R_RISCV_SUB16: used by alternatives in strcmp()
>>> - R_RISCV_GOT_HI20: used to resolve _ctype in strcasecmp()
>>>
>>> All this hassle is needed for one single call to memcmp() from
>>> verify_sha256_digest() to compare 32 bytes of SHA256 checksum.
>>>
>>> Simply replace this memcmp() call with an explicit loop over those 32
>>> bytes
>>> and remove the need to link with string.o and all the other object files
>>> that provide undefined symbols from that object file.
>>>
>>> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
>>> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
>>
>> This version keeps the automation happy,
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Oddly enough, this breaks my builds.  I tried fixing the first one with
> something like

FTR I have no idea how a patch to the purgatory code and its Makefile
can have any effect on the compilation of asm-offsets.s in another
directory.

Petr T

>    From 41c5a952f77e53bf4201296abff0132725aa19e6 Mon Sep 17 00:00:00 2001
>    From: Palmer Dabbelt <palmer@rivosinc.com>
>    Date: Wed, 2 Aug 2023 20:22:33 -0700
>    Subject: [PATCH] RISC-V: Include io from timex
>       Without this I get some implicit declarations.
>         CC      arch/riscv/kernel/asm-offsets.s
>    In file included from linux/include/linux/timex.h:67,
>                     from linux/include/linux/time32.h:13,
>                     from linux/include/linux/time.h:60,
>                     from linux/include/linux/ktime.h:24,
>                     from linux/include/linux/timer.h:6,
>                     from linux/include/linux/workqueue.h:9,
>                     from linux/include/linux/mm_types.h:19,
>                     from linux/include/linux/mmzone.h:22,
>                     from linux/include/linux/gfp.h:7,
>                     from linux/include/linux/mm.h:7,
>                     from linux/arch/riscv/kernel/asm-offsets.c:10:
>    linux/arch/riscv/include/asm/timex.h: In function 'get_cycles':
>    linux/arch/riscv/include/asm/timex.h:25:16: error: implicit
> declaration of function 'readl_relaxed'
> [-Werror=implicit-function-declaration]
>       25 |         return readl_relaxed(((u32 *)clint_time_val));
>          |
>       Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>    ---
>     arch/riscv/include/asm/timex.h | 1 +
>     1 file changed, 1 insertion(+)
>       diff --git a/arch/riscv/include/asm/timex.h
> b/arch/riscv/include/asm/timex.h
>    index a06697846e69..1a4d181193e0 100644
>    --- a/arch/riscv/include/asm/timex.h
>    +++ b/arch/riscv/include/asm/timex.h
>    @@ -7,6 +7,7 @@
>     #define _ASM_RISCV_TIMEX_H
>         #include <asm/csr.h>
>    +#include <asm/io.h>
>         typedef unsigned long cycles_t;
> 
>    --    2.41.0
> 
> The other two look fine and are somewhat independent, so I've picked
> those up
> for fixes.
> 
> Thanks!
> 
>>
>> Thanks,
>> Conor.

