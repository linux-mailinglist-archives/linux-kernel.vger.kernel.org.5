Return-Path: <linux-kernel+bounces-36606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8215F83A3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BF02944E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CF01755F;
	Wed, 24 Jan 2024 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Goowz/ZG"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90410171CD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083503; cv=none; b=fQdeVYz6TqnRfJUstVEC+3cjKC7oqdWTaKeMd4ZVqnEllhDQjOdh7B+xS/wnWgeqXfs7vlmEFs54iEBPBExd+rbsvNgBD6vmbDueGENmVZIxMrnnXB+N+SRd9f7/SLSeqVEg+8a30/OIAU86Ote/u1vV/1VxPDGib7ROn5tIjcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083503; c=relaxed/simple;
	bh=C27R85hLJ8jFsYGbXum67ur9M7OUX1bmDQYugmrCWJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wj3Z/AfFy2IvHh0tF3W7QMgZnVM4bhq4y8RBsyiuq/51Z0P5nLy9IT8pWmaHjNT9Rflqxfatp5pMo6atqJXtefD09YRF1/YCP36NyyDt2MaY0VHBu+3Oo7fjyhpLNjHbIxpaY0xyj2Z2SFBYCexiL/+Wmnou22fWBPOM+HXi7KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Goowz/ZG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so64958625e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706083500; x=1706688300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xp97wlBUwLOHv0unR+8poeipmd+dQbI6tLKDmEwT28=;
        b=Goowz/ZGk+SoxiAQuyj/8ppHoJtl2YNKrBpSJ2qy0mIOuU9Q5SZ8VzE7oSs7toahpx
         TtibbpoXUwq/gJwhYfHbsLyOP3MsF8TqeR3/p0DanyIUcCMDdG/eaZqdAl/oe16YTsm5
         F8bIiZca6vrD247CEa5DAJ9s8IlQc/CBwSzuG4RieRco/YFx+O5Y3U562WjUd2DR3T49
         a31WBSKlIaNI7I4U/vOXESnoEyUY0t60oMX2qEfF9L/Rl5jRNuqbnKjIwk7Ddrw8GBoM
         B8WazeqJlTNmJ6INOYu70khG7+DrnVMJl8wMNYe4f+BJTz54mFRKXFNlCFNclw7rKcBd
         oWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706083500; x=1706688300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xp97wlBUwLOHv0unR+8poeipmd+dQbI6tLKDmEwT28=;
        b=iq6mGKbOM9SbIXuBty+dro2c4eIJe0OEKpWwJ/3Kl+HIA1XCBOqTqwozYItPt8lR37
         ssytv83U8Qm76LYgnKEN5PiUfYZXo7S8ivXZhACAGl9Wkl9/MsDE7Bux4bwteoJxln4Q
         AArfL0wGuPsOeXO3UDyJtsNxyp+20hpMJ+RPgqs6NV5Rlr0uEksn8jlTZZuHXjQOoe2r
         wy5ceW/i7Fy7QbKFj1qfIPUuKUyf1Fs4JAWaAh70TVzAZfXFQXi8WllVU3+lRm/x65M/
         cTSuYTg7JpR+PwfdI3VrepwOH2dvgucS1KGOnQ+815/QN2uuCeXbxKBoK8EgHBTovxDl
         3fCg==
X-Gm-Message-State: AOJu0Yyefq9S6avmBEVD8mW0c25uqHezUjXgA29/0GPzALDLvIO+RSuR
	Ar9SZgu/o9ZYMXNNYNQBp3jsu3MwVPGvaY0DgM634VXtCi2RU3UOqLEN6537FaEsqyHOKjDGlkD
	Luayip/N1vo+vFJsgG/V8o6lMrmg=
X-Google-Smtp-Source: AGHT+IG4NY9I5TCetk3gUnL4NU+vsphLH3oFDGaUv0e3ZkncOPiy2ll2/Oaz5taVnXjiY0IGUM+OzahfiTGhnc1r8uU=
X-Received: by 2002:a05:600c:2802:b0:40e:6c4e:56b1 with SMTP id
 m2-20020a05600c280200b0040e6c4e56b1mr889440wmb.143.1706083499607; Wed, 24 Jan
 2024 00:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122102256.261374-1-liangchen.linux@gmail.com>
 <4ada64aa-87ec-4340-9892-be52c1f27a97@linux.alibaba.com> <CAKhg4t+ayD-MPK8FwZFURZyX32d8gk26GdytwRiRjJBwBbaR6w@mail.gmail.com>
 <1706076301.4647658-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706076301.4647658-1-xuanzhuo@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 24 Jan 2024 16:04:47 +0800
Message-ID: <CAKhg4tJd7=xpj895RzEQSADfH_eVhDYesCOk_iXz_8RMRWzjHA@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: mst@redhat.com, jasowang@redhat.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Heng Qi <hengqi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 2:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 24 Jan 2024 10:04:51 +0800, Liang Chen <liangchen.linux@gmail.com=
> wrote:
> > On Mon, Jan 22, 2024 at 7:10=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> > >
> > > Hi Liang Chen,
> > >
> > > =E5=9C=A8 2024/1/22 =E4=B8=8B=E5=8D=886:22, Liang Chen =E5=86=99=E9=
=81=93:
> > > > The RSS hash report is a feature that's part of the virtio specific=
ation.
> > > > Currently, virtio backends like qemu, vdpa (mlx5), and potentially =
vhost
> > > > (still a work in progress as per [1]) support this feature. While t=
he
> > > > capability to obtain the RSS hash has been enabled in the normal pa=
th,
> > > > it's currently missing in the XDP path. Therefore, we are introduci=
ng XDP
> > > > hints through kfuncs to allow XDP programs to access the RSS hash.
> > > >
> > > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > > ---
> > > >   drivers/net/virtio_net.c | 56 +++++++++++++++++++++++++++++++++++=
+++++
> > > >   1 file changed, 56 insertions(+)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index d7ce4a1011ea..1463a4709e3c 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct v=
irtnet_info *vi, const int mtu)
> > > >       }
> > > >   }
> > > >
> > > > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *has=
h,
> > > > +                        enum xdp_rss_hash_type *rss_type)
> > > > +{
> > > > +     const struct xdp_buff *xdp =3D (void *)_ctx;
> > > > +     struct virtio_net_hdr_v1_hash *hdr_hash;
> > > > +     struct virtnet_info *vi;
> > > > +
> > > > +     if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> > >
> > > I think 'vi->has_rss_hash_report' should be used here.
> > > NETIF_F_RXHASH cannot guarantee that the hash report feature is negot=
iated,
> > > and accessing hash_report and hash_value is unsafe at this time.
> > >
> >
> > My understanding is that rxhash in dev->features is turned on only if
> > the corresponding hw feature is set. We will double check on this.
> >
> > > > +             return -ENODATA;
> > > > +
> > > > +     vi =3D netdev_priv(xdp->rxq->dev);
> > > > +     hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi=
->hdr_len);
> > >
> > > If the virtio-net-hdr is overrided by the XDP prog, how can this be d=
one
> > > correctly and as expected?
> > >
> >
> > Yeah, thanks for bringing up this concern. We are actively working on
> > a fix of this issue(possibly with a wrapper structure of xdp_buff).
>
> Are there some places to save the hash before run xdp?
>

Yeah, it will be saved in a wrapper structure. Thanks.

> Thanks.
>
>
> >
> > Thanks,
> > Liang
> >
> > > Thanks,
> > > Heng
> > >
> > > > +
> > > > +     switch (__le16_to_cpu(hdr_hash->hash_report)) {
> > > > +             case VIRTIO_NET_HASH_REPORT_TCPv4:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_TCP;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_UDPv4:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_UDP;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_TCPv6:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_UDPv6:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_IPv4:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV4;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_IPv6:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6_EX;
> > > > +                     break;
> > > > +             case VIRTIO_NET_HASH_REPORT_NONE:
> > > > +             default:
> > > > +                     *rss_type =3D XDP_RSS_TYPE_NONE;
> > > > +     }
> > > > +
> > > > +     *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D =
{
> > > > +     .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > > > +};
> > > > +
> > > >   static int virtnet_probe(struct virtio_device *vdev)
> > > >   {
> > > >       int i, err =3D -ENOMEM;
> > > > @@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device=
 *vdev)
> > > >       dev->ethtool_ops =3D &virtnet_ethtool_ops;
> > > >       SET_NETDEV_DEV(dev, &vdev->dev);
> > > >
> > > > +     dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> > > > +
> > > >       /* Do we support "hardware" checksums? */
> > > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
> > > >               /* This opens up the world of extra features. */
> > >
> >

