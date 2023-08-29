Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9A78CA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbjH2Q6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbjH2Q5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:57:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFD4BE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:57:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso982499666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693328264; x=1693933064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USnPVHhTaTEKWMY0RI8COMBvSuzKiyupj+WtOVSWwH4=;
        b=xozLu+XoMpQa847wsceNnGCC1gkwG5tw7MBvIwruVFu/QZSvY+5g+kc2yhMRoB+/2e
         B+WFV4aLla/wkqO9AOaF2R+Vhe3bElNVsYtoQ3CVI0rkZyokNeC5G18eI4rUBFPdsIG1
         8dzh85iyJLtYJF2LPTqlxITjCLvFM9SF0VsOAmF1S9CVMUdfnReg+F+1hDZPIlphv8T+
         dsFmGu0xhlN2U8kE6uwTeJaqhBa2OVL6pPrBwjDTlrV6oOS6d18GrNslNS9UKEsWN13/
         lf/O0s3aDmNgKBuQND/+7zjJ6PmBnrVUq/ZKj02F4TXOGyenZuvLHZZgqXwfC3NV3bk6
         Vl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693328264; x=1693933064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USnPVHhTaTEKWMY0RI8COMBvSuzKiyupj+WtOVSWwH4=;
        b=fF60X/RaMY6I9TlPp5FR3g0myOYeLNvG5LCXXZbldk5ifbQRRkv1OtFsZXae/dn45I
         jRfC7YEm/oHogcOEyFmYmFx+qMmbGu+WK629p2BC89ux+6lgacJUMZpaDLfOfIarH71L
         6eaJmnFuo081WoBhhffURxCwpzsCFZi0j5Ijdew2Q+o30B93x8fLTkxW7HRUT4mOBNZr
         B7L05i8pNUmHDJcp18RmeE+5VPQtu7UGGgwSK1R1Vf8Rizobv435QVJJqiI7DCH5ooK9
         1/9Jte8HR30c4gy295ITYU3Eb6Xh9iMZpDnhsaX02LYsXXJqJPUgKhUimEsK0wWWEdiO
         aXNw==
X-Gm-Message-State: AOJu0YxxH4vnaTW9lzjUWTXO3T+VZgci/Hks5qanJ5EpVyVpu3kmA3JM
        fbwi3opJTeqOCHDJzzWYqLYu5A==
X-Google-Smtp-Source: AGHT+IFUDlTg4lh2YVHAkkvvKYFu8vTL7QE7o7/B5+sdtauSDrekKlQkM8y9WlfNHo9QkAYi/Ti4TQ==
X-Received: by 2002:a17:907:3e0d:b0:9a1:fed1:9b42 with SMTP id hp13-20020a1709073e0d00b009a1fed19b42mr4249879ejc.23.1693328264045;
        Tue, 29 Aug 2023 09:57:44 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906488900b0099cc36c4681sm6146020ejq.157.2023.08.29.09.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 09:57:43 -0700 (PDT)
Message-ID: <97741bfd-70a3-f2ef-fd10-c1aadecd059b@linaro.org>
Date:   Tue, 29 Aug 2023 18:57:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/9] phy: qcom: uniphy: Update UNIPHY driver to be a
 common driver
Content-Language: en-US
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, robert.marko@sartura.hr,
        luka.perkov@sartura.hr, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        arnd@arndb.de, geert+renesas@glider.be, nfraprado@collabora.com,
        rafal@milecki.pl, peng.fan@nxp.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_varada@quicinc.com
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
 <20230829135818.2219438-4-quic_ipkumar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829135818.2219438-4-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 15:58, Praveenkumar I wrote:
> This patch updates the UNIPHY driver to be a common driver to

Please do not use "This commit/patch", but imperative mood. See longer
explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> accommodate all UNIPHY / Combo PHY. This driver can be used for
> both USB and PCIe UNIPHY. Using phy-mul-sel from DTS MUX selection
> for USB / PCIe can be acheived.

This patch is entirely unreadable. You speak "unify" but change much
more. There is no code removal, so what are you unifying?

...

> -	phy->phy = devm_phy_create(dev, NULL, of_device_get_match_data(dev));
> -	if (IS_ERR(phy->phy)) {
> -		dev_err(dev, "failed to create PHY\n");
> -		return PTR_ERR(phy->phy);
> +	uniphy->phy = devm_phy_create(dev, NULL, &uniphy_phy_ops);

NAK, really, this does not make sense, is not explained and not needed.
If needed, then it would deserve its own patch with own justification.

> +	if (IS_ERR(uniphy->phy)) {
> +		ret = PTR_ERR(uniphy->phy);
> +		dev_err_probe(dev, ret, "failed to create PHY\n");

That's not even the syntax. By "unifying" you introduce different, wrong
code.

> +		goto err;
>  	}
> -	phy_set_drvdata(phy->phy, phy);
> +
> +	phy_set_drvdata(uniphy->phy, uniphy);
>  
>  	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>  
> -	return PTR_ERR_OR_ZERO(phy_provider);
> +	ret = PTR_ERR_OR_ZERO(phy_provider);
> +
> +err:
> +	if (uniphy->cfg->pipe_clk_rate)
> +		of_node_put(np);
> +	return ret;
>  }
>  
> -static struct platform_driver ipq4019_usb_phy_driver = {
> -	.probe	= ipq4019_usb_phy_probe,
> +static const struct of_device_id qcom_uniphy_of_match[] = {
> +	{ .compatible = "qcom,usb-hs-ipq4019-phy", .data = &ipq4019_usb_hsphy_cfg},
> +	{ .compatible = "qcom,usb-ss-ipq4019-phy", .data = &ipq4019_usb_ssphy_cfg},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, qcom_uniphy_of_match);

What happens here?

Best regards,
Krzysztof

