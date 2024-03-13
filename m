Return-Path: <linux-kernel+bounces-101345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A5C87A5CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD6E282B67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B844D39AE9;
	Wed, 13 Mar 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix+1GjMh"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3E3D6D;
	Wed, 13 Mar 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325540; cv=none; b=hibGTxHCV7PVXm+gjIPYf2TbzmQpdpicqZ+PoWwiA8t50Kwbd8gHU3u3xBMeYrgYGKLqFTD3iGhMNbyi8PjWGoas/xV6sSUTpdjjC7Se7+RVQB1R7KKM6l/V+HvkuTIcoVIJHKttgBWMxxP36AOK9xzNjrejXB28QrN0YXSeOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325540; c=relaxed/simple;
	bh=RX9vDhe5EY/7G9bDxVAovHr6xzuu1Z8pn8UVJep2r6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJm/8DUNQP63Q+NgTCqkBzo8+p9xDbOes02UGNPv+klsOuIh/mJcf91la+pW7gJn+rKjNlDZfbnrWaT4R1GNohy1Blwnp/XWz2OAY8s5whOyrp5vV9Q0CUe+0Z2G6YfjgZHoaZkJvreDYekkjSJqgmoL3Jvc7uZoGlcpwg5mivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix+1GjMh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dd9066b7c3so6716485ad.2;
        Wed, 13 Mar 2024 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710325538; x=1710930338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YyqKpMvkzn2a0rZ5w5lLpASeVzXzMbzX+YLlhHTJc5w=;
        b=ix+1GjMhbgGKGn9suepvilQrIXyvd1ODU6XcqU6U2ecJkJHy37v2cQyZRJNkTt3Xwg
         9iRaDZslJjOIGMhifXQ0oY0KPL2KA/5QmmW7zTSJNUkwwZGqXZJgc7HaIlpS2R/FAxFC
         RXwyyyxKw3SlPUmJCFdJVwqjGx66JZPwRX4oWJ+QctNGcyMbZfMcBSqbKs7BYf92ZcMj
         +vqe9tehH3Oz4kdXiLuORsv9mRRrx23+Srg2NoshHjQE/1HbBVwfRXPWuWNefGQ260qo
         8l92T6wqmHkStdF15X579OBcVgvmywTJTgzJRqDmbTgMfy5olhvJ74CJmWovjaPOYLzi
         lxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710325538; x=1710930338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyqKpMvkzn2a0rZ5w5lLpASeVzXzMbzX+YLlhHTJc5w=;
        b=QlBV+fhG8KwjjQFxqEG5hxa2jO7CYFRXdQ4R02rstL+QDq4fgcd0t/Fdw07WhFAbp5
         SCme6lYUlzAZRkMP4HXNCfBaUKqC0NCaTNxBrpxF/5cwMh0f+jNuemZIC6YgqeyS/EGR
         QFFbZu/zzF3EqPF75HKYIdeMdcHgrEe/4rCoq+44u7nfubz6HxDMNoU/Z6E9SwXVMtrr
         tB6bVuPx9zCHEnExDk94oAkFJrOjGuB6SDB5KTWzdffjAhkEggVKsbTgmp9tLxWo1/nx
         odLJe1DsiHk4YvZUZ0qeQz4198c69J2iO/EiMCsKezq6vxlpNReiuWGtLIaJgLctvvr6
         F0Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUQAktm2jIM/rRZH1W9iq0JwQJhUZCp0HktVmDzEC45E/EnIeEZM7aTh7wN7l4CdDSQGDUScQtg7dPt1S+QB9z2WnNrScjtJv7PpSzyE/HbPIv3NGAs/JHvesVHm9mIh7zrWsEa3w1fMlOmfQiDLCPfccU8hgADpzLltgcUQZ91ZV0g3eo=
X-Gm-Message-State: AOJu0YyKTkR/dz1ULfDBIiqMqZGI4eDhNHHDfvnG9OsZeImCYsOc7jm8
	E8LSN0RpDATsy0Xug+/N4dPl2A9Z5Y92vYL/jCwwkAmBTBZlRxJ9fGrup9kA
X-Google-Smtp-Source: AGHT+IHHcc6DDrTFijSpL/E3Pt1lEW0JVpOialvzsEg+4NWo1Bgccejlq3Cb1J1IfZtST3nVuip6Pg==
X-Received: by 2002:a17:902:e748:b0:1dc:fc26:ad0a with SMTP id p8-20020a170902e74800b001dcfc26ad0amr7478914plf.1.1710325538001;
        Wed, 13 Mar 2024 03:25:38 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id v7-20020a170903238700b001dd42bbb08asm8295705plh.253.2024.03.13.03.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 03:25:37 -0700 (PDT)
Message-ID: <cb19954a-5f4e-4c39-8944-5f02d3221d79@gmail.com>
Date: Wed, 13 Mar 2024 18:25:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linus.walleij@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, j.neuschaefer@gmx.net,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240313035719.768469-1-ychuang570808@gmail.com>
 <20240313035719.768469-4-ychuang570808@gmail.com>
 <5c555723-1731-40cc-b9be-a88ef617e09f@moroto.mountain>
Content-Language: en-US
From: Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <5c555723-1731-40cc-b9be-a88ef617e09f@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/13 下午 04:04, Dan Carpenter wrote:
> On Wed, Mar 13, 2024 at 03:57:19AM +0000, Jacky Huang wrote:
>> +static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinctrl *npctl)
>> +{
>> +	struct ma35_pin_ctrl *ctrl = npctl->ctrl;
>> +	struct ma35_pin_bank *bank = ctrl->pin_banks;
>> +	int ret;
>> +	int i;
>> +
>> +	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
>> +		if (!bank->valid) {
>> +			dev_warn(&pdev->dev, "bank %s is not valid\n",
>> +				 bank->np->name);
>> +			continue;
>> +		}
>> +		bank->irqtype = 0;
>> +		bank->irqinten = 0;
>> +		bank->chip.label = bank->name;
>> +		bank->chip.of_gpio_n_cells = 2;
>> +		bank->chip.parent = &pdev->dev;
>> +		bank->chip.request = ma35_gpio_core_to_request;
>> +		bank->chip.direction_input = ma35_gpio_core_direction_in;
>> +		bank->chip.direction_output = ma35_gpio_core_direction_out;
>> +		bank->chip.get = ma35_gpio_core_get;
>> +		bank->chip.set = ma35_gpio_core_set;
>> +		bank->chip.base = -1;
>> +		bank->chip.ngpio = bank->nr_pins;
>> +		bank->chip.can_sleep = false;
>> +		spin_lock_init(&bank->lock);
>> +
>> +		if (bank->irq > 0) {
>> +			struct gpio_irq_chip *girq;
>> +
>> +			girq = &bank->chip.irq;
>> +			gpio_irq_chip_set_chip(girq, &ma35_gpio_irqchip);
>> +			girq->parent_handler = ma35_irq_demux_intgroup;
>> +			girq->num_parents = 1;
>> +
>> +			girq->parents = devm_kcalloc(&pdev->dev, 1, sizeof(*girq->parents),
>> +						     GFP_KERNEL);
>> +			if (!girq->parents)
>> +				return -ENOMEM;
> ret = -ENOMEM;
> goto fail;
>
> regards,
> dan carpenter

Thanks, I will fix it.

>> +
>> +			girq->parents[0] = bank->irq;
>> +			girq->default_type = IRQ_TYPE_NONE;
>> +			girq->handler = handle_level_irq;
>> +		}
>> +
>> +		ret = gpiochip_add_data(&bank->chip, bank);
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "failed to register gpio_chip %s, error code: %d\n",
>> +				bank->chip.label, ret);
>> +			goto fail;
>> +		}
>> +	}
>> +	return 0;
>> +
>> +fail:
>> +	for (--i, --bank; i >= 0; --i, --bank) {
>> +		if (!bank->valid)
>> +			continue;
>> +		gpiochip_remove(&bank->chip);
>> +	}
>> +	return ret;
>> +}

Best Regards,
Jacky Huang


