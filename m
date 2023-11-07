Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70137E3520
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjKGGQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKGGQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:16:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202D81B2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699337713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5dfPlyGlSo6QXgEoes79SduztR37OuOGMNtAn4fUdY=;
        b=AjcSOVMH8tahqlDSdd8aOBOF8nIRrNQa6xS4w9PlLXyjgN1Nr42DyGUuOPJm/rg54U8DhJ
        i/oNSUso5XmKp1PoOh548IRjHwxrh3ZwjiK1xrER2MfQnUSqFh5e7Nx8m+rn8yGAwqaUiS
        /wF6lSnANGLga/iH5clMSTgPP/+KqN0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-M86ae5FWPtuu5AqB4o0j0g-1; Tue, 07 Nov 2023 01:15:11 -0500
X-MC-Unique: M86ae5FWPtuu5AqB4o0j0g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54442ba286fso2173708a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 22:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699337710; x=1699942510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5dfPlyGlSo6QXgEoes79SduztR37OuOGMNtAn4fUdY=;
        b=HORGDPgLBT3calRBX+TCpxdvmkqTvogkuQDu4fB2jJ220ysg9kv1HVXnHnt7p/Ke7Q
         R3fYhQvcj7TUpDzWypAJirnBaf/Eu1PiWjf+ovyQMLoShuTaee0bQuZP/7smhveg4khm
         HoZTjsvMeALGsNGSrrcuDWQ6acLE1M55OaQ0blFhjyXeTyQdF+jpQeM+EM52TeM4RmTU
         hNSVZ6TfZjCpk+OesgGQRcmTIOQmf/G62L0Aw86jotmZBCl23MOoCvEma3c6q828rKQH
         pmCK4TcvzmG1nyRvomWK/2E0LMytS565Nj2Q0bpD5cDwG3ketKAw4oSuVaBy+BjL26ZU
         x4ew==
X-Gm-Message-State: AOJu0YzjhZ2LHqHoAWnQTeAH95uJHDsr6f8BNWi+UwX2B56pfDMFvzgj
        24sMDb40hDmpijGcezQhocYTXNeS9YvG8vbGFSyzFbNpIZtugq4ozeIvgmsK48KCwxKTeDZKLzm
        48nRPod/JQZ5jcweKr09epmf+RVw9TCURmVC83wL3
X-Received: by 2002:a17:907:807:b0:9c4:54c6:8030 with SMTP id wv7-20020a170907080700b009c454c68030mr15440738ejb.6.1699337710476;
        Mon, 06 Nov 2023 22:15:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhYPt3KYobO09KnF4S88gbLTgI2TypOVOaCV3ZqRCYa1d2hv0EALH/lOJVOq4QD+OvGxKCliEUGblAgoMpjDY=
X-Received: by 2002:a17:907:807:b0:9c4:54c6:8030 with SMTP id
 wv7-20020a170907080700b009c454c68030mr15440725ejb.6.1699337710161; Mon, 06
 Nov 2023 22:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-7-lulu@redhat.com>
 <12ebf6fc-9228-47a1-88dc-a177f7f7d5db@intel.com>
In-Reply-To: <12ebf6fc-9228-47a1-88dc-a177f7f7d5db@intel.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Tue, 7 Nov 2023 14:14:32 +0800
Message-ID: <CACLfguU8QcXJqXEg2zc47UoTzP=e58giUuX3O+hzO2HLfuxrXw@mail.gmail.com>
Subject: Re: [RFC v1 6/8] vdpa: change the map/unmap process to support iommufd
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 4:52=E2=80=AFPM Yi Liu <yi.l.liu@intel.com> wrote:
>
> On 2023/11/4 01:16, Cindy Lu wrote:
> > Add the check for iommufd_ictx,If vdpa don't have the iommufd_ictx
> > then will use the Legacy iommu domain pathway
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   drivers/vhost/vdpa.c | 43 ++++++++++++++++++++++++++++++++++++++-----
> >   1 file changed, 38 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index dfaddd833364..0e2dba59e1ce 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -1067,9 +1067,6 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, s=
truct vhost_iotlb *iotlb,
> >               /* Legacy iommu domain pathway without IOMMUFD */
> >               r =3D iommu_map(v->domain, iova, pa, size,
> >                             perm_to_iommu_flags(perm), GFP_KERNEL);
> > -     } else {
> > -             r =3D iommu_map(v->domain, iova, pa, size,
> > -                           perm_to_iommu_flags(perm), GFP_KERNEL);
> >       }
> >       if (r) {
> >               vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
> > @@ -1095,8 +1092,10 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *=
v,
> >       if (ops->set_map) {
> >               if (!v->in_batch)
> >                       ops->set_map(vdpa, asid, iotlb);
> > +     } else if (!vdpa->iommufd_ictx) {
> > +             /* Legacy iommu domain pathway without IOMMUFD */
> > +             iommu_unmap(v->domain, iova, size);
> >       }
> > -
> >   }
> >
> >   static int vhost_vdpa_va_map(struct vhost_vdpa *v,
> > @@ -1149,7 +1148,36 @@ static int vhost_vdpa_va_map(struct vhost_vdpa *=
v,
> >
> >       return ret;
> >   }
> > +#if 0
> > +int vhost_pin_pages(struct vdpa_device *device, dma_addr_t iova, int n=
page,
> > +                 int prot, struct page **pages)
> > +{
> > +     if (!pages || !npage)
> > +             return -EINVAL;
> > +     //if (!device->config->dma_unmap)
> > +     //return -EINVAL;
> > +
> > +     if (0) { //device->iommufd_access) {
> > +             int ret;
> > +
> > +             if (iova > ULONG_MAX)
> > +                     return -EINVAL;
> >
> > +             ret =3D iommufd_access_pin_pages(
> > +                     device->iommufd_access, iova, npage * PAGE_SIZE, =
pages,
> > +                     (prot & IOMMU_WRITE) ? IOMMUFD_ACCESS_RW_WRITE : =
0);
> > +             if (ret) {
> > +
> > +                     return ret;
> > +             }
> > +
> > +             return npage;
> > +     } else {
> > +             return pin_user_pages(iova, npage, prot, pages);
> > +     }
> > +     return -EINVAL;
> > +}
> > +#endif
>
> Is above code needed or not?
this code is for simulator=EF=BC=8C and this device still has some bugs I w=
ill
continue working in it,
Thanks
cindy
>
> >   static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
> >                            struct vhost_iotlb *iotlb,
> >                            u64 iova, u64 size, u64 uaddr, u32 perm)
> > @@ -1418,9 +1446,13 @@ static void vhost_vdpa_free_domain(struct vhost_=
vdpa *v)
> >       struct device *dma_dev =3D vdpa_get_dma_dev(vdpa);
> >
> >       if (v->domain) {
> > -             iommu_detach_device(v->domain, dma_dev);
> > +             if (!vdpa->iommufd_ictx) {
> > +                     iommu_detach_device(v->domain, dma_dev);
> > +             }
> >               iommu_domain_free(v->domain);
> >       }
> > +     if (vdpa->iommufd_ictx)
> > +             vdpa_iommufd_unbind(vdpa);
> >
> >       v->domain =3D NULL;
> >   }
> > @@ -1645,6 +1677,7 @@ static int vhost_vdpa_probe(struct vdpa_device *v=
dpa)
> >       }
> >
> >       atomic_set(&v->opened, 0);
> > +     atomic_set(&vdpa->iommufd_users, 0);
> >       v->minor =3D minor;
> >       v->vdpa =3D vdpa;
> >       v->nvqs =3D vdpa->nvqs;
>
> --
> Regards,
> Yi Liu
>

