Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633117CCF0D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjJQVRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQVRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:17:03 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44008C4;
        Tue, 17 Oct 2023 14:17:01 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1dd71c0a41fso3801393fac.2;
        Tue, 17 Oct 2023 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697577417; x=1698182217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQG8MtBQiSnRV8n69T7HmV5t8yhCaq2M9pMbaLDDzpc=;
        b=Ofk5Y6ypjYNIivQhBoM1TvF9v8MomZX0IedV7/+Y4lEjqgRd7oYsOVdyqywfviLym3
         M930eFAgh5o+T96NeiTqY1UICmzjx3cnfWllmOhJ4HbZQqSjHW+m+vYtpYNSxgpZUyJc
         LJ4+Jf7Ffkj/Cv0OhLvYfaR9FAL0iJ939kvc17fEmVR5rXmBnUnP1ChN8ldzhGBc9dgU
         zacdL4DCqK8kP3TTrFuCqwREUjXsSROx3ssCAiw+9u+DlHC40mTFO6U/HgiDbQvv/T7Q
         Xwt/LGAsJI4GB51xTxPJROlI0be+/3RfpSHtJSeCTEdn2tOL3kTC8KzkuGUu4+eAu2FZ
         P1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697577417; x=1698182217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQG8MtBQiSnRV8n69T7HmV5t8yhCaq2M9pMbaLDDzpc=;
        b=tcC4t5jz3OwB8EVTiZCketkBgKDp4VzhmcoIMyKGq2ltzMc2L5HYV/wJBTIxWiiCpO
         qVLSoKc2hZrEh6MzK/Bet97xl/0JkKgHotvOzmWVxK0m95EnSSBmiXRCduEAzF4ueE8y
         OunnCUPUL+0Tpiw+1+UWJb3znNwF0X46CJTwNd6gmXkmJzs2OGueGCJhDMcWMLQmGUSw
         TXpXMY7JtcEr9KqUtlvDuQKefGhTC3DnqmBMFLLWiyW2KoAJu8TeufsIyuiSM9NwLbmX
         4hpDEthuEIoAJI8zHmmxE+Bpz979w7KOcUzjv3mlL0rvel+QXxiyqY7q78t0pOhGrDxQ
         gjmg==
X-Gm-Message-State: AOJu0YyQRVBv849UkqZb/4CgtI1OFb2c5X1SQgs3lHsDFqrAB9J6MfUQ
        Tcr89b+VvfFy0jbbA/yPKNsJVJO1nLV2qEKoVCQ=
X-Google-Smtp-Source: AGHT+IFIdnup1Pui0Ph3Sx3b6dyIUwP7KU7y+C7Voyy0lzypj5Ks7q5EsuqaHmjprmGcgrekVDP+pKHvrpPbrGFNJuA=
X-Received: by 2002:a05:6870:1314:b0:1e9:9f9b:eb80 with SMTP id
 20-20020a056870131400b001e99f9beb80mr3731834oab.46.1697577417041; Tue, 17 Oct
 2023 14:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231017080616.18970-1-colin.i.king@gmail.com>
In-Reply-To: <20231017080616.18970-1-colin.i.king@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 17 Oct 2023 17:16:46 -0400
Message-ID: <CADnq5_PemQtG4CeeDm4QvNMWF_O69AXD5k66R2C3OhWe8L6sdA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix a handful of spelling mistakes
 in dml_print output
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Oct 17, 2023 at 4:22=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There are a few spelling mistakes and an minor grammatical issue in
> some dml_print messages. Fix these.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/dr=
ivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> index 851db026f251..218c355a97a4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> @@ -1507,7 +1507,7 @@ static dml_bool_t CalculatePrefetchSchedule(struct =
display_mode_lib_scratch_st *
>                 dml_print("DML: Tvm: %fus - time to fetch page tables for=
 meta surface\n", s->TimeForFetchingMetaPTE);
>                 dml_print("DML: Tr0: %fus - time to fetch first row of da=
ta pagetables and first row of meta data (done in parallel)\n", s->TimeForF=
etchingRowInVBlank);
>                 dml_print("DML: Tsw: %fus =3D time to fetch enough pixel =
data and cursor data to feed the scalers init position and detile\n", (dml_=
float_t)s->LinesToRequestPrefetchPixelData * s->LineTime);
> -               dml_print("DML: To: %fus - time for propogation from scal=
er to optc\n", (*p->DSTYAfterScaler + ((dml_float_t) (*p->DSTXAfterScaler) =
/ (dml_float_t)p->myPipe->HTotal)) * s->LineTime);
> +               dml_print("DML: To: %fus - time for propagation from scal=
er to optc\n", (*p->DSTYAfterScaler + ((dml_float_t) (*p->DSTXAfterScaler) =
/ (dml_float_t)p->myPipe->HTotal)) * s->LineTime);
>                 dml_print("DML: Tvstartup - TSetup - Tcalc - Twait - Tpre=
 - To > 0\n");
>                 dml_print("DML: Tslack(pre): %fus - time left over in sch=
edule\n", p->VStartup * s->LineTime - s->TimeForFetchingMetaPTE - 2 * s->Ti=
meForFetchingRowInVBlank - (*p->DSTYAfterScaler + ((dml_float_t) (*p->DSTXA=
fterScaler) / (dml_float_t)p->myPipe->HTotal)) * s->LineTime - p->TWait - p=
->TCalc - *p->TSetup);
>                 dml_print("DML: row_bytes =3D dpte_row_bytes (per_pipe) =
=3D PixelPTEBytesPerRow =3D : %u\n", p->PixelPTEBytesPerRow);
> @@ -9323,7 +9323,7 @@ void dml_core_mode_programming(struct display_mode_=
lib_st *mode_lib, const struc
>                                 if (mode_lib->ms.policy.ImmediateFlipRequ=
irement[k] !=3D dml_immediate_flip_not_required && locals->ImmediateFlipSup=
portedForPipe[k] =3D=3D false) {
>                                         locals->ImmediateFlipSupported =
=3D false;
>  #ifdef __DML_VBA_DEBUG__
> -                                       dml_print("DML::%s: Pipe %0d not =
supporing iflip\n", __func__, k);
> +                                       dml_print("DML::%s: Pipe %0d not =
supporting iflip\n", __func__, k);
>  #endif
>                                 }
>                         }
> @@ -9376,7 +9376,7 @@ void dml_core_mode_programming(struct display_mode_=
lib_st *mode_lib, const struc
>         if (locals->PrefetchAndImmediateFlipSupported) {
>                 dml_print("DML::%s: Good, Prefetch and flip scheduling so=
lution found at VStartupLines=3D%u (MaxVStartupAllPlanes=3D%u)\n", __func__=
, s->VStartupLines-1, s->MaxVStartupAllPlanes);
>         } else {
> -               dml_print("DML::%s: Bad, Prefetch and flip scheduling sol=
uation NOT found solution! (MaxVStartupAllPlanes=3D%u)\n", __func__, s->Max=
VStartupAllPlanes);
> +               dml_print("DML::%s: Bad, Prefetch and flip scheduling sol=
ution did NOT find solution! (MaxVStartupAllPlanes=3D%u)\n", __func__, s->M=
axVStartupAllPlanes);
>         }
>
>         //Watermarks and NB P-State/DRAM Clock Change Support
> --
> 2.39.2
>
