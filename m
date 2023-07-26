Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2436A763D09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjGZQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjGZQ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:56:57 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9EC211F;
        Wed, 26 Jul 2023 09:56:54 -0700 (PDT)
Received: from [192.168.0.107] (unknown [114.249.159.178])
        by APP-05 (Coremail) with SMTP id zQCowADHzRVcTsFkA0TYDg--.58489S2;
        Thu, 27 Jul 2023 00:48:28 +0800 (CST)
Message-ID: <2009e6c8-74b7-376b-5654-76d771939105@iscas.ac.cn>
Date:   Thu, 27 Jul 2023 00:48:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Subject: Re: [PATCH] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Bin Meng <bmeng@tinylab.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org
References: <20230725170405.251011-1-xingmingzheng@iscas.ac.cn>
 <20230725172344.GA1445373@dev-arch.thelio-3990X>
Content-Language: en-US
Organization: ISCAS
In-Reply-To: <20230725172344.GA1445373@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: zQCowADHzRVcTsFkA0TYDg--.58489S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF45ZF1kAFyrJrWrtFWkJFb_yoWrCrW3pa
        9xCFn8Crs5Xr4xCwnFy34UWw1FvrZ5Gr43Wr15G34UKrZxXFykKr92kw4agFyDZFs3Cw4j
        vr1S9Fy5Ww1DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07beAp5UUUUU=
X-Originating-IP: [114.249.159.178]
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiCgkECmTBJBdgYQACsY
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 01:23, Nathan Chancellor wrote:
> Hi Mingzheng,
>
> Thanks for the patch!
>
> On Wed, Jul 26, 2023 at 01:04:05AM +0800, Mingzheng Xing wrote:
>> When compiling the kernel with the toolchain composed of GCC >= 12.1.0 and
>> binutils < 2.38, default ISA spec used when building binutils and GCC, the
>> following build failure will appear because the
>> CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI is not turned on.
>> (i.e, gcc-12.1.0 and binutils-2.36, or gcc-12.3.0 and binutils-2.37, use
>> default ISA spec.)
>>
>>    CC      arch/riscv/kernel/vdso/vgettimeofday.o
>>    <<BUILDDIR>>/arch/riscv/include/asm/vdso/gettimeofday.h: Assembler messages:
>>    <<BUILDDIR>>/arch/riscv/include/asm/vdso/gettimeofday.h:79: Error: unrecognized opcode `csrr a5,0xc01'
> The gift that keeps on giving :/
Yeah, but things will get better :)
>> Binutils has updated the default ISA spec version, and the community has
>> responded well to this[1][2][3], but it appears that this is not over yet.
>>
>> We also need to consider the situation of binutils < 2.38 but
>> GCC >= 12.1.0, since the combination between different versions of GCC and
>> binutils is not unique, which is to some extent flexible. GCC release
>> 12.1.0 updated the default ISA spec version in GCC commit[4].
> I suspect this combination is not too common because binutils 2.38 came
> out before GCC 12.1.0 but as you note, it is obviously possible. What
> toolchain has this combination in the wild, which would be helpful for
> documentation purposes?
Actually, this issue was discovered during the upgrade of the distribution
openEuler for RISC-V. It is a temporary phenomenon caused by
inconsistent upgrade speeds of packages such as GCC and binutils.
 From my limited understanding, GCC and binutils are not strictly
version-bound in some other distributions, so I can't rule out this issue
happening in other scenarios. But once it happens it can cause problems
with compiling the kernel.
>> For more information, please refer to:
>>
>> commit 6df2a016c0c8 ("riscv: fix build with binutils 2.38")
>> commit e89c2e815e76 ("riscv: Handle zicsr/zifencei issues between clang and binutils")
>>
>> [1]:https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/aE1ZeHHCYf4
>> [2]:https://lore.kernel.org/all/20230308220842.1231003-1-conor@kernel.org
>> [3]:https://lore.kernel.org/all/20230223220546.52879-1-conor@kernel.org
>> [4]:https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd
>>
>> Signed-off-by: Mingzheng Xing<xingmingzheng@iscas.ac.cn>
>> ---
>>   arch/riscv/Kconfig | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 4c07b9189c86..b49cea30f6cc 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -570,11 +570,15 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
>>   config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>>   	def_bool y
>>   	#https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aed44286efa8ae8717a77d94b51ac3614e2ca6dc
>> -	depends on AS_IS_GNU && AS_VERSION >= 23800
>> +	#https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=98416dbb0a62579d4a7a4a76bab51b5b52fec2cd
>> +	depends on CC_IS_GCC && GCC_VERSION >= 120100 || \
>> +		   AS_IS_GNU && AS_VERSION >= 23800
> GCC_VERSION will be 0 for clang, so you don't need the CC_IS_GCC check.
> With that change, this should be able to stay on one line:
>
>      depends on GCC_VERSION >= 120100 || (AS_IS_GNU && AS_VERSION >= 23800)
OK, I'll change it in v2.

Thanks,
Mingzheng.
>>   	help
>>   	  Newer binutils versions default to ISA spec version 20191213 which
>>   	  moves some instructions from the I extension to the Zicsr and Zifencei
>>   	  extensions.
>> +	  Similarly, GCC release 12.1.0 has changed the default ISA spec version to
>> +	  20191213, so the above situation requires this option to be enabled.
>>   
>>   config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
>>   	def_bool y
>> -- 
>> 2.34.1
>>
> Cheers,
> Nathan
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

