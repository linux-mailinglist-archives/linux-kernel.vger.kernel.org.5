Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C347CB5AF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjJPVwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjJPVv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:51:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176FAEB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:51:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso10383153a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697493112; x=1698097912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDfJSs5OzGXgc3TokAo6lqqr7PnjzUUqy1FZuPSGgB4=;
        b=X1RxFHq2ve6JEwV8ZhI34+bEmwPF3Ofat12z6Qm2Ti853HxecH4dR1DhIJEN8qvOsl
         CSvB/h7FUkj+rzKdETOF2YkpIayzoo10OHZx5+uDXsh/pGhA7sausoYTDK0i3ZAp3p3G
         /RGC+RB/AaP/fzDoyCFZVfOYU9ai/53I+a6DaqO54O1ieKyrsRZ87ffOoafrbr5VGHMJ
         GGfHlXpdwmbtP/TU6atEicURzkb6umq4OxBAjtnDpPWgveKIkZPTRrKuYm+WBNFjidKu
         2wBliQqcr1Z3mqPObXZmGWvb37zMZQprog8WWMpTSx4QsI0JoRkRRCjSIxD4BLmb3ot1
         1LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697493112; x=1698097912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDfJSs5OzGXgc3TokAo6lqqr7PnjzUUqy1FZuPSGgB4=;
        b=LgqfFHOYpdCBVjfJpJQsACRvtXAnVzkHqDdeF5lUSduxr5vOMItNaQOEJMPIzKu62a
         9j+bAwl+AMhmYD53XIvmC1SfYtVhBcAyy2CYvqzDG2OEJF1YV4dYZ9T2TbYwNzMGV+hT
         ekryaphSDOSFv0p0SuMW8OLjhNPUE3BuGopV1FdkIugSmRUafBLIaf/zZKQNf8nDVLDY
         HzWJdOZ2C/OEjkJeD25OL1/MULZSgz2ALbvsMLvpfxNOnVbMQI4dzPRLuPWt2hAYZBSp
         ECkkmfEB0wQorvVPTzaVdmdvMk1PPoCmqq03gc+9Zure7AVNxMmJnmczq2Nkpn/rZxxr
         o15A==
X-Gm-Message-State: AOJu0YzCOK17gwS8lXtoYfbWLgWo1SNsLKrMhr0MdbhW7kibyQ/dACXI
        TmZv/8BsldImR3pi7bP2pKVL1Y3dP6nqngZJKbK4Ng==
X-Google-Smtp-Source: AGHT+IEERpWYV2vvHcCnO5+y33naH5Yx+loYIItAIaXNa0Ly8dUTDTTte1O+ITWOJ2yMMclBJqz5TFZylUajwBV8p0g=
X-Received: by 2002:a50:c301:0:b0:53d:fa08:bd2e with SMTP id
 a1-20020a50c301000000b0053dfa08bd2emr32625edb.20.1697493112467; Mon, 16 Oct
 2023 14:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <ZS1/qtr0dZJ35VII@debian.debian> <4c524eba575992cc1adfc41b2b230835946b126c.camel@gmail.com>
In-Reply-To: <4c524eba575992cc1adfc41b2b230835946b126c.camel@gmail.com>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Mon, 16 Oct 2023 16:51:41 -0500
Message-ID: <CAO3-PbrhdDrFdjzkCFM9EvDTK2HA2_JCkYLBZiHka4WAMRtm4w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] ipv6: avoid atomic fragment on GSO packets
To:     Alexander H Duyck <alexander.duyck@gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 4:00=E2=80=AFPM Alexander H Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Mon, 2023-10-16 at 11:23 -0700, Yan Zhai wrote:
> > GSO packets can contain a trailing segment that is smaller than
> > gso_size. When examining the dst MTU for such packet, if its gso_size i=
s
> > too large, then all segments would be fragmented. However, there is a
> > good chance the trailing segment has smaller actual size than both
> > gso_size as well as the MTU, which leads to an "atomic fragment". It is
> > considered harmful in RFC-8021. An Existing report from APNIC also show=
s
> > that atomic fragments are more likely to be dropped even it is
> > equivalent to a no-op [1].
> >
> > Refactor __ip6_finish_output code to separate GSO and non-GSO packet
> > processing. It mirrors __ip_finish_output logic now. Add an extra check
> > in GSO handling to avoid atomic fragments. Lastly, drop dst_allfrag
> > check, which is no longer true since commit 9d289715eb5c ("ipv6: stop
> > sending PTB packets for MTU < 1280").
> >
> > Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1=
]
> > Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 pr=
ocessing")
> > Suggested-by: Florian Westphal <fw@strlen.de>
> > Reported-by: David Wragg <dwragg@cloudflare.com>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> >  net/ipv6/ip6_output.c | 33 +++++++++++++++++++++++----------
> >  1 file changed, 23 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> > index a471c7e91761..1de6f3c11655 100644
> > --- a/net/ipv6/ip6_output.c
> > +++ b/net/ipv6/ip6_output.c
> > @@ -162,7 +162,14 @@ ip6_finish_output_gso_slowpath_drop(struct net *ne=
t, struct sock *sk,
> >               int err;
> >
> >               skb_mark_not_on_list(segs);
> > -             err =3D ip6_fragment(net, sk, segs, ip6_finish_output2);
> > +             /* Last gso segment might be smaller than actual MTU. Add=
ing
> > +              * a fragment header to it would produce an "atomic fragm=
ent",
> > +              * which is considered harmful (RFC-8021)
> > +              */
> > +             err =3D segs->len > mtu ?
> > +                     ip6_fragment(net, sk, segs, ip6_finish_output2) :
> > +                     ip6_finish_output2(net, sk, segs);
> > +
> >               if (err && ret =3D=3D 0)
> >                       ret =3D err;
> >       }
> > @@ -170,10 +177,19 @@ ip6_finish_output_gso_slowpath_drop(struct net *n=
et, struct sock *sk,
> >       return ret;
> >  }
> >
> > +static int ip6_finish_output_gso(struct net *net, struct sock *sk,
> > +                              struct sk_buff *skb, unsigned int mtu)
> > +{
> > +     if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
> > +         !skb_gso_validate_network_len(skb, mtu))
> > +             return ip6_finish_output_gso_slowpath_drop(net, sk, skb, =
mtu);
>
> If we are sending fakejumbo or have a frame that doesn't pass the
> muster it is just going immediately to ip6_finish_output. I think the
> checks that you removed are needed to keep the socket from getting
> stuck sending frames that will probably be discarded.
>

Hi Alexander,

Thanks for the feedback! But I am not sure I follow the situation you
mentioned here. If it is a fake jumbo but non GSO packet, it won't
enter ip6_finish_output_gso. What I am really skipping are the
dst_allfrag and frag_max_size checks on GSO packets, and dst_allfrag
on non-GSO packets.

As to dst_allfrag, I looked back at the case when this was added:

https://www.mail-archive.com/bk-commits-head@vger.kernel.org/msg03399.html

The actual feature was set only when a PMTU message carries a value
smaller than 1280 byte. But the main line kernel just drops such
messages now since the commit I pointed to in the change log (which
makes sense because the feature was set based on old RFC-2460
guidelines, and those have been deprecated in RFC-8200). Iproute2 also
doesn't expose this option as well. Is there any case that I am not
aware of here that still relies on it?

For frag_max_size, I might be wrong but to my best knowledge it only
applies when netfilter defrags packets. However, when dealing with
fragments, both local output and GRO code won't produce GSO packets in
the first place. Similarly, if we look at IPv4 implementation, it also
does not consider frag_max_size in GSO handling. So I intentionally
skip this for GSO packets in the change. WDYT?


> > +
> > +     return ip6_finish_output2(net, sk, skb);
> > +}
> > +
> >  static int __ip6_finish_output(struct net *net, struct sock *sk, struc=
t sk_buff *skb)
> >  {
> >       unsigned int mtu;
> > -
>
> This blank line can probably be left there to separate variable
> declarations from code.
>
my bad, should not have included it. I'll revise this.

thanks
Yan

> >  #if defined(CONFIG_NETFILTER) && defined(CONFIG_XFRM)
> >       /* Policy lookup after SNAT yielded a new policy */
> >       if (skb_dst(skb)->xfrm) {
> > @@ -183,17 +199,14 @@ static int __ip6_finish_output(struct net *net, s=
truct sock *sk, struct sk_buff
> >  #endif
> >
> >       mtu =3D ip6_skb_dst_mtu(skb);
> > -     if (skb_is_gso(skb) &&
> > -         !(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
> > -         !skb_gso_validate_network_len(skb, mtu))
> > -             return ip6_finish_output_gso_slowpath_drop(net, sk, skb, =
mtu);
> > +     if (skb_is_gso(skb))
> > +             return ip6_finish_output_gso(net, sk, skb, mtu);
> >
> > -     if ((skb->len > mtu && !skb_is_gso(skb)) ||
> > -         dst_allfrag(skb_dst(skb)) ||
> > +     if (skb->len > mtu ||
>
> This change looks a bit too aggressive to me. Basically if the frame is
> gso you now bypass the ip6_fragment entirely and are ignoring the
> dst_allfrag and frag_max_size case below. See the fail_toobig code in
> ip6_fragment.
>
> >           (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max=
_size))
> >               return ip6_fragment(net, sk, skb, ip6_finish_output2);
> > -     else
> > -             return ip6_finish_output2(net, sk, skb);
> > +
> > +     return ip6_finish_output2(net, sk, skb);
> >  }
> >
> >  static int ip6_finish_output(struct net *net, struct sock *sk, struct =
sk_buff *skb)
>
