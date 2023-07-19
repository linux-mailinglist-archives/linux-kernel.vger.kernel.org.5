Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D262B758AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGSBLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGSBLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:11:34 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE891BC9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:11:32 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-577497ec6c6so62187557b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689729091; x=1692321091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8xk4472MbQ0aONiK6ZtIfH665Wri1/wSc0QB/UZUqhk=;
        b=EHQ8krW39V/sbOi+DKhI1PMxM/sjS73lureK8IoE+d91eZY3vwuWy95pieu4fPe2Gs
         qgDS6zMd/e10X/+m9kpWSFFdZucDScjJ0xNbnzd1HdU52AJMAlh/KjTM2zHE7mK/JCg/
         uikl2pkgUY6wIKiHWr30hoqYwThHW9LJ4nT1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689729091; x=1692321091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xk4472MbQ0aONiK6ZtIfH665Wri1/wSc0QB/UZUqhk=;
        b=ZIMa7JV688bjArul7NSxCPib0kLLgjTMAbybRpBKYTrVgoOz6gHA78H8CCTrei8B4x
         wMWppkd+YE9phCTGKnXk1e3s8dX2+NEz6PRPWGlpWeeaaxF1xy7QB6bMEK3pSIDzqNI5
         5Xgu1+DJ6qOblX3Bp+FOqTG3d/I28x4ZnmwbwfyXOwR4/TecBb/HyznrFXZuGaCqS5RU
         +m8qDF0aBmjNn1xSUfXFQrGCgq4/dWHuGowzyBTwPc6ip1C5c2MjI7Jto/SXcOuXvaTK
         p27Y/KTCKAPqGnYR5oucjZ4NdWEMHWTSV1bvHwQzsla8NloxchgF4WtJLTnjVTDHoG1f
         COUA==
X-Gm-Message-State: ABy/qLZKT+AJEt9qGefrnLeFqurvQyG5+pVB0ihshtqahLGXch2DznVd
        a9ph/z6uCwUIG6BuLeo5mGHG7Rj/UQjfaIH/DrGe0w==
X-Google-Smtp-Source: APBJJlFru+d/U81Pb9ePkPrJKq43uASadD6AsRc7NSkUAAz8pFffpSMk41RYr0j/v1SdEfDOedDhi391SuLe3Lq39G4=
X-Received: by 2002:a25:9f0f:0:b0:bfe:e383:6297 with SMTP id
 n15-20020a259f0f000000b00bfee3836297mr1279983ybq.19.1689729091455; Tue, 18
 Jul 2023 18:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230718143045.1065100-1-robh@kernel.org>
In-Reply-To: <20230718143045.1065100-1-robh@kernel.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Tue, 18 Jul 2023 19:08:01 -0600
Message-ID: <CAPnjgZ0H077Hdq2HoOyrYxjAmXLigRrj+6H3sPLidtDa2w=Wcw@mail.gmail.com>
Subject: Re: [PATCH v2] power: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Support Opensource <support.opensource@diasemi.com>,
        David Lechner <david@lechnology.com>,
        Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-oxnas@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 at 08:31, Rob Herring <robh@kernel.org> wrote:
>
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Acked-by: David Lechner <david@lechnology.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - Fix double include of of.h
> ---
>  drivers/power/reset/as3722-poweroff.c            | 1 -
>  drivers/power/reset/brcm-kona-reset.c            | 4 ++--
>  drivers/power/reset/gpio-poweroff.c              | 3 ++-
>  drivers/power/reset/gpio-restart.c               | 2 +-
>  drivers/power/reset/keystone-reset.c             | 3 ++-
>  drivers/power/reset/ocelot-reset.c               | 4 ++--
>  drivers/power/reset/odroid-go-ultra-poweroff.c   | 3 ++-
>  drivers/power/reset/oxnas-restart.c              | 2 --
>  drivers/power/reset/st-poweroff.c                | 2 +-
>  drivers/power/reset/syscon-poweroff.c            | 3 +--
>  drivers/power/reset/syscon-reboot.c              | 3 +--
>  drivers/power/reset/xgene-reboot.c               | 2 +-
>  drivers/power/supply/axp20x_ac_power.c           | 1 -
>  drivers/power/supply/axp20x_battery.c            | 1 -
>  drivers/power/supply/axp20x_usb_power.c          | 1 -
>  drivers/power/supply/cpcap-battery.c             | 2 +-
>  drivers/power/supply/da9150-charger.c            | 2 --
>  drivers/power/supply/da9150-fg.c                 | 1 -
>  drivers/power/supply/lego_ev3_battery.c          | 2 +-
>  drivers/power/supply/ltc2941-battery-gauge.c     | 2 +-
>  drivers/power/supply/ltc4162-l-charger.c         | 2 +-
>  drivers/power/supply/max14656_charger_detector.c | 2 +-
>  drivers/power/supply/max17040_battery.c          | 2 +-
>  drivers/power/supply/max8903_charger.c           | 1 -
>  drivers/power/supply/rn5t618_power.c             | 1 -
>  drivers/power/supply/rt5033_charger.c            | 2 +-
>  drivers/power/supply/rt9455_charger.c            | 3 +--
>  drivers/power/supply/sbs-battery.c               | 2 +-
>  drivers/power/supply/tps65090-charger.c          | 2 +-
>  drivers/power/supply/tps65217_charger.c          | 1 -
>  drivers/power/supply/twl4030_charger.c           | 1 +
>  31 files changed, 26 insertions(+), 37 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
