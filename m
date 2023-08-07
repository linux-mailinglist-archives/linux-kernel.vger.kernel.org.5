Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65270772C1A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjHGRJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjHGRJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:09:03 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811C2E70
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:09:02 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a3e1152c23so3528774b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428142; x=1692032942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYtI8iCPC1kn3LKTZ1hvcBGhCgY8szmyxcIcuYezdzg=;
        b=LH43e8ewo6Q0OlUAnGbyvmHFDDCRyTjgIxIXzeCMJnjk8oOaCAlGN6m1ATWzL4gqqZ
         vEkF1AJJ2g9NLduquQm/WoTa/40/jk15YNlpBwKxcxK+MJPhIGhdZ74fFZf3+0EsxpIS
         OulJ6CQWeNuDr70UzQGezZcZAfF+eu/9hlVf8Db6UXlMDHUw62CKbGjbUJSxc/5kkob9
         yqBwm/ogK7UthRQ+0ArEuhFPQRfgb6xRyPsGknCS9G5DMu7h3DwcSbkl+k8D6a3u1tPQ
         AuLgdyzM70G6lsOskSv9sZbdO7umHZ1zG+RNa8/88uGGYqYyIoJ8XwfD6C5Ynp15wxZv
         hlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428142; x=1692032942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYtI8iCPC1kn3LKTZ1hvcBGhCgY8szmyxcIcuYezdzg=;
        b=WvUINQK8GT55zuA4+GEvnPmdVQRg87agOA8xjajm1zjKoZZhS4DfdHFTlkEhQY4QEx
         k/BveiqKk9RLSpHXCHhzH5kmPzyUxEtTZJEkc8tl/G2SMPzOfCmI6aI/SiMr58hb+vuO
         9TdynyXVQUnXkltPX4NkT8wmp0cyQYH1Rhr8zsqFbPrDW3u29XPrF9ZLila3sWuIKSnl
         wMYHTwxo8NGZxRPBqgUHuBtY7hBfAbChTaQYBSz+u6ifJdYhIAi2WPOQjVxmDDOiHhPf
         dDAUVEc7h04AZ8qQq4JqnwvgbSqSsTrtkb+3TjNmfcf60zxVZdb+tjoPM/4zBqdWnIra
         4PQw==
X-Gm-Message-State: AOJu0YxgsQsnhROBR4B+Api4sV6h760bUe5fly4VY14sMIKx+QkqWdSY
        QiBrTWTM8PU/c4tTdIpFJY1I8gnWwamL6yK1wi8=
X-Google-Smtp-Source: AGHT+IHIbguMOYbr/p6kStc4b8MneXaZ13fmPnWPKhux18thHDfWxJRPQ+Cz301UTH2V5ZPJoendg9F3yA6BpJeWJTQ=
X-Received: by 2002:a05:6870:d248:b0:1be:f973:efcd with SMTP id
 h8-20020a056870d24800b001bef973efcdmr11273905oac.43.1691428141796; Mon, 07
 Aug 2023 10:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230802025202.10282-1-sunran001@208suo.com>
In-Reply-To: <20230802025202.10282-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:08:50 -0400
Message-ID: <CADnq5_P-E63fZnjm-cgyz4HScOvvvtpm_MTdXfLBrVZe3MCe+w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in dce110_timing_generator.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 1, 2023 at 10:52=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: spaces required around that '=3D' (ctx:WxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c   | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generato=
r.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
> index 27cbb5b42c7e..6424e7f279dc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
> @@ -288,7 +288,7 @@ bool dce110_timing_generator_program_timing_generator=
(
>
>         uint32_t vsync_offset =3D dc_crtc_timing->v_border_bottom +
>                         dc_crtc_timing->v_front_porch;
> -       uint32_t v_sync_start =3Ddc_crtc_timing->v_addressable + vsync_of=
fset;
> +       uint32_t v_sync_start =3D dc_crtc_timing->v_addressable + vsync_o=
ffset;
>
>         uint32_t hsync_offset =3D dc_crtc_timing->h_border_right +
>                         dc_crtc_timing->h_front_porch;
> @@ -603,7 +603,7 @@ void dce110_timing_generator_program_blanking(
>  {
>         uint32_t vsync_offset =3D timing->v_border_bottom +
>                         timing->v_front_porch;
> -       uint32_t v_sync_start =3Dtiming->v_addressable + vsync_offset;
> +       uint32_t v_sync_start =3D timing->v_addressable + vsync_offset;
>
>         uint32_t hsync_offset =3D timing->h_border_right +
>                         timing->h_front_porch;
> --
> 2.17.1
>
