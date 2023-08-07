Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872BC772B71
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjHGQsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHGQsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:48:37 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3208999
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:48:36 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-56d8bc0d909so733912eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426915; x=1692031715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/XFpb9Q8SxuX4Bb0HzWApCl0ETedoYgIgDWXMebOdI=;
        b=JRv3FIduq6+iAKQo+88VdtQNqPMnEcW4wMVXdNwqZFEN2iMSHtgfvNqHy5Ck6bgYPV
         F8LcORa/HoiITMQyZepn1unEb0zD78crosXXir4GYrHNkZRsBGHmVioe4tRH1bqoQEXn
         zgCakowf1RxZ4c7jmEa9wCvIHVZzHYe885V/X5P2MzhoIM6tneK05nqGVTomjrLNzpCT
         boPNCd50O5WS70LDNR/FRbEZ607W7FjZoBl+GQo/BB2K7ODtc+Ktm9ztj6IxMfux7R/v
         oEuRuAni4FUdp10UXV7vJuph8LyzhheDCXlu7ieshfJ/3RPsqNmvoUednUni6/0Hc6+G
         Fcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426915; x=1692031715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/XFpb9Q8SxuX4Bb0HzWApCl0ETedoYgIgDWXMebOdI=;
        b=azA7SdoVXPVSJZT9PgI6/yOUbX1fjacnSjWhTxpmh9oWT/OZBigNJSgkPPu123KAD1
         K9OR9QMNDyM8nteAzFeHBzBMUCvdyMYfHqoecOdTS4YTG9EVGmpfs2aW23pqLgfMdKwx
         nI5b45i6/P9iMTvvqKqOJQsuQjSBwfDRehMwDEUnJNDOQATzVxrql0gLOm/UaZ02q9ga
         YPt7AfcRp//QxdHcwAGlmSapFpHbN4edRs8q0VL/xX4ad55Un3U1hxPUAIyH0MzCodeh
         408bONBgqnzzBXAZD5TaWMh0ploETn+gUheQt+ZZBhKX9C4HPA94UEfB01Pooq4bI+2M
         JSIA==
X-Gm-Message-State: AOJu0YzI1+QUxnFVAVOyXJtLbK0/3DswoJf+5jRtJvt1uXeEgHOYHW8A
        SSiEfYvFYPRLiHqLx0CTi4RZjmpvoQhKnJjcHZU=
X-Google-Smtp-Source: AGHT+IEHDP4Fk56b/IDFNDYPsywp6rtzDsPvd4tyvoY1127dvwwNOtZRqIx0ZoqYS1/qV0w36xVPjxLEYQ86n8O2rcg=
X-Received: by 2002:a4a:929a:0:b0:56c:7a55:f6b3 with SMTP id
 i26-20020a4a929a000000b0056c7a55f6b3mr8516267ooh.5.1691426915440; Mon, 07 Aug
 2023 09:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230801093656.7761-1-sunran001@208suo.com>
In-Reply-To: <20230801093656.7761-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:48:24 -0400
Message-ID: <CADnq5_N8PzxV27cpYsw9MBe2dDvt7Ba7Pjf1d_O8hpEgSjJZCg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm/powerplay/hwmgr/hwmgr: Clean up errors in hwmgr.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Aug 1, 2023 at 5:37=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space prohibited after that '~' (ctx:WxW)
> ERROR: spaces required around that '||' (ctx:VxW)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu=
/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> index f2cef0930aa9..2b5ac21fee39 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> @@ -120,7 +120,7 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
>                 case CHIP_TOPAZ:
>                         hwmgr->smumgr_funcs =3D &iceland_smu_funcs;
>                         topaz_set_asic_special_caps(hwmgr);
> -                       hwmgr->feature_mask &=3D ~ (PP_VBI_TIME_SUPPORT_M=
ASK |
> +                       hwmgr->feature_mask &=3D ~(PP_VBI_TIME_SUPPORT_MA=
SK |
>                                                 PP_ENABLE_GFX_CG_THRU_SMU=
);
>                         hwmgr->pp_table_version =3D PP_TABLE_V0;
>                         hwmgr->od_enabled =3D false;
> @@ -133,7 +133,7 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
>                 case CHIP_FIJI:
>                         hwmgr->smumgr_funcs =3D &fiji_smu_funcs;
>                         fiji_set_asic_special_caps(hwmgr);
> -                       hwmgr->feature_mask &=3D ~ (PP_VBI_TIME_SUPPORT_M=
ASK |
> +                       hwmgr->feature_mask &=3D ~(PP_VBI_TIME_SUPPORT_MA=
SK |
>                                                 PP_ENABLE_GFX_CG_THRU_SMU=
);
>                         break;
>                 case CHIP_POLARIS11:
> @@ -195,7 +195,7 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
>
>  int hwmgr_sw_init(struct pp_hwmgr *hwmgr)
>  {
> -       if (!hwmgr|| !hwmgr->smumgr_funcs || !hwmgr->smumgr_funcs->smu_in=
it)
> +       if (!hwmgr || !hwmgr->smumgr_funcs || !hwmgr->smumgr_funcs->smu_i=
nit)
>                 return -EINVAL;
>
>         phm_register_irq_handlers(hwmgr);
> --
> 2.17.1
>
