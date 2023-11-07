Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8B67E439D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343950AbjKGPj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjKGPjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:39:55 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6E994
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:39:52 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d30d9f4549so3736105a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699371591; x=1699976391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW7foL1oxcRpbeUsbIlYVRRPx5rqbcU/gbE+Wj+BaFE=;
        b=fen5jdeU+DNPR6z4fZONGR9aYqZf6PTMqRjolZuwZP+vzoxR3IPtGhmE4JSxql+XmL
         gHpqBOTm3UhDZK+4uhR7qTtm4NwUrSpvhTYY/HZjUfVUqx4tF5r8VHvtKwjDOPFLltn3
         dQJ2bQ3MLFXwkoOCn1ENQyI9liznz1LZA2Ro5o42o+cihQ7ixBOzWfqkvDWUduMn3HKH
         yzJCyxt3RrEfFa1px63xaaFUIRkGzosbaE0WmWi8tIATTvFLKKZ+WFfDJyarRE/cs5/d
         oqtkNGZHqj3UTn/0xrGgJBJOIJ8ik/yYKw8syF7WCG6DSwQVLIHvQ7GtElXz0ig3eHh8
         teZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699371591; x=1699976391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW7foL1oxcRpbeUsbIlYVRRPx5rqbcU/gbE+Wj+BaFE=;
        b=jBuX6uqMDh6zBq+q9qAZwm2jWKGZFKALoOMVnUjyVoDRwR6DvKpabGceR0YMG4PWbq
         asZj5nO4yIQGSBkZdPXsexiMbWIzuOQhk2FwxEDkpXXvPyDr3yGTjsppMKgPmT1o7xKE
         3QvGc815AjfJNoifBBRi+QH/FTOohK3SqHYyad4tqMGwnKodTOmEDxJdaYPHlbiOVmQd
         /VIWicQ7Iu97d236iQ6+5p7F5J8JD+Ev8VL9M9EmZ1QZssIGo21kQp4a6DKuUjY9apgc
         BLlQHuD841pT0MZGZO62EDmcuC0yjkeSrFVPM8Gle7i0IYfkMg43dA498XFbjj6b79nD
         O78Q==
X-Gm-Message-State: AOJu0YxneTtmhmNEhlSyDHXp2sl1CTSs9lIQW+mkNJk7Yia2e5hBkcdH
        +53jp1tanCfGfL/thHYXXoU5I2aOoqc7MbApQEY=
X-Google-Smtp-Source: AGHT+IFvtIGgWBLyu7RRG3uFcIzUM0xQQOleEl4WYezcoWx58X/a2dPjF56SgV0wq6ut3+Af0EixxFZNfu5sL4Wnq0k=
X-Received: by 2002:a05:6870:168a:b0:1ef:bae2:e3ac with SMTP id
 j10-20020a056870168a00b001efbae2e3acmr3487366oae.55.1699371591585; Tue, 07
 Nov 2023 07:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20231107082839.92061-1-jose.pekkarinen@foxhound.fi>
In-Reply-To: <20231107082839.92061-1-jose.pekkarinen@foxhound.fi>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Nov 2023 10:39:40 -0500
Message-ID: <CADnq5_NpMmo5SdXdStcRMGfcz0v6Nu-ZTORsSHo4_m_piAB77Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: clean up redundant conversions to bool
To:     =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Bhawanpreet.Lakha@amd.com, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 4:44=E2=80=AFAM Jos=C3=A9 Pekkarinen
<jose.pekkarinen@foxhound.fi> wrote:
>
> This patch will address the following couple of warnings retrieved by
> using coccinelle, where there is an explicit conversion to bool that
> are redundant.
>
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c:94:102-107: WARN=
ING: conversion to bool not needed here
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c:102:72-77: WARNI=
NG: conversion to bool not needed here
>
> Signed-off-by: Jos=C3=A9 Pekkarinen <jose.pekkarinen@foxhound.fi>

Thanks for the patch, but this was already fixed by Srinivasan a while ago.

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
> index 32d3086c4cb7..5ce542b1f860 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
> @@ -91,7 +91,7 @@ bool amdgpu_dm_setup_replay(struct dc_link *link, struc=
t amdgpu_dm_connector *ac
>         pr_config.replay_supported =3D true;
>         pr_config.replay_power_opt_supported =3D 0;
>         pr_config.replay_enable_option |=3D pr_enable_option_static_scree=
n;
> -       pr_config.replay_timing_sync_supported =3D aconnector->max_vfreq =
>=3D 2 * aconnector->min_vfreq ? true : false;
> +       pr_config.replay_timing_sync_supported =3D aconnector->max_vfreq =
>=3D 2 * aconnector->min_vfreq;
>
>         if (!pr_config.replay_timing_sync_supported)
>                 pr_config.replay_enable_option &=3D ~pr_enable_option_gen=
eral_ui;
> @@ -99,7 +99,7 @@ bool amdgpu_dm_setup_replay(struct dc_link *link, struc=
t amdgpu_dm_connector *ac
>         debug_flags =3D (union replay_debug_flags *)&pr_config.debug_flag=
s;
>         debug_flags->u32All =3D 0;
>         debug_flags->bitfields.visual_confirm =3D
> -               link->ctx->dc->debug.visual_confirm =3D=3D VISUAL_CONFIRM=
_REPLAY ? true : false;
> +               link->ctx->dc->debug.visual_confirm =3D=3D VISUAL_CONFIRM=
_REPLAY;
>
>         link->replay_settings.replay_feature_enabled =3D true;
>
> --
> 2.39.2
>
