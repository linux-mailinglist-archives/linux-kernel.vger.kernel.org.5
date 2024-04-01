Return-Path: <linux-kernel+bounces-126428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7068937D1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 915ECB20BC1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AD88BF0;
	Mon,  1 Apr 2024 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8BRDOY6"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16E546B5;
	Mon,  1 Apr 2024 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711942731; cv=none; b=VkA1U5RXNOAownsuk62jnb6LRBJoODRp4rgeoxu9c+NUU4R3ku8msCIpyoT//x7CRZc2xWsbBxQXEMhfSCd9grpEWZmN8s6vBo4le65V0aejH/vwjROel38xvw2hKg5kCMoBg+7ohAXBPRNHUPxYWmH1TU/PlEvnyuUoaf5h0JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711942731; c=relaxed/simple;
	bh=i11uzskaeCHVuiNLrT89/y5YIUGJasf+9x+lVmqm1b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruKaewSKqMW40iMCldeyB3AUYlpzmIlSI7/K9GOsUrh3wggY+rfRRoQHv4uHMtCnK0EnlC/AbYVGGLzQknLRRv/A5610WRKMQvb3kaUFRSWrUpHgpGT4TkDEuNkHm1l+/VellZLuJ1lqHZzapHueU9J9EFYsACbDi651c+8uEq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8BRDOY6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso5068202a12.2;
        Sun, 31 Mar 2024 20:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711942728; x=1712547528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q1PAGL3PzjVHU2xnkLk9TfT+VSrqXIeYGFzwjWDQQY=;
        b=b8BRDOY64O5Cmjy4GQWcSUXJ9HvMzCCxzJNVsmYaiEPQOcZGD8hd91QffPXAdIXWZK
         mT0+ba65//HiDgv0MlLhJE/PDpdq847GvtKujhV0gW7UFe8E3tT1aocDoSZH1SC5UkGP
         I0zdrsc1OYdjzknrwFgjNwcSngGMK5IqYSsVSy/xWNcRROcqYiIGlJPLY9gh1HDXeO+O
         CVL9BG6nKKQQrJRabEhyJLgO2wWC8MHA8ATMMR268jIjzDIYjDbESZN3sj2VnI2pZhQL
         7+/Kjjpo/kITSkWgTb4YNvsa7UM4QCcs0IUzaOMrc/eEljf1jKYd09omg9UWLlKH0yyx
         DqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711942728; x=1712547528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Q1PAGL3PzjVHU2xnkLk9TfT+VSrqXIeYGFzwjWDQQY=;
        b=gyeIsw4zm0050OHfGDQqJhUxFYC7MSQvVTjAarwRGsomuww3E+Bm8r4G7+Q8e7/z0W
         LEMTwqs0mX4+aZ8QGofcTMnngwCiJ16UGONEFqToAwAfKTjckNYFM4Y1BqMCOmTUCOsV
         rhKkX26ipJPVtidM1Up/56yU5tkwBKH5bIpEhnz7XbQhNqPB+5PcIFaueA/zvqbxNws/
         QCeAvTYOwYOxSq/JHO80vX2O/NL+Zc+P6Ysupy1JJIqZIojRzlp4D6K7R59gEH82R6YM
         3Ka1MoxUr2BhBBg/MmT+84BQppanIOui2gCksmzbxnfivBo+CY0/2AlTk/77YT0gU0Vd
         1mEA==
X-Forwarded-Encrypted: i=1; AJvYcCUZUJMrDNWVhP6+bNbYbQEoEud10xIAuSVS6kQcFW38/axeyLrh5BpBoTImVZ1v2rRsNB5j9imfAokA2pCD43nU+rsZCl1M0B3eBVz3+0gRK21cZxSviK2CKCIzxeM25XL+NPMv3fOhg5JEizeLInKRQSRtTPPEPIVW
X-Gm-Message-State: AOJu0Yxdc8fpGR+7OLvo7JMg/+gDf4emx3iTWfcHBzgw8e0xmnR6iZVc
	32KsRVzITNuhco4NoAmy1ZZA9zQFZFARgaYXnyAvROWPrHBmY4AXV/BSOtJlPNgr7f8ShcWjDnV
	prnMf93AtkJQjtal0GT2bX9wmXn8=
X-Google-Smtp-Source: AGHT+IESyFP9W2rN1PCNqYQHGt2io56zS98g8aELou9j8eEbTRrpcyPeg2UCpQHNpk/rqcFafuBH4tBIjg53j5eFe2w=
X-Received: by 2002:a50:9993:0:b0:56b:cf26:3af0 with SMTP id
 m19-20020a509993000000b0056bcf263af0mr4954345edb.17.1711942727968; Sun, 31
 Mar 2024 20:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org> <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
 <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
 <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
 <CAKhg4tJPjcShkw4-FHFkKOcgzHK27A5pMu9FP7OWj4qJUX1ApA@mail.gmail.com>
 <1b2d471a5d06ecadcb75e3d9155b6d566afb2767.camel@redhat.com>
 <1708652254.1517398-1-xuanzhuo@linux.alibaba.com> <CACGkMEuUeQTJYpZDx8ggqwBWULQS1Fjd_DgPvVMLq-_cjYfm7g@mail.gmail.com>
 <65dcf7a775437_20e0a2087f@john.notmuch> <CAKhg4t+dzRPjyRXAifS_TCGPv3SfMMm1CF3pCs18OR+o9v+S_Q@mail.gmail.com>
In-Reply-To: <CAKhg4t+dzRPjyRXAifS_TCGPv3SfMMm1CF3pCs18OR+o9v+S_Q@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 1 Apr 2024 11:38:34 +0800
Message-ID: <CAKhg4tLO7vG5jEYZ3xnzm=xKDHO0SNgDw=JT-j7gb5bjiQOqsw@mail.gmail.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
To: John Fastabend <john.fastabend@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, mst@redhat.com, 
	hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 4:37=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> On Tue, Feb 27, 2024 at 4:42=E2=80=AFAM John Fastabend <john.fastabend@gm=
ail.com> wrote:
> >
> > Jason Wang wrote:
> > > On Fri, Feb 23, 2024 at 9:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Fri, 09 Feb 2024 13:57:25 +0100, Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > > > > On Fri, 2024-02-09 at 18:39 +0800, Liang Chen wrote:
> > > > > > On Wed, Feb 7, 2024 at 10:27=E2=80=AFPM Paolo Abeni <pabeni@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Wed, 2024-02-07 at 10:54 +0800, Liang Chen wrote:
> > > > > > > > On Tue, Feb 6, 2024 at 6:44=E2=80=AFPM Paolo Abeni <pabeni@=
redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > > > > > > > > > On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard=
 Brouer <hawk@kernel.org> wrote:
> > > > > > > > > > > On 02/02/2024 13.11, Liang Chen wrote:
> > > > > > > > > [...]
> > > > > > > > > > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(st=
ruct xdp_buff *xdp)
> > > > > > > > > > > >       }
> > > > > > > > > > > >   }
> > > > > > > > > > > >
> > > > > > > > > > > > +static void virtnet_xdp_save_rx_hash(struct virtne=
t_xdp_buff *virtnet_xdp,
> > > > > > > > > > > > +                                  struct net_devic=
e *dev,
> > > > > > > > > > > > +                                  struct virtio_ne=
t_hdr_v1_hash *hdr_hash)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > > > > > > > > > +             virtnet_xdp->hash_value =3D hdr_hash-=
>hash_value;
> > > > > > > > > > > > +             virtnet_xdp->hash_report =3D hdr_hash=
->hash_report;
> > > > > > > > > > > > +     }
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > >
> > > > > > > > > > > Would it be possible to store a pointer to hdr_hash i=
n virtnet_xdp_buff,
> > > > > > > > > > > with the purpose of delaying extracting this, until a=
nd only if XDP
> > > > > > > > > > > bpf_prog calls the kfunc?
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > That seems to be the way v1 works,
> > > > > > > > > > https://lore.kernel.org/all/20240122102256.261374-1-lia=
ngchen.linux@gmail.com/
> > > > > > > > > > . But it was pointed out that the inline header may be =
overwritten by
> > > > > > > > > > the xdp prog, so the hash is copied out to maintain its=
 integrity.
> > > > > > > > >
> > > > > > > > > Why? isn't XDP supposed to get write access only to the p=
kt
> > > > > > > > > contents/buffer?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Normally, an XDP program accesses only the packet data. How=
ever,
> > > > > > > > there's also an XDP RX Metadata area, referenced by the dat=
a_meta
> > > > > > > > pointer. This pointer can be adjusted with bpf_xdp_adjust_m=
eta to
> > > > > > > > point somewhere ahead of the data buffer, thereby granting =
the XDP
> > > > > > > > program access to the virtio header located immediately bef=
ore the
> > > > > > >
> > > > > > > AFAICS bpf_xdp_adjust_meta() does not allow moving the meta_d=
ata before
> > > > > > > xdp->data_hard_start:
> > > > > > >
> > > > > > > https://elixir.bootlin.com/linux/latest/source/net/core/filte=
r.c#L4210
> > > > > > >
> > > > > > > and virtio net set such field after the virtio_net_hdr:
> > > > > > >
> > > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/vi=
rtio_net.c#L1218
> > > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/vi=
rtio_net.c#L1420
> > > > > > >
> > > > > > > I don't see how the virtio hdr could be touched? Possibly eve=
n more
> > > > > > > important: if such thing is possible, I think is should be so=
mewhat
> > > > > > > denied (for the same reason an H/W nic should prevent XDP fro=
m
> > > > > > > modifying its own buffer descriptor).
> > > > > >
> > > > > > Thank you for highlighting this concern. The header layout diff=
ers
> > > > > > slightly between small and mergeable mode. Taking 'mergeable mo=
de' as
> > > > > > an example, after calling xdp_prepare_buff the layout of xdp_bu=
ff
> > > > > > would be as depicted in the diagram below,
> > > > > >
> > > > > >                       buf
> > > > > >                        |
> > > > > >                        v
> > > > > >         +--------------+--------------+-------------+
> > > > > >         | xdp headroom | virtio header| packet      |
> > > > > >         | (256 bytes)  | (20 bytes)   | content     |
> > > > > >         +--------------+--------------+-------------+
> > > > > >         ^                             ^
> > > > > >         |                             |
> > > > > >  data_hard_start                    data
> > > > > >                                   data_meta
> > > > > >
> > > > > > If 'bpf_xdp_adjust_meta' repositions the 'data_meta' pointer a =
little
> > > > > > towards 'data_hard_start', it would point to the inline header,=
 thus
> > > > > > potentially allowing the XDP program to access the inline heade=
r.
> >
> > Fairly late to the thread sorry. Given above layout does it make sense =
to
> > just delay extraction to the kfunc as suggested above? Sure the XDP pro=
gram
> > could smash the entry in virtio header, but this is already the case fo=
r
> > anything else there. A program writing over the virtio header is likely
> > buggy anyways. Worse that might happen is bad rss values and mappings?
>
> Thank you for raising the concern. I am not quite sure if the XDP
> program is considered buggy, as it is agnostic to the layout of the
> inline header.
> Let's say an XDP program calls bpf_xdp_adjust_meta to adjust data_meta
> to point to the inline header and overwrites it without even knowing
> of its existence. Later, when the XDP program invokes the kfunc to
> retrieve the hash, incorrect data would be returned. In this case, the
> XDP program seems to be doing everything legally but ends up with the
> wrong hash data.
>
> Thanks,
> Liang
>

I haven=E2=80=99t received any feedback yet, so I=E2=80=99m under the impre=
ssion that
the XDP program is still considered buggy in the scenario mentioned
above, and the overall behavior is as designed from XDP perspective.
Looking up the intel igc driver, it also does not bother with this
particular aspect.

Given this context, we don't need to be concerned about the hash value
being overwritten. So if there aren't any objections, I plan to remove
the preservation of the hash value in the next iteration.

Thanks,
Liang

> >
> > I like seeing more use cases for the hints though.
> >
> > Thanks!
> > John

