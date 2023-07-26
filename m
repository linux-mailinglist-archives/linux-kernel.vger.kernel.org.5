Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8946576364C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjGZM1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGZM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:27:16 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1151BE3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:27:15 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9c9944da8so5518720a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690374434; x=1690979234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CM3hiGl9z/rtYcMF0BH0vmLxKeA8C/hk1KBXUt3g7gs=;
        b=TVbmMEOuCpU0fGkLFxHXjeK63YH6mzE8KNsFx6AVScyOs4b0FN52NAPMhVnH4rNIYX
         zZsCYsnChLx5jc8NQpbFGALWg47cHbF3kaV6usLFsJ1pLsq9Vv9fLdwq1B5+VKT9i/Hy
         J2plnjnfmbEr/nyUnlQbgNgvwEFsiqLuMBvHTsByWe/N6guU7JOMyWMnzrweIMqFygJf
         Sh5xzgDT6AAHcfiYwMAO/L4vw2n3cOxbyyvO5c+uWYqimDBo2Wvmeu+Z0DTuhUyZ7Fuj
         5/PYnbHhsJ5kiMPoQj3poVh1qjTjYFyQGTKh05CvbnewMu/LoF/kquVxt5H14kJqwFU6
         Cm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690374434; x=1690979234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CM3hiGl9z/rtYcMF0BH0vmLxKeA8C/hk1KBXUt3g7gs=;
        b=K2OZSh+tyvh2UWfqpHfa3/CFpgSpdghjttimJCbdnc/Z7pBtpU2CeNeDCxcMpGQMiw
         TWOtn5ApIE7qAXPIG4wlUGuKTbYHqOo9mfME+2CM7tcnYYxYCen8W2cYk6dlVhJ+9G6/
         NwNlrlGlxlEgQ/zgemMyX7K3SGg3B/4mUA3EPyTG9LxFcbtXZDK9PmpK+zQi/XPwk765
         nfn7/ezyktZINbUeJJtKeirgISPQvKyMQZJryoBdZ8ZMvQt9zjU8HHIY9FkffCia6CDJ
         /v2uG3MbG3VSBOoBdTXiOOFuz0xCMYpVD2VnC6OPoPsuZi5ljwI9Z5Yfz9i0lMJVe8jM
         +QMQ==
X-Gm-Message-State: ABy/qLZWiCOhwcdAVqttjFRdQ5IcsiqTPEIbkC6IJ/traHH91SE2fE+9
        Xc5E4lgI0ms05rDS9m7DZOlG2KFGk0WswSfIb5cKJg==
X-Google-Smtp-Source: APBJJlFJ9S9Zmaq1XO3jvFbcO9Eq1dpSS4Y5AhgxX/HP2Z2YwtT5buI9b4vn8pnbQx+oq10ptshSzpSzq/qorBhCldo=
X-Received: by 2002:a05:6358:428f:b0:134:dc90:b7d1 with SMTP id
 s15-20020a056358428f00b00134dc90b7d1mr2114354rwc.25.1690374434346; Wed, 26
 Jul 2023 05:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230726121724.3701240-1-arnd@kernel.org>
In-Reply-To: <20230726121724.3701240-1-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Jul 2023 14:26:38 +0200
Message-ID: <CAPDyKFroYh348BUBBfNC7UUVZHUefy1b5UHN9vkrdsOg-CU_Aw@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: starfive: remove stale Makefile entry
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Walker Chen <walker.chen@starfivetech.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 at 14:17, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> After the only starfive driver was moved out to the genpd subsystem, we get
> a build failure:
>
> scripts/Makefile.build:41: drivers/soc/starfive/Makefile: No such file or directory
>
> Fixes: f3fb16291f486 ("soc: starfive: Move the power-domain driver to the genpd dir")
> Reported=by: kernel test robot <lkp@intel.com
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd!

I have added this to my immutable genpd branch too:

git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git genpd_create_dir

Kind regards
Uffe


> ---
>  drivers/soc/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 3b0f9fb3b5c84..efdcd42f68cb3 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -29,7 +29,6 @@ obj-y                         += renesas/
>  obj-y                          += rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)      += samsung/
>  obj-y                          += sifive/
> -obj-$(CONFIG_SOC_STARFIVE)     += starfive/
>  obj-y                          += sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)       += tegra/
>  obj-y                          += ti/
> --
> 2.39.2
>
