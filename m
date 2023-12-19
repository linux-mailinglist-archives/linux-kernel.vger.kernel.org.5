Return-Path: <linux-kernel+bounces-5394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2526818A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE241C248B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B9B1D548;
	Tue, 19 Dec 2023 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WDxRS0z7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3581D522
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cc6ea4452cso31295211fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702996639; x=1703601439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iVTm9oZMtqSZBwJqdXJb3hYZoPtCTwqTZfX2l30DHE=;
        b=WDxRS0z7FMZPbZFRFQveKG6oIfR+CLw9BZoAPROsOa+Pn938Z1MysjsKXfyoavTBbc
         yrQtGOlmzPTBEqpFu1JCcewIotAl+vrYETA8y5931iF4VceU16Fklp2HWMt2y3i/5p/J
         KdWOx7Tp0T1FM1+tGKgIGwYDW7u233T16n9IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702996639; x=1703601439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iVTm9oZMtqSZBwJqdXJb3hYZoPtCTwqTZfX2l30DHE=;
        b=AvS3UorxXcS+tL8HAB5QZNz6KPLM32PPA/VcubWklTmF5A9yVRsGjHUnB1RIP0PxMk
         36TRmQnxy9TscBp/2cAoK3S4HxizxHg5ofcOlOiBtU63/jWiZsnyx0p3on8PWnLrHYCt
         1hEqI1mTHpmBmdM1OUL90cmyCXl9Giz4xqeYxfjS2ryJ2Bl8rflwxyJ3RD8f+2LcQmu7
         wRCljcn3s5sQAM1+sVxF07+sapKKiaHDv6N39CcijvLkvfOHiEh5eb0Rs0rMP9l7j440
         Yhlw9bESO6nw/Mb/v6vHJvpRRuosGnnDXjN+tMVQ/KnZ5uLjJ3OX7GmYSC5mmpGObqbi
         kH8g==
X-Gm-Message-State: AOJu0Yz7ECq2hX6FdJGKOdDDzNbF7FtFL4fuecnUz0nEEq4XPkSl7CuM
	TOcTeKxHxhCWku5DAnNLg7ijOeTRn3x40XxO5Hh9TJPiE2W6YEx3xWE=
X-Google-Smtp-Source: AGHT+IF+H7kOVCN0x8tihXqTBGeYLFioCMUVffwheMbHBbtqT5BVKyYtINt45F1GTcg91mvhaJk51Q85tOmD548iLIo=
X-Received: by 2002:a2e:be8b:0:b0:2cc:6bf0:8ee with SMTP id
 a11-20020a2ebe8b000000b002cc6bf008eemr2117097ljr.81.1702996638780; Tue, 19
 Dec 2023 06:37:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218151842.2756673-1-stevensd@google.com> <aae229d7-0675-47c5-9a02-5ba0b6a64906@redhat.com>
In-Reply-To: <aae229d7-0675-47c5-9a02-5ba0b6a64906@redhat.com>
From: David Stevens <stevensd@chromium.org>
Date: Tue, 19 Dec 2023 09:37:07 -0500
Message-ID: <CAD=HUj4jzxVB3=9kYVr+Y+3Ef2EUVztA4aVOXvha2zsCyzDGQQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_balloon: stay awake while adjusting balloon
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:33=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 18.12.23 16:18, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > A virtio_balloon's parent device may be configured so that a
> > configuration change interrupt is a wakeup event. Extend the processing
> > of such a wakeup event until the balloon finishes inflating or deflatin=
g
> > by calling pm_stay_awake/pm_relax in the virtio_balloon driver. Note
> > that these calls are no-ops if the parent device doesn't support wakeup
> > events or if the wakeup events are not enabled.
> >
> > This change allows the guest to use system power states such as s2idle
> > without running the risk the virtio_balloon's cooperative memory
> > management becoming unresponsive to the host's requests.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> > v1 -> v2:
> >   - Use adjustment_signal_pending flag instead of a sequence number
> >   - Call pm_stay_awake/pm_relax on parent device instead of adding a wa=
ke
> >     event to the virtio balloon device
> >
> >   drivers/virtio/virtio_balloon.c | 57 +++++++++++++++++++++++++++-----=
-
> >   1 file changed, 47 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> > index 1fe93e93f5bc..a3c11159cbe0 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -119,6 +119,11 @@ struct virtio_balloon {
> >       /* Free page reporting device */
> >       struct virtqueue *reporting_vq;
> >       struct page_reporting_dev_info pr_dev_info;
> > +
> > +     /* State for keeping the wakeup_source active while adjusting the=
 balloon */
> > +     spinlock_t adjustment_lock;
> > +     bool adjustment_signal_pending;
> > +     bool adjustment_in_progress;
> >   };
> >
> >   static const struct virtio_device_id id_table[] =3D {
> > @@ -437,6 +442,31 @@ static void virtio_balloon_queue_free_page_work(st=
ruct virtio_balloon *vb)
> >       queue_work(vb->balloon_wq, &vb->report_free_page_work);
> >   }
> >
> > +static void start_update_balloon_size(struct virtio_balloon *vb)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&vb->adjustment_lock, flags);
> > +     vb->adjustment_signal_pending =3D true;
> > +     if (!vb->adjustment_in_progress) {
> > +             vb->adjustment_in_progress =3D true;
> > +             pm_stay_awake(vb->vdev->dev.parent);
> > +     }
> > +     spin_unlock_irqrestore(&vb->adjustment_lock, flags);
> > +
> > +     queue_work(system_freezable_wq, &vb->update_balloon_size_work);
> > +}
> > +
> > +static void end_update_balloon_size(struct virtio_balloon *vb)
> > +{
> > +     spin_lock(&vb->adjustment_lock);
> > +     if (!vb->adjustment_signal_pending && vb->adjustment_in_progress)=
 {
>
> How could vb->adjustment_in_progress ever not be set at this point?
>
> > +             vb->adjustment_in_progress =3D false;
> > +             pm_relax(vb->vdev->dev.parent);
> > +     }
> > +     spin_unlock(&vb->adjustment_lock);
> > +}
> > +
>
> LGTM, although I wonder what happens when calling pm_stay_awake() etc.
> on a parent device that is not wakeup-even-capable?

If the parent device is not wakeup capable or if wakeup isn't enabled,
then the vb->vdev->dev.parent->power.wakeup pointer will be NULL, so
the NULL checks in __pm_relax/__pm_stay_awake will immediately return.

-David

