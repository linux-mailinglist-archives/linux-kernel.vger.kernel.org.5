Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56706774178
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjHHRVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjHHRV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:21:26 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739DE7A0D2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:08:43 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b9a2416b1cso4981839a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510892; x=1692115692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W8Rz6JdKJggB+vk185UWqplO5cbUsTa+J+i5abU5jbw=;
        b=QqncR2KeBXwVe/6BF3RIyBw9ujC3+Io2BO3EtgVSrHXcm3gwZFr8Gr+2ibIfKVTHtD
         x5Npgu6qRS0yoTUwKQR1wpaRhoE72hcoVLf0CsqAv/tPAttb5LTVAxdDbbc44BLHy+YR
         0/vCpA4EqE/m/y5YJY18psQicGMwBgbwqfTCgNqWfM9rZjOQIvJmYtWaK6OiloL9h3lz
         ZQxWrgJzYRIRLcYt1VCVPlz5qFEPnnIhk3+08HM2BEtJ9PnZ+oxbnyM6dcXRr6bs/QeZ
         TiEQFPhlNn4/BF0Plad/QWlre3OcpxP2WzxHs4PJxP7dbKyJGyfdwS0Aj489TwgOTby9
         EmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510892; x=1692115692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8Rz6JdKJggB+vk185UWqplO5cbUsTa+J+i5abU5jbw=;
        b=LEqY5eNIgVtQk6hi8LJ/Wee+ak9OBkfyw49rSU558hjHTnab2UXh9JtvbcfOFaScmj
         nPonRQg4xKSJD4EK1fiOWh/0n+DRm9F7de8j/MThCCEGInZ4+pr61XxN5E5tYj1fqpfu
         31YF8+scmL/lLpBzSrDrArMSbJRO4ssS67/Ah/+kFZ/ioyp8qgoifmUg5N0VtVO+AMpy
         Q7CCMUamDuRePM105CNgeLUBZfWZ7iLlyE4ts6s191qYaN3r2nGYJqqkU375ECCW83vs
         dNXepbFzk+iNvih8bShfYKkMB2NRXuaXj7KENa5V9TfAa5C+i5/Xzgn9zYpfY3K5sspS
         WUtg==
X-Gm-Message-State: AOJu0YzwU0aJyrpNWdmAVpZvUwgdreGozFw+sF2/Td2YV/0fOWtEgJKG
        JT5Gtbo+Mnekb6Z4U5b5+bjN6JfqiJkmi6AhIG/1oDeF7DD4RWlgMfhEjA==
X-Google-Smtp-Source: AGHT+IHd0ipN+K4djTCXtDOyfu+VTZpMjc2BHQ17nfPiSRQDUouO0mBCgRT9q8s21lVndeT3Y2wJvRIbhS8rd5n7No0=
X-Received: by 2002:a25:8d8e:0:b0:d3c:58ef:ef7b with SMTP id
 o14-20020a258d8e000000b00d3c58efef7bmr11095979ybl.6.1691506710111; Tue, 08
 Aug 2023 07:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 16:57:54 +0200
Message-ID: <CAPDyKFqvP71ZDcamFo5AijhTXEJKHUPNE=-dOvXYw3pr4XxK6A@mail.gmail.com>
Subject: Re: [PATCH V3 0/8] genpd: imx: relocate scu-pd and misc update
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 at 08:43, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V3:
>  return -EBUSY instead of return 0 in patch 4
>
> V2:
> Move drivers/firmware/imx/scu-pd.c to drivers/genpd/imx
>
> This patchset is to upstream NXP downstream scu-pd driver patches.
> patch is to relocate scu-pd to genpd
> patch 2,3 is to support more PDs
> patch 4 is to not power off console when no console suspend
> patch 5 is to suppress bind
> patch 6 is to make genpd align with HW state
> patch 7 is to support LP mode in runtime suspend, OFF mode in system suspend.
> patch 8 is to change init level to avoid uneccessary defer probe
>
> V1:
> This patchset is to upstream NXP downstream scu-pd driver patches.
> patch 1,2 is to support more PDs
> patch 3 is to not power off console when no console suspend
> patch 4 is to suppress bind
> patch 5 is to make genpd align with HW state
> patch 6 is to support LP mode in runtime suspend, OFF mode in system suspend.
> patch 7 is to change init level to avoid uneccessary defer probe
>
> Dong Aisheng (1):
>   genpd: imx: scu-pd: change init level to subsys_initcall
>
> Peng Fan (7):
>   genpd: imx: relocate scu-pd under genpd
>   genpd: imx: scu-pd: enlarge PD range
>   genpd: imx: scu-pd: add more PDs
>   genpd: imx: scu-pd: do not power off console if no_console_suspend
>   genpd: imx: scu-pd: Suppress bind attrs
>   genpd: imx: scu-pd: initialize is_off according to HW state
>   genpd: imx: scu-pd: add multi states support
>
>  drivers/firmware/imx/Makefile            |   1 -
>  drivers/genpd/imx/Makefile               |   1 +
>  drivers/{firmware => genpd}/imx/scu-pd.c | 193 +++++++++++++++++++++--
>  3 files changed, 183 insertions(+), 12 deletions(-)
>  rename drivers/{firmware => genpd}/imx/scu-pd.c (70%)
>

Moving this to the new genpd subsystem makes sense to me.

Even if we can't get the whole series ready for v6.6, we can certainly
pick patch1. Either we can funnel this via my new genpd tree [1] or if
Shawn picks it up. If the latter, Shawn needs to merge my immutable
branch [2] before applying. I am fine either way.

Kind regards
Uffe

[1]
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git next

[2]
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git genpd_create_dir
