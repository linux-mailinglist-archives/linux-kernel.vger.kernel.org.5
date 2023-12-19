Return-Path: <linux-kernel+bounces-4813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE28E81825A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C556286899
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F35125CE;
	Tue, 19 Dec 2023 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mpcQgBu/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59427125B2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so3705073a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702971392; x=1703576192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S612VJc/VzazF980cJxPL5Db4rx/FlsOcAzDCo+GAw0=;
        b=mpcQgBu/1JKZX7r+4nMt4QVUz3RrmQ6aRbrfnvlJ0qqkNd46v/fKDoEiN1a8xJ0jRW
         yPGo7rLzmFe9tmhe0h+CzFJ8SNJsdyKg+7lTx96xcubdRPZCC6RahDBhWEP7/anBJg0u
         Eu7S2xAl9ZRUkXeGzSqKkVHCTKgsTaYLqUoPFwqosAQEz0767i+f4yWqH5ZIajMXZcW/
         xVN9x6U4Jwe4gNt7Xsp0uILBRNhrHblVyIw5oGlJQx8YsvWGYAXvWUUXnxImQh2Ubl8j
         5NPElDoxfzIGiLDy8pcIE5+VW3CTroJ855HBocTgL8ESOHhyVN6dVCCE2XKHEidtt+rn
         MoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702971392; x=1703576192;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S612VJc/VzazF980cJxPL5Db4rx/FlsOcAzDCo+GAw0=;
        b=Ly/vOF50DD589m7HHYKZJDeHFDfA0xjXQfZMiu1PCTm8JuBYzri/v79A6/HSZ6vzg1
         z6isxnPxzj9wyaih1XicGMUwHgRLteUMVe1xs+AMO0OSI2Ti06cGC93gQPZmtS5MAyXS
         t1D0LHTjJmToyVmZlu5I2K7CLtGLK9cdZnifz8KVLbdWUYHC05/YKh3UINUmjjlmcqBx
         E+fpcks5MJifObDTPUjb+yk/6MrYsLykGqv/dtZqbuohjXR55lDv3wM95Wb5GdHsldYP
         +O1kDEhWVAg3iere1tYEDtubVlYZIbk56EkNdjnfwoW1UpCUUqzltGeGA/1AS4bG2yHu
         Aj+g==
X-Gm-Message-State: AOJu0YxZ0IQH4t6LTn1ZVp+w+YAiQonZ9dpHrq1RQW6oZmHjotddC7WE
	8rVrWrhMRj82VodjJR1KmjKG4A==
X-Google-Smtp-Source: AGHT+IFgC+gWbRfmqiQJJ2XKM9gEv5CAWcaztdlle8dpRyWXhL+j8I4igDgwrQ6TPg3amskkqttdoQ==
X-Received: by 2002:a50:85cb:0:b0:54c:6d09:3e3d with SMTP id q11-20020a5085cb000000b0054c6d093e3dmr9589211edh.26.1702971392617;
        Mon, 18 Dec 2023 23:36:32 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id x9-20020aa7cd89000000b0055289f60e3bsm4644445edv.79.2023.12.18.23.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 23:36:31 -0800 (PST)
Message-ID: <6f9cb381-3ac7-4478-a763-e392180e9f36@linaro.org>
Date: Tue, 19 Dec 2023 08:36:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] pinctrl: eyeq5: add driver
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20231218-mbly-pinctrl-v1-0-2f7d366c2051@bootlin.com>
 <20231218-mbly-pinctrl-v1-2-2f7d366c2051@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231218-mbly-pinctrl-v1-2-2f7d366c2051@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/12/2023 18:19, Théo Lebrun wrote:
> Add the Mobileye EyeQ5 pinctrl (pinconf & pinmux) controller driver. See
> the header comment for more information on how it works. This driver is
> specific to this platform; it might grow to add later support of other
> platforms from Mobileye.
> 
> Existing pins and their function live statically in the driver code
> rather than in the devicetree, see compatible match data.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  MAINTAINERS                     |   1 +
>  drivers/pinctrl/Kconfig         |  15 +
>  drivers/pinctrl/Makefile        |   1 +
>  drivers/pinctrl/pinctrl-eyeq5.c | 593 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 610 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d8d9583a5a06..5272b61d51d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14558,6 +14558,7 @@ F:	Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
>  F:	arch/mips/boot/dts/mobileye/
>  F:	arch/mips/configs/generic/board-eyeq5.config
>  F:	arch/mips/generic/board-epm5.its.S
> +F:	drivers/pinctrl/pinctrl-eyeq5.c
>  F:	drivers/reset/reset-eyeq5.c
>  F:	include/dt-bindings/reset/mobileye,eyeq5-reset.h
>  F:	include/dt-bindings/soc/mobileye,eyeq5.h
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 1de4e1edede0..e05c59116215 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -195,6 +195,21 @@ config PINCTRL_EQUILIBRIUM
>  	  desired pin functions, configure GPIO attributes for LGM SoC pins.
>  	  Pin muxing and pin confi

...

> +
> +struct eq5p_match {
> +	unsigned int regs[EQ5P_REG_MAX];
> +	const struct pinctrl_pin_desc *pins;
> +	unsigned int npins;
> +	const struct eq5p_function *funcs;
> +	unsigned int nfuncs;
> +};

Do not declare types in the middle of the unit. This goes to the
begining of the file.


Best regards,
Krzysztof


