Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328817A0636
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbjINNgw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 09:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbjINNgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:36:37 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8353C2D;
        Thu, 14 Sep 2023 06:34:34 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so1192498a12.0;
        Thu, 14 Sep 2023 06:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694698472; x=1695303272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpUIdnK9U7Z8dFu+3u/h7aGjExjlf4tG3qsuv5njPLM=;
        b=TR1x7jsDmqdxi0XwQF54fUixXaMuNUjTQvpjE+RF3FRuAe7jqKAhRaTNO1cnEV9evm
         wbGZ+/djqqClD9U0F5AGRwoTtyHX4/FIR6tvm+g8JX1rcGQmZvSPl5rVOIxDCUbCrvgJ
         m9jz+UuKC5S+r9s/PBBKKcljewvMNJJtyM6SeNAIwRSowMgf6d07dvuVUzTh0yMoNQSp
         HYsxs70w/AFs1q0u+H2Iv3y0ADBJigZYZvTx2R4COPEexRxgrFB+nySxNMi6tSn0vMlw
         ICXxw6S7tm1dYMr8+Zs/v/pVi7ZRROhh0c2iDRrErCKYRk4SzkkYrnHQq+4YjQuBTZCQ
         VQLQ==
X-Gm-Message-State: AOJu0Yzyelauh5Q7Tpp51w5h8qrnu1UrBZb/TGtDPoNxCOajmQb/8xQG
        nz3LNdNxXkMVAXEFla0UzCQAR0GjqikXPr+J
X-Google-Smtp-Source: AGHT+IHoSHhBHzdoVOZoVSlVzWh5mQfZXtJugX/ClqLHOgwOtBJL9kyIMToqjtkpdfJMnigafX/SEg==
X-Received: by 2002:a17:906:3195:b0:9a1:be5b:f499 with SMTP id 21-20020a170906319500b009a1be5bf499mr4092592ejy.24.1694698472201;
        Thu, 14 Sep 2023 06:34:32 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id q21-20020a1709066b1500b0098921e1b064sm1019750ejr.181.2023.09.14.06.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 06:34:32 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso127015066b.1;
        Thu, 14 Sep 2023 06:34:32 -0700 (PDT)
X-Received: by 2002:a17:906:2182:b0:9a5:c79f:bed5 with SMTP id
 2-20020a170906218200b009a5c79fbed5mr4416706eju.16.1694698471866; Thu, 14 Sep
 2023 06:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230914111712.586522-1-ulf.hansson@linaro.org>
In-Reply-To: <20230914111712.586522-1-ulf.hansson@linaro.org>
From:   Neal Gompa <neal@gompa.dev>
Date:   Thu, 14 Sep 2023 09:33:55 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_Goo+8NVXzF3m4zocNwCpE0kGty2aDpMj+zKoy616vbA@mail.gmail.com>
Message-ID: <CAEg-Je_Goo+8NVXzF3m4zocNwCpE0kGty2aDpMj+zKoy616vbA@mail.gmail.com>
Subject: Re: [PATCH 04/17] pmdomain: apple: Move Kconfig option to the
 pmdomain subsystem
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 7:17 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
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
> index 07d2f8165abe..55a9ca191849 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -3,5 +3,6 @@ menu "Power Domains Support"
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

Makes sense to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
