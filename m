Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E0A7CDE2C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbjJROA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjJROAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:00:54 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCCC106
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:00:51 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c49f781855so4503927a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697637651; x=1698242451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSpW0doOcXn+5lTEk2bF0qorpVq0IOpiC8aimltnNyc=;
        b=ZdmVd3MDe1hquHpYx8DRza3mYM5v0ZruXN7tnsaOiVvpivsUuOBO80fHp5lOKe9QM2
         Q6BfTYENDRxvmswl4pjuUlRzS/jil+/Ad4aSerWuNTka/+5O+CYZQ++/S64F9XGmZUS7
         Ku55RDrp9/LdeW1Tx/Tgjpf6m9vYSo4KoEZjiaKbx+SzJiIgBJgfPFRpUYaDtUQ0G5tJ
         uD+A+TrWfM2Xa3DHrElOBDj2fODQOUKTqPks+944v/0wdgLFRmonGPUchYYM+4yJ3vD8
         aSTTU028SjpsiU79NmTumobxBLNZVgq6Id6UaqjHptKK567najqdjlyRqw6p8jIlbuAN
         9d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637651; x=1698242451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSpW0doOcXn+5lTEk2bF0qorpVq0IOpiC8aimltnNyc=;
        b=gnkPff1qm28ET0Q3faTbI9bxlVxFRIqJMxRrlVGM/8kADKFAca2c39vFsx85uzGFdu
         Dbx8C88OkIrQWq7cHuZtQF1lcJQDsO7KjGHPij/O8hZu7moymTvbjefgAp+uYanccuP3
         jY1v1tUrjHESX0QXH8fDHpFFFMiIsKwu9I6MyVkgO6jyWjBKuF25RcdvKmZ6FZpdrxhu
         +pl+SWEK/WO9ScoCD3PcjUBbEL5aM6EX9tvCyMMwiZuvh84T9+EystqtmnsrBwMQGsWY
         p+VTEqUZ5YzI2nbxyTCtORoBc1cAw25o8s3leec83/JaAYdTKyBiusuPCpUCzH0yLId6
         UbeA==
X-Gm-Message-State: AOJu0YxkYExaBIA8j6DTYDEQdQEjoQMiRNxuoF4vVU3W4rnU4XxbqiSM
        iuKsG28/iDoJGWEK/RSnECJgiPFMeCrEQT8sn7c=
X-Google-Smtp-Source: AGHT+IEQ4VEtbC0I6wuqk0m6CgF4CBRg3eATOWskFebNDExHAfRNTUc8nf7f+4X0neKTlP5ZmmLRREbS7bZuwo/7gww=
X-Received: by 2002:a05:6871:8784:b0:1e9:bd5c:ae40 with SMTP id
 td4-20020a056871878400b001e9bd5cae40mr5801664oab.38.1697637650989; Wed, 18
 Oct 2023 07:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231018012232.23995-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20231018012232.23995-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 18 Oct 2023 10:00:39 -0400
Message-ID: <CADnq5_ONGOu-1SWzD99vr5CBtQzRXxOOUMMzto9UeN4q92Ri_Q@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Simplify bool conversion
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, harry.wentland@amd.com,
        airlied@gmail.com, daniel@ffwll.ch,
        Abaci Robot <abaci@linux.alibaba.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Oct 17, 2023 at 9:22=E2=80=AFPM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> ./drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c:4802:84-89: WAR=
NING: conversion to bool not needed here
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D6901
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/dr=
ivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> index 851db026f251..3296c078ff3e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> @@ -4799,7 +4799,7 @@ static void CalculateSurfaceSizeInMall(
>                 if (UseMALLForStaticScreen[k] =3D=3D dml_use_mall_static_=
screen_enable)
>                         TotalSurfaceSizeInMALL =3D TotalSurfaceSizeInMALL=
 + SurfaceSizeInMALL[k];
>         }
> -       *ExceededMALLSize =3D (TotalSurfaceSizeInMALL <=3D MALLAllocatedF=
orDCN * 1024 * 1024 ? false : true);
> +       *ExceededMALLSize =3D (TotalSurfaceSizeInMALL > MALLAllocatedForD=
CN * 1024 * 1024);
>  } // CalculateSurfaceSizeInMall
>
>  static void CalculateDETBufferSize(
> --
> 2.20.1.7.g153144c
>
