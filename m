Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF477CE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbjHOOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbjHOOkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:40:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E02DC5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:40:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe5c0e587eso55115805e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692110418; x=1692715218;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tSVBhXWt7TNqQc2EjdgZO4iqIf4JJ+I9/JS50KxzJlA=;
        b=c1FhoFHSurN696QKAroMPnZ16COmvLtaNEktF3j2u1wj47fJqOMv7QcL/qQb1VO2Ji
         bDhHJav9yC87r6vNTlSL3RcmxIEmCZdBChkTpqpCyWZAY94CkGjsiedFNAOOWU6S5wqd
         go12bxplHbCD8AbFIpdMinjYIEXF9PufktTuNvH3v86C/geXFjs106A7+crr6JtxXowA
         Ff+GZeRPklBU4WeuucxeVXdp2IUjYCQXW4eu6HYwbDeP7hgV0n5Y4DGV3kTh8UykOkR1
         r5bPA+iuFWGqMp4WJ/55cTAXFF5KbGAeUQk34ml1NkvZw3OqHDYSLdpYWZpueSCvnmIz
         0E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692110418; x=1692715218;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSVBhXWt7TNqQc2EjdgZO4iqIf4JJ+I9/JS50KxzJlA=;
        b=BA8T/vX+rzh6/RwNivAMRiGnud7ifJAntoBa/wx9tXJ+nz+JnZ/dbCqpv4x/zX0S9B
         5BghlmXD1Yk2J8p5wv8bLGD6/dZCIz1kuWM1LMS6w3TNTsllzvaWWpLhW9WRrbZfxshn
         VrwtNf1kvv/kqfeejnCBpLTtwqlbSIfCkzjWZ/A6YmsgpB3lTRN5F75wkzIPjQ21DpnE
         DIl7Lfpkaqv0DBSTlnJb8D+gexAT+BqLSjhnOJ3DtLmT6D8eiglS8lp/1wa8PPE+8ria
         1ow+C9UbY5/tPM3mkKX7BfWQ0TzFtFWvc4vgPhyve4H0yli62YzlfiUouKVTqpTGHfhV
         sTZw==
X-Gm-Message-State: AOJu0YwpnAMdave/kTSAYNrSY7UWiS4A++VnQOHlyzumtpRYbgkjgyAl
        GZsVlfQRrE+hrbTqmnOtmSBCEQ==
X-Google-Smtp-Source: AGHT+IEpvGhIfubksCEdL/OmxuZ5TRCfuGwk3fp2l69wE+slGPPNFJE+xDrK2HYAyxr06BpBMBiNNw==
X-Received: by 2002:a05:600c:217:b0:3fe:10d8:e7ef with SMTP id 23-20020a05600c021700b003fe10d8e7efmr11678457wmi.19.1692110417805;
        Tue, 15 Aug 2023 07:40:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id g7-20020a7bc4c7000000b003fbdd5d0758sm17975681wmk.22.2023.08.15.07.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 07:40:17 -0700 (PDT)
Message-ID: <3174c398-a19a-3b59-c2fc-3ec9a5e1a9df@linaro.org>
Date:   Tue, 15 Aug 2023 16:40:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5018: add WDT
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_saipraka@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230815141908.1084893-1-robimarko@gmail.com>
 <20230815141908.1084893-2-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230815141908.1084893-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 16:17, Robert Marko wrote:
> Add the required DT node for WDT operation.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 3285c86824cf..168322bfb11c 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -182,6 +182,13 @@ v2m1: v2m@1000 {
>  			};
>  		};
>  
> +		watchdog: watchdog@b017000 {
> +			compatible = "qcom,apss-wdt-ipq5018", "qcom,kpss-wdt";
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;

I think all GIC_SPI interrupts are level high.

> +			reg = <0x0b017000 0x40>;

Keep the reg as second property.

> +			clocks = <&sleep_clk>;
> +		};

Best regards,
Krzysztof

