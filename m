Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4309772A69
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjHGQU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHGQUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:20:24 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC9410D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:20:23 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bc9c01e154so3578401a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425223; x=1692030023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFgEczBVOmwiviyA0fAfUVo2xor8ZUuCQLMEthf9n1g=;
        b=QQws6JNdH3Ir4CXOIgPnwaa8y7FwpFfLiPIou/77zYkl6kLvqBPYXFDAqYZpsFDG5w
         Qik1kHvUKAJQY8vhofXUo9xNBwm4cb02k2JtD2ExXfgb+aV7nQB8lMTIq8Z3eToETBOq
         eJ1SgAQ2ynj+kPTSv3GHYWxQnOeT/v3J47ftoDGLALF/yyTMMNmTc12TfSwZR7duPWIH
         qORPX5IciAow3eXhN5An/fTYhzwt6gEwkuw5gsVNL5ow5J/XkEWDQpc5af+PRaiM7Lnq
         5sHKhBvQbvjG7DRN3CSRHlaIFORZOiX5YScAyfsaN/IkZCRxgyv3cS3+ItXHaZkKTpT/
         Migw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425223; x=1692030023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFgEczBVOmwiviyA0fAfUVo2xor8ZUuCQLMEthf9n1g=;
        b=PSPHVaJoU2MDk3xTkkTPun6y2KmBKugR6I+Pev5Jk86WZT1l+bnfP34/rUZZj+/Ccd
         d9i3IuvA07VzGxRvCaeP19PXSzkFDqY3fLIK+hlxzHZ6UomjseQ39xpBxP1gA1PAiS3i
         DUUF4vdv4vD0KYMUJsxTETLe2SMK85Gn2baKlKGp8XayGOf6UUcTvJqlhvm2F2YLubOM
         c8WFzpMyNH2L0Ut9UuxX+x0rg+U4R6s2dvXm+QY2W9C7/mVeKJPxWc7Cx5zSVQ4hhKgq
         8lOpEEu1Kp7iagtpGpObfg/ThEBn+MNIIGpDWJJe0ghjflcnNdlYB/z6g4aB1ynAxXkh
         I3uQ==
X-Gm-Message-State: AOJu0Yyd/ePkz6Hwf5WRor+eBsl8yPHfvxlLUDJCl8z0FdQDeIgI+CYE
        LnHskEN7iqqC4wBhz1Z+xOVv7QzohF+36BBNE3I=
X-Google-Smtp-Source: AGHT+IHbslJXFOnho9JUjULNY7bfYsjdUEcd3xNZCdbeKxSuR0POaVNEvGZzwZT5YyzP3NnHf57KLQ7rSp/PLjaxgUY=
X-Received: by 2002:a05:6870:560c:b0:1bf:8978:1eb8 with SMTP id
 m12-20020a056870560c00b001bf89781eb8mr6583944oao.17.1691425223179; Mon, 07
 Aug 2023 09:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230801014318.4097-1-sunran001@208suo.com>
In-Reply-To: <20230801014318.4097-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:20:12 -0400
Message-ID: <CADnq5_PAgA958H9gx97k1eUXedNpcP8YtmuFihQPJc=ximkFvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu_v13_0.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
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

On Mon, Jul 31, 2023 at 9:43=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space required before the open parenthesis '('
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 9b62b45ebb7f..895cda8e6934 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1121,7 +1121,7 @@ smu_v13_0_display_clock_voltage_request(struct smu_=
context *smu,
>
>                 ret =3D smu_v13_0_set_hard_freq_limited_range(smu, clk_se=
lect, clk_freq, 0);
>
> -               if(clk_select =3D=3D SMU_UCLK)
> +               if (clk_select =3D=3D SMU_UCLK)
>                         smu->hard_min_uclk_req_from_dal =3D clk_freq;
>         }
>
> @@ -1437,8 +1437,7 @@ static int smu_v13_0_irq_process(struct amdgpu_devi=
ce *adev,
>         return 0;
>  }
>
> -static const struct amdgpu_irq_src_funcs smu_v13_0_irq_funcs =3D
> -{
> +static const struct amdgpu_irq_src_funcs smu_v13_0_irq_funcs =3D {
>         .set =3D smu_v13_0_set_irq_state,
>         .process =3D smu_v13_0_irq_process,
>  };
> @@ -1933,7 +1932,7 @@ static int smu_v13_0_get_dpm_level_count(struct smu=
_context *smu,
>
>         ret =3D smu_v13_0_get_dpm_freq_by_index(smu, clk_type, 0xff, valu=
e);
>         /* SMU v13.0.2 FW returns 0 based max level, increment by one for=
 it */
> -       if((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, =
2)) && (!ret && value))
> +       if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0,=
 2)) && (!ret && value))
>                 ++(*value);
>
>         return ret;
> --
> 2.17.1
>
