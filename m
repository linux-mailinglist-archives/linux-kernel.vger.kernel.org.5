Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155A578CA0F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbjH2Q7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbjH2Q7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:59:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B601B1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:59:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so4110966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693328361; x=1693933161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6E5l4p6ydZ17uXkOlyCd2QIGqtq2GGVNLb4d/oALZo=;
        b=JMUuiO+ZCLJLovk6Y59tj6Acf9rsWss72UnnptnwbQuIuzodaLLnZlutttVRuFPcKV
         Obm7Pcj+2gvk2p4iA6NE/WQMuJReTPho8f6lC+sVdu0ZTGZkdTyINlQyYuAsjQbYVqf0
         g4xG9HASpNHS+cBPRfYJwEMenckWpPpTu4Si1+hucPgEaQbDM2rdkR1RNoEaGtvPdWlu
         rB9dccYdoGE+/YFHEtaNMO1KMV73bqlFb56YVXSK7O21oCkL2+BhLb3Svnt/frLlYsmW
         8sy73yfSLLb0Jni+BLEPJvsgCfrgX3OZfOdMevOwg6HZkxKDsqqctzGVRjlVT/MaumZV
         lyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693328361; x=1693933161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6E5l4p6ydZ17uXkOlyCd2QIGqtq2GGVNLb4d/oALZo=;
        b=TRP+FVoQ/APQa+C5NuVPGgRahb/fAmBoZDtTD/toFZk0ReayJJT0i10rUf+OVbZAVk
         xKKUQ3kB5/kR5pbQSBdhSS07Z9bxCDfw/roYt1Ypf4/m0+4BpG9uFwvDI2Ns9Al/Ywyy
         HsvWmcd33TRD3gCHrOrn/n1c9riTi8+nB1hICCD4NtDIk6uxGjNxcAlW9BCFKKf8cUYf
         tZ8beaLTmX8FLPfmjGH1Rei9UxRlbzfB9On7XgPu9LsQroCKnlw5lB2/aCn+zdt4+NWb
         AnCmHvd/X1j4Z3XVVm7JvEfqwqwbwiWLppEAcDmCusrPCeFnvzP0Bz42oGl0GBUUgFbb
         dxJA==
X-Gm-Message-State: AOJu0YwMLzhpRhZ8gAIk+C/O0slIePMssJHR9uvjWSP7Ymy+2gYI/DG8
        g2Ov77R+pwZri+LQuipQrTO4KA==
X-Google-Smtp-Source: AGHT+IGIj1KMlvwfJomohXDcL38Ci6Rl4M8OBPVW4F6QPISXVlVOBW578qDmgi5s5HINQQI8mCkvfw==
X-Received: by 2002:a17:906:5d16:b0:9a1:ee8c:7f3b with SMTP id g22-20020a1709065d1600b009a1ee8c7f3bmr3438544ejt.7.1693328360831;
        Tue, 29 Aug 2023 09:59:20 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id q4-20020a170906144400b00993860a6d37sm6130245ejc.40.2023.08.29.09.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 09:59:20 -0700 (PDT)
Message-ID: <61245ef4-3b96-67c9-fa75-5dc43c86b211@linaro.org>
Date:   Tue, 29 Aug 2023 18:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/9] dt-bindings: phy: qcom,uniphy: Add ipq5332 USB3 SS
 UNIPHY
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
 <20230829135818.2219438-5-quic_ipkumar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829135818.2219438-5-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 15:58, Praveenkumar I wrote:
> Add ipq5332 USB3 SS UNIPHY support.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
>  .../devicetree/bindings/phy/qcom,uniphy.yaml  | 117 +++++++++++++++++-
>  1 file changed, 114 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml b/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
> index cbe2cc820009..17ba661b3d9b 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
> @@ -19,21 +19,53 @@ properties:
>      enum:
>        - qcom,usb-ss-ipq4019-phy
>        - qcom,usb-hs-ipq4019-phy
> +      - qcom,ipq5332-usb-ssphy
>  
>    reg:
>      maxItems: 1
>  
> +  reg-names:
> +    items:
> +      - const: phy_base

Why do you need it?

> +
> +  clocks:
> +    maxItems: 3
> +
> +  clock-names:
> +    maxItems: 3
> +
> +  "#clock-cells":
> +    const: 0
> +
...
>  examples:
> @@ -55,3 +149,20 @@ examples:
>                 <&gcc USB2_HSPHY_S_ARES>;
>        reset-names = "por_rst", "srif_rst";
>      };
> +
> +  - |
> +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> +
> +    ssuniphy@4b0000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation



Best regards,
Krzysztof

