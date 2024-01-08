Return-Path: <linux-kernel+bounces-19072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE37826775
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB2A1C210F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7FB28F8;
	Mon,  8 Jan 2024 03:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgOQQVhl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C410EB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704685480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cnx9iyNScW+fjHqQwJKBaz57iJJ39RPOEEB/TE5TIg=;
	b=SgOQQVhlfduOx3GVPY/BdGhjzoxYMFG7zqXGWN8WuyG0hmtxNz5XK52ByaeNOo99LujnrW
	V2EUVedORsBqx+8VUDOzNI3zorQGHtvKzd9TGKQWlcHodCSg2XqWBvxTHImRbVINb3PX3y
	rjyfPqsTyv5mzXu9wSa3CB7gDeZxhr8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26--eXkoIe9OQyjN7j-Qo9yQQ-1; Sun, 07 Jan 2024 22:44:39 -0500
X-MC-Unique: -eXkoIe9OQyjN7j-Qo9yQQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5ce8a3381a1so1222720a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 19:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704685478; x=1705290278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cnx9iyNScW+fjHqQwJKBaz57iJJ39RPOEEB/TE5TIg=;
        b=fSsEqyAJ3iUMsK8iFVE9UIoRqeYeE74p1cT2DbQnpYwL//uoPz+9KUTapQUsf3PnKf
         A7wg30F+sTjOIupo5SR6ufgCBW+PWhMpERM5j49JaAilDVtLCqeNrlPQGDrOl50FS4fm
         0m6lWmfu1EGM05skydjms1k8jhVIPPNMcnA8kXPleuKe1AYkUar+3NXuS4iw9V/Xa9uf
         VWZ80c9XAhSaHaiprS0EbsrEzsFz3/15FdWzYHK2kLSwtHHtpP/3SBAzfZqk/riPv12S
         qwHuKC+AGiYF1svcoR8a0TZv3eGAljk3bXoov6CB+UNO8yP/5t29NRAD9AuMfHUDje6V
         +KOg==
X-Gm-Message-State: AOJu0Yy6YeKVJuDMsrLNyaLJOjEuYT3MZjmmCRbucvRpqa3YtdUxVE4S
	gRNrENhcFiM1g4EWD333Wh7PQGB4C0vHcwNPgZMnxYY/LKfzv3xHmsBQg1M/cTNFFo6xqp/HlIW
	wIwqO94fwZfOlZvE8XCHyF2+BQvgUC6boJurWn1DuhBHmFqWP
X-Received: by 2002:a05:6a20:3a9f:b0:199:b900:3e96 with SMTP id d31-20020a056a203a9f00b00199b9003e96mr803202pzh.100.1704685478132;
        Sun, 07 Jan 2024 19:44:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyADji7nM1guDP1OIGckPwbqKom2hyq0owGLObmppK/N9lq+t6uPQupJq54MYiyvdWCLr/vj63iT4ZdtJeU18=
X-Received: by 2002:a05:6a20:3a9f:b0:199:b900:3e96 with SMTP id
 d31-20020a056a203a9f00b00199b9003e96mr803193pzh.100.1704685477869; Sun, 07
 Jan 2024 19:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104153753.2931026-1-maxime.coquelin@redhat.com>
 <20240104153753.2931026-3-maxime.coquelin@redhat.com> <CACGkMEtmTY0ux8pw8VQ8SAdgGty=rM1VRkh6c-qBVSaqhYuURw@mail.gmail.com>
 <888255d7-e45b-44db-8561-5e9f386603c3@redhat.com> <CAJaqyWfrO3c9GD2k+aX=fA8OQLg2aQPHHb4WyTbE09KkmoOesA@mail.gmail.com>
 <0322ee9e-f6db-45ed-855f-9ebcdfca30a9@redhat.com>
In-Reply-To: <0322ee9e-f6db-45ed-855f-9ebcdfca30a9@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jan 2024 11:44:26 +0800
Message-ID: <CACGkMEuYVw0QvbmNCQ-43bn1nhVH4OS7tTpf0a-mvmOmvXaPkQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] vduse: Temporarily fail if control queue features requested
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, david.marchand@redhat.com, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 6:14=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 1/5/24 10:59, Eugenio Perez Martin wrote:
> > On Fri, Jan 5, 2024 at 9:12=E2=80=AFAM Maxime Coquelin
> > <maxime.coquelin@redhat.com> wrote:
> >>
> >>
> >>
> >> On 1/5/24 03:45, Jason Wang wrote:
> >>> On Thu, Jan 4, 2024 at 11:38=E2=80=AFPM Maxime Coquelin
> >>> <maxime.coquelin@redhat.com> wrote:
> >>>>
> >>>> Virtio-net driver control queue implementation is not safe
> >>>> when used with VDUSE. If the VDUSE application does not
> >>>> reply to control queue messages, it currently ends up
> >>>> hanging the kernel thread sending this command.
> >>>>
> >>>> Some work is on-going to make the control queue
> >>>> implementation robust with VDUSE. Until it is completed,
> >>>> let's fail features check if any control-queue related
> >>>> feature is requested.
> >>>>
> >>>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> >>>> ---
> >>>>    drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
> >>>>    1 file changed, 13 insertions(+)
> >>>>
> >>>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_=
user/vduse_dev.c
> >>>> index 0486ff672408..94f54ea2eb06 100644
> >>>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> >>>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> >>>> @@ -28,6 +28,7 @@
> >>>>    #include <uapi/linux/virtio_config.h>
> >>>>    #include <uapi/linux/virtio_ids.h>
> >>>>    #include <uapi/linux/virtio_blk.h>
> >>>> +#include <uapi/linux/virtio_ring.h>
> >>>>    #include <linux/mod_devicetable.h>
> >>>>
> >>>>    #include "iova_domain.h"
> >>>> @@ -46,6 +47,15 @@
> >>>>
> >>>>    #define IRQ_UNBOUND -1
> >>>>
> >>>> +#define VDUSE_NET_INVALID_FEATURES_MASK         \
> >>>> +       (BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |        \
> >>>> +        BIT_ULL(VIRTIO_NET_F_CTRL_RX)   |      \
> >>>> +        BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |      \
> >>>> +        BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) | \
> >>>> +        BIT_ULL(VIRTIO_NET_F_MQ) |             \
> >>>> +        BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |  \
> >>>> +        BIT_ULL(VIRTIO_NET_F_RSS))
> >>>
> >>> We need to make this as well:
> >>>
> >>> VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
> >>
> >> I missed it, and see others have been added in the Virtio spec
> >> repository (BTW, I see this specific one is missing in the dependency
> >> list [0], I will submit a patch).
> >>
> >> I wonder if it is not just simpler to just check for
> >> VIRTIO_NET_F_CTRL_VQ is requested. As we fail instead of masking out,
> >> the VDUSE driver won't be the one violating the spec so it should be
> >> good?
> >>
> >> It will avoid having to update the mask if new features depending on i=
t
> >> are added (or forgetting to update it).
> >>
> >> WDYT?
> >>
> >
> > I think it is safer to work with a whitelist, instead of a blacklist.
> > As any new feature might require code changes in QEMU. Is that
> > possible?
>
> Well, that's how it was done in previous revision. :)
>
> I changed to a blacklist for consistency with block device's WCE feature
> check after Jason's comment.
>
> I'm not sure moving back to a whitelist brings much advantages when
> compared to the effort of keeping it up to date. Just blacklisting
> VIRTIO_NET_F_CTRL_VQ is enough in my opinion.

I think this makes sense.

Thanks

>
> Thanks,
> Maxime
>
> >> Thanks,
> >> Maxime
> >>
> >> [0]:
> >> https://github.com/oasis-tcs/virtio-spec/blob/5fc35a7efb903fc352da81a6=
d2be5c01810b68d3/device-types/net/description.tex#L129
> >>> Other than this,
> >>>
> >>> Acked-by: Jason Wang <jasowang@redhat.com>
> >>>
> >>> Thanks
> >>>
> >>>> +
> >>>>    struct vduse_virtqueue {
> >>>>           u16 index;
> >>>>           u16 num_max;
> >>>> @@ -1680,6 +1690,9 @@ static bool features_is_valid(struct vduse_dev=
_config *config)
> >>>>           if ((config->device_id =3D=3D VIRTIO_ID_BLOCK) &&
> >>>>                           (config->features & (1ULL << VIRTIO_BLK_F_=
CONFIG_WCE)))
> >>>>                   return false;
> >>>> +       else if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> >>>> +                       (config->features & VDUSE_NET_INVALID_FEATUR=
ES_MASK))
> >>>> +               return false;
> >>>>
> >>>>           return true;
> >>>>    }
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>
> >>
> >>
> >
>


