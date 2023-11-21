Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3736C7F29DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjKUKLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjKUKLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:11:48 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0816FC1;
        Tue, 21 Nov 2023 02:11:45 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso1660090b3a.2;
        Tue, 21 Nov 2023 02:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700561504; x=1701166304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h77UCHBzfS9YsxxGuMxQKATmfaJKyNycbGsrjaUmphU=;
        b=U1vMUiC7Kj96pVlXogZWS8uk5x5NwUT3uzMVQoIZJSkW0JbbrRSD1ScaoQpW3vDZFl
         dcSUePPgJkYAQZTcFBkbTs1v1uuub2zheqZTflwUqTzyYPI9EgDKaZ+XkkG/N25KftXk
         goChYmzJdeQqyZhb+Iqcp1TbKF99L5zH3yMrBrTJwWTc5+/2RhE3ZPYmNe5JLXG/hxnH
         /4Uq2QNT3YiRO7QAUm5b5oW4f0WIM7cMTJI4cM15lbtzTbIKzI7ZQNPwJPqP9t1b2y0M
         cdJ62GL5ijKR6Cr+cscL/JwF78/DRNEYmipDOQ8S4R5ALYeEwrl1qLRkjv+AictMLmJ0
         +BuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700561504; x=1701166304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h77UCHBzfS9YsxxGuMxQKATmfaJKyNycbGsrjaUmphU=;
        b=Ak6H/jwWPzSm8xy6WuE0SI6RvLJ5POoklKNDwIDgTTFl73IedzNH1X8gH1XA/H5uWZ
         nvH+CC7JJ3qHhg+vJVWweZa442vN6oQqJxQeNx/UyKqmuEUjiN0qJJJ7dYfYOBn+pld/
         bQ0pN8bDHgnccNw7K9X7HjzALaphnQrZJ9RC3gEDP5jK7UpIWaHngCCabzjG+kziuVWA
         UdqtqcX1ZRZxLSUzsiCqsPlmXD3+gQoD7lsG/kxdP0LLL4uUVqad8ioJgnXRGVy1miku
         MyPZEzQivVZ4LT0LO7bOpW/f8phr7jQ1pWuaXMclFPi+e/w/Hm+MtZ1b3jWr/cJNfWoQ
         ihLg==
X-Gm-Message-State: AOJu0YxPlTzBPuGS/GdMGIqgetyoBpNdGl8CxD4hYYNQU7vrNBCoVojl
        WNemgq3mIXkjQmlz4ybjOZRsZWkgeHoper3dI0s=
X-Google-Smtp-Source: AGHT+IEp8j+Xt8I0EWdsh1ssJvEqhJY59UJ9RwYFSlAvOSHCZgQnKLiiltgHL/5rsbh4MhNNEDWqB0d6Hu9FlWOpSMc=
X-Received: by 2002:a05:6a21:789d:b0:187:15e2:fdd9 with SMTP id
 bf29-20020a056a21789d00b0018715e2fdd9mr8857392pzc.39.1700561504425; Tue, 21
 Nov 2023 02:11:44 -0800 (PST)
MIME-Version: 1.0
References: <1700552255-5364-1-git-send-email-shengjiu.wang@nxp.com>
 <1700552255-5364-14-git-send-email-shengjiu.wang@nxp.com> <0026a04d-8a04-4eeb-9f03-c68be6da5ec5@xs4all.nl>
In-Reply-To: <0026a04d-8a04-4eeb-9f03-c68be6da5ec5@xs4all.nl>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 21 Nov 2023 18:11:33 +0800
Message-ID: <CAA+D8APe+-_Z-vE2rffnF7S6Bss_3bigzb-Z2zHKof-7RARBKg@mail.gmail.com>
Subject: Re: [PATCH v10 13/14] media: imx-asrc: Add memory to memory driver
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 5:20=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> w=
rote:
>
> On 21/11/2023 08:37, Shengjiu Wang wrote:
> > Implement the ASRC memory to memory function using
> > the v4l2 framework, user can use this function with
> > v4l2 ioctl interface.
> >
> > User send the output and capture buffer to driver and
> > driver store the converted data to the capture buffer.
> >
> > This feature can be shared by ASRC and EASRC drivers
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  drivers/media/platform/nxp/Kconfig    |   13 +
> >  drivers/media/platform/nxp/Makefile   |    1 +
> >  drivers/media/platform/nxp/imx-asrc.c | 1264 +++++++++++++++++++++++++
> >  3 files changed, 1278 insertions(+)
> >  create mode 100644 drivers/media/platform/nxp/imx-asrc.c
> >
>
> <snip>
>
> > +static const struct v4l2_ctrl_config asrc_src_rate_off_control =3D {
> > +     .ops =3D &asrc_m2m_ctrl_ops,
> > +     .id =3D V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET,
> > +     .name =3D "Audio Source Sample Rate Offset",
> > +     .type =3D V4L2_CTRL_TYPE_INTEGER64,
>
> Do you need this to be INTEGER64? If the actual number of bits
> of the fixed point value that the hardware uses fits in 32 bits,
> then you can just use the INTEGER type.
>
> > +     .min =3D 0xFFFFFF0000000000,
> > +     .max =3D 0x7fffffffff,
> > +     .def =3D 0,
> > +     .step =3D 1,
> > +     .flags =3D V4L2_CTRL_FLAG_UPDATE,
> > +     .fraction_bits =3D 32,
>
> Can't you use the actual number of fraction bits that the hardware
> uses? I can't imagine that it is actually 32 bits, it is almost
> certainly less.
>
From the ratio point view, it is 44bits.  maximum 39 fractional bits.

> I do think that we need a helper function to fill in the min/max values.

what's the helper function look like?  Where can I find an example?

best regards
wang shengjiu


>
> Regards,
>
>         Hans
>
> > +};
> > +
> > +static const struct v4l2_ctrl_config asrc_dst_rate_off_control =3D {
> > +     .ops =3D &asrc_m2m_ctrl_ops,
> > +     .id =3D V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET,
> > +     .name =3D "Audio Dest Sample Rate Offset",
> > +     .type =3D V4L2_CTRL_TYPE_INTEGER64,
> > +     .min =3D 0xFFFFFF0000000000,
> > +     .max =3D 0x7fffffffff,
> > +     .def =3D 0,
> > +     .step =3D 1,
> > +     .flags =3D V4L2_CTRL_FLAG_UPDATE,
> > +     .fraction_bits =3D 32,
> > +};
>
