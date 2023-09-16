Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5757E7A2F37
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 12:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbjIPKRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 06:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjIPKRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 06:17:14 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA9A1CD8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:17:08 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8DxRvGigAVlswgpAA--.13289S3;
        Sat, 16 Sep 2023 18:17:07 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbS+dgAVl4qQIAA--.17205S3;
        Sat, 16 Sep 2023 18:17:03 +0800 (CST)
Message-ID: <4597fd85-8aff-fb6f-295b-e5b4b3ac092e@loongson.cn>
Date:   Sat, 16 Sep 2023 18:17:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] LoongArch: Fix some build warnings with -W1 option
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230916092330.971630-1-maobibo@loongson.cn>
 <CAAhV-H50_aY8Sw0uPSs1VuNOtbaHF2-a5mZE2jnSC7QPUaWf=Q@mail.gmail.com>
 <1918be3c-3560-bd3d-6518-c5e49319b1d6@loongson.cn>
 <c71c610d70727b94dfaa1bdd537235cde13db7c6.camel@xry111.site>
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <c71c610d70727b94dfaa1bdd537235cde13db7c6.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxbS+dgAVl4qQIAA--.17205S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF1kJw1rAry5Xry5AF4fWFX_yoW8tF18pF
        W7Ga1UKF4kJr18Xan7t34xWr1Yqan7GayxWws8Cry8Ars0ya48Gw4SgrW3CrnFyws3KFyF
        9FZ3A340yFyjvagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07je0PfUUUUU=
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/16 18:07, Xi Ruoyao 写道:
> On Sat, 2023-09-16 at 17:56 +0800, bibo mao wrote:
>>
>>
>> 在 2023/9/16 17:42, Huacai Chen 写道:
>>> Hi, Bibo,
>>>
>>> On Sat, Sep 16, 2023 at 5:23 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>> There are some building warnings when building LoongArch kernel
>>>> with -W1 option as following, this patch fixes these building
>>>> warnings.
>>> Don't touch asm-offsets.c now, because it is being refactored by the community.
>> Well, I will bypass this file and send the next version.
>>
>> Do you think that is it deserved to add -Wno-override-init option
>> to remove compiling warning about file syscall.c? I am not sure about it.
> 
> What is a -W1 option?  At least GCC 13 does not recognize it.
> 
> And generally you cannot randomly add warning options building the
> kernel and expect a clean result.  I don't think we should "fix"
> breakages caused by custom warnings at all, unless the warning indicates
> a real issue.
it is W=1 option:), and it is reported by lkp tool like this:

kernel test robot noticed the following build errors:
[auto build test ERROR on 744a759492b5c57ff24a6e8aabe47b17ad8ee964]
url:    https://github.com/intel-lab-lkp/linux/commits/Bibo-Mao/LoongArch-Add-tlb_flush_threshold-for-tlb-flush-range/20230908-093017
base:   744a759492b5c57ff24a6e8aabe47b17ad8ee964
patch link:    https://lore.kernel.org/r/20230908012907.2994001-1-maobibo%40loongson.cn
patch subject: [PATCH] LoongArch: Add tlb_flush_threshold for tlb flush range
config: loongarch-randconfig-r021-20230909 (https://download.01.org/0day-ci/archive/20230909/202309090624.CrkoQ4fj-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309090624.CrkoQ4fj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309090624.CrkoQ4fj-lkp@intel.com/

Regards
Bibo Mao

> 
> 

