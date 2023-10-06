Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876127BB111
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 07:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjJFFAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 01:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjJFFAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 01:00:36 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD0CBF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 22:00:31 -0700 (PDT)
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 38A0C3F694
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696568429;
        bh=3kBkO+xPsvpv6WlXJ5HZzURknDu1eKx2EKHLI5RN7RU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=W013DWQF0Ykme0/KQ4S2QHDhBKsMh/OjeN2cljvWLx9exoRoINkYpDLv/CKVCaCva
         G1RnMcEdr9J05EXKb/9rzNJDXVga5ZNKULK7RETyQrhOFqR3DsvXKqAoMHYhc0itps
         w6SaO3f5tBd0LHqQyzs3c/ID5hhKnVvoGNIUVzUqGuMEgewO7XDOg1LeonqUSu+Tt9
         PGBT2b0I8w0KBuSeg8cmZCRYLBV4WNLWa7K9+ek2n5j628oZbceCc0MGH8EgB3nAhn
         KIgXKcw61LQUwBDZJP4iA4Ypnj2ntqmO5n2+SkIPl2W5FJgHDEQouYdjpeNLDMRcmF
         coDrxem0ZwroA==
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-57e460ac8c3so2174190eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 22:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696568428; x=1697173228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kBkO+xPsvpv6WlXJ5HZzURknDu1eKx2EKHLI5RN7RU=;
        b=FCQi19Hk4VlGbiTNM0QHDTkoAzkfDbzB2jA1I4AxEhkCFGRbA37sEU4bFd+0ybdK2X
         bHjk1BQKJ0SW7wTE5soUI0T5lG0quOcGL2U+3/WK30kPxqOaHlqEq5pzOCFqIVx5s3u8
         63mmyfd9xjnvYRs3MlI1A2W8MeJR5gsE3hOXa+1V2EMYW/dxcuRBOWJQYhIhKIYaVjgk
         nmQ/2zCI8xWq3e+jiHswH6GSd5BX9VC0ajSnO3uyXOQqgbvVIBkm6GgdnFA/RYrVRxxB
         H6QZoa/w1PyZ6ntBBC4VFYCz0I5eOy0nhlxKF1YFeW4oju17QYVsuCALT4euRI1AMJDC
         18HA==
X-Gm-Message-State: AOJu0YwgRhIFyju5s7LTA18EvoIVYT+OEBaOtlzWoVThW+z+6VcCc5Bo
        bEy5lBtYL24FI2MdiIpeJJSsJtlLV14poBluLoDjZ2MbzOwOxrzRrGdwWNRoy6Mc/u39KoyL7aC
        f7Nq0UCoLwucHi2Tp7yNMqfYApD3DNDBpfD8YRzHbRORsTbJj2ZZShkG/+Q==
X-Received: by 2002:a05:6358:4298:b0:143:8af4:229e with SMTP id s24-20020a056358429800b001438af4229emr8083952rwc.9.1696568428082;
        Thu, 05 Oct 2023 22:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmuTznHxAWL216Xcmib0mpX2Hgmlr/og7zwlow+YPDDioBVPVh4YbkFELNe1Z/fYS8QzTzO+/k029euoUb2UY=
X-Received: by 2002:a05:6358:4298:b0:143:8af4:229e with SMTP id
 s24-20020a056358429800b001438af4229emr8083937rwc.9.1696568427688; Thu, 05 Oct
 2023 22:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <2ce258f371234b1f8a1a470d5488d00e@realtek.com> <CAPDyKFoCHtN9jK3A9YkoQC+e_3XNKJNp7-w1WkNMFBp6n-PH=g@mail.gmail.com>
 <CAPDyKFp6cFnpWRA=iGZFr94UdjFbjtMbcTJORfFKQ-izdtX8bQ@mail.gmail.com>
In-Reply-To: <CAPDyKFp6cFnpWRA=iGZFr94UdjFbjtMbcTJORfFKQ-izdtX8bQ@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 6 Oct 2023 13:00:15 +0800
Message-ID: <CAAd53p5+ngpAB+J_Hshug61bCCCoec=LveeAUSrtAd_UP6gSoQ@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: Fix an error access Page fault
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ricky WU <ricky_wu@realtek.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky,

On Tue, Sep 26, 2023 at 11:04=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Thu, 14 Sept 2023 at 16:47, Ulf Hansson <ulf.hansson@linaro.org> wrote=
:
> >
> > On Wed, 6 Sept 2023 at 10:03, Ricky WU <ricky_wu@realtek.com> wrote:
> > >
> > > an error occurs on insert SD7.0 card.
> > > The pci slot of rtsx_pci will Link Down when the SD7.0 card inserted,
> > > but the rtsx_pci not exit from runtime_idle at that time,
> > > then do the power_saving function to access the wrong resource
> > >
> > > Fixes: 597568e8df04 ("misc: rtsx: Rework runtime power management flo=
w")
> > > Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> >
> > Applied for fixes, thanks!
>
> This was not ready to be applied, my bad! Fortunately, I haven't
> submitted a pull-request with this yet, so I am simply dropping the
> patch for now, to make sure we find the proper solution.

Can you please see if the following change helps:

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_=
pci.c
index ad12515a4a121..89480e31c2266 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -18,9 +18,18 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include "../pci.h"
 #include "pciehp.h"

+int pciehp_pm_runtime_barrier(struct pci_dev *pdev, void *unused)
+{
+       pm_runtime_barrier(&pdev->dev);
+       pci_dev_set_disconnected(pdev, NULL);
+
+       return 0;
+}
+
 /**
  * pciehp_configure_device() - enumerate PCI devices below a hotplug bridg=
e
  * @ctrl: PCIe hotplug controller
@@ -98,7 +107,7 @@ void pciehp_unconfigure_device(struct controller
*ctrl, bool presence)
                 __func__, pci_domain_nr(parent), parent->number);

        if (!presence)
-               pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
+               pci_walk_bus(parent, pciehp_pm_runtime_barrier, NULL);

        pci_lock_rescan_remove();


>
> [...]
>
> Kind regards
> Uffe
