Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039C077B2CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjHNHnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjHNHnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:43:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49D510CE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:43:06 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe5695b180so36076055e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691998985; x=1692603785;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNbusZAKPFV3rbWegqKtvAQOoo6Bco8yrRT+3DqnBWo=;
        b=Gtluigu6V6DUfzP4Zxx+EEaIuQeJ3twguOUtjf99R/Cm7Slt2tyuCy2gbzNEo6oj3x
         i49h1LRBhIxR2tmavaIm5/pf29qZNfsM7eB0fGtwnwVRbV8YkJEff93y6dmnpcOzDsrV
         3WXBwrUEhdgwNfw5dwdDf9AG8XP77J7h0TL8rNUy87QwlSl7WKltzUednUlIMCekkt5e
         MFvPF1a8KcidBhLNuFYkB1zUt1BRClFpwdpe4r2mKNwtG8sWBAVaYGZKU02lZIPZ3JtC
         qwLyLjS9VoDGXNm40rT3aFs9dJGAem8gmsBVg4f5/WFz1B6cZmiVBgK/tBK+o4iuoPIq
         2qDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691998985; x=1692603785;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNbusZAKPFV3rbWegqKtvAQOoo6Bco8yrRT+3DqnBWo=;
        b=YCxRFi3xpSFhSZpJvYClIVT/ZY7nm3Wfp7nZy7Eb3yYKVizrR52Q08IWlHlp7ltyI2
         ugeY+XCOFg8qa5rZhbAqmGg7q905jXGxCRC2ocM9EPPKLt8v+mxDoO2rfLMe9GwkcAQJ
         nfYkaChvfE3+YVspZnWASJcU6Q/1PDyVVq3NoR3XAuiLNCBLlFODp7989ZzCZhd7e85N
         MQtx+0PU3BPXQ50B6TcZCdbDpnnosPCwjNlBzZj75Rx5yKdwUTKXL6yAqlKgJoG6PEck
         THc2/EHJTnqJ2YmS+1Aiu2PorILQjANCUfChQt6KqR1UW4yyyVeuqK/vXV/bW/EF6QEq
         WgkQ==
X-Gm-Message-State: AOJu0Yw08l2Ug/6TrpUNYOSn4izPdEvZMD5dwbQQo2chJN674iWQqlhF
        jDtexJspqy3O5LjIdXYuuNYClg==
X-Google-Smtp-Source: AGHT+IFXVn5VDLa4xeIUtvU8D0A1UXQoOEz1Dg7uXx/qsHPf6prWfHoXifNeFnZfnlx5ZeLaT8xk8w==
X-Received: by 2002:a7b:cb88:0:b0:3fe:24cc:ecfc with SMTP id m8-20020a7bcb88000000b003fe24ccecfcmr6428522wmi.21.1691998985150;
        Mon, 14 Aug 2023 00:43:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0? ([2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003fbb346279dsm13545121wmr.38.2023.08.14.00.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 00:43:04 -0700 (PDT)
Message-ID: <13491021-d849-da84-f1a2-a94401118de6@linaro.org>
Date:   Mon, 14 Aug 2023 09:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH net-next] phy: amlogic: meson-g12a-usb2: fix
 Wvoid-pointer-to-enum-cast warning
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>
References: <20230810091310.70231-1-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230810091310.70231-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 11:13, Krzysztof Kozlowski wrote:
> 'soc_id' is an enum, thus cast of pointer on 64-bit compile test with
> W=1 causes:
> 
>    phy-meson-g12a-usb2.c:322:17: error: cast to smaller integer type 'enum meson_soc_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/phy/amlogic/phy-meson-g12a-usb2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> index a628c59e5cf0..0e0b5c00b676 100644
> --- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> @@ -319,7 +319,7 @@ static int phy_meson_g12a_usb2_probe(struct platform_device *pdev)
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
> -	priv->soc_id = (enum meson_soc_id)of_device_get_match_data(&pdev->dev);
> +	priv->soc_id = (uintptr_t)of_device_get_match_data(&pdev->dev);
>   
>   	priv->regmap = devm_regmap_init_mmio(dev, base,
>   					     &phy_meson_g12a_usb2_regmap_conf);

I believe the net-next is wrong here, but whatever:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
