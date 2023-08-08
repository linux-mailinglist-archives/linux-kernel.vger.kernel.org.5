Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBAE773D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjHHQN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjHHQMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685657DA2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691509605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BESHa93GYbY84ybTy6DiDjuyKqGgnqcUoefmzBrlBBs=;
        b=QUtCjFCcbuOCTOfEM0aiS9uooneVKawslD1QAB+VLo9JOCfutmIOpNVThxYekyRtLQJe0U
        IoPyQj6gFUrnhTKE/ZqCWOwrQPCCGk27zElVMjjvvbgerl2Gmas1i7grar+9VdeII0VjTJ
        9JfHK7NSFcsEFZrr/M3s/3nu57ZKRXk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-ysE1qgtVMoa_jz4fSsyv5A-1; Tue, 08 Aug 2023 01:43:15 -0400
X-MC-Unique: ysE1qgtVMoa_jz4fSsyv5A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9bb2d0b47so22987871fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 22:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691473394; x=1692078194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BESHa93GYbY84ybTy6DiDjuyKqGgnqcUoefmzBrlBBs=;
        b=Fro8JYDSD86rbbXJVU3N9IwD9/QfqV9S4LfFqNzIbPHu8npRafcaE8J+gXVBG3FQ2h
         x+KnEQQrLN6TyDM03Twa5k6giKlRkDFZqRYhj51prZnCNaY3T1C6/d6J+hIdaJB0lUAR
         Po3d3jl2x4QIZgwDeD+qyWb3FDeNqt8Si0aWCPiXpHkrbVMmLxGMYWQ3+/MMJjrrIciS
         2Qa9ncz0Qu54o0g+3FN+S+/WW+la76hjUGiD0acw4VGS0YTtkAtqj8KegJs9DR1CyFCu
         l/P59OjOh1Qdi42zFKDlDoJBznWaRyhYJFKo/1DHFmdrjJ1xsH0/J41Tf/aQd7x2azev
         KdZg==
X-Gm-Message-State: AOJu0YxAtUYFG3683ClM1vGEMt77CL/0dkdU/jEScparEQ+YF6+a/pTO
        hyD7R/h06TAs4aHvvBYkB93n6WbHFbWaDR9QKGu3mirJFHr47Oj8lhQnWCylzZqQGv62HbRTibu
        pAQrh4n5UQmXDMRRG56qSEmpWOlQyY+LEhKQHMYDj
X-Received: by 2002:a2e:b0c6:0:b0:2b9:ea6b:64b with SMTP id g6-20020a2eb0c6000000b002b9ea6b064bmr7653475ljl.37.1691473394479;
        Mon, 07 Aug 2023 22:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC3CMhrHkub5YyRmarmFcgNYvSaMyar7Cls/hDMGwrfWldVQTbBjZJZpfo0Bq4s7X6uNnT1QxvJlAHvmqZytw=
X-Received: by 2002:a2e:b0c6:0:b0:2b9:ea6b:64b with SMTP id
 g6-20020a2eb0c6000000b002b9ea6b064bmr7653462ljl.37.1691473394165; Mon, 07 Aug
 2023 22:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
In-Reply-To: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 8 Aug 2023 13:43:02 +0800
Message-ID: <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 1:11=E2=80=AFPM Yuan Yao <yuanyaogoog@chromium.org> =
wrote:
>
> In current packed virtqueue implementation, the avail_wrap_counter won't
> flip, in the case when the driver supplies a descriptor chain with a
> length equals to the queue size; total_sg =3D=3D vq->packed.vring.num.
>
> Let=E2=80=99s assume the following situation:
> vq->packed.vring.num=3D4
> vq->packed.next_avail_idx: 1
> vq->packed.avail_wrap_counter: 0
>
> Then the driver adds a descriptor chain containing 4 descriptors.
>
> We expect the following result with avail_wrap_counter flipped:
> vq->packed.next_avail_idx: 1
> vq->packed.avail_wrap_counter: 1
>
> But, the current implementation gives the following result:
> vq->packed.next_avail_idx: 1
> vq->packed.avail_wrap_counter: 0
>
> To reproduce the bug, you can set a packed queue size as small as
> possible, so that the driver is more likely to provide a descriptor
> chain with a length equal to the packed queue size. For example, in
> qemu run following commands:
> sudo qemu-system-x86_64 \
> -enable-kvm \
> -nographic \
> -kernel "path/to/kernel_image" \
> -m 1G \
> -drive file=3D"path/to/rootfs",if=3Dnone,id=3Ddisk \
> -device virtio-blk,drive=3Ddisk \
> -drive file=3D"path/to/disk_image",if=3Dnone,id=3Drwdisk \
> -device virtio-blk,drive=3Drwdisk,packed=3Don,queue-size=3D4,\
> indirect_desc=3Doff \
> -append "console=3DttyS0 root=3D/dev/vda rw init=3D/bin/bash"
>
> Inside the VM, create a directory and mount the rwdisk device on it. The
> rwdisk will hang and mount operation will not complete.
>
> This commit fixes the wrap counter error by flipping the
> packed.avail_wrap_counter, when start of descriptor chain equals to the
> end of descriptor chain (head =3D=3D i).
>
> Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
> Signed-off-by: Yuan Yao <yuanyaogoog@chromium.org>
> ---
>
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c5310eaf8b46..da1150d127c2 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1461,7 +1461,7 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>                 }
>         }
>
> -       if (i < head)
> +       if (i <=3D head)
>                 vq->packed.avail_wrap_counter ^=3D 1;

Would it be better to move the flipping to the place where we flip
avail_used_flags?

                        if ((unlikely(++i >=3D vq->packed.vring.num))) {
                                i =3D 0;
                                vq->packed.avail_used_flags ^=3D
                                        1 << VRING_PACKED_DESC_F_AVAIL |
                                        1 << VRING_PACKED_DESC_F_USED;
                        }

Thanks

>
>         /* We're using some buffers from the free list. */
> --
> 2.41.0.640.ga95def55d0-goog
>

