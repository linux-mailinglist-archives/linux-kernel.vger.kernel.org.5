Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54CA7D5C64
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344341AbjJXUaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbjJXUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:30:15 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699DA109;
        Tue, 24 Oct 2023 13:30:13 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1dceb2b8823so86583fac.1;
        Tue, 24 Oct 2023 13:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698179412; x=1698784212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3qsgjZUiGkI+HnQU8qd10Dy5+V7e3QdrB1P5/64d/0=;
        b=tx/phYrxSK7KnNaFHjkd1d1kUQXlQlgT+tWjtSRIWNpWzB3nI30YA4TeIiI9//5PM2
         EfjP499gl8JaIpi0L9EUGuuacyEkpyD34044c62guTlazKF67JBhFStmE+cbbLStdL+Y
         XMeh4lbdLIhixCn47yj5F8CKJs4+ZunFW6jXlJcyPdQB1hfW80xZECMF3By2ut3G8IlE
         limsdIIeeFvv+4746H/l1lIG5hCnKUYZeN5U4J8Q2hGZUqBthdxq8GkhkGsU6an6D9Bv
         8zuoJ4OTcGIp+NxkZMTYTDgRbl2JdI0BVYODevtnrR1U1J2jFiq3rP3eXBZBIyNf8d4s
         D+cA==
X-Gm-Message-State: AOJu0YzvIlU6r53lGE3FRqBHiY//tlOIkmZcTIhZt+UizcmoBguODOKv
        p11J+8EPWLrKnrGxrU0hkC1WIGIfoA==
X-Google-Smtp-Source: AGHT+IE0whMUPrsoD9gh5o2IGz/Y8fxi2DnAYWxZTqLGtOQkx7r5SAEcn/I7BBShMQO37QiqQon48g==
X-Received: by 2002:a05:6870:e38e:b0:1e9:e413:b9d with SMTP id x14-20020a056870e38e00b001e9e4130b9dmr8879744oad.2.1698179412672;
        Tue, 24 Oct 2023 13:30:12 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j2-20020a056870530200b001e9b02b00e9sm2285355oan.22.2023.10.24.13.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 13:30:12 -0700 (PDT)
Received: (nullmailer pid 520032 invoked by uid 1000);
        Tue, 24 Oct 2023 20:30:10 -0000
Date:   Tue, 24 Oct 2023 15:30:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 05/18] dt-bindings: display: mediatek: dsi: add binding
 for MT8365 SoC
Message-ID: <20231024203010.GA518520-robh@kernel.org>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
 <20231023-display-support-v1-5-5c860ed5c33b@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v1-5-5c860ed5c33b@baylibre.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 04:40:05PM +0200, Alexandre Mergnat wrote:
> Display Serial Interface for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
> index 12441b937684..2479b9e4abd2 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
> @@ -34,6 +34,8 @@ properties:
>            - enum:
>                - mediatek,mt6795-dsi
>            - const: mediatek,mt8173-dsi
> +              - mediatek,mt8365-dsi

Not valid YAML nor json-schema. Please test your series before sending.

> +          - const: mediatek,mt8183-dsi
>  
>    reg:
>      maxItems: 1
> 
> -- 
> 2.25.1
> 
