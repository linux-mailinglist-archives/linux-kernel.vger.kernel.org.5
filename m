Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B327761029
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjGYKED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjGYKD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:03:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE2A271B;
        Tue, 25 Jul 2023 03:03:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so4197033f8f.3;
        Tue, 25 Jul 2023 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690279387; x=1690884187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e495hPVSSfsBudphKr6esdXlU/XthcZYmt9+fcJRM4U=;
        b=sTY/fduZIMTMRloop5bzm5cPr8tIcvfTYGuNFIfmUmg6q+lyKMtZ98wxsi2G+aBe/v
         SFtRPktXotZTp//Y4UDXKp/5xJIMy3rnKNxQKXB0+NyMkN23RMxsH28TGxfrJ8BGhxUK
         qHNjv3e3HRekuAy+Eeu1SyXAEcbnDnMXHeqNxv5SiFxDJXRbgaZuWcAnCrxziJ5C+uYb
         1ry2oxlQ/PIR/28h/jFMFkKoE7Iis2WwpVrHqO5hmukA8HeZQDA5Dm7rl3kcY/R7/EmG
         OKxtz4MLLUa9h/nx6RpuRx7bCVQp7aXthiOfx7hGcVWVboYEcFPNy7vFuE53aO/2+lc2
         vT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690279387; x=1690884187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e495hPVSSfsBudphKr6esdXlU/XthcZYmt9+fcJRM4U=;
        b=Vq1mn55q6yOTAPWg801dFWKyMyWmXytta0iB7cda4GWJi4bAspyynzxDhK6UzJ5ZcY
         GWIT/BK7ifKMaZ9b1vzTkn3sUMhPwomW0/bwAC1vL/8QtnBWrE+tvEfGwsOkavRau+XI
         NZNtdKv9ocpz5q7dt0pc3YyeyyO8+KWyDdt8NMwIBVFQf5nSz2lBiMOhcicwGN2BMVwX
         VpvIYFRPpxcNIOztlL8k9+PB9g6OStCK5AiUNT7jdzvG1/LHnPsUTGwnwkKNCsXVVb48
         tnEz84QCBQjP/Z+SJqjwJVKiav9LuDRBF3o5+YfWxOA0ciN7Yzo2qb8XKo16XZQHhWBo
         /eRQ==
X-Gm-Message-State: ABy/qLZukXddgESCDPSIGURNx7bhURvYjJkqDCsVuoP6zOf2ngRaPktA
        O+s8BaI/iV06AKCzf3XtjP0=
X-Google-Smtp-Source: APBJJlHwOSqGMpMZWoR++iwvf5SMZvA1SjBkVklrwFyXMgWeIzARRW0DL+VeKsGY5CIZ/yKgJjuYYg==
X-Received: by 2002:a05:6000:1151:b0:314:10d8:b491 with SMTP id d17-20020a056000115100b0031410d8b491mr8568115wrx.67.1690279387120;
        Tue, 25 Jul 2023 03:03:07 -0700 (PDT)
Received: from [192.168.1.107] (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id w16-20020adfec50000000b003143867d2ebsm15879054wrn.63.2023.07.25.03.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 03:03:06 -0700 (PDT)
Message-ID: <80ce1710-38e3-2c6e-73b9-6b18c38b3ff3@gmail.com>
Date:   Tue, 25 Jul 2023 12:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] clk: qcom: hfpll: Add MSM8976 PLL data
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230723160827.22660-1-a39.skl@gmail.com>
 <20230723160827.22660-6-a39.skl@gmail.com>
 <411da19f-10f3-6dc1-a708-cdf06be9c4d8@linaro.org>
From:   Adam Skladowski <a39.skl@gmail.com>
In-Reply-To: <411da19f-10f3-6dc1-a708-cdf06be9c4d8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25.07.2023 10:02, Konrad Dybcio wrote:
> On 23.07.2023 18:08, Adam Skladowski wrote:
>> Add PLL configuration for MSM8976 SoC, this SoC offers 3 HFPLL.
>> Small cluster offers two presets for 652-902Mhz range and 902Mhz-1.47Ghz.
>> For simplicity only add second range as smaller frequencies can be obtained
>> via apcs divider or safe parent this also saves us
>> a hassle of reconfiguring VCO bit and config_val.
>> A72 and CCI cluster only use single frequency range with their
>> outputs/post_dividers/vco_bits being static.
>>
>> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
>> ---
> [...]
>
>> +static const struct hfpll_data msm8976_a72 = {
>> +	.mode_reg = 0x00,
>> +	.l_reg = 0x04,
>> +	.m_reg = 0x08,
>> +	.n_reg = 0x0c,
>> +	.user_reg = 0x10,
>> +	.config_reg = 0x14,
>> +	.config_val = 0x4e0405d,
>> +	.status_reg = 0x1c,
>> +	.lock_bit = 16,
>> +
>> +	.l_val = 0x3e,
>> +	.user_val = 0x100109,
>> +	.min_rate = 940800000UL,
>> +	.max_rate = 1843200000UL,
> 2016000000?

We are using msm kernel as base not SODP ports.

https://android.googlesource.com/kernel/msm/+/android-lego-6.0.1_r0.2/drivers/clk/qcom/clock-cpu-8976.c
https://android.googlesource.com/kernel/msm.git/+/android-msm-lego-3.10-marshmallow-dr/arch/arm/boot/dts/qcom/msm8976.dtsi#349

> [...]
>>  static const struct of_device_id qcom_hfpll_match_table[] = {
>>  	{ .compatible = "qcom,hfpll", &hdata },
>> +	{ .compatible = "qcom,msm8976-hfpll-a53", &msm8976_a53 },
>> +	{ .compatible = "qcom,msm8976-hfpll-a72", &msm8976_a72 },
>> +	{ .compatible = "qcom,msm8976-hfpll-cci", &msm8976_cci },
> .data = is missing
>
> Konrad

Seems like i took "inspiration" from also not great code, albeit it does work somehow when printing inside init, will fix in v3 

Thanks Angelo/Konrad

