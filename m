Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476067E778E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345713AbjKJCcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjKJCcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A698E449A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699583523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNS2IyMSqXQW2yu+EGl6Ot8gwOdMjojW7LaUfYQpOEw=;
        b=HsiVgS4vHP9yfLnnqqNAA21UQUwaegRhVQnSPeTbU4iYJBGJcQbXs9y5npV38fpU/knuek
        Jz0x7ODK/JmlnPblgBgp9TnHYz2nQGD8MQCgauiA4LQ0prKxLgOcUMngP+EAezlVG22BpN
        dbojj2CcvVU/gx+ry6oyTLqJbZkD/2g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-u4wFGcYGMy-RkXM6BB_rAQ-1; Thu, 09 Nov 2023 21:32:01 -0500
X-MC-Unique: u4wFGcYGMy-RkXM6BB_rAQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507cb169766so1510416e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699583520; x=1700188320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNS2IyMSqXQW2yu+EGl6Ot8gwOdMjojW7LaUfYQpOEw=;
        b=PJhlodS/BmolXj2qIwTl4pDCl8bDbkreuPa8FNLl5cUCkw3xgNLdpZ3OKkKTI/kHth
         W/7spkHzRcOCKiboBKxJAXm1vk50KdGG5TFp5PQqpf/Gcid/QK99J11otBjqx+irOd+n
         0TPyJYrHPAEWV7hnno3mYIJChRhNPJYF1lvw+tOLWRSsL9U1CJpxcuWafCJO06zDyXgE
         B9b84kxh8LCbtDROYPBHHHqbTxMXWMTb55pPkV2TJvuWFGzTtXOnzfs0w0T7X9I8Rxcv
         9JeZ6Qu3dIZXbjODYLXFTKHGRLYg9nUhLq88F1+V5GPd2G2WZsQWTPc75CeCeczoJTYv
         L2Kg==
X-Gm-Message-State: AOJu0YxJ2/kU2Itz1jPhVleUaF7WE2U0FlD/1YxqAPgE7RnZi8ZKbe6X
        C0c+NsAII6sRnZ1G7PSmKorgveiLHpYLUcrjVIgDcc7hl7XObvzYDTeCEez2IG3DrUaAlvrUOui
        Fg/t37uBjwYoA3ge6G79nPianhVKeMsCWfIJI6ZLM
X-Received: by 2002:a05:6512:3b0d:b0:50a:5b7b:3de3 with SMTP id f13-20020a0565123b0d00b0050a5b7b3de3mr628503lfv.48.1699583519953;
        Thu, 09 Nov 2023 18:31:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5TlKYjD+BKd37dlAum2ISONImb/e0UdH9nWCcDO4HKzLaHEqEN/Kb8/dl/VFEMFjHAbPjUBm65YDovYK3SSs=
X-Received: by 2002:a05:6512:3b0d:b0:50a:5b7b:3de3 with SMTP id
 f13-20020a0565123b0d00b0050a5b7b3de3mr628487lfv.48.1699583519532; Thu, 09 Nov
 2023 18:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
 <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com>
 <CACLfguX9-wEQPUyZkJZoRMmgPDRFNyZCmt0nvHROhyP1yooiYA@mail.gmail.com>
 <CACGkMEsp_rg+_01hwxCtZNOk2itB1L89mdOc1W1DG3umfEt5bw@mail.gmail.com>
 <CACLfguW3NZawOL0ET2K7bmtGZuzQwUfJ2HSgnirswzZK1ayPnA@mail.gmail.com> <CACGkMEvnNXC8PhBNQn_F0ROGRX3CvwmXM6wP2A69aydSuzThYw@mail.gmail.com>
In-Reply-To: <CACGkMEvnNXC8PhBNQn_F0ROGRX3CvwmXM6wP2A69aydSuzThYw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 10 Nov 2023 10:31:47 +0800
Message-ID: <CACGkMEtVqAYP3ec0+uxmdiOdXXevjy5S+7Vuc9s=PcS3ry0nCg@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 3:09=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Nov 8, 2023 at 2:39=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Wed, Nov 8, 2023 at 11:03=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Tue, Nov 7, 2023 at 2:57=E2=80=AFPM Cindy Lu <lulu@redhat.com> wro=
te:
> > > >
> > > > On Mon, Nov 6, 2023 at 3:30=E2=80=AFPM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com>=
 wrote:
> > > > > >
> > > > > > VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
> > > > > >
> > > > > > VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommu=
fd
> > > > > > address space specified by IOAS id.
> > > > > >
> > > > > > VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> > > > > > from the iommufd address space
> > > > > >
> > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > ---
> > > > >
> > > > > [...]
> > > > >
> > > > > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vh=
ost.h
> > > > > > index f5c48b61ab62..07e1b2c443ca 100644
> > > > > > --- a/include/uapi/linux/vhost.h
> > > > > > +++ b/include/uapi/linux/vhost.h
> > > > > > @@ -219,4 +219,70 @@
> > > > > >   */
> > > > > >  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
> > > > > >
> > > > > > +/* vhost_vdpa_set_iommufd
> > > > > > + * Input parameters:
> > > > > > + * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
> > > > > > + * @iommufd_ioasid: IOAS identifier returned from ioctl(IOMMU_=
IOAS_ALLOC)
> > > > > > + * Output parameters:
> > > > > > + * @out_dev_id: device identifier
> > > > > > + */
> > > > > > +struct vhost_vdpa_set_iommufd {
> > > > > > +       __s32 iommufd;
> > > > > > +       __u32 iommufd_ioasid;
> > > > > > +       __u32 out_dev_id;
> > > > > > +};
> > > > > > +
> > > > > > +#define VHOST_VDPA_SET_IOMMU_FD \
> > > > > > +       _IOW(VHOST_VIRTIO, 0x7F, struct vhost_vdpa_set_iommufd)
> > > > > > +
> > > > > > +/*
> > > > > > + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> > > > > > + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_=
as)
> > > > > > + *
> > > > > > + * Attach a vdpa device to an iommufd address space specified =
by IOAS
> > > > > > + * id.
> > > > > > + *
> > > > > > + * Available only after a device has been bound to iommufd via
> > > > > > + * VHOST_VDPA_SET_IOMMU_FD
> > > > > > + *
> > > > > > + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> > > > > > + *
> > > > > > + * @argsz:     user filled size of this data.
> > > > > > + * @flags:     must be 0.
> > > > > > + * @ioas_id:   Input the target id which can represent an ioas
> > > > > > + *             allocated via iommufd subsystem.
> > > > > > + *
> > > > > > + * Return: 0 on success, -errno on failure.
> > > > > > + */
> > > > > > +struct vdpa_device_attach_iommufd_as {
> > > > > > +       __u32 argsz;
> > > > > > +       __u32 flags;
> > > > > > +       __u32 ioas_id;
> > > > > > +};
> > > > >
> > > > > I think we need to map ioas to vDPA AS, so there should be an ASI=
D
> > > > > from the view of vDPA?
> > > > >
> > > > > Thanks
> > > > >
> > > > The qemu will have a structure save and  maintain this information,=
So
> > > > I didn't add this
> > > >  in kernel=EF=BC=8Cwe can add this but maybe only for check?
> > >
> > > I meant for example, a simulator has two AS. How can we attach an ioa=
s
> > > to a specific AS with the above uAPI?
> > >
> > > Thank>
> > this   __u32 ioas_id here is alloc from the iommufd system. maybe I
> > need to change to new name iommuds_asid to
> > make this more clear
> > the process in qemu is
> >
> > 1) qemu want to use AS 0 (for example)
> > 2) checking the existing asid. the asid 0 not used before
> > 3 )alloc new asid from iommufd system, get new ioas_id (maybe 3 for exa=
mple)
> > qemu will save this relation 3<-->0 in the driver.
> > 4) setting the ioctl VDPA_DEVICE_ATTACH_IOMMUFD_AS to attach new ASID
> > to the kernel
>
> So if we want to map IOMMUFD AS 3 to VDPA AS 0, how can it be done?
>
> For example I didn't see a vDPA AS parameter in the above uAPI.
>
> vhost_vdpa_set_iommufd has iommufd_ioasid which is obviously not the vDPA=
 AS.
>
> And ioas_id of vdpa_device_attach_iommufd_as (as you explained above)
> is not vDPA AS.

For example, the simulator/mlx5e has two ASes. It needs to know the
mapping between vDPA AS and iommufd AS. Otherwise the translation will
be problematic.

Thanks

>
> Thanks
>
>
> > 5=EF=BC=89 while map the memory=EF=BC=8C qemu will use ASID 3 to map /u=
map
> > and use ASID 0 for legacy mode map/umap
> >
> > So kernel here will not maintain the ioas_id from iommufd=EF=BC=8C
> > and this also make the code strange since there will 2 different asid
> > for the same AS, maybe we can save these information in the kernel
> > Thanks
> > cindy
> > > > Thanks
> > > > Cindy
> > > > > > +
> > > > > > +#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
> > > > > > +       _IOW(VHOST_VIRTIO, 0x82, struct vdpa_device_attach_iomm=
ufd_as)
> > > > > > +
> > > > > > +/*
> > > > > > + * VDPA_DEVICE_DETACH_IOMMUFD_AS
> > > > > > + *
> > > > > > + * Detach a vdpa device from the iommufd address space it has =
been
> > > > > > + * attached to. After it, device should be in a blocking DMA s=
tate.
> > > > > > + *
> > > > > > + * Available only after a device has been bound to iommufd via
> > > > > > + * VHOST_VDPA_SET_IOMMU_FD
> > > > > > + *
> > > > > > + * @argsz:     user filled size of this data.
> > > > > > + * @flags:     must be 0.
> > > > > > + *
> > > > > > + * Return: 0 on success, -errno on failure.
> > > > > > + */
> > > > > > +struct vdpa_device_detach_iommufd_as {
> > > > > > +       __u32 argsz;
> > > > > > +       __u32 flags;
> > > > > > +};
> > > > > > +
> > > > > > +#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
> > > > > > +       _IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_iomm=
ufd_as)
> > > > > > +
> > > > > >  #endif
> > > > > > --
> > > > > > 2.34.3
> > > > > >
> > > > >
> > > >
> > >
> >

