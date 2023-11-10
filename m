Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2857E8464
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345936AbjKJUkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345646AbjKJUkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:40:06 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BF84205;
        Fri, 10 Nov 2023 12:40:03 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6cd0a8bc6dcso1399362a34.2;
        Fri, 10 Nov 2023 12:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699648803; x=1700253603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIUKFeCBp8QWWYNKFRJyz0CogaqLBpf4Mvy06PqKugo=;
        b=Rd1PfSHbJmKlw0LNoTOHBcflxxneqSd87lePzCs5duwGWv5uhAblJ/19f9gYDKsijH
         GbEgk7iEaAS4KeRL90UIMc937ww4GU8gg2Bt+69zugcSMUVIP31Kynwph2TcS0VoUe3I
         CdbqO15OSOQKOaEciB+kAtt+jZ3VxaybZ3LlU0vvIXoK1CskiqPHWKgTllZ+ZUPcLo5K
         6qowrrO2NeGIJq6hRyKgjTVE2QqILsl00CTfNkYar/x6tRRJTxNe1jcRCCvCIaEVnJR2
         7ZmFA2hH3yxNDC5Yk24TLWHlDGXoSI2OsYhMlUTBjSlNP5lCkRH2Z5i0la+t8772VjyT
         x0rw==
X-Gm-Message-State: AOJu0YwCn8y8JLvJGkAUDtthrEh/imHru+uUJfRPcFjJLV1LwZOCa8kv
        119lG45oQEGoqLdZ33Y/gw==
X-Google-Smtp-Source: AGHT+IHRxgqmlIcaZxA+uUtss7i4GqToCENI8qvZ/6FLZfO0lFbqJf5Tp34OcuHctKTILzporo4hUw==
X-Received: by 2002:a05:6830:2644:b0:6ba:865b:ca72 with SMTP id f4-20020a056830264400b006ba865bca72mr207172otu.31.1699648803023;
        Fri, 10 Nov 2023 12:40:03 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id do2-20020a0568300e0200b006d64467c68asm46743otb.77.2023.11.10.12.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 12:40:02 -0800 (PST)
Received: (nullmailer pid 393449 invoked by uid 1000);
        Fri, 10 Nov 2023 20:40:00 -0000
Date:   Fri, 10 Nov 2023 14:40:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>, alsa-devel@alsa-project.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-serial@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 05/17] dt-bindings: pinctrl: samsung: add specific
 compatibles for existing SoC
Message-ID: <169964880016.393384.2296633788360305234.robh@kernel.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
 <20231108104343.24192-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108104343.24192-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Nov 2023 11:43:31 +0100, Krzysztof Kozlowski wrote:
> Samsung Exynos SoC reuses several devices from older designs, thus
> historically we kept the old (block's) compatible only.  This works fine
> and there is no bug here, however guidelines expressed in
> Documentation/devicetree/bindings/writing-bindings.rst state that:
> 1. Compatibles should be specific.
> 2. We should add new compatibles in case of bugs or features.
> 
> Add compatibles specific to each SoC in front of all old-SoC-like
> compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> I propose to take the patch through Samsung SoC (me). See cover letter
> for explanation.
> ---
>  .../samsung,pinctrl-wakeup-interrupt.yaml     | 24 ++++++++++++-------
>  .../bindings/pinctrl/samsung,pinctrl.yaml     |  3 ++-
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

