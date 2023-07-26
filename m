Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413F47633ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjGZKiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjGZKiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:38:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96F3F1BCB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:38:16 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.22])
        by gateway (Coremail) with SMTP id _____8DxqOqV98Bkzi8KAA--.15982S3;
        Wed, 26 Jul 2023 18:38:13 +0800 (CST)
Received: from [10.180.13.22] (unknown [10.180.13.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLCOV98Bk46c7AA--.10453S3;
        Wed, 26 Jul 2023 18:38:13 +0800 (CST)
Message-ID: <02a0fd6c-16f6-26f4-b374-197f0a017a5f@loongson.cn>
Date:   Wed, 26 Jul 2023 18:37:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ASoC: loongson: mark OF related data as maybe unused
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Xi Ruoyao <xry111@xry111.site>, broonie@kernel.org,
        lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
References: <20230726070648.700754-1-mengyingkun@loongson.cn>
 <174b4c41d10fa1b31821482ec737733ca4633464.camel@xry111.site>
 <1ad985f9-2738-8b42-a8e2-c2312ec57d9e@linaro.org>
Content-Language: en-US
From:   Yingkun Meng <mengyingkun@loongson.cn>
In-Reply-To: <1ad985f9-2738-8b42-a8e2-c2312ec57d9e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLCOV98Bk46c7AA--.10453S3
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQAEDGTAnS8ElAABsO
X-Coremail-Antispam: 1Uk129KBj9xXoW7JF4fZF4rArWUCFWUGw17urX_yoW3ZFcEga
        yUurn5Gw13WF97Ka9FgFWUArWDKa17JF15Kr18Ww4F93s7tFWfCFZ5Zryfu3Z29F42gF13
        Ww4Fq343ZrnIyosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
        6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07je0PfUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/26 16:05, Krzysztof Kozlowski wrote:
> On 26/07/2023 09:20, Xi Ruoyao wrote:
>> On Wed, 2023-07-26 at 15:06 +0800, YingKun Meng wrote:
>>> The ASoC Sound Card driver can be compile tested with !CONFIG_OF
>>> making 'loongson_asoc_dt_ids' unused:
>>>
>>> sound/soc/loongson/loongson_card.c:200:34: warning: unused variable
>>> 'loongson_asoc_dt_ids' [-Wunused-const-variable]
>> Hmm, why not guard the definition with #ifdef CONFIG_OF instead?
>>
>> Source text is first and foremost for the human reader, not for the
>> compiler, and an ifdef clearly shows the condition when the definition
>> is not used.
> Rather drop of_match_ptr so this can be used also on ACPI.

This is more reasonable.

Please ignore the the patch，i will resend a new one.


Thanks,
Yingkun



