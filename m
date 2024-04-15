Return-Path: <linux-kernel+bounces-145472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0678C8A5693
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299241C21370
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F5E78C78;
	Mon, 15 Apr 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am8Cx9D1"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B778C9B;
	Mon, 15 Apr 2024 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195329; cv=none; b=MoHHRtvUNyDQJ9wmY5EjDkoF2hS+d4aAoL8wjFl2fTlk9SWGy3HybWV0S/WpteCaD5ZAHEct/7s1Z2ZKzGPZ5I4L96ltjOXQfiBpMkKAWWDKMM3HK/Nyc7ugIMI6Qs1OFxTjdDzqlN3UVQGeHsudkJChAl66h4ZBgR1XelDSPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195329; c=relaxed/simple;
	bh=53AOF03IbeEv9JvWKh4A18LWtIqZ7eTxXPEmrgCdYC0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Zj32m2GYLdByj2+mj+J+ttswoCC7ISOkV7gDDnNkLiygFhbqVcbacU0qeK06xyz5Ky1mdUUzwrHCSdx8us7A3vG2eHppCpzUWGIbzKkjve9tssJu9Oe3/xwW6JwanjVbIGWLU+jvYf9I29KhsIv3C5BlD8Le5lz2hUyDlW7gofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Am8Cx9D1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78d743f3654so323548685a.0;
        Mon, 15 Apr 2024 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713195326; x=1713800126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oadbbSFnpPAsw5LnkgDmwBlvZxtG9vRzbyBZLQ6hcaY=;
        b=Am8Cx9D1l1L7DIiVZ5ys1lSJVy1dnRgU41sWLj7hkI73Y/8H0pcECxkJ25I9ebBGTP
         c5F3P7XffP6OTEtPyf/NgAn+Tdf+bhuTrzENQdOYyoBuGw+zffjezKHelqyjm+Iorr/m
         05D8zfYBdCzEnWlG8BIoj1eBdvhZvSf9mSCGJEb6el/6ZHnynImaq8urbpCVK1wkBD2V
         9BjHkHaK4iOMdSLT5WXc7ifj4LqTNDDd0Dnm6cXjGLZtlLqhO+HJpcbfcyYBGKyEYkYk
         rszRjGxy8nOAL/EEog9HgScEMKO5JocgcKaSPwytMr21zIIuBNd4pl/QiMJo829UjwMO
         jTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713195326; x=1713800126;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oadbbSFnpPAsw5LnkgDmwBlvZxtG9vRzbyBZLQ6hcaY=;
        b=rrNzSdU9seiiSad/thRjiJtp89UbTHMYIfqrdHsQy6aeE2TsxAUmadqvWUNOT8gOCG
         V5ywzeWZwLcFGT8pOoC+68cGc3HpXZymst9NII52lTKaEwgYSNnbqCDXiOY5yncU73H6
         xLRHxMmPQJxljzxZL5ArSd1vHDdYrur5LN7UT2KCpP7zskafwgBnSMbUxk7i5MoNSnV4
         ak8AxGtTD2oDQyszZX3+l3HF8AvWVwGP+yU1euhZmtqTnp0LYJ+7OXS86m5y3jtiAU/S
         CgA2eiTu+ReRjI7FS9OslmNoB7n9JncBSbrsZoSwDdIoCkVEGwDELJfDALeOiQxjCT9z
         bxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu4XBL3oC8xUNdBOn9H4vuZkrubv3sdJdnfVnt72Dan1tL6C395vgxAcAwZrxltomQ8R4SnrRiaFH3pRWcnL/VJW0nbi4zMdIyEOkKSBR8LbJcc8Cigcfklj8xqoDObyHkW0cx
X-Gm-Message-State: AOJu0YyAVi0+7+LOSxFeCBWI02Uxwd1Io0KcJxKcq5tQqTwKiYyTpVWG
	cLZo/R0DILYhm88UGjuzqVSgWddvc7iBVAD42WWsDUfHCdZYAQKU
X-Google-Smtp-Source: AGHT+IEGoTUcnU0ybfnGeWzbsqwK78B0nhRietz7nUTtRT/2sVO9LnA5CHKgHB6Ruq9sZD3iCMB+XA==
X-Received: by 2002:a05:620a:a97:b0:78d:607e:2194 with SMTP id v23-20020a05620a0a9700b0078d607e2194mr11479280qkg.3.1713195326463;
        Mon, 15 Apr 2024 08:35:26 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id t12-20020a05620a004c00b0078d43da0be3sm6456078qkt.5.2024.04.15.08.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:35:26 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:35:25 -0400
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
Message-ID: <661d493de4709_11ba729442@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAKgT0UfbSPO9hAiF1nKM-ZOfDD7Yq9i8M29JX-mwz_NnPQAj0g@mail.gmail.com>
References: <20240412152120.115067-1-richardbgobert@gmail.com>
 <20240412152120.115067-2-richardbgobert@gmail.com>
 <661ad1136bc10_3be9a7294c2@willemb.c.googlers.com.notmuch>
 <CAKgT0UfB+3DTjK7vq1uvG-2xtA53pw03ygJhwSG8j1bPtmYU8A@mail.gmail.com>
 <661d41106f996_c0c829445@willemb.c.googlers.com.notmuch>
 <CAKgT0UfbSPO9hAiF1nKM-ZOfDD7Yq9i8M29JX-mwz_NnPQAj0g@mail.gmail.com>
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
> On Mon, Apr 15, 2024 at 8:00=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Alexander Duyck wrote:
> > > On Sat, Apr 13, 2024 at 11:38=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Richard Gobert wrote:
> > > > > GRO-GSO path is supposed to be transparent and as such L3 flush=
 checks are
> > > > > relevant to all flows which call skb_gro_receive. This patch us=
es the same
> > > > > logic and code from tcp_gro_receive but in the relevant flow pa=
th in
> > > > > udp_gro_receive_segment.
> > > > >
> > > > > Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fragl=
isted) UDP GRO packets")
> > > > > Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> > > >
> > > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > > >
> > > > > ---
> > > > >  net/ipv4/udp_offload.c | 13 ++++++++++++-
> > > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > > > > index 3498dd1d0694..1f4e08f43c4b 100644
> > > > > --- a/net/ipv4/udp_offload.c
> > > > > +++ b/net/ipv4/udp_offload.c
> > > > > @@ -471,6 +471,7 @@ static struct sk_buff *udp_gro_receive_segm=
ent(struct list_head *head,
> > > > >       struct sk_buff *p;
> > > > >       unsigned int ulen;
> > > > >       int ret =3D 0;
> > > > > +     int flush;
> > > > >
> > > > >       /* requires non zero csum, for symmetry with GSO */
> > > > >       if (!uh->check) {
> > > > > @@ -528,7 +529,17 @@ static struct sk_buff *udp_gro_receive_seg=
ment(struct list_head *head,
> > > > >                               skb_gro_postpull_rcsum(skb, uh,
> > > > >                                                      sizeof(str=
uct udphdr));
> > > > >
> > > > > -                             ret =3D skb_gro_receive(p, skb);
> > > > > +                             flush =3D NAPI_GRO_CB(p)->flush;
> > > > > +
> > > > > +                             if (NAPI_GRO_CB(p)->flush_id !=3D=
 1 ||
> > > > > +                                 NAPI_GRO_CB(p)->count !=3D 1 =
||
> > > > > +                                 !NAPI_GRO_CB(p)->is_atomic)
> > > > > +                                     flush |=3D NAPI_GRO_CB(p)=
->flush_id;
> > > > > +                             else
> > > > > +                                     NAPI_GRO_CB(p)->is_atomic=
 =3D false;
> > > > > +
> > > > > +                             if (flush || skb_gro_receive(p, s=
kb))
> > > > > +                                     ret =3D 1;
> > > >
> > > > UDP_L4 does not have the SKB_GSO_TCP_FIXEDID that uses is_atomic =
as
> > > > input.
> > > >
> > > > And I still don't fully internalize the flush_id logic after star=
ing
> > > > at it for more than one coffee.
> > >
> > > The flush_id field is there to indicate the difference between the
> > > current IPv4 ID of the previous IP header. It is meant to be used i=
n
> > > conjunction with the is_atomic for the frame coalescing. Basically
> > > after the second frame we can decide the pattern either incrementin=
g
> > > IPv4 ID or fixed, so on frames 3 or later we can decide to drop the=

> > > frame if it doesn't follow that pattern.
> > >
> > > > But even ignoring those, the flush signal of NAPI_GRO_CB(p)->flus=
h
> > > > set the network layer must be followed, so ACK. Thanks for the fi=
x.
> > >
> > > I'm not sure about the placement of this code though. That is the o=
ne
> > > thing that seems off to me. Specifically this seems like it should =
be
> > > done before we start the postpull, not after. It should be somethin=
g
> > > that can terminate the flow before we attempt to aggregate the UDP
> > > headers.
> >
> > In principle agreed that we should conclude the flush checks before
> > doing prep for coalescing.
> >
> > In practice it does not matter? NAPI_GRO_CB(skb)->csum will be ignore=
d
> > if the packet gets flushed.
> =

> I was referring more to the fact that this code is one of two
> branches. So there is this path, and then the is_flist branch that
> comes before this. I would think this logic would apply to both
> wouldn't it? I am not familiar with the code so I cannot say for
> certain if it does or doesn't. If it doesn't then yes. I suppose it
> doesn't matter.

With if_flist, all original segments are preserved in the frag_list,
so can be sent out as is.

Good point that that is no excuse for combining three or more
segments where some have a fixed id and others an incrementing id.=

