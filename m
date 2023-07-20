Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5634675AB00
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjGTJho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjGTJhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:37:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00F24213
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:32:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so894093e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689845515; x=1692437515;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=hSMhk6i6GINps38sHFzPosUE097n1Jty6srL/iyzn6U=;
        b=VAvi3G0e6XqAXgvnsCqHpV3v17qyegAzastUBATMH203E4CDtXSc4aa5SgTTtiThRq
         IX1hWELxyMcDVVeN4CSCV6b3JGRslNeXngmS4wQa33d8j094FAbI8D2345veVTMh2p+E
         LK2J8k7YuNm0Fa9aWEghtPyZvQov0XyBL4KKpmPXlAGz7H/NP+6dfnyfj7mxGhoM6PlJ
         y2NC/fz6fdzo6jZOdnc6UsL5T5sUCEr+yu6bIw9EBDT4U+qa8YJqlAgBvem2L2SOU4rz
         tvK7h+i52ajcKhfcCdq3or2eUgUWG/M9N6qjnPUG8zhPVXBqJ7ac098PLYw1uIYI+Bfq
         mSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689845515; x=1692437515;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSMhk6i6GINps38sHFzPosUE097n1Jty6srL/iyzn6U=;
        b=TIZNQQbH+yEBy3S8Ist+aXNEzoxy988CFXLH/bdYvHCtWoNFZSW41L0/Gwyw+CXX9l
         cfipZVSw7jry3fWfkadxhmnJLp7/4lk/PHItVXf80vS6g5Q9pUZhaA/TQn5g9foW1TMR
         AfJ8NYeaK+WCnSs9b6mDsG9gdA7XKGdcaPx3ldfTIVJ97hS3RDeqG9aDlQwgYYfcv9MO
         AksluxtvMWGdgwhjcgv32QFFWosMOYnBeZ7mKsSOIVr81u/+DzuDsEuUjFFVJQ4Vr5nj
         XnCNwmZnkqMcpd+Stm+8MjjX2NAWeaJZt0/Im+JzvpLxiCBi1uQVCXB1zlWfaWbT7myt
         RSVQ==
X-Gm-Message-State: ABy/qLb+uRy8+dyrqT6MJbyvjd67KcPiq+8irgJSJIGciLpVVzW6wRdM
        0TG4lu4C1nKoT4eRPodKK4Eiqw==
X-Google-Smtp-Source: APBJJlG1yCJEdqs7h0O+DVyITCi83c8k8QFShbwRseN1eoFH/pKOHb2MlKdI4eCohhrZQvoW3aJkLw==
X-Received: by 2002:a05:6512:3e21:b0:4f8:5af4:73f1 with SMTP id i33-20020a0565123e2100b004f85af473f1mr2422936lfv.32.1689845515449;
        Thu, 20 Jul 2023 02:31:55 -0700 (PDT)
Received: from localhost ([82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c028f00b003fc06169ab3sm3467170wmk.20.2023.07.20.02.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 02:31:54 -0700 (PDT)
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [PATCH v2 00/19] clk: meson: move all private clk IDs to public
 dt-bindings headers
Date:   Thu, 20 Jul 2023 11:31:06 +0200
In-reply-to: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
Message-ID: <1jwmyvnd2t.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 12 Jun 2023 at 11:57, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> After some complaints in the upstreaming of the A1 clock drivers,
> S4 clock driver and a tentative to use some of the private DSI
> clocks in [1], it has been decided to move out all the "private"
> clk IDs to public dt-bindings headers.
>
> For that we must get rid of the "NR_CLKS" define and use
> ARRAY_SIZE() to get the count of hw_clks, then we can move
> the IDs and do some cleanup.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Collect review tags
> - Move newly introduced helper and header into new meson-clkc-utils module
> - Link to v1: https://lore.kernel.org/r/20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org
>
> ---
> Neil Armstrong (19):
>       clk: meson: introduce meson-clkc-utils

Fixed MODULE_LICENSE

>       clk: meson: migrate meson-eeclk out of hw_onecell_data to drop NR_CLKS
>       clk: meson: migrate meson-aoclk out of hw_onecell_data to drop
>       NR_CLKS

Fixed whitespace warning

>       clk: meson: migrate a1 clock drivers out of hw_onecell_data to drop NR_CLKS
>       clk: meson: migrate meson8b out of hw_onecell_data to drop NR_CLKS
>       clk: meson: migrate axg-audio out of hw_onecell_data to drop NR_CLKS
>       dt-bindings: clk: gxbb-clkc: expose all clock ids
>       dt-bindings: clk: axg-clkc: expose all clock ids
>       dt-bindings: clk: g12a-clks: expose all clock ids
>       dt-bindings: clk: g12a-aoclkc: expose all clock ids
>       dt-bindings: clk: meson8b-clkc: expose all clock ids
>       dt-bindings: clk: amlogic,a1-peripherals-clkc: expose all clock ids
>       dt-bindings: clk: amlogic,a1-pll-clkc: expose all clock ids
>       dt-bindings: clk: axg-audio-clkc: expose all clock ids
>       clk: meson: aoclk: move bindings include to main driver
>       clk: meson: eeclk: move bindings include to main driver
>       clk: meson: a1: move bindings include to main driver
>       clk: meson: meson8b: move bindings include to main driver
>       clk: meson: axg-audio: move bindings include to main driver
>

Applied. Thx

>  drivers/clk/meson/Kconfig                          |    9 +
>  drivers/clk/meson/Makefile                         |    1 +
>  drivers/clk/meson/a1-peripherals.c                 |  325 ++---
>  drivers/clk/meson/a1-peripherals.h                 |   67 -
>  drivers/clk/meson/a1-pll.c                         |   38 +-
>  drivers/clk/meson/a1-pll.h                         |   19 -
>  drivers/clk/meson/axg-aoclk.c                      |   48 +-
>  drivers/clk/meson/axg-aoclk.h                      |   18 -
>  drivers/clk/meson/axg-audio.c                      |  851 ++++++-----
>  drivers/clk/meson/axg-audio.h                      |   75 -
>  drivers/clk/meson/axg.c                            |  285 ++--
>  drivers/clk/meson/axg.h                            |   63 -
>  drivers/clk/meson/g12a-aoclk.c                     |   72 +-
>  drivers/clk/meson/g12a-aoclk.h                     |   32 -
>  drivers/clk/meson/g12a.c                           | 1489 ++++++++++----------
>  drivers/clk/meson/g12a.h                           |  145 --
>  drivers/clk/meson/gxbb-aoclk.c                     |   14 +-
>  drivers/clk/meson/gxbb-aoclk.h                     |   15 -
>  drivers/clk/meson/gxbb.c                           |  848 +++++------
>  drivers/clk/meson/gxbb.h                           |   81 --
>  drivers/clk/meson/meson-aoclk.c                    |    9 +-
>  drivers/clk/meson/meson-aoclk.h                    |    3 +-
>  drivers/clk/meson/meson-clkc-utils.c               |   25 +
>  drivers/clk/meson/meson-clkc-utils.h               |   19 +
>  drivers/clk/meson/meson-eeclk.c                    |    9 +-
>  drivers/clk/meson/meson-eeclk.h                    |    3 +-
>  drivers/clk/meson/meson8b.c                        | 1318 ++++++++---------
>  drivers/clk/meson/meson8b.h                        |  117 --
>  .../clock/amlogic,a1-peripherals-clkc.h            |   53 +
>  include/dt-bindings/clock/amlogic,a1-pll-clkc.h    |    5 +
>  include/dt-bindings/clock/axg-audio-clkc.h         |   65 +
>  include/dt-bindings/clock/axg-clkc.h               |   48 +
>  include/dt-bindings/clock/g12a-aoclkc.h            |    7 +
>  include/dt-bindings/clock/g12a-clkc.h              |  130 ++
>  include/dt-bindings/clock/gxbb-clkc.h              |   65 +
>  include/dt-bindings/clock/meson8b-clkc.h           |   97 ++
>  36 files changed, 3189 insertions(+), 3279 deletions(-)
> ---
> base-commit: 84af914404dbc01f388c440cac72428784b8a161
> change-id: 20230607-topic-amlogic-upstream-clkid-public-migration-fc1c67c44858
>
> Best regards,

