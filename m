Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623B17D649B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjJYIKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjJYIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:10:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6803F138
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:10:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99357737980so838885466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698221415; x=1698826215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4W3FzdBdmgcqLq3CYAVEQg20wE8TpJO/Jt0nqAq+mI=;
        b=Z//HFD563Id1kD0AUwbP7b1BPWjP/UH0lGL7Km1J/CQKPulMxD3RqQxIQf9smiWnSh
         KGBLESmJUbJIvlpuJODqX9uvvJ3DI87fDRc+qdL1uWGhbo8TrIECDmgG6E/a8zZOb26S
         OxWr2R0dyTqfzHW445msiKZvyJRdhw7fn63BxNmImgxdx1x/hocOG/GaM2hx5dpgvBiX
         RxGD6FKHUH0jxs3+inWtEocVtOfMSUUTx9Zg0ygUhhiFxYW0lM6nEeelyI+Magw9oRrP
         RUIbM7M+7eSjNPRIeZh+TGbI4VG41GX3F+z9smOy7DDqdSFTSmrX4BMcfIHAU60sMiVx
         h0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698221415; x=1698826215;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4W3FzdBdmgcqLq3CYAVEQg20wE8TpJO/Jt0nqAq+mI=;
        b=U3GrNUi1N5v77V9bYy2vnsiY81YOLPAFY9dce2YaNOLE10AY1qsJnqu/G5svf15kpW
         dxUimu/JFQTqrFo2VUxwyQyJIMRcK+Gt8rsSA3ORbEjkzmq5PbeiD/k44JmJFUBTx0Ag
         7fOFJGnhdZoW+7yy7F4t0nbROMW5NG9iwHaXProgFKl8YK2z95mtVRin8TtNhX+Mtvg3
         cAb1lIXKaB+Jy0NyXKn1nVAKXgqfLFalrdxqn3EAXMwcYWfoJZ29/ahDuKyWqHubcNz6
         6DNW32YEX8LRJXWYZEwuJt62egyaEcpTiU8GEgPsc2RmM3QhXUyXFoMnDZmaUM5zKGEf
         q3Ow==
X-Gm-Message-State: AOJu0YxOXHxU7Yoxwgcwt2dFLkeX/u38gt+vo1jzvLEha3O43PXdsT8+
        ZK56rbHGzrdSyrMz5zGZju0Fbw==
X-Google-Smtp-Source: AGHT+IGVp+R025TInRQwYI6q7PbMS8fVsQj7ICyrdzm2FIiV9UmwrF/SDyNcy8E1FiLQ0fvBnSPBEg==
X-Received: by 2002:a17:907:8e89:b0:9c7:dc4e:1a22 with SMTP id tx9-20020a1709078e8900b009c7dc4e1a22mr8529234ejc.48.1698221414978;
        Wed, 25 Oct 2023 01:10:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id pj19-20020a170906d79300b009ad829ed144sm9378723ejb.130.2023.10.25.01.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 01:10:14 -0700 (PDT)
Message-ID: <213d8b75-93b5-40d5-bf4c-11690b05553f@linaro.org>
Date:   Wed, 25 Oct 2023 10:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: document the SM8650 Top Level
 Mode Multiplexer
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-tlmm-v1-0-4e3d84a3a46b@linaro.org>
 <20231025-topic-sm8650-upstream-tlmm-v1-1-4e3d84a3a46b@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231025-topic-sm8650-upstream-tlmm-v1-1-4e3d84a3a46b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 09:33, Neil Armstrong wrote:

Thank you for your patch. There is something to discuss/improve.

> +$defs:
> +  qcom-sm8650-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])$"
> +            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
> +        minItems: 1
> +        maxItems: 36
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +        enum: [ gpio, aoss_cti, atest_char, atest_usb, audio_ext_mclk0,
> +                audio_ext_mclk1, audio_ref_clk, cam_aon_mclk2, cam_aon_mclk4,
> +                cam_mclk, cci_async_in, cci_i2c_scl, cci_i2c_sda, cci_timer,
> +                cmu_rng, coex_uart1_rx, coex_uart1_tx, coex_uart2_rx,
> +                coex_uart2_tx, cri_trng, dbg_out_clk, ddr_bist_complete,
> +                ddr_bist_fail, ddr_bist_start, ddr_bist_stop, ddr_pxi0,
> +                ddr_pxi1, ddr_pxi2, ddr_pxi3, do_not, dp_hot, gcc_gp1,
> +                gcc_gp2, gcc_gp3, gnss_adc0, gnss_adc1, i2chub0_se0,
> +                i2chub0_se1, i2chub0_se2, i2chub0_se3, i2chub0_se4,
> +                i2chub0_se5, i2chub0_se6, i2chub0_se7, i2chub0_se8,
> +                i2chub0_se9, i2s0_data0, i2s0_data1, i2s0_sck, i2s0_ws,
> +                i2s1_data0, i2s1_data1, i2s1_sck, i2s1_ws, ibi_i3c,
> +                jitter_bist, mdp_vsync, mdp_vsync0_out, mdp_vsync1_out,
> +                mdp_vsync2_out, mdp_vsync3_out, mdp_vsync_e, nav_gpio0,
> +                nav_gpio1, nav_gpio2, nav_gpio3, pcie0_clk_req_n,
> +                pcie1_clk_req_n, phase_flag, pll_bist_sync, pll_clk_aux,
> +                prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, qdss_cti,
> +                qdss_gpio, qlink_big_enable, qlink_big_request,
> +                qlink_little_enable, qlink_little_request, qlink_wmss,
> +                qspi0, qspi1, qspi2, qspi3, qspi_clk, qspi_cs, qup1_se0,
> +                qup1_se1, qup1_se2, qup1_se3, qup1_se4, qup1_se5, qup1_se6,
> +                qup1_se7, qup2_se0, qup2_se1, qup2_se2, qup2_se3, qup2_se4,
> +                qup2_se5, qup2_se6, qup2_se7, sd_write_protect, sdc40, sdc41,
> +                sdc42, sdc43, sdc4_clk, sdc4_cmd, tb_trig_sdc2, tb_trig_sdc4,
> +                tgu_ch0_trigout, tgu_ch1_trigout, tgu_ch2_trigout,
> +                tgu_ch3_trigout, tmess_prng0, tmess_prng1, tmess_prng2,
> +                tmess_prng3, tsense_pwm1, tsense_pwm2, tsense_pwm3, uim0_clk,
> +                uim0_data, uim0_present, uim0_reset, uim1_clk, uim1_data,
> +                uim1_present, uim1_reset, usb1_hs, usb_phy, vfr_0, vfr_1,
> +                vsense_trigger_mirnat ]
> +
> +      bias-disable: true
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      drive-strength: true
> +      input-enable: true
> +      output-disable: true
> +      output-high: true
> +      output-low: true
> +
> +    required:
> +      - pins
> +
> +    additionalProperties: false

We changed the syntax here:
1. Use unevaluatedProperties: false (and put it after $ref:
qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state)
2. Drop all these ": true" properties.

Take a look at sm8550 for an example.

Best regards,
Krzysztof

