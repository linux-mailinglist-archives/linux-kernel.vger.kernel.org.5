Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFA1781FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 22:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjHTUdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 16:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjHTUdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 16:33:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E404A1A5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 13:32:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so3961212e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 13:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692563540; x=1693168340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZxBeLwRDLKLAdBdsYAHXWMJXrTZi5pLoEbnjRzYS4E=;
        b=EBd76ZBDi/sJ+0hGN8EQmzSDo4YJyPtakXUx8wshf1mosdbVpUCDEIMURO7yt9HLO/
         WiO9ri1/Xe2RX++ugvn9fhzOjOhW1lMMvQkZfvW2hbT1bac4pAx2lFs0YmIxYZsE7NjR
         tMVlIv9Yr4HIjzY/wGDheAMtmz01iIc3LmS1Ozw1yoefJqbFj4oHrUK51B1JxDb216IB
         Ws6gUBVBEqVmBL5yqEwqaaN6ZnBlhiG1vZu7d5fveD5W5BrFFin4gVdWxac/XrcdM5TP
         JVe9mm5/daSHRWKwiFqewbDZRZFJZcLEShX/gPijbHxJqPmbGMMy2UYKCRFdjMoMzzRz
         IgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692563540; x=1693168340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZxBeLwRDLKLAdBdsYAHXWMJXrTZi5pLoEbnjRzYS4E=;
        b=lhoGPVF4L7WvForb5hRqfKbopHK4Y1mxUdxUHnBf+P2IOipr/9SV5QS/IusU7hQwwh
         Fj/a0R2EB63o5WnPlOTui6ZDWifL+g77l+LURIk0IqWyWryqmwLKBknSp3S8+IzBVC8g
         xVRRb1LENL515OTkLQJakAIOSKzr9FfbeZgypgac+dIXW6r3xycKrM8rEzEOIJjJiKro
         FfDtkKHSLV0+twrKJFmG5KFfQ8CFtxVwm2dQtfoRoatSVZwZ1wseuGj0MzGNxk4ZzMMi
         7TM5oHaNT/ErGazCxfCLZ2kylL9ZIfNAfFBEYDL1/RljLdnqe5snMPtTlEjEX4ecXNQ7
         NLGA==
X-Gm-Message-State: AOJu0YyqTrCRaUEGCIdjynNVqNqq91IATVGipi6GbdL22Pzh8D4Oyu7+
        5P39utY+vJIZWAQeRjqXCgYwKg==
X-Google-Smtp-Source: AGHT+IHc+KIlPROAh1yE20iteSRYjcUQXrs0OvVtxTfoLJCAI1Cr/o8PJizOqvstNyNzlNZK438+fQ==
X-Received: by 2002:a2e:3802:0:b0:2b6:decf:5cbd with SMTP id f2-20020a2e3802000000b002b6decf5cbdmr3339728lja.36.1692563539609;
        Sun, 20 Aug 2023 13:32:19 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id ga10-20020a170906b84a00b00992b2c55c67sm5198948ejb.156.2023.08.20.13.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 13:32:19 -0700 (PDT)
Message-ID: <f5b16676-04b9-7864-ffa7-1c48f3c2ca9c@linaro.org>
Date:   Sun, 20 Aug 2023 22:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: fsl_easrc: Add support for
 imx8mp-easrc
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230820175655.206723-1-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230820175655.206723-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2023 19:56, Adam Ford wrote:
> The i.MX8MP appears to have the same easrc support as the Nano, so
> add imx8mp as an option with a fallback to imx8mn.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> index bdde68a1059c..2d53b3b10f2c 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> @@ -14,7 +14,11 @@ properties:
>      pattern: "^easrc@.*"
>  
>    compatible:
> -    const: fsl,imx8mn-easrc
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx8mp-easrc
> +          - const: fsl,imx8mn-easrc

You need here also const for fsl,imx8mn-easrc, otherwise you do not
allow it alone. Test it for fsl,imx8mn-easrc DTS - you will notice warnings.

Best regards,
Krzysztof

