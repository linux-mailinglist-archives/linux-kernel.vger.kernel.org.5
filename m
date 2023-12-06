Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7C1806D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378156AbjLFLNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378052AbjLFLNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:13:20 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E99CA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:13:23 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c09f4bea8so35449735e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701861201; x=1702466001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=taILMNBmv0UhUk+zKRJE40uPAEg1eYYDWH/IKikPI8U=;
        b=xsxrUpgJPM37oJ+4uX8Loa/5wIr2aRtz4mQ/9C9RbY2c+yG07nPKOHLyknGIOvW8uJ
         C8pZZcBwH0k7NmxiHLWPmWY9IgmiJ128WCr/UQBFZNn7NEf5AzNYrtErwa6NC7pPQR1s
         Gc691YfgeHzWhJj8Ab8wPZw6bqoSnNCQQQsKDU3EbP0D9Posf0FX0MptNIP240x3myiI
         gX57L8NcnirA5L6cBjWk+sQgiN3yDUF92KfcJKJnr7b9sAhg/TAekHS+VY8DZKHMBoOS
         rR0yTBDzM6o7YtYjx8NxVU1rl345S+l0o5W5lYvDF0vL9TAoAaxvpAfDyRB7XOsBmkEY
         WKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861201; x=1702466001;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=taILMNBmv0UhUk+zKRJE40uPAEg1eYYDWH/IKikPI8U=;
        b=wDBDQqEsWmSriSIP+jo8nler2XD2IXrf6sfZZ05Aj14kJi+CtCvwBwps96tCY6HIsv
         EvPjySDKqNhDD26PKm/wtQ07zY9n5ZtK/0an86K2JYaD+lglAyNLjvAX7Bh9/DwTnPzN
         sRm/K89awiQ8GNcDBOBAoJ/fMQNu0aKh7wtpPl3hy3TlQUZ46bP6Ji7HKADnNnYoah3L
         UJZ8dPi8hGOr3l260UVqlQV6R31UgP6LlOC/s6onyUWmd9pucSuZpjEJxwxhJUrLCYYr
         e0TFZIwKc2mrIt5chGPavYlTNqPJXm7OpH33eV3RlvnvHud8wHjmK5gXZHNIhnxhuiyQ
         SSRA==
X-Gm-Message-State: AOJu0Yyvg1nfrCk4kRkslb9f26QQvABhZBPbEz9+Au+LEawxYz1DE+v7
        r5S56XpKzXSZoevKAXnqcyxzog==
X-Google-Smtp-Source: AGHT+IExFG83iuPQ4zXtvq3yL38vp2jPwoWtmtZOf0Ugg1jxvDmCEohOl9bwNtAqpH8zGrDuNDGJNw==
X-Received: by 2002:a05:600c:3b0e:b0:40b:3643:48bf with SMTP id m14-20020a05600c3b0e00b0040b364348bfmr499723wms.17.1701861201434;
        Wed, 06 Dec 2023 03:13:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b0040b3515cdf8sm21645411wms.7.2023.12.06.03.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:13:21 -0800 (PST)
Message-ID: <8e86fb4c-9526-4d64-9352-f9c8e5cae75f@linaro.org>
Date:   Wed, 6 Dec 2023 12:13:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] memory: brcmstb_dpfe: introduce best-effort API
 detection
Content-Language: en-US
To:     Markus Mayer <mmayer@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231205184741.3092376-1-mmayer@broadcom.com>
 <20231205184741.3092376-5-mmayer@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231205184741.3092376-5-mmayer@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 19:47, Markus Mayer wrote:
> Add a best-effort probe function that tries all known DPFE versions to
> see if one might actually work. This helps in cases where device tree
> doesn't provide the proper version information for whatever reason. In

So for incomplete DTS you now add elaborate, own, custom matching
function. That's not how the code should work.

> that case, the driver may still be able to register if one of the known
> API versions ends up working.
> 
> Caveat: we have to skip "v1" during our best effort attempts. This is
> due to the fact that attempting a firmware download as required by v1
> will result in a memory access violation on anything but v1 hardware.
> This would crash the kernel. Since we don't know the HW version, we need
> to play it safe and skip v1.

None of this commit explains what is real problem being solved.


> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/memory/brcmstb_dpfe.c | 58 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
> index 0b0a9b85b605..15f4ee3b8535 100644
> --- a/drivers/memory/brcmstb_dpfe.c
> +++ b/drivers/memory/brcmstb_dpfe.c
> @@ -879,6 +879,50 @@ static int brcmstb_dpfe_resume(struct platform_device *pdev)
>  	return brcmstb_dpfe_download_firmware(priv);
>  }
>  
> +static int brcmstb_dpfe_probe_best_effort(struct platform_device *pdev)
> +{
> +	const char versioned_compat[] = "brcm,dpfe-cpu-v";
> +	const char v1_str[] = "-v1";
> +	const struct of_device_id *matches;
> +	const struct dpfe_api *orig_dpfe_api;
> +	struct device *dev = &pdev->dev;
> +	struct brcmstb_dpfe_priv *priv;
> +	int ret = -ENODEV;
> +
> +	priv = dev_get_drvdata(dev);
> +	orig_dpfe_api = priv->dpfe_api;
> +	matches = dev->driver->of_match_table;
> +
> +	/* Loop over all compatible strings */
> +	for (; matches->compatible[0]; matches++) {
> +		const char *compat = matches->compatible;
> +		/* Find the ones that start with "brcm,dpfe-cpu-v" */
> +		if (strstr(compat, versioned_compat) == compat) {
> +			char *v1_ptr = strstr(compat, v1_str);
> +			/*
> +			 * We must skip v1, since we don't know the hardware
> +			 * version and attempting a firmware download on v2 and
> +			 * newer would crash the kernel due to a memory access
> +			 * violation.
> +			 * We make sure to match "-v1" at the end of the string
> +			 * only.
> +			 */
> +			if (v1_ptr && v1_ptr[sizeof(v1_str)] == '\0')
> +				continue;
> +			priv->dpfe_api = matches->data;
> +			/* Fingers crossed... */
> +			ret = brcmstb_dpfe_download_firmware(priv);
> +			if (!ret)
> +				return 0;
> +		}
> +	}
> +
> +	/* It didn't work, so let's clean up. */
> +	priv->dpfe_api = orig_dpfe_api;
> +
> +	return ret;
> +}
> +
>  static int brcmstb_dpfe_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -923,8 +967,20 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = brcmstb_dpfe_download_firmware(priv);
> +	if (ret && ret != -EPROBE_DEFER) {
> +		/*
> +		 * If the information provided by Device Tree didn't work, let's
> +		 * try all known version. Maybe one will work.

I don't understand how this comment is related to downloading firmware.

> +		 */
> +		dev_warn(dev,
> +			"DPFE v%d didn't work, reverting to best-effort\n",
> +			priv->dpfe_api->version);
> +		dev_warn(dev,
> +			"Device Tree and / or the driver should be updated\n");

You are now introducing new warnings?

NAK

Best regards,
Krzysztof

