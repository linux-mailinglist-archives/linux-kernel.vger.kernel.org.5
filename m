Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE877EECB9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 08:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjKQHjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 02:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjKQHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 02:39:33 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7C3D53
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 23:39:28 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231117073926epoutp01f6e7d68755078f320c8e1a28d7314575~YWQuzCBIl1230412304epoutp01s
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:39:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231117073926epoutp01f6e7d68755078f320c8e1a28d7314575~YWQuzCBIl1230412304epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700206766;
        bh=wDrKubwuI3Sqsj91xOGLNjY6z0KTspS1GXMj5gRrwS4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=RY2im7SUHeHdbCTyMQdsO/kp6KtOfeT9Z8k+bOZW4uVyrk2AyoAnZ3cc/+EwGqlDr
         okXJ0Y71v2MI9cYEfqLjdNUYeRJLif4B59uhqMi6J9y/uNG3hTvfXcDeEvcDtXxQ0W
         kqZVUIYuRXPse8Zv219dmDdbuowNRn3qi+MUdrak=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231117073925epcas2p4086e54e4767ad4a0ead78e02b8dfe035~YWQuOQ74j0776207762epcas2p4B;
        Fri, 17 Nov 2023 07:39:25 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SWpgw6C80z4x9QD; Fri, 17 Nov
        2023 07:39:24 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.62.09622.CA817556; Fri, 17 Nov 2023 16:39:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231117073924epcas2p429428d5dfdcd3a4d6019bb8ceb7ce151~YWQtB-Npn0743507435epcas2p4M;
        Fri, 17 Nov 2023 07:39:24 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231117073924epsmtrp1e52659ddfbc92dfb6dfeb70b6c6d9567~YWQtBErpj2370223702epsmtrp1f;
        Fri, 17 Nov 2023 07:39:24 +0000 (GMT)
X-AuditID: b6c32a46-d61ff70000002596-07-655718ac2c06
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.8A.07368.CA817556; Fri, 17 Nov 2023 16:39:24 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231117073923epsmtip2cfd70f45d1e145aa5f07cdd69d3bea12~YWQsx-xse0135401354epsmtip2L;
        Fri, 17 Nov 2023 07:39:23 +0000 (GMT)
Message-ID: <926ea5c5-20ac-5e63-16ea-6f0c20e2db0a@samsung.com>
Date:   Fri, 17 Nov 2023 16:36:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH v2 10/12] pinctrl: samsung: add exynosautov920 pinctrl
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <6a5610e0-e60d-4ab7-8708-6f77a38527b7@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmme4aifBUg4/LdSwezNvGZrFm7zkm
        i/lHzrFaNC9ez2bxbq6Mxd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfN4u7dVYwWM87vY7I4
        s7iX3aJ17xF2i8Nv2lktfu6ax2KxahdQ3e2JkxkdhDx2zrrL7rFpVSebx51re9g89s9dw+6x
        eUm9R/9fA4++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdS
        yEvMTbVVcvEJ0HXLzAH6REmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yY
        W1yal66Xl1piZWhgYGQKVJiQnfHx4EG2gtmWFb1nprI3MB7T7WLk5JAQMJHoWbqKpYuRi0NI
        YAejxPb9/9ghnE+MEj/WHoLKfANyWs+xwbQ0Pn/FCJHYyyjx9fYFJgjnNaPExd9dTCBVvAJ2
        Ej+vnGcBsVkEVCVW/t3MBhEXlDg58wlYXFQgWqJ12X2wuLCAl8SpnXtYQWxmAXGJW0/mg80R
        EbjPLPG6rRpkAbPAA0aJuee+MoIk2AS0Jb6vXwzWwAm0rGXrZCaIZnmJ5q2zmSFOfcMhsWG3
        JYTtIrHl4kmoF4QlXh3fwg5hS0m87G+DsrMl2qf/YYWwKyQubpgNVW8sMetZO9BeDqD5mhLr
        d+mDmBICyhJHbrFAbOWT6Dj8lx0izCvR0SYE0agmcX8qLNxkJCYdWckEYXtINE+ezjaBUXEW
        UqDMQvL8LCS/zELYu4CRZRWjWGpBcW56arFRgRE8spPzczcxghO5ltsOxilvP+gdYmTiYDzE
        KMHBrCTCay4XkirEm5JYWZValB9fVJqTWnyI0RQYNROZpUST84G5JK8k3tDE0sDEzMzQ3MjU
        wFxJnPde69wUIYH0xJLU7NTUgtQimD4mDk6pBqbizIZnE6S501zMTFuvJe5Z/+DY61k3G70P
        LdwkN03woKOdfdWk+nVxt9x+/psbcXIL+7q0Fa5Ta8reXauaGtgUwsOlL8XgrJofE2N8M6Is
        mY+R5U17ku+VzfN6V9q9DU3IqG3+9WOv7eaVt490m1z4knl5x3q31esDtTrPbZ4md6Npcfsk
        oVc1txLcdXcu3fr0xGtG77YyO4vuX7X850T3narwrtzf7DS5MOV15Z7Gl6UXTqlEJb1lLeGY
        G6fJyHm5MESyczLHrRwDg+7PnI0sDczZuzy9nnw8fnDfrtC28tMcWcrOl+fcD5A7VxSz03Dv
        gh3HnEKbsnduj88/9W9Tzo231iJTfftP5terv1BiKc5INNRiLipOBABkgeg7bQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSvO4aifBUgw8X2CwezNvGZrFm7zkm
        i/lHzrFaNC9ez2bxbq6Mxd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfN4u7dVYwWM87vY7I4
        s7iX3aJ17xF2i8Nv2lktfu6ax2KxahdQ3e2JkxkdhDx2zrrL7rFpVSebx51re9g89s9dw+6x
        eUm9R/9fA4++LasYPT5vkgvgiOKySUnNySxLLdK3S+DK+HjwIFvBbMuK3jNT2RsYj+l2MXJy
        SAiYSDQ+f8XYxcjFISSwm1Gi8+ISVoiEjMTyZ31sELawxP2WI6wQRS8ZJY7/OcUIkuAVsJP4
        eeU8C4jNIqAqsfLvZjaIuKDEyZlPwOKiAtESqz9fABsqLOAlcWrnHjCbWUBc4taT+UwgQ0UE
        HjNLPJz6nxnEYRZ4wCixfNIjqHWPmSRmrHjFDtLCJqAt8X39YrB2TqDVLVsnM0GMMpPo2trF
        CGHLSzRvnc08gVFoFpJLZiHZOAtJyywkLQsYWVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl
        5+duYgTHsJbGDsZ78//pHWJk4mA8xCjBwawkwmsuF5IqxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nNdwxuwUIYH0xJLU7NTUgtQimCwTB6dUA9Nch8jzkTqNRfu6DBdFh0xjZpwldPR7qvFLmbOG
        MQfrWmYIWmRrCO1oabvikN4fxivF4sLyOkOx58rFV0vjX6+6eDBMwPvv8hOft4vpbzcQcgha
        9Pz+7gveX3VeVO6ebH96dUhHxN4un4IJR9UfWou6fViRElNx48AH0/hCNRuBFZmHLhps3XQg
        KfPOxD32ShVPnOZqzRNbl3itlTU691wyQ5xrqaLdF/03cU8fsvp8kZSM+s2y5pf13u9huVyP
        Am5YdPS3dLP48505HOkjKlVznd3M4O7W317xgiuMTUOWXXdP3bj08/tnBwpzSjbN+BCwWkvs
        Y7KnKuOG2Ju1lypVS6e9n9Qt1x8XKuk/R4mlOCPRUIu5qDgRAMZetlVQAwAA
X-CMS-MailID: 20231117073924epcas2p429428d5dfdcd3a4d6019bb8ceb7ce151
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115095856epcas2p1c3ee85750828bec2ee4ab0adeaeaff28
References: <20231115095609.39883-1-jaewon02.kim@samsung.com>
        <CGME20231115095856epcas2p1c3ee85750828bec2ee4ab0adeaeaff28@epcas2p1.samsung.com>
        <20231115095609.39883-11-jaewon02.kim@samsung.com>
        <62b7176d-f99c-49f6-a287-17a6b3604c1c@linaro.org>
        <f0f6a7af-2170-89a2-1eea-dfb9d8440321@samsung.com>
        <6a5610e0-e60d-4ab7-8708-6f77a38527b7@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 11. 16. 20:21, Krzysztof Kozlowski wrote:
> On 16/11/2023 06:39, Jaewon Kim wrote:
>> On 23. 11. 15. 21:28, Krzysztof Kozlowski wrote:
>>
>>> On 15/11/2023 10:56, Jaewon Kim wrote:
>>>> ExynosAutov920 GPIO has a different register structure.
>>>> In the existing Exynos series, EINT control register enumerated after
>>>> a specific offset (e.g EXYNOS_GPIO_ECON_OFFSET).
>>>> However, in ExynosAutov920 SoC, the register that controls EINT belongs
>>>> to each GPIO group, and each GPIO group has 0x1000 align.
>>>>
>>>> This is a structure to protect the GPIO group with S2MPU in VM environment,
>>>> and will only be applied in ExynosAuto series SoCs.
>>>>
>>>> Example)
>>>> -------------------------------------------------
>>>> | original		| ExynosAutov920	|
>>>> |-----------------------------------------------|
>>>> | 0x0	GPIO_CON	| 0x0	GPIO_CON	|
>>>> | 0x4	GPIO_DAT	| 0x4	GPIO_DAT	|
>>>> | 0x8	GPIO_PUD	| 0x8	GPIO_PUD	|
>>>> | 0xc	GPIO_DRV	| 0xc	GPIO_DRV	|
>>>> | 0x700	EINT_CON	| 0x18	EINT_CON	|
>>>> | 0x800	EINT_FLTCON	| 0x1c	EINT_FLTCON0	|
>>>> | 0x900	EINT_MASK	| 0x20	EINT_FLTCON1	|
>>>> | 0xa00	EINT_PEND	| 0x24	EINT_MASK	|
>>>> |			| 0x28	EINT_PEND	|
>>>> -------------------------------------------------
>>>>
>>>> Pinctrl data for ExynosAutoV920 SoC.
>>>>    - GPA0,GPA1 (10): External wake up interrupt
>>>>    - GPQ0 (2): SPMI (PMIC I/F)
>>>>    - GPB0,GPB1,GPB2,GPB3,GPB4,GPB5,GPB6 (47): I2S Audio
>>>>    - GPH0,GPH1,GPH2,GPH3,GPH4,GPH5,GPH6,GPH8 (49): PCIE, UFS, Ethernet
>>>>    - GPG0,GPG1,GPG2,GPG3,GPG4,GPG5 (29): General purpose
>>>>    - GPP0,GPP1,GPP2,GPP3,GPP4,GPP5,GPP6,GPP7,GPP8,GPP9,GPP10 (77): USI
>>>>
>>>> Signed-off-by: Jaewon Kim<jaewon02.kim@samsung.com>
>>>> ---
>>>>    .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 140 ++++++++++++++++++
>>>>    drivers/pinctrl/samsung/pinctrl-exynos.c      | 102 ++++++++++++-
>>>>    drivers/pinctrl/samsung/pinctrl-exynos.h      |  27 ++++
>>>>    drivers/pinctrl/samsung/pinctrl-samsung.c     |   5 +
>>>>    drivers/pinctrl/samsung/pinctrl-samsung.h     |  13 ++
>>>>    5 files changed, 280 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>>>> index cb965cf93705..cf86722a70a3 100644
>>>> --- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>>>> +++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>>>> @@ -796,3 +796,143 @@ const struct samsung_pinctrl_of_match_data fsd_of_data __initconst = {
>>>>    	.ctrl		= fsd_pin_ctrl,
>>>>    	.num_ctrl	= ARRAY_SIZE(fsd_pin_ctrl),
>>>>    };
>>>> +
>>>> +/* pin banks of exynosautov920 pin-controller 0 (ALIVE) */
>>>> +static struct samsung_pin_bank_data exynosautov920_pin_banks0[] = {
>>> So you created patch from some downstream code? No, please work on
>>> upstream. Take upstream code and customize it to your needs. That way
>>> you won't introduce same mistakes fixes years ago.
>>>
>>> Missing const.
>> Thanks for the guide.
>>
>> I didn`t work on downstream source, but when I copy/paste
>>
>> the struct enumerations from downstream, it seemed like
> That's what I am talking about. Don't do like this.
>
> We fixed several things in Linux kernel, so copying unfixed code is
> wasting of everyone's time. Don't work on downstream. Don't copy
> anything from downstream. You *MUST CUSTOMIZE* upstream file, not
> downstream.

Got it. I will not copy from downstream code.


>
>
>> 'const' was missing.
>>
>>> ...
>>>
>>>> @@ -31,6 +31,7 @@
>>>>    #define EXYNOS7_WKUP_EMASK_OFFSET	0x900
>>>>    #define EXYNOS7_WKUP_EPEND_OFFSET	0xA00
>>>>    #define EXYNOS_SVC_OFFSET		0xB08
>>>> +#define EXYNOSAUTOV920_SVC_OFFSET	0xF008
>>>>    
>>> ...
>>>
>>>>    #ifdef CONFIG_PINCTRL_S3C64XX
>>>>    	{ .compatible = "samsung,s3c64xx-pinctrl",
>>>> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
>>>> index 9b3db50adef3..cbb78178651b 100644
>>>> --- a/drivers/pinctrl/samsung/pinctrl-samsung.h
>>>> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
>>>> @@ -122,6 +122,9 @@ struct samsung_pin_bank_type {
>>>>     * @eint_type: type of the external interrupt supported by the bank.
>>>>     * @eint_mask: bit mask of pins which support EINT function.
>>>>     * @eint_offset: SoC-specific EINT register or interrupt offset of bank.
>>>> + * @mask_offset: SoC-specific EINT mask register offset of bank.
>>>> + * @pend_offset: SoC-specific EINT pend register offset of bank.
>>>> + * @combine: EINT register is adjacent to the GPIO control register.
>>> I don't understand it. Adjacent? Are you sure? GPIO control register has
>>> 0xF004 (EXYNOSAUTOV920_SVC_OFFSET + 0x4)? Anyway, this does not scale.
>>> What if next revision comes with not-adjacent. There will be
>>> "combine_plus"? Also name confuses me - combine means together.
>>>
>>> Also your first map of registers does not have it adjacent...
>> I think I should have added a little more information about new struct.
>>
>> -------------------------------------------------
>> | original             | ExynosAutov920         |
>> |-----------------------------------------------|
>> | 0x0   GPA_CON	       | 0x0    GPA_CON         |
>> | 0x4   GPA_DAT	       | 0x4    GPA_DAT         |
>> | 0x8   GPA_PUD	       | 0x8    GPA_PUD         |
>> | 0xc   GPA_DRV	       | 0xc    GPA_DRV         |
>> |----------------------| 0x18   EINT_GPA_CON    |
>> | 0x20  GPB_CON        | 0x1c   EINT_GPA_FLTCON0|
>> | 0x4   GPB_DAT	       | 0x20   EINT_GPA_FLTCON1|
>> | 0x28  GPB_PUD	       | 0x24   EINT_GPA_MASK   |
>> | 0x2c  GPB_DRV	       | 0x28   EINT_GPA_PEND   |
>> |----------------------|------------------------|
>> | 0x700	EINT_GPA_CON   | 0x1000 GPA_CON         |
>> | 0x704	EINT_GPB_CON   | 0x1004 GPA_DAT         |
>> |----------------------| 0x1008 GPA_PUD         |
>> | 0x800	EINT_GPA_FLTCON| 0x100c GPA_DRV         |
>> | 0x804	EINT_GPB_FLTCON| 0x1018 EINT_GPA_CON    |
>> |----------------------| 0x101c EINT_GPA_FLTCON0|
>> | 0x900	EINT_GPA_MASK  | 0x1020 EINT_GPA_FLTCON1|
>> | 0x904	EINT_GPB_MASK  | 0x1024 EINT_GPA_MASK   |
>> |----------------------| 0x1028 EINT_GPA_PEND   |
>> | 0xa00	EINT_GPA_PEND  |------------------------|
>> | 0xa04	EINT_GPB_PEND  |                        |
>> ------------------------------------------------|
>> | 0xb08 SVC            | 0xf008 SVC             |
>> -------------------------------------------------
>>
>> The reason why I chose variable name 'combine' is that EINT registers was
>> separated from gpio control address. However, in exynosautov920 EINT
>> registers combined with GPx group. So I chose "combine" word.
> What does it mean "the GPx group"? Combined means the same place, the
> same register. I could imagine offset is 0x4, what I wrote last time.
>
> Is the offset 0x4?
>
>
>> Is another reasonable word, I will change it.
>
> Why you cannot store the offset?
>
>> EINT registers related to the entire group(e.g SVC) were at the end of
>> the GPIO block and are now moved to 0xf000.
> So not in the same register, not combined?
>
Okay,

Instead of the word combine, I will think of a better word in next version.


Thanks

Jaewon Kim

