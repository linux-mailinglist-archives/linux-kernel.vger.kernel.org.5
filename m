Return-Path: <linux-kernel+bounces-7753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3BC81ACA6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A967286636
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC0C4416;
	Thu, 21 Dec 2023 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoXPrInv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13691187E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703126007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5a0totasfvFwZIblW4qXBdcjfAygTJ0zVbYLxO+qMnc=;
	b=LoXPrInvYdCRD4BTDdrNJseR+p+3fA/pIvNpr05xB2D2L6ZAThpSVj/eXqwxUvmNeYZzqQ
	+HEjNfWrsaHfONSTzS1KnL64yc+hnYxvoTy0AoAaItnRoFgvg8lBSSsBstAvb31Yuakqjo
	/q7eQomscLiLFjFWJ/ID5ghpfl72N5s=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-ClStSlfxMt2cHd02HmmohA-1; Wed, 20 Dec 2023 21:33:25 -0500
X-MC-Unique: ClStSlfxMt2cHd02HmmohA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6d943f2cf6fso405873b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 18:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703126003; x=1703730803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5a0totasfvFwZIblW4qXBdcjfAygTJ0zVbYLxO+qMnc=;
        b=WNizbazfrPSGecakWV3nqyh8vc3yNF/jSNiKVn4bkaD3dOM64nU34VLtiGOvZ5fYTz
         Fbln55DuER1E38FJwcXaBX4aoO3J1I6xk+OqHIil7WnHGbtbUxBajEdPvEErxLsAGMSq
         APoEKLkFC4toVZoUaoxkhik5Ph5M7LGCO8pRj8QePbnNzW9bP8M8YK7IRz6OIlx8oH9P
         rx0PCuolvYCRRKsKl7hOOsOumdAZjd133XlQg8Wpi9hrh781qcQSyvBOZ2xyesRW0rnF
         WIiU+l+e4EFCCnv9o5bCvofVNaBNPeEfTE2ZNLmdxDmdyaT2ml3d6ocOLQkiPAmU0QNP
         pQyQ==
X-Gm-Message-State: AOJu0Ywu5f+zuzaI1hGsQsv84qUStFD+jEiwy9fSDeZpjB80g54kc71J
	PcGpyMp1hEFbb1UKythclmOxEnzqEBg4lumN3/61TzWozF7lj1ppHY0CElqSmQEeZ2Ygx+aovUQ
	u/RNsxUon99xFsJ/gn61dU2Lzb/O1kdKYhMA9OWYFU6dcTB8qdyNN9Q==
X-Received: by 2002:a05:6a00:428a:b0:6d9:471d:faee with SMTP id bx10-20020a056a00428a00b006d9471dfaeemr2568767pfb.55.1703126003607;
        Wed, 20 Dec 2023 18:33:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvNTtsHVi+NyeUO0tGmuPBmvsTAynsN/eV3C4oEjj91VnICK+2rcyqXiyLi2OseyD5girnnKsziyM5XzUlxx0=
X-Received: by 2002:a05:6a00:428a:b0:6d9:471d:faee with SMTP id
 bx10-20020a056a00428a00b006d9471dfaeemr2568755pfb.55.1703126003294; Wed, 20
 Dec 2023 18:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205113444.63015-1-linyunsheng@huawei.com>
 <20231205113444.63015-7-linyunsheng@huawei.com> <CACGkMEvVezZnHK-gRWY+MUd_6awnprb024scqPNmMQ05P8rWTQ@mail.gmail.com>
 <424670ab-23d8-663b-10cb-d88906767956@huawei.com> <CACGkMEsMdP1B-9RaqibJYfFsd_qJpB+Kta5BnyD_WXH=W2w_OQ@mail.gmail.com>
 <c5b5d36c-d0ca-c943-5355-343214d92c26@huawei.com>
In-Reply-To: <c5b5d36c-d0ca-c943-5355-343214d92c26@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Dec 2023 10:33:11 +0800
Message-ID: <CACGkMEs8HWq_NFNk=Pp3qxuo7AWBsybXT78LPgC-nKaP_u3LqA@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] tools: virtio: introduce vhost_net_test
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 8:45=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/12/12 12:35, Jason Wang wrote:>>>> +done:
> >>>> +       backend.fd =3D tun_alloc();
> >>>> +       assert(backend.fd >=3D 0);
> >>>> +       vdev_info_init(&dev, features);
> >>>> +       vq_info_add(&dev, 256);
> >>>> +       run_test(&dev, &dev.vqs[0], delayed, batch, reset, nbufs);
> >>>
> >>> I'd expect we are testing some basic traffic here. E.g can we use a
> >>> packet socket then we can test both tx and rx?
> >>
> >> Yes, only rx for tun is tested.
> >> Do you have an idea how to test the tx too? As I am not familar enough
> >> with vhost_net and tun yet.
> >
> > Maybe you can have a packet socket to bind to the tun/tap. Then you can=
 test:
> >
> > 1) TAP RX: by write a packet via virtqueue through vhost_net and read
> > it from packet socket
> > 2) TAP TX:  by write via packet socket and read it from the virtqueue
> > through vhost_net
>
> When implementing the TAP TX by adding VHOST_NET_F_VIRTIO_NET_HDR,
> I found one possible use of uninitialized data in vhost_net_build_xdp().
>
> And vhost_hlen is set to sizeof(struct virtio_net_hdr_mrg_rxbuf) and
> sock_hlen is set to zero in vhost_net_set_features() for both tx and rx
> queue.
>
> For vhost_net_build_xdp() called by handle_tx_copy():
>
> The (gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) checking below may cause a
> read of uninitialized data if sock_hlen is zero.

Which data is uninitialized here?

>
> And it seems vhost_hdr is skipped in get_tx_bufs():
> https://elixir.bootlin.com/linux/latest/source/drivers/vhost/net.c#L616
>
> static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
>                                struct iov_iter *from)
> {
> ...
>         buflen +=3D SKB_DATA_ALIGN(len + pad);
>         alloc_frag->offset =3D ALIGN((u64)alloc_frag->offset, SMP_CACHE_B=
YTES);
>         if (unlikely(!vhost_net_page_frag_refill(net, buflen,
>                                                  alloc_frag, GFP_KERNEL))=
)
>                 return -ENOMEM;
>
>         buf =3D (char *)page_address(alloc_frag->page) + alloc_frag->offs=
et;
>         copied =3D copy_page_from_iter(alloc_frag->page,
>                                      alloc_frag->offset +
>                                      offsetof(struct tun_xdp_hdr, gso),
>                                      sock_hlen, from);
>         if (copied !=3D sock_hlen)
>                 return -EFAULT;
>
>         hdr =3D buf;
>         gso =3D &hdr->gso;
>
>         if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>             vhost16_to_cpu(vq, gso->csum_start) +
>             vhost16_to_cpu(vq, gso->csum_offset) + 2 >
>             vhost16_to_cpu(vq, gso->hdr_len)) {
> ...
> }
>
> I seems the handle_tx_copy() does not handle the VHOST_NET_F_VIRTIO_NET_H=
DR
> case correctly, Or do I miss something obvious here?

In get_tx_bufs() we did:

        *len =3D init_iov_iter(vq, &msg->msg_iter, nvq->vhost_hlen, *out);

Which covers this case?

Thanks

>
> >
> > Thanks
> >
> >>
> >>>
> >>> Thanks
> >>
> >
> > .
> >
>


