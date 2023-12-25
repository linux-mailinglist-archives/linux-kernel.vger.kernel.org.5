Return-Path: <linux-kernel+bounces-10887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD5C81DE0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 05:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BF01F2122B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69421258D;
	Mon, 25 Dec 2023 04:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbM08b2a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465AF23A8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 04:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703477502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PR0rFCSyUG2eR88FaJw5eC09XvCgcCbfqIX9eF5hqEQ=;
	b=JbM08b2a1y/LrdMZVrfZaPXr72a73RQxp+EzbierX07a3SSZqNeT4WwJAn3FiULWLj0Wer
	ODJ5QhQZw6BolR80sFc/5sfFCji6zbQuMLk2icLP+hbfent6k5HUohr8Iuryi4igzyQX9b
	EU2TmH+hG1vNEyLAn8qjDm4Mer+GfYA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-5RbA8SDjMXmbfzR9xVDQpQ-1; Sun, 24 Dec 2023 23:11:40 -0500
X-MC-Unique: 5RbA8SDjMXmbfzR9xVDQpQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28b0fe75032so3954784a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 20:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703477499; x=1704082299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR0rFCSyUG2eR88FaJw5eC09XvCgcCbfqIX9eF5hqEQ=;
        b=MkTWDyfxs8XxwWlfWlSmBe+691830kB8xBaxgUwvTlo14aG/uj7OHpMTW6DjKM53AN
         TipNV8LM9cqJSmhBw/lOA2bNbF8Hhh9GvlVlf8u/LT+faoecEXMSiVuqEWaOc0sSKLai
         JB+Bdlqww45dDLOnPhMTpkT5sCt1NGGXPVZcW8MDq5GBLORTu0NN1k4B9kSzDLu4V7ee
         P8Q9SeX2PfJeY4DkLdj4XfefC/dNdyZxwkaxbZfkvfKsVc5Q6adNraY4Orq9gKKxpu+E
         6ATq26e1WYk9dunIM6XjFA31MsFnPQlZQjp0DM6f1PLcnrd0qBvlMXMGjSI1/gCb1t96
         ZkEw==
X-Gm-Message-State: AOJu0YypS3xtj89rr7OmfQBSKuZK+w9KInoK/3vuGVewuNCct67dwvL5
	pcgZ3iuq0cMTztmtOSW+Pc0OnQ0CCXQ8IXu8dwIwDBRIIBhE8r3mGRt8Zbsgnm9aJJ3ZRqcMoBs
	xoA47hE+uJ8pX9DPjb9nSBWy89pYlYlT2sqHOiw5RJdxR/qqP
X-Received: by 2002:a17:90a:428c:b0:28b:dc75:bef8 with SMTP id p12-20020a17090a428c00b0028bdc75bef8mr2579970pjg.22.1703477499383;
        Sun, 24 Dec 2023 20:11:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtxp8ucWx5dROZrp5JvDri52KPchZd12v9x5kEJ0UPnd0L9ZR0+MGTL1LiOJ9Z1GS7ksafL6q7Xk0IKUseXt0=
X-Received: by 2002:a17:90a:428c:b0:28b:dc75:bef8 with SMTP id
 p12-20020a17090a428c00b0028bdc75bef8mr2579959pjg.22.1703477499127; Sun, 24
 Dec 2023 20:11:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-7-dtatulea@nvidia.com>
 <CACGkMEs_kf2y9Khr==zY3RRHffaPRwS51XK33Lgv1eeanQdRpg@mail.gmail.com>
 <65064744954829b844d8a7b23bb09792cb6c2760.camel@nvidia.com> <f54a1037b515d15b24193d96d574b775eb743099.camel@nvidia.com>
In-Reply-To: <f54a1037b515d15b24193d96d574b775eb743099.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Dec 2023 12:11:27 +0800
Message-ID: <CACGkMEsCrYY1bYDwOYD=XMPi0b1naJj5dGe8FXH9uMqpsf1b2A@mail.gmail.com>
Subject: Re: [PATCH vhost v4 06/15] vdpa: Track device suspended state
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Parav Pandit <parav@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, "eperezma@redhat.com" <eperezma@redhat.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"mst@redhat.com" <mst@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 7:22=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Wed, 2023-12-20 at 13:55 +0100, Dragos Tatulea wrote:
> > On Wed, 2023-12-20 at 11:46 +0800, Jason Wang wrote:
> > > On Wed, Dec 20, 2023 at 2:09=E2=80=AFAM Dragos Tatulea <dtatulea@nvid=
ia.com> wrote:
> > > >
> > > > Set vdpa device suspended state on successful suspend. Clear it on
> > > > successful resume and reset.
> > > >
> > > > The state will be locked by the vhost_vdpa mutex. The mutex is take=
n
> > > > during suspend, resume and reset in vhost_vdpa_unlocked_ioctl. The
> > > > exception is vhost_vdpa_open which does a device reset but that sho=
uld
> > > > be safe because it can only happen before the other ops.
> > > >
> > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > >  drivers/vhost/vdpa.c | 17 +++++++++++++++--
> > > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > index b4e8ddf86485..00b4fa8e89f2 100644
> > > > --- a/drivers/vhost/vdpa.c
> > > > +++ b/drivers/vhost/vdpa.c
> > > > @@ -59,6 +59,7 @@ struct vhost_vdpa {
> > > >         int in_batch;
> > > >         struct vdpa_iova_range range;
> > > >         u32 batch_asid;
> > > > +       bool suspended;
> > >
> > > Any reason why we don't do it in the core vDPA device but here?
> > >
> > Not really. I wanted to be safe and not expose it in a header due to lo=
cking.
> >
> A few clearer answers for why the state is not added in struct vdpa_devic=
e:
> - All the suspend infrastructure is currently only for vhost.
> - If the state would be moved to struct vdpa_device then the cf_lock woul=
d have
> to be used. This adds more complexity to the code.
>
> Thanks,
> Dragos

Ok, I'm fine with that.

Thanks


