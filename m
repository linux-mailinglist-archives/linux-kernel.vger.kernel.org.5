Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D94807B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377481AbjLFWFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLFWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:05:01 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1A0D5E;
        Wed,  6 Dec 2023 14:05:07 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-58de42d0ff7so11146eaf.0;
        Wed, 06 Dec 2023 14:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701900307; x=1702505107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46zP7PpIV9+s0f094gD8cCn/8R7C1jWUWzTcq7Dc4qU=;
        b=bNyCGF9Z9kA04+tKKmmkAzpvYqrAccQLGmXHU5q4HqG0tD9NxVV77fdI7qdOHtA56p
         k4tDcdRh/sX1Eqw4pcNeqScU2DauW3bKydBOB1cho6WWL7v7yOFQMZ9xjyts3mO5hsQO
         gOigUVu7ShofngFllapDT343vpsuTVNtlLTEETnqnVB1t1dZ4qe4iFbbMRnY2TU7SbHI
         tBROKA9/7hCibDBDU9KdiPCaHDAr0vlBLX4vIALfoQIrhDSqo/gWRCgCF5yBuLJA7RIE
         C6X4yXOoQxE0gYKdlicthMOOh2wUp0s0E1sSVJLCfeIauFESLlq+NBehXSwnmkPqY5rP
         35rw==
X-Gm-Message-State: AOJu0YxNTvu4Z9Z6P7NPMDaPh3bqAIZQq7FpLD0zL0JjwLdWNgZoDwuy
        +CNejVyVZ/nsp4kzlJCSCg==
X-Google-Smtp-Source: AGHT+IGVE6hNi0r0U9VEv68OQG7Fvz3CTeeiQktzyzsAr0iJ/XTJ6vatuh1vvXzAuTGY1UAotFvV2g==
X-Received: by 2002:a05:6820:167:b0:58e:1c47:6325 with SMTP id k7-20020a056820016700b0058e1c476325mr1573720ood.19.1701900306696;
        Wed, 06 Dec 2023 14:05:06 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i12-20020a056830010c00b006d879395c73sm127696otp.21.2023.12.06.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:05:06 -0800 (PST)
Received: (nullmailer pid 3422750 invoked by uid 1000);
        Wed, 06 Dec 2023 22:05:04 -0000
Date:   Wed, 6 Dec 2023 16:05:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        linux-fsd@tesla.com, Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: samsung: exynos-pmu: add specific
 compatible for Tesla FSD
Message-ID: <170190030447.3422711.17534836727723691670.robh@kernel.org>
References: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
 <20231205092229.19135-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205092229.19135-5-krzysztof.kozlowski@linaro.org>
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


On Tue, 05 Dec 2023 10:22:27 +0100, Krzysztof Kozlowski wrote:
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
>  Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

