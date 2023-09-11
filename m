Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8601C79B248
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355855AbjIKWCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbjIKJlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:41:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A78102
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:41:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so5107501a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694425275; x=1695030075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Rdq0URinpTcu5sLen+gjO6hyEzWhm5ftrWrOcMBRpM=;
        b=lMIIa9V5rOMkhv2xupJwO/N4bwoe1QJhGloH0O5tDgH1na4Di3FxyXw7V91OuRwXiH
         O+NgOkn2YEdI6UEh8A60w43Ue5AP4/roHZrp01/xW/RsEy00Vs9cQjZ3k9KDjf+nIubs
         /3ESNtehObRKkCMR3HO0B7O5x9JWYK9pegj2Eo+9c3krnV57u65Zd4GSPYdZCTDMoP8K
         pQgaUw1Io9kDfQcsZZAlvt6nAt6c+dzgsQ0RNj7FJhJDnEavMmxkc8qrowk467F2aN+1
         6EOZy+FWZHtaS09J7qBryTT5KB80WvHEMyJigQOPnbG9zGpKmDrJvkbOTGOqBp/SrnQW
         whTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425275; x=1695030075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Rdq0URinpTcu5sLen+gjO6hyEzWhm5ftrWrOcMBRpM=;
        b=bGWSV637yIBkBT0r9FnGDhMAd/3ehZmNF6UZ0Wywl4h+kVG3QAMs0wpSmdvAAEOku6
         C1G2WLTb5PVUzMWvGfAFPh7nPPPVdO/vJ0P2DSmJBs3M7JxkLnVkQA5X5rsU/Mc/B/d/
         vgPorDN6mB+vgfjTCCFfJEpes666Q/llazSZw3KzFKtj+OO7U6GPSE8gmrMxiRTlSn0w
         bE2HjJ2PIXc+1G9kmITUmtLVE4hPikhsBIMGCC5oIv4bk+ynYHUL+9KUQ28ejtBk1xlr
         9eFcS1ouB6KIzG6bEohO8FeaLKrpQ2ulZ+CltWspH3+IOq+CAKNgqvxrZXLQWk/GwA68
         kKYw==
X-Gm-Message-State: AOJu0YzblgNyWbYDHarQiSaA6K4jKDxYKTEluWBS5XHYDH5bA4CMhBgi
        Txnxg7BoShT8DFAGiaui1ELI2Q==
X-Google-Smtp-Source: AGHT+IGhnpDY+O7Wu+c7whPNnupCcBmcZnCuU7k3WX1FcCTde0t4ZKRKDDZbCWg2Yu2id6JclD98fw==
X-Received: by 2002:a17:906:1019:b0:9a2:96d2:b1e6 with SMTP id 25-20020a170906101900b009a296d2b1e6mr7687841ejm.75.1694425275244;
        Mon, 11 Sep 2023 02:41:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709064f0e00b0099e05fb8f95sm5089570eju.137.2023.09.11.02.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 02:41:14 -0700 (PDT)
Message-ID: <e22e61e7-02b1-8127-888d-e470838f4a18@linaro.org>
Date:   Mon, 11 Sep 2023 11:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 8/8] dt-bindings: display: panel: add Fascontek
 FS035VG158 panel
To:     John Watts <contact@jookia.org>, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911090206.3121440-1-contact@jookia.org>
 <20230911090206.3121440-9-contact@jookia.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230911090206.3121440-9-contact@jookia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 11:02, John Watts wrote:
> This is a small 3.5" 640x480 IPS LCD panel.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---

Thank you for your patch. There is something to discuss/improve.

> +maintainers:
> +  - John Watts <contact@jookia.org>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: fascontek,fs035vg158
> +
> +  backlight: true
> +  port: true
> +  power-supply: true
> +  reg: true
> +  reset-gpios: true

Why do you need all these 5? They are allowed by panel-common.

> +
> +  spi-3wire: true
> +
> +required:
> +  - compatible

Missing reg. Probably also port.


> +  - power-supply
> +  - reset-gpios
> +


Best regards,
Krzysztof

