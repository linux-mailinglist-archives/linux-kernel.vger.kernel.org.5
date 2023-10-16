Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F64A7CB693
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjJPW3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPW3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:29:05 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85A695;
        Mon, 16 Oct 2023 15:29:03 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5ac88d2cfaaso2533464a12.2;
        Mon, 16 Oct 2023 15:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697495343; x=1698100143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIltTB5RXnB/HbiI9eyhaiUtmKimVkgUsywSRuJ70lU=;
        b=aopnqbaCSNHqF6KpHfOs9i4eGmk0PeNFmcRoz4IagUggRx/jolTCPG/Sa82+Kp3MAA
         ty1RIF8zeW104dMDSYNrNXOVvb2Y5gC42mwI4s9UsEs4022BVXN6SMilhVMAu1Wgqms5
         mqqdYiV/oaLCtGzoQer1GUTiM6YDs4SQ+JUSckLhMLTKM+KhNiqbqJa8ghsYG0wTA8+2
         jptFENH4daN10ehwdpaHofp+NPx1botHSVxc3C4Yp/RZG6Ohz71bm/jpxldklgQRjCig
         cbElB5VT3FHdKBEb6xwv4ANNEmPzigwE3b5eN7+L/cd8hjsWYPcWfVwO3kHJd95ct72a
         ezQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697495343; x=1698100143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIltTB5RXnB/HbiI9eyhaiUtmKimVkgUsywSRuJ70lU=;
        b=FmiJJIuPSUCqIIA2Z04ARtmU5zPb0UFrry74jE5NzmIEEsC5X/HwuXFM+hkP8h82f2
         VzoWotI3bK57je9t+XksdcfvHix5fjMmnVTRwpKBr72LJGV4ERrSZiGhZeYJ2dj/wgZ1
         D0fo6Rj5r1Tb7FOKhMDWYjmwsXWCL2UxLqGiFA1vqc/8A1eE6P8wEW5PcnxQObeAxQcy
         C3i2ImZCMrHA4BelvNEQi5VA7ikDZliYdlY2MCRw1hGZ+Zfdc7ll1/s+n3FYXAD21g/D
         PHpUmZDpi5HyFhGqghHy2yuk2KuuuC42+Cku5jGZa86PzWb5S/aAm8ILroAvsPqChXmP
         nnuw==
X-Gm-Message-State: AOJu0YxOXaICjJJOJrg44XEmjGbHIAGEsDQPgWzPyQVpaIoNdR6c4IRi
        hJhGdssLzindzUMn+q2/zgypGaDIICPRF+1K9AM=
X-Google-Smtp-Source: AGHT+IFHhGEr1n/vy8in1Q6rjAMQ2eCy9R7rGUdktM71Fc3B5tae9zwlqDKfG1+NelJjjKnouByHZrpBXR7uE/gOcYM=
X-Received: by 2002:a05:6a21:3e0b:b0:16b:c20d:f979 with SMTP id
 bk11-20020a056a213e0b00b0016bc20df979mr366217pzc.13.1697495343227; Mon, 16
 Oct 2023 15:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <ZS1/qtr0dZJ35VII@debian.debian> <4c524eba575992cc1adfc41b2b230835946b126c.camel@gmail.com>
 <CAO3-PbrhdDrFdjzkCFM9EvDTK2HA2_JCkYLBZiHka4WAMRtm4w@mail.gmail.com>
In-Reply-To: <CAO3-PbrhdDrFdjzkCFM9EvDTK2HA2_JCkYLBZiHka4WAMRtm4w@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 16 Oct 2023 15:28:26 -0700
Message-ID: <CAKgT0UfLECx9HZAKKK+Grv5oTiUTrwSkpscmJy_+EWax9AZU6w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] ipv6: avoid atomic fragment on GSO packets
To:     Yan Zhai <yan@cloudflare.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 2:51=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> On Mon, Oct 16, 2023 at 4:00=E2=80=AFPM Alexander H Duyck
> <alexander.duyck@gmail.com> wrote:
> >
> > On Mon, 2023-10-16 at 11:23 -0700, Yan Zhai wrote:
> > > GSO packets can contain a trailing segment that is smaller than
> > > gso_size. When examining the dst MTU for such packet, if its gso_size=
 is
> > > too large, then all segments would be fragmented. However, there is a
> > > good chance the trailing segment has smaller actual size than both
> > > gso_size as well as the MTU, which leads to an "atomic fragment". It =
is
> > > considered harmful in RFC-8021. An Existing report from APNIC also sh=
ows
> > > that atomic fragments are more likely to be dropped even it is
> > > equivalent to a no-op [1].
> > >
> > > Refactor __ip6_finish_output code to separate GSO and non-GSO packet
> > > processing. It mirrors __ip_finish_output logic now. Add an extra che=
ck
> > > in GSO handling to avoid atomic fragments. Lastly, drop dst_allfrag
> > > check, which is no longer true since commit 9d289715eb5c ("ipv6: stop
> > > sending PTB packets for MTU < 1280").
> > >
> > > Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf =
[1]
> > > Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 =
processing")
> > > Suggested-by: Florian Westphal <fw@strlen.de>
> > > Reported-by: David Wragg <dwragg@cloudflare.com>
> > > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > > ---
> > >  net/ipv6/ip6_output.c | 33 +++++++++++++++++++++++----------
> > >  1 file changed, 23 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> > > index a471c7e91761..1de6f3c11655 100644
> > > --- a/net/ipv6/ip6_output.c
> > > +++ b/net/ipv6/ip6_output.c
> > > @@ -162,7 +162,14 @@ ip6_finish_output_gso_slowpath_drop(struct net *=
net, struct sock *sk,
> > >               int err;
> > >
> > >               skb_mark_not_on_list(segs);
> > > -             err =3D ip6_fragment(net, sk, segs, ip6_finish_output2)=
;
> > > +             /* Last gso segment might be smaller than actual MTU. A=
dding
> > > +              * a fragment header to it would produce an "atomic fra=
gment",
> > > +              * which is considered harmful (RFC-8021)
> > > +              */
> > > +             err =3D segs->len > mtu ?
> > > +                     ip6_fragment(net, sk, segs, ip6_finish_output2)=
 :
> > > +                     ip6_finish_output2(net, sk, segs);
> > > +
> > >               if (err && ret =3D=3D 0)
> > >                       ret =3D err;
> > >       }
> > > @@ -170,10 +177,19 @@ ip6_finish_output_gso_slowpath_drop(struct net =
*net, struct sock *sk,
> > >       return ret;
> > >  }
> > >
> > > +static int ip6_finish_output_gso(struct net *net, struct sock *sk,
> > > +                              struct sk_buff *skb, unsigned int mtu)
> > > +{
> > > +     if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
> > > +         !skb_gso_validate_network_len(skb, mtu))
> > > +             return ip6_finish_output_gso_slowpath_drop(net, sk, skb=
, mtu);
> >
> > If we are sending fakejumbo or have a frame that doesn't pass the
> > muster it is just going immediately to ip6_finish_output. I think the
> > checks that you removed are needed to keep the socket from getting
> > stuck sending frames that will probably be discarded.
> >
>
> Hi Alexander,
>
> Thanks for the feedback! But I am not sure I follow the situation you
> mentioned here. If it is a fake jumbo but non GSO packet, it won't
> enter ip6_finish_output_gso. What I am really skipping are the
> dst_allfrag and frag_max_size checks on GSO packets, and dst_allfrag
> on non-GSO packets.
>
> As to dst_allfrag, I looked back at the case when this was added:
>
> https://www.mail-archive.com/bk-commits-head@vger.kernel.org/msg03399.htm=
l
>
> The actual feature was set only when a PMTU message carries a value
> smaller than 1280 byte. But the main line kernel just drops such
> messages now since the commit I pointed to in the change log (which
> makes sense because the feature was set based on old RFC-2460
> guidelines, and those have been deprecated in RFC-8200). Iproute2 also
> doesn't expose this option as well. Is there any case that I am not
> aware of here that still relies on it?
>
> For frag_max_size, I might be wrong but to my best knowledge it only
> applies when netfilter defrags packets. However, when dealing with
> fragments, both local output and GRO code won't produce GSO packets in
> the first place. Similarly, if we look at IPv4 implementation, it also
> does not consider frag_max_size in GSO handling. So I intentionally
> skip this for GSO packets in the change. WDYT?

I am not certain. Just looking at the code it seems like there were a
number of corner cases handled that this is getting rid of the code
for. Specifically my main concern is GSO being enabled for a path
where the MTU is incorrect due to something such as a tunnel being
between the system and the endpoint. In such a case it would normally
send back an ICMP message triggering a path MTU update which would
then have to ripple through.

I'm not an IPv6 expert though so perhaps I will leave that for
somebody else to provide feedback on.
