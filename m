Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8756480A445
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573797AbjLHNQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjLHNQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:16:24 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FB5D54
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:16:30 -0800 (PST)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D7C8740A76
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702041388;
        bh=5OGFeeZf5m0bMG5GtisyOq/eek7cqESU/OhJA19L9VA=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=eUtZytU4O7R0hL8fK8O1fvvqlIPuYJJcbY8QmgCsOifUrxPwvsT/ifJv+E+ewCRO5
         YgDQyAucqdWi9fQUoNZAw6t62kG3vUyMRhd3qpWbWKJtJp51AI/5jpGssp0Wlpfbk+
         5xUXURHmRexAQNl9E8I7+R8OaTx45ulJPdhEgwkjZmXWfx/NueX0gbfhmssY0+ooRd
         pDpkl+wgEDR+jlZf2wrlcjYii7N5kJOWdVbT7VT1NI64vvQKz4ExoFu53iDzzMIfty
         2lpPHS9tSNhoa3I9gh5xRcDZtBx8rHBnZAVcsD/nKOJwnH0FN2LHCu4AD05JerCMxR
         TSiO7fKhgC+zg==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50c1c0710f6so994359e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 05:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702041388; x=1702646188;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OGFeeZf5m0bMG5GtisyOq/eek7cqESU/OhJA19L9VA=;
        b=oL63oJlJCJtEqbBC1PN+vXrcWt/umiekMcXrMsNirzv9Y6k0GiR2nR9/y7LgyZKkxq
         3b73PJCV8K+um8aaowdaOIt//SYIN10tvty+f5si2BkhvkVHvboDb/RQXBWc6oJdvEfK
         LmSPrxOiKxNXIXjTaqWpYe8QRya2x8287cPI1cW7aJl7rat45Kdp08l6Ng9g0PCG8aEI
         XZnZA5lDGx+ZgAbM9IoFCT4RWB6h3dyzcSXYccImtq3XG4NuDHhppSu6JbmvhyMG/l5P
         jXAN7Qp/XSgiyFKZy0LQs8w8DeWtdG7n1xEhaALS4Fsbq0oL4wr7FgwRlVOz4BHTAB+G
         N3kg==
X-Gm-Message-State: AOJu0YwWDxpAdCT1dXJAkC+37cA0VLZhDcA0sSFG0KtXbkdBOEHRVvV5
        h3YzHzjKb4zT4tnfl964ak3WZGPU1YnjH9lOo2s85b5rbfz6l5Nkl8DmjCGRnYDNKWuMw8ohG/2
        A85Dt6nP19oFWjnpEXob4FBlFXvTCOjlw0twm/KsmDoai2tO8DEvW7FnBCg==
X-Received: by 2002:a19:9108:0:b0:50b:fd3c:5dab with SMTP id t8-20020a199108000000b0050bfd3c5dabmr66157lfd.27.1702041387910;
        Fri, 08 Dec 2023 05:16:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGksnQ48tiMDGwLrQKVaPnOs0v9pxKkmcT1acbXZkH1CCKvDD7B4YKfWLimQP/LAPMt6WElHwTfhZsSr/Lh3Sk=
X-Received: by 2002:a19:9108:0:b0:50b:fd3c:5dab with SMTP id
 t8-20020a199108000000b0050bfd3c5dabmr66137lfd.27.1702041387548; Fri, 08 Dec
 2023 05:16:27 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Dec 2023 07:16:26 -0600
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231206115000.295825-4-jeeheng.sia@starfivetech.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com> <20231206115000.295825-4-jeeheng.sia@starfivetech.com>
Mime-Version: 1.0
Date:   Fri, 8 Dec 2023 07:16:26 -0600
Message-ID: <CAJM55Z8_0ght6hH8j6JaEjA1eoiLxbaeX2-Juf=D0yk-wi5mqQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/16] clk: starfive: Rename file name "jh71x0" to "common"
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>, kernel@esmil.dk,
        conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        emil.renner.berthing@canonical.com, hal.feng@starfivetech.com,
        xingyu.wu@starfivetech.com
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        leyfoon.tan@starfivetech.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sia Jee Heng wrote:
> StarFive JH8100 shares a similar clock and reset design with JH7110.
> To facilitate the reuse of the file and its functionalities, files
> containing the "jh71x0" naming convention are renamed to use the
> "common" wording.
>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  drivers/clk/starfive/Kconfig                              | 8 ++++----
>  drivers/clk/starfive/Makefile                             | 2 +-
>  .../{clk-starfive-jh71x0.c => clk-starfive-common.c}      | 4 ++--
>  .../{clk-starfive-jh71x0.h => clk-starfive-common.h}      | 4 ++--
>  drivers/clk/starfive/clk-starfive-jh7100-audio.c          | 2 +-
>  drivers/clk/starfive/clk-starfive-jh7100.c                | 2 +-
>  drivers/clk/starfive/clk-starfive-jh7110.h                | 2 +-
>  7 files changed, 12 insertions(+), 12 deletions(-)
>  rename drivers/clk/starfive/{clk-starfive-jh71x0.c => clk-starfive-common.c} (99%)
>  rename drivers/clk/starfive/{clk-starfive-jh71x0.h => clk-starfive-common.h} (97%)
>
> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> index bd29358ffeec..ff8eace36e64 100644
> --- a/drivers/clk/starfive/Kconfig
> +++ b/drivers/clk/starfive/Kconfig
> @@ -1,12 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -config CLK_STARFIVE_JH71X0
> +config CLK_STARFIVE_COMMON
>  	bool
>
>  config CLK_STARFIVE_JH7100
>  	bool "StarFive JH7100 clock support"
>  	depends on ARCH_STARFIVE || COMPILE_TEST
> -	select CLK_STARFIVE_JH71X0
> +	select CLK_STARFIVE_COMMON
>  	default ARCH_STARFIVE
>  	help
>  	  Say yes here to support the clock controller on the StarFive JH7100
> @@ -15,7 +15,7 @@ config CLK_STARFIVE_JH7100
>  config CLK_STARFIVE_JH7100_AUDIO
>  	tristate "StarFive JH7100 audio clock support"
>  	depends on CLK_STARFIVE_JH7100
> -	select CLK_STARFIVE_JH71X0
> +	select CLK_STARFIVE_COMMON
>  	default m if ARCH_STARFIVE
>  	help
>  	  Say Y or M here to support the audio clocks on the StarFive JH7100
> @@ -33,7 +33,7 @@ config CLK_STARFIVE_JH7110_SYS
>  	bool "StarFive JH7110 system clock support"
>  	depends on ARCH_STARFIVE || COMPILE_TEST
>  	select AUXILIARY_BUS
> -	select CLK_STARFIVE_JH71X0
> +	select CLK_STARFIVE_COMMON
>  	select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
>  	select CLK_STARFIVE_JH7110_PLL
>  	default ARCH_STARFIVE
> diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
> index 199ac0f37a2f..012f7ee83f8e 100644
> --- a/drivers/clk/starfive/Makefile
> +++ b/drivers/clk/starfive/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_CLK_STARFIVE_JH71X0)	+= clk-starfive-jh71x0.o
> +obj-$(CONFIG_CLK_STARFIVE_COMMON)	+= clk-starfive-common.o
>
>  obj-$(CONFIG_CLK_STARFIVE_JH7100)	+= clk-starfive-jh7100.o
>  obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+= clk-starfive-jh7100-audio.o
> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-common.c
> similarity index 99%
> rename from drivers/clk/starfive/clk-starfive-jh71x0.c
> rename to drivers/clk/starfive/clk-starfive-common.c
> index aebc99264a0b..a12490c97957 100644
> --- a/drivers/clk/starfive/clk-starfive-jh71x0.c
> +++ b/drivers/clk/starfive/clk-starfive-common.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * StarFive JH71X0 Clock Generator Driver
> + * StarFive Clock Generator Driver
>   *
>   * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
>   */
> @@ -10,7 +10,7 @@
>  #include <linux/device.h>
>  #include <linux/io.h>
>
> -#include "clk-starfive-jh71x0.h"
> +#include "clk-starfive-common.h"
>
>  static struct jh71x0_clk *jh71x0_clk_from(struct clk_hw *hw)
>  {
> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-common.h
> similarity index 97%
> rename from drivers/clk/starfive/clk-starfive-jh71x0.h
> rename to drivers/clk/starfive/clk-starfive-common.h
> index 34bb11c72eb7..1f32f7024e9f 100644
> --- a/drivers/clk/starfive/clk-starfive-jh71x0.h
> +++ b/drivers/clk/starfive/clk-starfive-common.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __CLK_STARFIVE_JH71X0_H
> -#define __CLK_STARFIVE_JH71X0_H
> +#ifndef __CLK_STARFIVE_COMMON_H
> +#define __CLK_STARFIVE_COMMON_H
>
>  #include <linux/bits.h>
>  #include <linux/clk-provider.h>
> diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> index ee4bda14a40e..dc4c278606d7 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> @@ -15,7 +15,7 @@
>
>  #include <dt-bindings/clock/starfive-jh7100-audio.h>
>
> -#include "clk-starfive-jh71x0.h"
> +#include "clk-starfive-common.h"
>
>  /* external clocks */
>  #define JH7100_AUDCLK_AUDIO_SRC			(JH7100_AUDCLK_END + 0)
> diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
> index 69cc11ea7e33..6bb6a6af9f28 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7100.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7100.c
> @@ -15,7 +15,7 @@
>
>  #include <dt-bindings/clock/starfive-jh7100.h>
>
> -#include "clk-starfive-jh71x0.h"
> +#include "clk-starfive-common.h"
>
>  /* external clocks */
>  #define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + 0)
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110.h b/drivers/clk/starfive/clk-starfive-jh7110.h
> index 0659adae4d76..6b1bdf860f00 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110.h
> +++ b/drivers/clk/starfive/clk-starfive-jh7110.h
> @@ -2,7 +2,7 @@
>  #ifndef __CLK_STARFIVE_JH7110_H
>  #define __CLK_STARFIVE_JH7110_H
>
> -#include "clk-starfive-jh71x0.h"
> +#include "clk-starfive-common.h"
>
>  /* top clocks of ISP/VOUT domain from JH7110 SYSCRG */
>  struct jh7110_top_sysclk {
> --
> 2.34.1
>
