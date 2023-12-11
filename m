Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B268880BF43
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjLKClt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjLKCls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:41:48 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC95E8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 18:41:51 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231211024150epoutp03e62ff979718ea588d1b63d0c202bd826~fprvm1bAh2937329373epoutp03Z
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:41:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231211024150epoutp03e62ff979718ea588d1b63d0c202bd826~fprvm1bAh2937329373epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702262510;
        bh=ZYIIjWWje1plfriKCC+pMHMU/g6sWyXy3v70HneMEnU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=olm5cH4pwDW8/26zBCFGFqnZgJqHp52Q+rvbtxRl8QG9DYUMhdXQZnyk6Qdxbt/17
         V5NLmUbW2KfybCpLuoBLx4aBlkggYmO1mYRbvFZ7K+n1sfR9pKCnvq3GzspO8egwfr
         jesZIzeRls+GpwllikHG1oG/Jzvgco80fjuIU/wI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231211024149epcas2p3ae1c8cf32de8a802ebafb602dc7e9e82~fprvItwP60449004490epcas2p3V;
        Mon, 11 Dec 2023 02:41:49 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.69]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SpQxT01jvz4x9Pr; Mon, 11 Dec
        2023 02:41:49 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.C9.18994.CE676756; Mon, 11 Dec 2023 11:41:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231211024148epcas2p24432804d1dfa9406cc2aa2b1623d873d~fpruCXlPl2678326783epcas2p2S;
        Mon, 11 Dec 2023 02:41:48 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231211024148epsmtrp2e3f76147370a68a710f785ca8ddacebe~fpruBauQ_2191321913epsmtrp2T;
        Mon, 11 Dec 2023 02:41:48 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-06-657676ec9338
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.A6.07368.CE676756; Mon, 11 Dec 2023 11:41:48 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231211024148epsmtip2955336bd1de28d9bd406140ab625f089~fprts0TTc2003620036epsmtip2D;
        Mon, 11 Dec 2023 02:41:48 +0000 (GMT)
Message-ID: <7800ae2d-cc19-ce7c-7b3b-54016903d8ec@samsung.com>
Date:   Mon, 11 Dec 2023 11:38:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/4] pinctrl: samsung: support ExynosAuto GPIO
 structure
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
In-Reply-To: <421ede4c-7a96-47e0-9b82-0eb350b59c33@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbVRzeuff29kLGcimPnSBRuBtbxtbSEiiXSTcfbNxFSZhM4iBS7+gN
        INA2bUHQJg4JD1nUvSDa8ejSiVKbgIXhZCtEqA6RgeACjlGojLBkwBZl3bLIw5aLyn/f78vv
        +37n+51zCFQ0hYcR+WoDp1OzhRTuj3X175OLF0tKOOnUWALtburCaZtjGKGbncMCusLShtMP
        G8Npx8JVIX1x5SuEtt8bF9AdzSuA/q27AaddLiugPx/pQeghyydCutLhFNL9i9UC+ll3E0Zb
        u719d89dAC+JmO9NLiFjt36MM1PjN3Cmt9EmZDqufMh8tiplPu20AmbZ/nwakVmQlMexKk4X
        walzNKp8da6Cei1d+aoyXi6ViWWJdAIVoWaLOAWV/Hqa+Gh+oTcJFVHCFhZ7qTRWr6diDiXp
        NMUGLiJPozcoKE6rKtQmaCV6tkhfrM6VqDnDQZlUGhvvbXynIK9lcg1or6eU3hpvFZwGfybW
        Aj8CknGwY3xAUAv8CRF5A8D6URvOF38BuDY4ulk8AXCwaxSrBcSGpOriDp53ADj72CLkiwUA
        p7/5Hff5BpCH4ERdHfBhjIyCDQ7XJh8If/5iDvPhEDILVrbM4D7TIPI4NA/u99EouRNOzjUj
        PhxMzqBwoeoDnz9KugFsHPZseOLkfvi0zSLwYT/vrMtuD8KLX4DfLTWgPgEkHxNwuvM+xgdN
        hiOtZxAeB8EHNzuFPA6Dyw8dOI81sOr20CZvhN+axwCPD0PT350C30FRch9s647hF7ELOicx
        fuwOWNO/KuTpAFhTJeKFe+BM3fCmeTg872xF+BYGDrTQZ0GkactOTFvCm7ZkMf0/1gwwKwjj
        tPqiXC4nVisTq7n3/rvuHE2RHWw88+jUa2ChbVXSBxAC9AFIoFRwQLhTz4kCVGzZ+5xOo9QV
        F3L6PhDvvZ1zaFhIjsb7T9QGpSwuURonl8sSYuOlCdTOgOnKRpWIzGUNXAHHaTndvzqE8As7
        jWxviHxwbOmt48byyDj/3hPIl1feqE49Y9k9O/+1Yfe9vKSl2Xa7fWjvhMtYMa/oPRxlrO/K
        kEuaZSFvr8PzPe1PnxniL9/VNsbcVM5sS5/LGnCzBXccE0NRHsGbpPtlT5TgJKm4RJxYP2vE
        HlXnf9T3a7orqzgCDzyqzlCoWkvl85nvdv7x3NhPKaeetJTlx7mCroVIzLE2dDJU23Oq6daa
        tafqh0sNK+Mjzmnx3l3RkTHXp1OPDZu3h7pHKyaYk4/KPdVHymeyb4ujB4EFPXhgoU7pTrbN
        lQa+Um2jfilTLR2ZqK/JXm8PDt2WsefOiyvYojZlMDvzR9WBqftXY5aXKEyfx8qiUZ2e/Qdc
        JM5tbwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSvO6bsrJUg4+dghYP5m1js1iz9xyT
        xfwj51gtmhevZ7N4N1fGYu/rrewWU/4sZ7LY9Pgaq8Xm+X8YLS7vmsNmcffuKkaLGef3MVmc
        WdzLbtG69wi7xeE37awWP3fNY7FYtQuo7vbEyYwOQh47Z91l99i0qpPN4861PWwe++euYffY
        vKTeo/+vgUffllWMHp83yQVwRHHZpKTmZJalFunbJXBlLLv1j7Fgt3vF2WsrWRsYP1p2MXJw
        SAiYSLRN4eti5OIQEtjNKHFwfQNbFyMnUFxGYvmzPihbWOJ+yxFWiKKXjBJdi56ygiR4Bewk
        rk+dyghiswioSszZe5cNIi4ocXLmExYQW1QgWmL15wusIMuEBQIlFpzSBgkzC4hL3Hoynwlk
        pojAY2aJh1P/M4M4zAIPGCWWT3oEte0no0Tfx1Z2kBY2AW2J7+sXg23mBNq88MFXJohRZhJd
        W7sYIWx5ie1v5zBPYBSaheSQWUg2zkLSMgtJywJGllWMkqkFxbnpucmGBYZ5qeV6xYm5xaV5
        6XrJ+bmbGMHxq6Wxg/He/H96hxiZOBgPMUpwMCuJ8MocKU4V4k1JrKxKLcqPLyrNSS0+xCjN
        waIkzms4Y3aKkEB6YklqdmpqQWoRTJaJg1OqgclX9phl9DX7Ko/vIUbdklEB/+06f8nxbTwl
        cKNvH8eXRfcqniyKKvDRVQmak+7F1xX6adJK8cUtVvETkuboRivJZ07bVHg43C9r7xGp7Ddl
        c8RV9xawi6ZdCzgWOH3GCz/RzVMjFtb9+/8txspric2C6y88vC0rLrz+u+bvcdUGrRz1hxc+
        fjU5tOBjhcKFt1oik+x+sbyberhs/dX6tRXcFh/iFl+1vPZs87r+2RGKfDtj1399+9ktxSzt
        Y8UUh3vRKSuObgv3rI7f6MVuwD2N3fzFW8FlV5dx9ZpPPO76Yc4kzwXPvL98F5/8+hqT1qp7
        bmfnb1M2XtF5c1Z0fa71IpspVX4zZhvu65xrKHxCiaU4I9FQi7moOBEAwb2xuU4DAAA=
X-CMS-MailID: 20231211024148epcas2p24432804d1dfa9406cc2aa2b1623d873d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231208075020epcas2p260c65fa8d33e0cd97806f065bb8a044d
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
        <CGME20231208075020epcas2p260c65fa8d33e0cd97806f065bb8a044d@epcas2p2.samsung.com>
        <20231208074527.50840-4-jaewon02.kim@samsung.com>
        <421ede4c-7a96-47e0-9b82-0eb350b59c33@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

Thanks to review.


On 23. 12. 10. 22:00, Krzysztof Kozlowski wrote:
> On 08/12/2023 08:45, Jaewon Kim wrote:
>> New ExynosAuto series GPIO have a different register structure.
>> In the existing Exynos series, EINT control register enumerated after
>> a specific offset (e.g EXYNOS_GPIO_ECON_OFFSET, EXYNOS_GPIO_EMASK_OFFSET).
>> However, from ExynosAutov920 SoC, the register that controls EINT belongs
>> to each GPIO bank, and each GPIO bank has 0x1000 align.
>>
>> This is a structure to protect the GPIO bank using S2MPU in VM environment,
>> and will only be applied in ExynosAuto series SoCs.
>>
>> -------------------------------------------------
>> | original		| ExynosAutov920	|
>> |-----------------------------------------------|
>> | 0x0	GPIO_CON	| 0x0	GPIO_CON	|
>> | 0x4	GPIO_DAT	| 0x4	GPIO_DAT	|
>> | 0x8	GPIO_PUD	| 0x8	GPIO_PUD	|
>> | 0xc	GPIO_DRV	| 0xc	GPIO_DRV	|
>> | 0x10	GPIO_CONPDN	| 0x10	GPIO_CONPDN	|
>> | 0x14	GPIO_PUDPDN	| 0x14	GPIO_PUDPDN	|
>> | 0x700	EINT_CON	| 0x18	EINT_CON	|
>> | 0x800	EINT_FLTCON	| 0x1c	EINT_FLTCON0	|
>> | 0x900	EINT_MASK	| 0x20	EINT_FLTCON1	|
>> | 0xa00	EINT_PEND	| 0x24	EINT_MASK	|
>> |			| 0x28	EINT_PEND	|
>> -------------------------------------------------
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   drivers/pinctrl/samsung/pinctrl-exynos.c  | 81 +++++++++++++++++++++--
>>   drivers/pinctrl/samsung/pinctrl-exynos.h  |  1 +
>>   drivers/pinctrl/samsung/pinctrl-samsung.c |  3 +
>>   drivers/pinctrl/samsung/pinctrl-samsung.h | 12 ++++
>>   4 files changed, 90 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
>> index 6b58ec84e34b..f798f64b1122 100644
>> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
>> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
>> @@ -56,6 +56,9 @@ static void exynos_irq_mask(struct irq_data *irqd)
>>   	unsigned int mask;
>>   	unsigned long flags;
>>   
>> +	if (bank->eint_mask_offset)
>> +		reg_mask = bank->pctl_offset + bank->eint_mask_offset;
> Drop the initialization of reg_mask so:
>
> else:
> reg_mask = ...

Okay, I will fix it in v4.


>
>> +
>>   	raw_spin_lock_irqsave(&bank->slock, flags);
>>   
>>   	mask = readl(bank->eint_base + reg_mask);
>> @@ -72,6 +75,9 @@ static void exynos_irq_ack(struct irq_data *irqd)
>>   	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
>>   	unsigned long reg_pend = our_chip->eint_pend + bank->eint_offset;
>>   
>> +	if (bank->eint_pend_offset)
>> +		reg_pend = bank->pctl_offset + bank->eint_pend_offset;
>> +
>>   	writel(1 << irqd->hwirq, bank->eint_base + reg_pend);
>>   }
>>   
>> @@ -95,6 +101,9 @@ static void exynos_irq_unmask(struct irq_data *irqd)
>>   	if (irqd_get_trigger_type(irqd) & IRQ_TYPE_LEVEL_MASK)
>>   		exynos_irq_ack(irqd);
>>   
> Ditto
I will fix it also.
>
>> +	if (bank->eint_mask_offset)
>> +		reg_mask = bank->pctl_offset + bank->eint_mask_offset;
>> +
>>   	raw_spin_lock_irqsave(&bank->slock, flags);
>>   
>>   	mask = readl(bank->eint_base + reg_mask);
>> @@ -139,6 +148,9 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
>>   	else
>>   		irq_set_handler_locked(irqd, handle_level_irq);
>>   
>
> Ditto
I will fix it also.
>
>> +	if (bank->eint_con_offset)
>> +		reg_con = bank->pctl_offset + bank->eint_con_offset;
>> +
>>   	con = readl(bank->eint_base + reg_con);
>>   	con &= ~(EXYNOS_EINT_CON_MASK << shift);
>>   	con |= trig_type << shift;
>> @@ -221,6 +233,18 @@ static const struct exynos_irq_chip exynos_gpio_irq_chip __initconst = {
>>   	/* eint_wake_mask_value not used */
>>   };
>>   
>> +static const struct exynos_irq_chip exynosauto_gpio_irq_chip __initconst = {
> No related to this patch.
>
>> +	.chip = {
>> +		.name = "exynosauto_gpio_irq_chip",
>> +		.irq_unmask = exynos_irq_unmask,
>> +		.irq_mask = exynos_irq_mask,
>> +		.irq_ack = exynos_irq_ack,
>> +		.irq_set_type = exynos_irq_set_type,
>> +		.irq_request_resources = exynos_irq_request_resources,
>> +		.irq_release_resources = exynos_irq_release_resources,
>> +	},
>> +};
>> +
>>   static int exynos_eint_irq_map(struct irq_domain *h, unsigned int virq,
>>   					irq_hw_number_t hw)
>>   {
>> @@ -247,7 +271,10 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *data)
>>   	unsigned int svc, group, pin;
>>   	int ret;
>>   
>> -	svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
>> +	if (bank->eint_con_offset)
>> +		svc = readl(bank->eint_base + EXYNOSAUTO_SVC_OFFSET);
> This belongs to the second patch. The point of this patch is only to
> customize the offsets. There should be nothing autov920 here.

Okay, I will put the irq-related changes in the v920 patch.


>
>
>> +	else
>> +		svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
>>   	group = EXYNOS_SVC_GROUP(svc);
>>   	pin = svc & EXYNOS_SVC_NUM_MASK;
>>   
>> @@ -297,8 +324,12 @@ __init int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
>>   		if (bank->eint_type != EINT_TYPE_GPIO)
>>   			continue;
>>   
>> -		bank->irq_chip = devm_kmemdup(dev, &exynos_gpio_irq_chip,
>> -					   sizeof(*bank->irq_chip), GFP_KERNEL);
>> +		if (bank->eint_con_offset)
>> +			bank->irq_chip = devm_kmemdup(dev, &exynosauto_gpio_irq_chip,
>> +						      sizeof(*bank->irq_chip), GFP_KERNEL);
>> +		else
>> +			bank->irq_chip = devm_kmemdup(dev, &exynos_gpio_irq_chip,
>> +						      sizeof(*bank->irq_chip), GFP_KERNEL);
>>   		if (!bank->irq_chip) {
>>   			ret = -ENOMEM;
>>   			goto err_domains;
>> @@ -655,6 +686,19 @@ static void exynos_pinctrl_suspend_bank(
>>   	pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask);
>>   }
>>   
>> +static void exynosauto_pinctrl_suspend_bank(struct samsung_pinctrl_drv_data *drvdata,
>> +					    struct samsung_pin_bank *bank)
>> +{
>> +	struct exynos_eint_gpio_save *save = bank->soc_priv;
>> +	void __iomem *regs = bank->eint_base;
>> +
>> +	save->eint_con = readl(regs + bank->pctl_offset + bank->eint_con_offset);
>> +	save->eint_mask = readl(regs + bank->pctl_offset + bank->eint_mask_offset);
>> +
>> +	pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con);
>> +	pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask);
>> +}
>> +
>>   void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
>>   {
>>   	struct samsung_pin_bank *bank = drvdata->pin_banks;
>> @@ -662,8 +706,12 @@ void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
>>   	int i;
>>   
>>   	for (i = 0; i < drvdata->nr_banks; ++i, ++bank) {
>> -		if (bank->eint_type == EINT_TYPE_GPIO)
>> -			exynos_pinctrl_suspend_bank(drvdata, bank);
>> +		if (bank->eint_type == EINT_TYPE_GPIO) {
>> +			if (bank->eint_con_offset)
>> +				exynosauto_pinctrl_suspend_bank(drvdata, bank);
>> +			else
>> +				exynos_pinctrl_suspend_bank(drvdata, bank);
>> +		}
>>   		else if (bank->eint_type == EINT_TYPE_WKUP) {
>>   			if (!irq_chip) {
>>   				irq_chip = bank->irq_chip;
>> @@ -704,14 +752,33 @@ static void exynos_pinctrl_resume_bank(
>>   						+ bank->eint_offset);
>>   }
>>   
>> +static void exynosauto_pinctrl_resume_bank(struct samsung_pinctrl_drv_data *drvdata,
>> +					   struct samsung_pin_bank *bank)
>> +{
>> +	struct exynos_eint_gpio_save *save = bank->soc_priv;
>> +	void __iomem *regs = bank->eint_base;
>> +
>> +	pr_debug("%s:     con %#010x => %#010x\n", bank->name,
>> +		 readl(regs + bank->pctl_offset + bank->eint_con_offset), save->eint_con);
>> +	pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
>> +		 readl(regs + bank->pctl_offset + bank->eint_mask_offset), save->eint_mask);
>> +
>> +	writel(save->eint_con, regs + bank->pctl_offset + bank->eint_con_offset);
>> +	writel(save->eint_mask, regs + bank->pctl_offset + bank->eint_mask_offset);
>> +}
>> +
>>   void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>>   {
>>   	struct samsung_pin_bank *bank = drvdata->pin_banks;
>>   	int i;
>>   
>>   	for (i = 0; i < drvdata->nr_banks; ++i, ++bank)
>> -		if (bank->eint_type == EINT_TYPE_GPIO)
>> -			exynos_pinctrl_resume_bank(drvdata, bank);
>> +		if (bank->eint_type == EINT_TYPE_GPIO) {
>> +			if (bank->eint_con_offset)
>> +				exynosauto_pinctrl_resume_bank(drvdata, bank);
>> +			else
>> +				exynos_pinctrl_resume_bank(drvdata, bank);
>> +		}
>>   }
>>   
>>   static void exynos_retention_enable(struct samsung_pinctrl_drv_data *drvdata)
>> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
>> index 3ac52c2cf998..5049c170e958 100644
>> --- a/drivers/pinctrl/samsung/pinctrl-exynos.h
>> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
>> @@ -31,6 +31,7 @@
>>   #define EXYNOS7_WKUP_EMASK_OFFSET	0x900
>>   #define EXYNOS7_WKUP_EPEND_OFFSET	0xA00
>>   #define EXYNOS_SVC_OFFSET		0xB08
>> +#define EXYNOSAUTO_SVC_OFFSET		0xF008
> As well not related to this patch.
>
> Best regards,
> Krzysztof
>
>

Thanks

Jaewon Kim

