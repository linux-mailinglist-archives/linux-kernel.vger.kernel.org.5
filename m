Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3881175CCCF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjGUP5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjGUP5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:57:11 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30743595
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:57:07 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1ba5cda3530so1477726fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955027; x=1690559827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHI6PjFKXZji62G1V5r/6jFnxf0AM65yBjnIXIDqpKU=;
        b=H6HIj/BzFhZLIecTq3jMzTjcsZlGyVbIFMUJnF1DSQiLxUOdyuR2I40UXNxWwl2iHr
         p6cVzQFzxWcsNe5sDWdeBK2V18/0is9STb5yzp8Fj4dv9TUjZ5r+SeX1JRzS942AKjn/
         XikMvkj9P/sQn9T1IGXwFtsfv6/AbBRwUzrzZpNXbkf0TciS1SatYgPwhIrRM1DkbY6x
         na1nTEp1gRqgLofPdiAShZHU05TmOCb40+whRx61sqjvDp5LUPGQuYTXvMknKXXdh9hq
         fjC04lndsE+eNBliwNlsalUztiwY75kd6mFC9oaqYmc2pchPkcpDuMrOv4sXqRLr4UdM
         pPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955027; x=1690559827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHI6PjFKXZji62G1V5r/6jFnxf0AM65yBjnIXIDqpKU=;
        b=Gu9+KOg43AL5hTVP4fv2KMvySEu/9WVz7bLVs2AEHOKcbh7mG5xB7KybBCMslIF/y0
         39yTCj76/C3l3vwJAg9Hs0CO40j/X2bSqE5cZ9V1t/ziYLFeMTz8q685qmOsDQ1sjRD+
         SYFKOeUxyIPkI4ntuh4gWvMKu2mLY7r7OO/aex+MoByb9jB3C2a13U93cr7ZMo6Iuen5
         +uLqUUs0GkPpI/sazgqT1eQnvEDf022Noq3aJJa7CD8QspzaYwFsLyBcjoV7HBo2UeMe
         DmOiUU2sraduwu7+ozsWBMQSXW8G7pJjIgWgekyXpjtzI+mW4IXNJxwy3XDfqqWihWQF
         N19Q==
X-Gm-Message-State: ABy/qLa1AJguBv4a13r831kk9ahSNT0EFLFYdZ5HM7a/PDAt9Ueqskzm
        T6f8gSUljyxfFT1ztse0Pr4+QfnqxK1f7U+yr30=
X-Google-Smtp-Source: APBJJlFBXAUjgYxVHyPQuxtWRK9jWFVgGsL5FPIAYnI5F6w2bjfsgOZ08UdghiEbOvgIMoUwonQ+9s+mFvz7iFbDTZ8=
X-Received: by 2002:a05:6870:c210:b0:1b7:2ad3:454d with SMTP id
 z16-20020a056870c21000b001b72ad3454dmr2633102oae.24.1689955026811; Fri, 21
 Jul 2023 08:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230721032537.4727-1-xujianghui@cdjrlc.com> <9bb658b64109e1e60afdf82906ae3e03@208suo.com>
In-Reply-To: <9bb658b64109e1e60afdf82906ae3e03@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 21 Jul 2023 11:56:55 -0400
Message-ID: <CADnq5_PBVuh=fOnh-wooP9QWV_NOdkc5wew_VckrKp8_E5oBTg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: open brace '{' following struct go on the
 same line
To:     sunran001@208suo.com
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

This applied properly.  Applied.  Thanks!

Alex

On Thu, Jul 20, 2023 at 11:27=E2=80=AFPM <sunran001@208suo.com> wrote:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   .../gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h  | 21 +++++++------------
>   1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
> index 1dc7a065a6d4..251ed011b3b0 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
> @@ -41,8 +41,7 @@
>   #define SMU_13_0_0_PP_OVERDRIVE_VERSION 0x83        // OverDrive 8
> Table Version 0.2
>   #define SMU_13_0_0_PP_POWERSAVINGCLOCK_VERSION 0x01 // Power Saving
> Clock Table Version 1.00
>
> -enum SMU_13_0_0_ODFEATURE_CAP
> -{
> +enum SMU_13_0_0_ODFEATURE_CAP {
>       SMU_13_0_0_ODCAP_GFXCLK_LIMITS =3D 0,
>       SMU_13_0_0_ODCAP_UCLK_LIMITS,
>       SMU_13_0_0_ODCAP_POWER_LIMIT,
> @@ -62,8 +61,7 @@ enum SMU_13_0_0_ODFEATURE_CAP
>       SMU_13_0_0_ODCAP_COUNT,
>   };
>
> -enum SMU_13_0_0_ODFEATURE_ID
> -{
> +enum SMU_13_0_0_ODFEATURE_ID {
>       SMU_13_0_0_ODFEATURE_GFXCLK_LIMITS           =3D 1 <<
> SMU_13_0_0_ODCAP_GFXCLK_LIMITS,           //GFXCLK Limit feature
>       SMU_13_0_0_ODFEATURE_UCLK_LIMITS             =3D 1 <<
> SMU_13_0_0_ODCAP_UCLK_LIMITS,             //UCLK Limit feature
>       SMU_13_0_0_ODFEATURE_POWER_LIMIT             =3D 1 <<
> SMU_13_0_0_ODCAP_POWER_LIMIT,             //Power Limit feature
> @@ -85,8 +83,7 @@ enum SMU_13_0_0_ODFEATURE_ID
>
>   #define SMU_13_0_0_MAX_ODFEATURE 32 //Maximum Number of OD Features
>
> -enum SMU_13_0_0_ODSETTING_ID
> -{
> +enum SMU_13_0_0_ODSETTING_ID {
>       SMU_13_0_0_ODSETTING_GFXCLKFMAX =3D 0,
>       SMU_13_0_0_ODSETTING_GFXCLKFMIN,
>       SMU_13_0_0_ODSETTING_UCLKFMIN,
> @@ -123,8 +120,7 @@ enum SMU_13_0_0_ODSETTING_ID
>   };
>   #define SMU_13_0_0_MAX_ODSETTING 64 //Maximum Number of ODSettings
>
> -enum SMU_13_0_0_PWRMODE_SETTING
> -{
> +enum SMU_13_0_0_PWRMODE_SETTING {
>       SMU_13_0_0_PMSETTING_POWER_LIMIT_QUIET =3D 0,
>       SMU_13_0_0_PMSETTING_POWER_LIMIT_BALANCE,
>       SMU_13_0_0_PMSETTING_POWER_LIMIT_TURBO,
> @@ -144,8 +140,7 @@ enum SMU_13_0_0_PWRMODE_SETTING
>   };
>   #define SMU_13_0_0_MAX_PMSETTING 32 //Maximum Number of PowerMode
> Settings
>
> -struct smu_13_0_0_overdrive_table
> -{
> +struct smu_13_0_0_overdrive_table {
>       uint8_t revision;                             //Revision =3D
> SMU_13_0_0_PP_OVERDRIVE_VERSION
>       uint8_t reserve[3];                           //Zero filled field
> reserved for future use
>       uint32_t feature_count;                       //Total number of
> supported features
> @@ -156,8 +151,7 @@ struct smu_13_0_0_overdrive_table
>       int16_t pm_setting[SMU_13_0_0_MAX_PMSETTING]; //Optimized power
> mode feature settings
>   };
>
> -enum SMU_13_0_0_PPCLOCK_ID
> -{
> +enum SMU_13_0_0_PPCLOCK_ID {
>       SMU_13_0_0_PPCLOCK_GFXCLK =3D 0,
>       SMU_13_0_0_PPCLOCK_SOCCLK,
>       SMU_13_0_0_PPCLOCK_UCLK,
> @@ -175,8 +169,7 @@ enum SMU_13_0_0_PPCLOCK_ID
>   };
>   #define SMU_13_0_0_MAX_PPCLOCK 16 //Maximum Number of PP Clocks
>
> -struct smu_13_0_0_powerplay_table
> -{
> +struct smu_13_0_0_powerplay_table {
>       struct atom_common_table_header header; //For SMU13,
> header.format_revision =3D 15, header.content_revision =3D 0
>       uint8_t table_revision;                 //For SMU13, table_revision
> =3D 2
>       uint8_t padding;
