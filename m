Return-Path: <linux-kernel+bounces-159015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAE98B282B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F6284831
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FA11509AE;
	Thu, 25 Apr 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwZf5LiC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2050914EC66;
	Thu, 25 Apr 2024 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714069765; cv=none; b=Iz30kBqkpdep9Ar8UCUU00zNUKelLzTjfrIYvRYcNHMszB/nMmqgyAciejJK/7bBhIgjLT+z4EF0alRr6bIXtOKDrjsgvSObz4nVRmZpjNsznijMKKLVcDgQr94gZ1QkmzYCNAVWV1MXBK0c5ZjjuC+Ijw2DQjmkmOu3pyOQRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714069765; c=relaxed/simple;
	bh=huLm0nrM9QJkaRSU+mfJBR/sAYQYDXxsrsFULLV94Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfcYw+BbmfaUItBEToppUN+gN/HcC7LkqUkW1BIfP21OOjHr/buvpDUiBQPpCPoOWxQ5yRes/RWqZ0CPeEE1YMj/L+mr45qO7jV+zqP0k/qqxCuVTVFj1axLJ9iVfJWOEk7lT+i087Hgwe/rNeoTJr7NmLkVudYLPwX0iWLRWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwZf5LiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E3CC113CC;
	Thu, 25 Apr 2024 18:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714069764;
	bh=huLm0nrM9QJkaRSU+mfJBR/sAYQYDXxsrsFULLV94Tc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UwZf5LiCT+ILOk4aObtDysMTUdZKWNbNVH5+uMLVkdDr6CBVr6YW/rOghiI+gUX21
	 BzD6a4/ikfgdRdJiuvDACNv84svsLHqae5cRHrCMNnqxR6JTcJe4rfahmOkSjaEvgt
	 LbW5Z006xa74hnV0Xq/h3zWkuTUhwWRhN3D0AmIddAIXQS2HIOdJsnnhH0POirdxDC
	 SOewiot2HewT0csXL1HesISJc5SJTchU26AuzW6hePK+r0BXQ+wRLL8xQjjdRIh6k9
	 P+dx2PIMgrP6KKzDKZqfY5WrS8IqUeidJv4z3u/wj0BrekhPo3XIgCEi1Pd8NuIEct
	 w9TJ6ETQXmRjQ==
Message-ID: <e7d9993e-b51d-4348-aa1d-de0671062c57@kernel.org>
Date: Thu, 25 Apr 2024 20:29:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pinctrl: samsung: support a bus clock
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240425-samsung-pinctrl-busclock-v1-0-898a200abe68@linaro.org>
 <20240425-samsung-pinctrl-busclock-v1-2-898a200abe68@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240425-samsung-pinctrl-busclock-v1-2-898a200abe68@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/04/2024 18:03, André Draszik wrote:
> On some Samsung-based SoCs there are separate bus clocks / gates each
> for each pinctrl instance. To be able to access each pinctrl instance's
> registers, this bus clock needs to be running, otherwise register
> access will hang. Google Tensor gs101 is one example for such an
> implementation.
> 
> Update the driver to handle this optional bus clock:
> * handle an optional bus clock from DT
> * prepare it during driver probe
> * enclose all relevant register accesses with a clock enable & disable
> 

..

>  	drvdata = pinctrl_dev_get_drvdata(pctldev);
>  	pin_to_reg_bank(drvdata, pin, &reg_base, &pin_offset, &bank);
> @@ -447,6 +456,12 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
>  	width = type->fld_width[cfg_type];
>  	cfg_reg = type->reg_offset[cfg_type];
>  
> +	ret = clk_enable(drvdata->pclk);
> +	if (ret) {
> +		dev_err(drvdata->dev, "failed to enable clock\n");
> +		return ret;
> +	}
> +
>  	raw_spin_lock_irqsave(&bank->slock, flags);
>  
>  	mask = (1 << width) - 1;
> @@ -466,6 +481,8 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
>  
>  	raw_spin_unlock_irqrestore(&bank->slock, flags);
>  
> +	clk_disable(drvdata->pclk);
> +
>  	return 0;
>  }
>  
> @@ -539,16 +556,24 @@ static void samsung_gpio_set_value(struct gpio_chip *gc,
>  {
>  	struct samsung_pin_bank *bank = gpiochip_get_data(gc);
>  	const struct samsung_pin_bank_type *type = bank->type;
> +	struct samsung_pinctrl_drv_data *drvdata = bank->drvdata;
>  	void __iomem *reg;
>  	u32 data;
>  
>  	reg = bank->pctl_base + bank->pctl_offset;
>  
> +	if (clk_enable(drvdata->pclk)) {

This is now called with bank->slock held, so you reversed the locking
thus creating possibility of ABBA deadlock.

Need to be moved to callers of samsung_gpio_set_value().

> +		dev_err(drvdata->dev, "failed to enable clock\n");
> +		return;
> +	}
> +
>  	data = readl(reg + type->reg_offset[PINCFG_TYPE_DAT]);
>  	data &= ~(1 << offset);
>  	if (value)
>  		data |= 1 << offset;
>  	writel(data, reg + type->reg_offset[PINCFG_TYPE_DAT]);
> +
> +	clk_disable(drvdata->pclk);
>  }
>  
>  /* gpiolib gpio_set callback function */
> @@ -569,12 +594,23 @@ static int samsung_gpio_get(struct gpio_chip *gc, unsigned offset)
>  	u32 data;
>  	struct samsung_pin_bank *bank = gpiochip_get_data(gc);
>  	const struct samsung_pin_bank_type *type = bank->type;
> +	struct samsung_pinctrl_drv_data *drvdata = bank->drvdata;
> +	int ret;
>  
>  	reg = bank->pctl_base + bank->pctl_offset;
>  
> +	ret = clk_enable(drvdata->pclk);
> +	if (ret) {
> +		dev_err(drvdata->dev, "failed to enable clock\n");
> +		return ret;
> +	}
> +
>  	data = readl(reg + type->reg_offset[PINCFG_TYPE_DAT]);
>  	data >>= offset;
>  	data &= 1;
> +
> +	clk_disable(drvdata->pclk);
> +
>  	return data;
>  }
>  
> @@ -591,9 +627,12 @@ static int samsung_gpio_set_direction(struct gpio_chip *gc,
>  	struct samsung_pin_bank *bank;
>  	void __iomem *reg;
>  	u32 data, mask, shift;
> +	struct samsung_pinctrl_drv_data *drvdata;
> +	int ret;
>  
>  	bank = gpiochip_get_data(gc);
>  	type = bank->type;
> +	drvdata = bank->drvdata;
>  
>  	reg = bank->pctl_base + bank->pctl_offset
>  			+ type->reg_offset[PINCFG_TYPE_FUNC];
> @@ -606,12 +645,20 @@ static int samsung_gpio_set_direction(struct gpio_chip *gc,
>  		reg += 4;
>  	}
>  
> +	ret = clk_enable(drvdata->pclk);

Same problem.

> +	if (ret) {
> +		dev_err(drvdata->dev, "failed to enable clock\n");
> +		return ret;
> +	}
> +
>  	data = readl(reg);
>  	data &= ~(mask << shift);
>  	if (!input)
>  		data |= PIN_CON_FUNC_OUTPUT << shift;
>  	writel(data, reg);
>  
> +	clk_disable(drvdata->pclk);
> +
>  	return 0;
>  }
>  
> @@ -1164,6 +1211,12 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	drvdata->pclk = devm_clk_get_optional_prepared(dev, "pclk");
> +	if (IS_ERR(drvdata->pclk)) {
> +		ret = PTR_ERR(drvdata->pclk);
> +		goto err_put_banks;
> +	}
> +
>  	ret = samsung_pinctrl_register(pdev, drvdata);
>  	if (ret)
>  		goto err_put_banks;
> @@ -1202,6 +1255,13 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
>  	struct samsung_pinctrl_drv_data *drvdata = dev_get_drvdata(dev);
>  	int i;
>  
> +	i = clk_enable(drvdata->pclk);
> +	if (i) {
> +		dev_err(drvdata->dev,
> +			"failed to enable clock for saving state\n");
> +		return i;
> +	}
> +
>  	for (i = 0; i < drvdata->nr_banks; i++) {
>  		struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
>  		const void __iomem *reg = bank->pctl_base + bank->pctl_offset;
> @@ -1231,6 +1291,8 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
>  		}
>  	}
>  
> +	clk_disable(drvdata->pclk);
> +
>  	if (drvdata->suspend)
>  		drvdata->suspend(drvdata);
>  	if (drvdata->retention_ctrl && drvdata->retention_ctrl->enable)
> @@ -1252,6 +1314,16 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
>  	struct samsung_pinctrl_drv_data *drvdata = dev_get_drvdata(dev);
>  	int i;
>  
> +	/* enable clock before the callback, as we don't want to have to deal

That's not netdev, so:

/*
 *

> +	 * with callback cleanup on clock failures.
> +	 */
> +	i = clk_enable(drvdata->pclk);

"i" is iterator, not return value. You want ret.

	

> +	if (i) {
> +		dev_err(drvdata->dev,
> +			"failed to enable clock for restoring state\n");
> +		return i;
> +	}
> +
>  	if (drvdata->resume)
>  		drvdata->resume(drvdata);
>  
> @@ -1286,6 +1358,8 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
>  				writel(bank->pm_save[type], reg + offs[type]);
>  	}
>  
> +	clk_disable(drvdata->pclk);
> +
>  	if (drvdata->retention_ctrl && drvdata->retention_ctrl->disable)
>  		drvdata->retention_ctrl->disable(drvdata);
>  


Best regards,
Krzysztof


