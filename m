Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B257E8483
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346540AbjKJUnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346512AbjKJUm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:42:27 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E287133;
        Fri, 10 Nov 2023 12:41:58 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6d64c1155a8so380180a34.2;
        Fri, 10 Nov 2023 12:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699648917; x=1700253717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EBl5Xv3aZC1B/CoCuf5eLNa9yKY/Gkw4iwanxopftw=;
        b=lkAY5bIogvHetstiORRINNv+oA7GvgupZeIFf5x4W+xEOr+T0ScYvMQ3T2FLyW7Vvz
         kXPrKS9uv9v/zKHK8TKSpXUAxtxIdFMMjoTXWc6xACZqbnCr1rJ+FDH5A/HlItDrZtQ5
         72yKasTMHeOWwWZc5/3LKyJLlwgKzJJhbOsydfLkVMgM+MesmOMW+TgGOTFijL/caJyF
         bJYEeaSXp6nJ+88nGHIytgHExc0GtD9KgVuMgszatKpJ4rvPCHXPJyvzeiBdzxtbIwS9
         mbvlYl8APooKVmtRJ4coTuOrV+0C+k477Rrb+2DXWafHiN4oHkohpqmAfg5+Sy3+/fOf
         nLcA==
X-Gm-Message-State: AOJu0Yzu6KtKWUJ/+ZfNYspMx1q6wsRUgxyVlWLNcJnh5lnhmPnUbM6Q
        ql0av+iFHkcVl4GZNU2Qhw==
X-Google-Smtp-Source: AGHT+IF1/xoVIE1AxHEqioWJNWInr5h1m1P3hdrpoBOInT7vjcfYXrW2+GFkkUSryqGVJF7HdU+emA==
X-Received: by 2002:a05:6830:1302:b0:6c6:3ea5:cdbe with SMTP id p2-20020a056830130200b006c63ea5cdbemr259082otq.18.1699648917500;
        Fri, 10 Nov 2023 12:41:57 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l19-20020a056830269300b006ce2fce83cbsm52548otu.25.2023.11.10.12.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 12:41:56 -0800 (PST)
Received: (nullmailer pid 396513 invoked by uid 1000);
        Fri, 10 Nov 2023 20:41:54 -0000
Date:   Fri, 10 Nov 2023 14:41:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-rtc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        David Airlie <airlied@gmail.com>, linux-serial@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
        alsa-devel@alsa-project.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-gpio@vger.kernel.org, linux-sound@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 09/17] dt-bindings: gpu: arm,mali-midgard: add specific
 compatibles for existing Exynos SoC
Message-ID: <169964891433.396452.11090809203947265672.robh@kernel.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
 <20231108104343.24192-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108104343.24192-10-krzysztof.kozlowski@linaro.org>
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


On Wed, 08 Nov 2023 11:43:35 +0100, Krzysztof Kozlowski wrote:
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
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

