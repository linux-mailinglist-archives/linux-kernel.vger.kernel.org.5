Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF0B760185
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGXVtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjGXVtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:49:00 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B97170E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:48:59 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1bb954414e8so62939fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690235339; x=1690840139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVY78p9bK1Bp6OYFjZ0D65jc+/ozxlt9gkf3mIG8qJ8=;
        b=AKnH7nIE0azuBGdLAsUV6B+JFdb4MLuYJ0UlSAS2gs1T9+kYthwsHiwxJr+Fbf0fTy
         pSDELav/FGFKtsAJE63ztr+eJlck4VA76wgASUTMlngySxvZN6QfqPvN/BzkfQLyt583
         BqQR/XnRPy4f6moz1TTvPEbG2pkZZfa6JN6nOmieVJ25bl3cFHlPzSIchW/yq8QYSZfe
         vMBbMvvSVm+fj0nkDCpJ0RUWMrrhrJMS+FdLG/gu9LL/3jU1pPCj2ufRk2++lzbrv0kJ
         /BEAkCIybgWQ4XUf4lfPzlOo6h9QMzFoaeXq1N3tn+p4Pnzh6przonv4AR+KpNXt9Pa9
         wNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235339; x=1690840139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVY78p9bK1Bp6OYFjZ0D65jc+/ozxlt9gkf3mIG8qJ8=;
        b=J9Z12dqD4Opo2Dkq5YskyNCd+cCdy/5eWtpFbPQIDazMlmmrFFnLfTpaen/fzIZS2V
         OtBYozYKN9T+b8PI27Mf7ysVo1XD2ziIKElE0km4Z++BbyQt0KcQozaWQas01BJj+glp
         VbbXpky8TRFiYUZr82ZA+AN9tyaa3aasx/ht0XMMDpNPoUa7ueVdGiu9/YUd5ehciBlw
         pM/T1XTz2hW/zjTp4HynqrwhkZlecKQVoh1v8DNOJhh+HjKGhSupGAM/BIR01CbCS/2V
         wU5Tdy6zIrsn8nn34Gkb6tOez/Smy+QoPHGbbGRX/0rgjL0DqeCffvsfyEK2AWlsXgZu
         5BxA==
X-Gm-Message-State: ABy/qLZH7Os8GXMAmXM2dITwceiyGYgjFrbVih9MuiPw85tloOVwLiS0
        IcYpOK9IFaPAC06oXDs63NPBW4jqZvicWQWZtus=
X-Google-Smtp-Source: APBJJlGgr3DhZc0jXmHDid6h9Mxlb9XBB2RmEVIUhyDqVZljQi4ueZYRt1nuTrOWo4YPqZWKDcG8zypeh8Bs/PT39Rk=
X-Received: by 2002:a05:6870:b491:b0:1bb:91de:7f92 with SMTP id
 y17-20020a056870b49100b001bb91de7f92mr720387oap.23.1690235339063; Mon, 24 Jul
 2023 14:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230724073153.9003-1-xujianghui@cdjrlc.com> <71605c0ae02fcfd1d044aa9e52088543@208suo.com>
In-Reply-To: <71605c0ae02fcfd1d044aa9e52088543@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:48:48 -0400
Message-ID: <CADnq5_O=iGXp7+6GFGieroFxng9-h3L_sQ=BWp0Lhv8ZFA0QYQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in arcturus_ppt.c
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

Applied.  thanks!

On Mon, Jul 24, 2023 at 3:32=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: spaces required around that '=3D' (ctx:VxW)
> ERROR: spaces required around that '>=3D' (ctx:WxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 3bb18396d2f9..c49f770c97b3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -598,7 +598,7 @@ static int arcturus_get_smu_metrics_data(struct
> smu_context *smu,
>                                          MetricsMember_t member,
>                                          uint32_t *value)
>   {
> -       struct smu_table_context *smu_table=3D &smu->smu_table;
> +       struct smu_table_context *smu_table =3D &smu->smu_table;
>         SmuMetrics_t *metrics =3D (SmuMetrics_t *)smu_table->metrics_tabl=
e;
>         int ret =3D 0;
>
> @@ -1482,7 +1482,7 @@ static int arcturus_set_power_profile_mode(struct
> smu_context *smu,
>                 return ret;
>
>         if ((profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) &&
> -            (smu_version >=3D0x360d00)) {
> +            (smu_version >=3D 0x360d00)) {
>                 ret =3D smu_cmn_update_table(smu,
>                                        SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>                                        WORKLOAD_PPLIB_CUSTOM_BIT,
