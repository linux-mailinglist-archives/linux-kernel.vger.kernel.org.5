Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EAC760173
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjGXVo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGXVo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:44:26 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0A3120
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:44:26 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-55e1ae72dceso3090572eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690235065; x=1690839865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlHxsY9OcrrDCal1ZNdgpHuchbxam/ZBDhN8uMZFULc=;
        b=M7sUc1gW3sLWS8GMvsV462wSss4hddFsBEUqscVpoXFdr62KZQPr9lm9mjTxQo8Fps
         5z077odF859+vejqTUQIBca0alsNUECh+TWMC9EQmNEriKqWq3Q3dytAQ91j5pnq+qt5
         GbuGNFAIQgiHNX6dnZMWEAVy2QZcJR3slvYGc6qQG51EKRpjQZ63sLSrLghgB4qw3LTz
         /8mbN8aqFB5EZ+rpDLyiSlYpj4R40MJ3X7x+gXFQlVM1cHJ2BW1dQzawl2DKSXAIz3nV
         aKTM6bn0GCSNbFCY/bEH+gHYcd5xwYaCNeEnh1GpjGWCs5dpi83Kt9wVyGToUufy0LC1
         O62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235065; x=1690839865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlHxsY9OcrrDCal1ZNdgpHuchbxam/ZBDhN8uMZFULc=;
        b=VWC0SBgW4qAYYloCKLH6QhDgBJzuUJw+/izwJqeHKrRwFkP6irpzVWVQl4oNDmfWUe
         LfDmrD9pV8n7krXRl/bpylxZaSBoj9/HzPRM/s7YtGlp7vd7TnvCxuE0PYqS8z8KoZPG
         5f21DQFMnnzXaiGy2uGgsf8p9PgYBSFJ1f9zSc468Fau9BHgROv8dqAesdIZ8giML+cM
         4JlOJgj1y3frR4ZxKAk2EhjiBaaVicFLc90bUvyZV6MhE/Tqhe1kLrnJf4QPmejk59BC
         va5nVJLLCoK5JNHG+1QamNeqtw9zxEHRCMcxKeHNKLDwrXuxSgFcD10puAvYJHHBAzYj
         1XWg==
X-Gm-Message-State: ABy/qLbK//7E9QRrVCaf6oSMjC2gH9tFgPOleyvZhlafMRfz2ayZksTW
        CbDfm8kp1S+1h7o0ubi7TcbBmKPwMtM0fHL4EqEWWDUJ
X-Google-Smtp-Source: APBJJlEg7/5AKifoi+TnBm8aAaktrudaF0wR/ft0Cx9kmj1mrHGtFnMgPXRkyDfas0B3XBO4l/9RX1au+STS/+RL0TA=
X-Received: by 2002:a05:6870:d112:b0:1b0:3ffc:97e9 with SMTP id
 e18-20020a056870d11200b001b03ffc97e9mr12694143oac.0.1690235065373; Mon, 24
 Jul 2023 14:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230724034415.8257-1-xujianghui@cdjrlc.com> <304e90636af5cb6843ae603cd973680f@208suo.com>
In-Reply-To: <304e90636af5cb6843ae603cd973680f@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:44:14 -0400
Message-ID: <CADnq5_M4uLoVGn02NC7bCFwbMieOsr7MOzSoTXgXnruDNzCy4g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Move assignment outside if condition
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

On Sun, Jul 23, 2023 at 11:45=E2=80=AFPM <sunran001@208suo.com> wrote:
>
> Fixes the following checkpatch errors:
>
> ERROR: do not use assignment in if condition
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/radeon_legacy_tv.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_legacy_tv.c
> b/drivers/gpu/drm/radeon/radeon_legacy_tv.c
> index 12e180b119ac..7883e9ec0bae 100644
> --- a/drivers/gpu/drm/radeon/radeon_legacy_tv.c
> +++ b/drivers/gpu/drm/radeon/radeon_legacy_tv.c
> @@ -724,12 +724,14 @@ void radeon_legacy_tv_mode_set(struct drm_encoder
> *encoder,
>         }
>
>         for (i =3D 0; i < MAX_H_CODE_TIMING_LEN; i++) {
> -               if ((tv_dac->tv.h_code_timing[i] =3D hor_timing[i]) =3D=
=3D 0)
> +               tv_dac->tv.h_code_timing[i] =3D hor_timing[i];
> +               if (tv_dac->tv.h_code_timing[i] =3D=3D 0)
>                         break;
>         }
>
>         for (i =3D 0; i < MAX_V_CODE_TIMING_LEN; i++) {
> -               if ((tv_dac->tv.v_code_timing[i] =3D vert_timing[i]) =3D=
=3D 0)
> +               tv_dac->tv.v_code_timing[i] =3D vert_timing[i];
> +               if (tv_dac->tv.v_code_timing[i] =3D=3D 0)
>                         break;
>         }
