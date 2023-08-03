Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8DB76EC7A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjHCO11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjHCO10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:27:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD02F5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:27:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c10ba30afso466064466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691072843; x=1691677643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbQfNecOkQKqfj8owcZIJmrIWpzf3fVGEB2RAsnZvXo=;
        b=Vt6sayz3PfRfpZfRobgXRCWaGHBMOqrpkpgLFgjYod/R2acQZuB0azEx+kaae4vLUn
         C1K0+JYc4ACYK7eu/MXCWUwyQtphOTPdzLQFzJ5jw29fL73yWFbPJ7Z01x+34HUtrc84
         ULT+CC3gX2esWT2kJfNGgJMHdZyCqCezlLA0cqnh82cZy0FpORJerAsbN0Cx9iI7F9iP
         aICFTpX2cO4NJB3b8K2PTMYu9POJxreO+9FTKiYKQTYmgV7v4T6r5G97P0g75FMqgSIj
         8DtX2icz/3bvUzzqCYk7uV4IPRUT3WnbHlisUda3kLvuCdt0pRroFh6GwknpHG74wX8p
         l4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691072843; x=1691677643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbQfNecOkQKqfj8owcZIJmrIWpzf3fVGEB2RAsnZvXo=;
        b=d35XOWeNQ/N5hBEE2UmOfI7MU86E4ENpg4MB8vvgOqhyqJEzuVzdQdb8ONiTaIMrah
         hsBU+3eYx1n4k4MNXBSZb8FVTvfWzM4UlKM/largRBMqAtm7ksG/H+sF82XVjUgebuaw
         0J0Z6X33jNC2ngC+pOCBRi38tzKRCzgnh+jPnnvCCOe0+VII7SGMYWjMPglv5VQiaSer
         2BMHyTHwVzDU34Os/+BDRx2r0Z0f+WInkiLrb81ENd9uaLFmYZG54gXoCjYAo5PMB7me
         5k9jp3wRKxcE4CegWgry8m6sGOfi/6RJy+/tHXUymYc4XXz7s7lr8s3k2R75WhCYp0Lo
         068w==
X-Gm-Message-State: ABy/qLb/lKTzHlZKgf0OZUhqCdBjCKDPLddKo+a6fLMtDcEvqW8giDhT
        0WOkXodsaING1ilCLKUheqWb0w==
X-Google-Smtp-Source: APBJJlGCDsZfN8FX81QWj0wYvM83MdJrGMaVp7p1XNbZiFyY3u34pb03l132S1VHTkCoJTJkcrnTLQ==
X-Received: by 2002:a17:907:1dcd:b0:994:5457:269e with SMTP id og13-20020a1709071dcd00b009945457269emr10870939ejc.0.1691072842866;
        Thu, 03 Aug 2023 07:27:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id q26-20020a1709060e5a00b00992b50fbbe9sm10576733eji.90.2023.08.03.07.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 07:27:22 -0700 (PDT)
Message-ID: <0bb37521-0ea8-b343-b801-d57ee17fde55@linaro.org>
Date:   Thu, 3 Aug 2023 16:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v1 1/6] dt-bindings: vendor-prefixes: Add BigTreeTech
Content-Language: en-US
To:     Martin Botka <martin@biqu3d.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230802220309.163804-1-martin@biqu3d.com>
 <32C9B4A9A60647F1+20230802220309.163804-2-martin@biqu3d.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <32C9B4A9A60647F1+20230802220309.163804-2-martin@biqu3d.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 00:02, Martin Botka wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> BigTreeTech is a company based in Shenzhen that makes
> 3D printers and accessories.
> 
> Add prefix for it.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index af60bf1a6664..1d5f86e3f099 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -194,6 +194,8 @@ patternProperties:
>      description: Beckhoff Automation GmbH & Co. KG
>    "^bitmain,.*":
>      description: Bitmain Technologies
> +  "^bigtreetech,.*":

Please keep alphabetical order.

Best regards,
Krzysztof

