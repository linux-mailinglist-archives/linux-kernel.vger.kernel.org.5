Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599CA7B34AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjI2OQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjI2OQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:16:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E818F1B6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:16:14 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4065f29e933so5735355e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695996973; x=1696601773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00JIa3i2YsuwYBTn1xiPk8aPDl3kS4S8pu4PM2POaUI=;
        b=hrW7w7JlgqYDLBetKemNzjp7x4cVc2MXWIalfba5IePCjFNGq5u8kb9crDeEghFxka
         W10sAS60DlA7JRIfVdbMJoDGSUxMw5ppzU80O2BZq1VUwzhC33oBHua0N7n2cCVZ7lrL
         lcHP78i4Hy0nD50rrUNs8RpfSumHaIAOJHsG22QsK0P+lBMW2quYgWEot68PmyqzmzJi
         cI2lLnIbKAamYmu2vkWAWrFUAlhU+Sr2QL+XBYnMtwaF1uUyFXFFEMoO+U4e/b0UrgEJ
         8kJE0JuJ6RF1CMxA55wbWuKngtsq4uVBAqBNOohNaRPK3xpNauattMaK8SdTcJkQK3uZ
         BWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996973; x=1696601773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00JIa3i2YsuwYBTn1xiPk8aPDl3kS4S8pu4PM2POaUI=;
        b=djGxthZj+J62mEtsWLXgz2l0+ieSunGREHFzS6UT79uc16bEM88jQGUpl9X5m5G8sV
         vFuqx787Ccd+V1DQEFMObSD7aXEO35EJHF3/iKElovWtP/6xxIxr3fAz18IEEzs6kjQM
         phYVooBb7RcrVSA6xaxhHo87/JNMjSToKhEgrNUztOWxzTfa+yf+JLfg3Jbsg1p1FNnz
         sVdfdEKLBPYeZ49SJjwL71eIgYu16hIdNmaa90klrMPoZjOnAWEtQCuR2h3SH0WPNK+3
         g+gLvtWMEnrNHkJJhxh672vAD33TFGilHuYKbavUQm71tH0P40aXRuQYkgyCo3GkJb7m
         3FXw==
X-Gm-Message-State: AOJu0YwsbPtcgYrwCnXeMiRM+s4a7G0gH+JqwtFUace9yZq7BYnDyC0+
        BGMN1Xsvv+MMOFijxOgYlfi0Ng==
X-Google-Smtp-Source: AGHT+IG61tSL0NxdNazcc9PmRAuQGFsDS5CNv2jnP9lZj6UbJ/936yH9/EvOEDuRV/yyAsqsm4f9Cg==
X-Received: by 2002:a05:600c:211:b0:404:6ed9:98d1 with SMTP id 17-20020a05600c021100b004046ed998d1mr3845184wmi.41.1695996973349;
        Fri, 29 Sep 2023 07:16:13 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n24-20020a1c7218000000b003fefb94ccc9sm1520894wmc.11.2023.09.29.07.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 07:16:12 -0700 (PDT)
Message-ID: <6b201582-4005-4d06-819d-356dd906b28c@linaro.org>
Date:   Fri, 29 Sep 2023 15:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: i2c: qcom-cci: Document SC7280
 compatible
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230929-sc7280-cci-v1-0-16c7d386f062@fairphone.com>
 <20230929-sc7280-cci-v1-1-16c7d386f062@fairphone.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230929-sc7280-cci-v1-1-16c7d386f062@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2023 09:01, Luca Weiss wrote:
> Document the compatible for the CCI block found on SC7280 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> index 042d4dc636ee..158588236749 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> @@ -25,6 +25,7 @@ properties:
>   
>         - items:
>             - enum:
> +              - qcom,sc7280-cci
>                 - qcom,sdm845-cci
>                 - qcom,sm6350-cci
>                 - qcom,sm8250-cci
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
