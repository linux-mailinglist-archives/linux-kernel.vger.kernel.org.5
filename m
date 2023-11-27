Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE927FAC3D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjK0VHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0VHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:07:01 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AB519D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:07:07 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5ce8eff71e1so29263387b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701119226; x=1701724026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUU3+89wZrgDbzq+c00gpiQNcqaCPhQOfgZ74RHd2SY=;
        b=q5FdhAj3PI3P2/F7hAOXnatnGewHgwFkCOjipwJzTXtv3CPlKQ/MCjL7i2XkBtbkme
         4cIK36OMYRFg3Wq2UqFvg9Dy06h2xjfx9S5yJulKL1sXqN9DG+2A3geaND8iEVFEBKvL
         o0uwHeRcY0gmrxlgGFWw0O0N8vS8X8izx07hor6H4mJLokFawAYB67lL4IuxBj8hRc++
         Jf07Fpp93vFxf3MUepugMkxjulcCYp8L3hRkHR/50zHSU7fR9sKrGzpIOXEKdVBA3CnI
         SolGORjJ2tqmFx0BfGQz3s07f0Z7MKHkYazGV+svCz+lUHbSFW68kaKuI1wpATqHunRW
         S/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701119226; x=1701724026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUU3+89wZrgDbzq+c00gpiQNcqaCPhQOfgZ74RHd2SY=;
        b=ucPU+1Qd+ZpNPMjfnysKIOZT6xnOCKEIrHpy1ZTX8yqCjJ/sYDCzPKkKhSPVgQZ+Q1
         0zqgXcXO1qxJFNYsWIqBvKy3wejQ1vHbCrEQpKogJZqBHUQl7ll8VmVg4Q2YT403umS3
         1J/wy+itqGYMVSqQUdiUMluSNLlmOaQAH9zPppKYTYn3HjeB+c8It6y6jFGkdB05Nl3a
         3Clhfmr8frpSkuA9mZUGUog1ApmeSZZSJAlVKKRV1NPMSUqwJmnmQIcyWH9c7073XmHA
         8JY5fTFLY/vH7m+C5KF+cOU9AQcjq0Hc8WqzEIEDiTPrq1bkBwISC6FBCMPnIlbo1GZN
         AHOw==
X-Gm-Message-State: AOJu0YzMTCR4RNNlCLNUNWmF8hPEWk/WqLr0VigFIX514supSNejBFiX
        hbXRF9lG87Vz2dMDdh7Y6CVG2voAX9AH9o5iydGcNA==
X-Google-Smtp-Source: AGHT+IF+k1LKe2Ufl37lo2dRXkW3bDFo2hDN+DJaSNvvCtX+/g+2Hd5wjHLMUZMnlAdWEBan4IGHhabadU7daPRnizw=
X-Received: by 2002:a81:6006:0:b0:5c9:af70:8e99 with SMTP id
 u6-20020a816006000000b005c9af708e99mr13101599ywb.41.1701119226420; Mon, 27
 Nov 2023 13:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20231115141928.429688-1-dipamt1729@gmail.com> <CAA8EJprqnUGQxmj4Y=qttVuj0zJxdD9B6neHa6sPseLLETpk5A@mail.gmail.com>
 <CALHmwsoC5h7_w9OzpUS_-xM6x5WF5V-vFExLEf4y99b2eCcqGQ@mail.gmail.com>
 <CAA8EJpoyC=paF1ZuznXgJAkT1fne0RwYfqJh-cdz0WLt02i+bw@mail.gmail.com>
 <CAF6AEGtdKD6-xA+AeZDXuKc+k4MnP8Ba4-12hHxt00bXLhJ7Eg@mail.gmail.com>
 <CAA8EJprj7F_K1zxnGdz1ReLNMR2CiYfRxWHUmudTZC+qjKA+kA@mail.gmail.com> <CAF6AEGtW5XZS+S0xQViE8RwmdsxXsSg3yz8-1=oGO5+HTzw52g@mail.gmail.com>
In-Reply-To: <CAF6AEGtW5XZS+S0xQViE8RwmdsxXsSg3yz8-1=oGO5+HTzw52g@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 27 Nov 2023 23:06:55 +0200
Message-ID: <CAA8EJpr6QerE_VhfQksgSUFHY=-gg3xWAqY9cfAHzfMtyBnNKA@mail.gmail.com>
Subject: Re: [PATCH v2] Remove custom dumb_map_offset implementation in msm driver
To:     Rob Clark <robdclark@gmail.com>
Cc:     Dipam Turkar <dipamt1729@gmail.com>, quic_abhinavk@quicinc.com,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 at 22:52, Rob Clark <robdclark@gmail.com> wrote:
>
> On Tue, Nov 21, 2023 at 5:14=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, 21 Nov 2023 at 04:26, Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > On Wed, Nov 15, 2023 at 11:33=E2=80=AFAM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > On Wed, 15 Nov 2023 at 20:46, Dipam Turkar <dipamt1729@gmail.com> w=
rote:
> > > > >
> > > > > They are not outdated, my bad. I went through the locks' code and=
 saw that they have been updated. But they are probably not necessary here =
as most of the drivers do not use any form of locking in their implementati=
ons. The generic implementations drm_gem_dumb_map_offset() and drm_gem_ttm_=
dumb_map_offset() do not have any locking mechanisms either.
> > > >
> > > > Excuse me, but this doesn't sound right to me. There are different
> > > > drivers with different implementations. So either we'd need a good
> > > > explanation of why it is not necessary, or this patch is NAKed.
> > >
> > > Digging a bit thru history, it looks like commit 0de23977cfeb
> > > ("drm/gem: convert to new unified vma manager") made external locking
> > > unnecessary, since the vma mgr already had it's own internal locking.
> >
> > So, should we drop our own locking system?
>
> specifically for _just_ vma_offset_manager/vma_node, we could.  But I
> think that only amounts to mmap_offset().

I see. I'll try digging into the mentioned commit. In the meantime,
this looks like an R-B from you, doesn't it?

>
> BR,
> -R
>
> > >
> > > BR,
> > > -R
> > >
> > > > >
> > > > > Thanks and regards
> > > > > Dipam Turkar
> > > > >
> > > > > On Wed, Nov 15, 2023 at 8:37=E2=80=AFPM Dmitry Baryshkov <dmitry.=
baryshkov@linaro.org> wrote:
> > > > >>
> > > > >> On Wed, 15 Nov 2023 at 16:30, Dipam Turkar <dipamt1729@gmail.com=
> wrote:
> > > > >> >
> > > > >> > Make msm use drm_gem_create_map_offset() instead of its custom
> > > > >> > implementation for associating GEM object with a fake offset. =
Since,
> > > > >> > we already have this generic implementation, we don't need the=
 custom
> > > > >> > implementation and it is better to standardize the code for GE=
M based
> > > > >> > drivers. This also removes the outdated locking leftovers.
> > > > >>
> > > > >> Why are they outdated?
> > > > >>
> > > > >> >
> > > > >> > Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
> > > > >> > ---
> > > > >> >  drivers/gpu/drm/msm/msm_drv.c |  2 +-
> > > > >> >  drivers/gpu/drm/msm/msm_gem.c | 21 ---------------------
> > > > >> >  drivers/gpu/drm/msm/msm_gem.h |  2 --
> > > > >> >  3 files changed, 1 insertion(+), 24 deletions(-)
> > > > >> >
> > > > >> > Changes in v2:
> > > > >> > Modify commit message to include the absence of internal locki=
ng leftovers
> > > > >> > around allocating a fake offset in msm_gem_mmap_offset() in th=
e generic
> > > > >> > implementation drm_gem_create_map_offset().
> > > > >> >
> > > > >> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/m=
sm/msm_drv.c
> > > > >> > index a428951ee539..86a15992c717 100644
> > > > >> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > > > >> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > > > >> > @@ -1085,7 +1085,7 @@ static const struct drm_driver msm_drive=
r =3D {
> > > > >> >         .open               =3D msm_open,
> > > > >> >         .postclose          =3D msm_postclose,
> > > > >> >         .dumb_create        =3D msm_gem_dumb_create,
> > > > >> > -       .dumb_map_offset    =3D msm_gem_dumb_map_offset,
> > > > >> > +       .dumb_map_offset    =3D drm_gem_dumb_map_offset,
> > > > >> >         .gem_prime_import_sg_table =3D msm_gem_prime_import_sg=
_table,
> > > > >> >  #ifdef CONFIG_DEBUG_FS
> > > > >> >         .debugfs_init       =3D msm_debugfs_init,
> > > > >> > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/m=
sm/msm_gem.c
> > > > >> > index db1e748daa75..489694ef79cb 100644
> > > > >> > --- a/drivers/gpu/drm/msm/msm_gem.c
> > > > >> > +++ b/drivers/gpu/drm/msm/msm_gem.c
> > > > >> > @@ -671,27 +671,6 @@ int msm_gem_dumb_create(struct drm_file *=
file, struct drm_device *dev,
> > > > >> >                         MSM_BO_SCANOUT | MSM_BO_WC, &args->han=
dle, "dumb");
> > > > >> >  }
> > > > >> >
> > > > >> > -int msm_gem_dumb_map_offset(struct drm_file *file, struct drm=
_device *dev,
> > > > >> > -               uint32_t handle, uint64_t *offset)
> > > > >> > -{
> > > > >> > -       struct drm_gem_object *obj;
> > > > >> > -       int ret =3D 0;
> > > > >> > -
> > > > >> > -       /* GEM does all our handle to object mapping */
> > > > >> > -       obj =3D drm_gem_object_lookup(file, handle);
> > > > >> > -       if (obj =3D=3D NULL) {
> > > > >> > -               ret =3D -ENOENT;
> > > > >> > -               goto fail;
> > > > >> > -       }
> > > > >> > -
> > > > >> > -       *offset =3D msm_gem_mmap_offset(obj);
> > > > >> > -
> > > > >> > -       drm_gem_object_put(obj);
> > > > >> > -
> > > > >> > -fail:
> > > > >> > -       return ret;
> > > > >> > -}
> > > > >> > -
> > > > >> >  static void *get_vaddr(struct drm_gem_object *obj, unsigned m=
adv)
> > > > >> >  {
> > > > >> >         struct msm_gem_object *msm_obj =3D to_msm_bo(obj);
> > > > >> > diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/m=
sm/msm_gem.h
> > > > >> > index 8ddef5443140..dc74a0ef865d 100644
> > > > >> > --- a/drivers/gpu/drm/msm/msm_gem.h
> > > > >> > +++ b/drivers/gpu/drm/msm/msm_gem.h
> > > > >> > @@ -139,8 +139,6 @@ struct page **msm_gem_pin_pages(struct drm=
_gem_object *obj);
> > > > >> >  void msm_gem_unpin_pages(struct drm_gem_object *obj);
> > > > >> >  int msm_gem_dumb_create(struct drm_file *file, struct drm_dev=
ice *dev,
> > > > >> >                 struct drm_mode_create_dumb *args);
> > > > >> > -int msm_gem_dumb_map_offset(struct drm_file *file, struct drm=
_device *dev,
> > > > >> > -               uint32_t handle, uint64_t *offset);
> > > > >> >  void *msm_gem_get_vaddr_locked(struct drm_gem_object *obj);
> > > > >> >  void *msm_gem_get_vaddr(struct drm_gem_object *obj);
> > > > >> >  void *msm_gem_get_vaddr_active(struct drm_gem_object *obj);
> > > > >> > --
> > > > >> > 2.34.1
> > > > >> >
> > > > >>
> > > > >>
> > > > >> --
> > > > >> With best wishes
> > > > >> Dmitry
> > > >
> > > >
> > > >
> > > > --
> > > > With best wishes
> > > > Dmitry
> >
> >
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry
