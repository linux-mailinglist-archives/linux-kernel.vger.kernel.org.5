Return-Path: <linux-kernel+bounces-93945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF3C873754
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90A91C21DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FA2130AED;
	Wed,  6 Mar 2024 13:05:51 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632E812C53E;
	Wed,  6 Mar 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730351; cv=none; b=srodtKYwc1L+IqTHSpstMllL0wNI93mH5BVn71F5JAYSJcTIZDfQfYRxNVLCu1rjF/K0Hi49/NNpcqBvFAkhbw5MFbGBQzSanLvbI8cJKiTsU+sR1YWiae0KGkdAuVQw5Fbk397VEE1A6g6mgD7h5UNcgxIxphKFgj9eqdk7qeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730351; c=relaxed/simple;
	bh=8uc1R+slg/97k/IQYzXJlpNpHvL5yYvzn94i0APTfU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOhZ8aQprZUVxf+ZF2ZDKhv5ejDpwv6TJH/S1RlQl/X+OPst3bND2aMwIZoo7E+tIK9HIHyJTA2GrYgJyEFP91hJV0IyoNrpr7s+eryRAn3w+3NwM9h3jpjf4HpVKcAUvegXwmrmFGFHxABKX4a6fG5zB6Ul4n/SRjfWhv0ee5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a13ecfb6b8so307169eaf.1;
        Wed, 06 Mar 2024 05:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730348; x=1710335148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEhriZi3EhlptrvY3zDnSYlGkdTq8xk82JatT/h3VxM=;
        b=By0rNVn51Ndv7cFzSFFmuxlRocMUFtafXnVmpA5joy3oPRpzk+6vxQdeprDG08hm6M
         Dk+Xx6jk1j2KbZ3W9WBpq6ZWAybClW+DTN6foQG82zgEgK/B7VH8EBywvLpFQ9NI/rN1
         UzEQou5sMqWi0L88e8pyS/xG/2IdkCgOEx0I+evnvSN6fZKPMkoP+gw0d/DMVJ/SQZKw
         EHoLIqNJeiY+Qngegs8TngJNPyy5t648TkvttutRKRri1Lw1h6t2P3FzHX/HVmT8Q9RK
         0lfCukvteKwLyCCovyE/Ef9S9EvqyN+J8891ORRV1iLopCuTvj/spic6FcY+Dg6jO0uL
         GApA==
X-Forwarded-Encrypted: i=1; AJvYcCUrKeLWy5mKcyUPWlPvAwK6xkAWuqB3qH74tg4pfJinVgNHs1jyh4tPcbH0p4hat0gwsYJDAPlWsev8pJA3FQUX893DaAu7D546u1qdfnn8sH7tUW6K+dCiG8Oy7PV3sq/sZamX4bDh3UwLXCqPXjiw6IJFY1Cu83KqK8krRP/yyg==
X-Gm-Message-State: AOJu0Ywt9DU/BHNPkv+NbYByVSPnCN8vZ6Ia9CxswP5QGvlO4zYMUpp+
	e6F5gruDUBy39zUmwhayGl5gp5HN0Ik6m5G916qyA+bIz8m6BkrNMrCDX8GQ5st/FU94vvm1Gdb
	cfltSjcOrTjO+4N0BOU1T1xwxBhA=
X-Google-Smtp-Source: AGHT+IFI0PZyOmJYzDvNd76NT02uWYi+e3g17uo4elnzoibUKltLzsJf0CvD0b0XCA5BComTmd/+bndxC06NwmpC/bc=
X-Received: by 2002:a05:6870:d0d3:b0:221:3b96:4e84 with SMTP id
 k19-20020a056870d0d300b002213b964e84mr3529472oaa.5.1709730348309; Wed, 06 Mar
 2024 05:05:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085007.169771-1-herve.codina@bootlin.com>
 <20240306085007.169771-2-herve.codina@bootlin.com> <1fff8742a13c28dd7e1dda47ad2d6fa8e21e421e.camel@gmail.com>
 <CAJZ5v0gWCo9nDAHkzeD08tTKoE0DE0ocht-Qq4zA7P59y9KeuQ@mail.gmail.com> <ed442b6916016b3a40782dc32538fc517715db6c.camel@gmail.com>
In-Reply-To: <ed442b6916016b3a40782dc32538fc517715db6c.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Mar 2024 14:05:36 +0100
Message-ID: <CAJZ5v0iQNEj6e_L1=uBTPaWn7BqV4pnoWxUq7LRPe5iVWsaifw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] driver core: Introduce device_link_wait_removal()
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Saravana Kannan <saravanak@google.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 2:01=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
>
> On Wed, 2024-03-06 at 13:43 +0100, Rafael J. Wysocki wrote:
> > On Wed, Mar 6, 2024 at 10:17=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail=
com> wrote:
> > >
> > > On Wed, 2024-03-06 at 09:50 +0100, Herve Codina wrote:
> > > > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > > > introduces a workqueue to release the consumer and supplier devices=
 used
> > > > in the devlink.
> > > > In the job queued, devices are release and in turn, when all the
> > > > references to these devices are dropped, the release function of th=
e
> > > > device itself is called.
> > > >
> > > > Nothing is present to provide some synchronisation with this workqu=
eue
> > > > in order to ensure that all ongoing releasing operations are done a=
nd
> > > > so, some other operations can be started safely.
> > > >
> > > > For instance, in the following sequence:
> > > >   1) of_platform_depopulate()
> > > >   2) of_overlay_remove()
> > > >
> > > > During the step 1, devices are released and related devlinks are re=
moved
> > > > (jobs pushed in the workqueue).
> > > > During the step 2, OF nodes are destroyed but, without any
> > > > synchronisation with devlink removal jobs, of_overlay_remove() can =
raise
> > > > warnings related to missing of_node_put():
> > > >   ERROR: memory leak, expected refcount 1 instead of 2
> > > >
> > > > Indeed, the missing of_node_put() call is going to be done, too lat=
e,
> > > > from the workqueue job execution.
> > > >
> > > > Introduce device_link_wait_removal() to offer a way to synchronize
> > > > operations waiting for the end of devlink removals (i.e. end of
> > > > workqueue jobs).
> > > > Also, as a flushing operation is done on the workqueue, the workque=
ue
> > > > used is moved from a system-wide workqueue to a local one.
> > > >
> > > > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > ---
> > >
> > > With the below addressed:
> > >
> > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > >
> > > >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> > > >  include/linux/device.h |  1 +
> > > >  2 files changed, 24 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index d5f4e4aac09b..48b28c59c592 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> > > >  static void __fw_devlink_link_to_consumers(struct device *dev);
> > > >  static bool fw_devlink_drv_reg_done;
> > > >  static bool fw_devlink_best_effort;
> > > > +static struct workqueue_struct *device_link_wq;
> > > >
> > > >  /**
> > > >   * __fwnode_link_add - Create a link between two fwnode_handles.
> > > > @@ -532,12 +533,26 @@ static void devlink_dev_release(struct device=
 *dev)
> > > >       /*
> > > >        * It may take a while to complete this work because of the S=
RCU
> > > >        * synchronization in device_link_release_fn() and if the con=
sumer
> > > > or
> > > > -      * supplier devices get deleted when it runs, so put it into =
the
> > > > "long"
> > > > -      * workqueue.
> > > > +      * supplier devices get deleted when it runs, so put it into =
the
> > > > +      * dedicated workqueue.
> > > >        */
> > > > -     queue_work(system_long_wq, &link->rm_work);
> > > > +     queue_work(device_link_wq, &link->rm_work);
> > > >  }
> > > >
> > > > +/**
> > > > + * device_link_wait_removal - Wait for ongoing devlink removal job=
s to
> > > > terminate
> > > > + */
> > > > +void device_link_wait_removal(void)
> > > > +{
> > > > +     /*
> > > > +      * devlink removal jobs are queued in the dedicated work queu=
e.
> > > > +      * To be sure that all removal jobs are terminated, ensure th=
at any
> > > > +      * scheduled work has run to completion.
> > > > +      */
> > > > +     flush_workqueue(device_link_wq);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > > > +
> > > >  static struct class devlink_class =3D {
> > > >       .name =3D "devlink",
> > > >       .dev_groups =3D devlink_groups,
> > > > @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> > > >       sysfs_dev_char_kobj =3D kobject_create_and_add("char", dev_ko=
bj);
> > > >       if (!sysfs_dev_char_kobj)
> > > >               goto char_kobj_err;
> > > > +     device_link_wq =3D alloc_workqueue("device_link_wq", 0, 0);
> > > > +     if (!device_link_wq)
> > > > +             goto wq_err;
> > > >
> > >
> > > I can't still agree with this. Why not doing it in devlink_class_init=
()?
> > > This is
> > > devlink specific so it makes complete sense to me.
> >
> > If you do that in devlink_class_init() and it fails, you essentially
> > cause the creation of every device link to fail.  IOW, you try to live
> > without device links and pretend that it is all OK.  That won't get
> > you very far, especially on systems where DT is used.
> >
> > Doing it here, if it fails, you prevent the driver model from working
> > at all (because one of its necessary components is unavailable), which
> > arguably is a better choice.
>
> That makes sense but then the only thing I still don't fully get is why w=
e have
> a separate devlink_class_init() initcall for registering the devlink clas=
s
> (which can also fail)...

Well, I haven't added it. :-)

> What I take from the above is that we should fail the
> driver model if one of it's fundamental components fails so I would say w=
e
> should merge devlink_class_init() with device_init() otherwise it's a bit
> confusing (at least to me) and gives the idea that it's ok for the driver=
 model
> to exist without the links (unless I'm missing some other reason for the =
devlink
> init function).

+1

Feel free to send a patch along these lines, chances are that it will
be popular. ;-)

