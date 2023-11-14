Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EB97EB4B0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjKNQXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKNQXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:23:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4158510D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:23:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40a46ea95f0so37052715e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699979017; x=1700583817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gz70NjtMqfOHarEC11NDfoSuQm8/yNERwJUtrYzlAug=;
        b=UiwnzahQaJJsHcT3j5svkfy2dUee1+yiBQjH9txDLPSb9dfBNjLHgcoPy4Ou00DBn+
         /pAtYk2+9Tuc3eJg9RQdS91mRraUUC0naGi9tNnxBUdMQXm95DJCDePEaSJwIdB8uZl/
         G3p5gQiCty1ZHuOgPmcx8qoyxnIyNH4YTzKFAUZNKrzvgaEShCn2mB94mI0Cfp2RdncA
         3A6WiW+nLm1ytm+ST5cAPYqSMCt5+Akj7vDWLWhWHoJnfCC+6wtaJeqZalmrrH2QGfhF
         NKtIDRCiNLur+tkmULc34Yy2ag4JjcoHDlzERQTxD1SewxKdyl7xeCnbTNAOr4ar3cyS
         b8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699979017; x=1700583817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gz70NjtMqfOHarEC11NDfoSuQm8/yNERwJUtrYzlAug=;
        b=iL0lcYuhW8xqAysazOSUPbf1ILIIQ4+iM1jOT4RFR1yvzfZwXll2nM4K8kPseZ0+bk
         4YCed7ythcjS7yduKEzLcXlDs3ITlLeSK8fZa0KBejDbC04asj9wheWEWXmQ3/kkoEKc
         Gwo+ZJ6xGz7Yg/fknSf7e/BzOrL9ZqZyXbLduT2ur7hlU4QeVh/Boaa0dBEB0If8rte6
         nDsUMn7XM2CSdzN3Q3EijCx6pDBvWvPNNKaAokS+z1a73dWAxFeIYnQFzKh9X/50nlnl
         cpM6o1uU2/13qs3rj/U95sNnbiAga2SGTqDT7EzZRhTDbOeo39F7yCv3sYVQyrpLSSQn
         0mMQ==
X-Gm-Message-State: AOJu0YzAyWG1RgV2a8N+7hpWoTb3wf2yB1dgQPP6kcpga7Q0LTLFiouJ
        5Q8l7TxoUaQ95zAks5+u8HMQuzdDhxAThAhFE+TBDg==
X-Google-Smtp-Source: AGHT+IHvx+Q8rLFCu1dTpyDyePF2UPHPScKHmc0NeQJgE8fGfmww0FS4y4jLfKJAPzOWQAdIBgio70VcJshYkGZjuK0=
X-Received: by 2002:a5d:4492:0:b0:31f:ef77:67ee with SMTP id
 j18-20020a5d4492000000b0031fef7767eemr7482714wrq.40.1699979016635; Tue, 14
 Nov 2023 08:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20231014231548.637303-1-tanmay.shah@amd.com> <20231014231548.637303-2-tanmay.shah@amd.com>
 <dznmvir337tb455usswkrvovf34urgyejkrt7rduscbepd2wg3@7atos56utizw>
In-Reply-To: <dznmvir337tb455usswkrvovf34urgyejkrt7rduscbepd2wg3@7atos56utizw>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 14 Nov 2023 09:23:24 -0700
Message-ID: <CANLsYky+6=tvAHE408pGg_=YTUM4eH6ovwn--h2iuaNMGwRF+Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] remoteproc: Make rproc_get_by_phandle()
 work for clusters
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Tanmay Shah <tanmay.shah@amd.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Levinsky <ben.levinsky@xilinx.com>,
        Ben Levinsky <ben.levinsky@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 08:22, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Sat, Oct 14, 2023 at 04:15:47PM -0700, Tanmay Shah wrote:
> > From: Mathieu Poirier <mathieu.poirier@linaro.org>
> >
> > Multi-cluster remoteproc designs typically have the following DT
> > declaration:
> >
> >       remoteproc_cluster {
> >               compatible = "soc,remoteproc-cluster";
> >
> >                 core0: core0 {
> >                       compatible = "soc,remoteproc-core"
> >                         memory-region;
> >                         sram;
> >                 };
> >
> >                 core1: core1 {
> >                       compatible = "soc,remoteproc-core"
> >                         memory-region;
> >                         sram;
> >                 }
> >         };
> >
> > A driver exists for the cluster rather than the individual cores
> > themselves so that operation mode and HW specific configurations
> > applicable to the cluster can be made.
> >
> > Because the driver exists at the cluster level and not the individual
> > core level, function rproc_get_by_phandle() fails to return the
> > remoteproc associated with the phandled it is called for.
> >
> > This patch enhances rproc_get_by_phandle() by looking for the cluster's
> > driver when the driver for the immediate remoteproc's parent is not
> > found.
> >
> > Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Tested-by: Ben Levinsky <ben.levinsky@amd.com>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 695cce218e8c..3a8191803885 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/elf.h>
> >  #include <linux/crc32.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/of_reserved_mem.h>
> >  #include <linux/virtio_ids.h>
> >  #include <linux/virtio_ring.h>
> > @@ -2111,7 +2112,9 @@ EXPORT_SYMBOL(rproc_detach);
> >  #ifdef CONFIG_OF
> >  struct rproc *rproc_get_by_phandle(phandle phandle)
> >  {
> > +     struct platform_device *cluster_pdev;
> >       struct rproc *rproc = NULL, *r;
> > +     struct device_driver *driver;
> >       struct device_node *np;
> >
> >       np = of_find_node_by_phandle(phandle);
> > @@ -2122,7 +2125,30 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
> >       list_for_each_entry_rcu(r, &rproc_list, node) {
> >               if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
> >                       /* prevent underlying implementation from being removed */
> > -                     if (!try_module_get(r->dev.parent->driver->owner)) {
> > +
> > +                     /*
> > +                      * If the remoteproc's parent has a driver, the
> > +                      * remoteproc is not part of a cluster and we can use
> > +                      * that driver.
> > +                      */
> > +                     driver = r->dev.parent->driver;
> > +
> > +                     /*
> > +                      * If the remoteproc's parent does not have a driver,
> > +                      * look for the driver associated with the cluster.
> > +                      */
> > +                     if (!driver) {
> > +                             cluster_pdev = of_find_device_by_node(np->parent);
>
> Both the Ti and Xilinx drivers are using of_platform_populate(), so
> their r->dev.parent should have a parent reference to the cluster
> device.
>

So you are proposing to get the cluster's driver using something like
r->dev.parent->parent->driver?

I will have to verify the parent/child relationship is set up properly
through the of_platform_populate().  If it is, following the pointer
trail is an equally valid approach and I will respin this set.

> Unless I'm reading the code wrong, I think we should follow that
> pointer, rather than taking the detour in the DeviceTree data.
>
> Regards,
> Bjorn
>
> > +                             if (!cluster_pdev) {
> > +                                     dev_err(&r->dev, "can't get parent\n");
> > +                                     break;
> > +                             }
> > +
> > +                             driver = cluster_pdev->dev.driver;
> > +                             put_device(&cluster_pdev->dev);
> > +                     }
> > +
> > +                     if (!try_module_get(driver->owner)) {
> >                               dev_err(&r->dev, "can't get owner\n");
> >                               break;
> >                       }
> > --
> > 2.25.1
> >
