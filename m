Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C626751E83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjGMKLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjGMKLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:11:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0479A26BC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:11:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9928abc11deso83476966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689243069; x=1691835069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdJChzZNxDzjOXLqJ61GLiH0/vTfmrIbg8mkf+gOJHA=;
        b=XpqauorbRj+16W2KdWYqID1YUOFsG/PLZ+NFNt+BljuZB9a8RP2Z/dH2zY5Ud6LuI2
         8/Oklpnhec0u39RVTWa6M8TXhm7RiPlh2NpjuLqR3labjm2NuAGTRuIaeld0yiieIcb/
         CxliVWI5j8uhpr/ofEZOSON3NL7jkUYeC7mLPSZUKgTDzU03htyHcMqlDTNMXow5Y52U
         dXh16Ij30ycdhACBcsI+r0sBo0JoYAQqmwX/ezXoNyfPctJ9LVHds8EsBM0ldo7qUoG0
         Ge4g78Zrmpgz+voLuE92FZAmklmu9ryRlMcnyz2NStpskMAELW8xPy1VePTI1sSwjxym
         aHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689243069; x=1691835069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdJChzZNxDzjOXLqJ61GLiH0/vTfmrIbg8mkf+gOJHA=;
        b=V0d8qmStF2JGlRCusIn1eF2BBNi3abLxbCbDhBKr8/R7nYf+gHDIQRFgYJ2FnA+hxL
         YEIkEYGsCWGLbQZd7R+sJvHdWMc1sGZQo/Ih4s1ag1VaG5bb8xAyrT9Evkj7WOPuksLN
         +FipO6CfBnWMx06PVyoerAAj/NKqf2n3FxjuEszuQxPuz9ha5SPkjYxfcOdXRM7bbole
         T2D2pDS/JhJH33oo+6KdXNegfJSzwID3qxHIY7QMOs96nA3h/c2CySJ9b3XoHFoMw5ll
         oGSFvF2rfj6pdmvzY6H66gxUypMvcNHyM8MnJhhlLAfBfzuqsO44Rs9YJedtneFTsg7Z
         JSCQ==
X-Gm-Message-State: ABy/qLbkjFXYUtCJDEraVvdV+ud2DBjFuS+tiIWT2aHbdQKrHOy/RBzi
        rJj2BjyC9wq59v3K1cP9MFjUhQ==
X-Google-Smtp-Source: APBJJlHupH2O4PNGjOoIHbXwB5WOyuMkaK5vUVwl67E+lPYsa2Kthyh37XaKqJxQvC4FiojvMkXRgA==
X-Received: by 2002:a17:906:341b:b0:992:a836:a194 with SMTP id c27-20020a170906341b00b00992a836a194mr788045ejb.59.1689243069359;
        Thu, 13 Jul 2023 03:11:09 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id x18-20020a170906149200b00989027eb30asm3762868ejc.158.2023.07.13.03.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 03:11:08 -0700 (PDT)
Message-ID: <5bc4ddee-fdac-a6c0-c30d-5d0a065e24e9@linaro.org>
Date:   Thu, 13 Jul 2023 11:11:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] dt-bindings: nvmem: qfprom: Add compatible for
 MSM8226
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
 <20230507201225.89694-2-matti.lehtimaki@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230507201225.89694-2-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/05/2023 21:12, Matti Lehtimäki wrote:
> Document QFPROM compatible for MSM8226.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---

Applied thanks,

--srini
>   Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> index 2173fe82317d..0baf7819ab46 100644
> --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> @@ -20,6 +20,7 @@ properties:
>             - qcom,apq8084-qfprom
>             - qcom,ipq8064-qfprom
>             - qcom,ipq8074-qfprom
> +          - qcom,msm8226-qfprom
>             - qcom,msm8916-qfprom
>             - qcom,msm8974-qfprom
>             - qcom,msm8976-qfprom
