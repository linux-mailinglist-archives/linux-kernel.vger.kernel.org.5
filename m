Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12C177A78F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjHMPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjHMPiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:38:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D1E60;
        Sun, 13 Aug 2023 08:38:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso34896645e9.0;
        Sun, 13 Aug 2023 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691941082; x=1692545882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNmDOME263tbNnJDox2WuqRcHXZN+XqB+OMfOqpA9xQ=;
        b=WNqBOi4ZZC6V6xRgRLsfitnrUocDN44nmI2hwUzUaFeK2Ey4eCQ3XiKbzkPj+8IK+f
         Zc6QGbNAD3ZYzDXGt1BR/HDnQi0Z+205k54AX+n7M17nfRK54q3Q4m70bI0JWL4SnPPG
         sAQGDvFGjh0VhrcdkKsVw1l0PvHFscTPBEk/TRg29lw128Tg8y2cFzAjZcxB7b24kS2G
         AlPAn4LgKVWHKasQYODf1oyDyFku+7pnoGwibto1NqnoVpzDxHrQQwjP70B5R781EDg0
         z6X8UkWVyXrx/BF+H+MZGgPCvN4w35lD2Xdz29stgweKUhTAGvKgs1isa9pPzw3pabWL
         /yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691941082; x=1692545882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNmDOME263tbNnJDox2WuqRcHXZN+XqB+OMfOqpA9xQ=;
        b=EQaxhOCFUI6cSic39l9Bpwyf7BT/3RoXSxbiI0hLsMwMfIIky4cFoD6Vg69OJUGFb2
         nhUXTWjs6ESVVbRutLs6HbfBztN4cI8uG4aR2fmqzt7tSAavItU34e6MbomU9SOlRVEo
         j8Xx1/tnaIOMoHKyjY+F/H1V7iMsJQKO9CtBmwYfwsq+MwpdWscdu2Dvfm4Ns7ljzuIJ
         vg0vb98jAHWEVoFnXLeaVQXIN5fGHE0dHhKS4M0dq8E9FBCiO0whZB/ClVKhS3s7NcLn
         l3lgh9+D9o0N7bu4Broz0nlNX/EZiX/IdzwXDD1oB2IJpGOd20S/+WP/Za1c+rFyzm8g
         AfLA==
X-Gm-Message-State: AOJu0YwxhHHw/PEH3XMv5aJR4leF8lfoVwjtSK/zILI7qkVk8ixA04mX
        GPYMq5oAw0fo2ZWVooxb0qs=
X-Google-Smtp-Source: AGHT+IFR9Cvz4CIyUP1iq9gFAC2zyjVR2KXeCO2wabvTXPUPFUWnjVOzIYFmlO4lwwSjRS33Gmro6A==
X-Received: by 2002:a05:600c:3648:b0:3fd:29cf:20c5 with SMTP id y8-20020a05600c364800b003fd29cf20c5mr5963620wmq.7.1691941082325;
        Sun, 13 Aug 2023 08:38:02 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003fe17901fcdsm14472709wmg.32.2023.08.13.08.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 08:38:02 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Martin Botka <martin.botka1@gmail.com>,
        Martin Botka <martin@biqu3d.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Icenowy Zheng <uwu@icenowy.me>, Andrew Lunn <andrew@lunn.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: arm: sunxi: Add BigTreeTech boards
Date:   Sun, 13 Aug 2023 17:37:59 +0200
Message-ID: <1859280.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <309C7C26158AF852+20230807145349.2220490-3-martin@biqu3d.com>
References: <20230807145349.2220490-1-martin@biqu3d.com>
 <309C7C26158AF852+20230807145349.2220490-3-martin@biqu3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 07. avgust 2023 ob 16:53:22 CEST je Martin Botka napisal(a):
> From: Martin Botka <martin.botka@somainline.org>
> 
> Add name & compatible for BigTreeTech Manta boards and
> BigTreeTech Pi
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> Changes in V2:
>     - Remove CB1 SoM as its own entry
>     - Squash BTT Pi and manta patches into 1
> Changes in V3,V4: none
> 
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml
> b/Documentation/devicetree/bindings/arm/sunxi.yaml index
> ee8fdd2da869..b90d2a7dbe2d 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -151,6 +151,17 @@ properties:
>            - const: roofull,beelink-x2
>            - const: allwinner,sun8i-h3
> 
> +      - description: BigTreeTech Manta M4/8P
> +        items:
> +          - const: bigtreetech,cb1-manta
> +          - const: bigtreetech,cb1
> +          - const: allwinner,sun50i-h616
> +
> +      - description: BigTreeTech Pi
> +        items:
> +          - const: bigtreetech,pi
> +          - const: allwinner,sun50i-h616
> +
>        - description: Chuwi V7 CW0825
>          items:
>            - const: chuwi,v7-cw0825




