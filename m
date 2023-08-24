Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1207871E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbjHXOji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbjHXOjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:39:32 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BE21BC5;
        Thu, 24 Aug 2023 07:39:30 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a43cbb432aso4626056b6e.3;
        Thu, 24 Aug 2023 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692887969; x=1693492769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrK71RvaQ7b4OCylU/4LUKFwalwp4s36HCe5cCV9fk8=;
        b=hq3EB23/XpHs6XqYoXRFITE/p/yPGuHar54ibOcWKvSiEALt3/E0ipfKRJOhmAr9T7
         iXGJ6ZuOr9JaipvsmK/PV8DtB7whKXhsEl6cYKLWqI8BU+gxLCgnjwtUPH2vehAltBCr
         pI1VRffqDstCJHz+ULdBY9/941oPTpbtAP5fVUu/bbQD7PhOUY3M1bg4kNi8ttDRnLgE
         F2ba3zEv5WhVXX+1akMykFe7/W7Vjf+WX+ybejcNV62+T8raKjCQLjmwtmaMeoTI6IDp
         8hn382ivq+0816PIUb7cBFxyDpsJEazoV0NQowfUiBSt1IybWaEpz/wV/h7RwHburC69
         ZHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887969; x=1693492769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrK71RvaQ7b4OCylU/4LUKFwalwp4s36HCe5cCV9fk8=;
        b=KRP0eOWfXrh6IAfUA6kJNawFvKfTqCVI5lwhHgIQZsfxm3dO21jYegA6QoiiWgYHxa
         4uQrfBZoke7erdf5Io/P7fQapOA1sncY8AIx8ZuuSDiynXL3Irpg/AjlxLJ0f41CGeIv
         3DKW0JrKkSTiNNJ5TtRrSvH1l7kvC8Lbsd8q/1hw11ElBBxPZ8lw+dycAdSVKVww4D7f
         VQQGkg8NUjmDdqaptkDBqTikEqqkgOa+dk+qfmlGPgn0Gmj6NkHwdur0l8vc4MwwwtRK
         oC0uAG/AJF4OOm9y/qa6OnGvahjdgEwvOBO6VHO85qNlYXOKZHaBIP9I0oUm/cGPCQVS
         0weA==
X-Gm-Message-State: AOJu0Ywzk8DQNhKIViFEbK+p9SYfEK7oJzVNd7ndqSFMC1Ajnrktsv7L
        2X9GGmtvQH+0nVFF8Y15rZ6kJNfjXtIJCJsVesQ=
X-Google-Smtp-Source: AGHT+IFgcLrF31v+WCFEQImPho9YhEJmvzbCnLfTuAfXnXJePen5IsCGW7BJuqY2tW7Tb+e203u+QBPbA8JpfyBYFkM=
X-Received: by 2002:a05:6808:2a62:b0:3a7:7d4:4f91 with SMTP id
 fu2-20020a0568082a6200b003a707d44f91mr16668415oib.14.1692887969702; Thu, 24
 Aug 2023 07:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230823090323.184121-1-colin.i.king@gmail.com> <PH7PR12MB599765C42139EDFCA7080339821CA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB599765C42139EDFCA7080339821CA@PH7PR12MB5997.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 24 Aug 2023 10:39:18 -0400
Message-ID: <CADnq5_Oz22ahx3q0a3guye_TUvDDStfsdJBQjg6EfDpctVTRGQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd: Fix spelling mistake "throtting" -> "throttling"
To:     "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Alex

On Wed, Aug 23, 2023 at 5:50=E2=80=AFAM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Co=
lin Ian King
> Sent: Wednesday, August 23, 2023 5:03 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Airlie <ai=
rlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Lazar, Lijo <Lijo.Lazar@=
amd.com>; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org
> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH][next] drm/amd: Fix spelling mistake "throtting" -> "thro=
ttling"
>
> There is a spelling mistake in variable throtting_events, rename it to th=
rottling_events.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 6 +++---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 6 +++---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 704a2b577a0e..fbcff154b1d0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2313,7 +2313,7 @@ static const struct throttling_logging_label {  sta=
tic void arcturus_log_thermal_throttling_event(struct smu_context *smu)  {
>         int ret;
> -       int throttler_idx, throtting_events =3D 0, buf_idx =3D 0;
> +       int throttler_idx, throttling_events =3D 0, buf_idx =3D 0;
>         struct amdgpu_device *adev =3D smu->adev;
>         uint32_t throttler_status;
>         char log_buf[256];
> @@ -2328,11 +2328,11 @@ static void arcturus_log_thermal_throttling_event=
(struct smu_context *smu)
>         for (throttler_idx =3D 0; throttler_idx < ARRAY_SIZE(logging_labe=
l);
>              throttler_idx++) {
>                 if (throttler_status & logging_label[throttler_idx].featu=
re_mask) {
> -                       throtting_events++;
> +                       throttling_events++;
>                         buf_idx +=3D snprintf(log_buf + buf_idx,
>                                             sizeof(log_buf) - buf_idx,
>                                             "%s%s",
> -                                           throtting_events > 1 ? " and =
" : "",
> +                                           throttling_events > 1 ? " and=
 " : "",
>                                             logging_label[throttler_idx].=
label);
>                         if (buf_idx >=3D sizeof(log_buf)) {
>                                 dev_err(adev->dev, "buffer overflow!\n");=
 diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index cc3169400c9b..bed5a9df1c06 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1674,7 +1674,7 @@ static const struct throttling_logging_label {  sta=
tic void aldebaran_log_thermal_throttling_event(struct smu_context *smu)  {
>         int ret;
> -       int throttler_idx, throtting_events =3D 0, buf_idx =3D 0;
> +       int throttler_idx, throttling_events =3D 0, buf_idx =3D 0;
>         struct amdgpu_device *adev =3D smu->adev;
>         uint32_t throttler_status;
>         char log_buf[256];
> @@ -1689,11 +1689,11 @@ static void aldebaran_log_thermal_throttling_even=
t(struct smu_context *smu)
>         for (throttler_idx =3D 0; throttler_idx < ARRAY_SIZE(logging_labe=
l);
>              throttler_idx++) {
>                 if (throttler_status & logging_label[throttler_idx].featu=
re_mask) {
> -                       throtting_events++;
> +                       throttling_events++;
>                         buf_idx +=3D snprintf(log_buf + buf_idx,
>                                             sizeof(log_buf) - buf_idx,
>                                             "%s%s",
> -                                           throtting_events > 1 ? " and =
" : "",
> +                                           throttling_events > 1 ? " and=
 " : "",
>                                             logging_label[throttler_idx].=
label);
>                         if (buf_idx >=3D sizeof(log_buf)) {
>                                 dev_err(adev->dev, "buffer overflow!\n");=
 diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index d3b578e6bc2a..fa4ad08099ef 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1888,7 +1888,7 @@ static const char *const throttling_logging_label[]=
 =3D {
>
>  static void smu_v13_0_6_log_thermal_throttling_event(struct smu_context =
*smu)  {
> -       int throttler_idx, throtting_events =3D 0, buf_idx =3D 0;
> +       int throttler_idx, throttling_events =3D 0, buf_idx =3D 0;
>         struct amdgpu_device *adev =3D smu->adev;
>         uint32_t throttler_status;
>         char log_buf[256];
> @@ -1902,10 +1902,10 @@ static void smu_v13_0_6_log_thermal_throttling_ev=
ent(struct smu_context *smu)
>              throttler_idx < ARRAY_SIZE(throttling_logging_label);
>              throttler_idx++) {
>                 if (throttler_status & (1U << throttler_idx)) {
> -                       throtting_events++;
> +                       throttling_events++;
>                         buf_idx +=3D snprintf(
>                                 log_buf + buf_idx, sizeof(log_buf) - buf_=
idx,
> -                               "%s%s", throtting_events > 1 ? " and " : =
"",
> +                               "%s%s", throttling_events > 1 ? " and " :=
 "",
>                                 throttling_logging_label[throttler_idx]);
>                         if (buf_idx >=3D sizeof(log_buf)) {
>                                 dev_err(adev->dev, "buffer overflow!\n");
> --
> 2.39.2
>
