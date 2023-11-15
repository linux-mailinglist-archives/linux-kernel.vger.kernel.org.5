Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C897EC7BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjKOPuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjKOPuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:50:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A42D43
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:50:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32fadd4ad09so4833279f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700063408; x=1700668208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzEnr8i1sT5AWLTvZnLADAf4vpUV1tEYyqWWPHLAQFo=;
        b=HJvKUUbpr0fG7Bg9awMfA7T8BEfdnsVRxg23yKp4oay74VWPG4kyIoA7D0dgwzHmQW
         fRLHU51MPfsoU+sSOdXXsU3j/mU1CMjaLSHP//vc5AFK7knOivu1UCrbD7YZ9yykhrz/
         v5xZATrfevpRdL1SQw94U1WPWhLYqqd1gFQL+si5oAetF3G95eRfHpI2Ji3/EK44uJfs
         8lJPMmHgszJXG9dPlxBQh1ZlQLpJ17mk54Qx07FlgTUQ/2k+HwSoyao2j/719dvB1JYj
         P1v+68aRTojIQtK4mMmnqG/v96vy6zXz9DrYNUlbCfTVLB1MxoR2ZKjdAz8umdFXhIRI
         hKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063408; x=1700668208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzEnr8i1sT5AWLTvZnLADAf4vpUV1tEYyqWWPHLAQFo=;
        b=vO1+qhJ/SFcqFC/FkZDoMsmoR+rOioEmhpoT9+zvgjPslPby+Etkx9FtwcTFJ03HRx
         tQ+d8szzJFaDaDjmGCehq6n5DgYIZ1Semb2e5l2ZccdOwwxQVeX8NAGgDOurr2dzmMHQ
         9lzkNMnUVW3AfXQNEpf9X4RC35+JB7NT0hQRAtTgUI44xeY6BVF6EsgG0HtaLpFSgJcO
         rOS/W9p4HZISVsAh5VTNAwQ8pBka8lxIU7IntHkHP91r/tdfGbUf4PyjLRPaoKaNY/8a
         fZZVu+Q+VJBVVZTmDtQS/mUtKnkdZUJZy2PsiEC9vcKfPrXsZIjm7aqnBUvxa+NjuES6
         D+Sg==
X-Gm-Message-State: AOJu0Yw23+jjIXjC8GJzBwxmNGaGTNweMt7qrF0yC867tMVm7tapx9qp
        Tg838CNmHmWCc2kHjpRYs43v0ecGdsXsshqgrhMQiA==
X-Google-Smtp-Source: AGHT+IFla7G1hT2tVBN1ZaWqd4Z9G6daPNypvTqubx3Og4idSx6Ik0nGx86WBC8LDRrRn2fpnCnRCijl0gBE6lz+FsY=
X-Received: by 2002:a5d:64c6:0:b0:32f:8920:48ab with SMTP id
 f6-20020a5d64c6000000b0032f892048abmr9261113wri.65.1700063407522; Wed, 15 Nov
 2023 07:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20231114233859.274189-1-appsforartists@google.com>
 <70f12e96-0fcc-4954-8507-27cf5e15a3b2@redhat.com> <CAAL3-=9YYQBV-T-KhHdYrtGHH1RC29uzTuQ98roAY9GwrNrwmg@mail.gmail.com>
 <CAAL3-=-b3-RZNNfQEYzQxK=SW4PPJ7cmrX8omBniec+tgC2frw@mail.gmail.com>
In-Reply-To: <CAAL3-=-b3-RZNNfQEYzQxK=SW4PPJ7cmrX8omBniec+tgC2frw@mail.gmail.com>
From:   Brenton Simpson <appsforartists@google.com>
Date:   Wed, 15 Nov 2023 07:49:56 -0800
Message-ID: <CAAL3-=8_DL7ip753ue+Y9-xS+ma-yMmVX6U0Ojzxht0S+FdNcg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-orientation-quirks: add Lenovo Legion Go
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Allen Ballway <ballway@chromium.org>,
        Patrick Thompson <ptf@google.com>,
        Jared Baldridge <jrb@expunge.us>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arg - the special characters got mangled.  One last time.

-- >8 --

The Legion Go has a 2560x1600 portrait screen, with the native "up"
facing the right controller (90=C2=B0 CW from the rest of the device).

Signed-off-by: Brenton Simpson <appsforartists@google.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c
b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index d5c1529..3d92f66 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -336,6 +336,12 @@ static const struct dmi_system_id orientation_data[] =
=3D {
                  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IG=
L5"),
                },
                .driver_data =3D (void *)&lcd1200x1920_rightside_up,
+       }, {    /* Lenovo Legion Go 8APU1 */
+               .matches =3D {
+                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+                 DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
+               },
+               .driver_data =3D (void *)&lcd1600x2560_leftside_up,
        }, {    /* Lenovo Yoga Book X90F / X90L */
                .matches =3D {
                  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
--
2.43.0.rc0.421.g78406f8d94-goog

On Wed, Nov 15, 2023 at 7:48=E2=80=AFAM Brenton Simpson
<appsforartists@google.com> wrote:
>
> Resending from the email address linked to my GitHub account.
>
> -- >8 --
>
> The Legion Go has a 2560x1600 portrait screen, with the native "up" facin=
g =3D
> the right controller (90=3DC2=3DB0 CW from the rest of the device).
>
> Signed-off-by: Brenton Simpson <appsforartists@google.com>
> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu=
/d=3D
> rm/drm_panel_orientation_quirks.c
> index d5c1529..3d92f66 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -336,6 +336,12 @@ static const struct dmi_system_id orientation_data[]=
 =3D
> =3D3D {
>  =3D09=3D09  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"=
),
>  =3D09=3D09},
>  =3D09=3D09.driver_data =3D3D (void *)&lcd1200x1920_rightside_up,
> +=3D09}, {=3D09/* Lenovo Legion Go 8APU1 */
> +=3D09=3D09.matches =3D3D {
> +=3D09=3D09  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +=3D09=3D09  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
> +=3D09=3D09},
> +=3D09=3D09.driver_data =3D3D (void *)&lcd1600x2560_leftside_up,
>  =3D09}, {=3D09/* Lenovo Yoga Book X90F / X90L */
>  =3D09=3D09.matches =3D3D {
>  =3D09=3D09  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
> --=3D20
> 2.43.0.rc0.421.g78406f8d94-goog
