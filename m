Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D72C806A77
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjLFJMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFJLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:11:52 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B821BE8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:11:56 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-daf4f0e3a0fso4911930276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 01:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701853915; x=1702458715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YqJKf6k3LqdMOajnfjgr4qlTOkc+4XpnvbfWlmqLEqw=;
        b=yYhIoaaFP2pDyV/7WCE+SVYkzAmn9WDSKN3A1MgJg2wsDBBB6Nhhr/hScFBA4xnm9c
         iEkEXQvLfqpEy6KSHUo/V4p1bHCiYjL2VYJj+gKnQBVSiVwTAAz7SMk+g+2babMZHUzb
         Dwwex06NZt3mrLQbsB2aLVek2QRPCMDubiLODaxQ0UqmKsdrFBndfE+4FdcNT1O2678K
         xZ+9hKEsNvatBy68E7EK5W4aTVUjmT+N9JGWLKCBlpKaZf/ycy3/KCpwGbv1URbx6uWv
         QQgCu0nmd4D3AraOOascALi9dIxjms4JAjPnT1EQaF5qd2nO0TSc+qpFEOdecq+Sj5IB
         27rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701853915; x=1702458715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqJKf6k3LqdMOajnfjgr4qlTOkc+4XpnvbfWlmqLEqw=;
        b=eH36OlWNOg9b3YV6jD0Xxj+XEsxLq9+/sesShGbqif1hU5D4FXpXDQJ2HhH/vPxqBX
         g5+cDHnlY2+6ZQL+VAoP45FakSQ3R72XwVenI3PcbAoTu/Fso4ztOPWJwqnWY134AVDW
         fBYYMzeqap/FLTY+2WRYvfQ5sPW5chVdFLn28UIwq+EYlJxgmzlV4GgQv5co7VRpyL6G
         WQO6wQ7ggvRyNZd1jgKc/Fd1VVE20CPJD1fTW54u/EtOO0ePLFjqkcAyrQdVsepdk/2u
         FhUUALbyqkhAKABDPDMLKr8gaCmQ7xwVXylb6hrXArpD6UlRj/AZN3UeGW0t+Oc9c7gp
         iwkA==
X-Gm-Message-State: AOJu0Yzue+DTDXxUSLdeYmbx8Nw2tAI12QrlIJB4A51U0OTNKeCB2PRw
        MgcJM4dqjL1Rrxtff3IloJk6RMXaguvz1x0KC76oPg==
X-Google-Smtp-Source: AGHT+IEa3a5UoBcKWU2a9NslT+MOBgjSAC1zjicINvB9Ra2bERFvGcDVtQBsO6xLpYDOkNYNwp2dm8OphFFSIX5tAN0=
X-Received: by 2002:a25:3497:0:b0:db7:dacf:622a with SMTP id
 b145-20020a253497000000b00db7dacf622amr375926yba.124.1701853915593; Wed, 06
 Dec 2023 01:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20231205220526.417719-1-robdclark@gmail.com> <20231205220526.417719-3-robdclark@gmail.com>
In-Reply-To: <20231205220526.417719-3-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Dec 2023 11:11:44 +0200
Message-ID: <CAA8EJppNjBCx2NDe4zS_41hEUBiiXcuG63frJ7E67A5M9-FSzg@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/msm/adreno: Split catalog into separate files
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 at 00:06, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Split each gen's gpu table into it's own file.  Only code-motion, no
> functional change.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/Makefile               |   5 +
>  drivers/gpu/drm/msm/adreno/a2xx_catalog.c  |  53 ++
>  drivers/gpu/drm/msm/adreno/a3xx_catalog.c  |  75 +++
>  drivers/gpu/drm/msm/adreno/a4xx_catalog.c  |  51 ++
>  drivers/gpu/drm/msm/adreno/a5xx_catalog.c  | 145 ++++++
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c  | 285 +++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 570 +--------------------
>  7 files changed, 620 insertions(+), 564 deletions(-)
>  create mode 100644 drivers/gpu/drm/msm/adreno/a2xx_catalog.c
>  create mode 100644 drivers/gpu/drm/msm/adreno/a3xx_catalog.c
>  create mode 100644 drivers/gpu/drm/msm/adreno/a4xx_catalog.c
>  create mode 100644 drivers/gpu/drm/msm/adreno/a5xx_catalog.c
>  create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_catalog.c

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 49671364fdcf..32f2fd980452 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -7,12 +7,17 @@ ccflags-$(CONFIG_DRM_MSM_DP) += -I $(srctree)/$(src)/dp
>  msm-y := \
>         adreno/adreno_device.o \
>         adreno/adreno_gpu.o \
> +       adreno/a2xx_catalog.o \
>         adreno/a2xx_gpu.o \
> +       adreno/a3xx_catalog.o \
>         adreno/a3xx_gpu.o \
> +       adreno/a4xx_catalog.o \
>         adreno/a4xx_gpu.o \
> +       adreno/a5xx_catalog.o \
>         adreno/a5xx_gpu.o \
>         adreno/a5xx_power.o \
>         adreno/a5xx_preempt.o \
> +       adreno/a6xx_catalog.o \
>         adreno/a6xx_gpu.o \
>         adreno/a6xx_gmu.o \
>         adreno/a6xx_hfi.o \
> diff --git a/drivers/gpu/drm/msm/adreno/a2xx_catalog.c b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
> new file mode 100644
> index 000000000000..1a4d182279fc
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2013-2014 Red Hat
> + * Author: Rob Clark <robdclark@gmail.com>
> + *
> + * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
> + */
> +
> +#include "adreno_gpu.h"
> +
> +const struct adreno_info a2xx_gpus[] = {
> +       {
> +               .chip_ids = ADRENO_CHIP_IDS(0x02000000),
> +               .family = ADRENO_2XX_GEN1,
> +               .revn  = 200,
> +               .fw = {
> +                       [ADRENO_FW_PM4] = "yamato_pm4.fw",
> +                       [ADRENO_FW_PFP] = "yamato_pfp.fw",
> +               },
> +               .gmem  = SZ_256K,
> +               .inactive_period = DRM_MSM_INACTIVE_PERIOD,
> +               .init  = a2xx_gpu_init,
> +       }, { /* a200 on i.mx51 has only 128kib gmem */
> +               .chip_ids = ADRENO_CHIP_IDS(0x02000001),
> +               .family = ADRENO_2XX_GEN1,
> +               .revn  = 201,
> +               .fw = {
> +                       [ADRENO_FW_PM4] = "yamato_pm4.fw",
> +                       [ADRENO_FW_PFP] = "yamato_pfp.fw",
> +               },
> +               .gmem  = SZ_128K,
> +               .inactive_period = DRM_MSM_INACTIVE_PERIOD,
> +               .init  = a2xx_gpu_init,
> +       }, {
> +               .chip_ids = ADRENO_CHIP_IDS(0x02020000),
> +               .family = ADRENO_2XX_GEN2,
> +               .revn  = 220,
> +               .fw = {
> +                       [ADRENO_FW_PM4] = "leia_pm4_470.fw",
> +                       [ADRENO_FW_PFP] = "leia_pfp_470.fw",
> +               },
> +               .gmem  = SZ_512K,
> +               .inactive_period = DRM_MSM_INACTIVE_PERIOD,
> +               .init  = a2xx_gpu_init,
> +       }, {
> +               /* sentinal */
> +       }
> +};
> +
> +MODULE_FIRMWARE("qcom/leia_pfp_470.fw");
> +MODULE_FIRMWARE("qcom/leia_pm4_470.fw");
> +MODULE_FIRMWARE("qcom/yamato_pfp.fw");
> +MODULE_FIRMWARE("qcom/yamato_pm4.fw");
> \ No newline at end of file

Nit: you might want to fix newlines (here and in other catalog files).



-- 
With best wishes
Dmitry
