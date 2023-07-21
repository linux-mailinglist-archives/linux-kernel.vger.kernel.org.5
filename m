Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C7B75C3D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjGUJ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjGUJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:58:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8DAF0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:58:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98df3dea907so274025366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689933499; x=1690538299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+H/k5vHvj8kcG6LcXyR42Y2m5hHpp/nIIH32ljRbCvM=;
        b=eDXCCirEYEqCGTOW1dVNgCDtmY1vO9G2nB1a46dLQxQxo3oEmkJVEvn3h5sKlS9yO1
         GcBa7JiEf0a47Dy/gNbwJ7ZffXfbiMn8zfjtr3I3x4LBY1ZjEXpfZHcZDYJL0jju32qj
         vo58gFqw7F1YoqvqAKz2RHYBuYlXGsmOayqKzQr6R+H9IBFozzWGlacG72HOin3y8UH2
         hz2IWuPZ1m46i8hZST3QHSQyJETaMSscTOkOtQaBNFg2IRvL9swXaSlF4k8KDrunHhj6
         UbYusCdQmrbOqnsAOZDyv+6uE0YbmkKzJUG6a6bIswT5pb68l69SfBdn9CnXFnBZGB2l
         Ht/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689933499; x=1690538299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+H/k5vHvj8kcG6LcXyR42Y2m5hHpp/nIIH32ljRbCvM=;
        b=Ct7o2/T9bmdaEToIEufS4ISGag74oI2XAz16gfNhy0sGlkhDZMX6Ma/JgmXxfCjXFB
         RLKvQ5D8q8C6Ww2dt9q2mHFS80JHLl8/JhW/gxDCHknZx8UPbxii1nQZvwM1cyqZLx3m
         s4e/qoxQbI1Gd7+DLwgeOoeFlZ5Z3y8kxW3rfvhqMBa81RMFrkJUFjKyp49JH3vG4qd7
         u8Aer6ZNaoYr9JaLh5aVd9KedCKKe4RyZDI8hwze5dVSixzv9dkK7EXSanlzF4pqBe19
         JHzbHAVy9q0NjCAgz/obmWl/SjZu+ZNxCM1wBmEF/ek94egruBLKHw7l0gh0/RABp5LW
         6loA==
X-Gm-Message-State: ABy/qLagzuS/qHThiYyKTcmCGkydlTu//JWkBvVBosIKwn5U2MQrDpOZ
        3v3aUyNjZc3CdpBp5XE+tboBDQ==
X-Google-Smtp-Source: APBJJlG21+znlFjc40LwxV6FBJsq9EH4uHRAof0jfxe+7/+XkPzWFKkhhvWgwgKv47Xbs+ewzBBCEA==
X-Received: by 2002:a17:906:5a6f:b0:970:c9f:2db6 with SMTP id my47-20020a1709065a6f00b009700c9f2db6mr1226126ejc.63.1689933499625;
        Fri, 21 Jul 2023 02:58:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id qc12-20020a170906d8ac00b0098866a94f14sm1933968ejb.125.2023.07.21.02.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 02:58:19 -0700 (PDT)
Message-ID: <5dd12391-3f67-043e-9dab-19e8d556cb86@linaro.org>
Date:   Fri, 21 Jul 2023 11:58:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/4] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230721095003.3681484-1-james.hilliard1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721095003.3681484-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 11:49, James Hilliard wrote:
> Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 2510eaa8906d..da486c4a4ecf 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -385,6 +385,11 @@ properties:
>            - const: toradex,apalis_imx6q
>            - const: fsl,imx6q
>  
> +      - description: i.MX6Q Variscite VAR-SOM-MX6 Boards
> +        items:
> +          - const: variscite,var-som-imx6q

Again, this cannot be on its own. This commit does not make sense on its
own.

Best regards,
Krzysztof

