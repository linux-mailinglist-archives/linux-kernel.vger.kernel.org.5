Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6A380BAC2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 14:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjLJNAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 08:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjLJNAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 08:00:44 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9888B119
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 05:00:46 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a196f84d217so418448066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 05:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702213245; x=1702818045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QP4ZV7YyqeQFCr7fKyMgWEbeUKcNeD2cWy0MLNepC5Y=;
        b=yLvyXzrUAKrklS2oQQxMOhTJyN1fEbdEq46D3QrosqNPcA+TaOt4Qr1hn0ThBrhDmA
         eBONddjOv9UAp2/NxCg5tkoixfMQj3lYdzQ+dv3Qs5JFuMek2TbnPAm5lCJulWT0tYip
         vzXGJqWMP61H0tNC68u9Ookjm/sMeqcMgBmW0WX138yVrm0cBwUy/cUoQtREFecv+3ho
         fCU85rFrd+6bAPsnWQL8TdG60f4BgiPb6YdINLaGq4Pl2lqTrlbo0PXssgWCW3wSo9SN
         lSZP4gYN/LKDyWC2xXN6JyFBqYbcUZZHK8W/MUsWWw/U6sqzbz+BW46smoEdvD3HfH6O
         pbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702213245; x=1702818045;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QP4ZV7YyqeQFCr7fKyMgWEbeUKcNeD2cWy0MLNepC5Y=;
        b=Eh8CdTMzkGN9v+yotoVFrJ1wyMoU0dXPxZmDMrLvJuW6MfULKacjt7oHSekm7y7IyO
         gCC5NVHwx/txt6u73NuJ1p1BI6DzPyFz0CDkew7hsS1HBfzfKZgPcEj0dGp905XsHdou
         HCWpbaOLWlkGUCjpBdICr9xERU79pwOYmopI2sGAywQP7s5EjINv+HWrJemuJ0dLB6n6
         GKi0z7c3M9Wh+U0CkWjb/blgJj/QxzslyqsNJn0qt9b8qoam1rSV7fVEy29r+0dme7nY
         WfbnrwL4vWdNUP6WM1K6MBl+0Jozs2QERN96Ww6OVDkcu3O9zY2d9Rmgds1n5ULHPC78
         kA9w==
X-Gm-Message-State: AOJu0Yy2hIHZAeW6+L2gnvmDbJDR3CD9JBY2a58gLBdY9UR+xxClVOK/
        BkbagM+DSDtMKqo5gfrxhz2LWw==
X-Google-Smtp-Source: AGHT+IGQI/DZDET88OFLHl3ALDFhjRtqb/FyeP92PjFSQWaUD9rSqY2UBWBxZhhW86mGb35qqPCF4w==
X-Received: by 2002:a17:906:830f:b0:a1f:6ae3:3f99 with SMTP id j15-20020a170906830f00b00a1f6ae33f99mr1213710ejx.132.1702213244986;
        Sun, 10 Dec 2023 05:00:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tx18-20020a1709078e9200b00a1b618766cbsm3425958ejc.136.2023.12.10.05.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 05:00:44 -0800 (PST)
Message-ID: <421ede4c-7a96-47e0-9b82-0eb350b59c33@linaro.org>
Date:   Sun, 10 Dec 2023 14:00:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] pinctrl: samsung: support ExynosAuto GPIO
 structure
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
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
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
 <CGME20231208075020epcas2p260c65fa8d33e0cd97806f065bb8a044d@epcas2p2.samsung.com>
 <20231208074527.50840-4-jaewon02.kim@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231208074527.50840-4-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2023 08:45, Jaewon Kim wrote:
> New ExynosAuto series GPIO have a different register structure.
> In the existing Exynos series, EINT control register enumerated after
> a specific offset (e.g EXYNOS_GPIO_ECON_OFFSET, EXYNOS_GPIO_EMASK_OFFSET).
> However, from ExynosAutov920 SoC, the register that controls EINT belongs
> to each GPIO bank, and each GPIO bank has 0x1000 align.
> 
> This is a structure to protect the GPIO bank using S2MPU in VM environment,
> and will only be applied in ExynosAuto series SoCs.
> 
> -------------------------------------------------
> | original		| ExynosAutov920	|
> |-----------------------------------------------|
> | 0x0	GPIO_CON	| 0x0	GPIO_CON	|
> | 0x4	GPIO_DAT	| 0x4	GPIO_DAT	|
> | 0x8	GPIO_PUD	| 0x8	GPIO_PUD	|
> | 0xc	GPIO_DRV	| 0xc	GPIO_DRV	|
> | 0x10	GPIO_CONPDN	| 0x10	GPIO_CONPDN	|
> | 0x14	GPIO_PUDPDN	| 0x14	GPIO_PUDPDN	|
> | 0x700	EINT_CON	| 0x18	EINT_CON	|
> | 0x800	EINT_FLTCON	| 0x1c	EINT_FLTCON0	|
> | 0x900	EINT_MASK	| 0x20	EINT_FLTCON1	|
> | 0xa00	EINT_PEND	| 0x24	EINT_MASK	|
> |			| 0x28	EINT_PEND	|
> -------------------------------------------------
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c  | 81 +++++++++++++++++++++--
>  drivers/pinctrl/samsung/pinctrl-exynos.h  |  1 +
>  drivers/pinctrl/samsung/pinctrl-samsung.c |  3 +
>  drivers/pinctrl/samsung/pinctrl-samsung.h | 12 ++++
>  4 files changed, 90 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
> index 6b58ec84e34b..f798f64b1122 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
> @@ -56,6 +56,9 @@ static void exynos_irq_mask(struct irq_data *irqd)
>  	unsigned int mask;
>  	unsigned long flags;
>  
> +	if (bank->eint_mask_offset)
> +		reg_mask = bank->pctl_offset + bank->eint_mask_offset;

Drop the initialization of reg_mask so:

else:
reg_mask = ...


> +
>  	raw_spin_lock_irqsave(&bank->slock, flags);
>  
>  	mask = readl(bank->eint_base + reg_mask);
> @@ -72,6 +75,9 @@ static void exynos_irq_ack(struct irq_data *irqd)
>  	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
>  	unsigned long reg_pend = our_chip->eint_pend + bank->eint_offset;
>  
> +	if (bank->eint_pend_offset)
> +		reg_pend = bank->pctl_offset + bank->eint_pend_offset;
> +
>  	writel(1 << irqd->hwirq, bank->eint_base + reg_pend);
>  }
>  
> @@ -95,6 +101,9 @@ static void exynos_irq_unmask(struct irq_data *irqd)
>  	if (irqd_get_trigger_type(irqd) & IRQ_TYPE_LEVEL_MASK)
>  		exynos_irq_ack(irqd);
>  

Ditto

> +	if (bank->eint_mask_offset)
> +		reg_mask = bank->pctl_offset + bank->eint_mask_offset;
> +
>  	raw_spin_lock_irqsave(&bank->slock, flags);
>  
>  	mask = readl(bank->eint_base + reg_mask);
> @@ -139,6 +148,9 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
>  	else
>  		irq_set_handler_locked(irqd, handle_level_irq);
>  


Ditto

> +	if (bank->eint_con_offset)
> +		reg_con = bank->pctl_offset + bank->eint_con_offset;
> +
>  	con = readl(bank->eint_base + reg_con);
>  	con &= ~(EXYNOS_EINT_CON_MASK << shift);
>  	con |= trig_type << shift;
> @@ -221,6 +233,18 @@ static const struct exynos_irq_chip exynos_gpio_irq_chip __initconst = {
>  	/* eint_wake_mask_value not used */
>  };
>  
> +static const struct exynos_irq_chip exynosauto_gpio_irq_chip __initconst = {

No related to this patch.

> +	.chip = {
> +		.name = "exynosauto_gpio_irq_chip",
> +		.irq_unmask = exynos_irq_unmask,
> +		.irq_mask = exynos_irq_mask,
> +		.irq_ack = exynos_irq_ack,
> +		.irq_set_type = exynos_irq_set_type,
> +		.irq_request_resources = exynos_irq_request_resources,
> +		.irq_release_resources = exynos_irq_release_resources,
> +	},
> +};
> +
>  static int exynos_eint_irq_map(struct irq_domain *h, unsigned int virq,
>  					irq_hw_number_t hw)
>  {
> @@ -247,7 +271,10 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *data)
>  	unsigned int svc, group, pin;
>  	int ret;
>  
> -	svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
> +	if (bank->eint_con_offset)
> +		svc = readl(bank->eint_base + EXYNOSAUTO_SVC_OFFSET);

This belongs to the second patch. The point of this patch is only to
customize the offsets. There should be nothing autov920 here.


> +	else
> +		svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
>  	group = EXYNOS_SVC_GROUP(svc);
>  	pin = svc & EXYNOS_SVC_NUM_MASK;
>  
> @@ -297,8 +324,12 @@ __init int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
>  		if (bank->eint_type != EINT_TYPE_GPIO)
>  			continue;
>  
> -		bank->irq_chip = devm_kmemdup(dev, &exynos_gpio_irq_chip,
> -					   sizeof(*bank->irq_chip), GFP_KERNEL);
> +		if (bank->eint_con_offset)
> +			bank->irq_chip = devm_kmemdup(dev, &exynosauto_gpio_irq_chip,
> +						      sizeof(*bank->irq_chip), GFP_KERNEL);
> +		else
> +			bank->irq_chip = devm_kmemdup(dev, &exynos_gpio_irq_chip,
> +						      sizeof(*bank->irq_chip), GFP_KERNEL);
>  		if (!bank->irq_chip) {
>  			ret = -ENOMEM;
>  			goto err_domains;
> @@ -655,6 +686,19 @@ static void exynos_pinctrl_suspend_bank(
>  	pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask);
>  }
>  
> +static void exynosauto_pinctrl_suspend_bank(struct samsung_pinctrl_drv_data *drvdata,
> +					    struct samsung_pin_bank *bank)
> +{
> +	struct exynos_eint_gpio_save *save = bank->soc_priv;
> +	void __iomem *regs = bank->eint_base;
> +
> +	save->eint_con = readl(regs + bank->pctl_offset + bank->eint_con_offset);
> +	save->eint_mask = readl(regs + bank->pctl_offset + bank->eint_mask_offset);
> +
> +	pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con);
> +	pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask);
> +}
> +
>  void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
>  {
>  	struct samsung_pin_bank *bank = drvdata->pin_banks;
> @@ -662,8 +706,12 @@ void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
>  	int i;
>  
>  	for (i = 0; i < drvdata->nr_banks; ++i, ++bank) {
> -		if (bank->eint_type == EINT_TYPE_GPIO)
> -			exynos_pinctrl_suspend_bank(drvdata, bank);
> +		if (bank->eint_type == EINT_TYPE_GPIO) {
> +			if (bank->eint_con_offset)
> +				exynosauto_pinctrl_suspend_bank(drvdata, bank);
> +			else
> +				exynos_pinctrl_suspend_bank(drvdata, bank);
> +		}
>  		else if (bank->eint_type == EINT_TYPE_WKUP) {
>  			if (!irq_chip) {
>  				irq_chip = bank->irq_chip;
> @@ -704,14 +752,33 @@ static void exynos_pinctrl_resume_bank(
>  						+ bank->eint_offset);
>  }
>  
> +static void exynosauto_pinctrl_resume_bank(struct samsung_pinctrl_drv_data *drvdata,
> +					   struct samsung_pin_bank *bank)
> +{
> +	struct exynos_eint_gpio_save *save = bank->soc_priv;
> +	void __iomem *regs = bank->eint_base;
> +
> +	pr_debug("%s:     con %#010x => %#010x\n", bank->name,
> +		 readl(regs + bank->pctl_offset + bank->eint_con_offset), save->eint_con);
> +	pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
> +		 readl(regs + bank->pctl_offset + bank->eint_mask_offset), save->eint_mask);
> +
> +	writel(save->eint_con, regs + bank->pctl_offset + bank->eint_con_offset);
> +	writel(save->eint_mask, regs + bank->pctl_offset + bank->eint_mask_offset);
> +}
> +
>  void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  {
>  	struct samsung_pin_bank *bank = drvdata->pin_banks;
>  	int i;
>  
>  	for (i = 0; i < drvdata->nr_banks; ++i, ++bank)
> -		if (bank->eint_type == EINT_TYPE_GPIO)
> -			exynos_pinctrl_resume_bank(drvdata, bank);
> +		if (bank->eint_type == EINT_TYPE_GPIO) {
> +			if (bank->eint_con_offset)
> +				exynosauto_pinctrl_resume_bank(drvdata, bank);
> +			else
> +				exynos_pinctrl_resume_bank(drvdata, bank);
> +		}
>  }
>  
>  static void exynos_retention_enable(struct samsung_pinctrl_drv_data *drvdata)
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
> index 3ac52c2cf998..5049c170e958 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos.h
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
> @@ -31,6 +31,7 @@
>  #define EXYNOS7_WKUP_EMASK_OFFSET	0x900
>  #define EXYNOS7_WKUP_EPEND_OFFSET	0xA00
>  #define EXYNOS_SVC_OFFSET		0xB08
> +#define EXYNOSAUTO_SVC_OFFSET		0xF008

As well not related to this patch.

Best regards,
Krzysztof

