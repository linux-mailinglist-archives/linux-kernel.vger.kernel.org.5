Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683107601A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjGXV6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGXV6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:58:38 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D5D118
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:58:37 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-565f3881cbeso3407857eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690235916; x=1690840716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NJFs6oMV2v7s/6JWLw92i8k8fJbTsKr3ji5S2m8KS0=;
        b=iRhyHEHT9v0N25GBiANzkyyDiU2tkhSDVDb+ndq32RtThI/B1SEelfS7MJletWVxMs
         xHSzY/5cMtImbSa3tDKQv3FNId4sQASFMqVIaAANlenBUZIgne88uJuRXqN/PDEuDwS0
         JxX3JA/B8lOOaQFrErfISUrx08U/LwiBB3DMUIVIykUhjmtzyOWSC+KsD+mkvJM0aDUQ
         qmyCQqAThsL44UtNgdztyMHKrQwp90hHcYHlzeFdNZq9oqTJZYQz2JD5ocXRg3Jd3eHc
         y2PadWI0ZL0YSIAIYRIKHLW7YtgMoHMZ6pSO3C4t1v1wVLbL4Gwa/jvrYOwwz4TSoAfE
         xHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235916; x=1690840716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NJFs6oMV2v7s/6JWLw92i8k8fJbTsKr3ji5S2m8KS0=;
        b=epIGGYiPgTcTVe++5N4LL5dWsFcYx6Ro3R+o6T+o9ZsXfvIc2+CpXmLgqsv1SbslPO
         o3x5ozjbd//TPpk09SKQsLkKMcfT3UuB1QQPjtk3RMAZvU1mtkcp4q3ONBB2KKEYgDKw
         fatoQ2NqavUKjcxVIqYD6fTOZDT9CYbAPHpxOJh30TswVjKmclA+OI729WtARPyo2dig
         YrBsXqlgaHwX9sPwRGlnleEBX648eCio3Y0FN46yTfNgely1aZBU11jiqGZXyHvoN95J
         WvSJAby0P3FXTNXn3ft/AhHmIkM1IoJa+9xpzXRWCGcVUuVJ+Dfz4S9t08n+v3Y2fFez
         5PJg==
X-Gm-Message-State: ABy/qLbBEHh7MQVWK0VWjTggwfja1JvmepbGg5IQJp2uDVLIlkDHoz4l
        LDJuW2yezwOE4FjBAQs0YsdZYqSH/XM0MIPmHLY=
X-Google-Smtp-Source: APBJJlEjAyCLEl3W4KjypzjxkJg0xvoj++O/ICBdF0x8TZ0kBTlIiMDzQZR83k+PaRGpN5MVvoEIjibwSTR2y5mubxM=
X-Received: by 2002:a4a:750d:0:b0:569:d46a:5c1d with SMTP id
 j13-20020a4a750d000000b00569d46a5c1dmr4477416ooc.4.1690235916477; Mon, 24 Jul
 2023 14:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230724083344.9285-1-xujianghui@cdjrlc.com> <7e638628f942fe7989fe2da3da537c28@208suo.com>
In-Reply-To: <7e638628f942fe7989fe2da3da537c28@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:58:25 -0400
Message-ID: <CADnq5_Pj+B8azBwSMAWg5d=UWS9ey-wnVTJWLScHCv--xMLTgw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu_v13_0_1_pmfw.h
To:     sunran001@208suo.com
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

This doesn't apply cleanly.

Alex

On Mon, Jul 24, 2023 at 4:57=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: trailing whitespace
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
> index c5e26d619bf0..8ec588248aac 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
> @@ -30,7 +30,7 @@
>
>   #define ENABLE_DEBUG_FEATURES
>
> -// Firmware features
> +// Firmware features
>   // Feature Control Defines
>   #define FEATURE_CCLK_DPM_BIT                 0
>   #define FEATURE_FAN_CONTROLLER_BIT           1
> @@ -92,7 +92,7 @@
>   #define FEATURE_ZSTATES_ECO_BIT             57
>   #define FEATURE_CC6_BIT                     58
>   #define FEATURE_DS_UMCCLK_BIT               59
> -#define FEATURE_DS_HSPCLK_BIT               60
> +#define FEATURE_DS_HSPCLK_BIT               60
>   #define NUM_FEATURES                        61
>
>   typedef struct {
