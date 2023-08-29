Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951AD78BFA2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjH2HuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjH2Htt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:49:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC406C2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:49:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso393964266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693295385; x=1693900185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBKYwwwaV8cRh5Erh2JbY8liVtcLQI9ggm+DBksrBGg=;
        b=cMcvMqp7jaDjMSNHoVnoDrQOIOKgUKX6gIXsapr6QJVghbnDffQe24TCi9r51GZ0lt
         0Oq80kExgNrupCMNVovjq2GcRlKHqASwmUxcrMPnXwwZI9Osxx41+yxM85Y+vnI63PTA
         PdbT093xQFUk1pixpm5sb9WTirDz9rzTT6MfwazdlgaVbM2kiBG5pWJE+WD8SZXpXson
         Xw5q8KweQf6YalCyI+glbFrA6LcBrzA/8JCsnSAsdDC4eT+fZW9DK4e0mRhchaqgpY5M
         11iQ8WPhD4snX4j8cdSDLi2sqCFDALDT86SukLSZjwtWoHoi6+WHAW4KT8PyyUxfuPyR
         KfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693295385; x=1693900185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBKYwwwaV8cRh5Erh2JbY8liVtcLQI9ggm+DBksrBGg=;
        b=fc2jkbUMOlRjRPPShbtwpDbdo/JriR7a50xYTYo8NET8ACtmFGP+mL7wKEbmUFDD7u
         NQuwla8ZOXOp55VEIxzMn6mr5dhsz5IFjRgk75yPm7vURfnH15eHdCyeRtqpEr8mLs8+
         PrC7AyYkB2P1s/iGNtDjX7n0zVK9tq6+NyKKTzMDrbkaNs+rVdKVPAp+fmLyjsD86cyD
         YO8Jobi0S1JyDmeB3TNmbMDEP5RVOZrq/jFDHKYDrCsdogFTEeZo1S9YXFCq6zkLxWha
         Ef9gaJWdXGGcmYG7KSr0I0+N/FJIuDpilIhg5d5eIPp0Icjm7DmwmHyCGCVLkDXad3rh
         M6rQ==
X-Gm-Message-State: AOJu0YwcCALpHa2toaUGZEaObGhNm1CNPNuv5l3yz9cjCvRqyeHiZSKi
        da6NmiXj6sHVrLf+g1RUMwSOmw==
X-Google-Smtp-Source: AGHT+IG2cTz2vabx5GreIaQ1PnVSCZiAxiM8h/wP6ramkRLTgf2Fzb7Ob8c10rlKPj8Le7ZFbM4pOQ==
X-Received: by 2002:a17:907:1dc7:b0:9a5:c7a6:1549 with SMTP id og7-20020a1709071dc700b009a5c7a61549mr1143306ejc.39.1693295385355;
        Tue, 29 Aug 2023 00:49:45 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id mh2-20020a170906eb8200b0099b76c3041csm5586721ejb.7.2023.08.29.00.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 00:49:44 -0700 (PDT)
Message-ID: <6d9423d4-0402-bdf5-b8d1-fed5982a6855@linaro.org>
Date:   Tue, 29 Aug 2023 09:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/3] dt-bindings: phy: phy-imx8-pcie: Add binding for
 different usecases of i.MX8QM PCIe PHYs
Content-Language: en-US
To:     Richard Zhu <hongxing.zhu@nxp.com>, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        l.stach@pengutronix.de, a.fatoum@pengutronix.de,
        u.kleine-koenig@pengutronix.de
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
References: <1693291534-32092-1-git-send-email-hongxing.zhu@nxp.com>
 <1693291534-32092-3-git-send-email-hongxing.zhu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1693291534-32092-3-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 08:45, Richard Zhu wrote:
> Add binding for different usecases of i.MX8QM PCIe PHYs.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

This patch does not make sense on its own. Otherwise your previous patch
has invalid path.

> ---
>  include/dt-bindings/phy/phy-imx8-pcie.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/dt-bindings/phy/phy-imx8-pcie.h b/include/dt-bindings/phy/phy-imx8-pcie.h
> index 8bbe2d6538d8..c8425c172118 100644
> --- a/include/dt-bindings/phy/phy-imx8-pcie.h
> +++ b/include/dt-bindings/phy/phy-imx8-pcie.h
> @@ -11,4 +11,11 @@
>  #define IMX8_PCIE_REFCLK_PAD_INPUT	1
>  #define IMX8_PCIE_REFCLK_PAD_OUTPUT	2
>  
> +/*
> + * Different usecases of i.MX8QM HSIO(High Speed IO) module.
> + */
> +#define	PCIEAX2SATA		1
> +#define	PCIEAX1PCIEBX1SATA	2
> +#define	PCIEAX2PCIEBX1		3

Drop indentation. Look at the define few lines above and compare.

Anyway, this is neither explained nor looking like hardware property.
Nothing in the commit msg or in doc here justifies these constants. Drop
and use existing properties.


Best regards,
Krzysztof

