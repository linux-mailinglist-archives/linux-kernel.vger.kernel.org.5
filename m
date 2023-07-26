Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD27632AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjGZJp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGZJpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:45:55 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E5D397;
        Wed, 26 Jul 2023 02:45:52 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8AxCPJP68BkdSgKAA--.25252S3;
        Wed, 26 Jul 2023 17:45:51 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx3yNP68BkWJg7AA--.54678S3;
        Wed, 26 Jul 2023 17:45:51 +0800 (CST)
Message-ID: <f19c393b-8c2e-e3aa-988a-88a423b59b99@loongson.cn>
Date:   Wed, 26 Jul 2023 17:45:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 0/2] irqchip/loongson-eiointc: Add simple irq routing
 method
From:   bibo mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230719063558.3131045-1-maobibo@loongson.cn>
Content-Language: en-US
In-Reply-To: <20230719063558.3131045-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx3yNP68BkWJg7AA--.54678S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKrWfGr45AFyfAry7Ar1UArc_yoWfXwb_WF
        y29395KrZ5XFWFvas7AFnrJF9rK398Wwn8ZFWv9r45J34UAr15JrZ2yr93JFnxKFWSvFnx
        CrW8CryfAw12yosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
        AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
        0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
        UUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slight ping :)

在 2023/7/19 14:35, Bibo Mao 写道:
> Fix return value checking of eiointc_index where int type
> is converted uint32_t and check smaller than 0.
> 
> Add simple irq route support on system with only one eiointc node,
> rather than use anysend method.
> 
> ---
> Changes in v5:
>   Modify typo issue.
> 
> Changes in v4:
>   Modify some spell checking problems.
>   Add Fixes tag.
> 
> Changes in v3:
>   Modify some spell checking problems.
> 
> Changes in v2:
>   Use the simple irq routing on embeded board like 2K0500 and 2K2000
> board, since there is only one eio node.
> 
> ---
> Bibo Mao (2):
>   irqchip/loongson-eiointc: Fix return value checking of eiointc_index
>   irqchip/loongson-eiointc: Simplify irq routing on some platforms
> 
>  drivers/irqchip/irq-loongson-eiointc.c | 93 +++++++++++++++++++++++---
>  1 file changed, 82 insertions(+), 11 deletions(-)
> 

