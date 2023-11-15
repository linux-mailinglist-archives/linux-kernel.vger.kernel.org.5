Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408C67EC644
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344254AbjKOOtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344226AbjKOOtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:49:11 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3CE8E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:49:07 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9d242846194so1008626866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700059745; x=1700664545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2OAEGyarM/hUZBw174UpvceChqj/S103XaaXVFnIlZM=;
        b=SZ24r3XXnFGpdHPWJrK6xbhH9Ntm64S6szjGlVYf/5szD8rS3m8d5WVRljVW1My5iB
         R4n1ZvOTTTlJOMwxjIQHSJwS6qsp/Stz8IaaHTc28B87AkE/8nIETytn5rwZOun/iumA
         c7f5m1AusvW2Yk5kx5lyqglmPE4A8S8GIfTUK+CX2Xw0F0mnClnzHdf4MPSdq1NG6L3x
         fomDwf4PpOn0ZjCH0QO5YGa2JDyHFC3/nxyLq9x1ezggt4Jto1a6dOr3ZmFQqqQbFSBD
         30cTOGJczvpoPI5sU1Xo/iwLMFAccVgH04P+syb97LfA0Nl2DzKhRBvGpqrKRwkeVbQe
         lFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700059745; x=1700664545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OAEGyarM/hUZBw174UpvceChqj/S103XaaXVFnIlZM=;
        b=A+7Ei5vrC98XovuA/7QAgPjkzuryHJab9XKDqBGoopzAh7EJjona612vITq/X/eS9s
         0K1l0nAo0JNIuNnPsgsxuLDGW7s4TI5kKCLgzCYGM3IWS+yslpFs/4yUPcYyQTLCEkO8
         Am5IC/pi3GMj4iRq5wkikVdn4c6O536ZjKe/Ak3FNW/TTAZphmawLE/YdWOlSeev6cWZ
         gjo8t5lvHAVs2qBSGggBbzWr0iA/2aE7+oBgTtNrve1V6Fhm1eRUCcNWTIWYAZleMJgH
         VxC7NjZBeLqMMRPra997RHwovliAplW+sTHA+sGRZg72mbhdGBWc3cMeMFDz0YYvaNKi
         n1Xw==
X-Gm-Message-State: AOJu0YyeOdOO23TFwYzdeGlx9Zgz/etREn5XIsJN1IrL45IKlY7vD4I2
        cCMe+qqxIZEvZFG1Y4NH1+GMiw==
X-Google-Smtp-Source: AGHT+IE2f2PU9DaDjONXySx6FQe9BN0WZ4klk13CTjt7DjmnzLIwOG+L132BHH7WWbo2SRDHntXiYQ==
X-Received: by 2002:a17:906:d217:b0:9be:3c7e:7f38 with SMTP id w23-20020a170906d21700b009be3c7e7f38mr9188689ejz.10.1700059745432;
        Wed, 15 Nov 2023 06:49:05 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.119])
        by smtp.gmail.com with ESMTPSA id c26-20020a17090603da00b009adce1c97ccsm7118328eja.53.2023.11.15.06.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 06:49:05 -0800 (PST)
Message-ID: <58b2905a-afa1-4991-9d67-8952eaf4b9ea@tuxon.dev>
Date:   Wed, 15 Nov 2023 16:49:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] irqchip/renesas-rzg2l: Add support for suspend to
 RAM
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231115142749.853106-1-claudiu.beznea.uj@bp.renesas.com>
 <20231115142749.853106-9-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB11269C1937A0086A53D51D90486B1A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TYCPR01MB11269C1937A0086A53D51D90486B1A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Biju,

On 15.11.2023 16:45, Biju Das wrote:
> Hi Claudiu,
> 
> Thanks for the patch.
> 
>> Subject: [PATCH v2 8/9] irqchip/renesas-rzg2l: Add support for suspend to
>> RAM
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> irqchip-renesas-rzg2l driver is used on RZ/G3S SoC. RZ/G3S could go to
>> deep sleep states where power to different SoC's parts are cut off and RAM
>> is switched to self-refresh. The resume from these states is done with the
>> help of bootloader.
>>
>> IA55 IRQ controller needs to be reconfigured when resuming from deep sleep
>> state. For this the IA55 registers are cached in suspend and restored in
>> resume.
>>
>> The IA55 IRQ controller is connected to GPIO controller and GIC as
>> follows:
>>
>>                                       ┌──────────┐          ┌──────────┐
>>                                       │          │ SPIX     │          │
>>                                       │          ├─────────►│          │
>>                                       │          │          │          │
>>                                       │          │          │          │
>>               ┌────────┐IRQ0-7        │  IA55    │          │  GIC     │
>>  Pin0 ───────►│        ├─────────────►│          │          │          │
>>               │        │              │          │ PPIY     │          │
>>  ...          │  GPIO  │              │          ├─────────►│          │
>>               │        │GPIOINT0-127  │          │          │          │
>>  PinN ───────►│        ├─────────────►│          │          │          │
>>               └────────┘              └──────────┘          └──────────┘
>>
>> where:
>> - Pin0 is the first GPIO controller pin
>> - PinN is the last GPIO controller pin
>> - SPIX is the SPI interrupt with identifier X
>> - PPIY is the PPI interrupt with identifier Y
>>
>> Suspend/resume functionality was implemented with syscore_ops to be able
>> to cache/restore the registers after/before GPIO controller suspend/resume
>> was called. As suspend/resume function members of syscore_ops doesn't take
>> any argument, to be able to access the cache data structure and
>> controller's base address from within suspend/resume functions, the driver
>> private data structure was declared as static in file, named
>> rzg2l_irqc_data and driver has been adjusted accordingly for this.
>>
>> Because IA55 IRQC is resumed before GPIO controller and different GPIO
>> pins could be in unwanted state for IA55 IRQC (e.g. HiZ) when IA55
>> reconfiguration is done on resume path, to avoid spurious interrupts the
>> IA55 resume configures only interrupt type on resume. The interrupt enable
>> operation will be done at the end of GPIO controller resume.
>> The interrupt type reconfiguration was kept in IA55 driver to minimize the
>> number of subsystems interactions on suspend/resume b/w GPIO and
>> IA55 drivers (as the IRQ reconfiguration from GPIO driver is done with IRQ
>> specific APIs).
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v2:
>> - improved commit description
>> - use uppercase letter after ":" in patch title
>> - implemented review comments: used tabs to align initialized structures
>>   members, use proper naming for driver's private data structure
>> - use local variable for controller's base address in suspend/resume
>>   functions
>>
>>  drivers/irqchip/irq-renesas-rzg2l.c | 68 +++++++++++++++++++++++------
>>  1 file changed, 55 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-
>> renesas-rzg2l.c
>> index 45b696db220f..bd0dd9fcd68a 100644
>> --- a/drivers/irqchip/irq-renesas-rzg2l.c
>> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/reset.h>
>>  #include <linux/spinlock.h>
>> +#include <linux/syscore_ops.h>
>>
>>  #define IRQC_IRQ_START			1
>>  #define IRQC_IRQ_COUNT			8
>> @@ -55,17 +56,29 @@
>>  #define TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
>>  #define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
>>
>> +/**
>> + * struct rzg2l_irqc_reg_cache - registers cache (necessary for
>> +suspend/resume)
>> + * @iitsr: IITSR register
>> + * @titsr: TITSR registers
>> + */
>> +struct rzg2l_irqc_reg_cache {
>> +	u32	iitsr;
>> +	u32	titsr[2];
>> +};
>> +
>>  /**
>>   * struct rzg2l_irqc_priv - IRQ controller private data structure
>>   * @base: controller's base address
>>   * @fwspec: IRQ firmware specific data
>>   * @lock: lock to protect concurrent access to hardware registers
>> + * @cache: registers cache (necessary for suspend/resume)
>>   */
>> -struct rzg2l_irqc_priv {
>> +static struct rzg2l_irqc_priv {
>>  	void __iomem			*base;
>>  	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
>>  	raw_spinlock_t			lock;
>> -};
>> +	struct rzg2l_irqc_reg_cache	cache;
>> +} rzg2l_irqc_data;
> 
> Why can't you use a static pointer here and fill it in probe()
> and use this pointer in suspend()/resume()?

I can do that. I think I wrongly understood previous review comment on
this. I'll update and resend.

Thank you,
Claudiu Beznea


> 
> Cheers,
> Biju
> 
>>
>>  static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
>> { @@ -246,6 +259,38 @@ static int rzg2l_irqc_set_type(struct irq_data *d,
>> unsigned int type)
>>  	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);  }
>>
>> +static int rzg2l_irqc_irq_suspend(void) {
>> +	struct rzg2l_irqc_reg_cache *cache = &rzg2l_irqc_data.cache;
>> +	void __iomem *base = rzg2l_irqc_data.base;
>> +
>> +	cache->iitsr = readl_relaxed(base + IITSR);
>> +	for (u8 i = 0; i < 2; i++)
>> +		cache->titsr[i] = readl_relaxed(base + TITSR(i));
>> +
>> +	return 0;
>> +}
>> +
>> +static void rzg2l_irqc_irq_resume(void) {
>> +	struct rzg2l_irqc_reg_cache *cache = &rzg2l_irqc_data.cache;
>> +	void __iomem *base = rzg2l_irqc_data.base;
>> +
>> +	/*
>> +	 * Restore only interrupt type. TSSRx will be restored at the
>> +	 * request of pin controller to avoid spurious interrupts due
>> +	 * to invalid PIN states.
>> +	 */
>> +	for (u8 i = 0; i < 2; i++)
>> +		writel_relaxed(cache->titsr[i], base + TITSR(i));
>> +	writel_relaxed(cache->iitsr, base + IITSR); }
>> +
>> +static struct syscore_ops rzg2l_irqc_syscore_ops = {
>> +	.suspend	= rzg2l_irqc_irq_suspend,
>> +	.resume		= rzg2l_irqc_irq_resume,
>> +};
>> +
>>  static const struct irq_chip irqc_chip = {
>>  	.name			= "rzg2l-irqc",
>>  	.irq_eoi		= rzg2l_irqc_eoi,
>> @@ -331,7 +376,6 @@ static int rzg2l_irqc_init(struct device_node *node,
>> struct device_node *parent)
>>  	struct irq_domain *irq_domain, *parent_domain;
>>  	struct platform_device *pdev;
>>  	struct reset_control *resetn;
>> -	struct rzg2l_irqc_priv *priv;
>>  	int ret;
>>
>>  	pdev = of_find_device_by_node(node);
>> @@ -344,15 +388,11 @@ static int rzg2l_irqc_init(struct device_node *node,
>> struct device_node *parent)
>>  		return -ENODEV;
>>  	}
>>
>> -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> -	if (!priv)
>> -		return -ENOMEM;
>> +	rzg2l_irqc_data.base = devm_of_iomap(&pdev->dev, pdev->dev.of_node,
>> 0, NULL);
>> +	if (IS_ERR(rzg2l_irqc_data.base))
>> +		return PTR_ERR(rzg2l_irqc_data.base);
>>
>> -	priv->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
>> -	if (IS_ERR(priv->base))
>> -		return PTR_ERR(priv->base);
>> -
>> -	ret = rzg2l_irqc_parse_interrupts(priv, node);
>> +	ret = rzg2l_irqc_parse_interrupts(&rzg2l_irqc_data, node);
>>  	if (ret) {
>>  		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
>>  		return ret;
>> @@ -375,17 +415,19 @@ static int rzg2l_irqc_init(struct device_node *node,
>> struct device_node *parent)
>>  		goto pm_disable;
>>  	}
>>
>> -	raw_spin_lock_init(&priv->lock);
>> +	raw_spin_lock_init(&rzg2l_irqc_data.lock);
>>
>>  	irq_domain = irq_domain_add_hierarchy(parent_domain, 0,
>> IRQC_NUM_IRQ,
>>  					      node, &rzg2l_irqc_domain_ops,
>> -					      priv);
>> +					      &rzg2l_irqc_data);
>>  	if (!irq_domain) {
>>  		dev_err(&pdev->dev, "failed to add irq domain\n");
>>  		ret = -ENOMEM;
>>  		goto pm_put;
>>  	}
>>
>> +	register_syscore_ops(&rzg2l_irqc_syscore_ops);
>> +
>>  	return 0;
>>
>>  pm_put:
>> --
>> 2.39.2
> 
