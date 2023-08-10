Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9613F7775AB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjHJKWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjHJKWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:22:13 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DFD9F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:22:12 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d659ad4af70so16158276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691662932; x=1692267732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zO4KyyuaXtRM/oTROtyRhv+QW9j9ZaqNkf8KIDhgR1g=;
        b=h03HkvqsbQUpUNbxXk8ASTVVIlMS5wyQ5GIV9h7Idn3Vy+0swCp0zzFITe4dV2Bb57
         kyg6/JMeLXn1TFp/Y+xqYjsSGV+EXhtPtkFXYlMD62WoTWWaiyhOcYpM/RlE8QXxgpIk
         9B7HveL6GlWrwC9FyBnMDm8XqdMyXG91O6dBtMgWAtedLDg6zuX14DDiUMPUjNyn+FRh
         fD9fFwdYNop4Z9L7ET/si54xPEbqJ7JtGG4QI1KTCLP4Qt/Vo/DjonsClLlYVcE+9Jwb
         lpWLW54HPMjgVo0HNVrgIhFJCUlSh78qPLFkBSvNeFnhFG4M23RJMo8XbtSYqYRD8Ky4
         jmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691662932; x=1692267732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zO4KyyuaXtRM/oTROtyRhv+QW9j9ZaqNkf8KIDhgR1g=;
        b=O1660KfsLKdy7xE8+51PPtipWs/a5puGbQUg+Synacox1MYKrMyGToc8dxXi4JeUbe
         rFk45yy1MWpwE6JAC6CDMbZiG6HeKTfFLHwb22QmwHOb/3tHyq21NqTOYwPjheAgBud6
         4ed0YTk3zsjxI0n9vVPskqYLu8p5TIiSj+1SgNZ8ZVnKkLjuIeoAYf705pBIs9DLNU4e
         j+gqc79gLXfSCHbDgHL2Hmdn26cp3Kolu2E0PwhXCYQTsYkAtHnVgoHmhhVcI2cpdSbj
         F85yjPnuAvNE0PmM2fH7px8Na4MJgKh4YxYMwcXZSYa74X4UaI7MIqZmnSGktB6ZxYu2
         gfuw==
X-Gm-Message-State: AOJu0YzQzeoxgVmB0/olpsE+JbYHw/Di+yfNOQP1EzYnxGsT1TWTif2N
        y+IGhVLrbDwjd/b7FzokkTqDtUJIga/JCsJWpSUPLA==
X-Google-Smtp-Source: AGHT+IElrj9Okjsl2TmHt5zBVp6IvD+QWVOR0hppYxe14YtyWS4pktSp8ZRF4NbazB57+lzeN8oe4Jz8EGzZ83NYt8A=
X-Received: by 2002:a25:ad20:0:b0:cb6:4943:a021 with SMTP id
 y32-20020a25ad20000000b00cb64943a021mr2380449ybi.7.1691662931757; Thu, 10 Aug
 2023 03:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230808202319.191434-1-limings@nvidia.com> <16047c7a-5bd1-868c-e6eb-e5f415e77fdd@intel.com>
In-Reply-To: <16047c7a-5bd1-868c-e6eb-e5f415e77fdd@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 10 Aug 2023 12:21:35 +0200
Message-ID: <CAPDyKFp28mmbRAGf14u8KTO3v7H=SFAYbwcz7xeb1m4tD_G2vQ@mail.gmail.com>
Subject: Re: [PATCH v7] mmc: sdhci-of-dwcmshc: Add runtime PM operations
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Liming Sun <limings@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 at 10:13, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 8/08/23 23:23, Liming Sun wrote:
> > This commit implements the runtime PM operations to disable eMMC
> > card clock when idle.
> >
> > Reviewed-by: David Thompson <davthompson@nvidia.com>
> > Signed-off-by: Liming Sun <limings@nvidia.com>
> > ---
> > v6->v7:
> >     - Address Ulf's comment;
> > v5->v6:
> >     - Address Adrian's more comments and add coordination between
> >       runtime PM and system PM;
> > v4->v5:
> >     - Address Adrian's comment to move the pm_enable to the end to
> >       avoid race;
> > v3->v4:
> >     - Fix compiling reported by 'kernel test robot';
> > v2->v3:
> >     - Revise the commit message;
> > v1->v2:
> >     Updates for comments from Ulf:
> >     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
> > v1: Initial version.
> > ---
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 72 ++++++++++++++++++++++++++++-
> >  1 file changed, 70 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index e68cd87998c8..c8e145031429 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/reset.h>
> >  #include <linux/sizes.h>
> >
> > @@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >
> >       host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> >
> > +     pm_runtime_get_noresume(dev);
> > +     pm_runtime_set_active(dev);
> > +     pm_runtime_enable(dev);
> > +
> >       err = sdhci_setup_host(host);
> >       if (err)
> > -             goto err_clk;
> > +             goto err_rpm;
> >
> >       if (rk_priv)
> >               dwcmshc_rk35xx_postinit(host, priv);
> > @@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >       if (err)
> >               goto err_setup_host;
> >
> > +     pm_runtime_put(dev);
> > +
> >       return 0;
> >
> >  err_setup_host:
> >       sdhci_cleanup_host(host);
> > +err_rpm:
> > +     pm_runtime_disable(dev);
> > +     pm_runtime_put_noidle(dev);
> >  err_clk:
> >       clk_disable_unprepare(pltfm_host->clk);
> >       clk_disable_unprepare(priv->bus_clk);
> > @@ -606,6 +616,12 @@ static int dwcmshc_suspend(struct device *dev)
> >       if (ret)
> >               return ret;
> >
> > +     ret = pm_runtime_force_suspend(dev);
> > +     if (ret) {
> > +             sdhci_resume_host(host);
> > +             return ret;
> > +     }
>
> Since you are only using the runtime PM callbacks to turn off the card
> clock via SDHCI_CLOCK_CONTROL, pm_runtime_force_suspend() and
> pm_runtime_force_resume() are not needed at all.

Right, it can be done without these too.

>
> sdhci_suspend_host() does not care if SDHCI_CLOCK_CARD_EN is on or off.
> (And you are disabling pltfm_host->clk and priv->bus_clk, so presumably
> the result is no clock either way)
>
> sdhci_resume_host() does not restore state unless
> SDHCI_QUIRK2_HOST_OFF_CARD_ON is used, it just resets, so the internal clock
> SDHCI_CLOCK_INT_EN is off which is consistent with either runtime suspended
> or runtime resumed.

Even if this may work, to me, it doesn't look like good practice for
how to use runtime PM in combination with system wide suspend/resume.

The point is, sdhci_suspend|resume_host() may end up reading/writing
to sdhci registers - and we should *not* allow that (because it may
not always work), unless the sdhci controller has been runtime resumed
first, right?

[...]

Kind regards
Uffe
