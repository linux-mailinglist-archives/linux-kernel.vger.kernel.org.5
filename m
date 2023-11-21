Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB507F2E16
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjKUNOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjKUNOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:14:44 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618BA1A1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:14:40 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5ca5afb453aso19884757b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700572479; x=1701177279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1FVx31ny1UIsUYTN0FvTESgACbfkRrXqAtlZm7hdMQ=;
        b=wk96o3fkJaxwTwxESfaLw91TAWzPE1mwY9IeWR7R5ED0LiNjXTeN8gM867VHuiT1Ok
         zW6n3sbU1sAMqmlo4ehmAMSjhCJJuacXksllhjcyjXsf5uVmxS5Id1+dBvAH/ietSTvt
         bzN0OFoRxJVxke07DHCToUA4lSwH4lwHrsQezABoPCf6Pm1E9YC5MN1wtGhodpDfX0AX
         WUbw0qUA3UgJTuwLff+fyO8NarRKM1NWKS46Vhf38kNO6pBywqPnnnNi4oo8OmTV7/6y
         xnEbSA9oRghfY2z/Iw+8lpH89BZhgpT2hxGpCKNyFb+lT/JQT4hT2rrfUJaU95OpBjuX
         OYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700572479; x=1701177279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1FVx31ny1UIsUYTN0FvTESgACbfkRrXqAtlZm7hdMQ=;
        b=CBnCu5wvh5YEAoB+O4n8QGwm5LFSbiR0xDP1HpZaHgDgN443XPP2ECHp1rBvXb4VnX
         CyE0zKGhfAfDJp4yltyzcRRMzz49G8gk7NCfO0sLDyxg3/44968BrjgAlRi7khFvacxV
         XR7CBsJ7lhJWGDKDDBcu9BlgUZlIlrOBZ3QYWniN3/NoxZUUV4ILWjzHdlEAWyXCmYwS
         0lDjzWHdYeyj9A4TRp66FsbxPvcz1xsZEwSE/5thLN7lbRytx6pytvAPlfp7ll86NDQV
         K5EEgqgMigoOWJmsVS9TBFLfbXo3Vh6KB2IPswzoguCmUW8k4HpFebmMHne3YMAQMuJd
         pfew==
X-Gm-Message-State: AOJu0Yy/9FEE873vcT2eAisqRpsg3tIAXvTKz6j5EiAC0NdjXXrdkDpt
        AsF/IbzurzpBxWOmSoTI0VX2DQcpax+zbSh+rAN1ONQv34iSpuzE
X-Google-Smtp-Source: AGHT+IGdy0glLtv5dcrxHz/dOPuR1DdG5UQYfnJPpwRpz2KnBMCt7ft48fu4aJhKTM32UX2jKzQNfexAUsNEH1vJArE=
X-Received: by 2002:a81:5342:0:b0:5c8:d81d:763d with SMTP id
 h63-20020a815342000000b005c8d81d763dmr7840991ywb.44.1700572479464; Tue, 21
 Nov 2023 05:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20231115141928.429688-1-dipamt1729@gmail.com> <CAA8EJprqnUGQxmj4Y=qttVuj0zJxdD9B6neHa6sPseLLETpk5A@mail.gmail.com>
 <CALHmwsoC5h7_w9OzpUS_-xM6x5WF5V-vFExLEf4y99b2eCcqGQ@mail.gmail.com>
 <CAA8EJpoyC=paF1ZuznXgJAkT1fne0RwYfqJh-cdz0WLt02i+bw@mail.gmail.com> <CAF6AEGtdKD6-xA+AeZDXuKc+k4MnP8Ba4-12hHxt00bXLhJ7Eg@mail.gmail.com>
In-Reply-To: <CAF6AEGtdKD6-xA+AeZDXuKc+k4MnP8Ba4-12hHxt00bXLhJ7Eg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Nov 2023 15:14:28 +0200
Message-ID: <CAA8EJprj7F_K1zxnGdz1ReLNMR2CiYfRxWHUmudTZC+qjKA+kA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 at 04:26, Rob Clark <robdclark@gmail.com> wrote:
>
> On Wed, Nov 15, 2023 at 11:33=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, 15 Nov 2023 at 20:46, Dipam Turkar <dipamt1729@gmail.com> wrote=
:
> > >
> > > They are not outdated, my bad. I went through the locks' code and saw=
 that they have been updated. But they are probably not necessary here as m=
ost of the drivers do not use any form of locking in their implementations.=
 The generic implementations drm_gem_dumb_map_offset() and drm_gem_ttm_dumb=
_map_offset() do not have any locking mechanisms either.
> >
> > Excuse me, but this doesn't sound right to me. There are different
> > drivers with different implementations. So either we'd need a good
> > explanation of why it is not necessary, or this patch is NAKed.
>
> Digging a bit thru history, it looks like commit 0de23977cfeb
> ("drm/gem: convert to new unified vma manager") made external locking
> unnecessary, since the vma mgr already had it's own internal locking.

So, should we drop our own locking system?

>
> BR,
> -R
>
> > >
> > > Thanks and regards
> > > Dipam Turkar
> > >
> > > On Wed, Nov 15, 2023 at 8:37=E2=80=AFPM Dmitry Baryshkov <dmitry.bary=
shkov@linaro.org> wrote:
> > >>
> > >> On Wed, 15 Nov 2023 at 16:30, Dipam Turkar <dipamt1729@gmail.com> wr=
ote:
> > >> >
> > >> > Make msm use drm_gem_create_map_offset() instead of its custom
> > >> > implementation for associating GEM object with a fake offset. Sinc=
e,
> > >> > we already have this generic implementation, we don't need the cus=
tom
> > >> > implementation and it is better to standardize the code for GEM ba=
sed
> > >> > drivers. This also removes the outdated locking leftovers.
> > >>
> > >> Why are they outdated?
> > >>
> > >> >
> > >> > Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
> > >> > ---
> > >> >  drivers/gpu/drm/msm/msm_drv.c |  2 +-
> > >> >  drivers/gpu/drm/msm/msm_gem.c | 21 ---------------------
> > >> >  drivers/gpu/drm/msm/msm_gem.h |  2 --
> > >> >  3 files changed, 1 insertion(+), 24 deletions(-)
> > >> >
> > >> > Changes in v2:
> > >> > Modify commit message to include the absence of internal locking l=
eftovers
> > >> > around allocating a fake offset in msm_gem_mmap_offset() in the ge=
neric
> > >> > implementation drm_gem_create_map_offset().
> > >> >
> > >> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/m=
sm_drv.c
> > >> > index a428951ee539..86a15992c717 100644
> > >> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > >> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > >> > @@ -1085,7 +1085,7 @@ static const struct drm_driver msm_driver =
=3D {
> > >> >         .open               =3D msm_open,
> > >> >         .postclose          =3D msm_postclose,
> > >> >         .dumb_create        =3D msm_gem_dumb_create,
> > >> > -       .dumb_map_offset    =3D msm_gem_dumb_map_offset,
> > >> > +       .dumb_map_offset    =3D drm_gem_dumb_map_offset,
> > >> >         .gem_prime_import_sg_table =3D msm_gem_prime_import_sg_tab=
le,
> > >> >  #ifdef CONFIG_DEBUG_FS
> > >> >         .debugfs_init       =3D msm_debugfs_init,
> > >> > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/m=
sm_gem.c
> > >> > index db1e748daa75..489694ef79cb 100644
> > >> > --- a/drivers/gpu/drm/msm/msm_gem.c
> > >> > +++ b/drivers/gpu/drm/msm/msm_gem.c
> > >> > @@ -671,27 +671,6 @@ int msm_gem_dumb_create(struct drm_file *file=
, struct drm_device *dev,
> > >> >                         MSM_BO_SCANOUT | MSM_BO_WC, &args->handle,=
 "dumb");
> > >> >  }
> > >> >
> > >> > -int msm_gem_dumb_map_offset(struct drm_file *file, struct drm_dev=
ice *dev,
> > >> > -               uint32_t handle, uint64_t *offset)
> > >> > -{
> > >> > -       struct drm_gem_object *obj;
> > >> > -       int ret =3D 0;
> > >> > -
> > >> > -       /* GEM does all our handle to object mapping */
> > >> > -       obj =3D drm_gem_object_lookup(file, handle);
> > >> > -       if (obj =3D=3D NULL) {
> > >> > -               ret =3D -ENOENT;
> > >> > -               goto fail;
> > >> > -       }
> > >> > -
> > >> > -       *offset =3D msm_gem_mmap_offset(obj);
> > >> > -
> > >> > -       drm_gem_object_put(obj);
> > >> > -
> > >> > -fail:
> > >> > -       return ret;
> > >> > -}
> > >> > -
> > >> >  static void *get_vaddr(struct drm_gem_object *obj, unsigned madv)
> > >> >  {
> > >> >         struct msm_gem_object *msm_obj =3D to_msm_bo(obj);
> > >> > diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/m=
sm_gem.h
> > >> > index 8ddef5443140..dc74a0ef865d 100644
> > >> > --- a/drivers/gpu/drm/msm/msm_gem.h
> > >> > +++ b/drivers/gpu/drm/msm/msm_gem.h
> > >> > @@ -139,8 +139,6 @@ struct page **msm_gem_pin_pages(struct drm_gem=
_object *obj);
> > >> >  void msm_gem_unpin_pages(struct drm_gem_object *obj);
> > >> >  int msm_gem_dumb_create(struct drm_file *file, struct drm_device =
*dev,
> > >> >                 struct drm_mode_create_dumb *args);
> > >> > -int msm_gem_dumb_map_offset(struct drm_file *file, struct drm_dev=
ice *dev,
> > >> > -               uint32_t handle, uint64_t *offset);
> > >> >  void *msm_gem_get_vaddr_locked(struct drm_gem_object *obj);
> > >> >  void *msm_gem_get_vaddr(struct drm_gem_object *obj);
> > >> >  void *msm_gem_get_vaddr_active(struct drm_gem_object *obj);
> > >> > --
> > >> > 2.34.1
> > >> >
> > >>
> > >>
> > >> --
> > >> With best wishes
> > >> Dmitry
> >
> >
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry
