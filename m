Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8BA78B3E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjH1PAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjH1PAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:00:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD20FBF;
        Mon, 28 Aug 2023 08:00:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50091b91a83so5032386e87.3;
        Mon, 28 Aug 2023 08:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693234819; x=1693839619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/Iv+UJrS/3Ac+CBpzamiE2539VuRhYJEwYN53j5C48=;
        b=XEC6EQXO+tUhRz9PO98p2Sa2QVpVl4AhyDeqQHMbryX4dXPEF3x8ZPiEBi8CPvSMcb
         GzjyoPH5RYGrnrxYPeQVIszcalsKk+YzRKY8BRn+VB+TZ6cN7bpysBwaOaGgtBziwF+4
         CmtglG6KPwGlbOvqEKC28fE5jbhIVyuLmF5FG/l5PYKDtphIs8ROePpWrY8sdQtBCwfP
         7QOnrBm7t+ZWgcDf0PBZQRZa1kAI45N0NFjUUPt58dvwQQApbSM6LxfSeflfISRSc0no
         hI08V8pI/f54n6qZrfmNOyY1np8jmBLkHPGpeVq7OTE27D17OyZzz0C9iUxxJeTBzX5V
         ZbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693234819; x=1693839619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/Iv+UJrS/3Ac+CBpzamiE2539VuRhYJEwYN53j5C48=;
        b=LYJ+wClaX9T/ZufxQ6mVqKHv8NxPL7rYgTfCKk6GtIrB8Bed1Ehsgr1vNm+BC2GKDR
         vcR+a/2GDAfvNiWY8DB9UuNPeJlgdzvjv1Q3Kgoag5LAbQmdbtGDab1pXMmboYzsL6+A
         D3Xu/jOpdiaec7taBqXO6nNRNnUGxrlPMpa//xPjgAWUsEEfPPgpwoH2aKyrmII+6zxF
         2hwnESZ4gylbh2pi/xpWM9HxjvEZsXPbVUNUVSo4MzNBz/wyzyUen3Jgvx/h531Ka9RF
         BWI14ktjhBOGtYlAq8TgCBL/m5TKhm5n3NJEDsVuDVmqJeu3fahIujXkcHCn+IphHoE1
         dSmw==
X-Gm-Message-State: AOJu0YwyDKeXCbwv3KDe6S2FBpdQx/f7ZcjGA0Ih8nxKRAFW39p4InHp
        MrZ+MsBsDxkvHWNQjKSm0MUFU/pLqne8V66DxSY=
X-Google-Smtp-Source: AGHT+IETY9abOfDkwuwAfP8oxiTrbKWtuyVO2Jf40soOOV3pmIaGIJrqyaxIUb/iRIeotvbn3JYjwWDVrv8Su0Xk6mQ=
X-Received: by 2002:a05:6512:1088:b0:4fb:89b3:3373 with SMTP id
 j8-20020a056512108800b004fb89b33373mr21789410lfg.43.1693234818641; Mon, 28
 Aug 2023 08:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230824013604.466224-1-adrian.larumbe@collabora.com> <20230824013604.466224-7-adrian.larumbe@collabora.com>
In-Reply-To: <20230824013604.466224-7-adrian.larumbe@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 28 Aug 2023 08:00:06 -0700
Message-ID: <CAF6AEGtXUTs3ta0N+0hiORa+Tsyh94AXPYm9XdaK6xZbqf+nzA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/drm-file: Allow size unit selection in drm_show_memory_stats
To:     =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, healych@amazon.com,
        kernel@collabora.com, Tvrtko Ursulin <tvrtko.ursulin@intel.com>
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

On Wed, Aug 23, 2023 at 6:36=E2=80=AFPM Adri=C3=A1n Larumbe
<adrian.larumbe@collabora.com> wrote:
>
> The current implementation will try to pick the highest available
> unit. This is rather unflexible, and allowing drivers to display BO size
> statistics through fdinfo in units of their choice might be desirable.
>
> The new argument to drm_show_memory_stats is to be interpreted as the
> integer multiplier of a 10-power of 2, so 1 would give us size in Kib and=
 2
> in Mib. If we want drm-file functions to pick the highest unit, then 0
> should be passed.
>
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/drm_file.c              | 22 +++++++++++++---------
>  drivers/gpu/drm/msm/msm_drv.c           |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
>  include/drm/drm_file.h                  |  5 +++--
>  4 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 762965e3d503..517e1fb8072a 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -873,7 +873,7 @@ void drm_send_event(struct drm_device *dev, struct dr=
m_pending_event *e)
>  EXPORT_SYMBOL(drm_send_event);
>
>  static void print_size(struct drm_printer *p, const char *stat,
> -                      const char *region, u64 sz)
> +                      const char *region, u64 sz, unsigned int unit)
>  {
>         const char *units[] =3D {"", " KiB", " MiB"};
>         unsigned u;
> @@ -881,6 +881,8 @@ static void print_size(struct drm_printer *p, const c=
har *stat,
>         for (u =3D 0; u < ARRAY_SIZE(units) - 1; u++) {
>                 if (sz < SZ_1K)
>                         break;
> +               if (unit > 0 && unit =3D=3D u)
> +                       break;
>                 sz =3D div_u64(sz, SZ_1K);
>         }
>
> @@ -898,17 +900,18 @@ static void print_size(struct drm_printer *p, const=
 char *stat,
>  void drm_print_memory_stats(struct drm_printer *p,
>                             const struct drm_memory_stats *stats,
>                             enum drm_gem_object_status supported_status,
> -                           const char *region)
> +                           const char *region,
> +                           unsigned int unit)

I'm not really adverse to changing what units we use.. or perhaps
changing the threshold to go to higher units to be 10000x or 100000x
of the previous unit.  But I'm less excited about having different
drivers using different units.

BR,
-R


>  {
> -       print_size(p, "total", region, stats->private + stats->shared);
> -       print_size(p, "shared", region, stats->shared);
> -       print_size(p, "active", region, stats->active);
> +       print_size(p, "total", region, stats->private + stats->shared, un=
it);
> +       print_size(p, "shared", region, stats->shared, unit);
> +       print_size(p, "active", region, stats->active, unit);
>
>         if (supported_status & DRM_GEM_OBJECT_RESIDENT)
> -               print_size(p, "resident", region, stats->resident);
> +               print_size(p, "resident", region, stats->resident, unit);
>
>         if (supported_status & DRM_GEM_OBJECT_PURGEABLE)
> -               print_size(p, "purgeable", region, stats->purgeable);
> +               print_size(p, "purgeable", region, stats->purgeable, unit=
);
>  }
>  EXPORT_SYMBOL(drm_print_memory_stats);
>
> @@ -916,11 +919,12 @@ EXPORT_SYMBOL(drm_print_memory_stats);
>   * drm_show_memory_stats - Helper to collect and show standard fdinfo me=
mory stats
>   * @p: the printer to print output to
>   * @file: the DRM file
> + * @unit: multipliyer of power of two exponent of desired unit
>   *
>   * Helper to iterate over GEM objects with a handle allocated in the spe=
cified
>   * file.
>   */
> -void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
> +void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file,=
 unsigned int unit)
>  {
>         struct drm_gem_object *obj;
>         struct drm_memory_stats status =3D {};
> @@ -967,7 +971,7 @@ void drm_show_memory_stats(struct drm_printer *p, str=
uct drm_file *file)
>         }
>         spin_unlock(&file->table_lock);
>
> -       drm_print_memory_stats(p, &status, supported_status, "memory");
> +       drm_print_memory_stats(p, &status, supported_status, "memory", un=
it);
>  }
>  EXPORT_SYMBOL(drm_show_memory_stats);
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.=
c
> index 2a0e3529598b..cd1198151744 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1067,7 +1067,7 @@ static void msm_show_fdinfo(struct drm_printer *p, =
struct drm_file *file)
>
>         msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, p);
>
> -       drm_show_memory_stats(p, file);
> +       drm_show_memory_stats(p, file, 0);
>  }
>
>  static const struct file_operations fops =3D {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 93d5f5538c0b..79c08cee3e9d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -563,7 +563,7 @@ static void panfrost_show_fdinfo(struct drm_printer *=
p, struct drm_file *file)
>
>         panfrost_gpu_show_fdinfo(pfdev, file->driver_priv, p);
>
> -       drm_show_memory_stats(p, file);
> +       drm_show_memory_stats(p, file, 1);
>  }
>
>  static const struct file_operations panfrost_drm_driver_fops =3D {
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 010239392adf..21a3b022dd63 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -466,9 +466,10 @@ enum drm_gem_object_status;
>  void drm_print_memory_stats(struct drm_printer *p,
>                             const struct drm_memory_stats *stats,
>                             enum drm_gem_object_status supported_status,
> -                           const char *region);
> +                           const char *region,
> +                           unsigned int unit);
>
> -void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)=
;
> +void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file,=
 unsigned int unit);
>  void drm_show_fdinfo(struct seq_file *m, struct file *f);
>
>  struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int flag=
s);
> --
> 2.42.0
>
