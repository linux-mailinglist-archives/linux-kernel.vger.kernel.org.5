Return-Path: <linux-kernel+bounces-1496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E117814F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4215F1C22A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468A146449;
	Fri, 15 Dec 2023 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQKk3Az0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056245BE9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702663051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h++U50hN+X/POmGBCeysUUq1JPcL9OMnDXCoOtDvh9U=;
	b=SQKk3Az0qQuRAbGazU6k2d7ERFdzOAX9RmvgS0q2x+0iNpWuT+HHmAIZpMvmrP7w1FRXBI
	19fMR6BxbB/e7tHlNDECNP30kNAIFeeGs/4nKn9Afvl/3BlsQlWJ+yatNkGuSBnavjVWpF
	vXb3XsNUCp3ut3eTu+BFNKvVuM/zK+M=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-9CymarmsNwmB4NYPuaXq4Q-1; Fri, 15 Dec 2023 12:57:30 -0500
X-MC-Unique: 9CymarmsNwmB4NYPuaXq4Q-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5d0c4ba7081so10097557b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702663049; x=1703267849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h++U50hN+X/POmGBCeysUUq1JPcL9OMnDXCoOtDvh9U=;
        b=C8gj9Q506Mcn0RPCa4Wkx018j48Yi6fCcuquHr33+ehBzSWuWvk27UdpNzUk+dMxFM
         j/hvn9xwHXSWaAo0Bv/Xk4ySKPFyEl9aiL9qSlUc+C8ce949NKWNn1tnYFD2wFDhnjTi
         vtJgNGBOrTVUwQDKixOKw9nNIsSW1Yr5Ig4/g1BXW5ZQ31tPZYvjBCpR5aesRSZOVQkg
         jy2NEONEnKsrIfOBjjvLrFgrHOBOzW36ddmPlBA+KpWpge707v0HXZpKUaqG4cSJ+z2j
         Q7TDNZ1hCORlXaeynXzGTmqH3k4QV1cuVCtCkXiLU1eTWtFX3KTF4a8FmXirZTAAFLIv
         Boww==
X-Gm-Message-State: AOJu0YwMUbyM1ddBk5DWbmv1Kxa6xKIZYfyhPYJvOCKOXyDYOvK4t8KG
	1m5u7EYYG4M3kKqQzWyaOFpjEj6ue7AE9MT/2x1aDokkxWpcyxw0PyWhGv9bj3N9Cv+ks3OTjxv
	/2bfKJjCfyUqKOVGuLH0A+kPf9WwB/CVfrI7Gfgq7
X-Received: by 2002:a0d:f583:0:b0:5d7:1940:b382 with SMTP id e125-20020a0df583000000b005d71940b382mr11071054ywf.78.1702663049528;
        Fri, 15 Dec 2023 09:57:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7430/+tU94/q04Uagk69EzjcMYfYTJ6BP+3d8bTzJ0ew3e/PuQ2dInXS8ckZQ38VdMkqUi/WeEisLFgIaWfo=
X-Received: by 2002:a0d:f583:0:b0:5d7:1940:b382 with SMTP id
 e125-20020a0df583000000b005d71940b382mr11071041ywf.78.1702663049216; Fri, 15
 Dec 2023 09:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205104609.876194-1-dtatulea@nvidia.com> <20231205104609.876194-5-dtatulea@nvidia.com>
 <CAJaqyWeEY9LNTE8QEnJgLhgS7HiXr5gJEwwPBrC3RRBsAE4_7Q@mail.gmail.com>
 <27312106-07b9-4719-970c-b8e1aed7c4eb@oracle.com> <075cf7d1ada0ee4ee30d46b993a1fe21acfe9d92.camel@nvidia.com>
 <20231214084526-mutt-send-email-mst@kernel.org> <9a6465a3d6c8fde63643fbbdde60d5dd84b921d4.camel@nvidia.com>
 <CAJaqyWfF9eVehQ+wutMDdwYToMq=G1+War_7wANmnyuONj=18g@mail.gmail.com>
 <9c387650e7c22118370fa0fe3588ee009ce56f11.camel@nvidia.com> <0bfb42ee1248b82eaedd88bdc9e97e83919f2405.camel@nvidia.com>
In-Reply-To: <0bfb42ee1248b82eaedd88bdc9e97e83919f2405.camel@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 15 Dec 2023 18:56:53 +0100
Message-ID: <CAJaqyWdv5xAXp2jiAj=z+3+Bu+6=sXiE0HtOZrMSSZmvVsHeJw@mail.gmail.com>
Subject: Re: [PATCH vhost v2 4/8] vdpa/mlx5: Mark vq addrs for modification in
 hw vq
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Parav Pandit <parav@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, "mst@redhat.com" <mst@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, "leon@kernel.org" <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 3:13=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Fri, 2023-12-15 at 12:35 +0000, Dragos Tatulea wrote:
> > On Thu, 2023-12-14 at 19:30 +0100, Eugenio Perez Martin wrote:
> > > On Thu, Dec 14, 2023 at 4:51=E2=80=AFPM Dragos Tatulea <dtatulea@nvid=
ia.com> wrote:
> > > >
> > > > On Thu, 2023-12-14 at 08:45 -0500, Michael S. Tsirkin wrote:
> > > > > On Thu, Dec 14, 2023 at 01:39:55PM +0000, Dragos Tatulea wrote:
> > > > > > On Tue, 2023-12-12 at 15:44 -0800, Si-Wei Liu wrote:
> > > > > > >
> > > > > > > On 12/12/2023 11:21 AM, Eugenio Perez Martin wrote:
> > > > > > > > On Tue, Dec 5, 2023 at 11:46=E2=80=AFAM Dragos Tatulea <dta=
tulea@nvidia.com> wrote:
> > > > > > > > > Addresses get set by .set_vq_address. hw vq addresses wil=
l be updated on
> > > > > > > > > next modify_virtqueue.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > > > > Reviewed-by: Gal Pressman <gal@nvidia.com>
> > > > > > > > > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > I'm kind of ok with this patch and the next one about state=
, but I
> > > > > > > > didn't ack them in the previous series.
> > > > > > > >
> > > > > > > > My main concern is that it is not valid to change the vq ad=
dress after
> > > > > > > > DRIVER_OK in VirtIO, which vDPA follows. Only memory maps a=
re ok to
> > > > > > > > change at this moment. I'm not sure about vq state in vDPA,=
 but vhost
> > > > > > > > forbids changing it with an active backend.
> > > > > > > >
> > > > > > > > Suspend is not defined in VirtIO at this moment though, so =
maybe it is
> > > > > > > > ok to decide that all of these parameters may change during=
 suspend.
> > > > > > > > Maybe the best thing is to protect this with a vDPA feature=
 flag.
> > > > > > > I think protect with vDPA feature flag could work, while on t=
he other
> > > > > > > hand vDPA means vendor specific optimization is possible arou=
nd suspend
> > > > > > > and resume (in case it helps performance), which doesn't have=
 to be
> > > > > > > backed by virtio spec. Same applies to vhost user backend fea=
tures,
> > > > > > > variations there were not backed by spec either. Of course, w=
e should
> > > > > > > try best to make the default behavior backward compatible wit=
h
> > > > > > > virtio-based backend, but that circles back to no suspend def=
inition in
> > > > > > > the current virtio spec, for which I hope we don't cease deve=
lopment on
> > > > > > > vDPA indefinitely. After all, the virtio based vdap backend c=
an well
> > > > > > > define its own feature flag to describe (minor difference in)=
 the
> > > > > > > suspend behavior based on the later spec once it is formed in=
 future.
> > > > > > >
> > > > > > So what is the way forward here? From what I understand the opt=
ions are:
> > > > > >
> > > > > > 1) Add a vdpa feature flag for changing device properties while=
 suspended.
> > > > > >
> > > > > > 2) Drop these 2 patches from the series for now. Not sure if th=
is makes sense as
> > > > > > this. But then Si-Wei's qemu device suspend/resume poc [0] that=
 exercises this
> > > > > > code won't work anymore. This means the series would be less we=
ll tested.
> > > > > >
> > > > > > Are there other possible options? What do you think?
> > > > > >
> > > > > > [0] https://github.com/siwliu-kernel/qemu/tree/svq-resume-wip
> > > > >
> > > > > I am fine with either of these.
> > > > >
> > > > How about allowing the change only under the following conditions:
> > > >   vhost_vdpa_can_suspend && vhost_vdpa_can_resume &&
> > > > VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is set
> > > >
> > > > ?
> > >
> > > I think the best option by far is 1, as there is no hint in the
> > > combination of these 3 indicating that you can change device
> > > properties in the suspended state.
> > >
> > Sure. Will respin a v3 without these two patches.
> >
> > Another series can implement option 2 and add these 2 patches on top.
> Hmm...I misunderstood your statement and sent a erroneus v3. You said tha=
t
> having a feature flag is the best option.
>
> Will add a feature flag in v4: is this similar to the
> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag?
>

Right, it should be easy to return it from .get_backend_features op if
the FW returns that capability, isn't it?

> Thanks,
> Dragos
>
> > > > Thanks,
> > > > Dragos
> > > >
> > > > > > Thanks,
> > > > > > Dragos
> > > > > >
> > > > > > > Regards,
> > > > > > > -Siwei
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Jason, what do you think?
> > > > > > > >
> > > > > > > > Thanks!
> > > > > > > >
> > > > > > > > > ---
> > > > > > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 9 +++++++++
> > > > > > > > >   include/linux/mlx5/mlx5_ifc_vdpa.h | 1 +
> > > > > > > > >   2 files changed, 10 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/=
vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > index f8f088cced50..80e066de0866 100644
> > > > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > @@ -1209,6 +1209,7 @@ static int modify_virtqueue(struct =
mlx5_vdpa_net *ndev,
> > > > > > > > >          bool state_change =3D false;
> > > > > > > > >          void *obj_context;
> > > > > > > > >          void *cmd_hdr;
> > > > > > > > > +       void *vq_ctx;
> > > > > > > > >          void *in;
> > > > > > > > >          int err;
> > > > > > > > >
> > > > > > > > > @@ -1230,6 +1231,7 @@ static int modify_virtqueue(struct =
mlx5_vdpa_net *ndev,
> > > > > > > > >          MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, n=
dev->mvdev.res.uid);
> > > > > > > > >
> > > > > > > > >          obj_context =3D MLX5_ADDR_OF(modify_virtio_net_q=
_in, in, obj_context);
> > > > > > > > > +       vq_ctx =3D MLX5_ADDR_OF(virtio_net_q_object, obj_=
context, virtio_q_context);
> > > > > > > > >
> > > > > > > > >          if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MAS=
K_STATE) {
> > > > > > > > >                  if (!is_valid_state_change(mvq->fw_state=
, state, is_resumable(ndev))) {
> > > > > > > > > @@ -1241,6 +1243,12 @@ static int modify_virtqueue(struct=
 mlx5_vdpa_net *ndev,
> > > > > > > > >                  state_change =3D true;
> > > > > > > > >          }
> > > > > > > > >
> > > > > > > > > +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK=
_VIRTIO_Q_ADDRS) {
> > > > > > > > > +               MLX5_SET64(virtio_q, vq_ctx, desc_addr, m=
vq->desc_addr);
> > > > > > > > > +               MLX5_SET64(virtio_q, vq_ctx, used_addr, m=
vq->device_addr);
> > > > > > > > > +               MLX5_SET64(virtio_q, vq_ctx, available_ad=
dr, mvq->driver_addr);
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > >          MLX5_SET64(virtio_net_q_object, obj_context, mod=
ify_field_select, mvq->modified_fields);
> > > > > > > > >          err =3D mlx5_cmd_exec(ndev->mvdev.mdev, in, inle=
n, out, sizeof(out));
> > > > > > > > >          if (err)
> > > > > > > > > @@ -2202,6 +2210,7 @@ static int mlx5_vdpa_set_vq_address=
(struct vdpa_device *vdev, u16 idx, u64 desc_
> > > > > > > > >          mvq->desc_addr =3D desc_area;
> > > > > > > > >          mvq->device_addr =3D device_area;
> > > > > > > > >          mvq->driver_addr =3D driver_area;
> > > > > > > > > +       mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_=
VIRTIO_Q_ADDRS;
> > > > > > > > >          return 0;
> > > > > > > > >   }
> > > > > > > > >
> > > > > > > > > diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include=
/linux/mlx5/mlx5_ifc_vdpa.h
> > > > > > > > > index b86d51a855f6..9594ac405740 100644
> > > > > > > > > --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > > > > > > > +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > > > > > > > @@ -145,6 +145,7 @@ enum {
> > > > > > > > >          MLX5_VIRTQ_MODIFY_MASK_STATE                    =
=3D (u64)1 << 0,
> > > > > > > > >          MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_PARAMS      =
=3D (u64)1 << 3,
> > > > > > > > >          MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_DUMP_ENABLE =
=3D (u64)1 << 4,
> > > > > > > > > +       MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS           =
=3D (u64)1 << 6,
> > > > > > > > >          MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY          =
=3D (u64)1 << 14,
> > > > > > > > >   };
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.42.0
> > > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


