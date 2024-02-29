Return-Path: <linux-kernel+bounces-86719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C50C86C996
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2C51F2438A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196F57E0F3;
	Thu, 29 Feb 2024 12:57:22 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3C7D410;
	Thu, 29 Feb 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709211441; cv=none; b=fCpqb+BS/rJrMlGfaFohDHfBneZ8wn+0QEv3GCJciC6OPussRn+4oRDurhcRfwcMLp3AWnikVyB5pFpXXPwaRejMWp1MX5SPrLFcmj5gwwi1LQTDTswU6n/nonEOQBQF3eoUEwulC0xbFgxp2vwiitxXPLgCO8b98fJp77b5MCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709211441; c=relaxed/simple;
	bh=NV3Lexd1I215GFCfOKf6e+kUNlEsB4HcsnZBbnMzknI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYBUq0HtSDmhfFvO2lhKyZv9y3+4r2BdP6wIftypO07chqRDbzjfke0YCoDAkDcJVeojvqb6dslFcbi0nVrTM/nxolLh8UohFUxD1VpQwpDMMgL2oGJDxGwB4l0dI6D0SA2XWA1MxNcwLAZ4FA25E9sQ72ms/0swqJXQ6GjTvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a04665952eso7716eaf.1;
        Thu, 29 Feb 2024 04:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709211439; x=1709816239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmxLHqXEDN1UeIR2OAQOlz0mDPHOUy1z0W0gmKcx3LM=;
        b=gg6zkeax6QsIDYSiZxvLUXT1C+zznxF2i/12F3T09DQX9OJ/r+heeDCC5CS8W1Us4s
         4MRtN4ZnPU5EtZ5oR/tyaCFWHDoTMhOK8c9roQ0VdSO3EocvY65pF7V0agT2/wAesL1S
         79pKHYsOFPdVjTUp6S2BYLBwwL2HQKI19WmNAyX1AJkW8EYEiXb9EQwKqIjhpLbJoNCh
         FFhpGd163jxUUD1k7JgAb5F8+7NaltAohxdgmSyZkBURXtf3nKscV5fucHZt5ITlKCDV
         dcDwg+Wpa25u5Z8vJf8cbZ5z5ifPMDoWV2rp6Lrci7CBV7hz4sJukrdtgQ9tuImTMDHn
         sJng==
X-Forwarded-Encrypted: i=1; AJvYcCUst4duC1/5xA/viiQZ69EQsG+L7MkbJMYeUHyiC6Uz7q+vGzHqVj0WgBovyJVIWolTqw4illWOeVLNeqc8TXAFsaaQfgriMzZp/eHyb4SaeEC5IvIjIhMXjK6KUuGXIvInQAL2D2R/XPq59VEtOIGlxfsg9g7/4a8HE5HQlCB64Q==
X-Gm-Message-State: AOJu0Yy4PCIwphbu1YENBEoNB1CDJu4/xmjZAnWgI7hPi7TmcP9s7AbD
	pkuSfwrDcUqQ36EITwc+qu+K1wtFnrCVn1DkwDjXZoKmHOGulux26Ga69xAKlodQxiF09OMjAm8
	QjcJfg77YBL0mPiiPmhLGLUYs1SHN519N
X-Google-Smtp-Source: AGHT+IGED+M5hFzTkwZYRVdQHZ8ABuM4bQYwA4kCbUfVaiZ5BhWxbJYorfpzyQC0QmeWmWRaMozuorYlfBG1jlNYNWo=
X-Received: by 2002:a4a:625e:0:b0:5a0:4d78:975d with SMTP id
 y30-20020a4a625e000000b005a04d78975dmr1990060oog.1.1709211439116; Thu, 29 Feb
 2024 04:57:19 -0800 (PST)
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
Date: Thu, 29 Feb 2024 13:57:07 +0100
Message-ID: <CAJZ5v0iNiRKo=sem_OmwTxnkSz-raWOk0vKVuHQc31Q9r+D1UA@mail.gmail.com>
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
>
> > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > +
> >  static struct class devlink_class =3D {
> >       .name =3D "devlink",
> >       .dev_groups =3D devlink_groups,
> > @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> >       sysfs_dev_char_kobj =3D kobject_create_and_add("char", dev_kobj);
> >       if (!sysfs_dev_char_kobj)
> >               goto char_kobj_err;
> > +     device_link_wq =3D alloc_workqueue("device_link_wq", 0, 0);
> > +     if (!device_link_wq)
> > +             goto wq_err;
> >
>
> I still think this makes more sense in devlink_class_init() as this reall=
y
> device link specific. Moreover, as I said to Saravana, we need to "convin=
ce"
> Rafael about this as he (in my series) did not agreed with erroring out i=
n case
> we fail to allocate the queue.
>
> Rafael?

I don't really think it matters in practice, so this is fine with me too.

