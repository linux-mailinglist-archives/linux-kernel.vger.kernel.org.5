Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75B7748C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbjHHTis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbjHHTic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88241B330
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691514642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOP3UCdxdZwBEyv5Fh6IklPdndMr9NfHjbDsFfTyZxg=;
        b=Pj+cJcT40PQghD4el1g2TJcPZwytNKtyBYirKp4TtXDg7pHhXbHRlL9/fNqfWn5eyAw/oI
        lIGdFikcsSymt5AuL6w/Ipi18HhCu0BalOxVKarcUFDMVRa7z62kgp6ulZXrrS9l0IK/vZ
        qPSKUJjR4i67E6DJXTjHjw+EABeUVmw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-yqOagaApP96XLXrep2J-nQ-1; Tue, 08 Aug 2023 02:05:46 -0400
X-MC-Unique: yqOagaApP96XLXrep2J-nQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fe67ea789eso1755371e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 23:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691474745; x=1692079545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOP3UCdxdZwBEyv5Fh6IklPdndMr9NfHjbDsFfTyZxg=;
        b=YUoPGuP0tx4BojHxFDDS8vdiZ9AgikdadqjibSWVqdXkBALPgpFX4Mda1YkSqdJoNC
         VL5CghzjNN2o9qxaphHIuvDq+sB6isoet0MJh/p176XzkmCfiwanTRir/4L7p5in7scL
         l5XoWElA4BKZfDuz2Px/DpanDK9gvrAlkdgzngUpSs9Rk1/xC3UDLNfO2JydexT3P5oo
         vg2VO9nemH1z67sSU2Trn27dmkscehXfCU4M2AhY7HhWl01CncmvdLXKvtboNzEt3VqW
         Sl8bRYImVoJRXcOYfYxGtMmfWtelEN+Qzwlfrg9ttQkPcRtWmGmQmHVJUm4m8U/NPgiL
         JpZQ==
X-Gm-Message-State: AOJu0YxBeIIPpySYf6iOx7st1oM7yHHScJA9FwP9OVFyK8U1JTzPhUhl
        hRNZj4riSx6EPTZmAEEEDP7w6DJyMjyNmxNlu//H7ii59M2JSOizYhTVlAMhbkjtbNS5WbGnzjL
        ierRW+g34AU3zdCLIkP6hFlumovf/4ULl8rToqh8R
X-Received: by 2002:a2e:8706:0:b0:2b9:35ae:c9ac with SMTP id m6-20020a2e8706000000b002b935aec9acmr8985884lji.2.1691474745524;
        Mon, 07 Aug 2023 23:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB4FPK57NJCdoZAr7GH4lSTDvxl2Rj2fwo8dADkTNUUpuVR63YX0D/XhSN8Y3+/z7/PQBLD/VqAsN3jEoWoXA=
X-Received: by 2002:a2e:8706:0:b0:2b9:35ae:c9ac with SMTP id
 m6-20020a2e8706000000b002b935aec9acmr8985864lji.2.1691474745305; Mon, 07 Aug
 2023 23:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
 <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com> <CAOJyEHaXqmHStJnHrT0H4QsTJBxjBxVe+33EuWm9H3wApPKtxQ@mail.gmail.com>
In-Reply-To: <CAOJyEHaXqmHStJnHrT0H4QsTJBxjBxVe+33EuWm9H3wApPKtxQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 8 Aug 2023 14:05:34 +0800
Message-ID: <CACGkMEuiVnLFRRDHaTH3Jnpr+znU9L33gLyRynbBabVqumN2ug@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
To:     Yuan Yao <yuanyaogoog@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Takaya Saeki <takayas@chromium.org>,
        Junichi Uekawa <uekawa@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 1:59=E2=80=AFPM Yuan Yao <yuanyaogoog@chromium.org> =
wrote:
>
> Since there is a check for 0-length chain in code;BUG_ON(total_sg =3D=3D =
0), we won=E2=80=99t get a 0-length chain in practice. So, I think use (i <=
=3D head) makes the commit as small as possible.

Ok, offered ack in other mail.

Thanks

>
>
> Best regards
>
>
>
> On Tue, Aug 8, 2023 at 2:43=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>>
>> On Tue, Aug 8, 2023 at 1:11=E2=80=AFPM Yuan Yao <yuanyaogoog@chromium.or=
g> wrote:
>> >
>> > In current packed virtqueue implementation, the avail_wrap_counter won=
't
>> > flip, in the case when the driver supplies a descriptor chain with a
>> > length equals to the queue size; total_sg =3D=3D vq->packed.vring.num.
>> >
>> > Let=E2=80=99s assume the following situation:
>> > vq->packed.vring.num=3D4
>> > vq->packed.next_avail_idx: 1
>> > vq->packed.avail_wrap_counter: 0
>> >
>> > Then the driver adds a descriptor chain containing 4 descriptors.
>> >
>> > We expect the following result with avail_wrap_counter flipped:
>> > vq->packed.next_avail_idx: 1
>> > vq->packed.avail_wrap_counter: 1
>> >
>> > But, the current implementation gives the following result:
>> > vq->packed.next_avail_idx: 1
>> > vq->packed.avail_wrap_counter: 0
>> >
>> > To reproduce the bug, you can set a packed queue size as small as
>> > possible, so that the driver is more likely to provide a descriptor
>> > chain with a length equal to the packed queue size. For example, in
>> > qemu run following commands:
>> > sudo qemu-system-x86_64 \
>> > -enable-kvm \
>> > -nographic \
>> > -kernel "path/to/kernel_image" \
>> > -m 1G \
>> > -drive file=3D"path/to/rootfs",if=3Dnone,id=3Ddisk \
>> > -device virtio-blk,drive=3Ddisk \
>> > -drive file=3D"path/to/disk_image",if=3Dnone,id=3Drwdisk \
>> > -device virtio-blk,drive=3Drwdisk,packed=3Don,queue-size=3D4,\
>> > indirect_desc=3Doff \
>> > -append "console=3DttyS0 root=3D/dev/vda rw init=3D/bin/bash"
>> >
>> > Inside the VM, create a directory and mount the rwdisk device on it. T=
he
>> > rwdisk will hang and mount operation will not complete.
>> >
>> > This commit fixes the wrap counter error by flipping the
>> > packed.avail_wrap_counter, when start of descriptor chain equals to th=
e
>> > end of descriptor chain (head =3D=3D i).
>> >
>> > Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
>> > Signed-off-by: Yuan Yao <yuanyaogoog@chromium.org>
>> > ---
>> >
>> >  drivers/virtio/virtio_ring.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring=
.c
>> > index c5310eaf8b46..da1150d127c2 100644
>> > --- a/drivers/virtio/virtio_ring.c
>> > +++ b/drivers/virtio/virtio_ring.c
>> > @@ -1461,7 +1461,7 @@ static inline int virtqueue_add_packed(struct vi=
rtqueue *_vq,
>> >                 }
>> >         }
>> >
>> > -       if (i < head)
>> > +       if (i <=3D head)
>> >                 vq->packed.avail_wrap_counter ^=3D 1;
>>
>> Would it be better to move the flipping to the place where we flip
>> avail_used_flags?
>>
>>                         if ((unlikely(++i >=3D vq->packed.vring.num))) {
>>                                 i =3D 0;
>>                                 vq->packed.avail_used_flags ^=3D
>>                                         1 << VRING_PACKED_DESC_F_AVAIL |
>>                                         1 << VRING_PACKED_DESC_F_USED;
>>                         }
>>
>> Thanks
>>
>> >
>> >         /* We're using some buffers from the free list. */
>> > --
>> > 2.41.0.640.ga95def55d0-goog
>> >
>>

