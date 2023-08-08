Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772E17741D9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjHHR3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjHHR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AA420D25
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691511072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9kc7HdgyVBlkH2G96tmXBgYeeZK+6xmO5vsQNUcbsFM=;
        b=i3z/JRj7lLSXhrDNSSucgkTX0jBzHnJm+lx0wrSlhhmOezhbsw+59ZXnoi9yDXvcaOl2ll
        rMvgADnFq1k8P3nXcaKwn0oJz39gkMB6jjGqwLWKCJrKZP0BCuuTtq7vs69VKC4y2FhBHV
        V374jEyP5ZjET/M4RUAj9QVBsvyxNwM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-8o91E5PYOcG4kAUIGdV8Rg-1; Tue, 08 Aug 2023 02:05:23 -0400
X-MC-Unique: 8o91E5PYOcG4kAUIGdV8Rg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b961c3af8fso57694301fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 23:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691474721; x=1692079521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kc7HdgyVBlkH2G96tmXBgYeeZK+6xmO5vsQNUcbsFM=;
        b=LFDaBoPk/mKt7v1EfSqwJvh0Sy9jsuF116LzkSuN6xKb6r4GBIuRoF1ckOi3abxY9b
         r9FJ7dSApQt2j2HyNigrt+cnaamRrxU9PbXTZo5R/G1KtrfzeqCgd3Lo21kjDOusiPls
         7j0WxNPT9B6crT9AjMY4foCamRnYcG8Fb942H6fZto+A8x0PcgmjgpbB9hX9fGRUHR+7
         v0U3QiZVWj79RlYxSy0PvYofF60zQIU3h5qlJUlKjZWpbjcLAMJWEsCoj+JkQ8syd7VY
         T8Zha/fELdLbKgexgrL2zxxqk0Iny4EvUcGdHAyGR89mvM8jXxjCHrLC5HAlkXOHTXXy
         sB9w==
X-Gm-Message-State: AOJu0YzqXztgM99alktrJ53H5IAJO2cuEaStPIN/v8PdYKPeXYSq+pPe
        rx/+zIwVojs8vWMBaHXBbjuG9TU1+p+NfGXm3sRq0vGA5VTkE55fJjbmCNhfmcguNJh0W8NHX5J
        7K8dCO2izj+zXx/ExTKcicKw0IZ6Wk5QGi/Qm0ZIbIk7KJgZc/+r9iw==
X-Received: by 2002:a2e:95cf:0:b0:2b6:a763:5d13 with SMTP id y15-20020a2e95cf000000b002b6a7635d13mr8050847ljh.27.1691474721201;
        Mon, 07 Aug 2023 23:05:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiP1K3KaY4fH3OT7fEtJD+5UYQiOzlccf24StuAMCOgCgXaVL9bF0+CUaBC+LBT9HuQ1Po/V2Z3r5eXRjphbk=
X-Received: by 2002:a2e:95cf:0:b0:2b6:a763:5d13 with SMTP id
 y15-20020a2e95cf000000b002b6a7635d13mr8050828ljh.27.1691474720898; Mon, 07
 Aug 2023 23:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
 <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com> <20230808015921-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230808015921-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 8 Aug 2023 14:05:09 +0800
Message-ID: <CACGkMEtmLi97_6HjcSe9Wuo-BuEZTG3ZRxTHsbt8OUMgNNvwTg@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Yuan Yao <yuanyaogoog@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Takaya Saeki <takayas@chromium.org>,
        Junichi Uekawa <uekawa@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Tiwei Bie <tiwei.bie@intel.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 1:59=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Aug 08, 2023 at 01:43:02PM +0800, Jason Wang wrote:
> > On Tue, Aug 8, 2023 at 1:11=E2=80=AFPM Yuan Yao <yuanyaogoog@chromium.o=
rg> wrote:
> > >
> > > In current packed virtqueue implementation, the avail_wrap_counter wo=
n't
> > > flip, in the case when the driver supplies a descriptor chain with a
> > > length equals to the queue size; total_sg =3D=3D vq->packed.vring.num=
.
> > >
> > > Let=E2=80=99s assume the following situation:
> > > vq->packed.vring.num=3D4
> > > vq->packed.next_avail_idx: 1
> > > vq->packed.avail_wrap_counter: 0
> > >
> > > Then the driver adds a descriptor chain containing 4 descriptors.
> > >
> > > We expect the following result with avail_wrap_counter flipped:
> > > vq->packed.next_avail_idx: 1
> > > vq->packed.avail_wrap_counter: 1
> > >
> > > But, the current implementation gives the following result:
> > > vq->packed.next_avail_idx: 1
> > > vq->packed.avail_wrap_counter: 0
> > >
> > > To reproduce the bug, you can set a packed queue size as small as
> > > possible, so that the driver is more likely to provide a descriptor
> > > chain with a length equal to the packed queue size. For example, in
> > > qemu run following commands:
> > > sudo qemu-system-x86_64 \
> > > -enable-kvm \
> > > -nographic \
> > > -kernel "path/to/kernel_image" \
> > > -m 1G \
> > > -drive file=3D"path/to/rootfs",if=3Dnone,id=3Ddisk \
> > > -device virtio-blk,drive=3Ddisk \
> > > -drive file=3D"path/to/disk_image",if=3Dnone,id=3Drwdisk \
> > > -device virtio-blk,drive=3Drwdisk,packed=3Don,queue-size=3D4,\
> > > indirect_desc=3Doff \
> > > -append "console=3DttyS0 root=3D/dev/vda rw init=3D/bin/bash"
> > >
> > > Inside the VM, create a directory and mount the rwdisk device on it. =
The
> > > rwdisk will hang and mount operation will not complete.
> > >
> > > This commit fixes the wrap counter error by flipping the
> > > packed.avail_wrap_counter, when start of descriptor chain equals to t=
he
> > > end of descriptor chain (head =3D=3D i).
> > >
> > > Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
> > > Signed-off-by: Yuan Yao <yuanyaogoog@chromium.org>
> > > ---
> > >
> > >  drivers/virtio/virtio_ring.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index c5310eaf8b46..da1150d127c2 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1461,7 +1461,7 @@ static inline int virtqueue_add_packed(struct v=
irtqueue *_vq,
> > >                 }
> > >         }
> > >
> > > -       if (i < head)
> > > +       if (i <=3D head)
> > >                 vq->packed.avail_wrap_counter ^=3D 1;
> >
> > Would it be better to move the flipping to the place where we flip
> > avail_used_flags?
>
> I think I prefer this patch for stable, refactoring can
> be done on top.

Ok. So

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> >                         if ((unlikely(++i >=3D vq->packed.vring.num))) =
{
> >                                 i =3D 0;
> >                                 vq->packed.avail_used_flags ^=3D
> >                                         1 << VRING_PACKED_DESC_F_AVAIL =
|
> >                                         1 << VRING_PACKED_DESC_F_USED;
> >                         }
> >
> > Thanks
> >
> > >
> > >         /* We're using some buffers from the free list. */
> > > --
> > > 2.41.0.640.ga95def55d0-goog
> > >
>

