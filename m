Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5907080913F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443685AbjLGTY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjLGTYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:24:55 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09F91733
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:24:57 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so14666531fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 11:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701977096; x=1702581896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVaODAR3o/Ibyy68Y5wtq42VvON75SYxd68wi+HuMbg=;
        b=aapZXh8gNXnkNDyCEaF2CkI3afCG7YiDlbr+psnIu7TKK+I8/1APWcUZ/u96GhYc3M
         UpWSLUmZcpReZ/5bXvPoD41Zf1ZAOKWUW6N1kFXXonaaM3Qq6aTGFI6t/Axs7U+Sihbp
         m3JuYFAE7Es77L8dQvZi8lCSL1rpK3E54UVHBiLNCU72XGWTvgxdaZZU5mG+5kwleuDM
         yvz5E0GKj0yO4vLf2hbozliSLvwOQbfqOIMDoETznw2dlNtk2sTXK5yg9eUDCWj6fpH9
         U7PKdF1m54Bgobii2+ki5ZHodDNnyMVjNXjTIiYPq6azn/ckmQbX53D937kEwDl3YP9l
         avGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701977096; x=1702581896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVaODAR3o/Ibyy68Y5wtq42VvON75SYxd68wi+HuMbg=;
        b=G7MW5GCTVRSb9q0jFHO7x336nwJYVxvSnmcmOYLua3LIu2DIS7tE/oD6Nr40DDHSxa
         TQS0CQA+5skqs4GMlsDkiccIY3TLxjJcrlVgtNmuWkdenkuV5ntqcxECpBDSojVT1683
         7VrILyyw8rgpQCKIM5YvGQ8xe80m8WAz8ieq2o4yXVfhra33ZWSPlderXGT+qffhpf9H
         BzS5h+rg1Y4Wx/Z2ZqmurqdxVMx5huV7sGU3XuFH20CUbSZvQ/jIq+yXMsh3yLwrEYyW
         PeyBHrRh4zp3imX/OTG0nwXPPolhYNaNgUUlW74EvsDilG1NG+oOx5tap/Zp7Ahx5T1t
         pR/w==
X-Gm-Message-State: AOJu0YzQyieqYFrHQ25Zjsrccr6vPj1fsY14YLY/j2ClHLMozY5BYpzr
        oKw8mLaAT58I+AddKnVEK87/WQ==
X-Google-Smtp-Source: AGHT+IFbt/5mwz2PM1xcvV0ngLhtlHgCEprELvE1ziPZmZYPzXnNF0jvMRZNxbcmV6BSINZKU+pZmw==
X-Received: by 2002:a2e:97d3:0:b0:2ca:18de:126b with SMTP id m19-20020a2e97d3000000b002ca18de126bmr1347468ljj.43.1701977095729;
        Thu, 07 Dec 2023 11:24:55 -0800 (PST)
Received: from [172.30.205.181] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a11-20020a05651c010b00b002ca0a5dc73csm24380ljb.9.2023.12.07.11.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:24:55 -0800 (PST)
Message-ID: <71459bab-05b9-41f6-bb32-2b744736487d@linaro.org>
Date:   Thu, 7 Dec 2023 20:24:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] power: supply: Add Acer Aspire 1 embedded controller
 driver
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
 <20231207-aspire1-ec-v1-2-ba9e1c227007@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231207-aspire1-ec-v1-2-ba9e1c227007@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/23 12:20, Nikita Travkin wrote:
> Acer Aspire 1 is a Snapdragon 7c based laptop. It uses an embedded
> controller to control the charging and battery management, as well as to
> perform a set of misc functions.
> 
> Unfortunately, while all this functionality is implemented in ACPI, it's
> currently not possible to use ACPI to boot Linux on such Qualcomm
> devices. To allow Linux to still support the features provided by EC,
> this driver reimplments the relevant ACPI parts. This allows us to boot
> the laptop with Device Tree and retain all the features.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
[...]

> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		val->intval = le16_to_cpu(ddat.capacity_now) * 100
> +			      / le16_to_cpu(sdat.capacity_full);
It may be just my OCD and im not the maintainer here, but I'd do
/= here

[...]

> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		if (sdat.model_id - 1 < ARRAY_SIZE(aspire_ec_psy_battery_model))
> +			val->strval = aspire_ec_psy_battery_model[sdat.model_id - 1];
> +		else
> +			val->strval = "Unknown";
Would it make sense to print the model_id that's absent from the LUT
here and similarly below?

> +		break;
> +
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		if (sdat.vendor_id - 3 < ARRAY_SIZE(aspire_ec_psy_battery_vendor))
> +			val->strval = aspire_ec_psy_battery_vendor[sdat.vendor_id - 3];
> +		else
> +			val->strval = "Unknown";
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
Another ocd trip, i'd add a newline before return

> +	return 0;
> +}
[...]

> +	/*
> +	 * The original ACPI firmware actually has a small sleep in the handler.
> +	 *
> +	 * It seems like in most cases it's not needed but when the device
> +	 * just exits suspend, our i2c driver has a brief time where data
> +	 * transfer is not possible yet. So this delay allows us to suppress
> +	 * quite a bunch of spurious error messages in dmesg. Thus it's kept.
Ouch.. do you think i2c-geni needs fixing on this part?

[...]

> +	switch (id) {
> +	case 0x0: /* No event */
> +		break;
Is this a NOP/watchdog sort of thing?

[...]

> +
> +static struct i2c_driver aspire_ec_driver = {
> +	.driver = {
> +		.name = "aspire-ec",
> +		.of_match_table = aspire_ec_of_match,
> +		.pm = pm_sleep_ptr(&aspire_ec_pm_ops),
> +	},
> +	.probe = aspire_ec_probe,
> +	.id_table = aspire_ec_id,
Since it's tristate, I'd expect an entry for .remove_new here

Konrad
