Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168B27E3020
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjKFWpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjKFWpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:45:05 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A210EA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:44:51 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5afabb23900so60381457b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699310691; x=1699915491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jh4ueUUtnHe+xpZ555uV9QkBq8rONsDDGRxRxIz5vUk=;
        b=V2TAxHD48QaOdmpfyG5eD8yq/njaTlwLVCQhpMd7KzdrRDhvua3C3Kms1pvND9NjN0
         1tM0lgZ8AhW8WiAQrEJPbQNrNTUW8TC0OBddroDUveaV0EiNvhkiIyyCmA4PfVodlth2
         9kNqF3wEACpON3+2PNIXOoausAotBZlyOPzN3xtfezBvfGmTLr0Oz8AiEE5qbu0u5/ZM
         TcKNDuqLYDRZr8dJKf0ISkfIbgQi+sGWjd3iuwd8YEggYpTZmhT48AENeVasb+3zk1Vi
         A5QKERiavNQZu2Kr2xbts/NT1FtEeJP3mdaV3nzlxB6Bvz+PdtzGjnenzDVs1cS3JFfu
         ycOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310691; x=1699915491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jh4ueUUtnHe+xpZ555uV9QkBq8rONsDDGRxRxIz5vUk=;
        b=cRL2WI1GxZpg/AR2x6VunuOIN0ssBgEb90/Wvz2W0e1ESNkkvQZwShd55ET9a89HMv
         nqxjvjMXGjJvk+eyWRxmwPBDDXbTwo6gh+D51wnC61RswRSgrNiwgACsKM793w1HfnFp
         96la884g1hMMgxnXQFEL1tTqyDwlxsXx9NOSPlhnG5rUBT+Pl4vmaZ76Tz4jmMGJ2kWh
         oievhkRDhgbXCM8nh2/feYcl7EJNBBG3D5srRkJr0czexMfEX6FY1ceg6s8GMqr2silA
         lRfssM5bRsEC0RS/JysoAKEZ0SGIUSPppMksrlrsU/BHpLX6lTnny2o6VGUjKGKNI5kY
         Ybfw==
X-Gm-Message-State: AOJu0Yw8S5sGgT8uVtd+wneSoqxsRRfyMY/BUE9eKxaknxXVxuNvb1U8
        cVT2MSgdMV3oFY0FBZTQM3QE16PHYP4NFX0zgiX6uQ==
X-Google-Smtp-Source: AGHT+IFW46W/qi2R11wocWXMwQfH71KxUBDhedZj2DPWapnZTpkSztTFIYEo5cIEnwGFOFiUNQD9a/CWiF7cl9YjzYQ=
X-Received: by 2002:a05:690c:681:b0:577:a46:26e5 with SMTP id
 bp1-20020a05690c068100b005770a4626e5mr15037079ywb.31.1699310690873; Mon, 06
 Nov 2023 14:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
 <20231105-gemini-largeframe-fix-v2-4-cd3a5aa6c496@linaro.org> <20231106132626.orn5r57cc7n5ditj@skbuf>
In-Reply-To: <20231106132626.orn5r57cc7n5ditj@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Nov 2023 23:44:37 +0100
Message-ID: <CACRpkdb-iAQdw3S_1iBX=SFt6LCPvdW8+K0nvuXxD01q1K9A1A@mail.gmail.com>
Subject: Re: [PATCH net v2 4/4] net: ethernet: cortina: Handle large frames
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 2:26=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com> =
wrote:
> On Sun, Nov 05, 2023 at 09:57:26PM +0100, Linus Walleij wrote:

> > If we start sending bigger frames (after first bumping up the MTU
> > on both interfaces sending and receiveing the frames), truncated
> > packets start to appear on the target such as in this tcpdump
> > resulting from ping -s 1474:
>
> A bit related: what is gmac_fix_features() supposed to do? I see it
> unsets GMAC_OFFLOAD_FEATURES when the MTU goes over a certain limit,
> and that also includes NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM. Is that
> limit correct, or is it supposed to kick in sooner, to allow
> validate_xmit_skb() -> skb_csum_hwoffload_help() do the software
> checksuum for you? I'm not sure whether that was the intention.

That indeed seems like the intention. But it's a bit suboptimal, because it
disables hardware checksum just because the MTU goes over a
certain level, and stops using the hardware checksum also for all
packets smaller than the MTU :(

I'll delete this and make the driver slot in the SW fallback per-packet
instead, I think it is fair to assume that most packets will be < MTU
and it is really just a question of where the fallback gets called.

> > Suggested-by: Vladimir Oltean <olteanv@gmail.com>
>
> To be clear, I didn't suggest any of this. I just pointed towards the gem=
ini.c
> driver as being the problem. Please remove my Suggested-by tag.

OK sorry, it was just my way of trying to provide credit where
credit is due, because you helped so much with this bug.

> > -     if (skb->ip_summed !=3D CHECKSUM_NONE) {
> > +     if (skb->len >=3D ETH_FRAME_LEN) {
> > +             /* Hardware offloaded checksumming isn't working on frame=
s
> > +              * bigger than 1514 bytes. Perhaps the buffer is only 151=
8
> > +              * bytes fitting a normal frame and a checksum?
> > +              * Just use software checksumming and bypass on bigger fr=
ames.
> > +              */
> > +             if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> > +                     ret =3D skb_checksum_help(skb);
> > +                     if (ret)
> > +                             return ret;
> > +             }
> > +             word1 |=3D TSS_BYPASS_BIT;
> > +     } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> >               int tcp =3D 0;
> >
> >               if (skb->protocol =3D=3D htons(ETH_P_IP)) {
>
> [ context: tag_rtl4_a.c is a "category 2", aka "Ethertype", tagger ]
>
> We say this in Documentation/networking/dsa/dsa.rst:
>
> Checksum offload should work with category 1 and 2 taggers when the DSA c=
onduit
> driver declares NETIF_F_HW_CSUM in vlan_features
> and looks at csum_start and csum_offset.
> For those cases, DSA will shift the checksum start and offset by
> the tag size. If the DSA conduit driver still uses the legacy NETIF_F_IP_=
CSUM
> or NETIF_F_IPV6_CSUM in vlan_features, the offload might only work if the
> offload hardware already expects that specific tag (perhaps due to matchi=
ng
> vendors).

Since things work smoothly I can only assume that the Gemini
checksum engine actually knows about the Realtek ethertype (0x8899)
and the protocol (0xa) and takes action on that, since the switch works.

OR: it has some heuristic on for how to handle it. (Such as looking for
a valid TCP or UDP header to figure out where to put the checksum.)

But I have no idea how it does it. It doesn't have a firmware AFAIK.

Examples listed were ICMP so just IP checksums but I tried for example
SSH, and HTTP and packets look like this:

22:51:35.457191 9a:ec:30:5a:46:96 (oui Unknown) > bc:ae:c5:6b:a8:3d
(oui Unknown),
ethertype IPv4 (0x0800), length 434: (tos 0x48, ttl 64, id 8221,
offset 0, flags [DF], proto TCP (6), length 420)
    _gateway.48102 > fedora.ssh: Flags [P.], cksum 0xcf1b (correct),
seq 811:1179, ack 2310,
   win 2054, options [nop,nop,TS val 74858741 ecr 1981407207], length 368

Checksum correct. So...

> DSA user ports inherit those flags from the conduit, and it is up to
> the driver to correctly fall back to software checksum when the IP header=
 is not
> where the hardware expects. If that check is ineffective, the packets mig=
ht go
> to the network without a proper checksum (the checksum field will have th=
e
> pseudo IP header sum).

It definately does not contain the pseudo IP header sum because
it would be the same all the time but tcpdump is happy:
cksum 0xcf1b (correct)
cksum 0x0655 (correct)
cksum 0xd247 (correct)
cksum 0x06b1 (correct)

> Shouldn't "word1 |=3D TSS_BYPASS_BIT;" be done depending on skb->protocol=
,
> rather than depending on skb->len?!
>
>                 if (skb->protocol =3D=3D htons(ETH_P_IP)) {
>                         word1 |=3D TSS_IP_CHKSUM_BIT;
>                         tcp =3D ip_hdr(skb)->protocol =3D=3D IPPROTO_TCP;
>                 } else { /* IPv6 */
>                         word1 |=3D TSS_IPV6_ENABLE_BIT;
>                         tcp =3D ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_TCP=
;
>                 } // here
>                         word1 |=3D TSS_BYPASS_BIT;

Oddly it assumes everything is either TCP or UDP on
IPv4 or IPv6. And yet things such as ICMP work just fine.

I think the checksum engine can contain some various
heuristics, such as if it cannot recognize what is coming
in as the selected TCP or UDP, it will pass right through.

> Gemini should never attempt to provide checksums for DSA-tagged packets
> unless it is able to take skb->csum_start into consideration, otherwise
> it will get it wrong.
>
> This is somewhat independent of the other problem you've found, which
> seems to be that large non-DSA packets get truncated anyway. But not
> bypassing TX checksum offload truncates a packet? Hmm, strange.

I have a theory about that in the comment, which is that when they
engineered the hardware they only put in a hardware buffer for
1518 bytes in the checksum engine. If you try to put in any more
it gets truncated. It's a reasonable guess.

If you do not set the checkumming engine to "bypass" it will try
to fit the incoming paket into the checksumming buffer, and then
it will look to see if it can find the right TCP or UDP headers.
If it can't it will pass the packet out from the buffer without doing
any changes. But the buffer is just 1518 bytes, which means that
no matter what kind of package it is, it will get truncated if it
does not fit into the checksumming buffer.

This would give exactly the behaviour we're seeing.

Yours,
Linus Walleij
