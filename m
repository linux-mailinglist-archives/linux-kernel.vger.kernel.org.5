Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC7E75A8EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjGTIQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjGTIQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:16:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6F1268C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:16:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fdddf92b05so338443e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689841002; x=1690445802;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7XyOQDpJVVfm2vqrxvwzAIErygUb0oI9Levi9EQEtzU=;
        b=pHd64Uh9HIqJaZloNuVrUQxpEVMxLthAeyouypZyuO7vZEQ9j5qgcCQi/Da3LcF/GT
         SjXNfoJSC2/MtKWIkwM1RcmQGmHhm1Tf5nuOwIXcY5cI3xQYuyS3YWaiX01ILpXxxXYi
         o9c/IIztqkY9xa9u9IDBHcST7vctOTEwJ6Ypw1uxGolpGtK5woINczQB4IKhsSTGXP7G
         wLhHy5HCP7SLv+gaNwXPdAApaUgex2b3AYTHc3dfbdLutSCOylaNUoBFpW39qkLPOubW
         piQuYeogZr/HhxSpjeldxyWMMLy4c44bqexXCkid2B008TnfNkA0WoUUgeJEFBiQL8bv
         sLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689841002; x=1690445802;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XyOQDpJVVfm2vqrxvwzAIErygUb0oI9Levi9EQEtzU=;
        b=ihthellAdMKbxVqFyee3RYzc4nK8ayaRbMPQtb6QJasZTQ1iavumnRVWbH2DgKB1Q4
         nt1qJB8A12WKkEkUus7rOGN2WLtwZnqrf/E2SEPfp7yDHd8AHyf1l0lmhMN6OhDcYE8g
         gO+I4kXSm3CAcY/tqyOa7DNahgAZwoh4pNZfVC7zhFsHPjcZqDk4lP2wQhPaGhBaeCxJ
         SxnnyCl3oXRXce9dP6oQ+bQhnGua3IlmNNWDSyGEC0bvmRL9QUlvnsowRBn/3PSjO/rZ
         PrkLKtxB3RZCixcLsxP/M+MCbBHQ/HKtlWN2D6/dm4PHSIJZZr/WmXn8Oqeb+d9HiQjs
         0yFQ==
X-Gm-Message-State: ABy/qLaGsWeFc8b3d8vvld/KLbZWmiF/SvV9jS2aHuuFWiqrzhnz0wkr
        ZPABIA6CJZf7poV7OeTfdhIr+Q==
X-Google-Smtp-Source: APBJJlHWu5+IPzKxrWZtiDlXrVbECYNzGFwtTOD5wxG+qhwNidLMw5No3bP69pTIx8i3gE2MUSH+Yg==
X-Received: by 2002:a19:e016:0:b0:4f8:596a:4bb7 with SMTP id x22-20020a19e016000000b004f8596a4bb7mr1441271lfg.57.1689841002463;
        Thu, 20 Jul 2023 01:16:42 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id o4-20020a05651238a400b004fbbba57ca9sm83724lft.85.2023.07.20.01.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 01:16:42 -0700 (PDT)
Message-ID: <6f26ab9d-cf92-e918-866c-daa68096ee08@linaro.org>
Date:   Thu, 20 Jul 2023 10:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5018: add support for the RDP415
 variant
Content-Language: en-US
To:     Hariharan K <quic_harihk@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com
References: <20230720074846.20350-1-quic_harihk@quicinc.com>
 <20230720074846.20350-3-quic_harihk@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230720074846.20350-3-quic_harihk@quicinc.com>
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

On 20.07.2023 09:48, Hariharan K wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 415 based on IPQ5018 family of SoC. This patch
> carries the support for Console UART and eMMC.
> 
> Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
> ---
[...]

> +
> +&sdhc_1 {
> +	pinctrl-0 = <&sdc_default_state>;
> +	pinctrl-names = "default";
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	max-frequency = <192000000>;
> +	bus-width = <4>;
> +	status = "okay";
Since some (but presumably not all) SKUs have SDHCI, you can define
the plumbing for it in the common DTSI but only enable it on ones
that do (or disable on those that don't)

Konrad
