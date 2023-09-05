Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15DC7931ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244823AbjIEWX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbjIEWXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:23:49 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00571185;
        Tue,  5 Sep 2023 15:23:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so4191752a12.0;
        Tue, 05 Sep 2023 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693952623; x=1694557423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T55w72TpNqnSrtyLfrBfFw2Bj7G/h6hqY2N0kbcyw4=;
        b=oKwj9TwTKDt0bCNPeZkawKVg68OKxkg1ALrHhNO/JoYPOyVFFZUPU9CnY5fNBzSgxZ
         k2Z0HfXh5P/vlYYAVFjsIWy7uBirm0PPTGCxSrOkCe4cSJJ5bFs8l87EpJMMIG416Gsb
         I3b5S0sRJ0CzwB35nZb+3lidmYMi13f0IMh8OaE6LbR/xkcBsT/3a4xjPUN88T1lPPyb
         TEOZtWd1EFE3wjdsvS4NstsZTWvtYMdXo9a6R9nLu+Ct39wKPKMuynAfnfkSt6AFqhFU
         lWBewUqyFvl2tuCzyDYh6/Gwntgs5U+6OTvBt0dlrbkE5J2YyyI0koa8APP2sQJ7CIS7
         iuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693952623; x=1694557423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1T55w72TpNqnSrtyLfrBfFw2Bj7G/h6hqY2N0kbcyw4=;
        b=ISvViJN8R1+dRQLeYybu0Ib+gCBxyCYjtv3gOD/3NqS7YS+1nk6kD5HKiZ6SYX9sQg
         JzBY7Ts9DW1PYNfsWHZDjCLdQ/02D8s0yKWvBsefncxbpSpEzfH3yUTBB2bHg6ZN1lYP
         OWO3al2djYyplj8nugUYxhV7S+goPODnkvaTiMW6h17R9hWytSaw4+V9woTSX5fKtdPC
         MgmsK1f0mTsJOWtVqy//GRb2Mh8v2Izukpn4ANsb+pLnpWr/GK6vxLu2k33fl/Nxf8kg
         IaoSkJ8Y+DYqnawlBIlmoIifAX9OhGQrhDCBa+TDW/8QHpFtZNMdogFH/4IdTyFBua2g
         ms/w==
X-Gm-Message-State: AOJu0Yx1KCG8R6oJsO2eTny2QguBQBtsMIJFh2YedemjSKmLyjkV7uAS
        I/5vmYKTTJzj7lNseaENs7FoCExLAlKWQ2nfkpw=
X-Google-Smtp-Source: AGHT+IGaNhh5xAZtd1HQ7K+uOvEuJt6MrFF437Bu/DNH19srdrf+ltw2URQ82OywTRN2n3QE0XOen0vftZ3tepICecQ=
X-Received: by 2002:a17:906:10cd:b0:9a5:821e:1655 with SMTP id
 v13-20020a17090610cd00b009a5821e1655mr760091ejv.71.1693952623162; Tue, 05 Sep
 2023 15:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230824013604.466224-1-adrian.larumbe@collabora.com>
 <20230824013604.466224-7-adrian.larumbe@collabora.com> <CAF6AEGtXUTs3ta0N+0hiORa+Tsyh94AXPYm9XdaK6xZbqf+nzA@mail.gmail.com>
 <tc7x4uzxvfwakzoqxgaxbkzh3nyhub56ksrgaqmrb4uaq4rruw@7xwan7qfofw7>
In-Reply-To: <tc7x4uzxvfwakzoqxgaxbkzh3nyhub56ksrgaqmrb4uaq4rruw@7xwan7qfofw7>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 5 Sep 2023 15:23:31 -0700
Message-ID: <CAF6AEGtueEoHCT1rg6G3BPAMaFMidr0un1i6X1VFMxq_xeUq7w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/drm-file: Allow size unit selection in drm_show_memory_stats
To:     =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, healych@amazon.com,
        kernel@collabora.com, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rob Clark <robdclark@chromium.org>
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

On Wed, Aug 30, 2023 at 8:51=E2=80=AFAM Adri=C3=A1n Larumbe
<adrian.larumbe@collabora.com> wrote:
>
> >> The current implementation will try to pick the highest available
> >> unit. This is rather unflexible, and allowing drivers to display BO si=
ze
> >> statistics through fdinfo in units of their choice might be desirable.
> >>
> >> The new argument to drm_show_memory_stats is to be interpreted as the
> >> integer multiplier of a 10-power of 2, so 1 would give us size in Kib =
and 2
> >> in Mib. If we want drm-file functions to pick the highest unit, then 0
> >> should be passed.
> >>
> >> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> >> ---
> >>  drivers/gpu/drm/drm_file.c              | 22 +++++++++++++---------
> >>  drivers/gpu/drm/msm/msm_drv.c           |  2 +-
> >>  drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
> >>  include/drm/drm_file.h                  |  5 +++--
> >>  4 files changed, 18 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> >> index 762965e3d503..517e1fb8072a 100644
> >> --- a/drivers/gpu/drm/drm_file.c
> >> +++ b/drivers/gpu/drm/drm_file.c
> >> @@ -873,7 +873,7 @@ void drm_send_event(struct drm_device *dev, struct=
 drm_pending_event *e)
> >>  EXPORT_SYMBOL(drm_send_event);
> >>
> >>  static void print_size(struct drm_printer *p, const char *stat,
> >> -                      const char *region, u64 sz)
> >> +                      const char *region, u64 sz, unsigned int unit)
> >>  {
> >>         const char *units[] =3D {"", " KiB", " MiB"};
> >>         unsigned u;
> >> @@ -881,6 +881,8 @@ static void print_size(struct drm_printer *p, cons=
t char *stat,
> >>         for (u =3D 0; u < ARRAY_SIZE(units) - 1; u++) {
> >>                 if (sz < SZ_1K)
> >>                         break;
> >> +               if (unit > 0 && unit =3D=3D u)
> >> +                       break;
> >>                 sz =3D div_u64(sz, SZ_1K);
> >>         }
> >>
> >> @@ -898,17 +900,18 @@ static void print_size(struct drm_printer *p, co=
nst char *stat,
> >>  void drm_print_memory_stats(struct drm_printer *p,
> >>                             const struct drm_memory_stats *stats,
> >>                             enum drm_gem_object_status supported_statu=
s,
> >> -                           const char *region)
> >> +                           const char *region,
> >> +                           unsigned int unit)
> >
> >I'm not really adverse to changing what units we use.. or perhaps
> >changing the threshold to go to higher units to be 10000x or 100000x
> >of the previous unit.  But I'm less excited about having different
> >drivers using different units.
> >
> >BR,
> >-R
>
> Would it be alright if I left it set to the default unit, and allow chang=
ing it
> at runtime with a debugfs file?

I suppose we could, but it does seem a bit like overkill.  OTOH I
think it would make sense to increase the threshold, ie. switch to MiB
after 10MiB instead of 1MiB.. at that point the fractional component
is less significant..

BR,
-R

> >>  {
> >> -       print_size(p, "total", region, stats->private + stats->shared)=
;
> >> -       print_size(p, "shared", region, stats->shared);
> >> -       print_size(p, "active", region, stats->active);
> >> +       print_size(p, "total", region, stats->private + stats->shared,=
 unit);
> >> +       print_size(p, "shared", region, stats->shared, unit);
> >> +       print_size(p, "active", region, stats->active, unit);
> >>
> >>         if (supported_status & DRM_GEM_OBJECT_RESIDENT)
> >> -               print_size(p, "resident", region, stats->resident);
> >> +               print_size(p, "resident", region, stats->resident, uni=
t);
> >>
> >>         if (supported_status & DRM_GEM_OBJECT_PURGEABLE)
> >> -               print_size(p, "purgeable", region, stats->purgeable);
> >> +               print_size(p, "purgeable", region, stats->purgeable, u=
nit);
> >>  }
> >>  EXPORT_SYMBOL(drm_print_memory_stats);
> >>
> >> @@ -916,11 +919,12 @@ EXPORT_SYMBOL(drm_print_memory_stats);
> >>   * drm_show_memory_stats - Helper to collect and show standard fdinfo=
 memory stats
> >>   * @p: the printer to print output to
> >>   * @file: the DRM file
> >> + * @unit: multipliyer of power of two exponent of desired unit
> >>   *
> >>   * Helper to iterate over GEM objects with a handle allocated in the =
specified
> >>   * file.
> >>   */
> >> -void drm_show_memory_stats(struct drm_printer *p, struct drm_file *fi=
le)
> >> +void drm_show_memory_stats(struct drm_printer *p, struct drm_file *fi=
le, unsigned int unit)
> >>  {
> >>         struct drm_gem_object *obj;
> >>         struct drm_memory_stats status =3D {};
> >> @@ -967,7 +971,7 @@ void drm_show_memory_stats(struct drm_printer *p, =
struct drm_file *file)
> >>         }
> >>         spin_unlock(&file->table_lock);
> >>
> >> -       drm_print_memory_stats(p, &status, supported_status, "memory")=
;
> >> +       drm_print_memory_stats(p, &status, supported_status, "memory",=
 unit);
> >>  }
> >>  EXPORT_SYMBOL(drm_show_memory_stats);
> >>
> >> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_d=
rv.c
> >> index 2a0e3529598b..cd1198151744 100644
> >> --- a/drivers/gpu/drm/msm/msm_drv.c
> >> +++ b/drivers/gpu/drm/msm/msm_drv.c
> >> @@ -1067,7 +1067,7 @@ static void msm_show_fdinfo(struct drm_printer *=
p, struct drm_file *file)
> >>
> >>         msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, p);
> >>
> >> -       drm_show_memory_stats(p, file);
> >> +       drm_show_memory_stats(p, file, 0);
> >>  }
> >>
> >>  static const struct file_operations fops =3D {
> >> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm=
/panfrost/panfrost_drv.c
> >> index 93d5f5538c0b..79c08cee3e9d 100644
> >> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> >> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> >> @@ -563,7 +563,7 @@ static void panfrost_show_fdinfo(struct drm_printe=
r *p, struct drm_file *file)
> >>
> >>         panfrost_gpu_show_fdinfo(pfdev, file->driver_priv, p);
> >>
> >> -       drm_show_memory_stats(p, file);
> >> +       drm_show_memory_stats(p, file, 1);
> >>  }
> >>
> >>  static const struct file_operations panfrost_drm_driver_fops =3D {
> >> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> >> index 010239392adf..21a3b022dd63 100644
> >> --- a/include/drm/drm_file.h
> >> +++ b/include/drm/drm_file.h
> >> @@ -466,9 +466,10 @@ enum drm_gem_object_status;
> >>  void drm_print_memory_stats(struct drm_printer *p,
> >>                             const struct drm_memory_stats *stats,
> >>                             enum drm_gem_object_status supported_statu=
s,
> >> -                           const char *region);
> >> +                           const char *region,
> >> +                           unsigned int unit);
> >>
> >> -void drm_show_memory_stats(struct drm_printer *p, struct drm_file *fi=
le);
> >> +void drm_show_memory_stats(struct drm_printer *p, struct drm_file *fi=
le, unsigned int unit);
> >>  void drm_show_fdinfo(struct seq_file *m, struct file *f);
> >>
> >>  struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int f=
lags);
> >> --
> >> 2.42.0
> >>
