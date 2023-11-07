Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F5D7E356D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjKGG6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjKGG6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:58:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4301FC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699340274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2UKkJWw0ipJp0+eK2cyF9Tytq76jRoBcGjC8u2Fp/zg=;
        b=DCPE91w/zKYcRkYQHBNpBuJo2aodXEt3bkEVB6PSnoFEzrbELraJSdDmSEgfdVgBkUroqM
        PaR9RykiCdv6C6+t1JOd19was+tTJUqYrMBPv64Ag8fq2R/FXLWbk/KVUINSXQ5Ax6NJUp
        ruYNVDMLPYefwWZRddNzD4oJzCa4TR0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-NO9gHCv3NVyAC6vNEWfQPw-1; Tue, 07 Nov 2023 01:57:43 -0500
X-MC-Unique: NO9gHCv3NVyAC6vNEWfQPw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9be601277c2so382239166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 22:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699340262; x=1699945062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UKkJWw0ipJp0+eK2cyF9Tytq76jRoBcGjC8u2Fp/zg=;
        b=A7jppv5aJTZoGLFZ+Fkun9CMyb7MD4jKtbNNLfG+GHW1lzjCucS+J2MLzF8cZc8oBw
         ZaMSg5yRqtBa/uvfkLT6/XeAJCHw2xdk2/KWICs2ugP5L8p6N5zXNzmuB0Q1TxoX+oFo
         /Iq1b1Aux8roUepZgdPH++HcMmaS1ME9KWdEdGHx0bepOE0GHsw+hRoph53BsPsEhJFA
         mzuP9ongcOnVwhFw/Xm5ywXiRPWWqsFt6Cp3KRExA/BhyPPnHBHDMB5/4TCJTFfoG0ss
         iIQTx/Tc77fhbkDwlD3MnB2vIBGjDTn0Z7RvfWp9Ahwp1yfUEuCmuq/2N9x35QhI3qGM
         mOLQ==
X-Gm-Message-State: AOJu0YyEB66tlA7ykjs6+eNOrjs8sODJqDGsGOl32VddRPXPpFUks2KZ
        P4rKNtnrtLZaSkdaFM9t5zh2hx8j4mXdBb0dBsSlSfPNRRJmN8t4393J6Uz8QuoEke9cqkaSX8v
        STaJao+i+nVKizmVNe/IRegnzuZd7aiOCBr8v2XZJ
X-Received: by 2002:a17:907:2da7:b0:9dd:f00d:c4e5 with SMTP id gt39-20020a1709072da700b009ddf00dc4e5mr7921447ejc.53.1699340262196;
        Mon, 06 Nov 2023 22:57:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpoDaO1jLLW4JPf6quOD7RvrGAVMZGCINfmMiWH9FieITjURg9fW1hcoakgE4F7vstqKhiYiv0ExnE/IcXagg=
X-Received: by 2002:a17:907:2da7:b0:9dd:f00d:c4e5 with SMTP id
 gt39-20020a1709072da700b009ddf00dc4e5mr7921431ejc.53.1699340261949; Mon, 06
 Nov 2023 22:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
 <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com>
In-Reply-To: <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Tue, 7 Nov 2023 14:57:04 +0800
Message-ID: <CACLfguX9-wEQPUyZkJZoRMmgPDRFNyZCmt0nvHROhyP1yooiYA@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 3:30=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
> >
> > VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommufd
> > address space specified by IOAS id.
> >
> > VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> > from the iommufd address space
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
>
> [...]
>
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index f5c48b61ab62..07e1b2c443ca 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -219,4 +219,70 @@
> >   */
> >  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
> >
> > +/* vhost_vdpa_set_iommufd
> > + * Input parameters:
> > + * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
> > + * @iommufd_ioasid: IOAS identifier returned from ioctl(IOMMU_IOAS_ALL=
OC)
> > + * Output parameters:
> > + * @out_dev_id: device identifier
> > + */
> > +struct vhost_vdpa_set_iommufd {
> > +       __s32 iommufd;
> > +       __u32 iommufd_ioasid;
> > +       __u32 out_dev_id;
> > +};
> > +
> > +#define VHOST_VDPA_SET_IOMMU_FD \
> > +       _IOW(VHOST_VIRTIO, 0x7F, struct vhost_vdpa_set_iommufd)
> > +
> > +/*
> > + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> > + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as)
> > + *
> > + * Attach a vdpa device to an iommufd address space specified by IOAS
> > + * id.
> > + *
> > + * Available only after a device has been bound to iommufd via
> > + * VHOST_VDPA_SET_IOMMU_FD
> > + *
> > + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> > + *
> > + * @argsz:     user filled size of this data.
> > + * @flags:     must be 0.
> > + * @ioas_id:   Input the target id which can represent an ioas
> > + *             allocated via iommufd subsystem.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +struct vdpa_device_attach_iommufd_as {
> > +       __u32 argsz;
> > +       __u32 flags;
> > +       __u32 ioas_id;
> > +};
>
> I think we need to map ioas to vDPA AS, so there should be an ASID
> from the view of vDPA?
>
> Thanks
>
The qemu will have a structure save and  maintain this information,So
I didn't add this
 in kernel=EF=BC=8Cwe can add this but maybe only for check?
this in
Thanks
Cindy
> > +
> > +#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
> > +       _IOW(VHOST_VIRTIO, 0x82, struct vdpa_device_attach_iommufd_as)
> > +
> > +/*
> > + * VDPA_DEVICE_DETACH_IOMMUFD_AS
> > + *
> > + * Detach a vdpa device from the iommufd address space it has been
> > + * attached to. After it, device should be in a blocking DMA state.
> > + *
> > + * Available only after a device has been bound to iommufd via
> > + * VHOST_VDPA_SET_IOMMU_FD
> > + *
> > + * @argsz:     user filled size of this data.
> > + * @flags:     must be 0.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +struct vdpa_device_detach_iommufd_as {
> > +       __u32 argsz;
> > +       __u32 flags;
> > +};
> > +
> > +#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
> > +       _IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_iommufd_as)
> > +
> >  #endif
> > --
> > 2.34.3
> >
>

