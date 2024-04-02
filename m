Return-Path: <linux-kernel+bounces-127690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1DF894F86
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947E62839DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF6A5A0E5;
	Tue,  2 Apr 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKOdjmG0"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF315915C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052413; cv=none; b=cba0HzoWkB3uPKa8mKv9DVsUMTl4YfEOb/6+pCMcHzp+kxElCaQZFnRJqd4S8F/BQyd4iQmObdn/zAT1NnJgCDQ8VBz1qtmDj9m5fRGaYz1Q+2Dp0ZyA6Jzvk9JTqx8awB4dyS69lkCGyptUZv/otbsJ0nA7YnuSAy70xPaRtso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052413; c=relaxed/simple;
	bh=Cw2Q3xDBBRAVFPRnXEzp+S1KCZjxpnypMCXgMiTtqRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0sCQQwiF/+WDXFTKx5Vtju+059Wt78tWqU1dKbabUmvCSTmTP4c0qdCvFjcn2vSAZXpb2qA0hprEXoURaUOxdrcymhVTwI2ETITg8Uv36Oel+z6hUGMuH6z+raWOBJwqJYiVClcPwwCRiYf4VNlp3UeOKsbblXPjwbe/wzVyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKOdjmG0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516a97b3139so1938451e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712052410; x=1712657210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E71HktNt2vCJ+kaJF6zj4KNKSsAq8viHRU6nqxmCOvY=;
        b=aKOdjmG0tPi/68df5jLwHXaCeZ/Fm7pFgFMgqI3EfG4LUfoVBJwV9UdhpNmHyUho9b
         aS/kwC85ikolF5L07SB8+LVGwiG+x42K31ieo/cMwPu8Jrma1lJ+nDYQMTYA7WxRFWRo
         ns3xupZzWTnPOYcooVsi4aDi+vb3Dwgq0ImJPlG6PJWKZczgyOMKg8DXaKDhUzqBoHAG
         mOaonTFtRUxdEmZQ8OxEVZwDyCVdfeEmK9C11JGteZreOxYrd3hQr3mniIY1ZNdPDKyR
         sPpP4Y5E8aSZUeJxdibzVxNS9qD87/DpYcUjEUFMT1FRV/+jun4lRBv90gHY7onYJuYE
         uGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712052410; x=1712657210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E71HktNt2vCJ+kaJF6zj4KNKSsAq8viHRU6nqxmCOvY=;
        b=ipZPAseBb5MydDn9KtMX+bzjvv406A6Fq4qZrCGW0Jjp0ik+IImhA4KJQMcGf+RYow
         1Q4wuq1ITgyOassEnNh6IWvjm+k0C1KOeACKXc7O8wnPMGhjRPxQyBaqRPXSRxnGAK/I
         ogw5h3uLXNpHetm29lDOvYrJNrm4lkDdJA4AtFkQJOOwqMPG+9DsvJUg0mKY6tkO7ZzI
         C+VxvTPkzASJohB4p+XkFbjpTSSNBOMICH37FU0xImDgmBI4qbNB7hBHq2wcMxTUO30c
         HY/XMIVYRuNQxLS/kWpcx208PD9zIyAWDkQzjhGLFyOJSFB34BAAlNmcy2EDDLpm5Gv0
         Pcjw==
X-Gm-Message-State: AOJu0YxzFbzB/VVvPkNBES8HbS/+rF3eKS7X4R4Q2xjCBi2vAkAgaOho
	0vj+XXA3q4sQVbk29j4zEFzCIq58tnfyLih6m3N2VC5FIvL9A5uQe5gco1aCz0E=
X-Google-Smtp-Source: AGHT+IHLSxAEB2SvV6kZYK4cczrb+dS+Jp7tjyU4B2As9XYNP5YzX/G7r2iO34wGH6orIwv4AvcvUg==
X-Received: by 2002:ac2:4559:0:b0:516:9ec1:b197 with SMTP id j25-20020ac24559000000b005169ec1b197mr5087862lfm.36.1712052410239;
        Tue, 02 Apr 2024 03:06:50 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id o10-20020a170906774a00b00a4e472a8e54sm4180381ejn.48.2024.04.02.03.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:06:49 -0700 (PDT)
Date: Tue, 2 Apr 2024 13:06:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, lee@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jpanis@baylibre.com,
	devicetree@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org, eblanc@baylibre.com
Subject: Re: [PATCH v5 09/11] regulator: tps6594-regulator: Add TI TPS65224
 PMIC regulators
Message-ID: <29d6a737-0bfc-4440-ac57-54c94c6d7ad4@moroto.mountain>
References: <20240328124016.161959-1-bhargav.r@ltts.com>
 <20240328124016.161959-10-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328124016.161959-10-bhargav.r@ltts.com>

On Thu, Mar 28, 2024 at 06:10:14PM +0530, Bhargav Raviprakash wrote:
>  static irqreturn_t tps6594_regulator_irq_handler(int irq, void *data)
>  {
>  	struct tps6594_regulator_irq_data *irq_data = data;
> @@ -369,17 +513,23 @@ static irqreturn_t tps6594_regulator_irq_handler(int irq, void *data)
>  static int tps6594_request_reg_irqs(struct platform_device *pdev,
              ^^^^^^^
This function is not beautiful.  I think since you're changing it from
being tps6594 specific, maybe you want to rename a bunch of stuff.

>  				    struct regulator_dev *rdev,
>  				    struct tps6594_regulator_irq_data *irq_data,
> -				    struct tps6594_regulator_irq_type *tps6594_regs_irq_types,
> +				    struct tps6594_regulator_irq_type *regs_irq_types,
>  				    int *irq_idx)
>  {
>  	struct tps6594_regulator_irq_type *irq_type;
>  	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
> -	int j;
> +	size_t j;
>  	int irq;
>  	int error;
> +	size_t interrupt_cnt;
> +
> +	if (tps->chip_id == TPS6594)
> +		interrupt_cnt = ARRAY_SIZE(tps6594_buck1_irq_types);
> +	else
> +		interrupt_cnt = ARRAY_SIZE(tps65224_buck1_irq_types);

Either 1) pass both the array and the size or 2) just use tps->chip_id
to determine both the array and the arrays_size.  Passing the array and
then determining which array was passed by looking at the type is ugly.

regards,
dan carpenter


>  
> -	for (j = 0; j < REGS_INT_NB; j++) {
> -		irq_type = &tps6594_regs_irq_types[j];
> +	for (j = 0; j < interrupt_cnt; j++) {
> +		irq_type = &regs_irq_types[j];
>  		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
>  		if (irq < 0)
>  			return -EINVAL;


