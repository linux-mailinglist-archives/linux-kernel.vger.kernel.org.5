Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1877F773F90
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjHHQtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjHHQss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:48:48 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBC144477
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:57:15 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b9a2416b1cso4969426a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510196; x=1692114996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6q8AWTQBFD8b34cUtgYL+witLNypid98p7CdPe4IBE=;
        b=Gj/GBrieD7aSggPe6Y+oAG5Wc9wDwnV3g3daa9uYCvuJtyB1VQq/YRQx6S8mU3HYS5
         bmk7aPoH6yutI1auQ4WiBuPgdRQBA/4+PMt2lRJRUS1pSGdkwUHEHBVSSDMYTOE+9VO5
         mp/7qwGT4fClfPO2HT1ZKQtM5YCXN0BHhbdx22y7Dv7MQ1XbRs8LOioJqoyw8ws/A7iL
         OxhJGTH9+0xz/p2k66j466C56mUj01uEwdGfxM7ivSbdMdv7xH9e1XBKmQyimy1ZkNfj
         OAdokVf5X1bwuZSSJkk0ac/XgSnq9Uaz1rH3LO4YDi4D3qrm8P+0jSKeQHEm8ffcbsGa
         33jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510196; x=1692114996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6q8AWTQBFD8b34cUtgYL+witLNypid98p7CdPe4IBE=;
        b=D29oAj/v+qipzFaFr9+JfeXWfBvgFNNIlm2bi8Nic6GYziCCjS4itXvEUY+bBRqmkW
         Ykhd0HITMZHpSeCG/5wF1SjqSwWCyj7Tg3OyoP5KbaDOxWMhBLXdVa8stP9SIP99Jz1A
         tw9NiRiWZcarhIHjTbSUVZHF8WZv6akBc7vc83izjvncSRC34/nQ5ZAO2WuYiKuKVbyV
         T3adBGUhhwiYaV+CNftfS0VAasiHBSKh1knpBNT+jNw7bGeCBaEkqqLwhPJ0gO6iwFCt
         FSZ6yuS5yn2bIy4pJVJxzngSkXWUtVueJb0y0AxLt4YvXScon7FKkwFplZeqouumre8p
         HGvg==
X-Gm-Message-State: AOJu0Yyso2AsV+c7hxdjh/4Re1sqsJmfMANlEUDl12DTlH3BgQEhrJCS
        ewtuR24B4HLAWn+TfeqU5roVSutAM34d1H+8v1eModZWhDlOaQsq
X-Google-Smtp-Source: AGHT+IHPeWlMhp/iuilCXvaLkenjZHEONKa+356uZo9i11tbs0WMo8B7ql77BuPz+mojouwmY87u8kqJrivnVxW927A=
X-Received: by 2002:a25:374c:0:b0:d0d:2d17:3f11 with SMTP id
 e73-20020a25374c000000b00d0d2d173f11mr12364694yba.17.1691503040670; Tue, 08
 Aug 2023 06:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230804233015.173957-1-limings@nvidia.com> <CAPDyKFprnX=37FDdBxiNyyr5X_6zpp87Kt7o1hxdRePZhMJO4A@mail.gmail.com>
 <BN9PR12MB506823B5AF3069C0C8350BE9D30DA@BN9PR12MB5068.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB506823B5AF3069C0C8350BE9D30DA@BN9PR12MB5068.namprd12.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 15:56:44 +0200
Message-ID: <CAPDyKFq+S544LFH_fMNucd8B8mrV9ORbL+v05q2EnWtgg+8ggA@mail.gmail.com>
Subject: Re: [PATCH v6] mmc: sdhci-of-dwcmshc: Add runtime PM operations
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 at 15:21, Liming Sun <limings@nvidia.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Tuesday, August 8, 2023 5:40 AM
> > To: Liming Sun <limings@nvidia.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>; David Thompson
> > <davthompson@nvidia.com>; Shawn Lin <shawn.lin@rock-chips.com>; linux-
> > mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v6] mmc: sdhci-of-dwcmshc: Add runtime PM operation=
s
> >
> > On Sat, 5 Aug 2023 at 01:30, Liming Sun <limings@nvidia.com> wrote:
> > >
> > > This commit implements the runtime PM operations to disable eMMC
> > > card clock when idle.
> > >
> > > Reviewed-by: David Thompson <davthompson@nvidia.com>
> > > Signed-off-by: Liming Sun <limings@nvidia.com>
> > > ---
> > > v5->v6:
> > >     - Address Adrian's more comments and add coordination between
> > >       runtime PM and system PM;
> > > v4->v5:
> > >     - Address Adrian's comment to move the pm_enable to the end to
> > >       avoid race;
> > > v3->v4:
> > >     - Fix compiling reported by 'kernel test robot';
> > > v2->v3:
> > >     - Revise the commit message;
> > > v1->v2:
> > >     Updates for comments from Ulf:
> > >     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
> > > v1: Initial version.
> > > ---
> > >  drivers/mmc/host/sdhci-of-dwcmshc.c | 72
> > ++++++++++++++++++++++++++++-
> > >  1 file changed, 70 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/s=
dhci-
> > of-dwcmshc.c
> > > index e68cd87998c8..aaf66358f626 100644
> > > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_device.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/reset.h>
> > >  #include <linux/sizes.h>
> > >
> > > @@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device
> > *pdev)
> > >
> > >         host->mmc->caps |=3D MMC_CAP_WAIT_WHILE_BUSY;
> > >
> > > +       pm_runtime_get_noresume(dev);
> > > +       pm_runtime_set_active(dev);
> > > +       pm_runtime_enable(dev);
> > > +
> > >         err =3D sdhci_setup_host(host);
> > >         if (err)
> > > -               goto err_clk;
> > > +               goto err_rpm;
> > >
> > >         if (rk_priv)
> > >                 dwcmshc_rk35xx_postinit(host, priv);
> > > @@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device
> > *pdev)
> > >         if (err)
> > >                 goto err_setup_host;
> > >
> > > +       pm_runtime_put_sync(dev);
> > > +
> >
> > The async pm_runtime_put() is probably sufficient - and it would allow
> > the probe to complete a bit "sooner".
>
> Sure, will test and update the line in v7.
>
> >
> > >         return 0;
> > >
> > >  err_setup_host:
> > >         sdhci_cleanup_host(host);
> > > +err_rpm:
> > > +       pm_runtime_disable(dev);
> > > +       pm_runtime_put_noidle(dev);
> > >  err_clk:
> > >         clk_disable_unprepare(pltfm_host->clk);
> > >         clk_disable_unprepare(priv->bus_clk);
> > > @@ -606,6 +616,12 @@ static int dwcmshc_suspend(struct device *dev)
> > >         if (ret)
> > >                 return ret;
> > >
> > > +       ret =3D pm_runtime_force_suspend(dev);
> >
> > Can dwcmshc_suspend() be called for a device that may be attached to
> > the ACPI PM domain?
>
> BlueField SoC is the only chip that uses ACPI in this driver for now and =
it doesn't support System Sleep. Thus, the dwcmshc_suspend() won't be calle=
d. But I guess it might be possible when other new chip support is added in=
to this driver. Is it a concern?

The ACPI PM domain doesn't support drivers using
pm_runtime_force_suspend|resume(). Unless that has been changed
without me knowing about it.

Anyway, it looks like it shouldn't be a problem at this point. We can
also add separate callbacks for other SoCs, if that comes into play
going forward.

[...]

Kind regards
Uffe
