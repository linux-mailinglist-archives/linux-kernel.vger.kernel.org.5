Return-Path: <linux-kernel+bounces-299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 509FB813EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83F91F22C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A21650;
	Fri, 15 Dec 2023 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hzwGOXol"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A8620F8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50bce78f145so112177e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 17:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702602052; x=1703206852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeaw3ji0pg6zC2peZEVGQL9hjW+bOoI/oOULSseP2eQ=;
        b=hzwGOXolsVPC0dvo+rMI6/6DbZNOpzCbDFsy8Q1N97iUNkAxp+/zDGRvG21GzRYOKV
         /ACl2C9fDnUApnTEIANxgLjO5S0DW+bkv+adKveHNsGHTgllbHU8HmL/8yDcWSepsRB4
         6NM7/Fsew/9IT1ckPHDjfXsGV6FaLkI8RDzqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702602052; x=1703206852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeaw3ji0pg6zC2peZEVGQL9hjW+bOoI/oOULSseP2eQ=;
        b=ukJwMRmajAZQr9hi+b6epAwE1k8hoPn9hv6KpkJwqCzJAw6eHycwBTFGBL4QTd1/VJ
         WYp9gTupvcQ3z0PCjq0hvTOjpW0j+BkC0wRYALXX9mNUfuDJECVXs9npJaLr8VLqCWqR
         Mwqf3q8JKNJhzwUD1dxsXlWdqtgR5swcBqcBiTb8WOlcaDMDkhpoiQyc3PZojKPGx+i/
         mFbOtUVYRB7RABQBRVkEwzf+nSXadeLdMoN3DQRXEPfcirYpXZvfPqTeHgmplikD9cKW
         j3Zp3H+Jb1lr8WzkQebbrdVsjV027tLIj0k6XnJC3cQJlirlE7t3NXYXKeYcbAea72r5
         U/dQ==
X-Gm-Message-State: AOJu0Yz648y/AcoS6KbvsKUGiq4kwcV/UdrrOSJpKiTchvAJdfoIl9op
	hK/K1bXLpBwl9Twl/3P+kpHihBAwff/tTbtUuGMZqQ==
X-Google-Smtp-Source: AGHT+IE04S5Qh7uJe6rBqhFgzTVg8/E62kzoLJ68Pm4mv9JVFbY+sJs88Raftysa85n96dacTNvUxuni1E51J6YM/Kc=
X-Received: by 2002:a05:6512:3b8d:b0:50d:1487:8d11 with SMTP id
 g13-20020a0565123b8d00b0050d14878d11mr3154911lfv.144.1702602052113; Thu, 14
 Dec 2023 17:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208070754.3132339-1-stevensd@chromium.org> <9fb51bfc-576a-4c7b-92c2-c161e7f08ae7@redhat.com>
In-Reply-To: <9fb51bfc-576a-4c7b-92c2-c161e7f08ae7@redhat.com>
From: David Stevens <stevensd@chromium.org>
Date: Fri, 15 Dec 2023 10:00:41 +0900
Message-ID: <CAD=HUj6ZsZo_kxZazDDDUp61pEHupuf0Lf7WqkKBsMOA1CYcNQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 6:47=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 08.12.23 08:07, David Stevens wrote:
> > If a virtio_pci_device supports native PCI power management and has the
> > No_Soft_Reset bit set, then skip resetting and reinitializing the devic=
e
> > when suspending and restoring the device. This allows system-wide low
> > power states like s2idle to be used in systems with stateful virtio
> > devices that can't simply be re-initialized (e.g. virtio-fs).
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> > v1 -> v2:
> >   - Check the No_Soft_Reset bit
> >
> >   drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++=
-
> >   1 file changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio=
_pci_common.c
> > index c2524a7207cf..3a95ecaf12dc 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
> >       return virtio_device_restore(&vp_dev->vdev);
> >   }
> >
> > +static bool vp_supports_pm_no_reset(struct device *dev)
> > +{
> > +     struct pci_dev *pci_dev =3D to_pci_dev(dev);
> > +     u16 pmcsr;
> > +
> > +     if (!pci_dev->pm_cap)
> > +             return false;
> > +
> > +     pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmc=
sr);
> > +     if (PCI_POSSIBLE_ERROR(pmcsr)) {
> > +             dev_err(dev, "Unable to query pmcsr");
> > +             return false;
> > +     }
> > +
> > +     return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> > +}
> > +
> > +static int virtio_pci_suspend(struct device *dev)
> > +{
> > +     return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> > +}
> > +
> > +static int virtio_pci_resume(struct device *dev)
> > +{
> > +     return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev)=
;
> > +}
> > +
> >   static const struct dev_pm_ops virtio_pci_pm_ops =3D {
> > -     SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
> > +     .suspend =3D virtio_pci_suspend,
> > +     .resume =3D virtio_pci_resume,
> > +     .freeze =3D virtio_pci_freeze,
> > +     .thaw =3D virtio_pci_restore,
> > +     .poweroff =3D virtio_pci_freeze,
> > +     .restore =3D virtio_pci_restore,
> >   };
> >   #endif
> >
>
> Am I correct with my assumption that this will make s2idle work with virt=
io-mem-pci as well?
>
> Right now, all suspending is disabled, but really only s4/hibernate is pr=
oblematic.
>
> [root@vm-0 ~]# echo "s2idle" > /sys/power/mem_sleep
> [root@vm-0 ~]# echo "mem" > /sys/power/state
> [  101.822991] PM: suspend entry (s2idle)
> [  101.828978] Filesystems sync: 0.004 seconds
> [  101.831618] Freezing user space processes
> [  101.834569] Freezing user space processes completed (elapsed 0.001 sec=
onds)
> [  101.836915] OOM killer disabled.
> [  101.838072] Freezing remaining freezable tasks
> [  101.841054] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
> [  101.843538] printk: Suspending console(s) (use no_console_suspend to d=
ebug)
> [  101.957676] virtio_mem virtio0: save/restore not supported.
> [  101.957683] virtio-pci 0000:00:02.0: PM: pci_pm_suspend(): virtio_pci_=
freeze+0x0/0x50 returns -1
> [  101.957702] virtio-pci 0000:00:02.0: PM: dpm_run_callback(): pci_pm_su=
spend+0x0/0x170 returns -1
> [  101.957718] virtio-pci 0000:00:02.0: PM: failed to suspend async: erro=
r -1

QEMU's virtio-pci devices don't advertise no_soft_reset, so this patch
won't affect vanilla QEMU. But if you add PCI_PM_CTRL_NO_SOFT_RESET to
the capability, then it should work. I'm working with crosvm, which
doesn't have virtio-mem implemented, but this patch makes virtio-fs
work with no extra kernel changes.

-David

