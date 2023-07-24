Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F78A76014E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGXVji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGXVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:39:37 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD3CD8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:39:36 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a3ad1f39ebso3750303b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234775; x=1690839575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQvicdLmL4lt+yOX/xSjVt1t0bXl8fj+TJA76nTMosM=;
        b=V79dFufsH0cq8p82YJZTa6JJu805tKEi0siRmc7/XqFp1XYZLKgJRXMCdoYJjQaMoy
         3ueByAhffU3P9aRI3PW838rHnrnT34TzFvgDdxp6pOVBQTn+zHRJ94uCjW7qREnx8NBB
         pY4ACAMGjVbc9FxaFOFrw8Gy8Ylf/4mYjTIvy4qOwKIELL05P1mWTG1SEy+ufYq2EnAb
         a7l0qq3D+2hFJBQrUP2nMEdBM+Fz6oFjxQYhI0AsMhCoAN+/mVpw3BFJqCWpPlWEc39J
         YHSxAQ8fsoBlJKPiJrKBpxHvV27wo0km4mpy9TJPHYtNu5QDtet6YpHC5Jzobcb49tYq
         zt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234775; x=1690839575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQvicdLmL4lt+yOX/xSjVt1t0bXl8fj+TJA76nTMosM=;
        b=HfcZAUuuU+RlVg3i5jp07QtTrRUwo+i+5WoNHNUL0i+6axZeZuQmn6AODEFz2JhWk6
         SJE/IeuqTxiMeGuW18BsrHnBjclLrSrh4bWexB7s1G/WqeA9Rv6ZQV0brdDBsO1hdFvk
         gGMyUquYdkAVwfgJQuNzr8u4YEdKujHaGC1m+Ztk9nhFVLsMvE0PDFEg1HbkqVcbCpap
         wsaUhxRLmMsOis37UivLQEyt1SIHRl+mcYlvW0fYVt4t7FamS9OjXuTdNzH2vxVvvUdA
         icRRvZrl4l7Pib+uhuBcvdMQrMN2ReywqTCcxr6i/I9DJU1Ao4UunlBYFXRY5qyCZaq4
         4NPA==
X-Gm-Message-State: ABy/qLZtZm5RfsgH72nRU1mqjuRPNrw9EtXnZc6wvN5QNhMc2DzrF1in
        ba1uNsekjJzpPDmGnC/mlbbNMi6vqjRP+HMLQO8=
X-Google-Smtp-Source: APBJJlEMvcyH9ZXex3ywXk18jFbBc0CodET+fnbeLWDQUctaVJbHZTMwvtITsVZodqjKH5wz1nAo4hnF/svGcBwq5Zo=
X-Received: by 2002:a05:6808:189b:b0:3a3:652e:8862 with SMTP id
 bi27-20020a056808189b00b003a3652e8862mr352635oib.2.1690234775301; Mon, 24 Jul
 2023 14:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230724032920.7892-1-xujianghui@cdjrlc.com> <d88773902f7a8536a8be83ead18981b3@208suo.com>
In-Reply-To: <d88773902f7a8536a8be83ead18981b3@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:39:24 -0400
Message-ID: <CADnq5_M7x2js7C4fAUVsOd6YAfExqjVW5AapiqDxRQo2e4stBA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: add missing spaces after ',' and else should
 follow close brace '}'
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

Alex

On Sun, Jul 23, 2023 at 11:30=E2=80=AFPM <sunran001@208suo.com> wrote:
>
> ERROR: else should follow close brace '}'
>
> ERROR: space required after that ',' (ctx:VxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/radeon_connectors.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c
> b/drivers/gpu/drm/radeon/radeon_connectors.c
> index 07193cd0c417..4ceceb972e8d 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -198,8 +198,7 @@ int radeon_get_monitor_bpc(struct drm_connector
> *connector)
>                                 DRM_DEBUG("%s: HDMI deep color 10 bpc exc=
eeds max tmds clock. Using
> %d bpc.\n",
>                                                   connector->name, bpc);
>                         }
> -               }
> -               else if (bpc > 8) {
> +               } else if (bpc > 8) {
>                         /* max_tmds_clock missing, but hdmi spec mandates=
 it for deep color.
> */
>                         DRM_DEBUG("%s: Required max tmds clock for HDMI d=
eep color missing.
> Using 8 bpc.\n",
>                                           connector->name);
> @@ -1372,7 +1371,7 @@ radeon_dvi_detect(struct drm_connector *connector,
> bool force)
>                                         /* assume digital unless load det=
ected otherwise */
>                                         radeon_connector->use_digital =3D=
 true;
>                                         lret =3D encoder_funcs->detect(en=
coder, connector);
> -                                       DRM_DEBUG_KMS("load_detect %x ret=
urned:
> %x\n",encoder->encoder_type,lret);
> +                                       DRM_DEBUG_KMS("load_detect %x ret=
urned: %x\n",
> encoder->encoder_type, lret);
>                                         if (lret =3D=3D connector_status_=
connected)
>                                                 radeon_connector->use_dig=
ital =3D false;
>                                 }
