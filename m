Return-Path: <linux-kernel+bounces-7741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FF881AC7B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5462A282A15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DA64A20;
	Thu, 21 Dec 2023 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAPL8Jwg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DC4685
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703124199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVgqAvwwX5PZ+K0StsYhb5ohbh7FF/syTZKMQDbQ9v4=;
	b=jAPL8Jwg23l7HJeW1GkOm9ldKLhHBOPycIPxQrjyJAdBAZHBtGulL2nDEB4WIkq3CNuJMi
	hKzoKRfR8+Ta6cq5fYmwAFswQ2YXQjfFYVg0V2ujzRyF1uy6KVPmyjMMf4iA2lPwr4w7sS
	i99Xx77kwoH43jTGAIGrQR2TilxqX5o=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-nXHPj2HIO5qztw95hNczLg-1; Wed, 20 Dec 2023 21:03:17 -0500
X-MC-Unique: nXHPj2HIO5qztw95hNczLg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d8d059a790so369040b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 18:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703124196; x=1703728996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVgqAvwwX5PZ+K0StsYhb5ohbh7FF/syTZKMQDbQ9v4=;
        b=EGBcR6SsK5Nc4niJ3SLJ96nQlFzvUWtgwQuNHUp/30g/nSzNx8aqMKFe69rvjziu7G
         +2zVqPP3M8AGvzpVOLjPvAgDj9rH2Zcyo/Aw6QLCAc+5k4AIchNbqLw4ZgfEdffMpHWw
         nuCTfPixyrNnReQkKrvHxI3T09t581dLOFitAMCxBU3nGK+120+lzW0T2wBuX+qcrJm4
         9HkuWNLOB/9R4AXDbolFwW/XDnAXSJnCfnfK/untCStzhT4L8dT1VtyAKOT7ttTLY35S
         S/L0G6Hx8eZB3hQZVkeFGsp4e645gfvq9+uejKxriDIRZsBqUc9YHGidaGUa6uMYJ5cN
         EgkA==
X-Gm-Message-State: AOJu0Yx4XBLq75KJCCb5LyqOzXXYjFf1X2w/0acHKlwQeDm8WxZkyW1Z
	mJIp4b5ctGmiiBtjks6cShoHcFlJTu322hJ/gyGEiEA3xZEZReN2mLcoIg0xPfwz2ShYTOgjepy
	netvQg8cdDLMGOM0e45LBfASI4sI5/W8Mk5EOZSEk
X-Received: by 2002:a05:6a00:708:b0:6d9:46f4:4226 with SMTP id 8-20020a056a00070800b006d946f44226mr2361713pfl.20.1703124196278;
        Wed, 20 Dec 2023 18:03:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/KGKYSCtd/fkWAWhBJnYkjiak2fMrNDbFAXlC8oYYs9VT364GRHf9AqL3ddt2MNKwq9lVLHfwyUtJQ0JG1u4=
X-Received: by 2002:a05:6a00:708:b0:6d9:46f4:4226 with SMTP id
 8-20020a056a00070800b006d946f44226mr2361704pfl.20.1703124196001; Wed, 20 Dec
 2023 18:03:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-3-dtatulea@nvidia.com>
 <CACGkMEv7xQkZYJAgAUK6C3oUrZ9vuUJdTKRzihXcNPb-iWdpJw@mail.gmail.com>
 <CACGkMEsaaDGi63__YrvsTC1HqgTaEWHvGokK1bJS5+m1XYM-6w@mail.gmail.com> <CAJaqyWdoaj8a7q1KrGqWmkYvAw_R_p0utcWvDvkyVm1nUOAxrA@mail.gmail.com>
In-Reply-To: <CAJaqyWdoaj8a7q1KrGqWmkYvAw_R_p0utcWvDvkyVm1nUOAxrA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Dec 2023 10:03:05 +0800
Message-ID: <CACGkMEuM7bXxsxHUs_SodiDQ2+akrLqqzWZBJSZEcnMASUkb+g@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/15] vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND
 flag
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 9:32=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Dec 20, 2023 at 5:06=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Dec 20, 2023 at 11:46=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Wed, Dec 20, 2023 at 2:09=E2=80=AFAM Dragos Tatulea <dtatulea@nvid=
ia.com> wrote:
> > > >
> > > > The virtio spec doesn't allow changing virtqueue addresses after
> > > > DRIVER_OK. Some devices do support this operation when the device i=
s
> > > > suspended. The VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND flag
> > > > advertises this support as a backend features.
> > >
> > > There's an ongoing effort in virtio spec to introduce the suspend sta=
te.
> > >
> > > So I wonder if it's better to just allow such behaviour?
> >
> > Actually I mean, allow drivers to modify the parameters during suspend
> > without a new feature.
> >
>
> That would be ideal, but how do userland checks if it can suspend +
> change properties + resume?

As discussed, it looks to me the only device that supports suspend is
simulator and it supports change properties.

E.g:

static int vdpasim_set_vq_address(struct vdpa_device *vdpa, u16 idx,
                                  u64 desc_area, u64 driver_area,
                                  u64 device_area)
{
        struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
        struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];

        vq->desc_addr =3D desc_area;
        vq->driver_addr =3D driver_area;
        vq->device_addr =3D device_area;

        return 0;
}

>
> The only way that comes to my mind is to make sure all parents return
> error if userland tries to do it, and then fallback in userland.

Yes.

> I'm
> ok with that, but I'm not sure if the current master & previous kernel
> has a coherent behavior. Do they return error? Or return success
> without changing address / vq state?

We probably don't need to worry too much here, as e.g set_vq_address
could fail even without suspend (just at uAPI level).

Thanks

>


