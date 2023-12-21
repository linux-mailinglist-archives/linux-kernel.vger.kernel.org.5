Return-Path: <linux-kernel+bounces-8599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DADE081B9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B88A1C23A78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137BD55E77;
	Thu, 21 Dec 2023 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWkPBdTx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1564B13D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703170580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8eIz4f9p7CSrHkPxbwx9C5GZwRnjE0R1lz9iIAHGRA=;
	b=hWkPBdTxnyrRNpryCJHQJthAYlNj2Y4mqiy35XJDucZrxvaFOSx0O2wr5baYghHY+Ty697
	pxKPMc2oqaV+MV1kPJBGYuAaYkPhcrgIECDraE/5l8dYzKCNOAqcctW3O7A5xLHesA+3+D
	PcLkFTvZLTAQwXjE5ZJTHczLO6LGiGE=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-aJm-suPgMrOuIqi5dRh9gA-1; Thu, 21 Dec 2023 09:56:15 -0500
X-MC-Unique: aJm-suPgMrOuIqi5dRh9gA-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dbdd300d01bso205752276.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703170575; x=1703775375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8eIz4f9p7CSrHkPxbwx9C5GZwRnjE0R1lz9iIAHGRA=;
        b=Fe2saWMYwOuLmE5Bvw+eRfgdyrQkmQg27YGWiGw7yTPKVui9DgVWP6hazDYyoy/nOj
         2GqFnGbMR/pJI2t83t6I3YYDZgk5xwgesNbWWWwiNl+iV2BtMMkDd4q7/hXaHQlZaFdi
         GZoST/iaEmLFZ/t6pf6rtZlTmWpWUJcWpzwze4T/AKbH3ZnwIDdNIva7HGEQLGPvC3GH
         MYh82nhpcjdlyliZYvh6OMRThVOfaEsOwaCC/u252KRilRWeaU1/oppj+WAtNi0zhMlk
         OltPA0Zkx0YD3cCmYCenEzTU2w1DvE+ztawUpnPVWnZcIcOZoU6SSAUDaxhYottgNQwY
         pnSg==
X-Gm-Message-State: AOJu0YzsHrrXLp/gVj/ZLblySHfJnTKdw4NhTyQW0VWGgHrv9alPd864
	uHvrUsMM9bD4xYphskWaCV6vnJzOcNp1ZZl5QFr/+YwJ5VOhbboJH0jer7kYNPEVlncdC7r6Ean
	Vbv7yUuwTQLkHWmswxUIFXBvEeuRq71HMnPV+2hMU
X-Received: by 2002:a25:d88b:0:b0:dbd:11:5dee with SMTP id p133-20020a25d88b000000b00dbd00115deemr1311070ybg.37.1703170575142;
        Thu, 21 Dec 2023 06:56:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8jOlzMv0iYcVNkFXFgLaDs5GWBuNPYA3j97IaAxPd2JpsSU5V8zCmy+j79KFLQR0AlsT/6eD/52Y8Bkd+cQQ=
X-Received: by 2002:a25:d88b:0:b0:dbd:11:5dee with SMTP id p133-20020a25d88b000000b00dbd00115deemr1311052ybg.37.1703170574842;
 Thu, 21 Dec 2023 06:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-3-dtatulea@nvidia.com>
 <CACGkMEv7xQkZYJAgAUK6C3oUrZ9vuUJdTKRzihXcNPb-iWdpJw@mail.gmail.com>
 <CACGkMEsaaDGi63__YrvsTC1HqgTaEWHvGokK1bJS5+m1XYM-6w@mail.gmail.com>
 <CAJaqyWdoaj8a7q1KrGqWmkYvAw_R_p0utcWvDvkyVm1nUOAxrA@mail.gmail.com>
 <CACGkMEuM7bXxsxHUs_SodiDQ2+akrLqqzWZBJSZEcnMASUkb+g@mail.gmail.com>
 <CAJaqyWeBVVcTZEzZK=63Ymk85wnRFd+_wK56UfEHNXBH-qy1Zg@mail.gmail.com>
 <70adc734331c1289dceb3bcdc991f3da7e4db2f0.camel@nvidia.com>
 <CAJaqyWeUHiZXMFkNBpinCsJAXojtPkGz+SjzUNDPx5W=qqON1w@mail.gmail.com> <c03eb2bb3ad76e28be2bb9b9e4dee4c3bc062ea7.camel@nvidia.com>
In-Reply-To: <c03eb2bb3ad76e28be2bb9b9e4dee4c3bc062ea7.camel@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 21 Dec 2023 15:55:38 +0100
Message-ID: <CAJaqyWevZX5TKpaLiJwu2nD7PHFsHg+TEZ=iPdWvrH4jyPV+cA@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/15] vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND
 flag
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Parav Pandit <parav@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	"mst@redhat.com" <mst@redhat.com>, "leon@kernel.org" <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 3:38=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Thu, 2023-12-21 at 13:08 +0100, Eugenio Perez Martin wrote:
> > On Thu, Dec 21, 2023 at 12:52=E2=80=AFPM Dragos Tatulea <dtatulea@nvidi=
a.com> wrote:
> > >
> > > On Thu, 2023-12-21 at 08:46 +0100, Eugenio Perez Martin wrote:
> > > > On Thu, Dec 21, 2023 at 3:03=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Wed, Dec 20, 2023 at 9:32=E2=80=AFPM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, Dec 20, 2023 at 5:06=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 20, 2023 at 11:46=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Dec 20, 2023 at 2:09=E2=80=AFAM Dragos Tatulea <dta=
tulea@nvidia.com> wrote:
> > > > > > > > >
> > > > > > > > > The virtio spec doesn't allow changing virtqueue addresse=
s after
> > > > > > > > > DRIVER_OK. Some devices do support this operation when th=
e device is
> > > > > > > > > suspended. The VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSP=
END flag
> > > > > > > > > advertises this support as a backend features.
> > > > > > > >
> > > > > > > > There's an ongoing effort in virtio spec to introduce the s=
uspend state.
> > > > > > > >
> > > > > > > > So I wonder if it's better to just allow such behaviour?
> > > > > > >
> > > > > > > Actually I mean, allow drivers to modify the parameters durin=
g suspend
> > > > > > > without a new feature.
> > > > > > >
> > > > > >
> > > > > > That would be ideal, but how do userland checks if it can suspe=
nd +
> > > > > > change properties + resume?
> > > > >
> > > > > As discussed, it looks to me the only device that supports suspen=
d is
> > > > > simulator and it supports change properties.
> > > > >
> > > > > E.g:
> > > > >
> > > > > static int vdpasim_set_vq_address(struct vdpa_device *vdpa, u16 i=
dx,
> > > > >                                   u64 desc_area, u64 driver_area,
> > > > >                                   u64 device_area)
> > > > > {
> > > > >         struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> > > > >         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
> > > > >
> > > > >         vq->desc_addr =3D desc_area;
> > > > >         vq->driver_addr =3D driver_area;
> > > > >         vq->device_addr =3D device_area;
> > > > >
> > > > >         return 0;
> > > > > }
> > > > >
> > > >
> > > > So in the current kernel master it is valid to set a different vq
> > > > address while the device is suspended in vdpa_sim. But it is not va=
lid
> > > > in mlx5, as the FW will not be updated in resume (Dragos, please
> > > > correct me if I'm wrong). Both of them return success.
> > > >
> > > In the current state, there is no resume. HW Virtqueues will just get=
 re-created
> > > with the new address.
> > >
> >
> > Oh, then all of this is effectively transparent to the userspace
> > except for the time it takes?
> >
> Not quite: mlx5_vdpa_set_vq_address will save the vq address only on the =
SW vq
> representation. Only later will it will call into the FW to update the FW=
. Later
> means:
> - On DRIVER_OK state, when the VQs get created.
> - On .set_map when the VQs get re-created (before this series) / updated =
(after
> this series)
> - On .resume (after this series).
>
> So if the .set_vq_address is called when the VQ is in DRIVER_OK but not
> suspended those addresses will be set later for later.
>

Ouch, that is more in the line of my thoughts :(.

> > In that case you're right, we don't need feature flags. But I think it
> > would be great to also move the error return in case userspace tries
> > to modify vq parameters out of suspend state.
> >
> On the driver side or on the core side?
>

Core side.

It does not have to be part of this series, I meant it can be proposed
in a separate series and applied before the parent driver one.

> Thanks
> > Thanks!
> >
> >
> > > > How can we know in the destination QEMU if it is valid to suspend &
> > > > set address? Should we handle this as a bugfix and backport the
> > > > change?
> > > >
> > > > > >
> > > > > > The only way that comes to my mind is to make sure all parents =
return
> > > > > > error if userland tries to do it, and then fallback in userland=
.
> > > > >
> > > > > Yes.
> > > > >
> > > > > > I'm
> > > > > > ok with that, but I'm not sure if the current master & previous=
 kernel
> > > > > > has a coherent behavior. Do they return error? Or return succes=
s
> > > > > > without changing address / vq state?
> > > > >
> > > > > We probably don't need to worry too much here, as e.g set_vq_addr=
ess
> > > > > could fail even without suspend (just at uAPI level).
> > > > >
> > > >
> > > > I don't get this, sorry. I rephrased my point with an example earli=
er
> > > > in the mail.
> > > >
> > >
> >
>


