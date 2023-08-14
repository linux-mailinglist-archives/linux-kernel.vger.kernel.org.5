Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4C77B795
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjHNL2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjHNL21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:28:27 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F64129
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:28:26 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d62bdd1a97dso4293697276.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692012505; x=1692617305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zV7e4uqCOZfFxUomsrlciPWk9Fd/IJUmKy5w/Bnb3o0=;
        b=hOuVghxDpW00pxzb5dzoUPvu+bMfT+myG9WRxGoIkKOK1x4kzwy+0gTqN6gkGlcSQC
         WTgLmNAoH87AxbTzpjzbUyvoQKuvVsuPGvofRsogfLe0foUruUjpIHaQaR3VRc1ripik
         V4swmeIgAiSpr18UvxsG16sTKF80yC6bmtzmOneCvuLZICL+dAtkmclKH/rkjQQMSJep
         fpm0wbwIF2WNlU1VGC7WYAYcexXXFrpgMPWhBUrgRj2fUKqMpXo/GGBl6P9p6JSokRIJ
         b5b8cyMMkMnQgFGXB4rnbu4gubZzOOpsFjAnsA6tfu5GZPQtp1lhI2snVhHu1YKan758
         4rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692012505; x=1692617305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zV7e4uqCOZfFxUomsrlciPWk9Fd/IJUmKy5w/Bnb3o0=;
        b=cNDvt6AGmooVxGlhridM2I/N1sVz1F2AO+c/jUVf2r9DyMvYQaOz60ZxtnZXjLQjs8
         08UBV1yoIMRDbMxlfPVUxPhdOraZvXI1RxsNb1FywOYfh3NnzOcszi8FcH4XEogrN7Iy
         vdnQb7DrIR8TfrWUx1OmJl4gGF2Ct9IHTXM+JoFSlYUb887LietEKGU3e3gvXp5vNuJ7
         DLfxlhdTbSp/LR6ayQGEBX4Tbt9ohowe4OPNqiN85iijoH6uUml7rJxcFKTIhFORaGqE
         MsWLCfrHJpDZkL2vH24SJWjzHjKyFADSBfzpPutTsboblXRwS4VRTcjbesuiDsY6bcSa
         rhdA==
X-Gm-Message-State: AOJu0Yz/w9dRGzzo4u5CRp1xWwdXpRCLo/DOBWOTe+QY5eVIfZ/yZfy/
        HKc+I/ps7x4T0v5BsRdR8o2tyMrnIAVcRCrP7x2Lig==
X-Google-Smtp-Source: AGHT+IGnQJT82CyRJQHGhUeBgoe4lkdDdYbjacPwBMd98HAzPlLW3y5rC5ORU5ANElco5nbwuNNBY+6yI+wNMWRcDkQ=
X-Received: by 2002:a25:bcc4:0:b0:d21:ef87:c1be with SMTP id
 l4-20020a25bcc4000000b00d21ef87c1bemr9876239ybm.27.1692012505512; Mon, 14 Aug
 2023 04:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230814104127.1929-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230814104127.1929-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Aug 2023 13:27:49 +0200
Message-ID: <CAPDyKFowxz_Ndy5uFmXaTmQoY1SUNNg7-R04JUUXX0n=5FH_fA@mail.gmail.com>
Subject: Re: [PATCH V4 0/8] genpd: imx: relocate scu-pd and misc update
To:     shawnguo@kernel.org, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 at 12:36, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V4:
>  Update commit message in patch 4
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

I am fine to pick up patch 1 -> patch 6, to let them go in for v6.6.
Should we do that or defer until the complete series is ready?

Kind regards
Uffe
