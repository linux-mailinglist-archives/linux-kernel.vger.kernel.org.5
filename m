Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06468005EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377863AbjLAIj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjLAIjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:39:55 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D851720
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:40:01 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bc36725bbso2696292e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 00:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701419999; x=1702024799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBM0cPs1Gi8BXGGaIRnt4whCmCq9vuvHTnWmljIuX1M=;
        b=y4zy/Dum45Nz9GJpJECOmuhu19Zu0GLShXUf1tOgz6x82EQxbPZnOWhiO47qtcbCgM
         3Ck23WI6LBiU7HFl0i596zzHvicIhiq/WC0d5jjoZPbDYBdyR9DCQ14g6+AJ/SYnQznX
         daHVjW3iiU8/XlKS/1u9SjeNb/ekjJw9QLceosdke6nWABrbDKoqHPswlgWquPwsoDq/
         O1cFExFF86FUcjbUEvVumE8Hu/FyCIxLeBi9FR6E6aIXOuSoLlZX0JxhbYsbzRD0ZoNa
         MpEqBlB3NtSHCH/PlhjY7BUoL/m8Zlc8wuLP8TMRO5n/GC6yw7TJpUilRIjSG1xfbNIZ
         F94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701419999; x=1702024799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBM0cPs1Gi8BXGGaIRnt4whCmCq9vuvHTnWmljIuX1M=;
        b=sbz9FEPk2akuZvGpuaMeuNDkQWEuAuxcvRAEcdSW0KyuWCaug+odgvr8r3De2gY5QN
         z0Z8gCu5iwwTh2DzzFT9NmJMP8puuDvQ7oVBoaVpA7acZXvsDSQPE0JTWPpBERY6Vivo
         tkgYtjJAMkqDjNNaBFoVT1gIkEyaSDYv0lfgBR2Lgbmfy4OZ3cu+Y2m1ujUmQpuPnwDV
         m4eNd3WbB7VM0qHzBcn1GevcFx0IBMQaj+UwTKuIDRZL4UlCC/ADFW96nMExcGdMHK/z
         aJQrBMiGNJpZUnkq1QYpsDgdCGszk+HJrg9y2d3RwTU9JjzM2jj8v/a5iCx/cML2aIvd
         gR9g==
X-Gm-Message-State: AOJu0YzEIlycqYRbzFtZseH95WLeG+emCFD9T/HvohJ9PHCOkdaSNRzk
        2PtLxXcTavwOoQMlK1R+FES0YQ==
X-Google-Smtp-Source: AGHT+IG9NgMjpjHaijT4SNeNKxPgYBOMeGyO+6VbIMNinwm9tJq0n2F38OjVQAXxE7KNX+7pveCisQ==
X-Received: by 2002:ac2:58e3:0:b0:50b:c307:7cba with SMTP id v3-20020ac258e3000000b0050bc3077cbamr454706lfo.31.1701419999229;
        Fri, 01 Dec 2023 00:39:59 -0800 (PST)
Received: from linaro.org ([82.77.85.67])
        by smtp.gmail.com with ESMTPSA id fa10-20020a05600c518a00b00405442edc69sm8274555wmb.14.2023.12.01.00.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:39:58 -0800 (PST)
Date:   Fri, 1 Dec 2023 10:39:57 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sm8550-lpass-lpi: add
 X1E80100 LPASS LPI
Message-ID: <ZWmb3fa5bIXQmLzf@linaro.org>
References: <20231129155738.167030-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129155738.167030-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-29 16:57:38, Krzysztof Kozlowski wrote:
> Document the Qualcomm X1E80100 SoC Low Power Audio SubSystem Low Power
> Island (LPASS LPI) pin controller, compatible with earlier SM8550 model.
> 
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  .../bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml     | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
> index ef9743246849..ad5e32130fd7 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
> @@ -16,7 +16,11 @@ description:
>  
>  properties:
>    compatible:
> -    const: qcom,sm8550-lpass-lpi-pinctrl
> +    oneOf:
> +      - const: qcom,sm8550-lpass-lpi-pinctrl
> +      - items:
> +          - const: qcom,x1e80100-lpass-lpi-pinctrl
> +          - const: qcom,sm8550-lpass-lpi-pinctrl
>  
>    reg:
>      items:
> -- 
> 2.34.1
> 
