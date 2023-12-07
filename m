Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6092F8081B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377825AbjLGHOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjLGHOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:14:15 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B9D3193
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:14:21 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxfevMcHFl6Y4_AA--.58818S3;
        Thu, 07 Dec 2023 15:14:20 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxK9zLcHFl0kVXAA--.61456S3;
        Thu, 07 Dec 2023 15:14:19 +0800 (CST)
Subject: Re: [PATCH v5 0/8] Add objtool and orc support for LoongArch
To:     Huacai Chen <chenhuacai@kernel.org>
References: <20231129130701.27744-1-yangtiezhu@loongson.cn>
 <CAAhV-H7VWCFJPYLN6SRuxvvhe6gsj1HHYbLgZaWFk7g8sh1LPA@mail.gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <ec661951-c08d-0c47-de5c-f6b8923bbef6@loongson.cn>
Date:   Thu, 7 Dec 2023 15:14:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7VWCFJPYLN6SRuxvvhe6gsj1HHYbLgZaWFk7g8sh1LPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxK9zLcHFl0kVXAA--.61456S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWkurWxCw4fJFy5Ar43Arc_yoW8XrW3pF
        y7Zrn0kr48ZFs3Cw4DA393WrWfJ39xC3yaq3Z8AryfC3yagas0q3W0yrnrJFyjgw47CrWF
        qF1F9wnFya1UuwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU466zUUUUU
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/02/2023 09:52 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> There are still some build warnings.
>
> If FUNCTION_TRACER enabled, we get
>   AS      arch/loongarch/kernel/mcount_dyn.o
> arch/loongarch/kernel/mcount_dyn.o: warning: objtool:
> ftrace_common+0x0: unreachable instruction
> arch/loongarch/kernel/mcount_dyn.o: warning: objtool:
> ftrace_caller+0x0: unreachable instruction
> arch/loongarch/kernel/mcount_dyn.o: warning: objtool:
> ftrace_regs_caller+0x0: unreachable instruction
> arch/loongarch/kernel/mcount_dyn.o: warning: objtool:
> ftrace_graph_caller+0x0: unreachable instruction
> arch/loongarch/kernel/mcount_dyn.o: warning: objtool:
> return_to_handler+0x0: unreachable instruction
> arch/loongarch/kernel/mcount_dyn.o: warning: objtool:
> ftrace_stub_direct_tramp+0x0: unreachable instruction
>
>   AS      arch/loongarch/kernel/rethook_trampoline.o
> arch/loongarch/kernel/rethook_trampoline.o: warning: objtool:
> arch_rethook_trampoline+0x0: unreachable instruction

I tested with the default config loongson3_defconfig,
the FUNCTION_TRACE is not enabled, let me try to fix it.

> And when I use the latest binutils/gcc for native build, there are
> some warnings in some files from the {init, kernel} directory. But
> cross-building is fine, I don't know why.

I can not reproduce it for native build, it works well,
I will analysis if it can reproduce someday.

Thanks,
Tiezhu

