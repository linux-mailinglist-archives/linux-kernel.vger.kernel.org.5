Return-Path: <linux-kernel+bounces-25596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3750482D329
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B4D2815BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66E41FAE;
	Mon, 15 Jan 2024 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck1TjCxs"
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122A17CB;
	Mon, 15 Jan 2024 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so5531222276.1;
        Sun, 14 Jan 2024 18:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705286467; x=1705891267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRiH3rKb0wRjOf3BbgKydSU389B/0RSNV5DhI9M+Ozg=;
        b=ck1TjCxsjHLQY1ldhfv6EqDPeIrFfvcp2tS88mFgjiujhZfl7lu9++rakU1xD+UKHL
         W+oueTCiy8oeI3SXVVwbMC0UO/Gp7C/Z/iy2pKj8KGMq6QpD3tFrIHBnxfhCUQRzZ6Fx
         SKtezcSsnNFXmSTd9WxB5n+h9ZKGzzrZ37ZyVQwuvZTVDfvOaMBgIBqL3p81mO2sRmav
         1xu5rsFAv/clYOuW3LuR5eiB2U1lU/3DWWTadZnuqdkKy5VCx2knriS9oZWvRMUAMg0u
         tewdwsqpUhDN+pMgPY4qdA3As2PDZRItc/hbTnSjT+WzXpFhBFAWevSFIDsPMiBepJoF
         iQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705286467; x=1705891267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRiH3rKb0wRjOf3BbgKydSU389B/0RSNV5DhI9M+Ozg=;
        b=gMjoDwuzBP+hqUxtt0sGYwyMEyHU0q1HIVznMcWNNA/DNz0n6wF4jEue1fmmsspCqm
         QgWxm4IdLzl1KX7VVJrYtq8UFarK/t1rE2pF3ZXFauZiPKkpUUn40W7awDYy9MifslSB
         3a5WC3Z9bqMa0HrZpY1ZO+fzL7yUslKk+9qMVnGbsuYIa2sAmzHoHBwUqnT1c04gN8mg
         ljts2+5hS63nx8vfHGQC7bLmVK7VV1TCo7WB1fYVlb93InZjXDYb7gchW2xZV3ug1Vu/
         jz+VgmdAAZMSKuCT1Y2+o8SX2S3gP8Ynv8j18Bam3nsjgj3K7vYn3jFQW+b6efmUR3W0
         lsig==
X-Gm-Message-State: AOJu0YzCQLE5nezAIofLElcallTYPf3ZZsWWF4h0DoDd3c1nyq9lO3iw
	MEvMJ45OYJScYBRNT3dxePTm1e8vkQ3iU7w+SOQ=
X-Google-Smtp-Source: AGHT+IEBFwxTzzCHfqepNUmxksnmgIQ3vF9oVF+2AKFSQiZVFTFH54QoEjst3wDA9VV67vjRCnr2HJGLFNoQ5JOgsmw=
X-Received: by 2002:a25:d88b:0:b0:dbd:998:5fbb with SMTP id
 p133-20020a25d88b000000b00dbd09985fbbmr1629974ybg.99.1705286467574; Sun, 14
 Jan 2024 18:41:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112094603.23706-1-menglong8.dong@gmail.com> <20240113154632.GI392144@kernel.org>
In-Reply-To: <20240113154632.GI392144@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 15 Jan 2024 10:40:56 +0800
Message-ID: <CADxym3a6qNcb47R_DfXMsac9Ou_zkz5hR3bGY9tr7Jhsdw3y-Q@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2] net: tcp: accept old ack during closing
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 11:46=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Fri, Jan 12, 2024 at 05:46:03PM +0800, Menglong Dong wrote:
> > For now, the packet with an old ack is not accepted if we are in
> > FIN_WAIT1 state, which can cause retransmission. Taking the following
> > case as an example:
> >
> >     Client                               Server
> >       |                                    |
> >   FIN_WAIT1(Send FIN, seq=3D10)          FIN_WAIT1(Send FIN, seq=3D20, =
ack=3D10)
> >       |                                    |
> >       |                                Send ACK(seq=3D21, ack=3D11)
> >    Recv ACK(seq=3D21, ack=3D11)
> >       |
> >    Recv FIN(seq=3D20, ack=3D10)
> >
> > In the case above, simultaneous close is happening, and the FIN and ACK
> > packet that send from the server is out of order. Then, the FIN will be
> > dropped by the client, as it has an old ack. Then, the server has to
> > retransmit the FIN, which can cause delay if the server has set the
> > SO_LINGER on the socket.
> >
> > Old ack is accepted in the ESTABLISHED and TIME_WAIT state, and I think
> > it should be better to keep the same logic.
> >
> > In this commit, we accept old ack in FIN_WAIT1/FIN_WAIT2/CLOSING/LAST_A=
CK
> > states. Maybe we should limit it to FIN_WAIT1 for now?
> >
> > Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> > ---
> > v2:
> > - fix the compiling error
> > ---
> >  net/ipv4/tcp_input.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index df7b13f0e5e0..70642bb08f3a 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -6699,17 +6699,21 @@ int tcp_rcv_state_process(struct sock *sk, stru=
ct sk_buff *skb)
> >               return 0;
> >
> >       /* step 5: check the ACK field */
> > -     acceptable =3D tcp_ack(sk, skb, FLAG_SLOWPATH |
> > -                                   FLAG_UPDATE_TS_RECENT |
> > -                                   FLAG_NO_CHALLENGE_ACK) > 0;
> > +     reason =3D tcp_ack(sk, skb, FLAG_SLOWPATH |
> > +                               FLAG_UPDATE_TS_RECENT |
> > +                               FLAG_NO_CHALLENGE_ACK);
>
> Hi Menglong Dong,
>
> Probably I am missing something terribly obvious,
> but I am confused about the types used here.
>
> The type of reason is enum skb_drop_reason.
> For which, which on my system, the compiler uses an unsigned entity.
> i.e. it is an unsigned integer.
>
> But tcp_ack returns a (signed) int. And below reason is checked
> for values less than zero, and negated. This doesn't seem right.
>

Hello! You are right, and it seems that I make the same
mistake with Eric in this commit:

843f77407eeb ("tcp: fix signed/unsigned comparison")

I should convert it to signed int before comparing it
like this:

  if ((int)reason <=3D 0) {
      ......
      if ((int)reason < 0) {
          ....
      }
  }

Thanks!
Menglong Dong

> >
> > -     if (!acceptable) {
> > +     if (reason <=3D 0) {
> >               if (sk->sk_state =3D=3D TCP_SYN_RECV)
> >                       return 1;       /* send one RST */
> > -             tcp_send_challenge_ack(sk);
> > -             SKB_DR_SET(reason, TCP_OLD_ACK);
> > -             goto discard;
> > +             /* accept old ack during closing */
> > +             if (reason < 0) {
> > +                     tcp_send_challenge_ack(sk);
> > +                     reason =3D -reason;
> > +                     goto discard;
> > +             }
> >       }
> > +     SKB_DR_SET(reason, NOT_SPECIFIED);
> >       switch (sk->sk_state) {
> >       case TCP_SYN_RECV:
> >               tp->delivered++; /* SYN-ACK delivery isn't tracked in tcp=
_ack */
> > --
> > 2.39.2
> >

