Return-Path: <linux-kernel+bounces-7635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7D181AB15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDDCB2104D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715414B142;
	Wed, 20 Dec 2023 23:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dfrgmw5I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2D34B5A4;
	Wed, 20 Dec 2023 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d47bb467a9so989680b3a.1;
        Wed, 20 Dec 2023 15:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703115229; x=1703720029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CN16sSVT2xqXL72OUmXgbGKwYMaDCSmR5EOjpuJUGsE=;
        b=Dfrgmw5IuOQqxhfpAwOD7TgiqLy+6Tg2iEako8pFBDeUsO7LknkW/OnHcj0w6BW2G3
         ZCzh/tWylV/F5eSmaGDX82SuErdN+2Mwji2H9anUDqG2ZXcU7f0BjBG+63LqVYZQhxEc
         CoAfgAwy3+YVJswO4Gp6IxsbXMPXxdt8WqITvVlO6mP587Po4ZKY6mtLwux4u1X0jDGU
         iyfwvE5ooq2Vyp0uAgrtlSNJ/5c3IUN/ShkyizamGgc0SWmwOIv5BbIG5oBJ0Zp1P25T
         s3HotsuzatovPQ+9ujs7B96ObCweZPvshjSU+0IFZutha+/XCQ6/2GewicPzLXLEaZkH
         aG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703115229; x=1703720029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CN16sSVT2xqXL72OUmXgbGKwYMaDCSmR5EOjpuJUGsE=;
        b=h/VgS5fDq2+KP/pTvvFXTdu+UY3hcmb6zsY3WoatCJwo/FmEL6SILNWmIjcU3/HIqo
         psFeBjcTsJqC0aozej2Wce9jSfA6rFor2XffkbFtHoqWLvXLGK4yHrWhwru8PkriL4Ne
         XCJ+fCgNRAfUudshxkDfPCKt+95gNIKyrwfpZLrxhGxbb71qfmNXSbSetl/dayZBkKRc
         xtbiYC+ytHXyv+A4mWbc2h0eNojsqPFrQR9UJ4xcyjfM4Mv+kvbfnlfz5a9Kt1uxsHGi
         x3RXl9v5FsQshtxKWUp1GJw1fPLYmbETjkxV1QxIsGRjVdtNBZpnkIAQC+9qmBjr5WEz
         hbmg==
X-Gm-Message-State: AOJu0Yw2hwWw5ML4Qvp1eC/mnLuaB/NIiufkT4TUEMqrqebj8zIjZhN3
	ZuhBcOvxcDGbrGunVZvmUjI=
X-Google-Smtp-Source: AGHT+IF4Y4XTpIswRn22zZq6QounGFEhD6PCWbxXfIA0tccD4E4J7TbiW9Dj+4WjdNwU5LcG2eOz2A==
X-Received: by 2002:a05:6a20:2a29:b0:194:9c57:2f3b with SMTP id e41-20020a056a202a2900b001949c572f3bmr525049pzh.4.1703115229267;
        Wed, 20 Dec 2023 15:33:49 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:9d7:3461:3155:35d4])
        by smtp.gmail.com with ESMTPSA id r10-20020aa7844a000000b006d5723e9a0dsm314882pfn.74.2023.12.20.15.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:33:48 -0800 (PST)
Date: Wed, 20 Dec 2023 15:33:46 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] input: add onkey driver for Marvell 88PM88X PMICs
Message-ID: <ZYN52mD6-1hj_K7S@google.com>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
 <20231217131838.7569-5-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217131838.7569-5-karelb@gimli.ms.mff.cuni.cz>

Hi Karel,

On Sun, Dec 17, 2023 at 02:17:02PM +0100, Karel Balej wrote:
> From: Karel Balej <balejk@matfyz.cz>
> 
> The Marvell 88PM88X PMICs provide onkey among other things. Add client
> driver to handle it. The driver currently only provides a basic support
> omitting additional functions found in the vendor version, such as long
> onkey and GPIO integration.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  drivers/input/misc/88pm88x-onkey.c | 103 +++++++++++++++++++++++++++++
>  drivers/input/misc/Kconfig         |  10 +++
>  drivers/input/misc/Makefile        |   1 +
>  3 files changed, 114 insertions(+)
>  create mode 100644 drivers/input/misc/88pm88x-onkey.c
> 
> diff --git a/drivers/input/misc/88pm88x-onkey.c b/drivers/input/misc/88pm88x-onkey.c
> new file mode 100644
> index 000000000000..0d6056a3cab2
> --- /dev/null
> +++ b/drivers/input/misc/88pm88x-onkey.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/kernel.h>
> +#include <linux/input.h>
> +#include <linux/regmap.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>

Please sort alphabetically.

> +
> +#include <linux/mfd/88pm88x.h>
> +
> +struct pm88x_onkey {
> +	struct input_dev *idev;
> +	struct pm88x_chip *chip;
> +	int irq;

Since you are using devm to request interrupt I do not think you need to
store it here.

> +};
> +
> +static irqreturn_t pm88x_onkey_irq_handler(int irq, void *data)
> +{
> +	struct pm88x_onkey *onkey = data;
> +	unsigned int val;
> +	int ret = 0;

"error". Also no need to initialize it to 0.

> +
> +	ret = regmap_read(onkey->chip->regmaps[PM88X_REGMAP_BASE], PM88X_REG_STATUS1, &val);

I still prefer to keep withing 80 columns, unless longer lines are a
clear win.

> +	if (ret) {
> +		dev_err(onkey->idev->dev.parent, "Failed to read status: %d\n", ret);

Maybe have "dev" in onkey instead of poking through input?

> +		return IRQ_NONE;
> +	}
> +	val &= PM88X_ONKEY_STS1;
> +
> +	input_report_key(onkey->idev, KEY_POWER, val);
> +	input_sync(onkey->idev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pm88x_onkey_probe(struct platform_device *pdev)
> +{
> +	struct pm88x_chip *chip = dev_get_drvdata(pdev->dev.parent);
> +	struct pm88x_onkey *onkey;
> +	int err;
> +
> +	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
> +	if (!onkey)
> +		return -ENOMEM;
> +
> +	onkey->chip = chip;
> +
> +	onkey->irq = platform_get_irq(pdev, 0);
> +	if (onkey->irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get IRQ\n");
> +		return -EINVAL;

Do not clobber the return from platform_get_irq(). So "return
onkey->irq" (or simply irq if you drop it from onkey and use temporary).

> +	}
> +
> +	onkey->idev = devm_input_allocate_device(&pdev->dev);
> +	if (!onkey->idev) {
> +		dev_err(&pdev->dev, "Failed to allocate input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	onkey->idev->name = "88pm88x-onkey";
> +	onkey->idev->phys = "88pm88x-onkey/input0";
> +	onkey->idev->id.bustype = BUS_I2C;
> +	onkey->idev->dev.parent = &pdev->dev;

No need to do this since you are using devm_input_allocate_device().

> +	onkey->idev->evbit[0] = BIT_MASK(EV_KEY);
> +	onkey->idev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);

Please use

	input_set_capability(onkey->idev, EV_KEY, KEY_POWER);

> +
> +	err = devm_request_threaded_irq(&pdev->dev, onkey->irq, NULL, pm88x_onkey_irq_handler,
> +			IRQF_ONESHOT | IRQF_NO_SUSPEND, "onkey", onkey);

Please align arguments.

> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to request IRQ: %d\n", err);

I was persuaded to stop my crusade against dev_err_probe() so you may
use it here.

> +		return err;
> +	}
> +
> +	err = input_register_device(onkey->idev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to register input device: %d\n", err);
> +		return err;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, 1);

Are there cases where we woudl not want wakeup? Maybe use standard
"wakeup-source" property?

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id pm88x_onkey_of_match[] = {
> +	{ .compatible = "marvell,88pm88x-onkey", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, pm88x_onkey_of_match);
> +
> +static struct platform_driver pm88x_onkey_driver = {
> +	.driver = {
> +		.name = "88pm88x-onkey",
> +		.of_match_table = of_match_ptr(pm88x_onkey_of_match),

Given that you are not guarding pm88x_onkey_of_match definition with
#ifdef CONFIG_OF you shoudl not use of_match_ptr().

Thanks.

-- 
Dmitry

