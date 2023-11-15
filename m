Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001EF7EC7F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjKOPxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjKOPx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:53:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72AA19A0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:53:04 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32f7bd27c2aso4824548f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700063583; x=1700668383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0o7wVY4Z+/CfE773KwLKFQ/G0W7E5XEigW016DUdkI=;
        b=1NjpMpvW3qX0TXcpJf6R/i+sVFedWbleYpHlHVO6wUJz4yzlZzFUNMXgFa2Wzb3CAI
         YTFgjadTG4vrrH3uFvWG0D6UCVvsEuVJSpemjVQLrY6/0IyNxvr3pFiteNev1ASvwtP8
         srqn3nx3AFinC2CILBgt4N6NwWrSaz3lYfFmDJu5fmyqZzDHaVIiTAxPkbSN8YtyMXd2
         snkK3vC9MtUcFFBkjJNw5LGplJEwIzjQaEQ8nQ/szn2exWO8uzQ9IrYuKnJKxQjYzXqw
         Uiulu0tJGMUeT+cSI6NXv9x1lKek5kbvJ2Sxd+1pgLVA7Bo/2Y8ghigbiLDjnuNAYXPk
         3q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063583; x=1700668383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0o7wVY4Z+/CfE773KwLKFQ/G0W7E5XEigW016DUdkI=;
        b=ZslvhxiOkEozhskKFDdRl5Lt2dGV214cJqQPTiEpz/m9CtGBJjrgvrqsHTRkH3R+lD
         Ky/GtIobwK1eAiJjhPLGsfkftdoRgGX+M701qcGUEFlXpf64p8p8iuW0DlhhW8vWqrCO
         g0RWURsIw7bC8gzgFCr6HEnFc0I25/kUR12no9xjyxIzBXj5q+gZ2N+tlS8ISlSlhC/s
         DLtBVwcbEflsOw/zxNO3y/CXS4wlwuLFmWmfwbwA+TyDAVncy57QPs47pZW3N9GRv08d
         WgmWGy9FIPCYzGdw3yP88haFd6ESUUVdBdhdwbEMcNv1m0BNaD34ZA+/TCeaRKRDy+PB
         eZDg==
X-Gm-Message-State: AOJu0YyFEhuTQJGqezTMSs7378UCHKi4t+TBm8tLXgz3j+4qrho5cSpj
        XRo2thE7ci1p1f4DhuubU/kthfG0gbD1QePxPQBr4Q==
X-Google-Smtp-Source: AGHT+IHV/SEME9EZGXCQLBSXL9uZD1NVc9cYfJL72n/LJIM0QFuI5owBhoOpxizaqcoECaAHSL/f3Vcb+kWc+csyNH4=
X-Received: by 2002:a5d:460a:0:b0:32f:8a7f:f00f with SMTP id
 t10-20020a5d460a000000b0032f8a7ff00fmr8654191wrq.60.1700063583161; Wed, 15
 Nov 2023 07:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20231114233859.274189-1-appsforartists@google.com>
 <70f12e96-0fcc-4954-8507-27cf5e15a3b2@redhat.com> <CAAL3-=9YYQBV-T-KhHdYrtGHH1RC29uzTuQ98roAY9GwrNrwmg@mail.gmail.com>
 <CAAL3-=-b3-RZNNfQEYzQxK=SW4PPJ7cmrX8omBniec+tgC2frw@mail.gmail.com> <4570d94e-b446-4fd1-a24a-db11a87846c4@redhat.com>
In-Reply-To: <4570d94e-b446-4fd1-a24a-db11a87846c4@redhat.com>
From:   Brenton Simpson <appsforartists@google.com>
Date:   Wed, 15 Nov 2023 07:52:52 -0800
Message-ID: <CAAL3-=_p4waxpf9a6B0Yvno0dnakZ6f81-Kfjxwbw4jA_CrcSw@mail.gmail.com>
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

Yes, thanks!

That's the email attached to my public git work, so it should be the
one here as well.

Sorry for the hassle.  Very new to sending PRs over email, and still
working through the kinks.

On Wed, Nov 15, 2023 at 7:51=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 11/15/23 16:48, Brenton Simpson wrote:
> > Resending from the email address linked to my GitHub account.
>
> Ok, this doesn't really help. I'll just fix-up the author
> field of the original patch.
>
> Do understand correctly that both the author and the Signed-off-by
> should be set to:
>
> Brenton Simpson <appsforartists@google.com>
>
> ?
>
> Regards,
>
> Hans
>
>
>
> >
> > -- >8 --
> >
> > The Legion Go has a 2560x1600 portrait screen, with the native "up" fac=
ing =3D
> > the right controller (90=3DC2=3DB0 CW from the rest of the device).
> >
> > Signed-off-by: Brenton Simpson <appsforartists@google.com>
> > ---
> >  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/g=
pu/d=3D
> > rm/drm_panel_orientation_quirks.c
> > index d5c1529..3d92f66 100644
> > --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > @@ -336,6 +336,12 @@ static const struct dmi_system_id orientation_data=
[] =3D
> > =3D3D {
> >  =3D09=3D09  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL=
5"),
> >  =3D09=3D09},
> >  =3D09=3D09.driver_data =3D3D (void *)&lcd1200x1920_rightside_up,
> > +=3D09}, {=3D09/* Lenovo Legion Go 8APU1 */
> > +=3D09=3D09.matches =3D3D {
> > +=3D09=3D09  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > +=3D09=3D09  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
> > +=3D09=3D09},
> > +=3D09=3D09.driver_data =3D3D (void *)&lcd1600x2560_leftside_up,
> >  =3D09}, {=3D09/* Lenovo Yoga Book X90F / X90L */
> >  =3D09=3D09.matches =3D3D {
> >  =3D09=3D09  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
> > --=3D20
> > 2.43.0.rc0.421.g78406f8d94-goog
> >
>
