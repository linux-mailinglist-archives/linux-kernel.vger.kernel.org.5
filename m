Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5E79EF47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjIMQs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjIMQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:48:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CC62685;
        Wed, 13 Sep 2023 09:46:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so9105933a12.0;
        Wed, 13 Sep 2023 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694623618; x=1695228418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5YGng7LquR7VbitExATGwfX7+5OwRblTGs4u5vbxVs=;
        b=VkrIIwMjgQhalGnIU1EqFHIYTDAZ5GHYGfirC+jTni3tIrk2FWleEwN16KUa2mxgsn
         KX6TFCsHnArMdQdAbMYi+CRtYyXOXph4EMtd5MsQz5BeEdFL6GtD15LLuhFVqhZgzSQ0
         wsVT+Q8FpI27K9IuAsGeuWWbfkRwtHLLnCTBWCT9jBriS5Cei/C8yIr1flgo+jEOQLSi
         KifxlgFAM21HdkPW18jOLB+ww49892UX9raJeuJKz+ucHMlhSonekWtJiW3f2b/MEwYm
         DVIUeGOZAbTvM11uTyE+XqmXq5AtzEwmSsGagVr+w9Ui+8oa/NnBnnrv6NfGfs0sYrIr
         blqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694623618; x=1695228418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5YGng7LquR7VbitExATGwfX7+5OwRblTGs4u5vbxVs=;
        b=He06g6K0EfDawG3fEM4dT18TFD9QDFkbCgoic1RNCjBJcAXAjLvbvN8SKqrfngtrpz
         01+uq/K2DcBJwPpvgaqCpPty2K1pYXCGcMJTIpN8muceKyMGzrQ1yU0TvfnU2tWGuczq
         xD+1OrE3PitXglSY25GkgocfoGog3mELOBPvo+hEraK3HLWgEwE6raO1KqzUIDrqeNkL
         IedQKjcmnN14rvHrYTmQHje1R3b+O+7rZsFGtOafKQWYDAZtXyOJmj1VyY5NYPmV8qtQ
         ss/H1WpD6GwjDep6FmYYGZzEjMsOhMV1FNC86q9YeF15OZ4385eF4x2abc+NcnWWIfpf
         VS+g==
X-Gm-Message-State: AOJu0YyzpIx7AOIo08OmLtRHuFT2/mxzB+tIfgRDdOUWtVckd5W6tNyy
        wDyu14FCe81OqK5ajpxgxFc6xzWt5O0+SEP6hyc=
X-Google-Smtp-Source: AGHT+IEc2KBgN3FRWC0KNxdRSFvRYj33UjiqQW/x5aJZfHR0AmWtDWPkiHn6xF3C8Knu1WGuANLSFzngKfOIKzJec/o=
X-Received: by 2002:aa7:c0cb:0:b0:523:47b0:9077 with SMTP id
 j11-20020aa7c0cb000000b0052347b09077mr2728747edp.38.1694623617692; Wed, 13
 Sep 2023 09:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230912084044.955864-1-adrian.larumbe@collabora.com>
 <20230912084044.955864-7-adrian.larumbe@collabora.com> <20230912113210.65897aab@collabora.com>
 <CAF6AEGtzOS89V1vbobpSEb9KX8x9T0FfmkW2OAaxAKLs+GugKA@mail.gmail.com>
 <CAF6AEGup93tQMYrmx6iKex2Fxz+Yu5m-MMWPmeOQ4yx_Racnag@mail.gmail.com> <20230913093637.2748d217@collabora.com>
In-Reply-To: <20230913093637.2748d217@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 13 Sep 2023 09:46:45 -0700
Message-ID: <CAF6AEGu+NeMfeP3yVLr76fUmXeWPx86D9ckw_WjXu+Xpn6DJvA@mail.gmail.com>
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

On Wed, Sep 13, 2023 at 12:36=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 12 Sep 2023 19:14:35 -0700
> Rob Clark <robdclark@gmail.com> wrote:
>
> > On Tue, Sep 12, 2023 at 6:46=E2=80=AFPM Rob Clark <robdclark@gmail.com>=
 wrote:
> > >
> > > On Tue, Sep 12, 2023 at 2:32=E2=80=AFAM Boris Brezillon
> > > <boris.brezillon@collabora.com> wrote:
> > > >
> > > > On Tue, 12 Sep 2023 09:37:00 +0100
> > > > Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
> > > >
> > > > > The current implementation will try to pick the highest available=
 size
> > > > > display unit as soon as the BO size exceeds that of the previous
> > > > > multiplier. That can lead to loss of precision in BO's whose size=
 is
> > > > > not a multiple of a MiB.
> > > > >
> > > > > Fix it by changing the unit selection criteria.
> > > > >
> > > > > For much bigger BO's, their size will naturally be aligned on som=
ething
> > > > > bigger than a 4 KiB page, so in practice it is very unlikely thei=
r display
> > > > > unit would default to KiB.
> > > >
> > > > Let's wait for Rob's opinion on this.
> > >
> > > This would mean that if you have SZ_1G + SZ_1K worth of buffers, you'=
d
> > > report the result in KiB.. which seems like overkill to me, esp given
> > > that the result is just a snapshot in time of a figure that
> > > realistically is dynamic.
>
> Yeah, my point was that, generally, such big buffers tend to have
> a bigger size alignment (like 2MB for anything bigger than 1GB), but
> maybe this assumption doesn't stand for all drivers.

Maybe for CMA?  Regardless, this # is the sum of buffer sizes, so you
could still get that 1G+1K scenario

> > >
> > > Maybe if you have SZ_1G+SZ_1K worth of buffers you should report the
> > > result with more precision than GiB, but more than MiB seems a bit
> > > overkill.
> > >
> > > BR,
> > > -R
> > >
> > > > >
> > > > > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_file.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_fil=
e.c
> > > > > index 762965e3d503..bf7d2fe46bfa 100644
> > > > > --- a/drivers/gpu/drm/drm_file.c
> > > > > +++ b/drivers/gpu/drm/drm_file.c
> > > > > @@ -879,7 +879,7 @@ static void print_size(struct drm_printer *p,=
 const char *stat,
> > > > >       unsigned u;
> > > > >
> > > > >       for (u =3D 0; u < ARRAY_SIZE(units) - 1; u++) {
> > > > > -             if (sz < SZ_1K)
> >
> > btw, I was thinking more along the lines of:
> >
> >    if (sz < 10*SZ_1K)
> >
> > (or perhaps maybe 100*SZ_1K)
>
> I think I suggested doing that at some point:
>
>                 if ((sz & (SZ_1K - 1)) &&
>                     sz < UPPER_UNIT_THRESHOLD * SZ_1K)
>                         break;
>
> so we can keep using the upper unit if the size is a multiple of this
> upper unit, even if it's smaller than the selected threshold.

yeah, that wfm

BR,
-R

>
> >
> > I mean, any visualization tool is going to scale the y axis based on
> > the order of magnitude.. and if I'm looking at the fdinfo with my
> > eyeballs I don't want to count the # of digits manually to do the
> > conversion in my head.  The difference btwn 4 or 5 or maybe 6 digits
> > is easy enough to eyeball, but more than that is too much for my
> > eyesight, and I'm not seeing how it is useful ;-)
> >
> > But if someone really has a valid use case for having precision in 1KB
> > then I'm willing to be overruled.
>
> So, precision loss was one aspect, but my main concern was having
> things displayed in KiB when they could have been displayed in MiB,
> because the size is a multiple of a MiB but still not big enough to
> pass the threshold test (which was set to 10000x in the previous
> version).
>
> > But I'm not a fan of the earlier
> > approach of different drivers reporting results differently, the whole
> > point of fdinfo was to have some standardized reporting.
>
> Totally agree with that.
>
> >
> > BR,
> > -R
> >
> > > > > +             if (sz & (SZ_1K - 1))
> > > > >                       break;
> > > > >               sz =3D div_u64(sz, SZ_1K);
> > > > >       }
> > > >
>
