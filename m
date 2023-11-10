Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D447E84EB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjKJVEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 16:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjKJVEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:04:48 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA8B9F;
        Fri, 10 Nov 2023 13:04:46 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b2e72fe47fso1484847b6e.1;
        Fri, 10 Nov 2023 13:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699650285; x=1700255085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OReAG/NBqEVFLwZGkLlqa+2uqckd3cbd5xDGpNykLUc=;
        b=V0qcx96YalsSMc7AlXaD3CaNI1GxzrDOD2mPqDsKiSZ+ODTveU/2FvmXoNYIKnvRRp
         NWNrhKWUbiurrKTQpJspexz04TSC0nC+cThKzg4iVjJ+Rx3hbQbRjKTZSV8USfwFprWT
         vGbTWCsJm9dRDr8vrT2zvGY5w7iH9z5a3WD4UpBWLmIvxenSgFKZauQP4JaJmnZeNMZd
         Yaw4tgUAvhNvMV+Bi7rY76pQnYToJmaJnekiVzQWpaO93+C7IVebY16kt/suStmUmMoI
         CIGBeCTW0PWNM5vSoH7EFmuQmtgMIIg/tPvbGqvYI9DAowgu8Q5M6fsb0fphv/1LG22e
         OlvA==
X-Gm-Message-State: AOJu0Yx3zQH7pk9FP2sQbAMsVINcRPA8QvfvOw6wZtzFRhrYg2qWLR/d
        I07GpBgXK9LXFOMRmb0sXA==
X-Google-Smtp-Source: AGHT+IFiqy2OZ3nIDTm6Fa8CJvyvr/Lh1xdBTB5opdpha0WN/3K5zzZBM9is72GKFetK8Yo/bFgGqg==
X-Received: by 2002:a05:6870:2dc6:b0:1c8:c27f:7d9b with SMTP id op6-20020a0568702dc600b001c8c27f7d9bmr406200oab.27.1699650285305;
        Fri, 10 Nov 2023 13:04:45 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v13-20020a05683011cd00b006d2e04a55e8sm55062otq.14.2023.11.10.13.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 13:04:44 -0800 (PST)
Received: (nullmailer pid 431470 invoked by uid 1000);
        Fri, 10 Nov 2023 21:04:43 -0000
Date:   Fri, 10 Nov 2023 15:04:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [RFC PATCH v2 6/7] dt-bindings: arm: mediatek: Remove SKU
 specific compatibles for Google Krane
Message-ID: <20231110210443.GA419831-robh@kernel.org>
References: <20231109100606.1245545-1-wenst@chromium.org>
 <20231109100606.1245545-7-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109100606.1245545-7-wenst@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 06:06:03PM +0800, Chen-Yu Tsai wrote:
> In cases where the same Chromebook model is manufactured with different
> components (MIPI DSI panels, MIPI CSI camera sensors, or trackpad /
> touchscreens with conflicting addresses), a different SKU ID is
> allocated to each specific combination. This SKU ID is exported by the
> bootloader into the device tree, and can be used to "discover" which
> combination is present on the current machine. Thus we no longer have
> to specify separate compatible strings for each of them.

You just broke an existing kernel with a new DT having this change.

Just because you come up with a new way to do things, doesn't mean you 
can remove the old way.

> 
> Remove the SKU specific compatible strings for Google Krane.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index a4541855a838..ef3dfb286814 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -186,9 +186,6 @@ properties:
>            - const: mediatek,mt8183
>        - description: Google Krane (Lenovo IdeaPad Duet, 10e,...)
>          items:
> -          - enum:
> -              - google,krane-sku0
> -              - google,krane-sku176
>            - const: google,krane
>            - const: mediatek,mt8183
>        - description: Google Willow (Acer Chromebook 311 C722/C722T)
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
