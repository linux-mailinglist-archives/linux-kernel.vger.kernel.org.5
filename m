Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D19F763650
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjGZM1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjGZM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:27:29 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5970326BE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:27:26 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-583ae4818c8so58761357b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690374445; x=1690979245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xytvwAV0BU3B8ZVId1NpX2j1ZIQGa+bfPlc5rTSIhmg=;
        b=oTKgk6cvDOz/jzdgKjaJ/cQ92upctsVgYslejhg9gbqdnrHGZchEpRr2h6TZdVnSVL
         2CIiK8d5BoudJuVraCxOMWGow345fmPGb11JwNyD6w3V7FlUA+5vPpMc8aYgxLwzt51q
         94AxY7jxE7cmlWOf4vdp0sq1VSF8Gp2eYS9/8F541mgnEzCG/yxqJsxsMSR8QPZEABH6
         DxBerXsO99pRhgQgIgDS34ZUe7735VWt8CEfXe0qBk86t6jvehPK8aJiP8GldQYl8XB3
         388monTXyn5bGHuR5nsKd6YiyghDoxTrJcdx45OnwjAJyUcspIhbijXlkoPnZT33LilO
         rnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690374445; x=1690979245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xytvwAV0BU3B8ZVId1NpX2j1ZIQGa+bfPlc5rTSIhmg=;
        b=Qqv4KQaXrne78ICxL3HiYTaHfptkeIAOn1SYtFgMEEfr+0sDSMhWn3rEYYsuZPEx6U
         qZDbJ8yQlK2cYThYHuDusrdHqradSuXvcWOMF683h8A4gCh+CaV4VFNvlaUPP5/5lnaC
         TAbgQqoFccQByUEwNXiZZ+fhIqQ++x2EqMkWNB6BXIHF57W5xJEmiA7dY/xWPJTcF1/n
         gEKK8VaNviQKEmQgFWYuXMY3X2Rc6I8cW+gQPPRSIiV5HKKpllae7QAGj+XLFVYz2lKy
         1ys6CYX0CU6ZJFRx9bW5fVcOu6ethHF0PDgw0M+US7YHKG+4RLJkE85RSsb5DWBHNIW8
         MC4g==
X-Gm-Message-State: ABy/qLYHSu/LMKMof7yr0QKrfoK79UIWZft5UxTTc005LAaAAL+NegvJ
        3bdiaHvgrsblPLLqJksMnQkghVMD3pojtZVney/OIw==
X-Google-Smtp-Source: APBJJlFD6NN6UJlweoiYrZKDWs+FEhc/yYSNPE0vEJMiGVh/uOHAYCGmBapgIdDiMjb2gHQrywGtB5CGPsA9pSIi5hc=
X-Received: by 2002:a25:804f:0:b0:cb4:469e:3308 with SMTP id
 a15-20020a25804f000000b00cb4469e3308mr1464176ybn.6.1690374445384; Wed, 26 Jul
 2023 05:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230726121724.3701240-1-arnd@kernel.org> <20230726121724.3701240-2-arnd@kernel.org>
In-Reply-To: <20230726121724.3701240-2-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Jul 2023 14:26:49 +0200
Message-ID: <CAPDyKFph13af0+47=TtG--WZ+A+H7qpz7158cAZ8=xo39Tdzbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] genpd: move owl-sps-helper.c from drivers/soc
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Conor Dooley <conor.dooley@microchip.com>,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Walker Chen <walker.chen@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
> Moving only one of the two files in drivers/soc/actions to drivers/genpd
> caused a link failure in allmodconfig, as drivers/genpd is entered
> for compile testing, but drivers/soc/actions accidentally got skipped:
>
> x86_64-linux-gnu-ld: vmlinux.o: in function `owl_sps_set_power':
> owl-sps.c:(.text+0x16e259d): undefined reference to `owl_sps_set_pg'
>
> Move the other one as well to allow build testing to work correctly.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd!

I have added this to my immutable genpd branch too:

git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git genpd_create_dir

Kind regards
Uffe


> ---
>  drivers/genpd/actions/Makefile                  | 1 +
>  drivers/{soc => genpd}/actions/owl-sps-helper.c | 0
>  drivers/soc/Makefile                            | 1 -
>  drivers/soc/actions/Makefile                    | 3 ---
>  4 files changed, 1 insertion(+), 4 deletions(-)
>  rename drivers/{soc => genpd}/actions/owl-sps-helper.c (100%)
>  delete mode 100644 drivers/soc/actions/Makefile
>
> diff --git a/drivers/genpd/actions/Makefile b/drivers/genpd/actions/Makefile
> index e78c420a24540..7e8aa473d12d1 100644
> --- a/drivers/genpd/actions/Makefile
> +++ b/drivers/genpd/actions/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0+
> +obj-$(CONFIG_OWL_PM_DOMAINS_HELPER)    += owl-sps-helper.o
>  obj-$(CONFIG_OWL_PM_DOMAINS)           += owl-sps.o
> diff --git a/drivers/soc/actions/owl-sps-helper.c b/drivers/genpd/actions/owl-sps-helper.c
> similarity index 100%
> rename from drivers/soc/actions/owl-sps-helper.c
> rename to drivers/genpd/actions/owl-sps-helper.c
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index efdcd42f68cb3..708eaad8f590d 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -3,7 +3,6 @@
>  # Makefile for the Linux Kernel SOC specific device drivers.
>  #
>
> -obj-$(CONFIG_ARCH_ACTIONS)     += actions/
>  obj-y                          += apple/
>  obj-y                          += aspeed/
>  obj-$(CONFIG_ARCH_AT91)                += atmel/
> diff --git a/drivers/soc/actions/Makefile b/drivers/soc/actions/Makefile
> deleted file mode 100644
> index 4ac88fec2050a..0000000000000
> --- a/drivers/soc/actions/Makefile
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0+
> -
> -obj-$(CONFIG_OWL_PM_DOMAINS_HELPER) += owl-sps-helper.o
> --
> 2.39.2
>
