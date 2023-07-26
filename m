Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130E4762EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjGZHuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjGZHs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:48:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A305584
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:44:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9891c73e0fbso148831566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357448; x=1690962248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+595fqyQAtRGgWRPqauKidMABLj6m7NIPfITqXstJro=;
        b=wjoE3XSL03eoZZffQ7rPfct487FsvJfaQvHALV+vKNU5oBLR16q7wsqJ9eeWTmxjmP
         n1TQ5Z+1yfGu3Fj6amjW4ZnJ56t+6hr0exOgvpQ5lVVPOPMnFyYNSQ/HsWPolfNQhby7
         MXIVDIH+/HRfYLG1xagrVHKpbNYbGrm51grgLwitznxalYMyXzGv6EcQtBbPbZPNmiRn
         aAUVW1FgJ/lUag1rDjYbHFfjCCgNvCQx+68t1tdH/nW51vvlY+PhF3oq6MP46ACmVLKx
         RxZkIHedul7BB9oCGYd5CICwkYCNBgIh3O2DlTl18zeAoHdW+HrRQ4V6Oaf47U98qN4j
         7IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357448; x=1690962248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+595fqyQAtRGgWRPqauKidMABLj6m7NIPfITqXstJro=;
        b=ibM8n+dsF9hTCXKZ+i+kSkFWEcV8CoJ82oViqifIcTrvCDvO3wpfVjDAPi0CMsduG3
         RQLWTEEEZFRcWN+3EecnmL9v5iJ3HjfaQUJogHxJTxM6t3TEEJJzvC/DujjAwNAsPStZ
         2Ii/Num3iR7Qg/Gat42lNgcMTy7PPjdEycAMl1akgFu4VsjWoJIpGbdVu/+UJGTqxLZh
         aJ9yO1HYJDzx596I7JHKyNnlr+nvJF/0nryMaJB8NEmjk3SyxgW3ZidPyYoVOf7sY4Ro
         EnwHpFA9yoExrcIwCPRtNVa/Y1ivyuUy1u5PKFNX98ZXVYuCbRZW2hBsYNC9Y3Q5JjPj
         889w==
X-Gm-Message-State: ABy/qLYlRn3FczetX5IjUOjVMEhyhVdXXO6QfUvltGST+u20beirnAev
        jDK8AIvbYUNYT3Yhby+ow1jcVg==
X-Google-Smtp-Source: APBJJlGgyHZAbdoBRwxptIi49+tg1Kmb9zJa/z48MBZTdGhcFMw901PUOm74U9JCdsDuawdcBg308A==
X-Received: by 2002:a17:907:980c:b0:99b:4b6d:f2bf with SMTP id ji12-20020a170907980c00b0099b4b6df2bfmr4774442ejc.10.1690357447804;
        Wed, 26 Jul 2023 00:44:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id kd8-20020a17090798c800b0099bccb03eadsm115198ejc.205.2023.07.26.00.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 00:44:07 -0700 (PDT)
Message-ID: <65ea6b51-a314-48bf-df4c-2508ba1eb91b@linaro.org>
Date:   Wed, 26 Jul 2023 09:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: power: fsl,scu-pd: separate out fsl,scu-pd
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20230725102900.225262-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725102900.225262-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 12:29, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add an entry dedicated for fsl,scu-pd which could serve i.MX8DXL
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/power/fsl,scu-pd.yaml         | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
> index 407b7cfec783..3a92e4fef7ae 100644
> --- a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
> +++ b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
> @@ -18,11 +18,14 @@ allOf:
>  
>  properties:
>    compatible:
> -    items:
> +    oneOf:
>        - enum:
> -          - fsl,imx8qm-scu-pd
> -          - fsl,imx8qxp-scu-pd
> -      - const: fsl,scu-pd
> +          - fsl,scu-pd

No, sorry, you got in the past comments about style of compatibles.



Best regards,
Krzysztof

