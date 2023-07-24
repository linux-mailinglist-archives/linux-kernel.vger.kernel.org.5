Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33117601F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjGXWAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjGXWAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:00:14 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C8F194
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:59:54 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bb1ec7945dso1367431a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690235993; x=1690840793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKXXQoujPlp56Vu9MiAPxZJv9g2kLPe6/i7I5ujqsT4=;
        b=HpWLr/cii57x0K56jdIMzaoYubGP5yAArPD4GGbZ7rg3c8zkWyPF8Jo1SZgFHVwYVw
         Q10GDz3c4jRYxaYxrzoKwaRBW6ocxi0//3MeEbBlMWoqGDzYc/ZaScvKLCD+h7vYIKuy
         +5RWO5r2eMOWYZDYhHqhtLF6s7eP6Rl+d3ohNAR0yumMY4jBrgKXilWKT8REFw7XZ4dC
         8EwezNLdSPpLTftMmFJyiIj67aimFqCUzWU1DlI6RBjqtbQzXovDUgH9g9E3c7t1+bhN
         ueVsy+UqTF3/k/+7/98C7YJu0qq178s33y2w01scVgj4UC322mxmj9DpdUl6zjZ//sfN
         2n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235993; x=1690840793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKXXQoujPlp56Vu9MiAPxZJv9g2kLPe6/i7I5ujqsT4=;
        b=NfnGqCGqA4NOE4pG27N5qnKiTuPztfK2pF8pDrQbJ1VvkvLLvcse+DusICTDM6BDQR
         2lyzZG0oKlxk7kg8mjuiEpKFmE483fev3HscGiglY1IGzgJpTv6Sp/2RxpXgls04cY+A
         KeXtBGCsXdDi714ZsB1HHO5EcLs0QzbSquaNO3g3AdjNiYoIP2xUAUEPyY/bJttfyZjz
         YKS/lWPkELwrTQ+mIAcXq4JP7i953jAq95DHlJGTiEp3C8/GpqG/0XZ1KgZJ618RDJQP
         ROYhXb6LcmOiGziMXTyf6sFRZQJdDE+o7qX+faGYc84CGS7aTsxoaRXrKFMHBVMCNv0a
         hHqg==
X-Gm-Message-State: ABy/qLamXp2EuobBH0JmYsP/oJO8p0LxtyigdEkP6PrL3OC9s99nAx6S
        yeYy8tr/cuqT09W/LNbnLv5bCih3hjVHdfhhJEA=
X-Google-Smtp-Source: APBJJlHVP3kmdwAl7RB3BmqgixgStZVMBM7WCfOT8KU4DkhTa9aSkSHPsGqnBbYlT3Ii5MIKmGH0b3f+xJAGF0VYE7U=
X-Received: by 2002:a05:6830:4410:b0:6b7:2ef3:37aa with SMTP id
 q16-20020a056830441000b006b72ef337aamr463718otv.15.1690235993268; Mon, 24 Jul
 2023 14:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230724090624.9699-1-xujianghui@cdjrlc.com> <5ce64e06635dbf038d73452098fd0163@208suo.com>
In-Reply-To: <5ce64e06635dbf038d73452098fd0163@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:59:42 -0400
Message-ID: <CADnq5_M-NaGgzFQB+zcCgCMPXROGFhk+Was+m9JYcvQq=k9u1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: open brace '{' following struct go on the
 same line
To:     sunran001@208suo.com
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Jul 24, 2023 at 5:08=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   .../amd/pm/swsmu/inc/smu_v13_0_7_pptable.h    | 21 +++++++------------
>   1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
> index eadbe0149cae..eb694f9f556d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
> @@ -41,8 +41,7 @@
>   #define SMU_13_0_7_PP_OVERDRIVE_VERSION 0x83        // OverDrive 8
> Table Version 0.2
>   #define SMU_13_0_7_PP_POWERSAVINGCLOCK_VERSION 0x01 // Power Saving
> Clock Table Version 1.00
>
> -enum SMU_13_0_7_ODFEATURE_CAP
> -{
> +enum SMU_13_0_7_ODFEATURE_CAP {
>       SMU_13_0_7_ODCAP_GFXCLK_LIMITS =3D 0,
>       SMU_13_0_7_ODCAP_UCLK_LIMITS,
>       SMU_13_0_7_ODCAP_POWER_LIMIT,
> @@ -62,8 +61,7 @@ enum SMU_13_0_7_ODFEATURE_CAP
>       SMU_13_0_7_ODCAP_COUNT,
>   };
>
> -enum SMU_13_0_7_ODFEATURE_ID
> -{
> +enum SMU_13_0_7_ODFEATURE_ID {
>       SMU_13_0_7_ODFEATURE_GFXCLK_LIMITS           =3D 1 <<
> SMU_13_0_7_ODCAP_GFXCLK_LIMITS,           //GFXCLK Limit feature
>       SMU_13_0_7_ODFEATURE_UCLK_LIMITS             =3D 1 <<
> SMU_13_0_7_ODCAP_UCLK_LIMITS,             //UCLK Limit feature
>       SMU_13_0_7_ODFEATURE_POWER_LIMIT             =3D 1 <<
> SMU_13_0_7_ODCAP_POWER_LIMIT,             //Power Limit feature
> @@ -85,8 +83,7 @@ enum SMU_13_0_7_ODFEATURE_ID
>
>   #define SMU_13_0_7_MAX_ODFEATURE 32 //Maximum Number of OD Features
>
> -enum SMU_13_0_7_ODSETTING_ID
> -{
> +enum SMU_13_0_7_ODSETTING_ID {
>       SMU_13_0_7_ODSETTING_GFXCLKFMAX =3D 0,
>       SMU_13_0_7_ODSETTING_GFXCLKFMIN,
>       SMU_13_0_7_ODSETTING_UCLKFMIN,
> @@ -123,8 +120,7 @@ enum SMU_13_0_7_ODSETTING_ID
>   };
>   #define SMU_13_0_7_MAX_ODSETTING 64 //Maximum Number of ODSettings
>
> -enum SMU_13_0_7_PWRMODE_SETTING
> -{
> +enum SMU_13_0_7_PWRMODE_SETTING {
>       SMU_13_0_7_PMSETTING_POWER_LIMIT_QUIET =3D 0,
>       SMU_13_0_7_PMSETTING_POWER_LIMIT_BALANCE,
>       SMU_13_0_7_PMSETTING_POWER_LIMIT_TURBO,
> @@ -144,8 +140,7 @@ enum SMU_13_0_7_PWRMODE_SETTING
>   };
>   #define SMU_13_0_7_MAX_PMSETTING 32 //Maximum Number of PowerMode
> Settings
>
> -struct smu_13_0_7_overdrive_table
> -{
> +struct smu_13_0_7_overdrive_table {
>       uint8_t revision;                             //Revision =3D
> SMU_13_0_7_PP_OVERDRIVE_VERSION
>       uint8_t reserve[3];                           //Zero filled field
> reserved for future use
>       uint32_t feature_count;                       //Total number of
> supported features
> @@ -156,8 +151,7 @@ struct smu_13_0_7_overdrive_table
>       int16_t pm_setting[SMU_13_0_7_MAX_PMSETTING]; //Optimized power
> mode feature settings
>   };
>
> -enum SMU_13_0_7_PPCLOCK_ID
> -{
> +enum SMU_13_0_7_PPCLOCK_ID {
>       SMU_13_0_7_PPCLOCK_GFXCLK =3D 0,
>       SMU_13_0_7_PPCLOCK_SOCCLK,
>       SMU_13_0_7_PPCLOCK_UCLK,
> @@ -175,8 +169,7 @@ enum SMU_13_0_7_PPCLOCK_ID
>   };
>   #define SMU_13_0_7_MAX_PPCLOCK 16 //Maximum Number of PP Clocks
>
> -struct smu_13_0_7_powerplay_table
> -{
> +struct smu_13_0_7_powerplay_table {
>       struct atom_common_table_header header; //For PLUM_BONITO,
> header.format_revision =3D 15, header.content_revision =3D 0
>       uint8_t table_revision;                 //For PLUM_BONITO,
> table_revision =3D 2
>       uint8_t padding;
