Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D126480E359
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjLLEfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjLLEfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:35:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9997E4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702355718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3VntsOLPXuWJtx6zQj2tvFN5GConn9kSc0M72tw246g=;
        b=Cc5vElkisxoK69ivsjqSWMAO8XihsssD89GJlz2F/iOPTlG68FZI0MLdZrTQdZJ9v8881+
        3mfbQ7R9mC3wVVExoKqYkoS80lxRw6oThwULWX02SrD5v5/siUhAk4tjBr9OYkZSym233v
        Dtg2wzvT9iO3HH4coAjPVPtjC+4dCXk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-4jjlgN0XO7y6H0mIsrqFbQ-1; Mon, 11 Dec 2023 23:35:16 -0500
X-MC-Unique: 4jjlgN0XO7y6H0mIsrqFbQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77f41dc15b7so665592985a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702355716; x=1702960516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VntsOLPXuWJtx6zQj2tvFN5GConn9kSc0M72tw246g=;
        b=ayLy+jNeDy3Q14T/TnO7Wrwj+tPUkoeDu+JAO4mdwFwi+9uYslOP8UZYWOga4dqKP6
         jbAxiXfU1qEFL1ezx+ma/s4odkcqpI+OJrNhtN/pWtUq+GN6QpNASqEzHGO57KKh0HxS
         veLcTQKITN6zl93RQ8uLuS+qBaGjiU8NAgn7QsRKVSiZcr9GFvRim0ekYvpDy5roK2WZ
         TzH8nsXxY9S3Gq71eAdtj6L8oI2JYpXQkJidmL4+JbLPOPSr2aoCIjjwlRSczAxb8BN4
         i6btVmLEJw+pKqGZAseQliQ7CA9UMpF3pwrANymjxW49NpWdz33lxCzDwJauwJCqMQp5
         USgA==
X-Gm-Message-State: AOJu0YyEoGm7UCNcXXfOkvooS98MeLUMxzLg3fesgtb4rCKzw5eL5KXw
        qT3A/eBuhJJXmLYAN4UFKJbM6cQfF7ofNAZz2keXAlyPz3R147Inh29k/0/HFt5oCA3kq3Y9wn9
        51itdRJy/Lae3U0UPAZ7TpFPyE6S+/2Rjr/aJZ+3S
X-Received: by 2002:a05:620a:4614:b0:77f:6dd:4dba with SMTP id br20-20020a05620a461400b0077f06dd4dbamr8523579qkb.96.1702355716174;
        Mon, 11 Dec 2023 20:35:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrOyuf1Odoaak2ZYdtgyzyZFIpFfyG35pal8NbvcJN0xXVIGcCgktqW+IfyPOYVkS+zor94oNUfe4BlGyRZ3A=
X-Received: by 2002:a05:620a:4614:b0:77f:6dd:4dba with SMTP id
 br20-20020a05620a461400b0077f06dd4dbamr8523573qkb.96.1702355715908; Mon, 11
 Dec 2023 20:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20231205113444.63015-1-linyunsheng@huawei.com>
 <20231205113444.63015-7-linyunsheng@huawei.com> <CACGkMEvVezZnHK-gRWY+MUd_6awnprb024scqPNmMQ05P8rWTQ@mail.gmail.com>
 <424670ab-23d8-663b-10cb-d88906767956@huawei.com>
In-Reply-To: <424670ab-23d8-663b-10cb-d88906767956@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 12 Dec 2023 12:35:04 +0800
Message-ID: <CACGkMEsMdP1B-9RaqibJYfFsd_qJpB+Kta5BnyD_WXH=W2w_OQ@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] tools: virtio: introduce vhost_net_test
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 7:28=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2023/12/7 14:00, Jason Wang wrote:
> > On Tue, Dec 5, 2023 at 7:35=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> ...
>
> >> +
> >> +static int tun_alloc(void)
> >> +{
> >> +       struct ifreq ifr;
> >> +       int fd, e;
> >> +
> >> +       fd =3D open("/dev/net/tun", O_RDWR);
> >> +       if (fd < 0) {
> >> +               perror("Cannot open /dev/net/tun");
> >> +               return fd;
> >> +       }
> >> +
> >> +       memset(&ifr, 0, sizeof(ifr));
> >> +
> >> +       ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
> >
> > Why did you use IFF_TUN but not IFF_TAP here?
>
> To be honest, no particular reason, I just picked IFF_TUN and it happened
> to work for me to test changing in vhost_net_build_xdp().
>
> Is there a particular reason you perfer the IFF_TAP over IFF_TUN?

No preference here. It only matters if you want to test L2 or L3.


>
> >
> >> +       strncpy(ifr.ifr_name, "tun0", IFNAMSIZ);
> >
> > tun0 is pretty common if there's a VPN. Do we need some randomized name=
 here?
>
> How about something like below?
>
> snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
>
> >
> >
> >> +
> >> +       e =3D ioctl(fd, TUNSETIFF, (void *) &ifr);
> >> +       if (e < 0) {
> >> +               perror("ioctl[TUNSETIFF]");
> >> +               close(fd);
> >> +               return e;
> >> +       }
> >> +
> >> +       return fd;
> >> +}
> >> +
> >> +/* Unused */
> >> +void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> >
> > Why do we need trick like these here?
>
> That is because of the below error:
> tools/virtio/./linux/kernel.h:58: undefined reference to `__kmalloc_fake'
>
> when virtio_ring.c is compiled in the userspace, the kmalloc raleted func=
tion
> is implemented in tools/virtio/./linux/kernel.h, which requires those var=
ibles
> to be defined.
>
> >
> >> +
> >> +struct vq_info {
> >> +       int kick;
> >> +       int call;
> >> +       int num;
> >> +       int idx;
> >> +       void *ring;
> >> +       /* copy used for control */
> >> +       struct vring vring;
> >> +       struct virtqueue *vq;
> >> +};
> >> +
> >> +struct vdev_info {
> >> +       struct virtio_device vdev;
> >> +       int control;
> >> +       struct pollfd fds[1];
> >> +       struct vq_info vqs[1];
> >> +       int nvqs;
> >> +       void *buf;
> >> +       size_t buf_size;
> >> +       struct vhost_memory *mem;
> >> +};
> >> +
> >> +static struct vhost_vring_file no_backend =3D { .index =3D 1, .fd =3D=
 -1 },
> >> +                                    backend =3D { .index =3D 1, .fd =
=3D 1 };
> >
> > A magic number like fd =3D 1 is pretty confusing.
> >
> > And I don't see why we need global variables here.
>
> I was using the virtio_test.c as reference, will try to remove it
> if it is possible.
>
> >
> >> +static const struct vhost_vring_state null_state =3D {};
> >> +
>
> ..
>
> >> +
> >> +done:
> >> +       backend.fd =3D tun_alloc();
> >> +       assert(backend.fd >=3D 0);
> >> +       vdev_info_init(&dev, features);
> >> +       vq_info_add(&dev, 256);
> >> +       run_test(&dev, &dev.vqs[0], delayed, batch, reset, nbufs);
> >
> > I'd expect we are testing some basic traffic here. E.g can we use a
> > packet socket then we can test both tx and rx?
>
> Yes, only rx for tun is tested.
> Do you have an idea how to test the tx too? As I am not familar enough
> with vhost_net and tun yet.

Maybe you can have a packet socket to bind to the tun/tap. Then you can tes=
t:

1) TAP RX: by write a packet via virtqueue through vhost_net and read
it from packet socket
2) TAP TX:  by write via packet socket and read it from the virtqueue
through vhost_net

Thanks

>
> >
> > Thanks
>

