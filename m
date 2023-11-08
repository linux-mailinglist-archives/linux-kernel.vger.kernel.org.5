Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405377E4F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbjKHDEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 22:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKHDEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:04:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CDC10DA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 19:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699412607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdkmOE2i/X8mF+g84XXuwPONDq0bjsNF8/LqNbQhs1I=;
        b=eqFoHOPvQKYnNNXrkTzQWnwzRqN2KGSdfuAQgiz6bvtoU3yWvkYw9tHhzrBmg77c1OjcRw
        /qh32ZUfyDZslw/JdEdBUQIIULnQcHw4rIZ8h+0U9awe5jtvugd0jbDdxdN9jhsy02+nh2
        yCsaWd4C+wNYLqPZ2zkQRsGUxfV9C0I=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-n8xinL__MbSGul4HK1Zmlw-1; Tue, 07 Nov 2023 22:03:25 -0500
X-MC-Unique: n8xinL__MbSGul4HK1Zmlw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50948f24d14so6623310e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 19:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699412604; x=1700017404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdkmOE2i/X8mF+g84XXuwPONDq0bjsNF8/LqNbQhs1I=;
        b=no9Sclh06ro6XlJDhXKTc8wPj4fEYSGLnGJAzLUthPckxBHqlgDjrb18eyZvOhku76
         qinu8vOpQjlY58wYiZCd8b5pfqI7TgLnM8Ag06KLXWi3B72bpKnLosmf9sMU3rEBNcV8
         Q5RqxQw/UFpvdw0nlwB6cGPe72bPIalIDoNCUh5N6s+/y+W6+QPF8oP9aebaS1qJvNuY
         D0vSi65PZsUz1nvMNrJAoHDHR12Puypxu0eyOn1t7t2Ufp4zwIOv5BNz8SBB/AFXmoZp
         3C2uLTFtP3WsNv6aEBB9szL3L3mZALbdbgsrqDeRHztp/uR4hu2T5sCdX2iGMjJed3an
         lI3A==
X-Gm-Message-State: AOJu0Yw8ACVVKsxpdfQLecUciAGNFFQKpKbmDy8rCcFaGCAEy7gmeDVL
        QY9x4I3vE6NFNN2nqV5nhn/A1R/207+771aSUE+0k1h4rqbyQzbQF7hWDzynwYayjCOsPmMWTqI
        YHTkR/hs2HOS8jnf3uEUcJ9Qj45qGDOdrupziLBdqF2PIU7ZaJsg=
X-Received: by 2002:ac2:593b:0:b0:507:9a33:f105 with SMTP id v27-20020ac2593b000000b005079a33f105mr225716lfi.69.1699412604000;
        Tue, 07 Nov 2023 19:03:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfDeEEm3NoVSDw//ZEF2zrrCfMM8SZhj75WuhxEmVScFVNfxLlrPPD9qUMwz+h8100tBYfGU3SiaSXtv2KmjY=
X-Received: by 2002:ac2:593b:0:b0:507:9a33:f105 with SMTP id
 v27-20020ac2593b000000b005079a33f105mr225701lfi.69.1699412603658; Tue, 07 Nov
 2023 19:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
 <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com> <CACLfguX9-wEQPUyZkJZoRMmgPDRFNyZCmt0nvHROhyP1yooiYA@mail.gmail.com>
In-Reply-To: <CACLfguX9-wEQPUyZkJZoRMmgPDRFNyZCmt0nvHROhyP1yooiYA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 8 Nov 2023 11:03:12 +0800
Message-ID: <CACGkMEsp_rg+_01hwxCtZNOk2itB1L89mdOc1W1DG3umfEt5bw@mail.gmail.com>
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

On Tue, Nov 7, 2023 at 2:57=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, Nov 6, 2023 at 3:30=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> > >
> > > VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
> > >
> > > VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommufd
> > > address space specified by IOAS id.
> > >
> > > VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> > > from the iommufd address space
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> >
> > [...]
> >
> > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > index f5c48b61ab62..07e1b2c443ca 100644
> > > --- a/include/uapi/linux/vhost.h
> > > +++ b/include/uapi/linux/vhost.h
> > > @@ -219,4 +219,70 @@
> > >   */
> > >  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
> > >
> > > +/* vhost_vdpa_set_iommufd
> > > + * Input parameters:
> > > + * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
> > > + * @iommufd_ioasid: IOAS identifier returned from ioctl(IOMMU_IOAS_A=
LLOC)
> > > + * Output parameters:
> > > + * @out_dev_id: device identifier
> > > + */
> > > +struct vhost_vdpa_set_iommufd {
> > > +       __s32 iommufd;
> > > +       __u32 iommufd_ioasid;
> > > +       __u32 out_dev_id;
> > > +};
> > > +
> > > +#define VHOST_VDPA_SET_IOMMU_FD \
> > > +       _IOW(VHOST_VIRTIO, 0x7F, struct vhost_vdpa_set_iommufd)
> > > +
> > > +/*
> > > + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> > > + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as)
> > > + *
> > > + * Attach a vdpa device to an iommufd address space specified by IOA=
S
> > > + * id.
> > > + *
> > > + * Available only after a device has been bound to iommufd via
> > > + * VHOST_VDPA_SET_IOMMU_FD
> > > + *
> > > + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> > > + *
> > > + * @argsz:     user filled size of this data.
> > > + * @flags:     must be 0.
> > > + * @ioas_id:   Input the target id which can represent an ioas
> > > + *             allocated via iommufd subsystem.
> > > + *
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +struct vdpa_device_attach_iommufd_as {
> > > +       __u32 argsz;
> > > +       __u32 flags;
> > > +       __u32 ioas_id;
> > > +};
> >
> > I think we need to map ioas to vDPA AS, so there should be an ASID
> > from the view of vDPA?
> >
> > Thanks
> >
> The qemu will have a structure save and  maintain this information,So
> I didn't add this
>  in kernel=EF=BC=8Cwe can add this but maybe only for check?

I meant for example, a simulator has two AS. How can we attach an ioas
to a specific AS with the above uAPI?

Thanks

> this in
> Thanks
> Cindy
> > > +
> > > +#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
> > > +       _IOW(VHOST_VIRTIO, 0x82, struct vdpa_device_attach_iommufd_as=
)
> > > +
> > > +/*
> > > + * VDPA_DEVICE_DETACH_IOMMUFD_AS
> > > + *
> > > + * Detach a vdpa device from the iommufd address space it has been
> > > + * attached to. After it, device should be in a blocking DMA state.
> > > + *
> > > + * Available only after a device has been bound to iommufd via
> > > + * VHOST_VDPA_SET_IOMMU_FD
> > > + *
> > > + * @argsz:     user filled size of this data.
> > > + * @flags:     must be 0.
> > > + *
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +struct vdpa_device_detach_iommufd_as {
> > > +       __u32 argsz;
> > > +       __u32 flags;
> > > +};
> > > +
> > > +#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
> > > +       _IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_iommufd_as=
)
> > > +
> > >  #endif
> > > --
> > > 2.34.3
> > >
> >
>

