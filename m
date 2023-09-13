Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2779DE25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjIMCO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjIMCOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:14:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE598170A;
        Tue, 12 Sep 2023 19:14:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c93638322so97058366b.1;
        Tue, 12 Sep 2023 19:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694571288; x=1695176088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7tdcZxWcWP9Umyb5qLqi3mZy8phtG7cbzdtVA/Y3II=;
        b=UP3EsIGhZ9ZIpe6Gq6afCOcMfI4urcqFNc7a+jO3f1CWT4viA9pMNc4bhH/wmHs7RY
         Tayf/ClY1ddRKFkRTGmXtHmSdGdayLC20XMfZ+Zty8ujDPMXxiO8XBnZy9BTt7gW5BOh
         2YW7jMhqoHDqDupyt0wbs+BpmTO1WlfV656cWEhzgW1u58CRxoOBJImH1tOcZEPAnN92
         Zj9a+J8l6+15fkO/rIxURnf8GO2E12cddRWLIRT9FEOwIEp/eLGSJdqYTtujoPdD7ywv
         hCL+Qdu7v44A7JQ5aU4Etb+4kZStLsMLMIs8sNANRnQe99YYH/Dgpzy3P+b1f5w4TKUX
         /4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694571288; x=1695176088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7tdcZxWcWP9Umyb5qLqi3mZy8phtG7cbzdtVA/Y3II=;
        b=lf6QdD/WF9OjgX9s+G0xtwTzXW4vZrdXThe0p+MvD2hBOtzZejpIGsl8FcQmT5p6Z3
         e2iDRi0FxCZ/O4leOXiu4jDwE9CSpYiPbHrCw+vMKQhWDbLwNAiZmnFyT5RAVi0UEyrn
         chOMUdYsDfOo/jc+gd5dDKtaVJGmnG6hTb1+KkebhWrWlFt5NAyX5xEWinM/1UYrAzFd
         5rmbbQMwcA93PyXcHO9QUWj6WBkS5f+7DUoU4EXVXn4QhyhEY5E728NmkOuwISng9oB6
         ZrT/i8c+KYlYgerV1kxDEAonVOTi5vc98S3hipiIGfIW+bpa1V6gRCAR+GdASl8RoSJG
         R1nA==
X-Gm-Message-State: AOJu0YxZ2gwgr2MygeMU36tw6+yhHahmGK8xyhZRZbhSxUiVy1yp69wt
        pmA0qgCd48bqgH1zGPYOkm2NRWt88gLO7uQ7jIQ=
X-Google-Smtp-Source: AGHT+IFWoaxMpozSizksjlTIWZ2gq5IqQtjZx2Fma+6ckL4UgPSLfUZk28X5KYN6Ft4GFGF1z5hEo0GwRNCn2M3plks=
X-Received: by 2002:a17:907:762d:b0:9a5:9305:83fb with SMTP id
 jy13-20020a170907762d00b009a5930583fbmr1793419ejc.34.1694571287818; Tue, 12
 Sep 2023 19:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230912084044.955864-1-adrian.larumbe@collabora.com>
 <20230912084044.955864-7-adrian.larumbe@collabora.com> <20230912113210.65897aab@collabora.com>
 <CAF6AEGtzOS89V1vbobpSEb9KX8x9T0FfmkW2OAaxAKLs+GugKA@mail.gmail.com>
In-Reply-To: <CAF6AEGtzOS89V1vbobpSEb9KX8x9T0FfmkW2OAaxAKLs+GugKA@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 12 Sep 2023 19:14:35 -0700
Message-ID: <CAF6AEGup93tQMYrmx6iKex2Fxz+Yu5m-MMWPmeOQ4yx_Racnag@mail.gmail.com>
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
        freedreno@lists.freedesktop.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 6:46=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> On Tue, Sep 12, 2023 at 2:32=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Tue, 12 Sep 2023 09:37:00 +0100
> > Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
> >
> > > The current implementation will try to pick the highest available siz=
e
> > > display unit as soon as the BO size exceeds that of the previous
> > > multiplier. That can lead to loss of precision in BO's whose size is
> > > not a multiple of a MiB.
> > >
> > > Fix it by changing the unit selection criteria.
> > >
> > > For much bigger BO's, their size will naturally be aligned on somethi=
ng
> > > bigger than a 4 KiB page, so in practice it is very unlikely their di=
splay
> > > unit would default to KiB.
> >
> > Let's wait for Rob's opinion on this.
>
> This would mean that if you have SZ_1G + SZ_1K worth of buffers, you'd
> report the result in KiB.. which seems like overkill to me, esp given
> that the result is just a snapshot in time of a figure that
> realistically is dynamic.
>
> Maybe if you have SZ_1G+SZ_1K worth of buffers you should report the
> result with more precision than GiB, but more than MiB seems a bit
> overkill.
>
> BR,
> -R
>
> > >
> > > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > > ---
> > >  drivers/gpu/drm/drm_file.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> > > index 762965e3d503..bf7d2fe46bfa 100644
> > > --- a/drivers/gpu/drm/drm_file.c
> > > +++ b/drivers/gpu/drm/drm_file.c
> > > @@ -879,7 +879,7 @@ static void print_size(struct drm_printer *p, con=
st char *stat,
> > >       unsigned u;
> > >
> > >       for (u =3D 0; u < ARRAY_SIZE(units) - 1; u++) {
> > > -             if (sz < SZ_1K)

btw, I was thinking more along the lines of:

   if (sz < 10*SZ_1K)

(or perhaps maybe 100*SZ_1K)

I mean, any visualization tool is going to scale the y axis based on
the order of magnitude.. and if I'm looking at the fdinfo with my
eyeballs I don't want to count the # of digits manually to do the
conversion in my head.  The difference btwn 4 or 5 or maybe 6 digits
is easy enough to eyeball, but more than that is too much for my
eyesight, and I'm not seeing how it is useful ;-)

But if someone really has a valid use case for having precision in 1KB
then I'm willing to be overruled.  But I'm not a fan of the earlier
approach of different drivers reporting results differently, the whole
point of fdinfo was to have some standardized reporting.

BR,
-R

> > > +             if (sz & (SZ_1K - 1))
> > >                       break;
> > >               sz =3D div_u64(sz, SZ_1K);
> > >       }
> >
