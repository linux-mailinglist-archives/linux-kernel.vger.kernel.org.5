Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169BE7D0E06
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377149AbjJTK53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377154AbjJTK5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:57:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 446281706
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:56:55 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxPOv1XDJla3QzAA--.28819S3;
        Fri, 20 Oct 2023 18:56:53 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxri_0XDJlUkMsAA--.27445S3;
        Fri, 20 Oct 2023 18:56:52 +0800 (CST)
Subject: Re: [PATCH v3 5/8] objtool: Check local label about sibling call
To:     Peter Zijlstra <peterz@infradead.org>
References: <1697768821-22931-1-git-send-email-yangtiezhu@loongson.cn>
 <1697768821-22931-6-git-send-email-yangtiezhu@loongson.cn>
 <20231020093031.GB31411@noisy.programming.kicks-ass.net>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f8f6b51c-6e0d-baf2-788e-bc3d175d21f2@loongson.cn>
Date:   Fri, 20 Oct 2023 18:56:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20231020093031.GB31411@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cxri_0XDJlUkMsAA--.27445S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw48CF1kAw18urWktr4DJrc_yoW8GrW8pF
        4UC3y2kFW2qryfXw17tF1UWrZ8Ww47WryIkF17JFW0yr42qFnxGr4fCr1YyF1vqw45ua42
        9FyYgr18Jr4FvrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
        Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jna9
        -UUUUU=
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 05:30 PM, Peter Zijlstra wrote:
> On Fri, Oct 20, 2023 at 10:26:58AM +0800, Tiezhu Yang wrote:
>
>> +		if (reloc && reloc->sym->type == STT_NOTYPE &&
>> +		    strncmp(reloc->sym->name, ".L", 2) == 0)
>
>> +			if (reloc->sym->type == STT_NOTYPE &&
>> +			    strncmp(reloc->sym->name, ".L", 2) == 0) {
>
> Would not something like the below be better?
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e308d1ba664e..a57d293c834d 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2506,6 +2506,9 @@ static int classify_symbols(struct objtool_file *file)
>  	struct symbol *func;
>
>  	for_each_sym(file, func) {
> +		if (func->type == STT_NOTYPE && strstarts(func->name, ".L"))
> +			func->local_label = true;
> +
>  		if (func->bind != STB_GLOBAL)
>  			continue;
>
> diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
> index 9f71e988eca4..2b8a69de4db8 100644
> --- a/tools/objtool/include/objtool/elf.h
> +++ b/tools/objtool/include/objtool/elf.h
> @@ -67,6 +67,7 @@ struct symbol {
>  	u8 profiling_func    : 1;
>  	u8 warned	     : 1;
>  	u8 embedded_insn     : 1;
> +	u8 local_label       : 1;
>  	struct list_head pv_target;
>  	struct reloc *relocs;
>  };
>

Yes, this looks much better, thank you very much.
I will update the related code of patch #5, #6 and #7.

Thanks,
Tiezhu

