Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886B5807B13
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377482AbjLFWFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377409AbjLFWFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:05:16 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6BAD7D;
        Wed,  6 Dec 2023 14:05:22 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-58cf894544cso1285eaf.3;
        Wed, 06 Dec 2023 14:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701900322; x=1702505122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbd5B8BVVpRHLAAm9f1h8aNytsZytNMI1lzIKFManeQ=;
        b=pMxC2nOv9Eu5z315m6/BLH3Tr7emveEAdtWuOH6hXD7TYe61Uy6N5Ipe1uCZSVRJkQ
         it6h3Bgi9KuLmFBEa8hqjelaC4FdINkXGH4tuIV8xD6+F7YL+eQlYfDzho76uuwL6Jwm
         +rMWEYdGnL9ElPP/6f9Fv5F3hn6SCLdzMXyZXYRFfIbBDpSJRxHct5MljgdvmbzfQW97
         TyXGhbYJX2w4yZuQf5P25cC16/mvfVr9uQwVhb7eQuIGsgkmUUoZhBV80abHWmbGBul7
         au3/TBR+2kYgIBlFNJrTMsT6tJfHLJnS7yQPIbGInhM2r2PMx2jkMgmPTZeNcHyeihOJ
         8+gg==
X-Gm-Message-State: AOJu0YyWo34P2QWrvp09VLfcjMP2++KdX1CWu1aClGwYSrYAPU+TJQrX
        BlfpM0fSAwG6T/hYZ7rgBA==
X-Google-Smtp-Source: AGHT+IGje1u2DNEW9pSR9hih68DS0uYGwmFBGf37482odpdjRd1Z0Zs32LrlmDgot+tSfKBspUxDvQ==
X-Received: by 2002:a4a:251b:0:b0:58e:80e2:93b7 with SMTP id g27-20020a4a251b000000b0058e80e293b7mr1466627ooa.0.1701900322055;
        Wed, 06 Dec 2023 14:05:22 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d24-20020a4a9198000000b0057b6ac3922esm803ooh.18.2023.12.06.14.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:05:21 -0800 (PST)
Received: (nullmailer pid 3423211 invoked by uid 1000);
        Wed, 06 Dec 2023 22:05:20 -0000
Date:   Wed, 6 Dec 2023 16:05:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-serial@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-i2c@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: watchdog: samsung: add specific
 compatible for Tesla FSD
Message-ID: <170190031995.3423149.13499134597119767259.robh@kernel.org>
References: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
 <20231205092229.19135-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205092229.19135-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Dec 2023 10:22:28 +0100, Krzysztof Kozlowski wrote:
> Tesla FSD is a derivative of Samsung Exynos SoC, thus just like the
> others it reuses several devices from older designs.  Historically we
> kept the old (block's) compatible only.  This works fine and there is no
> bug here, however guidelines expressed in
> Documentation/devicetree/bindings/writing-bindings.rst state that:
> 1. Compatibles should be specific.
> 2. We should add new compatibles in case of bugs or features.
> 
> Add Tesla FSD compatible specific to be used with an existing fallback.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> I propose to take the patch through Samsung SoC (me). See cover letter
> for explanation.
> ---
>  .../bindings/watchdog/samsung-wdt.yaml        | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

