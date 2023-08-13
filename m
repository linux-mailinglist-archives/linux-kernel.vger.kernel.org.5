Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EBA77A78B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjHMPgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjHMPgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:36:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EDAE5F;
        Sun, 13 Aug 2023 08:36:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31965c94001so1378132f8f.3;
        Sun, 13 Aug 2023 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691940983; x=1692545783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HmyT9viofQwFO46Ag0TcEyc/eSeZtVKY9Vgh1cnGEs=;
        b=asGfA/zadH3EzscS9pqL8hD9PkPJ4/WZnKGgBg0rVwo4UdOWRev46I9/CnAf6guzUf
         NW0XrD20NpxsstWqh4FekZXXReMmJQmc8rJnDKIWFMoKqPredd7AGIyzbhcBoBiPKlUc
         ZVZht/Elip16apR/VnS6qQLpvWYfML4xwHVlMYINasLxg0tw75NB0BYV4dEv4OX02bi3
         oW5Y1EgGUSr6JM8t/WAmbTofAVVVivJbSyMWFCSCYRf9SypRLlhPBudbAOHedSZuOucF
         3gtv2bkpHr6c/qVEQwsASu22PrIUZEVvhGlEIFUa94hmgNRRvf1vQA38gSTPnkEjKuV8
         JLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691940983; x=1692545783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HmyT9viofQwFO46Ag0TcEyc/eSeZtVKY9Vgh1cnGEs=;
        b=ZIRsG8wtdkMNk/PoUdzL6pY98CKceMuU8j+To/dZtM6qRML4UKlGKtZZVneH8MMgcO
         udVZzg7sU2e0BCFccPalxeU1DYxpNNxK4tbHLCKu8krVBuiS1sOpUu66L0bMd6fyir+v
         XVUsHZYRqR4QizRBFks0SkDui8KiIO/yML1CAgJlVBmNZw6JHobhtZfLbz8T6F0ZsL7n
         A4QPYQ0d5PsgtNpxy1wwFNPlTgIZD74QH43cX6jtuPpEeF0eH+V2cA8kRMVzb7aDEUAW
         dvcRdN9zWIiAGLpD4Z/RkEieeNfv5ruw/227/zZe2FOtS01HuTFv0tkkE3qXBuo7Vd1V
         EP5Q==
X-Gm-Message-State: AOJu0YzvqISm2gxmrspPmT6L3XyYFBIoLXbLi6zaepPvikbKX4eVhmGZ
        Z/Zo86bRynE+/fe+0fTSnj1bse5lnNv9Bw==
X-Google-Smtp-Source: AGHT+IE9qkC2Ej8imYc6src4+3L/KGU0/FB4hp4AxhdHUalCY46flCcIBsPMWdx2pp/wNCgM4p9F0g==
X-Received: by 2002:a5d:42d2:0:b0:317:52d2:d05f with SMTP id t18-20020a5d42d2000000b0031752d2d05fmr5663858wrr.26.1691940982982;
        Sun, 13 Aug 2023 08:36:22 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id w17-20020adff9d1000000b00313f61889ecsm11645608wrr.66.2023.08.13.08.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 08:36:22 -0700 (PDT)
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
        Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: vendor-prefixes: Add BigTreeTech
Date:   Sun, 13 Aug 2023 17:36:20 +0200
Message-ID: <2291546.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <EB8B7A5FD2D8E12A+20230807145349.2220490-2-martin@biqu3d.com>
References: <20230807145349.2220490-1-martin@biqu3d.com>
 <EB8B7A5FD2D8E12A+20230807145349.2220490-2-martin@biqu3d.com>
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

Dne ponedeljek, 07. avgust 2023 ob 16:53:21 CEST je Martin Botka napisal(a):
> From: Martin Botka <martin.botka@somainline.org>
> 
> BigTreeTech is a company based in Shenzhen that makes
> 3D printers and accessories.
> 
> Add prefix for it.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> Changes in V2:
>     - Fix alphabetical order
> Changes in V3,V4: none
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> b/Documentation/devicetree/bindings/vendor-prefixes.yaml index
> af60bf1a6664..a1f3bb7be860 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -192,6 +192,8 @@ patternProperties:
>      description: BeagleBoard.org Foundation
>    "^bhf,.*":
>      description: Beckhoff Automation GmbH & Co. KG
> +  "^bigtreetech,.*":
> +    description: Shenzhen BigTree Tech Co., LTD
>    "^bitmain,.*":
>      description: Bitmain Technologies
>    "^blutek,.*":




