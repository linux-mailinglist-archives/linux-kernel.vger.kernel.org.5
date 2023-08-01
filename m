Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A26376B791
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjHAOeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjHAOd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:33:59 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A7871FEF;
        Tue,  1 Aug 2023 07:33:53 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxIvDOF8lkiiYOAA--.32762S3;
        Tue, 01 Aug 2023 22:33:50 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxJ83MF8lkyBdEAA--.44246S3;
        Tue, 01 Aug 2023 22:33:48 +0800 (CST)
Message-ID: <9f6ff24b-7e58-2dde-3b6d-eda9be1944ae@loongson.cn>
Date:   Tue, 1 Aug 2023 22:33:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v1,v1,5/7] drm/vs: Register DRM device
From:   suijingfeng <suijingfeng@loongson.cn>
To:     Keith Zhao <keith.zhao@starfivetech.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Shawn Guo <shawnguo@kernel.org>, christian.koenig@amd.com
References: <20230801101030.2040-6-keith.zhao@starfivetech.com>
 <6b776c23-9cc1-5a7d-0a85-bd7eb42e847d@loongson.cn>
Content-Language: en-US
In-Reply-To: <6b776c23-9cc1-5a7d-0a85-bd7eb42e847d@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ83MF8lkyBdEAA--.44246S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUUm2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
        xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
        67AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF54CYxVAaw2AFwI0_Jw0_GFyl4c8EcI0E
        c7CjxVAaw2AFwI0_GFv_Wryl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Wr
        v_ZF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07jUSdgUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/8/1 21:40, suijingfeng wrote:
>> +#define DRV_DATE    "202305161"
>
> The date is not correct here, generally it should have 8 numbers,
>
> while you have 9 digits, why you are so special ? 


I'm also interesting in RISCV arch, I got attracted by your patch.

I just want to join into the discussion at here (at my spare time),

So when you see my comments, I hoping that you will not interpret it as 
hostility.

Welcome contributing. :-)

