Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F095F76013A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjGXVep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGXVeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:34:44 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AC0D8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:34:42 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-563531a3ad2so2969625eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234482; x=1690839282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQkyjTBZJxu5zihmRYWARPnkRRY4L/Ob/JNKh65ICMo=;
        b=KlSqV22VreeIA6EwsZczaYagWE3+2tI2g9j3O2LBRreCtimrY+1W8JfemEqwndlmBe
         6Vgxi2JlUvNyuDDA/Jpr/LtEg6Sny/j1+whRPloxBEMKTZD2jNeRWBXbTdLo8JEaf+it
         upfujjajck9FaqAGMBK9SMa6JdEIPp0K+yQI8F+qM3voZdxjSoBCB0QQtaJ1ve3bZHHj
         Iw8zogLruFdju5dswuvEFeJu4TyvOoxxgdwhaNWWatsxD6yqOVlfm91m/ShLMSRj8swF
         viMAUZFl+fMrimEnchx7GJ3E8aLN/1PHoEw4i3zLL0GtuMP978to90a5Q4lDssEmjhKt
         bvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234482; x=1690839282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQkyjTBZJxu5zihmRYWARPnkRRY4L/Ob/JNKh65ICMo=;
        b=DW/F3WGx06SgzBEL1wybaiEPdu/JJZTFQL3PGvDr3k/+8jgu08V/ege0iFjl2QAEpA
         3OSoZLuGXAZWUyZkaMtJoUv9JAiyGucOVvYKP281An0IEtNAZRuZRGDRM4rHcfXyjsCy
         A+0QyVQhwJrQmbcgZ7jBi+yCZHpJrZ37NAqqUj/iuGZRhwVGXl1cdQN/AVmAPoWv2nUd
         MnQlkTf41Tpc2FujNfU+VmE0T1hLToXVBw3LR9Y5rDbsRinZYmriTY5yIkR2xLJ+Ghag
         ra/2FUCBj6fxH58iFtPU/VjnFLREuJdj3ga9sIOa/moMsuYdYpjoB/ft2Feq5EmeObA2
         tJpg==
X-Gm-Message-State: ABy/qLb38nrugpwTE2v3edYKZAKeJpKfVUtHg8x31I9yyX/Rsi8GvyuJ
        Nx1nJRHqYBYrRgxm2Bu6x98/TkJ1wvEe8+QiIEtyfd5O
X-Google-Smtp-Source: APBJJlELA15kpf/2nXafUx7Wqq9khE0QcLJc72In7q9KWoXK4MvpztOWeMWheJD756QbdaHJfrKJ5cH9pU8RiskN8L0=
X-Received: by 2002:a4a:9cdc:0:b0:566:f869:6d90 with SMTP id
 d28-20020a4a9cdc000000b00566f8696d90mr8758676ook.6.1690234482025; Mon, 24 Jul
 2023 14:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230724025911.7528-1-xujianghui@cdjrlc.com> <6c16a6c089033849af90ad35fe86515a@208suo.com>
In-Reply-To: <6c16a6c089033849af90ad35fe86515a@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:34:30 -0400
Message-ID: <CADnq5_Mofm5ESN6mveMnqeejx3T=CvJ8XH5i10LrLiR29AvPZA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: add missing spaces before ';'
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch, alexander.deucher@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Sun, Jul 23, 2023 at 11:00=E2=80=AFPM <sunran001@208suo.com> wrote:
>
> ERROR: space required after that ';' (ctx:BxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/radeon_vce.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_vce.c
> b/drivers/gpu/drm/radeon/radeon_vce.c
> index ca4a36464340..d1871af967d4 100644
> --- a/drivers/gpu/drm/radeon/radeon_vce.c
> +++ b/drivers/gpu/drm/radeon/radeon_vce.c
> @@ -95,7 +95,7 @@ int radeon_vce_init(struct radeon_device *rdev)
>
>         size =3D rdev->vce_fw->size - strlen(fw_version) - 9;
>         c =3D rdev->vce_fw->data;
> -       for (;size > 0; --size, ++c)
> +       for (; size > 0; --size, ++c)
>                 if (strncmp(c, fw_version, strlen(fw_version)) =3D=3D 0)
>                         break;
>
> @@ -110,7 +110,7 @@ int radeon_vce_init(struct radeon_device *rdev)
>
>         size =3D rdev->vce_fw->size - strlen(fb_version) - 3;
>         c =3D rdev->vce_fw->data;
> -       for (;size > 0; --size, ++c)
> +       for (; size > 0; --size, ++c)
>                 if (strncmp(c, fb_version, strlen(fb_version)) =3D=3D 0)
>                         break;
