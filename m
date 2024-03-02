Return-Path: <linux-kernel+bounces-89486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3B86F0F6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C90C1C20B2C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1634A18C19;
	Sat,  2 Mar 2024 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="M5Qh4XVd"
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E518657
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709394631; cv=none; b=deReMYnJBFSssXkZrMHBf5bftVAsQxVzMsfjPAF/HFtzsbg0k+gRV+vYRhV/tpfdTu278mnjovzeaibEJi5Z07Cm8oC+73HBc6fJKUtjmdQGkUor09FB1gy4BXEFnTHpkgovPjICXExcA6aeMab236x+436DNtOuGnY1WcbS1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709394631; c=relaxed/simple;
	bh=mN2LAc9j8pitp4/pP5rakUYeQUXvQd/UY0ksJb5F/AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJkem1w21m3sLGtE46aRiwaNmCt9MHv8BCTH+WtzQgSct7TSwZxcGKGOM/fg+m7tn4PE1X4Mklv33qMSc6dTdrjqj03is79uMSb9F7M6RSxNCE8ZhQBh7/aoKTtxk9eI0gEH17G3DfBhrPAfq6fhRWG41lCFRrOIMGobiFa1NV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=M5Qh4XVd; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id gRbkrY9aBQ6QsgRd4rNOK9; Sat, 02 Mar 2024 16:50:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1709394627;
	bh=Qv/ssscVV7fGs0JMzWV8vaTZi3w3mSOL334YpDMghuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=M5Qh4XVdS6CPVQ81wW+vqU6fBYIuJCy8mfyGplrusU67MKNuulUnmada7l0zc574r
	 xvDL/a5djesp7qHh6m3Khpe0DA1+qArKAQrROkYAY+8IwnDRM9sg6HwUAvtnG4W4nz
	 3a9UftEkSeZbjVo0abo+ByJDl/+JcYoqMwNSaHAJwSb47dbcPVAW2CJTtidonOWjtW
	 wRbWYlH8dliC/a+3hXdLGmLpbbRb/RXZqa/ixorXOuZz7GWC4HoeOjRb7hNWeYGtrQ
	 QIDKmL0Ri1Dgk4eCl3o5Xvf5DyQXOY47I5XmDtheOlbAJrm4NtdS3SYV+vf2ULFNXV
	 zrXr+L+f4Ff4g==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Mar 2024 16:50:27 +0100
X-ME-IP: 92.140.202.140
Message-ID: <52158bf6-16fe-4ce2-b9b6-bbc6550a6e14@wanadoo.fr>
Date: Sat, 2 Mar 2024 16:50:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] usb: dwc3: exynos: Use
 devm_regulator_bulk_get_enable() helper function
Content-Language: en-MW
To: Anand Moon <linux.amoon@gmail.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240301193831.3346-1-linux.amoon@gmail.com>
 <20240301193831.3346-4-linux.amoon@gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240301193831.3346-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 01/03/2024 à 20:38, Anand Moon a écrit :
> Use devm_regulator_bulk_get_enable() instead of open coded
> 'devm_regulator_get(), regulator_enable(), regulator_disable().
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   drivers/usb/dwc3/dwc3-exynos.c | 49 +++-------------------------------
>   1 file changed, 4 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index 5d365ca51771..7c77f3c69825 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -32,9 +32,6 @@ struct dwc3_exynos {
>   	struct clk		*clks[DWC3_EXYNOS_MAX_CLOCKS];
>   	int			num_clks;
>   	int			suspend_clk_idx;
> -
> -	struct regulator	*vdd33;
> -	struct regulator	*vdd10;
>   };
>   
>   static int dwc3_exynos_probe(struct platform_device *pdev)
> @@ -44,6 +41,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>   	struct device_node	*node = dev->of_node;
>   	const struct dwc3_exynos_driverdata *driver_data;
>   	int			i, ret;
> +	static const char * const regulators[] = { "vdd33", "vdd10" };
>   
>   	exynos = devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
>   	if (!exynos)
> @@ -78,27 +76,9 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>   	if (exynos->suspend_clk_idx >= 0)
>   		clk_prepare_enable(exynos->clks[exynos->suspend_clk_idx]);
>   
> -	exynos->vdd33 = devm_regulator_get(dev, "vdd33");
> -	if (IS_ERR(exynos->vdd33)) {
> -		ret = PTR_ERR(exynos->vdd33);
> -		goto vdd33_err;
> -	}
> -	ret = regulator_enable(exynos->vdd33);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable VDD33 supply\n");
> -		goto vdd33_err;
> -	}
> -
> -	exynos->vdd10 = devm_regulator_get(dev, "vdd10");
> -	if (IS_ERR(exynos->vdd10)) {
> -		ret = PTR_ERR(exynos->vdd10);
> -		goto vdd10_err;
> -	}
> -	ret = regulator_enable(exynos->vdd10);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable VDD10 supply\n");
> -		goto vdd10_err;
> -	}
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators), regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
>   
>   	if (node) {
>   		ret = of_platform_populate(node, NULL, NULL, dev);
> @@ -115,10 +95,6 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>   	return 0;
>   
>   populate_err:
> -	regulator_disable(exynos->vdd10);
> -vdd10_err:
> -	regulator_disable(exynos->vdd33);
> -vdd33_err:
>   	for (i = exynos->num_clks - 1; i >= 0; i--)
>   		clk_disable_unprepare(exynos->clks[i]);
>   
> @@ -140,9 +116,6 @@ static void dwc3_exynos_remove(struct platform_device *pdev)
>   
>   	if (exynos->suspend_clk_idx >= 0)
>   		clk_disable_unprepare(exynos->clks[exynos->suspend_clk_idx]);
> -
> -	regulator_disable(exynos->vdd33);
> -	regulator_disable(exynos->vdd10);
>   }
>   
>   static const struct dwc3_exynos_driverdata exynos5250_drvdata = {
> @@ -196,9 +169,6 @@ static int dwc3_exynos_suspend(struct device *dev)
>   	for (i = exynos->num_clks - 1; i >= 0; i--)
>   		clk_disable_unprepare(exynos->clks[i]);
>   
> -	regulator_disable(exynos->vdd33);
> -	regulator_disable(exynos->vdd10);

Hi,

Same here, I don't think that removing regulator_[en|dis]able from the 
suspend and resume function is correct.

The goal is to stop some hardware when the system is suspended, in order 
to save some power.

Why did you removed it?

CJ

> -
>   	return 0;
>   }
>   
> @@ -207,17 +177,6 @@ static int dwc3_exynos_resume(struct device *dev)
>   	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
>   	int i, ret;
>   
> -	ret = regulator_enable(exynos->vdd33);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable VDD33 supply\n");
> -		return ret;
> -	}
> -	ret = regulator_enable(exynos->vdd10);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable VDD10 supply\n");
> -		return ret;
> -	}
> -
>   	for (i = 0; i < exynos->num_clks; i++) {
>   		ret = clk_prepare_enable(exynos->clks[i]);
>   		if (ret) {


