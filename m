Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C3F79DDE5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbjIMBrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjIMBrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:47:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077BF10FE;
        Tue, 12 Sep 2023 18:47:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c93638322so93834766b.1;
        Tue, 12 Sep 2023 18:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694569625; x=1695174425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw2vbwh9Prl2aL4eCjxqEEuY3ibeNqCIYYpwmGgbBKk=;
        b=SjDVSpklyFl0ahhstDHlPV9V5HFEkoBRVgRi5VbJ8Pxe/LoLwEMrtwOODaTYyp+QzD
         KCCrTD2Lj4U/E1hh3mvyiGZDLsljrGLnbFbXDv345O57B6Y6GQn+DbwR1ufppJZJJF4D
         6JCwXFZ2CtgyXIYc5rYhMzmfGKfg0z5nhr4N71RVQzV/jcadQufxfTIZiWq3go2TNOV0
         usZtd1XDDsoni3EyBBMPjjgtWW0Qcxy9HWUr+XkneVEFrCIZQJayHYzI+d3iO0icwQeB
         txvPGQbJZoxAEztZRsAiULy/jwB34yvZt8pRvYvshCkm1/CPLQj9hGDl+NFOqa+Yvuu/
         AiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694569625; x=1695174425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nw2vbwh9Prl2aL4eCjxqEEuY3ibeNqCIYYpwmGgbBKk=;
        b=fkRCH09T+Ul1Cs18ltGdemIG5MvhBoPu/P9ToNT//Ct1jpeqV7z6Mu/07DWr5lNSgy
         o7tB85qmn6wD9iP4yMKtc4wdtkeylrZP8rHMN8qYMO6h0VDYbx+s2vh+Lez2oCCCOkqC
         hUuYqnR3dwNtAFEblN40Rq5ScRcVNZzuLx1S4T9xvkQ6dPwb7b/gznOkKoosBOcA1k2K
         aHUMmWruL/dwdoR3jn4kZAobmENn7fyVMtsrTL6EbAt1+lu7XIulFWnOF/iaUohxD3vw
         CG01orwcJq9hL52rbKo5+f2w0DnAk/Fv9WkRmXewYd4j22Ih+9LBwLBIRbse9B/zXttU
         OehA==
X-Gm-Message-State: AOJu0YyjWXy5RzMKbu1aDmAaICZofl0MdKhX3AVw0XEO3JlkV7q5msev
        OUda7PF+tp8fszkYkCcop+jBFhyqIt7Gc8A2vxU=
X-Google-Smtp-Source: AGHT+IH9cpCU/7Zs/hX2BjtG9840MbiSgk277qyUw73/CDt/MTKZHbRGAldZh5h9dMja6DQe2blemM8bcrEFXPMnBd0=
X-Received: by 2002:a17:906:cc0d:b0:9a2:86a:f9c0 with SMTP id
 ml13-20020a170906cc0d00b009a2086af9c0mr1955824ejb.1.1694569625097; Tue, 12
 Sep 2023 18:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230912084044.955864-1-adrian.larumbe@collabora.com>
 <20230912084044.955864-7-adrian.larumbe@collabora.com> <20230912113210.65897aab@collabora.com>
In-Reply-To: <20230912113210.65897aab@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 12 Sep 2023 18:46:52 -0700
Message-ID: <CAF6AEGtzOS89V1vbobpSEb9KX8x9T0FfmkW2OAaxAKLs+GugKA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] drm/drm-file: Show finer-grained BO sizes in drm_show_memory_stats
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 2:32=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 12 Sep 2023 09:37:00 +0100
> Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
>
> > The current implementation will try to pick the highest available size
> > display unit as soon as the BO size exceeds that of the previous
> > multiplier. That can lead to loss of precision in BO's whose size is
> > not a multiple of a MiB.
> >
> > Fix it by changing the unit selection criteria.
> >
> > For much bigger BO's, their size will naturally be aligned on something
> > bigger than a 4 KiB page, so in practice it is very unlikely their disp=
lay
> > unit would default to KiB.
>
> Let's wait for Rob's opinion on this.

This would mean that if you have SZ_1G + SZ_1K worth of buffers, you'd
report the result in KiB.. which seems like overkill to me, esp given
that the result is just a snapshot in time of a figure that
realistically is dynamic.

Maybe if you have SZ_1G+SZ_1K worth of buffers you should report the
result with more precision than GiB, but more than MiB seems a bit
overkill.

BR,
-R

> >
> > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/drm_file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> > index 762965e3d503..bf7d2fe46bfa 100644
> > --- a/drivers/gpu/drm/drm_file.c
> > +++ b/drivers/gpu/drm/drm_file.c
> > @@ -879,7 +879,7 @@ static void print_size(struct drm_printer *p, const=
 char *stat,
> >       unsigned u;
> >
> >       for (u =3D 0; u < ARRAY_SIZE(units) - 1; u++) {
> > -             if (sz < SZ_1K)
> > +             if (sz & (SZ_1K - 1))
> >                       break;
> >               sz =3D div_u64(sz, SZ_1K);
> >       }
>
