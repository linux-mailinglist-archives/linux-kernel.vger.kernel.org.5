Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2517651C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjG0K60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjG0K6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:58:24 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 913191FEC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:58:22 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx2erNTcJkh7EKAA--.21528S3;
        Thu, 27 Jul 2023 18:58:21 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF83MTcJkvPs8AA--.29457S3;
        Thu, 27 Jul 2023 18:58:20 +0800 (CST)
Subject: Re: [PATCH v1 4/6] objtool/LoongArch: Enable orc to be built
To:     Peter Zijlstra <peterz@infradead.org>
References: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
 <1690272910-11869-5-git-send-email-yangtiezhu@loongson.cn>
 <20230725115106.GC3765278@hirez.programming.kicks-ass.net>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <936a4873-bfe6-cabc-fa63-b8ba14857243@loongson.cn>
Date:   Thu, 27 Jul 2023 18:58:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230725115106.GC3765278@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxF83MTcJkvPs8AA--.29457S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruFWrtr4kJw4kWw1kGw1fZrc_yoWkWwb_uw
        1fZ34kC34DKF4fJan8Kay5ZasrGr1UtFs5JryqvFZFq3WkJrWkCw4kGr93ZrWfXayrtF90
        qrnFqw13Wr9rZosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
        JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/25/2023 07:51 PM, Peter Zijlstra wrote:
> On Tue, Jul 25, 2023 at 04:15:08PM +0800, Tiezhu Yang wrote:
>
> Previous Changelog had:
>
>> Define update_cfi_state() as a weak function which may be overwritten
>> by the arch-specific implementation.
>
> And then this patch does:
>
>> +int update_cfi_state(struct instruction *insn,
>> +		     struct instruction *next_insn,
>> +		     struct cfi_state *cfi, struct stack_op *op)
>> +{
>> +	struct cfi_reg *cfa = &cfi->cfa;
>> +	struct cfi_reg *regs = cfi->regs;

...

>> +	default:
>> +		WARN_FUNC("unknown stack-related instruction", insn->sec, insn->offset);
>> +		return -1;
>> +	}
>> +
>> +	return 0;
>> +}
>
> Why ?!? what is the actual irreconcilable difference?

I went in deeper to analysis the code and did more test,
the conclusion is that there is no need to define the
arch-specific update_cfi_state(), although it seems simpler
than the generic update_cfi_state(), the generic function
can handle all the cases and works well.

> If you want us to review this, you'll have to explain things.

I will drop the related changes in the next version, thank you.

Thanks,
Tiezhu

