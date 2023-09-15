Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234E57A1BED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjIOKV7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 06:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOKV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:21:57 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4DD1AE;
        Fri, 15 Sep 2023 03:21:52 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9adb9fa7200so358981566b.0;
        Fri, 15 Sep 2023 03:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694773310; x=1695378110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeroP2FcWVhozmtBWEw7Me43OWeaZ0iYsWXzbmy9YxQ=;
        b=u6OjwO01jJuaahB/QxUHsx6blCvJtXnMf7+rIx+yyfcjMLeqtxYnnFmgbesK6DxPXk
         ME+pAonKnfPYGzELFxkQWpUPcadKcJYL+jgIMxH/7eCTpjBrseux8CZiXo65mMs1K1sg
         vvPpGLHJ8gc4qcTAxrYbstANoqID9rhB5yLgbDxixSA5cvewlQUKVYx/gm2GYf/DYu1u
         g6J+Tnx+YSnO/ueiELcJYWPFpYhS9nJehCmdKJwZZSh+THhdu2PThxpyCmfyWcH8/FOA
         PYV8esqeMJdncnkWBkMUzaGdFFniJfsWj/rRBNCT37kdPR3hu11p63k2P6oeBMGtsdD/
         7pXQ==
X-Gm-Message-State: AOJu0YzLZ6S3iIDe5PUejFc4qJz7ot4z3bF1XPySIw00WaqBMj83jili
        O1Nms6fU8akByqEJoghC+pjkgCK3qqYXMg==
X-Google-Smtp-Source: AGHT+IHyImXuzvM7g/LJgNuL+MoJ7NU9SFbaIX9WTjma6TATIaZdBkZsuj5HFRY51lrGOgIqSfHmyQ==
X-Received: by 2002:a17:907:1c8b:b0:9a9:f6e7:43fe with SMTP id nb11-20020a1709071c8b00b009a9f6e743femr6678976ejc.24.1694773310084;
        Fri, 15 Sep 2023 03:21:50 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id gv23-20020a170906f11700b0098ec690e6d7sm2242399ejb.73.2023.09.15.03.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:21:49 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so4368013a12.0;
        Fri, 15 Sep 2023 03:21:49 -0700 (PDT)
X-Received: by 2002:a05:6402:2695:b0:52e:4789:bee2 with SMTP id
 w21-20020a056402269500b0052e4789bee2mr6586101edd.6.1694773309157; Fri, 15 Sep
 2023 03:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230915092003.658361-1-ulf.hansson@linaro.org> <20230915092003.658361-5-ulf.hansson@linaro.org>
In-Reply-To: <20230915092003.658361-5-ulf.hansson@linaro.org>
From:   Neal Gompa <neal@gompa.dev>
Date:   Fri, 15 Sep 2023 06:21:12 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-hNCuKfr_g1Wrp7uYWMmoj4=3NY86oR1wEqPc1wX9jqw@mail.gmail.com>
Message-ID: <CAEg-Je-hNCuKfr_g1Wrp7uYWMmoj4=3NY86oR1wEqPc1wX9jqw@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] pmdomain: apple: Move Kconfig option to the
 pmdomain subsystem
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 5:29 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The Kconfig option belongs closer to the corresponding implementation,
> hence let's move it from the soc subsystem to the pmdomain subsystem.
>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: Sven Peter <sven@svenpeter.dev>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: <asahi@lists.linux.dev>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/pmdomain/Kconfig       |  1 +
>  drivers/pmdomain/apple/Kconfig | 18 ++++++++++++++++++
>  drivers/soc/apple/Kconfig      | 13 -------------
>  3 files changed, 19 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/pmdomain/apple/Kconfig
>
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index 03c8991ad0fd..482d9e970e14 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -3,5 +3,6 @@ menu "PM Domains"
>
>  source "drivers/pmdomain/actions/Kconfig"
>  source "drivers/pmdomain/amlogic/Kconfig"
> +source "drivers/pmdomain/apple/Kconfig"
>
>  endmenu
> diff --git a/drivers/pmdomain/apple/Kconfig b/drivers/pmdomain/apple/Kconfig
> new file mode 100644
> index 000000000000..12237cbcfaa9
> --- /dev/null
> +++ b/drivers/pmdomain/apple/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +if ARCH_APPLE || COMPILE_TEST
> +
> +config APPLE_PMGR_PWRSTATE
> +       bool "Apple SoC PMGR power state control"
> +       depends on PM
> +       select REGMAP
> +       select MFD_SYSCON
> +       select PM_GENERIC_DOMAINS
> +       select RESET_CONTROLLER
> +       default ARCH_APPLE
> +       help
> +         The PMGR block in Apple SoCs provides high-level power state
> +         controls for SoC devices. This driver manages them through the
> +         generic power domain framework, and also provides reset support.
> +
> +endif
> diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
> index a1596fefacff..eff486a77337 100644
> --- a/drivers/soc/apple/Kconfig
> +++ b/drivers/soc/apple/Kconfig
> @@ -4,19 +4,6 @@ if ARCH_APPLE || COMPILE_TEST
>
>  menu "Apple SoC drivers"
>
> -config APPLE_PMGR_PWRSTATE
> -       bool "Apple SoC PMGR power state control"
> -       depends on PM
> -       select REGMAP
> -       select MFD_SYSCON
> -       select PM_GENERIC_DOMAINS
> -       select RESET_CONTROLLER
> -       default ARCH_APPLE
> -       help
> -         The PMGR block in Apple SoCs provides high-level power state
> -         controls for SoC devices. This driver manages them through the
> -         generic power domain framework, and also provides reset support.
> -
>  config APPLE_RTKIT
>         tristate "Apple RTKit co-processor IPC protocol"
>         depends on MAILBOX
> --
> 2.34.1
>
>

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
