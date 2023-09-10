Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796F7799D69
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 11:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343740AbjIJJJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 05:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjIJJJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 05:09:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE491CC5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 02:09:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so9714714a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694336978; x=1694941778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4YUMVbAN13zpaZAGFCDLaoN91mtJ2lE9r8ZViQLkdw=;
        b=inLEo1pg6tPx48iaCemSMU3ziGwWgJ59XeDxh3BVV3x+bmWMtSj2I2MzFysfUwyMza
         l0PuSrY2xDh9GixpBAqMO1ORZuNGa7hyP2Vd0voUcNATXgQ9Yw2I/u9GEqdNLtsOdZNd
         VeK4Hf0WwrlAqCsrQBV1NyPqbQWAUqwyHOCtnRleuqaPl3rxwNJYpjWHVU9wkoeI9tU/
         lzZlrmWm4Rg+IIAcTI2ceT8TuJPVDZbnTLzlTxupsuXFpKDex6HOXXCvIJYiOcpJD6xZ
         k6Y8r+6OtLgqvObwPqaYIWXzbBJDpMQIUvaPfr+gfGGr1I0Ql/sRhJdTni4E59IQiwzO
         t05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694336978; x=1694941778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4YUMVbAN13zpaZAGFCDLaoN91mtJ2lE9r8ZViQLkdw=;
        b=U2WlG0uIrETZr1PNU0ERbODvYU3pBviK3b8KMw1AF7c3t/lab258DTGvYhCrBA369D
         9z7h+zQyJA6f3ijoyoCvhGkwRviQ+vHuZbaOla6I3ju2848BWT2m2f26zxCEC9rIYhFY
         Eyw8ku8rlU7XLSAcZlGq28Yiaf50CCEJ8N7z8HEi0SS4IcDoMNRrNDYTDAvPg2YebyMM
         j9RdQbkRBncENnmoU4WI6k+Wwv24t5G1VOJMDx5WyqaPQ2rC0P71nx8OqGocePkqoUhN
         ZgERNXNPd3RC2CxP2byy3FFP+gEDdFYXPS/TDXoDdEgrWSDzCIq7N15N/ALUKFk/jGRI
         JZCw==
X-Gm-Message-State: AOJu0YxM7hmQPcYVTq/hrkty/GyvPuILz2Vm3nAaIt8So2XHxWCEZ1Eg
        iGU9aUEo4CvrD7iK1HiX8c6cYQ==
X-Google-Smtp-Source: AGHT+IGvOqtyZxH1eotD7XBo6uaExFnUdODBgoQCOSDBpJTGPQZ4tRxNF4mNV3heGAAC4nTzUBWM+g==
X-Received: by 2002:a17:907:7295:b0:9a5:b66a:436d with SMTP id dt21-20020a170907729500b009a5b66a436dmr13524162ejc.14.1694336978017;
        Sun, 10 Sep 2023 02:09:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id lf28-20020a170907175c00b0099bcf1c07c6sm3541516ejc.138.2023.09.10.02.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 02:09:37 -0700 (PDT)
Message-ID: <f8864242-daa1-e72f-4759-aac3fa1bbcf2@linaro.org>
Date:   Sun, 10 Sep 2023 11:09:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: arm64: dts: mediatek: add description for
 mt8365-evk board
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230910062852.15415-1-macpaul.lin@mediatek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230910062852.15415-1-macpaul.lin@mediatek.com>
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

On 10/09/2023 08:28, Macpaul Lin wrote:
> Fix the missing description for Mediatek mt8365-evk board.
> 
> Fixes: 4f5fc078ac6f ("dt-bindings: arm64: dts: mediatek: Add mt8365-evk board")

There is no bug here. Drop.

> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index c2935e99626b..3ce39a346fb1 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -248,7 +248,8 @@ properties:
>            - enum:
>                - mediatek,mt8183-pumpkin
>            - const: mediatek,mt8183
> -      - items:
> +      - description: MediaTek Genio 350 Boards (Genio 350 EVK)

That's a bit confusing. So all of the boards here will be Genio 350 EVK?
I don't get what is the point of this description.


> +        items:
>            - enum:
>                - mediatek,mt8365-evk
>            - const: mediatek,mt8365

Best regards,
Krzysztof

