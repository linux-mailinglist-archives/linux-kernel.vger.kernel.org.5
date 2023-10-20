Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0546B7D0D14
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376836AbjJTK2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376715AbjJTK2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:28:14 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C5DDB8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:28:09 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxyOg3VjJlFnMzAA--.64000S3;
        Fri, 20 Oct 2023 18:28:07 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxH90zVjJlvzssAA--.30051S3;
        Fri, 20 Oct 2023 18:28:04 +0800 (CST)
Subject: Re: [PATCH v3 0/8] Add objtool and orc support for LoongArch
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1697768821-22931-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4wqO0=+EOhyH+t=0bpiX2DayddVArB=x_yzVvmX9OW1g@mail.gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a967ebeb-f19d-4e36-3547-80e838ad2fa0@loongson.cn>
Date:   Fri, 20 Oct 2023 18:28:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4wqO0=+EOhyH+t=0bpiX2DayddVArB=x_yzVvmX9OW1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxH90zVjJlvzssAA--.30051S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF48Zry3tFW5JrWDGFWDWrX_yoW8Aw1DpF
        sFvrW2grWDW3sYy34kG3W0g34vvF1IkryYqFykGFWUArZ5Ary0qa97JFykZF17X3Z0va1Y
        934Igr15WF17AagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
        Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0pB
        -UUUUU=
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 04:51 PM, Huacai Chen wrote:
> Cross compiling on X86 for LoongArch fails:
>
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
> make[5]: *** No rule to make target
> '/usr/lib/gcc/x86_64-redhat-linux/8/include/stdbool.h', needed by
> '/home/chenhuacai/linux-official.git/tools/objtool/libsubcmd/exec-cmd.o'.
> Stop.
> make[4]: *** [Makefile:80:
> /home/chenhuacai/linux-official.git/tools/objtool/libsubcmd/libsubcmd-in.o]
> Error 2
> make[3]: *** [Makefile:82:
> /home/chenhuacai/linux-official.git/tools/objtool/libsubcmd/libsubcmd.a]
> Error 2
> make[2]: *** [Makefile:73: objtool] Error 2
> make[1]: *** [/home/chenhuacai/linux-official.git/Makefile:1355:
> tools/objtool] Error 2
> make: *** [Makefile:234: __sub-make] Error 2

It seems that there is no stdbool.h in your cross compile environment.

It works well with the following steps, you can try it.

wget 
https://github.com/loongson/build-tools/releases/download/2023.08.08/x86_64-cross-tools-loongarch64-gcc-libc.tar.xz
tar xf x86_64-cross-tools-loongarch64-gcc-libc.tar.xz -C /opt
export PATH=/opt/cross-tools/bin/:$PATH
export 
LD_LIBRARY_PATH=/opt/cross-tools/loongarch64-unknown-linux-gnu/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/cross-tools/lib:$LD_LIBRARY_PATH
export CROSS_COMPILE=loongarch64-unknown-linux-gnu-
export ARCH=loongarch

find /opt -name stdbool.h
/opt/cross-tools/lib/gcc/loongarch64-unknown-linux-gnu/14.0.0/include/stdbool.h
/opt/cross-tools/loongarch64-unknown-linux-gnu/include/c++/14.0.0/tr1/stdbool.h

cd linux.git
make loongson3_defconfig
make menuconfig   # select CONFIG_UNWINDER_ORC
make -j4

Thanks,
Tiezhu

