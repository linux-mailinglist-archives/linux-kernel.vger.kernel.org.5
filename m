Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF127FC141
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjK1QN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjK1QN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:13:26 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B40131
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:13:31 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so13537a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701188010; x=1701792810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HAiJaJ81nPkAx4TWzWQNYYGYBn6gKBuQc3mNIcpl1w=;
        b=gXwkuVa3pel40mtND5RY6TFEPpIE4+1Edrd7itN/I5Y8ygCnQA961C8Poc2uFsoTPm
         L10Ml49G6dA+z0H7mai1l8wHi1Q0FfgxExk/+MQQsEotO9mIuxM+MpZQ7q7JvYKHhXpG
         cktM+SXIRcvy3eLO/r+f3dm0GgQTjgB7rHjKGXnaPITrGzVo5AmN6+i2vm6RWjcXgTLV
         XtvU5KjSuJaUkaYtxQJCJoRc3PEAjRL099+4jxt1LtvNSTPJYsVZ8fXxY0bzO+XOfUxG
         5yaR7NjxT1kY3Z+UtNyWgzJ5sUyOblA/5pZ00YIANq4Owx42JcYTngFMCTUEROgqCcFw
         +7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701188010; x=1701792810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HAiJaJ81nPkAx4TWzWQNYYGYBn6gKBuQc3mNIcpl1w=;
        b=gPcvuFHid5aJpRrnQ+ii0q4lxTw3fUt1cc1QXrFIXr8UG0UsC9wX6j2BwHiIX1OjjV
         KPX4TpZHnemovDqGmfJhbeDTHRFkCJPWFOrsZkUEEkv6rZozmfBJKO3qYhaNcuTi+Twk
         Ke3Q91SA0iTYRLWiG7jHk/wThe/J3Hm2hpUKyPZpVmcrQad3uvlJMWICb9LqEqEOqP1i
         mkA1SoZ17yMy0TdK7QJRcFTOCtfHZ+CftW8YEI/VTsOTGP3j+fSytzt21rsJzkdNthCy
         zuXPSfolsspoMx2hbiRWtBHJ8do40Lz1pPZw0o5vMCH8rupAK3G71m5scqgi5G3Io++6
         hGTg==
X-Gm-Message-State: AOJu0YyTR2MGGz2H5fCS0zKB0sRIUL8nZOaZHB2/QKUl8oHZyKa6/7Ys
        SowMh91GvcT97kFtm4jyoqNcwLEOtT6LP5A2oZOGiQ==
X-Google-Smtp-Source: AGHT+IEiirBI/2XlMdNDeM06+b78jtscApyohz83EpRau/0BtARpdn73o9VamOU1GWSFta4sUvO2UISrBrOlO8dIgcU=
X-Received: by 2002:a05:6402:430e:b0:54b:67da:b2f with SMTP id
 m14-20020a056402430e00b0054b67da0b2fmr399570edc.7.1701188010040; Tue, 28 Nov
 2023 08:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20231126151652.372783-1-syoshida@redhat.com> <CANn89iKcstKYWoqUCXHO__7PfVRMFNnN5nRQVCTAADvFbcJRww@mail.gmail.com>
 <9daf8509e39cd20d9d806afdb425ad43af037f8d.camel@redhat.com> <CANn89iKO-5nwPAUtOzqRfqLhK77kgQB7Ep33rwFM+hgNKARLEw@mail.gmail.com>
In-Reply-To: <CANn89iKO-5nwPAUtOzqRfqLhK77kgQB7Ep33rwFM+hgNKARLEw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 28 Nov 2023 17:13:16 +0100
Message-ID: <CANn89iL0rj6zJYar9wwM3hGGwd60z_rZF6FoR47X4CYyiOt-VQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in ipgre_xmit()
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Shigeru Yoshida <syoshida@redhat.com>, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 5:05=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Nov 28, 2023 at 4:51=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On Tue, 2023-11-28 at 16:45 +0100, Eric Dumazet wrote:
> > > On Sun, Nov 26, 2023 at 4:17=E2=80=AFPM Shigeru Yoshida <syoshida@red=
hat.com> wrote:
> > > >
> > > > In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() r=
eturns
> > > > true. For example, applications can create a malformed packet that =
causes
> > > > this problem with PF_PACKET.
> > > >
> > > > This patch fixes the problem by dropping skb and returning from the
> > > > function if skb_pull() fails.
> > > >
> > > > Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> > > > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > > > ---
> > > >  net/ipv4/ip_gre.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> > > > index 22a26d1d29a0..95efa97cb84b 100644
> > > > --- a/net/ipv4/ip_gre.c
> > > > +++ b/net/ipv4/ip_gre.c
> > > > @@ -643,7 +643,8 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *s=
kb,
> > > >                 /* Pull skb since ip_tunnel_xmit() needs skb->data =
pointing
> > > >                  * to gre header.
> > > >                  */
> > > > -               skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
> > > > +               if (!skb_pull(skb, tunnel->hlen + sizeof(struct iph=
dr)))
> > > > +                       goto free_skb;
> > > >                 skb_reset_mac_header(skb);
> > > >
> > > >                 if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
> > > > --
> > >
> > >
> > > I have syszbot reports with an actual repro for this one.
> >
> > Could you please share them? I could not find easily the reports in
> > https://syzkaller.appspot.com/upstream
>
> Stack trace looks like the following:
>
> skbuff: skb_under_panic: text:ffffffff845f50a0 len:920 put:20
> head:ffff888171931000 data:ffff888171930ff8 tail:0x390 end:0x680
> dev:gre4
> ------------[ cut here ]------------
> kernel BUG at net/core/skbuff.c:120 !
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 12705 Comm: kworker/0:0 Not tainted
> 6.1.43-syzkaller-00022-g8f46c3493178 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 10/09/2023
> Workqueue: mld mld_ifc_work
> RIP: 0010:skb_panic net/core/skbuff.c:120 [inline]
> RIP: 0010:skb_under_panic+0x14c/0x150 net/core/skbuff.c:130
> Code: 60 98 da 85 48 c7 c6 05 6b 2f 86 48 8b 55 c0 8b 4d d4 44 8b 45
> d0 4c 8b 4d c8 53 41 55 41 54 41 57 e8 fc db f4 00 48 83 c4 20 <0f> 0b
> 66 90 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 18 41
> RSP: 0018:ffffc9000551f0a0 EFLAGS: 00010286
> RAX: 0000000000000087 RBX: ffff888162226000 RCX: 98ecdd4da3f28000
> RDX: 0000000000000000 RSI: 0000000000000400 RDI: 0000000000000000
> RBP: ffffc9000551f0e0 R08: ffffffff815a9ea5 R09: fffff52000aa3dad
> R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000390
> R13: 0000000000000680 R14: dffffc0000000000 R15: ffff888171930ff8
> FS: 0000000000000000(0000) GS:ffff8881f7000000(0000) knlGS:00000000000000=
00
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2f421000 CR3: 000000010f5a3000 CR4: 00000000003506b0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> skb_push+0xf3/0x120 net/core/skbuff.c:2181
> iptunnel_xmit+0x2d0/0x940 net/ipv4/ip_tunnel_core.c:67
> ip_tunnel_xmit+0x218f/0x2ae0 net/ipv4/ip_tunnel.c:813
> __gre_xmit net/ipv4/ip_gre.c:469 [inline]
> ipgre_xmit+0x7ac/0xaa0 net/ipv4/ip_gre.c:661
> __netdev_start_xmit include/linux/netdevice.h:4908 [inline]
> netdev_start_xmit include/linux/netdevice.h:4922 [inline]
> xmit_one net/core/dev.c:3602 [inline]
> dev_hard_start_xmit+0x1de/0x630 net/core/dev.c:3618
> __dev_queue_xmit+0x18c0/0x3700 net/core/dev.c:4268
> dev_queue_xmit include/linux/netdevice.h:3076 [inline]
> neigh_direct_output+0x17/0x20 net/core/neighbour.c:1592
> neigh_output include/net/neighbour.h:552 [inline]
> ip6_finish_output2+0x104a/0x1820 net/ipv6/ip6_output.c:134
> __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
> ip6_finish_output+0x5d9/0xb60 net/ipv6/ip6_output.c:206
> NF_HOOK_COND include/linux/netfilter.h:294 [inline]
> ip6_output+0x1f7/0x4d0 net/ipv6/ip6_output.c:227
> dst_output include/net/dst.h:444 [inline]
> NF_HOOK include/linux/netfilter.h:305 [inline]
> mld_sendpack+0x803/0xe40 net/ipv6/mcast.c:1820
> mld_send_cr net/ipv6/mcast.c:2121 [inline]
> mld_ifc_work+0x7dc/0xba0 net/ipv6/mcast.c:2653
> process_one_work+0x73d/0xcb0 kernel/workqueue.c:2299
> worker_thread+0xa60/0x1260 kernel/workqueue.c:2446
> kthread+0x26d/0x300 kernel/kthread.c:376
> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:skb_panic net/core/skbuff.c:120 [inline]
> RIP: 0010:skb_under_panic+0x14c/0x150 net/core/skbuff.c:130
> Code: 60 98 da 85 48 c7 c6 05 6b 2f 86 48 8b 55 c0 8b 4d d4 44 8b 45
> d0 4c 8b 4d c8 53 41 55 41 54 41 57 e8 fc db f4 00 48 83 c4 20 <0f> 0b
> 66 90 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 18 41
> RSP: 0018:ffffc9000551f0a0 EFLAGS: 00010286
> RAX: 0000000000000087 RBX: ffff888162226000 RCX: 98ecdd4da3f28000
> RDX: 0000000000000000 RSI: 0000000000000400 RDI: 0000000000000000
> RBP: ffffc9000551f0e0 R08: ffffffff815a9ea5 R09: fffff52000aa3dad
> R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000390
> R13: 0000000000000680 R14: dffffc0000000000 R15: ffff888171930ff8
> FS: 0000000000000000(0000) GS:ffff8881f7000000(0000) knlGS:00000000000000=
00
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2f421000 CR3: 000000010f5a3000 CR4: 00000000003506b0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

It looks like the repro I had was fixed by "#syz fix: bonding: stop
the device in bond_setup_by_slave()"

(I am not sure, I have to double check)

# See https://goo.gl/kgGztJ for information about syzkaller reproducers.
#{"repeat":true,"procs":1,"slowdown":1,"sandbox":"","sandbox_arg":0,"close_=
fds":false}
socket$inet(0x2, 0x2, 0x0)
r0 =3D socket(0x200000000000011, 0x4000000000080002, 0x0)
r1 =3D socket$netlink(0x10, 0x3, 0x0)
r2 =3D socket$netlink(0x10, 0x3, 0x0)
r3 =3D socket(0x10, 0x803, 0x0)
sendmsg$NL80211_CMD_CRIT_PROTOCOL_START(r3, &(0x7f0000000580)=3D{0x0,
0x0, &(0x7f0000000540)=3D{0x0, 0x1c}}, 0x0)
getsockname$packet(r3, &(0x7f0000000600)=3D{0x11, 0x0, <r4=3D>0x0, 0x1,
0x0, 0x6, @broadcast}, &(0x7f0000000080)=3D0x14)
sendmsg$nl_route(r2, &(0x7f0000000040)=3D{0x0, 0x0,
&(0x7f0000000000)=3D{&(0x7f0000000340)=3DANY=3D[@ANYBLOB=3D"3c0000001000850=
600002000fe612233ca000800",
@ANYRES32=3Dr4, @ANYBLOB=3D"2377f29e252155b21c0012000c000100626f6e640000000=
00c000200080001000134e7307075a7cc6d2dba6e4dce25f18968dd3d6f77199cd06d7a4cfc=
dc99dcfd5ec3f3e3d98be8a8bac2dcc414b58dda48b3ea35411d5b112c26f31b352982f55be=
446b3dd47e435954252213828ba98a1bc363278f8bd13ad746bb8edad619162f5d1892e9fa4=
2e4fe2b60f5fe2bb963f08d6696820ade9cff2b2deb91ce5657168a90dc5230e33b8c26cd92=
5c31366a2ae339f12ba8966be1439cec635b08c0a97490b133a5b7360b59347833fc95a7bf3=
dc9bc64741de1a6e83c9bdfdfd0baabec981099bb3dbd64a7e7979cfb7935affbcda49190b7=
ec9bc1e89d6ccedec20f91b571e6fc049ba82821b26ca4f85f4b03f70b176b43de915bec76e=
405bce49a4b46ec745b51f36282916b77d7f913a6afd6813df2c"],
0x3c}}, 0x0)
sendmsg$nl_route(r1, &(0x7f0000000240)=3D{0x0, 0x0,
&(0x7f0000000180)=3D{&(0x7f0000000780)=3D@newlink=3D{0x58, 0x10, 0xffffff1f=
,
0x0, 0x0, {0x0, 0x0, 0x0, 0x0, 0x800}, [@IFLA_LINKINFO=3D{0x28, 0x12,
0x0, 0x1, @gre=3D{{0x8}, {0x1c, 0x2, 0x0, 0x1, [@IFLA_GRE_LOCAL=3D{0x8,
0x6, @broadcast}, @IFLA_GRE_TOS=3D{0x5, 0x9, 0x8}, @IFLA_GRE_OKEY=3D{0x8,
0x5, 0x8}]}}}, @IFLA_MASTER=3D{0x8, 0xa, r4}, @IFLA_GROUP=3D{0x8, 0x1b,
0x8000}]}, 0x58}}, 0x4004000)
bind$packet(r0, &(0x7f00000000c0)=3D{0x11, 0x0, r4, 0x1, 0x0, 0x6, @remote}=
, 0x14)
sendmsg$nl_route(r0, &(0x7f0000000300)=3D{0x0, 0x0, &(0x7f00000002c0)=3D{0x=
0}}, 0x0)
