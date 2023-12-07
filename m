Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B8B8092EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443911AbjLGVCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGVCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:02:52 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BF71708;
        Thu,  7 Dec 2023 13:02:58 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1fab887fab8so859052fac.0;
        Thu, 07 Dec 2023 13:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701982978; x=1702587778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qXRZGXdBXSemm1qgUJNad1VBnNG3ZhMxzznoRoFWFw=;
        b=Lr4Vo+pWnpj4n+/gmHo+ZOJWPE/j2Fxl4ylgzvfZFZGOnNxXIWGViHIs+ZEmyWOeoX
         yK3eft+yFM6ipAqWVL824AYCM8wU5y50YM4LAbCVCGfO2oJN1ndlU9kR7Zbg/lqWOiIr
         lleSLuttyFRABNykYmuyh8NhO3bedALl4XYpBtajH5dFfAu7qFxTn78eRe2xUubFV7gm
         0HZhRoNLy2/VT5UFHnDtZGWVP8NRMaUNdDiYio4FUvsAgh+uFtfixJXYRr0JzCXI6H1i
         8SkHBHy3yUX06ONZZqalNYWk7+1N6Yj835Tdx/O4fp+1HDdBblmRAXOexciqUYooUa4f
         +Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701982978; x=1702587778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qXRZGXdBXSemm1qgUJNad1VBnNG3ZhMxzznoRoFWFw=;
        b=MNdW3v+t1hecxaGN5XrnIFaT4od7rJQTZvXYgVY+H5QYp+zPr+ALzuYrmEeXDWEK+d
         99PLR/AZURKiCwoae540yTPdePQV+Qy6fjPHb2+AanJGc4k2Jjmk57ncRkjb2Olm6ysR
         z/YSaVAQn4Gj5x8TWC/4kmXvfQJSpYhBTkUL6/PogfzSs5HamPy/FsuX57tw6HmoxQ0N
         Jlon/0W/bQr/gGQSvhj3PJH5YmzE9VF/yZ9oUshv6cerT7o+NN5zprglBK1welc7Y/06
         NKdS5TAchEzY/horf78Ctl/IOH7RgP/H7QqiBdhEaiMpTU4fDv4YwO1/jn3oKWPysSJf
         Po6A==
X-Gm-Message-State: AOJu0Yy3qM/VGH4s94peuzmbhyMDYMpV5tg+EdpLDbE/RrsWGmp1p2T0
        W5jGKWcYQJa3LiqBKZ69Swc4oAhpdW+RCRQp+GbSNn7N
X-Google-Smtp-Source: AGHT+IFEzmWcYBTV00sk2s93Nrwk7f66goAtZQXFa6TwduRQuXjftgzU/1Fm91uq7zxSk5Hlblx4jX44EmOadZti7Ms=
X-Received: by 2002:a05:6870:818:b0:1f9:e965:191d with SMTP id
 fw24-20020a056870081800b001f9e965191dmr3678951oab.56.1701982978144; Thu, 07
 Dec 2023 13:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20231207105454.3138964-1-colin.i.king@gmail.com>
In-Reply-To: <20231207105454.3138964-1-colin.i.king@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 Dec 2023 16:02:47 -0500
Message-ID: <CADnq5_NnDgXqZ_qpKMiMf10a6Ls=c-CLC2KE1m-b2itLYT5DJg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix spelling mistake
 "SMC_MSG_AllowZstatesEntr" -> "SMC_MSG_AllowZstatesEntry"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Charlene Liu <charlene.liu@amd.com>,
        Sung Joon Kim <sungkim@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

Alex

On Thu, Dec 7, 2023 at 6:32=E2=80=AFAM Colin Ian King <colin.i.king@gmail.c=
om> wrote:
>
> There is a spelling mistake in a smu_print message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/d=
rivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
> index d6db9d7fced2..6d4a1ffab5ed 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
> @@ -361,26 +361,26 @@ void dcn35_smu_set_zstate_support(struct clk_mgr_in=
ternal *clk_mgr, enum dcn_zst
>         case DCN_ZSTATE_SUPPORT_ALLOW:
>                 msg_id =3D VBIOSSMC_MSG_AllowZstatesEntry;
>                 param =3D (1 << 10) | (1 << 9) | (1 << 8);
> -               smu_print("%s: SMC_MSG_AllowZstatesEntr msg =3D ALLOW, pa=
ram =3D %d\n", __func__, param);
> +               smu_print("%s: SMC_MSG_AllowZstatesEntry msg =3D ALLOW, p=
aram =3D %d\n", __func__, param);
>                 break;
>
>         case DCN_ZSTATE_SUPPORT_DISALLOW:
>                 msg_id =3D VBIOSSMC_MSG_AllowZstatesEntry;
>                 param =3D 0;
> -               smu_print("%s: SMC_MSG_AllowZstatesEntr msg_id =3D DISALL=
OW, param =3D %d\n",  __func__, param);
> +               smu_print("%s: SMC_MSG_AllowZstatesEntry msg_id =3D DISAL=
LOW, param =3D %d\n",  __func__, param);
>                 break;
>
>
>         case DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY:
>                 msg_id =3D VBIOSSMC_MSG_AllowZstatesEntry;
>                 param =3D (1 << 10);
> -               smu_print("%s: SMC_MSG_AllowZstatesEntr msg =3D ALLOW_Z10=
_ONLY, param =3D %d\n", __func__, param);
> +               smu_print("%s: SMC_MSG_AllowZstatesEntry msg =3D ALLOW_Z1=
0_ONLY, param =3D %d\n", __func__, param);
>                 break;
>
>         case DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY:
>                 msg_id =3D VBIOSSMC_MSG_AllowZstatesEntry;
>                 param =3D (1 << 10) | (1 << 8);
> -               smu_print("%s: SMC_MSG_AllowZstatesEntr msg =3D ALLOW_Z8_=
Z10_ONLY, param =3D %d\n", __func__, param);
> +               smu_print("%s: SMC_MSG_AllowZstatesEntry msg =3D ALLOW_Z8=
_Z10_ONLY, param =3D %d\n", __func__, param);
>                 break;
>
>         case DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY:
> --
> 2.39.2
>
