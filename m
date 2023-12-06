Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE58807B06
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377291AbjLFWEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLFWEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:04:50 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F93A8;
        Wed,  6 Dec 2023 14:04:55 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d9d29a2332so172666a34.0;
        Wed, 06 Dec 2023 14:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701900295; x=1702505095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJDRR9SBiqm6w7pCdVTuuRkSR240r1kT/0bdPtSM6qQ=;
        b=MBvcdOmK9sUgE9jP24m0WizVol1a2g412+H8e9hjPAguky+I1BSN2MAy75UtFits14
         dhIzezkiIUdpzwMC75NE+3mr8AICez98p8zDrKkPIfGKeDkJ6EfvMIJrw1GFJXYO9y35
         i2fpkJvfCH6z0mzqQIntTlGtTebpsFnKPor6+a82wOw2P82Q0BS87BwrHJmUhPY8VFwf
         TsTGUxzb5ANdi5pgDbcODbnHJrP3T86gmw7B0495BktqFePRPQGIw5nT0mVjbKA3X3JH
         FSH1G/6dv6YRw6R1o4arE9YPGAMvfTg/9sxi75L8zTcbfjjekt7ABfIk3Uokar508tIw
         1zVA==
X-Gm-Message-State: AOJu0Yye+x6MhpYX5xLgirdhp3FiSu1sNm/0f1c0RfvB0FNq9yca7UJ5
        4RGcOHj0AM80XhVNS07kDzOAkESQMw==
X-Google-Smtp-Source: AGHT+IFFDEcvxaW1h6qjkDvAbD9CHKhsbak2krjz2Ss/TaHOG8qoVD7It3+H/lMrNxsC4ejBXRcljA==
X-Received: by 2002:a05:6830:1e41:b0:6d8:7bfd:7f1 with SMTP id e1-20020a0568301e4100b006d87bfd07f1mr1774877otj.26.1701900295151;
        Wed, 06 Dec 2023 14:04:55 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e25-20020a0568301e5900b006cd09ba046fsm122383otj.61.2023.12.06.14.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:04:54 -0800 (PST)
Received: (nullmailer pid 3422395 invoked by uid 1000);
        Wed, 06 Dec 2023 22:04:53 -0000
Date:   Wed, 6 Dec 2023 16:04:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsd@tesla.com, Andi Shyti <andi.shyti@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 3/6] dt-bindings: serial: samsung: add specific
 compatible for Tesla FSD
Message-ID: <170190029299.3422337.18033865992163523386.robh@kernel.org>
References: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
 <20231205092229.19135-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205092229.19135-4-krzysztof.kozlowski@linaro.org>
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


On Tue, 05 Dec 2023 10:22:26 +0100, Krzysztof Kozlowski wrote:
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
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

