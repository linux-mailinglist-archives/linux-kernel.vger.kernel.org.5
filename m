Return-Path: <linux-kernel+bounces-19784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB2D8273D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421E81C22D24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B95B53814;
	Mon,  8 Jan 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JwKUZj7o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6AC524A8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4b72c944019so484511e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 07:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704728393; x=1705333193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOJbSi5rNTjMHJMF5lMEiPd+GXhzy+vNHdpBCiGEhzo=;
        b=JwKUZj7oWgdMXLSKxW16NP93FDntTQXSMfSXfehzkgOQ5DWkLpb464jT9E9MiUWRVf
         LTO/5dfd4OzHhL5A4po/zfn6XXcUrqBZ1fxCRu+rUHSu5GzikhVd4EBq6ndsRcjyvWAR
         suyrQFaK6i+6aITUDtb+KPzxA5MM7h1DVL3oifC+AB3NkQEwIerHhto5qin4yY65WWoX
         8pQ04Tl9DaR9oXeIVyqQxdEr3jcBaZFXcCIMVoxnnw2MkTig3X8c/x/fFOWpez1+iPQP
         4Dv+mRXNwx1raZNwz7tmG7KDj8e6TMA9owmFehOBXlvTqh2edt+qnBQtGLJTtHCdNn+8
         oL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704728393; x=1705333193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOJbSi5rNTjMHJMF5lMEiPd+GXhzy+vNHdpBCiGEhzo=;
        b=qv4T5VbxVD6SsBB+oaGnz2AZrrw8d20x7GEeMcVSdXDwt/KlWN+xLqU1QRbJjt9dfk
         a90aeJBL69BMZieA2UTHv5RZo0115amysDoNAEd004TscPqB4O69MMu6bbBiF/r1Dwqo
         Lcbk5qHzL+6Mt3umzSX0rqDLckId6qjUEfWn+2Xa8vkPb6aSGyLoUAxOIOO/6n5vF5vR
         TdAPviZlhhpxuehNimATFdv3o3aFCu+C+4aySoT8dAM/kOrRuO90rdhJgkbYdT3xfEzS
         6QMcyM7zm8tTgJiJriAFpB8PSpe9eXb1jzD8YXN9cMcb1hUCeSxdnK1KGHqfGQBgaTLq
         u51Q==
X-Gm-Message-State: AOJu0YxekP1DMJgjmK0+w7T1butB+p7RaFaOhO3MYOh9LRadFJleNmQy
	s85ae+5/fKejyp/RkHHb+SbJIp1K6W2N1BLU2wJ9Ixmib6N14wRcOD6RIAki
X-Google-Smtp-Source: AGHT+IEXzfxEmWO3/tWR9nmj4EUSphBVdtQt7Noz+NC5+wWfuyb2uKGTlK89MCeD6645lTIuyBAXX+gEKP8BJcLiGic=
X-Received: by 2002:a05:6122:3a16:b0:4b7:17ae:747d with SMTP id
 fp22-20020a0561223a1600b004b717ae747dmr1208222vkb.22.1704728393280; Mon, 08
 Jan 2024 07:39:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102155949.73434-1-brgl@bgdev.pl> <CGME20240108130315eucas1p1ecb6dbf60f9b796c3c678c889371a747@eucas1p1.samsung.com>
 <20240102155949.73434-4-brgl@bgdev.pl> <32c76177-83c1-48c5-8198-b7347b83d5db@samsung.com>
In-Reply-To: <32c76177-83c1-48c5-8198-b7347b83d5db@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 8 Jan 2024 16:39:42 +0100
Message-ID: <CAMRc=MfAbgApC5nXjqvyRi9k_Zx9N_n8g-d5sGO-WR4mHn=LBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpiolib: pin GPIO devices in place during
 descriptor lookup
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 2:03=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 02.01.2024 16:59, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > There's time between when we locate the relevant descriptor during
> > lookup and when we actually take the reference to its parent GPIO
> > device where - if the GPIO device in question is removed - we'll end up
> > with a dangling pointer to freed memory. Make sure devices cannot be
> > removed until we hold a new reference to the device.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This patch landed in linux-next as commit db660b9a9f86 ("gpiolib: pin
> GPIO devices in place during descriptor lookup"). Unfortunately it
> introduces a following lock-dep warning:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: possible recursive locking detected
> 6.7.0-rc7-00062-gdb660b9a9f86 #7819 Not tainted
> --------------------------------------------
> kworker/u4:2/27 is trying to acquire lock:
> c13f4e1c (gpio_devices_sem){++++}-{3:3}, at: gpio_device_find+0x30/0x94
>
> but task is already holding lock:
> c13f4e1c (gpio_devices_sem){++++}-{3:3}, at:
> gpiod_find_and_request+0x44/0x594
>
> other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(gpio_devices_sem);
>    lock(gpio_devices_sem);
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
> 4 locks held by kworker/u4:2/27:
>   #0: c1c06ca8 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
> process_one_work+0x148/0x608
>   #1: e093df20 ((work_completion)(&entry->work)){+.+.}-{0:0}, at:
> process_one_work+0x148/0x608
>   #2: c1f3048c (&dev->mutex){....}-{3:3}, at:
> __driver_attach_async_helper+0x38/0xec
>   #3: c13f4e1c (gpio_devices_sem){++++}-{3:3}, at:
> gpiod_find_and_request+0x44/0x594
>
> stack backtrace:
> CPU: 0 PID: 27 Comm: kworker/u4:2 Not tainted
> 6.7.0-rc7-00062-gdb660b9a9f86 #7819
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: events_unbound async_run_entry_fn
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x58/0x70
>   dump_stack_lvl from __lock_acquire+0x1300/0x2984
>   __lock_acquire from lock_acquire+0x130/0x37c
>   lock_acquire from down_read+0x44/0x224
>   down_read from gpio_device_find+0x30/0x94
>   gpio_device_find from of_get_named_gpiod_flags+0xa4/0x3a8
>   of_get_named_gpiod_flags from of_find_gpio+0x80/0x168
>   of_find_gpio from gpiod_find_and_request+0x120/0x594
>   gpiod_find_and_request from gpiod_get_optional+0x54/0x90
>   gpiod_get_optional from reg_fixed_voltage_probe+0x200/0x400
>   reg_fixed_voltage_probe from platform_probe+0x5c/0xb8
>   platform_probe from really_probe+0xe0/0x400
>   really_probe from __driver_probe_device+0x9c/0x1f0
>   __driver_probe_device from driver_probe_device+0x30/0xc0
>   driver_probe_device from __driver_attach_async_helper+0x54/0xec
>   __driver_attach_async_helper from async_run_entry_fn+0x40/0x154
>   async_run_entry_fn from process_one_work+0x204/0x608
>   process_one_work from worker_thread+0x1e0/0x498
>   worker_thread from kthread+0x104/0x138
>   kthread from ret_from_fork+0x14/0x28
> Exception stack(0xe093dfb0 to 0xe093dff8)
> ...
>
>
> Taking gpio_devices_sem more than once for reading is safe, but it looks
> that it needs some lock-dep annotations to to make it happy and avoid
> the above warning.
>
>
> > ---
> >   drivers/gpio/gpiolib.c | 40 +++++++++++++++++++++++-----------------
> >   1 file changed, 23 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index 4c93cf73a826..be57f8d6aeae 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -4134,27 +4134,33 @@ static struct gpio_desc *gpiod_find_and_request=
(struct device *consumer,
> >       struct gpio_desc *desc;
> >       int ret;
> >
> > -     desc =3D gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, &fla=
gs, &lookupflags);
> > -     if (gpiod_not_found(desc) && platform_lookup_allowed) {
> > +     scoped_guard(rwsem_read, &gpio_devices_sem) {
> > +             desc =3D gpiod_find_by_fwnode(fwnode, consumer, con_id, i=
dx,
> > +                                         &flags, &lookupflags);
> > +             if (gpiod_not_found(desc) && platform_lookup_allowed) {
> > +                     /*
> > +                      * Either we are not using DT or ACPI, or their l=
ookup
> > +                      * did not return a result. In that case, use pla=
tform
> > +                      * lookup as a fallback.
> > +                      */
> > +                     dev_dbg(consumer,
> > +                             "using lookup tables for GPIO lookup\n");
> > +                     desc =3D gpiod_find(consumer, con_id, idx, &looku=
pflags);
> > +             }
> > +
> > +             if (IS_ERR(desc)) {
> > +                     dev_dbg(consumer, "No GPIO consumer %s found\n",
> > +                             con_id);
> > +                     return desc;
> > +             }
> > +
> >               /*
> > -              * Either we are not using DT or ACPI, or their lookup di=
d not
> > -              * return a result. In that case, use platform lookup as =
a
> > -              * fallback.
> > +              * If a connection label was passed use that, else attemp=
t to
> > +              * use the device name as label
> >                */
> > -             dev_dbg(consumer, "using lookup tables for GPIO lookup\n"=
);
> > -             desc =3D gpiod_find(consumer, con_id, idx, &lookupflags);
> > +             ret =3D gpiod_request(desc, label);
> >       }
> >
> > -     if (IS_ERR(desc)) {
> > -             dev_dbg(consumer, "No GPIO consumer %s found\n", con_id);
> > -             return desc;
> > -     }
> > -
> > -     /*
> > -      * If a connection label was passed use that, else attempt to use
> > -      * the device name as label
> > -      */
> > -     ret =3D gpiod_request(desc, label);
> >       if (ret) {
> >               if (!(ret =3D=3D -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXC=
LUSIVE))
> >                       return ERR_PTR(ret);
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Thanks for the report. I think it may have come too late in the
release cycle as it has the potential to break a lot of things. I will
back it out of my for-next branch. I'll resend it for v6.9.

Bart

