Return-Path: <linux-kernel+bounces-86721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B2F86C9A0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C726D1C20C06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77867E0F4;
	Thu, 29 Feb 2024 13:01:23 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1C33FE;
	Thu, 29 Feb 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709211683; cv=none; b=dPQkIXjPnxP+0Vv/fPfT6tog2cCZKj3ijxuFaaGVtQN4vML6nkQ0ebXD+crtJpM4+mVDJmqkSHxpM4OlosHEdDft4stHHU2xMymNTpKVloQR+cDoYYi7ZV5JZjUvlBG8338SgqY2WD1Ghjy46MvmETci+cGuk1JjYYmTjRgIM/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709211683; c=relaxed/simple;
	bh=lMqrM9gYMNpSkF93F+HZGHWPCYKJY8hNtsupE3Iox4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rL/al8FawT3/1/LxAPBryXVJR4tWSsD/liPfCMcEKJiOmYA4l6QuIM8dAEdfFXipdrv7exfvYQjmN8c2+FukuWvWrFnOtRQi/U+UGbA7zeZPzLIj/9+y55j/1YOKQrqECscYSfFDvrqGh/FpSoD/qHnpHZ+51nXYkihq6OLI8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e45f7c63f4so88758a34.1;
        Thu, 29 Feb 2024 05:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709211680; x=1709816480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iMLcQ0gRcQTa5GCHQismTR06jDMxmx5ybe9Si/LvkM=;
        b=GKYjbV6v8pTCSrhQjI0cW4TaZ99cLFVWyO4MAjHNoLogmtXeW+Ki+H0ExIpBLU1Xp7
         bG9vemLhIRdyzaIG3sNmi+SrOWYjb/Quk+QrJXL7yTBiG9S3/pBOPB2d5IKAfZBNqgth
         MC0lU9std8PXsKKdcRusQHl5FCi4HEZj/ndY/hHKT5cXmro0aLjPd5MEjBNPb2j06HaY
         8EZHgWJ0Sk0PfN8csJwyhCTu5ee/iZLhRWLAY5+pKIgzmq1nUznwLB63v59narrHiD29
         4vGlzDyeYvIEHFIJyERYT/L9kQ9efsB9woWL3ncG/L/mANMmuQ2LGPCB3D82dx33lUx+
         QCDg==
X-Forwarded-Encrypted: i=1; AJvYcCXRxM1DaNKCoQJmx27W7tjc3NGfn5sji41IcxuSCiYI+a3OlOFqbE2KPnlNUUM+uE3hlwHWDQsuPsAVrpbkOBqutITB+0htiuj6nGlFvqo3ektwIlKOfNYq6/Rjfigc31miA+b0ZSSKTwo0vD9NH/JH2oJK/dXTlh2wRhfgOYydSg==
X-Gm-Message-State: AOJu0YyNmrEphJU6g99XJuWvYZ+Uel14zagZQWhISvnlEQTqlHDyho6v
	MPwyR9xfaJCtCCj8TqXSnFBOoCBDGdWSyMSkW8AYXHSpzm/o23Eyurxjh+xvf0gkDa6mDgxZrv0
	Uki0j9AJUxSkLICCnodfa6jeQwws=
X-Google-Smtp-Source: AGHT+IFXmjtRjpw9aUeeINGMuBRauYkXsJDiIT5AGWtbB1kIwpbPBTb/5/e9wLPNL8xXwmwQTeMb/kU2p+WqpskvYzA=
X-Received: by 2002:a4a:a543:0:b0:5a0:ec66:b56b with SMTP id
 s3-20020a4aa543000000b005a0ec66b56bmr1030953oom.0.1709211680321; Thu, 29 Feb
 2024 05:01:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229105204.720717-1-herve.codina@bootlin.com>
 <20240229105204.720717-2-herve.codina@bootlin.com> <9cc3d11bc3e1bb89a1c725f865d0c8d1494111c5.camel@gmail.com>
In-Reply-To: <9cc3d11bc3e1bb89a1c725f865d0c8d1494111c5.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 14:01:08 +0100
Message-ID: <CAJZ5v0hGfqrczS1Si8Bu67vTSkTKO_gO7ftO2R7CQxGKGWsbAA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Introduce device_link_wait_removal()
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
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

On Thu, Feb 29, 2024 at 12:13=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
>
> Hi,
>
> Just copy pasting my previous comments :)
>
> On Thu, 2024-02-29 at 11:52 +0100, Herve Codina wrote:
> > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > introduces a workqueue to release the consumer and supplier devices use=
d
> > in the devlink.
> > In the job queued, devices are release and in turn, when all the
> > references to these devices are dropped, the release function of the
> > device itself is called.
> >
> > Nothing is present to provide some synchronisation with this workqueue
> > in order to ensure that all ongoing releasing operations are done and
> > so, some other operations can be started safely.
> >
> > For instance, in the following sequence:
> >   1) of_platform_depopulate()
> >   2) of_overlay_remove()
> >
> > During the step 1, devices are released and related devlinks are remove=
d
> > (jobs pushed in the workqueue).
> > During the step 2, OF nodes are destroyed but, without any
> > synchronisation with devlink removal jobs, of_overlay_remove() can rais=
e
> > warnings related to missing of_node_put():
> >   ERROR: memory leak, expected refcount 1 instead of 2
> >
> > Indeed, the missing of_node_put() call is going to be done, too late,
> > from the workqueue job execution.
> >
> > Introduce device_link_wait_removal() to offer a way to synchronize
> > operations waiting for the end of devlink removals (i.e. end of
> > workqueue jobs).
> > Also, as a flushing operation is done on the workqueue, the workqueue
> > used is moved from a system-wide workqueue to a local one.
> >
> > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> >  include/linux/device.h |  1 +
> >  2 files changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d5f4e4aac09b..80d9430856a8 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> >  static void __fw_devlink_link_to_consumers(struct device *dev);
> >  static bool fw_devlink_drv_reg_done;
> >  static bool fw_devlink_best_effort;
> > +static struct workqueue_struct *device_link_wq;
> >
> >  /**
> >   * __fwnode_link_add - Create a link between two fwnode_handles.
> > @@ -532,12 +533,26 @@ static void devlink_dev_release(struct device *de=
v)
> >       /*
> >        * It may take a while to complete this work because of the SRCU
> >        * synchronization in device_link_release_fn() and if the consume=
r or
> > -      * supplier devices get deleted when it runs, so put it into the
> > "long"
> > -      * workqueue.
> > +      * supplier devices get deleted when it runs, so put it into the
> > +      * dedicated workqueue.
> >        */
> > -     queue_work(system_long_wq, &link->rm_work);
> > +     queue_work(device_link_wq, &link->rm_work);
> >  }
> >
> > +/**
> > + * device_link_wait_removal - Wait for ongoing devlink removal jobs to
> > terminate
> > + */
> > +void device_link_wait_removal(void)
> > +{
> > +     /*
> > +      * devlink removal jobs are queued in the dedicated work queue.
> > +      * To be sure that all removal jobs are terminated, ensure that a=
ny
> > +      * scheduled work has run to completion.
> > +      */
> > +     drain_workqueue(device_link_wq);
> > +}
>
> I'm still not convinced we can have a recursive call into devlinks remova=
l so I
> do think flush_workqueue() is enough. I will defer to Saravana though...

AFAICS, the difference betwee flush_workqueue() and drain_workqueue()
is the handling of the case when a given work item can queue up itself
again.  This does not happen here.

