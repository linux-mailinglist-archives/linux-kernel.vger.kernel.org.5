Return-Path: <linux-kernel+bounces-145443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9698A5634
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D1EB20DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C364F78C6F;
	Mon, 15 Apr 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfYU9fi6"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD2F757FD;
	Mon, 15 Apr 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194411; cv=none; b=bcQFY9cWjBNSA1vze793juaUtwIDG939Q4K5MjLtzwKC5rCjhCkMUhHk03XJzkUM8SzZj/uwcnW4UeNlqnIgxSOP5ZwjcoY1N77Y+yghIqE4rjC7Xt1Is85A5o+bTS9aqYZTEiqLAumo/2a+OGPGMg3S/WoSuhDKg4+Rml8x2XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194411; c=relaxed/simple;
	bh=5o/bZl3xdnaZoAbttY2YpQFem0HsMz4sjcFfIQAFsU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+MJtnLUMhfy6OUtTgIzaLKvejErrh1P+lkDPFIpeLWk0omsJeB3Zy9qvck1xsGTYyCcgP5O4WHeE4UhmLPKF8VhqaAj4e6oFGi7us8NnL7RUQyZSygIzmUJE6XCRPPPKa6zHaOwaJ3NYjfHFzez92enYrF7Xbw8I+4pku8JE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfYU9fi6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-347c197a464so886835f8f.2;
        Mon, 15 Apr 2024 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713194408; x=1713799208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmSONjrG9P5UHWqk4X75Sk7Dx8YNHNhpgdKIK4omPcM=;
        b=nfYU9fi6jEVg/hxknVw4GSxdiWTn7Nzxl66ay32PwVo0G1+DEHtZROve5RW/9fdWnw
         SSntjrHHr9TIihqvwORZXQ3xQRoCRjtnxhXqqhs0TyE5FBvIjX8OeLpx0Hl0oz8o3nlX
         cX1CLAYEvdWGQyHHCDiZ7Yq/6n0UTUj5cM6bWRgjvORRElCoSMpd+Rz3PXnnv5LgV/8r
         Pha/MNs0otgdkEwCb1Fru+gdjMbjTG1MSdLx+Jw9QCyldjzDfu4FYiedISgJg7mr4e7u
         y0wC01SjtVu/GUJpNyWUrAtwzgtkJ54JgKTXsoqHdYLmfwdNZy0uPsSZzPwglmt12VxP
         7uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713194408; x=1713799208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmSONjrG9P5UHWqk4X75Sk7Dx8YNHNhpgdKIK4omPcM=;
        b=sArBWrKz93Lw3AUX/0JVHQ04pMi/GjU+EE7/eJHbOWjtKTnPMavhPug3XKQ9cvxkuk
         Vo6mbbYPJKv8SWUqT24v8oe92g4uyLVPz1bmjLG3qMsMv2lxFAErPVqhSV2imBSUU+iZ
         8T5SJlOOQkXlU5vAfYz+gsGHpT3FJYvVcsiEDq7WvaBgeCHIha2C/Q1zits5vanJdit1
         yiSKjO11OTNKXFnPtjj9bgo/eOLYpUplMzpViAV4+BGGA0WmAo9pWMaoi3g+GH1kgA2R
         gQF7kEOWoOyUFmoFIkOx/ZqdHR3KrX+2VG7qRbA1x3poByOc1n/+db84Yq5Di+Qscewo
         7+3w==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4WJVRYxw/xgzQ/CIZXV8FBcIAq9IPG2H4gVDY0lxSiZwgnCjP4zhLYxp+ONsKbxbqD+OymowjpxbI2TkUvseU3y8MtavS3Gl6vSIesEQD95H4QH4jSRh+J238rmoBAPhOlri
X-Gm-Message-State: AOJu0YzPZIWv7T4TrlZRIC2HrJbVAji5Dd8NP0PlUZ4Q+oH9mcGif1pY
	XrSdigq//d0Hn0WrNxr8TvEtyl40ofTGMym2nOeRJudsPZkmvDr/abeUG1z67i9LUoB7jmEpE2j
	PuFf+Uvo1BLHWWfzjVqNKPvlHpYc=
X-Google-Smtp-Source: AGHT+IH/XMwQL6RYpzbT8jMwNsSIbok5AQIs1jt2C+u//3Di7fGz9J+BNWrdBAVBTSE9iiNqRfJhInbEc8t1cOafMmM=
X-Received: by 2002:adf:ffcb:0:b0:347:adba:a3b0 with SMTP id
 x11-20020adfffcb000000b00347adbaa3b0mr2522065wrs.7.1713194407606; Mon, 15 Apr
 2024 08:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412152120.115067-1-richardbgobert@gmail.com>
 <20240412152120.115067-2-richardbgobert@gmail.com> <661ad1136bc10_3be9a7294c2@willemb.c.googlers.com.notmuch>
 <CAKgT0UfB+3DTjK7vq1uvG-2xtA53pw03ygJhwSG8j1bPtmYU8A@mail.gmail.com> <661d41106f996_c0c829445@willemb.c.googlers.com.notmuch>
In-Reply-To: <661d41106f996_c0c829445@willemb.c.googlers.com.notmuch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 15 Apr 2024 08:19:30 -0700
Message-ID: <CAKgT0UfbSPO9hAiF1nKM-ZOfDD7Yq9i8M29JX-mwz_NnPQAj0g@mail.gmail.com>
Subject: Re: [PATCH net v1 1/2] net: gro: add flush check in udp_gro_receive_segment
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 8:00=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Alexander Duyck wrote:
> > On Sat, Apr 13, 2024 at 11:38=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Richard Gobert wrote:
> > > > GRO-GSO path is supposed to be transparent and as such L3 flush che=
cks are
> > > > relevant to all flows which call skb_gro_receive. This patch uses t=
he same
> > > > logic and code from tcp_gro_receive but in the relevant flow path i=
n
> > > > udp_gro_receive_segment.
> > > >
> > > > Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fragliste=
d) UDP GRO packets")
> > > > Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> > >
> > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > >
> > > > ---
> > > >  net/ipv4/udp_offload.c | 13 ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > > > index 3498dd1d0694..1f4e08f43c4b 100644
> > > > --- a/net/ipv4/udp_offload.c
> > > > +++ b/net/ipv4/udp_offload.c
> > > > @@ -471,6 +471,7 @@ static struct sk_buff *udp_gro_receive_segment(=
struct list_head *head,
> > > >       struct sk_buff *p;
> > > >       unsigned int ulen;
> > > >       int ret =3D 0;
> > > > +     int flush;
> > > >
> > > >       /* requires non zero csum, for symmetry with GSO */
> > > >       if (!uh->check) {
> > > > @@ -528,7 +529,17 @@ static struct sk_buff *udp_gro_receive_segment=
(struct list_head *head,
> > > >                               skb_gro_postpull_rcsum(skb, uh,
> > > >                                                      sizeof(struct =
udphdr));
> > > >
> > > > -                             ret =3D skb_gro_receive(p, skb);
> > > > +                             flush =3D NAPI_GRO_CB(p)->flush;
> > > > +
> > > > +                             if (NAPI_GRO_CB(p)->flush_id !=3D 1 |=
|
> > > > +                                 NAPI_GRO_CB(p)->count !=3D 1 ||
> > > > +                                 !NAPI_GRO_CB(p)->is_atomic)
> > > > +                                     flush |=3D NAPI_GRO_CB(p)->fl=
ush_id;
> > > > +                             else
> > > > +                                     NAPI_GRO_CB(p)->is_atomic =3D=
 false;
> > > > +
> > > > +                             if (flush || skb_gro_receive(p, skb))
> > > > +                                     ret =3D 1;
> > >
> > > UDP_L4 does not have the SKB_GSO_TCP_FIXEDID that uses is_atomic as
> > > input.
> > >
> > > And I still don't fully internalize the flush_id logic after staring
> > > at it for more than one coffee.
> >
> > The flush_id field is there to indicate the difference between the
> > current IPv4 ID of the previous IP header. It is meant to be used in
> > conjunction with the is_atomic for the frame coalescing. Basically
> > after the second frame we can decide the pattern either incrementing
> > IPv4 ID or fixed, so on frames 3 or later we can decide to drop the
> > frame if it doesn't follow that pattern.
> >
> > > But even ignoring those, the flush signal of NAPI_GRO_CB(p)->flush
> > > set the network layer must be followed, so ACK. Thanks for the fix.
> >
> > I'm not sure about the placement of this code though. That is the one
> > thing that seems off to me. Specifically this seems like it should be
> > done before we start the postpull, not after. It should be something
> > that can terminate the flow before we attempt to aggregate the UDP
> > headers.
>
> In principle agreed that we should conclude the flush checks before
> doing prep for coalescing.
>
> In practice it does not matter? NAPI_GRO_CB(skb)->csum will be ignored
> if the packet gets flushed.

I was referring more to the fact that this code is one of two
branches. So there is this path, and then the is_flist branch that
comes before this. I would think this logic would apply to both
wouldn't it? I am not familiar with the code so I cannot say for
certain if it does or doesn't. If it doesn't then yes. I suppose it
doesn't matter.

