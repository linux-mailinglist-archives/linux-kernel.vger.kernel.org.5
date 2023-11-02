Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534237DEE7F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbjKBI5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjKBI5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:57:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8AD132
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:57:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9d216597f64so98221466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 01:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698915434; x=1699520234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ti8VRK44rRpfNSXAtpGWqBsh2GV0GvDCSbxVBHE7LHU=;
        b=yYfx0z+6NmJspUHdVYQfqQ2QO5EBDy7hbpyDqi3ttFJvq8CC96TQhFhXFzZtxC1mNb
         c6+ys//CiaW79E8hits65t+NIY/x7pCDDSqjtuPNX2RRaxw9i2bocNYxZO9Yni/IET+e
         tVYs7CXscXMWiuaYiXsxN1+9t4BHU1nHoVi4L1/fgvIP1JSaukYDi7bSb3864Hx3B1DR
         fwUEjGU28U311oeafV+sO0ascPdR9ibiGBdzk9Z53WllOz6abdWiXBxAI08ylqBjAcu9
         U7RFdQxpY1NBHKCwPhP4Aj9qa8X8GG5tXylH22ZC6FpHBq9JPLbaaz2+EJ5m7usDoFx3
         ilGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698915434; x=1699520234;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti8VRK44rRpfNSXAtpGWqBsh2GV0GvDCSbxVBHE7LHU=;
        b=NQmp6nzVL/SySklfZzs9H+RrZrSZI1RcijwSPzPeTRZUrKl8xdj128y2MBCwaJDleP
         J6NdMNE9FHj8eo3qJVyCGV37oJ0eL/WrXIbCKiF+u26c72D49v/bjs7Z4R4i5eLRsAbk
         QLp1UV2KJiAYFpn69WgTr5z02F+4uzJ9ruwETtnZ53b12VozyRocpcFpmxO1Z1IG0v/8
         f6JLYmqR6HPI4LMwZ8SaGcYq5scVKovSBPHz1sAvX5ceVZp/16wH+PoQIJPYn4FK7w1A
         nQp/Jp19byGYfkzSuKiEk7ZNXT2vA6fjx3T1dTQoKb3Wm/92kl1dhJs2VDDrd3imUTWT
         9mHA==
X-Gm-Message-State: AOJu0YzHS6Q7lOyPKqquIkjOWnbpfG9LkU+NKovKoUVn6WpSP8syQTTA
        kQ+FFjl+n5sY4dSi4d0U78JJ2g==
X-Google-Smtp-Source: AGHT+IF+eiox49ggCtBVRyaFXSqOif7UUxrSxAuvywhajNlQ/L5vdqEjYxiyZHOrXcAKtd2vPahgrA==
X-Received: by 2002:a17:906:fd89:b0:9ce:24d0:8a01 with SMTP id xa9-20020a170906fd8900b009ce24d08a01mr4203821ejb.60.1698915434658;
        Thu, 02 Nov 2023 01:57:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id t24-20020a170906065800b009b2b47cd757sm866237ejb.9.2023.11.02.01.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 01:57:14 -0700 (PDT)
Message-ID: <9c083c35-a8fb-4ee3-90a3-96af7efec11f@linaro.org>
Date:   Thu, 2 Nov 2023 09:57:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5][3/4] mmc: Add dw mobile mmc cmdq rtk driver
Content-Language: en-US
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        asutoshd@codeaurora.org
Cc:     p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com
References: <20231102081514.22945-1-jyanchou@realtek.com>
 <20231102081514.22945-4-jyanchou@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231102081514.22945-4-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 09:15, Jyan Chou wrote:
> Add Realtek mmc driver to make good use Synopsys
> DesignWare mmc cmdq host driver.
> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> 
> ---
> v4 -> v5:
> - Fix linux coding style issues.
> - Modify the use of sizeof(*).
> - Remove useless function and parameter passing.
> - Replace platform_get_resource by devm_platform_ioremap_resource().

It's merge window. Sending big patchset every day won't get you far.

> 
> v3 -> v4:
> - Modify dma setting's code to fix linux coding style.
> - Drop useless function messages.
> - Remove MODULE_ALIAS().
> 
> v0 -> v1:
> - Seperate different support into single patch.
> - Fix the compiler complains.
> ---


> +
> +static int dw_mci_rtk_parse_dt(struct dw_mci *host)
> +{
> +	struct dw_mci_rtkemmc_host *priv;
> +	const u32 *prop;
> +	int size, ret;
> +
> +	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->pinctrl = devm_pinctrl_get(host->dev);
> +	if (IS_ERR(priv->pinctrl))
> +		dev_dbg(host->dev, "no pinctrl\n");
> +
> +	priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
> +						  PINCTRL_STATE_DEFAULT);
> +	if (IS_ERR(priv->pins_default))
> +		dev_warn(host->dev, "could not get default state\n");
> +
> +	priv->pins_sdr50 = pinctrl_lookup_state(priv->pinctrl,
> +						"sdr50");
> +	if (IS_ERR(priv->pins_sdr50))
> +		dev_warn(host->dev, "could not get sdr50 state\n");
> +
> +	priv->pins_hs200 = pinctrl_lookup_state(priv->pinctrl,
> +						"hs200");
> +	if (IS_ERR(priv->pins_hs200))
> +		dev_warn(host->dev, "could not get hs200 state\n");
> +
> +	priv->pins_hs400 = pinctrl_lookup_state(priv->pinctrl,
> +						"hs400");
> +	if (IS_ERR(priv->pins_hs400))
> +		dev_warn(host->dev, "could not get hs400 state\n");
> +
> +	priv->pins_tune0 = pinctrl_lookup_state(priv->pinctrl,
> +						"tune0");
> +	if (IS_ERR(priv->pins_tune0))
> +		dev_warn(host->dev, "could not get tune0 state\n");
> +
> +	priv->pins_tune1 = pinctrl_lookup_state(priv->pinctrl,
> +						"tune1");
> +	if (IS_ERR(priv->pins_tune1))
> +		dev_warn(host->dev, "could not get tune1 state\n");
> +
> +	priv->pins_tune2 = pinctrl_lookup_state(priv->pinctrl,
> +						"tune2");
> +	if (IS_ERR(priv->pins_tune2))
> +		dev_warn(host->dev, "could not get tune2 state\n");
> +
> +	priv->pins_tune3 = pinctrl_lookup_state(priv->pinctrl,
> +						"tune3");
> +	if (IS_ERR(priv->pins_tune3))
> +		dev_warn(host->dev, "could not get tune3 state\n");
> +
> +	priv->pins_tune4 = pinctrl_lookup_state(priv->pinctrl,
> +						"tune4");
> +
> +	if (IS_ERR(priv->pins_tune4))
> +		dev_warn(host->dev, "could not get tune4 state\n");
> +
> +	priv->vp0 = devm_clk_get(host->dev, "vp0");
> +	if (IS_ERR(priv->vp0))
> +		dev_err_probe(host->dev, ret, "could not get vp0 clk\n");
> +
> +	priv->vp1 = devm_clk_get(host->dev, "vp1");
> +	if (IS_ERR(priv->vp1))
> +		dev_err_probe(host->dev, ret, "could not get vp1 clk\n");
> +
> +	if (of_property_read_bool(host->dev->of_node, "supports-cqe"))
> +		priv->is_cqe = 1;
> +	else
> +		priv->is_cqe = 0;
> +
> +	prop = of_get_property(host->dev->of_node, "rdq-ctrl", &size);

NAK

> +	if (prop)
> +		priv->rdq_ctrl = of_read_number(prop, 1);
> +	else
> +		priv->rdq_ctrl = 0;
> +
> +	priv->emmc_mode = 3;
> +
> +	priv->m2tmx = syscon_regmap_lookup_by_phandle(host->dev->of_node, "realtek,m2tmx");

NAK, for the same reasons I mentioned for other patch.

I will keep NAK-ing till you start testing your DTS.


> +	if (IS_ERR_OR_NULL(priv->m2tmx))
> +		dev_err_probe(host->dev, ret, "can not get m2mtx node.\n");
> +
> +	host->priv = priv;
> +
> +	return 0;
> +}


Best regards,
Krzysztof

