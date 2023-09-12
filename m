Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA00279D392
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbjILO2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjILO2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:28:37 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DBC1B6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:28:32 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-495ea3299b0so860868e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694528912; x=1695133712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CMD0KlldaZvMrW0HnZ/m87aJulX8pvfQgSp/+maLPY=;
        b=tLVMpSE/WdRZ77s+XAXDqXpqv8NmRBNUpcqkiYA8MdXa9dK8eVn8Tk54NGXzLoquIJ
         uk6hXGezXNYUXBaxd2H1Lft9ztVXjvOndtL7Dk2PhWlDy9EnkRCGouSDXJzlqoQX0l9+
         fR7BLKN7c71xwwQ24z/8ddNoC2MU6zCzwu/mURumia3cASFBubLplJ1+U19Pk/0nQWXd
         rxcOMSNhsikcCUzCCAZp/A2TXN4XOd+9mDwYDVI/Iy3UPFFWBuCPJ27A3dKrkwaiwTVC
         jLSWH/nWkcOMNzJ0j6rHGrY+nHDjqn8HYUT52hA3gB1YS3H4298h6YVmu0Q46PBDpOZ3
         BShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694528912; x=1695133712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CMD0KlldaZvMrW0HnZ/m87aJulX8pvfQgSp/+maLPY=;
        b=OJvhD7udcB442wg11uO60FKk3ejyddbUG0J4H99z1T1z89+txm7UF/b75K14UzF+k/
         gyQKeJZ8Kv+W4RezV5kvSlKrXyh3D4kz7Ct0IKPlVdAeMl0bdPer2pKdE2/zdX6IjwW/
         va58oncPZxA4J8yG9TTen8EfWPJ5ToSxbwbgzuMGSVR7yO45lBQ0PJqZ0WhKNJXI4x1N
         s0x+WhQ8mWkPS+Mt5vMpyC4RjNGJGYxiqIuo7UbpQBSK59C5E5SERzvzXv6VI95aoPzR
         K2oRhVCLafwPpLbzPZbvxm4l8MlvoKVgltEdeX7pFk7ddgAWeWCT3rMalnXM7c+u+mjy
         lEvw==
X-Gm-Message-State: AOJu0YxbJQUVZWeXymql4Pf6Q91LZ01k+Op1mjolZFK1vYnm/oYb1CDs
        MbpdRaJNJqEvjZXR2w2Pm6KVPhS5667kXqB330FdPw==
X-Google-Smtp-Source: AGHT+IFEkKeYB6WgKYWZ0RRsgKmLFjuyZwQN0KtmDEQuFpi7Nuv4JuDhImGrEkHJKScDuqkdo2HJEECLJTwlAYF9tmk=
X-Received: by 2002:a1f:de84:0:b0:48d:3b80:fba9 with SMTP id
 v126-20020a1fde84000000b0048d3b80fba9mr6991652vkg.11.1694528911950; Tue, 12
 Sep 2023 07:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230912085541.13682-1-brgl@bgdev.pl> <20230912085541.13682-2-brgl@bgdev.pl>
 <ZQBq81QRFVOMBmnB@yury-ThinkPad>
In-Reply-To: <ZQBq81QRFVOMBmnB@yury-ThinkPad>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Sep 2023 16:28:21 +0200
Message-ID: <CAMRc=Mdj54vERK2O9p0Hkxq_H=UOs_Jo=NK5Xd5H3OKy0E-2vw@mail.gmail.com>
Subject: Re: [PATCH 1/4] bitmap: define a cleanup function for bitmaps
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 3:43=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Tue, Sep 12, 2023 at 10:55:38AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add support for autopointers for bitmaps allocated with bitmap_alloc()
> > et al.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  include/linux/bitmap.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > index 03644237e1ef..ba8c0d733842 100644
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -6,6 +6,7 @@
> >
> >  #include <linux/align.h>
> >  #include <linux/bitops.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/find.h>
> >  #include <linux/limits.h>
> >  #include <linux/string.h>
> > @@ -125,6 +126,8 @@ unsigned long *bitmap_alloc_node(unsigned int nbits=
, gfp_t flags, int node);
> >  unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int=
 node);
> >  void bitmap_free(const unsigned long *bitmap);
> >
> > +DEFINE_FREE(bitmap, unsigned long *, bitmap_free(_T))
>
> So now it doesn't do weird  "if (_T) bitmap_free(_T)". Have you got any
> feedback from Peter for that?
>

I did get feedback from Peter. Unfortunately it was right *after* I
sent this. Turns out the NULL-pointer check is there for a reason,
please see the comment in this patch:
https://lore.kernel.org/all/169451499208.27769.5856056754166699857.tip-bot2=
@tip-bot2/T/#u

That means I will have to resend this one.

Bart

> My point is that if the above is correct, all the following
> declarations need to be revisited:
>
> yury:linux$ git grep DEFINE_FREE|grep if
> include/linux/cleanup.h:25: * DEFINE_FREE(kfree, void *, if (_T) kfree(_T=
))
> include/linux/device.h:1058:DEFINE_FREE(device_del, struct device *, if (=
_T) device_del(_T))
> include/linux/device.h:1228:DEFINE_FREE(put_device, struct device *, if (=
_T) put_device(_T))
> include/linux/mutex.h:224:DEFINE_FREE(mutex, struct mutex *, if (_T) mute=
x_unlock(_T))
> include/linux/rwsem.h:208:DEFINE_FREE(up_read, struct rw_semaphore *, if =
(_T) up_read(_T))
> include/linux/rwsem.h:209:DEFINE_FREE(up_write, struct rw_semaphore *, if=
 (_T) up_write(_T))
> include/linux/sched/task.h:164:DEFINE_FREE(put_task, struct task_struct *=
, if (_T) put_task_struct(_T))
> include/linux/slab.h:231:DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
>
> For the patch:
> Acked-by: Yury Norov <yury.norov@gmail.com>
