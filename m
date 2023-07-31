Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEED67692E5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjGaKR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjGaKRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:17:15 -0400
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1464CE65;
        Mon, 31 Jul 2023 03:17:12 -0700 (PDT)
Received: from [192.168.0.107] (unknown [111.197.209.91])
        by APP-03 (Coremail) with SMTP id rQCowACHj8fxicdkWHydDw--.11897S2;
        Mon, 31 Jul 2023 18:16:17 +0800 (CST)
Message-ID: <572ad471-8a0b-95e2-1112-c55f42e5594b@iscas.ac.cn>
Date:   Mon, 31 Jul 2023 18:16:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Bin Meng <bmeng@tinylab.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
References: <20230726174524.340952-1-xingmingzheng@iscas.ac.cn>
 <20230726-outclass-parade-2ccea9f6688a@spud>
 <10231b81-ea42-26d0-4c11-92851229e658@iscas.ac.cn>
 <20230726-armchair-evasive-427dd245a9fe@spud>
 <20230727-briskness-sappy-e2d9e4c1ef36@spud>
 <d75ef570-c0ad-cea4-687a-d02b560aa676@iscas.ac.cn>
 <20230729-chaps-coauthor-95557d86b189@spud>
Content-Language: en-US
From:   Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Organization: ISCAS
In-Reply-To: <20230729-chaps-coauthor-95557d86b189@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHj8fxicdkWHydDw--.11897S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr45Gw18tryDtw17KFyDKFg_yoW8Zw43pF
        4kCFyDGry5Xw1xGw4xJ34UWry0yr4rJay5Jr45W3WUAryUAFy0grykXw1Ygr1DArs5tw10
        vr1093WDZwn8JFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvCb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7IU56c_DUUUUU==
X-Originating-IP: [111.197.209.91]
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiCQkJCmTHZrJ09wAAs3
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/23 01:48, Conor Dooley wrote:
> On Sun, Jul 30, 2023 at 01:36:49AM +0800, Mingzheng Xing wrote:
>
>> I reproduced the error with gcc-12.2.0 and binutils-2.35. I tried a
>> different solution, which I think makes the logic easier. Showing
>> the new patch code:
> It is indeed simpler, neat.
>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 4c07b9189c86..a6fa1eed895c 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -569,25 +569,24 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
>>
>>   config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>>          def_bool y
>> -       # https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
>> -       depends on AS_IS_GNU && AS_VERSION >= 23800
>> +       depends on AS_IS_GNU && AS_VERSION >= 23600
>>          help
>> -         Newer binutils versions default to ISA spec version 20191213 which
>> -         moves some instructions from the I extension to the Zicsr and Zifencei
>> -         extensions.
>> +         Binutils has supported zicsr and zifencei extensions since version 2.36,
>> +         try to adapt to the changes by using explicit zicsr and zifencei via
>> +         -march.
> This sentence no longer makes sense to me, the motivation for why we are
> doing this is lost. Please preserve the link & explanation about the
> 20191213 version of the spec, adding to it the commentary about how we
> can relax the check to 2.36, since that makes our lives easier.
>
> The rest of this looks fine to me, if you resubmit I'll look at it
> further on Monday.

I updated it in v3 [1]. Thanks for your review.

[1] https://lore.kernel.org/all/20230731095936.23397-1-xingmingzheng@iscas.ac.cn

> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

