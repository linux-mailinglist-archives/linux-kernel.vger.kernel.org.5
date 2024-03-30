Return-Path: <linux-kernel+bounces-125703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0D7892ADA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD9EB217B4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E877E2E41A;
	Sat, 30 Mar 2024 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCKU7T9U"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1FE2C683
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711798439; cv=none; b=smmrmyKKY/Loze4eT4Y2bEBv6cLMIInDL/bzfGONPXRMz/tiumQ8AF4Ynrr/eiaZxkvz3tZIQ7YSz6eBDGc4mJxQilleKFQxgocfOp4RjXpDBCLvghG02PhxFpUEqKZWZwC8tQWd90P+LdhR7iGGJ1kPkfl0FqMqgORvIIlt3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711798439; c=relaxed/simple;
	bh=l5xIvAlUlvTR322cG9gHCXBT6iC/tG6s0rNkqv/fbrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1Ei38l6u0ddcwmdaR8aASN9QWwB24tW2FrzsGHg97U33USux+E6fqh3fZNnOkjdLHdstgt8kIZG5PvneRvhDEcwY7zmMOb0knU4pbgtn110nkSl0e63D4d6HJl982woAmJAVuIVEVtdl5oODazU/gl+JcNkiIFPoroMpwi6AD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nCKU7T9U; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so30545161fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 04:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711798435; x=1712403235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKuP23ycho2oA2KCvhT0ZMyIBbVELVhTwKe1JYrHv94=;
        b=nCKU7T9UOfdglfm1lmyi2I2dr2sgrUuCpWrkZWDyLi4TzjBJtK+XdiTss2BZp4WHW3
         TaxxdHBh6ANUqrsgg49uSN8R7odty966RgF5lE4AykLed3q67STwtqGXw8zY4OSW5EQT
         B16OkczVYdMIxpe6sPul+Bhve2BjpR4qa+4vB9YW3V8NfmBfXjNltLqdAqjiw9tUywd1
         4sD6xi1jILtdPZxYwQdRlrOrseaxrZq4fbkAob/Je90Q2ZJCbYLcL88YIk9PIxWTG2xR
         ggYGa27mWZFz09Qjs9n/3aap7IWhga/E6XRduAV0jR7WwPEzkYADhlFl61xcPNZUzsy6
         +Tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711798435; x=1712403235;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKuP23ycho2oA2KCvhT0ZMyIBbVELVhTwKe1JYrHv94=;
        b=Unp/PkDCjrattvMIvbKLQgdcN5hN8CcH7dCUP5CAZn2sEVmtrtuXCik2YYn4QteS4x
         EESwsFo03Uprmms93hXGzmUrb9zno/IyAMywrGa4Splds8xeiOq/dorn8LsYbQ6lYSUq
         S5XLNT0WusWRDo9LXi7wiAs2BvzWj1Vcixz28rWjInSi3jnLn4hgEA+bwnEll5ixq0KX
         udbW79NAdzv7LQU7m0u+TVEv6LqxLsWGDVGQT3gvF4bMy8oWYn+xi1rn4cK5EV/Zz0dJ
         k3Q6HqVeJKI2Em0azjELEhLqrmne/P9EhgoEUDhpFwgYXtWiWCcukN9SaxeX+ms5mDmv
         GDTg==
X-Forwarded-Encrypted: i=1; AJvYcCVYrzsw1bF6sE8UMyaRI4al3h516i8IzRdCtuMUMHnXWaZZy9XQ7pxC5r2q85t+MaAB2vCzXoU78MHtn1KswnEvG8K8BGbVin73fzwM
X-Gm-Message-State: AOJu0YyUHYyw4uJRCVNZnQabpzf62IMeDEkonm0X9KNXmBNdVgbKMs5+
	XpOni8NvYelk8ZyHftvXM1R38dPYEDNCCvV/9xhaXfEK3XWioixFRnBQ7Lh/se8=
X-Google-Smtp-Source: AGHT+IHFn0qQ/U7hs4+G1h1XSH2b8K/o2HHnoLDjyqL36pwa8qo5uKiLnqQ+10AAaVarFdluT+rTIw==
X-Received: by 2002:a05:651c:198e:b0:2d6:c001:d8b with SMTP id bx14-20020a05651c198e00b002d6c0010d8bmr3602180ljb.5.1711798435010;
        Sat, 30 Mar 2024 04:33:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b0041490467febsm11368698wmo.38.2024.03.30.04.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 04:33:54 -0700 (PDT)
Message-ID: <7bd584b0-46e1-4dcb-a402-80784f7d11b7@linaro.org>
Date: Sat, 30 Mar 2024 12:33:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] spi: cadence: Add Marvell IP modification changes
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, pthombar@cadence.com
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240329194849.25554-3-wsadowski@marvell.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240329194849.25554-3-wsadowski@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 20:48, Witold Sadowski wrote:
> Add support for Marvell IP modification - clock divider,
> and PHY config, and IRQ clearing.
> Clock divider block is build into Cadence XSPI controller
> and is connected directly to 800MHz clock.
> As PHY config is not set directly in IP block, driver can
> load custom PHY configuration values.
> To correctly clear interrupt in Marvell implementation
> MSI-X must be cleared too.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> 
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> ---


> +
> +static bool cdns_xspi_get_hw_overlay(struct platform_device *pdev)
> +{
> +	int err;
> +
> +	err = device_property_match_string(&pdev->dev,
> +					   "compatible", "mrvl,xspi-nor");

No, do not add matching in some random parts of the code, but use driver
match/data from ID table.

...

>  
> +	cdns_xspi_print_phy_config(cdns_xspi);
>  	ret = cdns_xspi_controller_init(cdns_xspi);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize controller\n");
> @@ -613,6 +911,9 @@ static const struct of_device_id cdns_xspi_of_match[] = {
>  	{
>  		.compatible = "cdns,xspi-nor",
>  	},
> +	{
> +		.compatible = "mrvl,xspi-nor",

This falsely suggest they are compatible :/

> +	},
>  	{ /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, cdns_xspi_of_match);

Best regards,
Krzysztof


