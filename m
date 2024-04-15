Return-Path: <linux-kernel+bounces-145409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCD58A55D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC01FB22E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2B3762D0;
	Mon, 15 Apr 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+RGp9BL"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9A74E37;
	Mon, 15 Apr 2024 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193238; cv=none; b=obebo+p1dueGKO3HyeJa+5UGcSsITfpf07BS9+O6ASeoXKn/tixdOWiIwJAna+yTdIIEYHqxhSJP8QD149s0cQrUpgT90j81lNvsKmX+bnJ1uAg69J6i53VDpk2MLzrfdWZw4ynmWgs6En0igLqpepzVxbcDcFYSCOaosPuKODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193238; c=relaxed/simple;
	bh=OJhWkXaiZfR5vxgWccVDhgB7L5539O3TT+m0W3wEVJQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kWkyHePVTFG4IVaCZ0ytViBqJB8WDUiFezQT1gaAOK0zvTwXLie8NNo5T9ZG7pxqRlRc4aeeI6pUqnNqBEl2iyXR4iDW0cyCB25r/flSR1UK65axGEAbSAi/+EV1FjJHzDzcegJTuCwA3w91UWR6seXWu0a+up4lSs1Hfdxcr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+RGp9BL; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4dac3cbc8fdso1306176e0c.0;
        Mon, 15 Apr 2024 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713193235; x=1713798035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS6Pv+eMPVF9jwN1/da6sM3EbXPOKQ+l4+JLzAo2+5s=;
        b=h+RGp9BLkdMOdq5GQBRNkfjRnIMkpwJnIO6R9Z4W+gTlWhHDa72XUfnH4Q9g82aydR
         pWaP2mF137KxIPyNb0Y9/K767+g27Kr8/YNus/Z/GGjS1BfGh5luxSQDU2AnafaIYVzP
         L1Dz/xXK/a8idBQfZ/hzePyFkfr6yLlazOboQSfrMp5fxU6YgLe2PRqvLZiTNtMJMdT6
         mjoVH/W04Es46vm53+xXJ9OofNOJem3iOMWSEyvyAdRVToyktMGPx04flfFN7/QJMHD6
         ObCxYiGLyLJ8ujnHJMeriPagjhZ0I9sHIj0W3IOwD6J6iLdPbPEpShXC7Oha2aouk/HT
         7AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193235; x=1713798035;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WS6Pv+eMPVF9jwN1/da6sM3EbXPOKQ+l4+JLzAo2+5s=;
        b=a59QN9V5lOKyOGSG+VJcYlxdaHJdIXkvX4eqVhSuAHW/swxu6XoIHhXcn72+rP7qOw
         o1Rph4e4LRNq/mrcMSKBMgfEDy9jLFYD42r/HBIQ7jlYsJ3MRAPvbjZSrbxzn5VFMBMT
         A3MU/6HLSMcuSKZeu4J03Pkwjl3shxYrKTeI1/mVeLij3w8Nr/SXHLOK+lzfryKa5wNm
         cPC+3K+dlG9IoktMHqx94Z2gjyjko0eo0TWeLE0y/yg6rdZReQBBNRrOCXIJCzCLEmWw
         qmZ93yDyiKMs5TMWeFX7NamPlVkxAQksl24rUfMT6DFuGJMXRgta0AFDGlHkxJVtcEoz
         iDhg==
X-Forwarded-Encrypted: i=1; AJvYcCXVJe3NWGXyyZtYCtr5jw0zSyslno6YrZhd2vvsHxaqyXccZJYmTAx5NAdmeqXCAIOAB6XxCtQ9aqBeIsdjg1b8Z5SLOO4J/beGsuktncWMTPDZGjk2URW/jsIJCPDu8XL9MSVS
X-Gm-Message-State: AOJu0Yxb0WIotI1BA5YCaYlnApje0tr9jXqTQUTAhtVb/4t1fqoC8bls
	xoImD4DH5sMOkZPAyv2T0ul/ZN12HlNaoQVmCDS/KpyVmR3CxypA
X-Google-Smtp-Source: AGHT+IGTheb8k3tpl64FvDV3BdvW1vuUvwO9iUTdUt2UdDwND0VjYngIDw7HpvBKpueW1xWnMDSlfA==
X-Received: by 2002:a05:6122:209e:b0:4cd:b718:4b08 with SMTP id i30-20020a056122209e00b004cdb7184b08mr7269652vkd.11.1713193233032;
        Mon, 15 Apr 2024 08:00:33 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id v13-20020a0cc60d000000b0069b75b8633dsm1963873qvi.67.2024.04.15.08.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:00:32 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:00:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Duyck <alexander.duyck@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 aleksander.lobakin@intel.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <661d41106f996_c0c829445@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAKgT0UfB+3DTjK7vq1uvG-2xtA53pw03ygJhwSG8j1bPtmYU8A@mail.gmail.com>
References: <20240412152120.115067-1-richardbgobert@gmail.com>
 <20240412152120.115067-2-richardbgobert@gmail.com>
 <661ad1136bc10_3be9a7294c2@willemb.c.googlers.com.notmuch>
 <CAKgT0UfB+3DTjK7vq1uvG-2xtA53pw03ygJhwSG8j1bPtmYU8A@mail.gmail.com>
Subject: Re: [PATCH net v1 1/2] net: gro: add flush check in
 udp_gro_receive_segment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Duyck wrote:
> On Sat, Apr 13, 2024 at 11:38=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Richard Gobert wrote:
> > > GRO-GSO path is supposed to be transparent and as such L3 flush che=
cks are
> > > relevant to all flows which call skb_gro_receive. This patch uses t=
he same
> > > logic and code from tcp_gro_receive but in the relevant flow path i=
n
> > > udp_gro_receive_segment.
> > >
> > > Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fragliste=
d) UDP GRO packets")
> > > Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> >
> > > ---
> > >  net/ipv4/udp_offload.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > > index 3498dd1d0694..1f4e08f43c4b 100644
> > > --- a/net/ipv4/udp_offload.c
> > > +++ b/net/ipv4/udp_offload.c
> > > @@ -471,6 +471,7 @@ static struct sk_buff *udp_gro_receive_segment(=
struct list_head *head,
> > >       struct sk_buff *p;
> > >       unsigned int ulen;
> > >       int ret =3D 0;
> > > +     int flush;
> > >
> > >       /* requires non zero csum, for symmetry with GSO */
> > >       if (!uh->check) {
> > > @@ -528,7 +529,17 @@ static struct sk_buff *udp_gro_receive_segment=
(struct list_head *head,
> > >                               skb_gro_postpull_rcsum(skb, uh,
> > >                                                      sizeof(struct =
udphdr));
> > >
> > > -                             ret =3D skb_gro_receive(p, skb);
> > > +                             flush =3D NAPI_GRO_CB(p)->flush;
> > > +
> > > +                             if (NAPI_GRO_CB(p)->flush_id !=3D 1 |=
|
> > > +                                 NAPI_GRO_CB(p)->count !=3D 1 ||
> > > +                                 !NAPI_GRO_CB(p)->is_atomic)
> > > +                                     flush |=3D NAPI_GRO_CB(p)->fl=
ush_id;
> > > +                             else
> > > +                                     NAPI_GRO_CB(p)->is_atomic =3D=
 false;
> > > +
> > > +                             if (flush || skb_gro_receive(p, skb))=

> > > +                                     ret =3D 1;
> >
> > UDP_L4 does not have the SKB_GSO_TCP_FIXEDID that uses is_atomic as
> > input.
> >
> > And I still don't fully internalize the flush_id logic after staring
> > at it for more than one coffee.
> =

> The flush_id field is there to indicate the difference between the
> current IPv4 ID of the previous IP header. It is meant to be used in
> conjunction with the is_atomic for the frame coalescing. Basically
> after the second frame we can decide the pattern either incrementing
> IPv4 ID or fixed, so on frames 3 or later we can decide to drop the
> frame if it doesn't follow that pattern.
> =

> > But even ignoring those, the flush signal of NAPI_GRO_CB(p)->flush
> > set the network layer must be followed, so ACK. Thanks for the fix.
> =

> I'm not sure about the placement of this code though. That is the one
> thing that seems off to me. Specifically this seems like it should be
> done before we start the postpull, not after. It should be something
> that can terminate the flow before we attempt to aggregate the UDP
> headers.

In principle agreed that we should conclude the flush checks before
doing prep for coalescing.

In practice it does not matter? NAPI_GRO_CB(skb)->csum will be ignored
if the packet gets flushed.=

