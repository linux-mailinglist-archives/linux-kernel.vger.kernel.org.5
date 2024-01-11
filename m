Return-Path: <linux-kernel+bounces-23010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B629582A651
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2729B213A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E59EC0;
	Thu, 11 Jan 2024 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpLmTPkI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA85A4F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704942530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6SQz5L0hBsYm6eMr2X57tR6Yc9zmeLUcvOiWFM8AnJ8=;
	b=cpLmTPkIRMcylYRVENXZB2RDhDmwMyhY4N9LEOj3vwZMYov3iFa+SMElm6X//TvT3/J+kh
	LOzuN1n7XyNinbKYNNlTPsqFL9FtovgH97bongks1oNhZ68ibJLu1Wq9harpt3bKIwidMH
	A4JX4k4kE3MKMr2L6PlwclScA5UZl4o=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-XFH-4OawMyaKW415KibCVw-1; Wed, 10 Jan 2024 22:08:48 -0500
X-MC-Unique: XFH-4OawMyaKW415KibCVw-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bd4b623e4aso2072107b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704942527; x=1705547327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SQz5L0hBsYm6eMr2X57tR6Yc9zmeLUcvOiWFM8AnJ8=;
        b=eoH6nguVjpnK2/hHaUp3V1OLmXtSUudyVKc6h6OKi+WgSctcMK8OvpHlt7W2FtQDXI
         C9h/KE1JwhKRGED4DkpS5MgrdysOS/VeayrQStIghwcISZUQ6IchMmBzZsP3jwQujhQY
         EtOM+oIdbZ6KfctiFqKl1vsDpqd4Ne4Qo/bptwNZVwz8GOgIaEsWqxfA6JIb4UhdhcFN
         kaC8I+1kcZzLRlzfF/ojujjqd9AOq1nI4JVUq1fPDvPN+6pozje+flyF9j2gJuA35EV+
         /xuYi2DeZiW+T2X2TBB8ez3n9YQq7AKLuRughYmLznn/Aib93VVFlGWQYiyx1JG7ZFza
         roYQ==
X-Gm-Message-State: AOJu0Yye1EOeHryIGnIi/wGNFWcsIsQUAVWeGEb0BdQxYgZb1lbuQlri
	kLLcgToVdX9qv0L3V/oPj1h8pIimoyFpaH6s1Ef9Ex5DVCn/zpWsVIJ8Y9CHumlecc+9lToYi2v
	P5Oh7myeUgOEH7biiRThjFzfWXuzyqNZ/gbDSCY8jsvVsbdT1
X-Received: by 2002:a05:6808:1784:b0:3bb:cdd5:17c4 with SMTP id bg4-20020a056808178400b003bbcdd517c4mr718531oib.83.1704942526962;
        Wed, 10 Jan 2024 19:08:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpuMzRUZs27bDbP+rps109ftXK1ZxLxm8s+N95dPDRP9BhlcuVF9fN6qNHuDTppiRor9al5Z+v20N82dcY1Kg=
X-Received: by 2002:a05:6808:1784:b0:3bb:cdd5:17c4 with SMTP id
 bg4-20020a056808178400b003bbcdd517c4mr718523oib.83.1704942526738; Wed, 10 Jan
 2024 19:08:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com> <1704919215-91319-6-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1704919215-91319-6-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 11:08:35 +0800
Message-ID: <CACGkMEsCzLNdRXu25tzhrnTVatM6pHwVXVUn7kE=3erVWQUL4g@mail.gmail.com>
Subject: Re: [RFC V1 05/13] vhost-vdpa: VHOST_IOTLB_REMAP
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
> When device ownership is passed to a new process via VHOST_NEW_OWNER,
> some devices need to know the new userland addresses of the dma mappings.
> Define the new iotlb message type VHOST_IOTLB_REMAP to update the uaddr
> of a mapping.  The new uaddr must address the same memory object as
> originally mapped.
>
> The user must suspend the device before the old address is invalidated,
> and cannot resume it until after VHOST_IOTLB_REMAP is called, but this
> requirement is not enforced by the API.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vhost/vdpa.c             | 34 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vhost_types.h | 11 ++++++++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index faed6471934a..ec5ca20bd47d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1219,6 +1219,37 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>
>  }
>
> +static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
> +                                         struct vhost_iotlb *iotlb,
> +                                         struct vhost_iotlb_msg *msg)
> +{
> +       struct vdpa_device *vdpa =3D v->vdpa;
> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> +       u32 asid =3D iotlb_to_asid(iotlb);
> +       u64 start =3D msg->iova;
> +       u64 last =3D start + msg->size - 1;
> +       struct vhost_iotlb_map *map;
> +       int r =3D 0;
> +
> +       if (msg->perm || !msg->size)
> +               return -EINVAL;
> +
> +       map =3D vhost_iotlb_itree_first(iotlb, start, last);
> +       if (!map)
> +               return -ENOENT;
> +
> +       if (map->start !=3D start || map->last !=3D last)
> +               return -EINVAL;
> +
> +       /* batch will finish with remap.  non-batch must do it now. */
> +       if (!v->in_batch)
> +               r =3D ops->set_map(vdpa, asid, iotlb);
> +       if (!r)
> +               map->addr =3D msg->uaddr;

I may miss something, for example for PA mapping,

1) need to convert uaddr into phys addr
2) need to check whether the uaddr is backed by the same page or not?

Thanks

> +
> +       return r;
> +}
> +
>  static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>                                            struct vhost_iotlb *iotlb,
>                                            struct vhost_iotlb_msg *msg)
> @@ -1298,6 +1329,9 @@ static int vhost_vdpa_process_iotlb_msg(struct vhos=
t_dev *dev, u32 asid,
>                         ops->set_map(vdpa, asid, iotlb);
>                 v->in_batch =3D false;
>                 break;
> +       case VHOST_IOTLB_REMAP:
> +               r =3D vhost_vdpa_process_iotlb_remap(v, iotlb, msg);
> +               break;
>         default:
>                 r =3D -EINVAL;
>                 break;
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index 9177843951e9..35908315ff55 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -79,7 +79,7 @@ struct vhost_iotlb_msg {
>  /*
>   * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
>   * multiple mappings in one go: beginning with
> - * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
> + * VHOST_IOTLB_BATCH_BEGIN, followed by any number of VHOST_IOTLB_REMAP =
or
>   * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END.
>   * When one of these two values is used as the message type, the rest
>   * of the fields in the message are ignored. There's no guarantee that
> @@ -87,6 +87,15 @@ struct vhost_iotlb_msg {
>   */
>  #define VHOST_IOTLB_BATCH_BEGIN    5
>  #define VHOST_IOTLB_BATCH_END      6
> +
> +/*
> + * VHOST_IOTLB_REMAP registers a new uaddr for the existing mapping at i=
ova.
> + * The new uaddr must address the same memory object as originally mappe=
d.
> + * Failure to do so will result in user memory corruption and/or device
> + * misbehavior.  iova and size must match the arguments used to create t=
he
> + * an existing mapping.  Protection is not changed, and perm must be 0.
> + */
> +#define VHOST_IOTLB_REMAP          7
>         __u8 type;
>  };
>
> --
> 2.39.3
>


