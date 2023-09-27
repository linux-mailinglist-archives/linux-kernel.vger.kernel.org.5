Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2C07AFF98
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjI0JOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjI0JOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:14:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B82FD6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:14:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4054496bde3so88374315e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695806042; x=1696410842; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=RsG+xQ5K7+BJbzhMgY+2l7hI3HJGu/U8Llgo7kKe+d0=;
        b=mQOK3pCoptalgz2S20iQDY2VGKjXNZEQX+zrOD8+N6MEKZamCDpiaVUjTmaP1kxKqX
         VdKum8TmiaRHjPIxzT6N9LsW7IoHs+rXELyVh6kzrELPX5sji0n0GjESMeWYjMrkjKj7
         +ETeo7l4Qhi6qjuce/AbDoXB6IGYyX05XgEEW/GO3D9RuGHAYAgynzM7o0oVlChEGLfO
         n+6Gpq3A6ZMT4UEVd/VBS33T6IhbHQTGrgEBauKRxsfDZTrdLX8NeZ59TgHDDIQWsh7Q
         0o9he6bPLjwpfiXYWZ0PWAes1B7QkXFmK36vKZIsw9+LQZYPm/+FMf4X/yclkW8Q/7wk
         sVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695806042; x=1696410842;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsG+xQ5K7+BJbzhMgY+2l7hI3HJGu/U8Llgo7kKe+d0=;
        b=rINWmapD+CRmhYcg1RC2QIJohBEFzhrp9ctbOSlATfeISWlXU/BevY0YCzSVLBrvCG
         VKKK0A2oyHjoiq/tqzVy9Ku+xdVG0HVGAuoyjoL1ux1Dpfu7jSgUum0I+ekqJwfpC5kY
         iy2kR80HiBjm8cBu+iW8lZUbbgW8Y48QM1XX8A6KAswAXHM3t9oHw9wW1+Uws9NqnyN5
         wuSS65Sspbe+w6C0nA3fts0NOFvGOQKiagSl72XZAvLOq3TL+OC7MLQTvWZMkAMD3Xw9
         4eQEMPuUVhzTXnng906cPe8ClRoTmQV/VoNdXhVRIpAMT0+mQOl59btvxnHvOhBunz/8
         SeRA==
X-Gm-Message-State: AOJu0YxWj7/kXIm/bgyd4+hmKzyYmx7iWG7GNWiL0ug9rz1Q6l2FVpJ8
        1QRH9+6RlyiRmsfv3pPBHdS2hw==
X-Google-Smtp-Source: AGHT+IE/QudZMKsR1NKWpqHhMWhm3ezMdiqFVqImn30dFuRULpbJwjQjX4JFMweOsN/FbuuxDCxHsg==
X-Received: by 2002:adf:e9c1:0:b0:31f:fa61:961b with SMTP id l1-20020adfe9c1000000b0031ffa61961bmr1201054wrn.66.1695806041834;
        Wed, 27 Sep 2023 02:14:01 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:99be:56aa:a730:ad2d])
        by smtp.gmail.com with ESMTPSA id c17-20020adfe751000000b00317909f9985sm16482378wrn.113.2023.09.27.02.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:14:01 -0700 (PDT)
References: <20230904075504.23263-1-yu.tu@amlogic.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
Subject: Re: [PATCH V11 0/4] Add S4 SoC PLLs and Peripheral clock
Date:   Wed, 27 Sep 2023 11:13:32 +0200
In-reply-to: <20230904075504.23263-1-yu.tu@amlogic.com>
Message-ID: <1jmsx8kmg7.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 04 Sep 2023 at 15:55, Yu Tu <yu.tu@amlogic.com> wrote:

> 1. Add S4 SoC PLLs and Peripheral clock controller dt-bindings.
> 2. Add PLLs and Peripheral clock controller driver for S4 SOC.
>
> Yu Tu (4):
>   dt-bindings: clock: document Amlogic S4 SoC PLL clock controller
>   dt-bindings: clock: document Amlogic S4 SoC peripherals clock
>     controller
>   clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver
>   clk: meson: S4: add support for Amlogic S4 SoC peripheral clock
>     controller
>
> V10 -> V11:
> 1. Change patch 0001/0002 dt-bindings tag. Suggested by Krzysztof.
> 2. Change patch 0002 dt-bindings added minItems. Suggested by Jerome.
> 3. Change patch 0004 added clock ".flags = 0" and comment. Suggested by Jerome.
>
> V9 -> V10:
> 1. Change the relevant S4 CLK patch based on Neil's recently modified
> patch.
> 2. Change patch 0003/0004 clocks comment, format and clock flags suggested
> by Jerome.
>
> V8 -> V9: Add patch 0001/0002 dt-bindings tag. Suggested by Krzysztof.
> V7 -> V8:
> 1. Change patch 0001/0002 dt-bindings title description, remove "meson".
> Suggested by Dmitry, Neil.
> 2. Change patch 0003/0004 clocks comment, format and clock flags suggested by
> Dmitry, Neil, Jerome.
>
> V6 -> V7: Change send patch series as well change format and clock flags
> suggested by Jerome. Change dt-bindings suggested by Krzysztof.
> V5 -> V6: Change send patch series, as well change format and clock flags.
> V4 -> V5: change format and clock flags and adjust the patch series
> as suggested by Jerome.
> V3 -> V4: change format and clock flags.
> V2 -> V3: Use two clock controller.
> V1 -> V2: Change format as discussed in the email.
>
> Link:https://lore.kernel.org/linux-amlogic/20230822082750.27633-1-yu.tu@amlogic.com/
>
>  .../clock/amlogic,s4-peripherals-clkc.yaml    |   96 +
>  .../bindings/clock/amlogic,s4-pll-clkc.yaml   |   49 +
>  drivers/clk/meson/Kconfig                     |   23 +
>  drivers/clk/meson/Makefile                    |    2 +
>  drivers/clk/meson/s4-peripherals.c            | 3813 +++++++++++++++++
>  drivers/clk/meson/s4-peripherals.h            |   57 +
>  drivers/clk/meson/s4-pll.c                    |  867 ++++
>  drivers/clk/meson/s4-pll.h                    |   38 +
>  .../clock/amlogic,s4-peripherals-clkc.h       |  236 +
>  .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |   43 +
>  10 files changed, 5224 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>  create mode 100644 drivers/clk/meson/s4-peripherals.c
>  create mode 100644 drivers/clk/meson/s4-peripherals.h
>  create mode 100644 drivers/clk/meson/s4-pll.c
>  create mode 100644 drivers/clk/meson/s4-pll.h
>  create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>  create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>
>
> base-commit: 41680df0975e04b959a28bf6ab85fd6a307ae0ea

Applied.
Thx.
