Return-Path: <linux-kernel+bounces-81248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08445867299
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E38A1F277C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAA01CFB4;
	Mon, 26 Feb 2024 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Rl+HF+12"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934741CD30
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945639; cv=none; b=MMCGRrVMmDXKEWZZ5Wqe/ArVGPYnQxPorQ0hI07QDudFNQAclOFlxLFi9aWTElFMco4QLQhmVcUQ2dbbdYp2cEEXjmgT7lmClD+tv+3wCO7ZvOP4v7PI2H6+qmMO/ah/93couScwnjmuKJeVZZuTKmbYr5i5dDaqKYzaX4hbAHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945639; c=relaxed/simple;
	bh=o469wJxegXoezlqIjGIYFTGOxZj7oatMUK25fXsLWMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETcr0nZTNBdH6+LX6nlL9aI5UYH7WrpMxWUUBRMoJ6iaLW4IEhTwvZK6U/vTiS3JQJTEpVv//c72UaCJ2FCEodVPqo9ya4eTxuawY40PZVN5AzCPChva3XH2uB1t4M2c13R3ceQwrv9I+CAvBkBOoC60iDM8F9dGsB283hqXjuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Rl+HF+12; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d153254b7so2292325f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708945636; x=1709550436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sbYFot8CFgR80jEb1giXs1QlZ5tdKUJQ13JHlGGWOQM=;
        b=Rl+HF+12qGuoSaZtjaHwjYMekpfeYazHg+qsLpnXZztZn9bpBkO/lHkDH+HV1oZ2rw
         JxIB434KNVmBagPglH0ODBMzOpZmSw09MpnVkfX0HSAUkOZvgktxGg1ZeO5JjqXcbdxQ
         vqRNZQkzVPOSVTmajZKvAsQBXYkafgdQZjv9ZITiCMMNPiiQ8LjvYPtRORh0S4mNK1bu
         EZ43Q0Pd1g270tq+ViJwYUqwAn8c/SlG9qewic3ltBIPYGnwuyIvoI/leZod/Z2kuh44
         5WBH0BNnmsfH2UgbCUk0OpucNOoRqQDHpzL4kocqqP53fdMnF10Y1DfIrzHYe9ka5vQe
         zpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708945636; x=1709550436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbYFot8CFgR80jEb1giXs1QlZ5tdKUJQ13JHlGGWOQM=;
        b=ow+qVTKqMlMHiNgAGXtTR0XGffJ/hzWn3QgSQN/DFH7awbgi21SDupLe3o3aMoIfol
         T11U9smJj0C71UwxZ67Imty/Uh2wzcz1tE78n9Qu+LZk4tBFb2urS1Wcpq6IMIsr+NTa
         xYGbvRxA6TR/vJSHq+lkOq5alegVPVQHvatMMYBo8eEkMHwhQP1pe3BI9RImw5gSr/KX
         VIvoSb/phW+9bC2jV3RXbNDELruwyLPZYwdCwq1Ymb/jVmcqDemBOZVLF7CCtPO5nCzJ
         85iibg4h9xOu70gk0mZDlwWmJ6HDzohhhbi/BoxmtL31z5OGdNVaFbToHmS16zJEg4pE
         FQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd+zDZUFojQ8SMAkhamjcp/64FcMWudy7q3YYQMYVngViqabf7KKU8KbyoarnklPFsjX/QJw/O2nwvQ3131ShB77AYfUPkqb0pkX7b
X-Gm-Message-State: AOJu0YyE6d91FYFrpQs+h3kHUciaAER8T03EEjEKtwqn2UMd7v90Q1E3
	pnj+1T8bcj7csPkz7PuyZG5twSRYm7U/kjxcuDlrQet10Z360sVJtNmex5SxWiU=
X-Google-Smtp-Source: AGHT+IGK+Y/yeiSY4i4LNG0FETbSsj8V00Fvy/EDeAdcI/jF6nTA4lWShcFts2QfASsHYeWulz4MLA==
X-Received: by 2002:adf:e682:0:b0:33d:3be4:6c75 with SMTP id r2-20020adfe682000000b0033d3be46c75mr4901520wrm.71.1708945635764;
        Mon, 26 Feb 2024 03:07:15 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id bt1-20020a056000080100b0033d9c7eb63csm8150307wrb.84.2024.02.26.03.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 03:07:15 -0800 (PST)
Message-ID: <6d82dca4-3ffe-4c51-9f74-cd6cfbac7f7a@baylibre.com>
Date: Mon, 26 Feb 2024 12:07:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mfd: tps6594: Add register definitions for TI
 TPS65224 PMIC
Content-Language: en-US
To: Bhargav Raviprakash <bhargav.r@ltts.com>, linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 lgirdwood@gmail.com, broonie@kernel.org, linus.walleij@linaro.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com,
 vigneshr@ti.com, kristo@kernel.org
References: <20240223093701.66034-1-bhargav.r@ltts.com>
 <20240223093701.66034-2-bhargav.r@ltts.com>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240223093701.66034-2-bhargav.r@ltts.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bhargav.

Thanks for the series.

On 2/23/24 10:36, Bhargav Raviprakash wrote:
> From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
>
> Extend TPS6594 PMIC register and field definitions to support TPS65224
> power management IC.
>
> TPS65224 is software compatible to TPS6594 and can re-use many of the
> same definitions, new definitions are added to support additional
> controls available on TPS65224.
>
> Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> ---
>   include/linux/mfd/tps6594.h | 354 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 342 insertions(+), 12 deletions(-)

[...]
> +/* IRQs */
> +enum tps65224_irqs {
> +	/* INT_BUCK register */
> +	TPS65224_IRQ_BUCK1_UVOV,
> +	TPS65224_IRQ_BUCK2_UVOV,
> +	TPS65224_IRQ_BUCK3_UVOV,
> +	TPS65224_IRQ_BUCK4_UVOV,
> +	/* INT_LDO_VMON register */
> +	TPS65224_IRQ_LDO1_UVOV,
> +	TPS65224_IRQ_LDO2_UVOV,
> +	TPS65224_IRQ_LDO3_UVOV,
> +	TPS65224_IRQ_VCCA_UVOV,
> +	TPS65224_IRQ_VMON1_UVOV,
> +	TPS65224_IRQ_VMON2_UVOV,
> +	/* INT_GPIO register */
> +	TPS65224_IRQ_GPIO1,
> +	TPS65224_IRQ_GPIO2,
> +	TPS65224_IRQ_GPIO3,
> +	TPS65224_IRQ_GPIO4,
> +	TPS65224_IRQ_GPIO5,
> +	TPS65224_IRQ_GPIO6,
> +	/* INT_STARTUP register */
> +	TPS65224_IRQ_VSENSE,
> +	TPS65224_IRQ_ENABLE,
> +	TPS65224_IRQ_PB_SHORT,
> +	TPS65224_IRQ_FSD,
> +	TPS65224_IRQ_SOFT_REBOOT,
> +	/* INT_MISC register */
> +	TPS65224_IRQ_BIST_PASS,
> +	TPS65224_IRQ_EXT_CLK,
> +	TPS65224_IRQ_REG_UNLOCK,
> +	TPS65224_IRQ_TWARN,
> +	TPS65224_IRQ_PB_LONG,
> +	TPS65224_IRQ_PB_FALL,
> +	TPS65224_IRQ_PB_RISE,
> +	TPS65224_IRQ_ADC_CONV_READY,
> +	/* INT_MODERATE_ERR register */
> +	TPS65224_IRQ_TSD_ORD,
> +	TPS65224_IRQ_BIST_FAIL,
> +	TPS65224_IRQ_REG_CRC_ERR,
> +	TPS65224_IRQ_RECOV_CNT,
> +	/* INT_SEVERE_ERR register */
> +	TPS65224_IRQ_TSD_IMM,
> +	TPS65224_IRQ_VCCA_OVP,
> +	TPS65224_IRQ_PFSM_ERR,
> +	TPS65224_IRQ_BG_XMON,
> +	/* INT_FSM_ERR register */
> +	TPS65224_IRQ_IMM_SHUTDOWN,
> +	TPS65224_IRQ_ORD_SHUTDOWN,
> +	TPS65224_IRQ_MCU_PWR_ERR,
> +	TPS65224_IRQ_SOC_PWR_ERR,
> +	TPS65224_IRQ_COMM_ERR,
> +	TPS65224_IRQ_I2C2_ERR,
> +	/* INT_ESM register */
> +	TPS65224_IRQ_ESM_MCU_PIN,
> +	TPS65224_IRQ_ESM_MCU_FAIL,
> +	TPS65224_IRQ_ESM_MCU_RST,
> +};

For tps6594, ESM_MCU interrupts were supposed to be cleared by the MCU FW. That's why we only had to 
deal with ESM_SOC interrupts in linux. For tps65224, I would recommend double-checking with TI where 
ESM_MCU interrupts should be handled (either in MCU FW or in the linux driver). For some reason this 
might be different than tps6594's case, but it does not look very consistent to me at first sight. 
Julien Panis

