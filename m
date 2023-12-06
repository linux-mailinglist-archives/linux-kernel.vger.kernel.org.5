Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101E6807AF0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377366AbjLFWAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjLFWAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:00:36 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C79B12F;
        Wed,  6 Dec 2023 14:00:43 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d875809921so158764a34.3;
        Wed, 06 Dec 2023 14:00:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701900042; x=1702504842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwhgtoJBHD+urcH5IYg5YW90GEy+rE7lf0f+y7qkFHs=;
        b=hv7ie2ZtXi+uiaWZDK26cttoc9RBQaOc6tn+vgh4vqSLkDfM2DHs1+i5AEoZ1X7bFY
         KIHmw7c9/tMdI1CQcwamnlBeNvFChVKXuUE9HUY7xXbCpeZxjlfbCzES7v7sl8y3os3w
         iYN/OJqy4X4AusZn2KEzlORHm26vmVDlJ3jiclkoAzCa/YPHhkrlaDQkTDyN5uWGcK0/
         wyOhMCo5Rv26CJwu58FnD8/suATYk2LjHARh4T0EEgrD1ozDXWcDstCorxys2CJtJwYd
         uhKSbpjf2ZX9QKbRtjcPVbfgU7Rb6/eqE63zz1LsT353aDCP1WsslM/rzDzaxnNBRiPp
         ybDQ==
X-Gm-Message-State: AOJu0YzgjzKqcR/Nw7PSvAHYQL59AFlzXaLJyx8Ee5OdVwZADpoxOkNB
        mS1/1x7B6GIc0pOdSLHT8us9qhcMvQ==
X-Google-Smtp-Source: AGHT+IFw6fuFwvD7kKM66OrVG43T8C1pgmSfk4/GKi5DIIhApWtBZ/cbH1dVyNVk7wzjZtscobGlAA==
X-Received: by 2002:a9d:7997:0:b0:6d8:74e2:6f32 with SMTP id h23-20020a9d7997000000b006d874e26f32mr1618350otm.46.1701900042258;
        Wed, 06 Dec 2023 14:00:42 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z14-20020a05683010ce00b006d879d8a4d8sm121306oto.78.2023.12.06.14.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:00:41 -0800 (PST)
Received: (nullmailer pid 3402462 invoked by uid 1000);
        Wed, 06 Dec 2023 22:00:40 -0000
Date:   Wed, 6 Dec 2023 16:00:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-fsd@tesla.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andi Shyti <andi.shyti@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH 1/6] dt-bindings: i2c: exynos5: add specific compatible
 for Tesla FSD
Message-ID: <170190003691.3402358.13173057171065129546.robh@kernel.org>
References: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
 <20231205092229.19135-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205092229.19135-2-krzysztof.kozlowski@linaro.org>
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


On Tue, 05 Dec 2023 10:22:24 +0100, Krzysztof Kozlowski wrote:
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
>  Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

