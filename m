Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00959757FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjGROgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGROgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:36:53 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E11F1B1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:36:50 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a426e70575so3123708b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689691010; x=1692283010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQf+oUcGcr5G91Xt9lom7mrF/vizZR+ycdZT6h8lo/0=;
        b=SB4mlWwzsBk34tG45RbN/YgPk7FQApL/VzYYIeFJ4M+3kqFsOipRgLWo/hEAJIwS/G
         C9iapSlhqwnUjJ2D6c81q4j3KW1+T38ZA8ITylAJPDO2W1poeJadkdoVp2X7PftrZKmN
         LaAAvvubP8JiZ0cY8qAGFNW44/tcarbK/YCRrIxC45RIsRPUN3HquD6V/63bHN6Gq7Vp
         +TFhb1DjN3FqJUYIKXlinko4bwvR2k4IJEY9E4TR5zzH4nSnCHbFfckxqoBS5qmKt+Jh
         CzwZsuz67Mo3SIj3TYlm8blUxQYm8r9qJoism/T5q27IHKYBLHMcPZgtL1W87uKFBViB
         vpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689691010; x=1692283010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQf+oUcGcr5G91Xt9lom7mrF/vizZR+ycdZT6h8lo/0=;
        b=XocAE3hTiWUv8a/gdL6wfOWf62XJW0cfMs5OG/7jcfGMmRRJrohRVoJKi65+aXzEyb
         npbfwHuarsqPnsTWSupHCwGIy18k6EwrZZJa/2UfIgtJ/c75dGgtbY2x9yDuroih8Erv
         5BXQ3vgGrBO2N+Yx5Gj1JHiE6spvUyLvK08l7YdX/41EGkmr69qVxL+WSp/Z9ZW9yyBk
         Xdi744XA9EHWT4DlZaFReE6hrtFW81/xrBK0580MCKLMP5J9kpRlGCWxr6MswM4mx4QV
         fNu1mZJBKXWfJmGwo3sBLisnzS8RyoNEAYeMQDXIr9wsMuiBrJNHXumqMyFEdPOXMD95
         0+pw==
X-Gm-Message-State: ABy/qLbgyLIBlaCuxRcKvtqYAHhzoVNCvmynP1ctDmrZ6wc3rj6V8FQG
        lPxsTk+bJahssXE8r+AJ2pr7iPg691VCj+En/VM=
X-Google-Smtp-Source: APBJJlEsOBa3z0vgWEg0Rdv40N6WvpSECqAkmNTxr1hhe3KsAxJLk8xziuMp2+p+SQtn/hto02rwx0W5XpCwD0z1T+E=
X-Received: by 2002:a05:6808:e8a:b0:3a0:5b87:6ef7 with SMTP id
 k10-20020a0568080e8a00b003a05b876ef7mr13380685oil.2.1689691009800; Tue, 18
 Jul 2023 07:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_FDFE1B9D84BD3C51CAE7FADFDCF6613D5D0A@qq.com> <21b12c2d37bff73a0c625b6af9d95021@208suo.com>
In-Reply-To: <21b12c2d37bff73a0c625b6af9d95021@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 18 Jul 2023 10:36:39 -0400
Message-ID: <CADnq5_OM2+Ed8z7FU84yEGoyGZpQF5a-+ZPThPszU9b=xFuVHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/dpm: ERROR: open brace '{' following enum go
 on the same line
To:     shijie001@208suo.com
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm happy to apply these patches, but please check your mailer.  The
formatting is messed up and they don't apply cleanly.  Please use
git-format-patch and git-send-email to generate and send the patches.

Thanks!

Alex

On Fri, Jul 14, 2023 at 3:15=E2=80=AFAM <shijie001@208suo.com> wrote:
>
> Fix four occurrences of the checkpatch.pl error:
> ERROR: open brace '{' following enum go on the same line
>
> Signed-off-by: Jie Shi <shijie001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/ni_dpm.h | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ni_dpm.h
> b/drivers/gpu/drm/radeon/ni_dpm.h
> index 74e301936906..4e3e7303e035 100644
> --- a/drivers/gpu/drm/radeon/ni_dpm.h
> +++ b/drivers/gpu/drm/radeon/ni_dpm.h
> @@ -59,8 +59,7 @@ struct ni_mc_reg_table {
>
>   #define NISLANDS_MCREGISTERTABLE_FIRST_DRIVERSTATE_SLOT 2
>
> -enum ni_dc_cac_level
> -{
> +enum ni_dc_cac_level {
>       NISLANDS_DCCAC_LEVEL_0 =3D 0,
>       NISLANDS_DCCAC_LEVEL_1,
>       NISLANDS_DCCAC_LEVEL_2,
> @@ -72,8 +71,7 @@ enum ni_dc_cac_level
>       NISLANDS_DCCAC_MAX_LEVELS
>   };
>
> -struct ni_leakage_coeffients
> -{
> +struct ni_leakage_coeffients {
>       u32 at;
>       u32 bt;
>       u32 av;
> @@ -83,8 +81,7 @@ struct ni_leakage_coeffients
>       u32 t_ref;
>   };
>
> -struct ni_cac_data
> -{
> +struct ni_cac_data {
>       struct ni_leakage_coeffients leakage_coefficients;
>       u32 i_leakage;
>       s32 leakage_minimum_temperature;
> @@ -100,8 +97,7 @@ struct ni_cac_data
>       u8 lts_truncate_n;
>   };
>
> -struct ni_cac_weights
> -{
> +struct ni_cac_weights {
>       u32 weight_tcp_sig0;
>       u32 weight_tcp_sig1;
>       u32 weight_ta_sig;
