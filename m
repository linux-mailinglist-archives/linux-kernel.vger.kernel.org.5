Return-Path: <linux-kernel+bounces-36306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E535B839F23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9630E288726
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA4A539E;
	Wed, 24 Jan 2024 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7+Z/YUQ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7D1874
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063245; cv=none; b=dqUo49RQkB1gum1HUIWj7q4PANlk37t5edreS37qrTmzBd2F+vE1zHON0eeoz68E5JMUSPpLiyJIVOlP8lLm+N63JWaSsAFl32++ErTSLyL7BkkpijxNr2M1t5k8oe3M5O9MelIXIgO6iOMKC+ALViPza7g2epbfEplQ0yNwafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063245; c=relaxed/simple;
	bh=wvo7LjfFKzlE79cgaD689QaQxVmVMsxOvMEBBTVkI7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/pQoDZMcUfiSTt6u5OeVpjhuot7gen9DiD0yyTrLFQnhfqCrdyvfHiu1oI+ANDGFz68Y+TjJLelkNUO9sKNNZsmZjuX3jO5i7RfYDgC7hZgfDwG8uXrwJ+Nb0Ph26TCv3akESfd/FZFIG4rby2+IxmdkIUZpNSFBcIg5JSdQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7+Z/YUQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso6596367a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706063242; x=1706668042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0OO2kNsfTulrolzVWOPc5d52vzKo7FmwBEwV4HF2i0=;
        b=L7+Z/YUQZ0nyPXinp5cd+lBFfdYPybCCVdBM2B3LFwYCHvF+gGbC6q7dqcOw0mZ9rz
         g8DknD9s7VgNsI+Fqg47ABmTKrkMTOMVRpxsAQ2bNJGE8c1CLf66zkoqJxbjdtdTBaeh
         6uWA+34xXXksyELkxGvqmDRrCE9pBXXrW2yoMCDccVlLNVTduzcq2Ho4LaK3cFquPGhF
         hS293xxsze/Lku6mxHdULh8xjjCRuTRrIaAbwPce+T1tvSXjswLIAwGnevB8DEPGELEW
         cx1sj8R3XtSrCwF+U7jEwv30YdB8K6fMRExMT2ubZQFYZGTNuPzlscinzh9ozGLxwfxb
         pNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706063242; x=1706668042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0OO2kNsfTulrolzVWOPc5d52vzKo7FmwBEwV4HF2i0=;
        b=puFiX4/rFt/sVejnvaEJgreAb3/10flWKa4hbSfk48mhsFb4kmOnsYPENxUfNEoowP
         AP33q5mszBOGq2hhDYqX+ghQ9imA0S4k5PCU2aPaGbdTGs/SMLymF7uoZyE6nlnfeSe3
         m92neQ2/6ThEYQZrlpLfn2APkbNckAJm7TMywrQf+o9DWqXvG7mhB5cTaZpZAEQTzTBn
         VH4SGSWxoE9TLNeYQ8qw7sttLrJ7mRJK84M3ztyzxaWoQ5vH3wVtzL5nuURTgZdcagVr
         dbUpI6di+GxQztITcmUaprYPpNaBTO+CjG8bslILzh0IWAywZ5Breg88Q+Tqhe4p3BC1
         34EA==
X-Gm-Message-State: AOJu0YxfqNcCVcqjCdz0NlywHwcRorbOD69fn3JefS1WZ8qTpCdTnASJ
	ICJf80WNcIRNWwDwrFU5TSHz23CpzW7/XT3VXfsB/oufOUXPHAdxk+nlBn5e5XWp3QbggF5oViI
	3f/MsPe8NkpnupNtMH/9l5xQTBJLr0v73UpU=
X-Google-Smtp-Source: AGHT+IFiCRdOaCAOvtAXc7e6Uar32bBy/m3xFl3wVt9f8tkxcTCM7lDMIjNyLBam6Y4E+nEXxZWmMIH92heyLO8oNgQ=
X-Received: by 2002:a17:906:5988:b0:a30:df55:ef5e with SMTP id
 m8-20020a170906598800b00a30df55ef5emr198932ejs.172.1706063241665; Tue, 23 Jan
 2024 18:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122102256.261374-1-liangchen.linux@gmail.com> <20240123020132-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240123020132-mutt-send-email-mst@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 24 Jan 2024 10:27:09 +0800
Message-ID: <CAKhg4tK6ea27iKNAPe=-G9wfzNe4hh9=9fk0cpt0qyAVW1Fa1g@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 3:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jan 22, 2024 at 06:22:56PM +0800, Liang Chen wrote:
> > The RSS hash report is a feature that's part of the virtio specificatio=
n.
> > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhos=
t
> > (still a work in progress as per [1]) support this feature. While the
> > capability to obtain the RSS hash has been enabled in the normal path,
> > it's currently missing in the XDP path. Therefore, we are introducing X=
DP
> > hints through kfuncs to allow XDP programs to access the RSS hash.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 56 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index d7ce4a1011ea..1463a4709e3c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >       }
> >  }
> >
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                        enum xdp_rss_hash_type *rss_type)
> > +{
> > +     const struct xdp_buff *xdp =3D (void *)_ctx;
> > +     struct virtio_net_hdr_v1_hash *hdr_hash;
> > +     struct virtnet_info *vi;
> > +
> > +     if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> > +             return -ENODATA;
> > +
> > +     vi =3D netdev_priv(xdp->rxq->dev);
> > +     hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hd=
r_len);
> > +
> > +     switch (__le16_to_cpu(hdr_hash->hash_report)) {
> > +             case VIRTIO_NET_HASH_REPORT_TCPv4:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_TCP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_UDPv4:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_UDP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_TCPv6:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_UDPv6:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_IPv4:
> > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV4;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_IPv6:
> > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6_EX;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_NONE:
> > +             default:
> > +                     *rss_type =3D XDP_RSS_TYPE_NONE;
> > +     }
> > +
> > +     *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> > +     return 0;
> > +}
> > +
> > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D {
> > +     .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > +};
> > +
> >  static int virtnet_probe(struct virtio_device *vdev)
> >  {
> >       int i, err =3D -ENOMEM;
> > @@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >       dev->ethtool_ops =3D &virtnet_ethtool_ops;
> >       SET_NETDEV_DEV(dev, &vdev->dev);
> >
> > +     dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> > +
>
> How about making this assignment depend on
>
> xdp->rxq->dev->features & NETIF_F_RXHASH
>

Thanks! How about dev->hw_features & NETIF_F_RXHASH? dev->features &
NETIF_F_RXHASH has not been enabled at this point.

> ?
>
> >       /* Do we support "hardware" checksums? */
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
> >               /* This opens up the world of extra features. */
> > --
> > 2.40.1
>

