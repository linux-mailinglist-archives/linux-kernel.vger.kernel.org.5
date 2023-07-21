Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659EF75C423
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjGUKL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjGUKLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:11:49 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546612D7B;
        Fri, 21 Jul 2023 03:11:45 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4716e4adb14so777834e0c.0;
        Fri, 21 Jul 2023 03:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934304; x=1690539104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8C4HGq6Loc8xIIi+flmd4/EO39MhWP8WepSaiqIPbk=;
        b=doMYJWkJTTU5T/kTl+KSJN3R0Rjfz4fJa1oi7RQ/TKRtfqkjPIwtO6LhFWw6Pezx08
         O0SPgf40mNDYJ8VwPN46Sj9wQ0m+knJSwZNiZIOP+rli+rMLen3/iqWx0ztCgPWTS1d/
         lzy0Z69fWy+CQBheMcDsQYDMqkYGIq3tqPjU3bLALUdQW73iWYP/nQHzUlkDVzOHICh+
         tU9h3E85Lx0MyTBXirZOX2A7ysoIfnmeq392hR4dzC/gzKnXG8rICY2ni45J460OjxCm
         zoiHyNbtGbyV8j6mWOpYbpkGOysZP1FBTL6osYs6TjVpYAeRS+cY/+kCh1aaceGsTewS
         CHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934304; x=1690539104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8C4HGq6Loc8xIIi+flmd4/EO39MhWP8WepSaiqIPbk=;
        b=IOWLGSEYDwXnZGikzR8I5g/vfiBxtn8ASoJnYHqKak772SP373BCBXprv2xBeg71fA
         RdqP+OJhR4NqCp7wzP5XUXD4WAgAuk/LVvKBWFU3+EA0DUH7lSt+dNCyx77kEogtEPzc
         IgjUs8ha8t3uj/+8ceDFFwMTFlOlmx4leVMiublQmBohnJO//bhTYNQRnCxw8LIM6MJD
         o8xk+HfT4YKvkJdFlTyNglepPMqyW3Jo7ZdoseI0Ph21endxS16TB3O5frMVwdEGdSOy
         IsldHNEXbW4uX+KgFjJI1Cihqdkih3G6O2B5qD7WqACXOkky+3+4IkX8WZStRJxF6hXH
         SSGQ==
X-Gm-Message-State: ABy/qLYYvXExHV/R5MvBKBlRv+P2EoBUwgOpSkGQKxat1eZahnjMcJS0
        wIcM74nMjPBECWRS4csH4gARAZ7r1SKpW4Gjn9f+j20OBls=
X-Google-Smtp-Source: APBJJlF2O5T3RtZj8GzZL1P04dS0oB8qknRqFYmm3sqLJP4yd3U97BpStifUn8I3MTUkUc92lZPO/BysUm3gPB1Uwqo=
X-Received: by 2002:a1f:4592:0:b0:471:9190:fa09 with SMTP id
 s140-20020a1f4592000000b004719190fa09mr852829vka.7.1689934304324; Fri, 21 Jul
 2023 03:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <20230621100151.6329-9-victorshihgli@gmail.com> <d8d7a64b-3640-d695-8f07-a75b702e32cf@intel.com>
In-Reply-To: <d8d7a64b-3640-d695-8f07-a75b702e32cf@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 21 Jul 2023 18:11:32 +0800
Message-ID: <CAK00qKCUtuQBVWmsF4NUv6iyFFdJ4R52iZ4BtmUU3UVB8mJ-+g@mail.gmail.com>
Subject: Re: [PATCH V8 08/23] mmc: sdhci: add UHS-II module and add a kernel configuration
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 12:01=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 21/06/23 13:01, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This patch adds sdhci-uhs2.c as a module for UHS-II support.
> > This is a skelton for further development in this patch series.
>
> skelton -> skeleton
>

Hi, Adrian

      I will fix it in the V9 version.

Thanks, Victor Shih

> >
> > This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
> > in the following commits to indicate UHS-II specific code in sdhci
> > controllers.
> >
> > Updates in V8:
> >  - Modify MODULE_LICENSE from "GPL v2" to "GPL".
> >
> > Updates in V6:
> >  - Merage V5 of patch[7] and patch[9] in to V6 of patch[8].
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/Kconfig      |  9 +++++++
> >  drivers/mmc/host/Makefile     |  1 +
> >  drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 56 insertions(+)
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 159a3e9490ae..215f1ab011dd 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -98,6 +98,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> >
> >         This is the case for the Nintendo Wii SDHCI.
> >
> > +config MMC_SDHCI_UHS2
> > +     tristate "UHS2 support on SDHCI controller"
> > +     depends on MMC_SDHCI
> > +     help
> > +       This option is selected by SDHCI controller drivers that want t=
o
> > +       support UHS2-capable devices.
> > +
> > +       If you have a controller with this feature, say Y or M here.
> > +
> >  config MMC_SDHCI_PCI
> >       tristate "SDHCI support on PCI bus"
> >       depends on MMC_SDHCI && PCI
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index a693fa3d3f1c..799f21d1f81f 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)               +=3D pxamci.o
> >  obj-$(CONFIG_MMC_MXC)                +=3D mxcmmc.o
> >  obj-$(CONFIG_MMC_MXS)                +=3D mxs-mmc.o
> >  obj-$(CONFIG_MMC_SDHCI)              +=3D sdhci.o
> > +obj-$(CONFIG_MMC_SDHCI_UHS2) +=3D sdhci-uhs2.o
> >  obj-$(CONFIG_MMC_SDHCI_PCI)  +=3D sdhci-pci.o
> >  sdhci-pci-y                  +=3D sdhci-pci-core.o sdhci-pci-o2micro.o=
 sdhci-pci-arasan.o \
> >                                  sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > new file mode 100644
> > index 000000000000..608f8ad5aaed
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -0,0 +1,46 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controll=
er
> > + *  Interface driver
> > + *
> > + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> > + *  Copyright (C) 2020 Genesys Logic, Inc.
> > + *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > + *  Copyright (C) 2020 Linaro Limited
> > + *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > + */
> > +
> > +#include <linux/module.h>
> > +
> > +#include "sdhci.h"
> > +#include "sdhci-uhs2.h"
> > +
> > +#define DRIVER_NAME "sdhci_uhs2"
> > +#define DBG(f, x...) \
> > +     pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
> > +
> > +/*********************************************************************=
********\
> > + *                                                                    =
       *
> > + * Driver init/exit                                                   =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int __init sdhci_uhs2_mod_init(void)
> > +{
> > +     return 0;
> > +}
> > +module_init(sdhci_uhs2_mod_init);
> > +
> > +static void __exit sdhci_uhs2_mod_exit(void)
> > +{
> > +}
> > +module_exit(sdhci_uhs2_mod_exit);
> > +
> > +MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
> > +MODULE_DESCRIPTION("MMC UHS-II Support");
> > +MODULE_LICENSE("GPL");
>
