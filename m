Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C881F772A92
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjHGQYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjHGQYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:24:38 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7F310DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:24:23 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-56c96982829so3294709eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425462; x=1692030262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA7ZGTP/1iIUz0NSZwan87qZk2dibq5PfQ7YdL9IqMM=;
        b=hA6asJm0yHV08nnQvgNI1vQwBdogPPdoOirvla3DXIv13onvTOJUXQGi9YL0QdFrz9
         QyMbdCorzP+ZVfAQDYS4rN/P8b5AGQvcjIyUdiSeTlGCqmN9ba1IrkCZi9eGKbwojvw0
         WUo6AuZW014oePyJcQc3Y0+rU3rJrk9dLNBP1zj/YmHxgWZcdrKbDudIxvpKY3aQLyJG
         CneiIBU20bvfwqpWRr/i+d3fsHydsuOlhD9Vkv/+XFds4Orij3/arJwjcSwyZNPhhW8f
         yOWqVwmGllhSuNJ523xhzKs0FuVl/0OVa9gdSevSG3LmB7CWCnlDQ+JG5VkrIIAB3cHd
         R52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425462; x=1692030262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA7ZGTP/1iIUz0NSZwan87qZk2dibq5PfQ7YdL9IqMM=;
        b=UyoL3U8iiKZ1RXuuKscRMs44MpjFHlltb9/nz3eQCQQcoOdij+iIC0JC8idJh3I0KK
         swoCu892V7hk24BSUol54EpSpr51otD/n8hesU8Ej+aYvTpRNSqhBqLAii8vWbfmPfSz
         jMNACA1qBq2W9SwV/gdqvbjbH6/ao/SHVqwltD4Em9Fs8W5HtSSDts37Hm+YAMkigT1m
         ocW8dGr2q+9K6IInNHavaFcyOeMo1b0iRcm/V02IyN7cGtj5MANsltp20wMAZX9D+fjI
         JE9ALBotsXYpPpTYwp8Qk6DPbhu7+z87b1nSfBFAwzOUANKGhCrxpu+u+Q/MqvmYPu92
         PEZA==
X-Gm-Message-State: AOJu0Yxwu5bD77gGnuaiJzrFiGFCsKuRbj+qT9ipg1of1hdF7IfgfVeq
        kVDxktgL+kkaWs189cQuAu5KDTZZksCMNyxiDSw=
X-Google-Smtp-Source: AGHT+IEYefXHM0TruKEa032jSyMqc1e77wIIewxYQEFOzkvak8lTQqoj7Y1uEiYfF5xMHwImLEdmeS+RTmJ7wEDkQFY=
X-Received: by 2002:a05:6870:6486:b0:1bb:8867:f7ed with SMTP id
 cz6-20020a056870648600b001bb8867f7edmr12411828oab.33.1691425462283; Mon, 07
 Aug 2023 09:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230801023658.4667-1-sunran001@208suo.com>
In-Reply-To: <20230801023658.4667-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:24:11 -0400
Message-ID: <CADnq5_MZ7HOUiw05H4oQokT4ad+=4ypjVBtSyYdqBNgfL5Q3CA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in amd_powerplay.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jul 31, 2023 at 10:37=E2=80=AFPM Ran Sun <sunran001@208suo.com> wro=
te:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
> ERROR: spaces required around that '||' (ctx:WxO)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/pm/powerplay/amd_powerplay.c
> index ff360c699171..9e4f8a4104a3 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -612,7 +612,7 @@ static int pp_dpm_get_pp_num_states(void *handle,
>
>         memset(data, 0, sizeof(*data));
>
> -       if (!hwmgr || !hwmgr->pm_en ||!hwmgr->ps)
> +       if (!hwmgr || !hwmgr->pm_en || !hwmgr->ps)
>                 return -EINVAL;
>
>         data->nums =3D hwmgr->num_ps;
> @@ -644,7 +644,7 @@ static int pp_dpm_get_pp_table(void *handle, char **t=
able)
>  {
>         struct pp_hwmgr *hwmgr =3D handle;
>
> -       if (!hwmgr || !hwmgr->pm_en ||!hwmgr->soft_pp_table)
> +       if (!hwmgr || !hwmgr->pm_en || !hwmgr->soft_pp_table)
>                 return -EINVAL;
>
>         *table =3D (char *)hwmgr->soft_pp_table;
> @@ -1002,7 +1002,7 @@ static int pp_get_power_limit(void *handle, uint32_=
t *limit,
>         struct pp_hwmgr *hwmgr =3D handle;
>         int ret =3D 0;
>
> -       if (!hwmgr || !hwmgr->pm_en ||!limit)
> +       if (!hwmgr || !hwmgr->pm_en || !limit)
>                 return -EINVAL;
>
>         if (power_type !=3D PP_PWR_TYPE_SUSTAINED)
> @@ -1047,7 +1047,7 @@ static int pp_get_display_power_level(void *handle,
>  {
>         struct pp_hwmgr *hwmgr =3D handle;
>
> -       if (!hwmgr || !hwmgr->pm_en ||!output)
> +       if (!hwmgr || !hwmgr->pm_en || !output)
>                 return -EINVAL;
>
>         return phm_get_dal_power_level(hwmgr, output);
> @@ -1120,7 +1120,7 @@ static int pp_get_clock_by_type_with_latency(void *=
handle,
>  {
>         struct pp_hwmgr *hwmgr =3D handle;
>
> -       if (!hwmgr || !hwmgr->pm_en ||!clocks)
> +       if (!hwmgr || !hwmgr->pm_en || !clocks)
>                 return -EINVAL;
>
>         return phm_get_clock_by_type_with_latency(hwmgr, type, clocks);
> @@ -1132,7 +1132,7 @@ static int pp_get_clock_by_type_with_voltage(void *=
handle,
>  {
>         struct pp_hwmgr *hwmgr =3D handle;
>
> -       if (!hwmgr || !hwmgr->pm_en ||!clocks)
> +       if (!hwmgr || !hwmgr->pm_en || !clocks)
>                 return -EINVAL;
>
>         return phm_get_clock_by_type_with_voltage(hwmgr, type, clocks);
> @@ -1155,7 +1155,7 @@ static int pp_display_clock_voltage_request(void *h=
andle,
>  {
>         struct pp_hwmgr *hwmgr =3D handle;
>
> -       if (!hwmgr || !hwmgr->pm_en ||!clock)
> +       if (!hwmgr || !hwmgr->pm_en || !clock)
>                 return -EINVAL;
>
>         return phm_display_clock_voltage_request(hwmgr, clock);
> @@ -1167,7 +1167,7 @@ static int pp_get_display_mode_validation_clocks(vo=
id *handle,
>         struct pp_hwmgr *hwmgr =3D handle;
>         int ret =3D 0;
>
> -       if (!hwmgr || !hwmgr->pm_en ||!clocks)
> +       if (!hwmgr || !hwmgr->pm_en || !clocks)
>                 return -EINVAL;
>
>         clocks->level =3D PP_DAL_POWERLEVEL_7;
> --
> 2.17.1
>
