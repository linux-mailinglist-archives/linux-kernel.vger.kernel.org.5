Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AF3786DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbjHXLd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240980AbjHXLda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:33:30 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2B51987;
        Thu, 24 Aug 2023 04:33:27 -0700 (PDT)
Received: from [192.168.0.107] (unknown [111.197.209.91])
        by APP-05 (Coremail) with SMTP id zQCowABHTPzXP+dkeCOzBA--.28393S2;
        Thu, 24 Aug 2023 19:32:39 +0800 (CST)
Message-ID: <4677fc33-6e76-21e6-2a7f-f12670bc1ce2@iscas.ac.cn>
Date:   Thu, 24 Aug 2023 19:32:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     patchwork-bot+linux-riscv@kernel.org,
        linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, bmeng@tinylab.org,
        guoren@kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org
References: <20230809165648.21071-1-xingmingzheng@iscas.ac.cn>
 <169228562484.20811.14246462375671910714.git-patchwork-notify@kernel.org>
 <20230823-captive-abdomen-befd942a4a73@wendy>
 <20230823-facelift-ovary-41f2eb4d9eac@spud>
From:   Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Organization: ISCAS
In-Reply-To: <20230823-facelift-ovary-41f2eb4d9eac@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: zQCowABHTPzXP+dkeCOzBA--.28393S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1kKF48ZFy8uryxZrW5Jrb_yoW8ur45pa
        yfKF9FkF4kXw48J3s7tr1jq3WYvw4ftryrXr1qyryjy3s8uF90qF92krWa9FyDZFWfCr40
        kr4ruasxuw1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvCb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7IU56c_DUUUUU==
X-Originating-IP: [111.197.209.91]
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiAxANCmTnMS822AAAsn
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 21:31, Conor Dooley wrote:
> On Wed, Aug 23, 2023 at 12:51:13PM +0100, Conor Dooley wrote:
>> On Thu, Aug 17, 2023 at 03:20:24PM +0000, patchwork-bot+linux-riscv@kernel.org wrote:
>>> Hello:
>>>
>>> This patch was applied to riscv/linux.git (fixes)
>>> by Palmer Dabbelt <palmer@rivosinc.com>:
>>>
>>> On Thu, 10 Aug 2023 00:56:48 +0800 you wrote:
>>>> Binutils-2.38 and GCC-12.1.0 bumped[0][1] the default ISA spec to the newer
>>>> 20191213 version which moves some instructions from the I extension to the
>>>> Zicsr and Zifencei extensions. So if one of the binutils and GCC exceeds
>>>> that version, we should explicitly specifying Zicsr and Zifencei via -march
>>>> to cope with the new changes. but this only occurs when binutils >= 2.36
>>>> and GCC >= 11.1.0. It's a different story when binutils < 2.36.
>>>>
>>>> [...]
>>> Here is the summary with links:
>>>    - [v5] riscv: Handle zicsr/zifencei issue between gcc and binutils
>>>      https://git.kernel.org/riscv/c/ca09f772ccca
>> *sigh* so this breaks the build for gcc-11 & binutils 2.37 w/
>> 	Assembler messages:
>> 	Error: cannot find default versions of the ISA extension `zicsr'
>> 	Error: cannot find default versions of the ISA extension `zifencei'
>>
>> I'll have a poke later.
> So uh, are we sure that this should not be:
> -       depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC && GCC_VERSION < 110100)
> +       depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC && GCC_VERSION <= 110100)
>
> My gcc-11.1 + binutils 2.37 toolchain built from riscv-gnu-toolchain
> doesn't have the default versions & the above diff fixes the build.

I reproduced the error, the combination of gcc-11.1 and
binutils 2.37 does cause errors. What a surprise, since binutils
2.36 and 2.38 are fine.

I used git bisect to locate this commit[1] for binutils.
I'll test this diff in more detail later. Thanks!

[1] 
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=f0bae2552db1dd4f1995608fbf6648fcee4e9e0c

Best Regards,
Mingzheng.

>
> Thanks,
> Conor.

