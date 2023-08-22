Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1A6783B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjHVISZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjHVISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:18:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6E4CC1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:18:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so8672617a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692692290; x=1693297090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z1MQ9JDRqAXFUR5POQlWiEXtOzxxDfLtExomDvSRs4g=;
        b=ZShpc+OjL6atbhiSlZgFZjO6BHhlIcXf4egHk65Yw/TLtOdRYbtnA51muuFMA6Iml/
         YLGljqfCkpbwQOa1n7wlxHYcc5hkMBmoxjcnmpdgxmw5nvPmlHx2wV361yulvh/Bo1Ky
         uLPGJ3kaadU8HdR7i8ZLiQH9TevJeSnMdAyaTmhORYZT4aY7EFfwOyAti3ovBsY3z3xf
         pVlFY9+eVYSSIbZ4nzhPAxaUTARbWRVVtrDeBZ9J2J4Cl+mMIwVIsDn39AgONR35Vbug
         rwbQwjm9AgkPWe/aCf6J5ejQo1/e1nMQBXXOiBpnDwTIKoSI86iKDyGgdKcyKwSpLWY/
         vAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692692290; x=1693297090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1MQ9JDRqAXFUR5POQlWiEXtOzxxDfLtExomDvSRs4g=;
        b=Cm1I4z1COOkcYvdzQPq5vM9cR6ASXtkTlo5iGiGcvQn50gKyxAr27Fh+Fd3czjirc7
         cpX+iFgZkyy9WEUeHtEl0JPtsVmgzSeFyrpeumVRiKAuvf72s6oqFe/tiyWB25i55tvC
         hzRZjoJzuLMGCBUFMiIpNM87FxTCt3O120E1AIx9ievj7kGo0to+edInU7KauDyK2AIR
         Syap6XiKhGkMB4pzmEBowLptUsrRNhZEj+CjTjKoDkIXi1EejDOLxNZSDGc7jXB6lNBo
         Z6LLqpDAsggcqORSRkUKY1XvYUA/ckNl+1AWgpIxZ+PNIT65SKQUyfVkNkwRxZPtkyPn
         c2vw==
X-Gm-Message-State: AOJu0YyGIgojJYTXXulhKeioB2PHNOGFVTrSIuzegqdoeT9obmAfSDW6
        xPRHttOLywbw4yt1jv59ICj6UQ==
X-Google-Smtp-Source: AGHT+IF/wxJ/4XOkLbbb7O+KZzjeajYoXprZMACUlegqY6DyztH0lDuyaAXJXaZc7jKn7ONnfTW48w==
X-Received: by 2002:a05:6402:1d4c:b0:51f:ef58:da87 with SMTP id dz12-20020a0564021d4c00b0051fef58da87mr12008495edb.2.1692692290509;
        Tue, 22 Aug 2023 01:18:10 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7d154000000b0052a1a623267sm731594edo.62.2023.08.22.01.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 01:18:10 -0700 (PDT)
Message-ID: <452f8d9c-e4ee-ad30-3637-7a44702b8d80@linaro.org>
Date:   Tue, 22 Aug 2023 10:18:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] mfd: sprd-sc27xx-spi: Add PMICs support for UMS9621
 SoC
Content-Language: en-US
To:     Jiansheng Wu <jiansheng.wu@unisoc.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yongzhi.chen@unisoc.com, xiaoqing.wu@unisoc.com,
        jinfeng.lin1@unisoc.com, jianshengwu16@gmail.com
References: <20230822075113.25506-1-jiansheng.wu@unisoc.com>
 <20230822075113.25506-3-jiansheng.wu@unisoc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230822075113.25506-3-jiansheng.wu@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 09:51, Jiansheng Wu wrote:
> There are three PMICs (UMP9620/21/22) on Unisoc's UMS9621 chip.
> UMP9620 is a master PMIC, the others are slave ones. Slave PMICs
> don't have irq functions, which is different from master device,
> such as SC27xx series and UMP9620, etc.
> 
> Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 104 +++++++++++++++++++++++++---------
>  1 file changed, 77 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index d21f32cc784d..aa91301568a9 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -24,6 +24,10 @@
>  #define SPRD_SC2731_IRQ_BASE		0x140
>  #define SPRD_SC2731_IRQ_NUMS		16
>  #define SPRD_SC2731_CHG_DET		0xedc
> +#define SPRD_UMP9620_IRQ_BASE           0x80
> +#define SPRD_UMP9620_IRQ_NUMS           11
> +#define SPRD_UMP9621_SLAVE_ID           0x8000
> +#define SPRD_UMP9622_SLAVE_ID           0xc000
>  
>  /* PMIC charger detection definition */
>  #define SPRD_PMIC_CHG_DET_DELAY_US	200000
> @@ -45,6 +49,7 @@ struct sprd_pmic {
>  };
>  
>  struct sprd_pmic_data {
> +	u32 slave_id;

See coding style about such wording. You know, it is not 2010 anymore...

>  	u32 irq_base;
>  	u32 num_irqs;
>  	u32 charger_det;
> @@ -67,6 +72,19 @@ static const struct sprd_pmic_data sc2731_data = {
>  	.charger_det = SPRD_SC2731_CHG_DET,
>  };
>  
> +static const struct sprd_pmic_data ump9620_data = {
> +	.irq_base = SPRD_UMP9620_IRQ_BASE,
> +	.num_irqs = SPRD_UMP9620_IRQ_NUMS,
> +};
> +
> +static const struct sprd_pmic_data ump9621_data = {
> +	.slave_id = SPRD_UMP9621_SLAVE_ID,
> +};
> +
> +static const struct sprd_pmic_data ump9622_data = {
> +	.slave_id = SPRD_UMP9622_SLAVE_ID,
> +};
> +
>  enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
>  {
>  	struct spi_device *spi = to_spi_device(dev);
> @@ -108,8 +126,27 @@ static int sprd_pmic_spi_write(void *context, const void *data, size_t count)
>  {
>  	struct device *dev = context;
>  	struct spi_device *spi = to_spi_device(dev);
> +	const struct sprd_pmic_data *pdata;
> +	int ret;
> +	u32 *pmdata;
> +
> +	if (!pdata->slave_id) {
> +		ret = spi_write(spi, data, count);
> +	} else {
> +		pdata = ((struct sprd_pmic *)spi_get_drvdata(spi))->pdata;
> +
> +		pmdata = kzalloc(count, GFP_KERNEL);
> +		if (!pmdata)
> +			return -ENOMEM;
> +		memcpy(pmdata, data, count);
> +		*pmdata += pdata->slave_id;
> +		ret = spi_write(spi, (const void *)pmdata, count);
> +		kfree(pmdata);
> +	}
> +	if (ret)
> +		pr_err("pmic mfd write failed!\n");
>  
> -	return spi_write(spi, data, count);
> +	return ret;
>  }
>  
>  static int sprd_pmic_spi_read(void *context,
> @@ -118,6 +155,7 @@ static int sprd_pmic_spi_read(void *context,
>  {
>  	struct device *dev = context;
>  	struct spi_device *spi = to_spi_device(dev);
> +	const struct sprd_pmic_data *pdata;
>  	u32 rx_buf[2] = { 0 };
>  	int ret;
>  
> @@ -125,11 +163,16 @@ static int sprd_pmic_spi_read(void *context,
>  	if (reg_size != sizeof(u32) || val_size != sizeof(u32))
>  		return -EINVAL;
>  
> +	pdata = ((struct sprd_pmic *)spi_get_drvdata(spi))->pdata;
>  	/* Copy address to read from into first element of SPI buffer. */
>  	memcpy(rx_buf, reg, sizeof(u32));
> +	if (!pdata->slave_id)
> +		rx_buf[0] += pdata->slave_id;
>  	ret = spi_read(spi, rx_buf, 1);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pr_err("pmic mfd read failed!\n");

Eh... drivers do not use pr_ but dev_. Which you can easily see within
this driver, so before posting changes please look at the driver and its
style, then learn from it and use similar coding convention.

>  		return ret;
> +	}
>  
>  	memcpy(val, rx_buf, val_size);
>  	return 0;

...


>  
>  	ret = devm_of_platform_populate(&spi->dev);
> @@ -240,6 +284,9 @@ static DEFINE_SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops,
>  static const struct of_device_id sprd_pmic_match[] = {
>  	{ .compatible = "sprd,sc2730", .data = &sc2730_data },
>  	{ .compatible = "sprd,sc2731", .data = &sc2731_data },
> +	{ .compatible = "sprd,ump9620", .data = &ump9620_data },
> +	{ .compatible = "sprd,ump9621", .data = &ump9621_data },
> +	{ .compatible = "sprd,ump9622", .data = &ump9622_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sprd_pmic_match);
> @@ -247,6 +294,9 @@ MODULE_DEVICE_TABLE(of, sprd_pmic_match);
>  static const struct spi_device_id sprd_pmic_spi_ids[] = {
>  	{ .name = "sc2730", .driver_data = (unsigned long)&sc2730_data },
>  	{ .name = "sc2731", .driver_data = (unsigned long)&sc2731_data },
> +	{ .name = "ump9620", .driver_data = (unsigned long)&ump9620_data },
> +	{ .name = "ump9621", .driver_data = (unsigned long)&ump9621_data },
> +	{ .name = "ump9622", .driver_data = (unsigned long)&ump9622_data },

So here you sneaked new compatibles... Sorry, adding new compatibles is
not the same as converting old ones. Entirely separate patch.

Best regards,
Krzysztof

