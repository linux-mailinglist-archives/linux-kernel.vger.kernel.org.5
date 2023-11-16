Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74177EDBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbjKPHVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjKPHVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:21:14 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4D9182
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:21:10 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231116072106epoutp04c2b150b8fc563e349a0c7f7c66e5c684~YCXchXJin0777607776epoutp04h
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:21:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231116072106epoutp04c2b150b8fc563e349a0c7f7c66e5c684~YCXchXJin0777607776epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700119266;
        bh=u8E99f1NXOYNCstPOVw2U01/UNiPDcWsjwx3IgmBrr0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=nsFDoVLNSvPth1+4tEJQgfPY3s9JOHpabCJm3StYmFGDuOkEGIcP5W+oGB5iY1p12
         FS7/8b3O8wa+VJYs9WmWkJgGj5myGlTwdRln+2ma2Bnpc+2a015sj+LqP6+MQO1UlS
         IoOZVQTpXEkupv0ojzyBZacys1ddJbxlfzYrVuNw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231116072106epcas2p127f6a407e41cecf23fa7007cfb2dcb15~YCXcFPkJg2754627546epcas2p1G;
        Thu, 16 Nov 2023 07:21:06 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SWBKF34krz4x9Q4; Thu, 16 Nov
        2023 07:21:05 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.00.10006.1E2C5556; Thu, 16 Nov 2023 16:21:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231116072104epcas2p32f44be9479074149027c07ee00b90cb3~YCXa0rH8t1977419774epcas2p3O;
        Thu, 16 Nov 2023 07:21:04 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231116072104epsmtrp1c4a7b897c2ff6e30a28fb17111379e72~YCXazagqQ0860308603epsmtrp1o;
        Thu, 16 Nov 2023 07:21:04 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-61-6555c2e10ad0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.10.08817.0E2C5556; Thu, 16 Nov 2023 16:21:04 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231116072104epsmtip1e9d95f8033c6e5a44d6ed5eaecff878a~YCXaeTzXU0695006950epsmtip1U;
        Thu, 16 Nov 2023 07:21:04 +0000 (GMT)
Message-ID: <bd312683-c3fc-bb85-3e8e-4b329e7e5719@samsung.com>
Date:   Thu, 16 Nov 2023 16:18:17 +0900
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
In-Reply-To: <62b7176d-f99c-49f6-a287-17a6b3604c1c@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmme7DQ6GpBh/bxCwezNvGZrFm7zkm
        i/lHzrFaNC9ez2bxbq6Mxd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfN4u7dVYwWM87vY7I4
        s7iX3aJ17xF2i8Nv2lktfu6ax2KxahdQ3e2JkxkdhDx2zrrL7rFpVSebx51re9g89s9dw+6x
        eUm9R/9fA4++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdS
        yEvMTbVVcvEJ0HXLzAH6REmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yY
        W1yal66Xl1piZWhgYGQKVJiQndHycj57wV7jirdfTrI3ML7T7GLk5JAQMJG4emMySxcjF4eQ
        wA5GiTl3XrNDOJ8YJdra3kM53xglPvbsZINpOfzmJTNEYi+jxKwbj5kgnNeMEpNnNwG1cHDw
        CthJTLshBNLAIqAqMf1vC1gzr4CgxMmZT1hAbFGBaInWZffB4sICXhKndu5hBbGZBcQlbj2Z
        zwRiiwjcZ5Z43VYNMp9Z4AGjxNxzXxlBEmwC2hLf1y8Ga+AE2jXz+XUmiGZ5ie1v54BdJyHw
        gUPi4cW7jBBnu0g8OvcRyhaWeHV8CzuELSXxsr8Nys6WaJ/+hxXCrpC4uGE21MvGErOetTOC
        PMYsoCmxfpc+iCkhoCxx5BYLxFo+iY7Df9khwrwSHW1CEI1qEvennoMaIiMx6chKJgjbQ6J5
        8nS2CYyKs5BCZRaS72cheWYWwt4FjCyrGMVSC4pz01OLjQoM4ZGdnJ+7iRGcyLVcdzBOfvtB
        7xAjEwfjIUYJDmYlEV5zuZBUId6UxMqq1KL8+KLSnNTiQ4ymwLiZyCwlmpwPzCV5JfGGJpYG
        JmZmhuZGpgbmSuK891rnpggJpCeWpGanphakFsH0MXFwSjUwNSu+uR8/W1XllInl/n4Fq0UH
        s596OU6JWfbr6vHbV9/eSSkO0ORk9VaLluGfa5OSXZ/zmKvjJqP2DpUbH/dxBuuc2R4yf9re
        Hl+eabGrhdu/MUWzH7k79XbP8iPsGz7tWCwXvOWQ4FmuoKSlugk27Teu/DpWf3BlbfGPKO/K
        v+Wmz+9e/JHarCH86lh7VtKyAxP2pRc7mAvfXsu1I/i+0yTL+JVGkZ4/mWI/dH6U3pC7NvKY
        dtBsszX+zLtOGWrt8tr8tKxw/+81c+oUpr2pO3j8P+cdESmzo8cmr2E34W+ec+2P9XzDaYlZ
        O66+qxCrPrd6VfXba0rilhOKJ5dHKS7Tl+uYtrDVnFPrlFv/GyWW4oxEQy3mouJEAAl1KuNt
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSnO6DQ6GpBo9uqls8mLeNzWLN3nNM
        FvOPnGO1aF68ns3i3VwZi72vt7JbTPmznMli0+NrrBab5/9htLi8aw6bxd27qxgtZpzfx2Rx
        ZnEvu0Xr3iPsFofftLNa/Nw1j8Vi1S6gutsTJzM6CHnsnHWX3WPTqk42jzvX9rB57J+7ht1j
        85J6j/6/Bh59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CV0fJyPnvBXuOKt19OsjcwvtPsYuTk
        kBAwkTj85iUziC0ksJtR4uYXJoi4jMTyZ31sELawxP2WI6xdjFxANS8ZJW7c3gBUxMHBK2An
        Me2GEEgNi4CqxPS/LWD1vAKCEidnPmEBsUUFoiVWf77ACmILC3hJnNq5B8xmFhCXuPVkPhPI
        TBGBx8wSD6f+ZwZxmAUeMEosn/QIatsvRom+eXPAxrIJaEt8X78YrJ0TaPPM59eZIEaZSXRt
        7WKEsOUltr+dwzyBUWgWkktmIdk4C0nLLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al
        6yXn525iBMevltYOxj2rPugdYmTiYDzEKMHBrCTCay4XkirEm5JYWZValB9fVJqTWnyIUZqD
        RUmc99vr3hQhgfTEktTs1NSC1CKYLBMHp1QD085jt5Zax2434epcZvIwzXzHiycK207eL77S
        EKgce/Wqtt3puo5Uidm/XevOGj8PLOet2dKRuFKiuL9Uc9d9Jukrr7PDyyeFmN2ZzSCfvIDn
        csglY0PD3Y5njqbY/VtXv/tafm2C06IFVlUSL9McNaTaWqy797VPWfT2zmlZeeUrm2dnCFy8
        vuBdyxHxHZPfmokvaN2wNVXrneyt2rPHV/y98JB/11WrkM6Tnxs2xMqf7+DwesctEvdWnXP2
        9j1BD1MnaXQaCazr2CXPv+D8FZ8zzYXHvljNaH3S1PBysrSOeXSE++lfwsrd287JvFpUxmwk
        FL9o4qZoDsWYlwE/vaa+bNpwx9XIaU179NvjNUosxRmJhlrMRcWJAGF6i29OAwAA
X-CMS-MailID: 20231116072104epcas2p32f44be9479074149027c07ee00b90cb3
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
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,


I sent it again because the mail format was broken due to the HTML part.


On 23. 11. 15. 21:28, Krzysztof Kozlowski wrote:
> On 15/11/2023 10:56, Jaewon Kim wrote:
>> ExynosAutov920 GPIO has a different register structure.
>> In the existing Exynos series, EINT control register enumerated after
>> a specific offset (e.g EXYNOS_GPIO_ECON_OFFSET).
>> However, in ExynosAutov920 SoC, the register that controls EINT belongs
>> to each GPIO group, and each GPIO group has 0x1000 align.
>>
>> This is a structure to protect the GPIO group with S2MPU in VM environment,
>> and will only be applied in ExynosAuto series SoCs.
>>
>> Example)
>> -------------------------------------------------
>> | original		| ExynosAutov920	|
>> |-----------------------------------------------|
>> | 0x0	GPIO_CON	| 0x0	GPIO_CON	|
>> | 0x4	GPIO_DAT	| 0x4	GPIO_DAT	|
>> | 0x8	GPIO_PUD	| 0x8	GPIO_PUD	|
>> | 0xc	GPIO_DRV	| 0xc	GPIO_DRV	|
>> | 0x700	EINT_CON	| 0x18	EINT_CON	|
>> | 0x800	EINT_FLTCON	| 0x1c	EINT_FLTCON0	|
>> | 0x900	EINT_MASK	| 0x20	EINT_FLTCON1	|
>> | 0xa00	EINT_PEND	| 0x24	EINT_MASK	|
>> |			| 0x28	EINT_PEND	|
>> -------------------------------------------------
>>
>> Pinctrl data for ExynosAutoV920 SoC.
>>   - GPA0,GPA1 (10): External wake up interrupt
>>   - GPQ0 (2): SPMI (PMIC I/F)
>>   - GPB0,GPB1,GPB2,GPB3,GPB4,GPB5,GPB6 (47): I2S Audio
>>   - GPH0,GPH1,GPH2,GPH3,GPH4,GPH5,GPH6,GPH8 (49): PCIE, UFS, Ethernet
>>   - GPG0,GPG1,GPG2,GPG3,GPG4,GPG5 (29): General purpose
>>   - GPP0,GPP1,GPP2,GPP3,GPP4,GPP5,GPP6,GPP7,GPP8,GPP9,GPP10 (77): USI
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 140 ++++++++++++++++++
>>   drivers/pinctrl/samsung/pinctrl-exynos.c      | 102 ++++++++++++-
>>   drivers/pinctrl/samsung/pinctrl-exynos.h      |  27 ++++
>>   drivers/pinctrl/samsung/pinctrl-samsung.c     |   5 +
>>   drivers/pinctrl/samsung/pinctrl-samsung.h     |  13 ++
>>   5 files changed, 280 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>> index cb965cf93705..cf86722a70a3 100644
>> --- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>> +++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>> @@ -796,3 +796,143 @@ const struct samsung_pinctrl_of_match_data fsd_of_data __initconst = {
>>   	.ctrl		= fsd_pin_ctrl,
>>   	.num_ctrl	= ARRAY_SIZE(fsd_pin_ctrl),
>>   };
>> +
>> +/* pin banks of exynosautov920 pin-controller 0 (ALIVE) */
>> +static struct samsung_pin_bank_data exynosautov920_pin_banks0[] = {
> So you created patch from some downstream code? No, please work on
> upstream. Take upstream code and customize it to your needs. That way
> you won't introduce same mistakes fixes years ago.
>
> Missing const.

I did not work on downstream source.

Kernel version is different, and there are numerous SoCs, So bringing 
the patch

form the downstream make conflicts. Don`t worry about it.

Only GPIO struct was copied in the downstream code and the 'const' was 
missing.

Anyway, I will add const in next version.


>
> ...
>
>> @@ -31,6 +31,7 @@
>>   #define EXYNOS7_WKUP_EMASK_OFFSET	0x900
>>   #define EXYNOS7_WKUP_EPEND_OFFSET	0xA00
>>   #define EXYNOS_SVC_OFFSET		0xB08
>> +#define EXYNOSAUTOV920_SVC_OFFSET	0xF008
>>   
> ...
>
>>   #ifdef CONFIG_PINCTRL_S3C64XX
>>   	{ .compatible = "samsung,s3c64xx-pinctrl",
>> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
>> index 9b3db50adef3..cbb78178651b 100644
>> --- a/drivers/pinctrl/samsung/pinctrl-samsung.h
>> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
>> @@ -122,6 +122,9 @@ struct samsung_pin_bank_type {
>>    * @eint_type: type of the external interrupt supported by the bank.
>>    * @eint_mask: bit mask of pins which support EINT function.
>>    * @eint_offset: SoC-specific EINT register or interrupt offset of bank.
>> + * @mask_offset: SoC-specific EINT mask register offset of bank.
>> + * @pend_offset: SoC-specific EINT pend register offset of bank.
>> + * @combine: EINT register is adjacent to the GPIO control register.
> I don't understand it. Adjacent? Are you sure? GPIO control register has
> 0xF004 (EXYNOSAUTOV920_SVC_OFFSET + 0x4)? Anyway, this does not scale.
> What if next revision comes with not-adjacent. There will be
> "combine_plus"? Also name confuses me - combine means together.
>
> Also your first map of registers does not have it adjacent...

I think I should have added more information about new architect.

-------------------------------------------------
| original		| ExynosAutov920	 |
|------------------------------------------------|
| 0x0   GPA_CON		| 0x0    GPA_CON	 |
| 0x4   GPA_DAT		| 0x4    GPA_DAT	 |
| 0x8   GPA_PUD		| 0x8    GPA_PUD	 |
| 0xc   GPA_DRV		| 0xc    GPA_DRV	 |
|-----------------------| 0x18   EINT_GPA_CON	 |
| 0x20  GPB_CON		| 0x1c   EINT_GPA_FLTCON0|
| 0x24  GPB_DAT		| 0x20   EINT_GPA_FLTCON1|
| 0x28  GPB_PUD		| 0x24   EINT_GPA_MASK	 |
| 0x2c  GPB_DRV		| 0x28   EINT_GPA_PEND	 |
|-----------------------|------------------------|
| 0x700 EINT_GPA_CON	| 0x1000 GPB_CON	 |
| 0x704 EINT_GPB_CON	| 0x1004 GPB_DAT	 |
|-----------------------| 0x1008 GPB_PUD	 |
| 0x800 EINT_GPA_FLTCON	| 0x100c GPB_DRV	 |
| 0x804 EINT_GPB_FLTCON	| 0x1018 EINT_GPB_CON	 |
|-----------------------| 0x101c EINT_GPB_FLTCON0|
| 0x900 EINT_GPA_MASK	| 0x1020 EINT_GPB_FLTCON1|
| 0x904 EINT_GPB_MASK	| 0x1024 EINT_GPB_MASK	 |
|-----------------------| 0x1028 EINT_GPB_PEND	 |
| 0xa00 EINT_GPA_PEND	|------------------------|
| 0xa04 EINT_GPB_PEND	|			 |
|-----------------------|------------------------|
| 0xb08 SVC		| 0xf008 SVC		 |
-------------------------------------------------|


The reason why I chose variable name 'combine' is that EINT registers was

separated from gpio control address. However, in exynosautov920 EINT

registers combined with GPx group. So I chose "combine" word.

If there is more reasonable name, i will change it.

And I will also change the description of the variable.


EINT registers related to the entire group(e.g SVC) were at the end of

the GPIO block 0xb00 and now it has been moved to 0xf000.


>
> Anyway first patch is to rework driver to support new register layout.
> Second patch is to add new variant.

Okay, I will divide the patch in the next version.

>
> Best regards,
> Krzysztof
>
>

Thanks

Jaewon Kim

