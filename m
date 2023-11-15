Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CB77ECCF0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjKOTdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbjKOTdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:33:22 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AAA9E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:33:18 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b5aee410f2so13629b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700076797; x=1700681597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IlDh6BA25cklyVUGxLrq0BMBGhOE7EADMlj8E0gBvo=;
        b=kZ3EY8jsrDs3VdA4M/j3GFUmy8xJRkeuHdi7DUjkNrKtLriwOLwRuTS8ha/HxHz1po
         9wCTdUGdEYvQlSNcqfXqllxzDyidnPGZns6l1r1ZBj9dGE35sJGBhQssVRHAOCiFMppX
         XRi+5XuHXqLlSrnPrFBQ1BSTINjq4HHVNUV3VMnCZJ9gJy/sBAD51fS1AtD/aRRH6L6/
         kVO77JoAIH3a+BeitQxzEqKsAhT/EXG9bzjpyLp5cJzV8uQw/1/nI+OwHm7U2cKDG4+i
         Bzbf6Zs1NDn7gGMNlMUWg3Sp8gIWl3W/wQ4pB5awA6nLH4e86tmdPPfiXsmYV4DdfZTR
         fnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700076797; x=1700681597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IlDh6BA25cklyVUGxLrq0BMBGhOE7EADMlj8E0gBvo=;
        b=mC4m3lLOH0kEzmAqlnwB8h1dHg6lnoXT7gUmH6isTE8lmwpB37HUg10E7YEolNtJeE
         TBgacfvQwPNdcrIr9EaQlEqh/CGhBOOOllBsosbYgT7EWSRlYfL8bYBxriFiItks1naB
         E2VNSpHAcYy/+epcGEe1HnQaAGMObyQqyc2ngzADmiq5OGJRpJ2qKQ0+/UvZ488DvSpj
         GEVH07idEsEJN/eklGkOJ9CjjT8fHs1+GebCpFYeyu3dp0qVeVQ6emqIb4o7tKd20sGP
         8bpL6FHf/7HAhDEldYj8SK4Iieu1TdnPStMpFXzshxvVCcnd5KvjuMZZBKCW5oFo6BZg
         qr4w==
X-Gm-Message-State: AOJu0YxcEMGmyMRGaybI4doHB7jZXq/4qnJP58/x4GvG01UpIoXUdONG
        7zgRD4oBOQKPpGkQXD8xOfiEXCdV7klSpykeGfz25A==
X-Google-Smtp-Source: AGHT+IFMFDUkGUwWEvF5Saq4BbZXy0sqfAid4D3HEq1LQ7pFsGYsyZceAB4Tsza0BqyiFHT2wREERfNM4XOtta+XAmc=
X-Received: by 2002:a05:6358:9386:b0:169:9859:ccc3 with SMTP id
 h6-20020a056358938600b001699859ccc3mr6697212rwb.12.1700076797522; Wed, 15 Nov
 2023 11:33:17 -0800 (PST)
MIME-Version: 1.0
References: <20231115141928.429688-1-dipamt1729@gmail.com> <CAA8EJprqnUGQxmj4Y=qttVuj0zJxdD9B6neHa6sPseLLETpk5A@mail.gmail.com>
 <CALHmwsoC5h7_w9OzpUS_-xM6x5WF5V-vFExLEf4y99b2eCcqGQ@mail.gmail.com>
In-Reply-To: <CALHmwsoC5h7_w9OzpUS_-xM6x5WF5V-vFExLEf4y99b2eCcqGQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Nov 2023 21:33:05 +0200
Message-ID: <CAA8EJpoyC=paF1ZuznXgJAkT1fne0RwYfqJh-cdz0WLt02i+bw@mail.gmail.com>
Subject: Re: [PATCH v2] Remove custom dumb_map_offset implementation in msm driver
To:     Dipam Turkar <dipamt1729@gmail.com>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, 15 Nov 2023 at 20:46, Dipam Turkar <dipamt1729@gmail.com> wrote:
>
> They are not outdated, my bad. I went through the locks' code and saw tha=
t they have been updated. But they are probably not necessary here as most =
of the drivers do not use any form of locking in their implementations. The=
 generic implementations drm_gem_dumb_map_offset() and drm_gem_ttm_dumb_map=
_offset() do not have any locking mechanisms either.

Excuse me, but this doesn't sound right to me. There are different
drivers with different implementations. So either we'd need a good
explanation of why it is not necessary, or this patch is NAKed.

>
> Thanks and regards
> Dipam Turkar
>
> On Wed, Nov 15, 2023 at 8:37=E2=80=AFPM Dmitry Baryshkov <dmitry.baryshko=
v@linaro.org> wrote:
>>
>> On Wed, 15 Nov 2023 at 16:30, Dipam Turkar <dipamt1729@gmail.com> wrote:
>> >
>> > Make msm use drm_gem_create_map_offset() instead of its custom
>> > implementation for associating GEM object with a fake offset. Since,
>> > we already have this generic implementation, we don't need the custom
>> > implementation and it is better to standardize the code for GEM based
>> > drivers. This also removes the outdated locking leftovers.
>>
>> Why are they outdated?
>>
>> >
>> > Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
>> > ---
>> >  drivers/gpu/drm/msm/msm_drv.c |  2 +-
>> >  drivers/gpu/drm/msm/msm_gem.c | 21 ---------------------
>> >  drivers/gpu/drm/msm/msm_gem.h |  2 --
>> >  3 files changed, 1 insertion(+), 24 deletions(-)
>> >
>> > Changes in v2:
>> > Modify commit message to include the absence of internal locking lefto=
vers
>> > around allocating a fake offset in msm_gem_mmap_offset() in the generi=
c
>> > implementation drm_gem_create_map_offset().
>> >
>> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_d=
rv.c
>> > index a428951ee539..86a15992c717 100644
>> > --- a/drivers/gpu/drm/msm/msm_drv.c
>> > +++ b/drivers/gpu/drm/msm/msm_drv.c
>> > @@ -1085,7 +1085,7 @@ static const struct drm_driver msm_driver =3D {
>> >         .open               =3D msm_open,
>> >         .postclose          =3D msm_postclose,
>> >         .dumb_create        =3D msm_gem_dumb_create,
>> > -       .dumb_map_offset    =3D msm_gem_dumb_map_offset,
>> > +       .dumb_map_offset    =3D drm_gem_dumb_map_offset,
>> >         .gem_prime_import_sg_table =3D msm_gem_prime_import_sg_table,
>> >  #ifdef CONFIG_DEBUG_FS
>> >         .debugfs_init       =3D msm_debugfs_init,
>> > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_g=
em.c
>> > index db1e748daa75..489694ef79cb 100644
>> > --- a/drivers/gpu/drm/msm/msm_gem.c
>> > +++ b/drivers/gpu/drm/msm/msm_gem.c
>> > @@ -671,27 +671,6 @@ int msm_gem_dumb_create(struct drm_file *file, st=
ruct drm_device *dev,
>> >                         MSM_BO_SCANOUT | MSM_BO_WC, &args->handle, "du=
mb");
>> >  }
>> >
>> > -int msm_gem_dumb_map_offset(struct drm_file *file, struct drm_device =
*dev,
>> > -               uint32_t handle, uint64_t *offset)
>> > -{
>> > -       struct drm_gem_object *obj;
>> > -       int ret =3D 0;
>> > -
>> > -       /* GEM does all our handle to object mapping */
>> > -       obj =3D drm_gem_object_lookup(file, handle);
>> > -       if (obj =3D=3D NULL) {
>> > -               ret =3D -ENOENT;
>> > -               goto fail;
>> > -       }
>> > -
>> > -       *offset =3D msm_gem_mmap_offset(obj);
>> > -
>> > -       drm_gem_object_put(obj);
>> > -
>> > -fail:
>> > -       return ret;
>> > -}
>> > -
>> >  static void *get_vaddr(struct drm_gem_object *obj, unsigned madv)
>> >  {
>> >         struct msm_gem_object *msm_obj =3D to_msm_bo(obj);
>> > diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_g=
em.h
>> > index 8ddef5443140..dc74a0ef865d 100644
>> > --- a/drivers/gpu/drm/msm/msm_gem.h
>> > +++ b/drivers/gpu/drm/msm/msm_gem.h
>> > @@ -139,8 +139,6 @@ struct page **msm_gem_pin_pages(struct drm_gem_obj=
ect *obj);
>> >  void msm_gem_unpin_pages(struct drm_gem_object *obj);
>> >  int msm_gem_dumb_create(struct drm_file *file, struct drm_device *dev=
,
>> >                 struct drm_mode_create_dumb *args);
>> > -int msm_gem_dumb_map_offset(struct drm_file *file, struct drm_device =
*dev,
>> > -               uint32_t handle, uint64_t *offset);
>> >  void *msm_gem_get_vaddr_locked(struct drm_gem_object *obj);
>> >  void *msm_gem_get_vaddr(struct drm_gem_object *obj);
>> >  void *msm_gem_get_vaddr_active(struct drm_gem_object *obj);
>> > --
>> > 2.34.1
>> >
>>
>>
>> --
>> With best wishes
>> Dmitry



--=20
With best wishes
Dmitry
