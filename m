Return-Path: <linux-kernel+bounces-22999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B8D82A634
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58441C23077
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EA3257C;
	Thu, 11 Jan 2024 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBtrNJVD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02561FD2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704941736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9j8eMpUTHCJ1mO7p36IGUmNwnqk3Axv6bQ9HcFkssI=;
	b=KBtrNJVDafh3JWHORE/R2dysE20RP7sd5w9sjGkcsHfsPrteVO4Tp2U7l+TxobQNRWclFs
	3FgOZPj7Kqov2uSBZZuD3bkyD/I8q93Dfk7W8q7ck8kBYbPEqIjuDkDsjHRm7p+R01naY6
	AQWOCH6f9feoCsrlU6Hq5xPyOQ8wPHM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-FfFHjeHOO6W5U_5PsFF26g-1; Wed, 10 Jan 2024 21:55:35 -0500
X-MC-Unique: FfFHjeHOO6W5U_5PsFF26g-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bd34d3c9cbso4279046b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704941734; x=1705546534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9j8eMpUTHCJ1mO7p36IGUmNwnqk3Axv6bQ9HcFkssI=;
        b=Z5RGuMaKkXTBMFI17JMa1pnBtrELEIkFrpzsAhOvHi2rPEFQ/C+5VzKGJpoU6QnTEH
         0xOgyWJxNn11zlNgkRJvUok4qC2v+XkR+c8rsoIWbvZkrE3K9sUOQb4B65Lh03IRZDXC
         zMp4W+bogmpSpLeozbi3kWrRG9J6jGwvGyhIcyR3S61e7qVKvs/CgrnXjIAka27/OdwY
         knMjZVVFq1r0o5kLvH1uFjfjS0IyF0koeI7DKyjkJdbXqZRrZBvlkwxBiDddiQ+x4j/E
         U5kSmgmmrCMGhViTwZwHarHbwg4j5MwOsI5EG7I4Rf93jKvqyHdW5uHGJMW0vbX9JKLG
         +zTQ==
X-Gm-Message-State: AOJu0YwW7au4+k1i+L20j4g23rAlBoUeBm8d1Ws0q/7sLfVPOqGef+OX
	hc7qSUdoeG3pFuJINSbZzRnRExKYvYMKrlkp1I8Hdw+r2t+7YSl4nkza0hoTT3vkIZ0OPCyJHpP
	DDo5J+7u+cPXl3SX1x6LYON/A3mEcK57ORBB7RDgtmzM+TAme
X-Received: by 2002:aca:1917:0:b0:3bb:bc99:97ea with SMTP id l23-20020aca1917000000b003bbbc9997eamr539521oii.113.1704941734412;
        Wed, 10 Jan 2024 18:55:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrvL5aN1oMY/xsWTuvDAwaYkeqoFoVu5BHvIE9XcjlsRb3VpFbSQsl3zMzrvJV2ZKCUCflaj93XQntprMwaYI=
X-Received: by 2002:aca:1917:0:b0:3bb:bc99:97ea with SMTP id
 l23-20020aca1917000000b003bbbc9997eamr539508oii.113.1704941734197; Wed, 10
 Jan 2024 18:55:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 10:55:23 +0800
Message-ID: <CACGkMEuFTRBYU+z3ZSWzMMv2650PQ=kduGxcGXaf0T5222Bh4g@mail.gmail.com>
Subject: Re: [RFC V1 00/13] vdpa live update
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>, 
	Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:40=E2=80=AFAM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> Live update is a technique wherein an application saves its state, exec's
> to an updated version of itself, and restores its state.  Clients of the
> application experience a brief suspension of service, on the order of
> 100's of milliseconds, but are otherwise unaffected.
>
> Define and implement interfaces that allow vdpa devices to be preserved
> across fork or exec, to support live update for applications such as qemu=
.
> The device must be suspended during the update, but its dma mappings are
> preserved, so the suspension is brief.
>
> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
> accounting from one process to another.
>
> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
> VHOST_NEW_OWNER is supported.
>
> The VHOST_IOTLB_REMAP message type updates a dma mapping with its userlan=
d
> address in the new process.
>
> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
> require it, because the userland address of each dma mapping is discarded
> after being translated to a physical address.
>
> Here is a pseudo-code sequence for performing live update, based on
> suspend + reset because resume is not yet available.  The vdpa device
> descriptor, fd, remains open across the exec.
>
>   ioctl(fd, VHOST_VDPA_SUSPEND)
>   ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
>   exec

Is there a userspace implementation as a reference?

>
>   ioctl(fd, VHOST_NEW_OWNER)
>
>   issue ioctls to re-create vrings
>
>   if VHOST_BACKEND_F_IOTLB_REMAP
>       foreach dma mapping
>           write(fd, {VHOST_IOTLB_REMAP, new_addr})

I think I need to understand the advantages of this approach. For
example, why it is better than

ioctl(VHOST_RESET_OWNER)
exec

ioctl(VHOST_SET_OWNER)

for each dma mapping
     ioctl(VHOST_IOTLB_UPDATE)

Thanks

>
>   ioctl(fd, VHOST_VDPA_SET_STATUS,
>             ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)
>
>
> Steve Sistare (13):
>   vhost-vdpa: count pinned memory
>   vhost-vdpa: pass mm to bind
>   vhost-vdpa: VHOST_NEW_OWNER
>   vhost-vdpa: VHOST_BACKEND_F_NEW_OWNER
>   vhost-vdpa: VHOST_IOTLB_REMAP
>   vhost-vdpa: VHOST_BACKEND_F_IOTLB_REMAP
>   vhost-vdpa: flush workers on suspend
>   vduse: flush workers on suspend
>   vdpa_sim: reset must not run
>   vdpa_sim: flush workers on suspend
>   vdpa/mlx5: new owner capability
>   vdpa_sim: new owner capability
>   vduse: new owner capability
>
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  |   3 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c   |  24 ++++++-
>  drivers/vdpa/vdpa_user/vduse_dev.c |  32 +++++++++
>  drivers/vhost/vdpa.c               | 101 +++++++++++++++++++++++++++--
>  drivers/vhost/vhost.c              |  15 +++++
>  drivers/vhost/vhost.h              |   1 +
>  include/uapi/linux/vhost.h         |  10 +++
>  include/uapi/linux/vhost_types.h   |  15 ++++-
>  8 files changed, 191 insertions(+), 10 deletions(-)
>
> --
> 2.39.3
>


