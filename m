Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A977E846E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345331AbjKJUi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjKJUiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:38:18 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449B646BD;
        Fri, 10 Nov 2023 12:38:15 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1f03d9ad89fso1281072fac.1;
        Fri, 10 Nov 2023 12:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699648694; x=1700253494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDEOGTCwLGe8/AbnY8N0ixov4mA0V6wpnOxoAqQPSK4=;
        b=K61igppD8/5+4+6t+T+Zihghhp3L8MZpd66hxwSmTdWyPEaauzRRw1KnNTEH8kz6V7
         +j9jXEjT4rTRoiIhhKFfpeesh4bm4eQT7sEw+1agwvTeP745bD3IQdExNKonQcU67kQm
         wGNcIoWGOdsAQkoqm1SvsxDjJH9hM3mAxvKqhTLSDeT/dY4Fekrp1Evd3iKsNprZPv7X
         Eo7E2lLgeGOfIT2cL7vmMVqsrbgXAoOkC9TfduALUmKBqWwvu2PdlxFCezQLVFVfBjh2
         OCj2aOaXX84OfeOxiCqiOeLSAEwPXokixNCA+r8tV5XHpCL3QjaoYWpRIs0ZifHQEtDK
         OIWw==
X-Gm-Message-State: AOJu0Yzd3FW4LKD1HV+TaZT0khLAchcNktLj/38N+p8WdG+RnHBexnuv
        ezQNi/F+QQCiyMxG86gj9g==
X-Google-Smtp-Source: AGHT+IFVVQE4BI8cOz3AIQYw2pXVqurA/tQ+STytYpdzYk+6P+Wjdqy5vAj94WGd/H3Kxm+R2FQFzQ==
X-Received: by 2002:a05:6870:d1c2:b0:1ea:14eb:b741 with SMTP id b2-20020a056870d1c200b001ea14ebb741mr343191oac.54.1699648694529;
        Fri, 10 Nov 2023 12:38:14 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y4-20020a056870a34400b001e9ce1b5e8fsm59655oak.15.2023.11.10.12.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 12:38:13 -0800 (PST)
Received: (nullmailer pid 390527 invoked by uid 1000);
        Fri, 10 Nov 2023 20:38:11 -0000
Date:   Fri, 10 Nov 2023 14:38:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Airlie <airlied@gmail.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        alsa-devel@alsa-project.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-rtc@vger.kernel.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Lee Jones <lee@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-mmc@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-i2c@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-serial@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 02/17] dt-bindings: i2c: exynos5: add specific
 compatibles for existing SoC
Message-ID: <169964869116.390473.6961652258456026108.robh@kernel.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
 <20231108104343.24192-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108104343.24192-3-krzysztof.kozlowski@linaro.org>
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


On Wed, 08 Nov 2023 11:43:28 +0100, Krzysztof Kozlowski wrote:
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
>  Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml | 10 +++++++++-
>  .../devicetree/bindings/soc/samsung/exynos-usi.yaml    |  2 +-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

