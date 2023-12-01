Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2C380005E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377459AbjLAAjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377446AbjLAAjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:39:40 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9687510C2;
        Thu, 30 Nov 2023 16:39:44 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfafe3d46bso131265ad.0;
        Thu, 30 Nov 2023 16:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701391184; x=1701995984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POn16WWR75l5/dVgevLDatVpLrPk2Rkku4P/FxfsQyU=;
        b=jsV5m5ij4Z2IXPYMO3sHF9h3Pxx11Ml4Tqt5VL87ij+iQY67F/gX6EKwZfE/ZXfe/U
         UpB+EqskjSfMvHGnkRMKrglWTpZLJSVtIuYIDu8CWXi2iJYLMpVA1PVta4BQjv6PwVwP
         UZY2YD53Q/+3Gicr4MANbONNKyeTqS1GBsXTQy5YC1alQgiBofKh/Xwco5z8mQ5AUkiy
         xQb2YzQ4RvaWjLSdSYZ3vagq/7Q/l4j10tpvXjyWTfygMSzT3149dNzE39o/3zBHFvju
         tXYrG1qlqY5NQxjGXUJtV8UKhujOUSDNDkjNzMZuRRgkdrkp/w2jaK/8rutNvFWED4Ff
         djkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701391184; x=1701995984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POn16WWR75l5/dVgevLDatVpLrPk2Rkku4P/FxfsQyU=;
        b=AG2REdNOcjjmDc2EECj1Ic1e51G+W4wGLWFEUhb5T8Gf5OiCyjeu/5ilKcDqxpeVxR
         MIApg6JNOi+7vp/TupMsq5EoGFSJh7K6+hzL6eMakGtQBqnxGvqOyxvzStWR5NDMvFKu
         aL6i4MDY81WO9OQlYDvpiBt0pgf6QA8qCgBXbjb1CS1h2sVFOro4h2k9nP4q597WBTPq
         N4MlqOlJ91SHJXhUkaS2U/nDKhiXDOygn+69kxzsB21UJMqgG3e39Qv5W5cUxjRdImen
         Rd3bQ4+GD2pG99rsIespYcdDinIVTwlo5yb1Zf6c1KqL7J2ppNjKfiFIlrB6aYxil5H6
         OxvQ==
X-Gm-Message-State: AOJu0YzsPy4bV0kA1k1qcXRk6XtxbuXxEQr+LHxr3U9qi76bU7Doz2h9
        JWGydOtq5Fk6WBlUCaeB4TmpDOcjcm22Bh5bnR0zvf89YIncMg==
X-Google-Smtp-Source: AGHT+IEtVudsG46uTMBuJbI6wLW6a69udvtTvqaMI/WTYi2br8pdT9qw3QDMoyJyrnFI1ECHUm+dAadBtVO7a2TtZUc=
X-Received: by 2002:a17:902:dacc:b0:1cf:a70b:39b7 with SMTP id
 q12-20020a170902dacc00b001cfa70b39b7mr26716483plx.43.1701391183673; Thu, 30
 Nov 2023 16:39:43 -0800 (PST)
MIME-Version: 1.0
References: <CABOYnLy_ufLD=BWDJct2chXMDYdZK=dNb4cnPYD5xo3WW1YCrw@mail.gmail.com>
 <CANn89iKpO35x-mFNgGA1axhn1hrq2HZBOFXo+wkTRPKxCQyQKA@mail.gmail.com> <CANn89iJ7h_LFSV6n_9WmbTMwTMsZ0UgdBj_oGrnzcrZu7oCxFw@mail.gmail.com>
In-Reply-To: <CANn89iJ7h_LFSV6n_9WmbTMwTMsZ0UgdBj_oGrnzcrZu7oCxFw@mail.gmail.com>
From:   xingwei lee <xrivendell7@gmail.com>
Date:   Fri, 1 Dec 2023 08:39:32 +0800
Message-ID: <CABOYnLzq7XwbFncos1p8FOnDyVes4VDkjWE277TngdJqSie14A@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
To:     Eric Dumazet <edumazet@google.com>
Cc:     syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com,
        davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to CC others, repeat mail.
Sorry, Dumazet. I found this bug with my modified syzkaller in my
local environment.
You are right, I crashed this bug about 10 times and used some
heuristic solutions to increase the chances of luck with modifying
syz-repro during this process.
I can confirm the reproduction can trigger the bug soon and I hope it helps=
 you.
I'll test your patch and give your feedback ASAP.

I apply your patch at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D3b47bc037bd44f142ac09848e8d3ecccc726be99
with a little fix:

diff --git a/net/core/sock.c b/net/core/sock.c
index fef349dd72fa..36d2871ac24f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2197,8 +2197,6 @@ static void __sk_destruct(struct rcu_head *head)

        if (likely(sk->sk_net_refcnt))
                put_net_track(sock_net(sk), &sk->ns_tracker);
-       else
-               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);

        sk_prot_free(sk->sk_prot_creator, sk);
 }
@@ -2212,6 +2210,9 @@ void sk_destruct(struct sock *sk)
                use_call_rcu =3D true;
        }

+       if (unlikely(!sk->sk_net_refcnt))
+               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);
+
        if (use_call_rcu)
                call_rcu(&sk->sk_rcu, __sk_destruct);
        else

and It's also trigger the crash like below:
root@syzkaller:~# ./a.out
[  114.072761][ T8229] chnl_net:caif_netlink_parms(): no params data found
[  114.326619][ T8230] chnl_net:caif_netlink_parms(): no params data found
[  114.340413][ T8231] chnl_net:caif_netlink_parms(): no params data found
[  114.351274][ T8229] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[  114.352623][ T8229] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[  114.353589][ T8229] bridge_slave_0: entered allmulticast mode
[  114.360175][ T8229] bridge_slave_0: entered promiscuous mode
[  114.362593][ T8232] chnl_net:caif_netlink_parms(): no params data found
[  114.367362][ T8229] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[  114.368464][ T8229] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[  114.369410][ T8229] bridge_slave_1: entered allmulticast mode
[  114.371429][ T8229] bridge_slave_1: entered promiscuous mode
[  114.510456][ T8229] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[  114.530922][ T8229] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[  114.683144][ T8231] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[  114.684040][ T8231] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[  114.684851][ T8231] bridge_slave_0: entered allmulticast mode
[  114.686531][ T8231] bridge_slave_0: entered promiscuous mode
[  114.694605][ T8230] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[  114.695945][ T8230] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[  114.696748][ T8230] bridge_slave_0: entered allmulticast mode
[  114.700798][ T8230] bridge_slave_0: entered promiscuous mode
[  114.705397][ T8229] team0: Port device team_slave_0 added
[  114.706511][ T8230] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[  114.707322][ T8230] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[  114.708736][ T8230] bridge_slave_1: entered allmulticast mode
[  114.710482][ T8230] bridge_slave_1: entered promiscuous mode
[  114.711909][ T8232] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[  114.713037][ T8232] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[  114.713871][ T8232] bridge_slave_0: entered allmulticast mode
[  114.715582][ T8232] bridge_slave_0: entered promiscuous mode
[  114.736327][ T8231] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[  114.737133][ T8231] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[  114.737924][ T8231] bridge_slave_1: entered allmulticast mode
[  114.740444][ T8231] bridge_slave_1: entered promiscuous mode
[  114.743350][ T8229] team0: Port device team_slave_1 added
[  114.761950][ T8232] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[  114.762774][ T8232] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[  114.763566][ T8232] bridge_slave_1: entered allmulticast mode
[  114.765230][ T8232] bridge_slave_1: entered promiscuous mode
[  114.788150][ T8230] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[  114.847766][ T8230] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[  114.892980][ T8231] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[  114.894626][ T8229] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[  114.895367][ T8229] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of b.
[  114.898001][ T8229] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[  114.946038][ T8231] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[  114.949398][ T8230] team0: Port device team_slave_0 added
[  114.950803][ T8229] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[  114.951699][ T8229] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of b.
[  114.954488][ T8229] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[  114.957273][ T8230] team0: Port device team_slave_1 added
[  114.964779][ T8232] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[  115.045328][ T8232] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[  115.048496][ T8231] team0: Port device team_slave_0 added
[  115.051434][ T8231] team0: Port device team_slave_1 added
[  115.069053][ T8230] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[  115.069772][ T8230] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of b.
[  115.072359][ T8230] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[  115.140116][ T8230] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[  115.140850][ T8230] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of b.
[  115.143422][ T8230] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[  115.173924][ T8231] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[  115.174643][ T8231] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of b.
[  115.177201][ T8231] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[  115.203430][ T8232] team0: Port device team_slave_0 added
[  115.209003][ T8229] hsr_slave_0: entered promiscuous mode
[  115.210517][ T8229] hsr_slave_1: entered promiscuous mode
[  115.212839][ T8231] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[  115.213564][ T8231] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of b.
[  115.216165][ T8231] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[  115.226076][ T8232] team0: Port device team_slave_1 added
[  115.275957][ T8232] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[  115.276680][ T8232] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of b.
[  115.279865][ T8232] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[  115.373684][ T8232] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[  115.374593][ T8232] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of b.
[  115.377603][ T8232] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[  115.395755][ T8230] hsr_slave_0: entered promiscuous mode
[  115.399850][ T8230] hsr_slave_1: entered promiscuous mode
[  115.401087][ T8230] debugfs: Directory 'hsr0' with parent 'hsr'
already present!
[  115.402250][ T8230] Cannot create hsr debugfs directory
[  115.407395][ T8231] hsr_slave_0: entered promiscuous mode
[  115.409607][ T8231] hsr_slave_1: entered promiscuous mode
[  115.410872][ T8231] debugfs: Directory 'hsr0' with parent 'hsr'
already present!
[  115.411646][ T8231] Cannot create hsr debugfs directory
[  115.501202][ T8232] hsr_slave_0: entered promiscuous mode
[  115.502669][ T8232] hsr_slave_1: entered promiscuous mode
[  115.503788][ T8232] debugfs: Directory 'hsr0' with parent 'hsr'
already present!
[  115.504564][ T8232] Cannot create hsr debugfs directory
[  115.938476][ T8229] netdevsim netdevsim3 netdevsim0: renamed from eth0
[  115.946200][ T8229] netdevsim netdevsim3 netdevsim1: renamed from eth1
[  115.950819][ T8229] netdevsim netdevsim3 netdevsim2: renamed from eth2
[  115.954893][ T8229] netdevsim netdevsim3 netdevsim3: renamed from eth3
[  116.003434][ T8231] netdevsim netdevsim1 netdevsim0: renamed from eth0
[  116.041993][ T8231] netdevsim netdevsim1 netdevsim1: renamed from eth1
[  116.045749][ T8231] netdevsim netdevsim1 netdevsim2: renamed from eth2
[  116.067822][ T8231] netdevsim netdevsim1 netdevsim3: renamed from eth3
[  116.092189][ T8230] netdevsim netdevsim2 netdevsim0: renamed from eth0
[  116.097375][ T8230] netdevsim netdevsim2 netdevsim1: renamed from eth1
[  116.105152][ T8230] netdevsim netdevsim2 netdevsim2: renamed from eth2
[  116.117443][ T8230] netdevsim netdevsim2 netdevsim3: renamed from eth3
[  116.166762][ T8232] netdevsim netdevsim0 netdevsim0: renamed from eth0
[  116.171211][ T8232] netdevsim netdevsim0 netdevsim1: renamed from eth1
[  116.174915][ T8232] netdevsim netdevsim0 netdevsim2: renamed from eth2
[  116.179722][ T8232] netdevsim netdevsim0 netdevsim3: renamed from eth3
[  116.304475][ T8229] 8021q: adding VLAN 0 to HW filter on device bond0
[  116.330276][ T8231] 8021q: adding VLAN 0 to HW filter on device bond0
[  116.352903][ T8229] 8021q: adding VLAN 0 to HW filter on device team0
[  116.361652][ T8230] 8021q: adding VLAN 0 to HW filter on device bond0
[  116.368463][ T8231] 8021q: adding VLAN 0 to HW filter on device team0
[  116.389882][  T791] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[  116.390859][  T791] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[  116.393500][  T791] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[  116.394306][  T791] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[  116.400271][ T8230] 8021q: adding VLAN 0 to HW filter on device team0
[  116.413712][   T23] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[  116.414726][   T23] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[  116.416940][   T23] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[  116.417923][   T23] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[  116.455333][T10414] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[  116.456169][T10414] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[  116.469603][ T4567] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[  116.470452][ T4567] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[  116.545064][ T8232] 8021q: adding VLAN 0 to HW filter on device bond0
[  116.585505][ T8232] 8021q: adding VLAN 0 to HW filter on device team0
[  116.604097][  T794] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[  116.604923][  T794] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[  116.607359][  T794] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[  116.608223][  T794] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[  116.625942][ T8229] 8021q: adding VLAN 0 to HW filter on device batadv0
[  116.628671][ T8230] 8021q: adding VLAN 0 to HW filter on device batadv0
[  116.640122][ T8231] 8021q: adding VLAN 0 to HW filter on device batadv0
[  116.705689][ T8231] veth0_vlan: entered promiscuous mode
[  116.732445][ T8229] veth0_vlan: entered promiscuous mode
[  116.750680][ T8230] veth0_vlan: entered promiscuous mode
[  116.754121][ T8229] veth1_vlan: entered promiscuous mode
[  116.767472][ T8232] 8021q: adding VLAN 0 to HW filter on device batadv0
[  116.769106][ T8231] veth1_vlan: entered promiscuous mode
[  116.777934][ T8230] veth1_vlan: entered promiscuous mode
[  116.800068][ T8229] veth0_macvtap: entered promiscuous mode
[  116.806955][ T8229] veth1_macvtap: entered promiscuous mode
[  116.836114][ T8231] veth0_macvtap: entered promiscuous mode
[  116.853502][ T8229] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[  116.863525][ T8231] veth1_macvtap: entered promiscuous mode
[  116.869518][ T8232] veth0_vlan: entered promiscuous mode
[  116.871213][ T8230] veth0_macvtap: entered promiscuous mode
[  116.875893][ T8230] veth1_macvtap: entered promiscuous mode
[  116.879203][ T8231] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3d) already exists on: batadv_slave_0
[  116.880567][ T8231] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[  116.882667][ T8231] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[  116.896729][ T8229] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[  116.904540][ T8229] netdevsim netdevsim3 netdevsim0: set [1, 0]
type 2 family 0 port 6081 - 0
[  116.905714][ T8229] netdevsim netdevsim3 netdevsim1: set [1, 0]
type 2 family 0 port 6081 - 0
[  116.906606][ T8229] netdevsim netdevsim3 netdevsim2: set [1, 0]
type 2 family 0 port 6081 - 0
[  116.907497][ T8229] netdevsim netdevsim3 netdevsim3: set [1, 0]
type 2 family 0 port 6081 - 0
[  116.912478][ T8231] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_1
[  116.913556][ T8231] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[  116.915575][ T8231] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[  116.930500][ T8230] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3d) already exists on: batadv_slave_0
[  116.931588][ T8230] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[  116.932581][ T8230] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3d) already exists on: batadv_slave_0
[  116.933835][ T8230] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[  116.935827][ T8230] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[  116.947967][ T8232] veth1_vlan: entered promiscuous mode
[  116.959390][ T8230] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_1
[  116.960514][ T8230] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[  116.961524][ T8230] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_1
[  116.962805][ T8230] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[  116.965336][ T8230] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[  116.972417][ T8230] netdevsim netdevsim2 netdevsim0: set [1, 0]
type 2 family 0 port 6081 - 0
[  116.973541][ T8230] netdevsim netdevsim2 netdevsim1: set [1, 0]
type 2 family 0 port 6081 - 0
[  116.974592][ T8230] netdevsim netdevsim2 netdevsim2: set [1, 0]
type 2 family 0 port 6081 - 0
[  116.975688][ T8230] netdevsim netdevsim2 netdevsim3: set [1, 0]
type 2 family 0 port 6081 - 0
[  116.982689][ T8231] netdevsim netdevsim1 netdevsim0: set [1, 0]
type 2 family 0 port 6081 - 0
[  116.983846][ T8231] netdevsim netdevsim1 netdevsim1: set [1, 0]
type 2 family 0 port 6081 - 0
[  116.984740][ T8231] netdevsim netdevsim1 netdevsim2: set [1, 0]
type 2 family 0 port 6081 - 0
[  116.985636][ T8231] netdevsim netdevsim1 netdevsim3: set [1, 0]
type 2 family 0 port 6081 - 0
[  117.052763][ T8232] veth0_macvtap: entered promiscuous mode
[  117.125330][ T8232] veth1_macvtap: entered promiscuous mode
[  117.161855][ T8232] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3d) already exists on: batadv_slave_0
[  117.162926][ T8232] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[  117.163915][ T8232] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3d) already exists on: batadv_slave_0
[  117.164958][ T8232] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[  117.165942][ T8232] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3d) already exists on: batadv_slave_0
[  117.167184][ T8232] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[  117.171068][ T8232] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[  117.177910][ T8232] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_1
[  117.179152][ T8232] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[  117.180147][ T8232] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_1
[  117.181173][ T8232] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[  117.182155][ T8232] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_1
[  117.183208][ T8232] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[  117.185430][ T8232] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[  117.190533][ T8232] netdevsim netdevsim0 netdevsim0: set [1, 0]
type 2 family 0 port 6081 - 0
[  117.191440][ T8232] netdevsim netdevsim0 netdevsim1: set [1, 0]
type 2 family 0 port 6081 - 0
[  117.192319][ T8232] netdevsim netdevsim0 netdevsim2: set [1, 0]
type 2 family 0 port 6081 - 0
[  117.193220][ T8232] netdevsim netdevsim0 netdevsim3: set [1, 0]
type 2 family 0 port 6081 - 0
[  119.795002][   T11] netdevsim netdevsim3 netdevsim3
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  119.804616][ T4551] systemd-journald[4551]: Sent WATCHDOG=3D1 notificati=
on.
[  122.341744][   T11] netdevsim netdevsim3 netdevsim2
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  122.450843][   T11] netdevsim netdevsim3 netdevsim1
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  122.504275][   T11] netdevsim netdevsim3 netdevsim0
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  123.467548][   T11] hsr_slave_0: left promiscuous mode
[  123.485539][   T11] hsr_slave_1: left promiscuous mode
[  123.487868][   T11] batman_adv: batadv0: Interface deactivated:
batadv_slave_0
[  123.491528][   T11] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[  123.495447][   T11] batman_adv: batadv0: Interface deactivated:
batadv_slave_1
[  123.496813][   T11] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[  123.499352][   T11] bridge_slave_1: left allmulticast mode
[  123.500320][   T11] bridge_slave_1: left promiscuous mode
[  123.502166][   T11] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[  123.507565][   T11] bridge_slave_0: left allmulticast mode
[  123.510266][   T11] bridge_slave_0: left promiscuous mode
[  123.511428][   T11] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[  123.521008][   T11] veth1_macvtap: left promiscuous mode
[  123.522171][   T11] veth0_macvtap: left promiscuous mode
[  123.523307][   T11] veth1_vlan: left promiscuous mode
[  123.524665][   T11] veth0_vlan: left promiscuous mode
[  123.762113][   T11] team0 (unregistering): Port device team_slave_1 remo=
ved
[  123.774449][   T11] team0 (unregistering): Port device team_slave_0 remo=
ved
[  123.779911][   T11] bond0 (unregistering): (slave bond_slave_1):
Releasing backup interface
[  123.786093][   T11] bond0 (unregistering): (slave bond_slave_0):
Releasing backup interface
[  123.864081][   T11] bond0 (unregistering): Released all slaves
[  124.886124][   T11] netdevsim netdevsim2 netdevsim3
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  125.002021][   T11] netdevsim netdevsim2 netdevsim2
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  125.080483][   T11] netdevsim netdevsim2 netdevsim1
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  125.123863][   T11] netdevsim netdevsim2 netdevsim0
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  125.278920][   T11] netdevsim netdevsim0 netdevsim3
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  125.343364][   T11] netdevsim netdevsim0 netdevsim2
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  125.432573][   T11] netdevsim netdevsim0 netdevsim1
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  125.524907][   T11] netdevsim netdevsim0 netdevsim0
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  125.638921][   T11] netdevsim netdevsim1 netdevsim3
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  125.708761][   T11] netdevsim netdevsim1 netdevsim2
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  125.843861][   T11] netdevsim netdevsim1 netdevsim1
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  125.902843][   T11] netdevsim netdevsim1 netdevsim0
(unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[  127.305317][   T11] hsr_slave_0: left promiscuous mode
[  127.307575][   T11] hsr_slave_1: left promiscuous mode
[  127.310229][   T11] batman_adv: batadv0: Interface deactivated:
batadv_slave_0
[  127.311917][   T11] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[  127.315522][   T11] batman_adv: batadv0: Interface deactivated:
batadv_slave_1
[  127.317504][   T11] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[  127.321068][   T11] bridge_slave_1: left allmulticast mode
[  127.322481][   T11] bridge_slave_1: left promiscuous mode
[  127.324051][   T11] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[  127.329783][   T11] bridge_slave_0: left allmulticast mode
[  127.331132][   T11] bridge_slave_0: left promiscuous mode
[  127.332593][   T11] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[  127.349619][   T11] hsr_slave_0: left promiscuous mode
[  127.351993][   T11] hsr_slave_1: left promiscuous mode
[  127.354448][   T11] batman_adv: batadv0: Interface deactivated:
batadv_slave_0
[  127.356190][   T11] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[  127.359889][   T11] batman_adv: batadv0: Interface deactivated:
batadv_slave_1
[  127.361631][   T11] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[  127.364894][   T11] bridge_slave_1: left allmulticast mode
[  127.366304][   T11] bridge_slave_1: left promiscuous mode
[  127.367795][   T11] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[  127.374317][   T11] bridge_slave_0: left allmulticast mode
[  127.375638][   T11] bridge_slave_0: left promiscuous mode
[  127.377139][   T11] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[  127.389196][   T11] hsr_slave_0: left promiscuous mode
[  127.391219][   T11] hsr_slave_1: left promiscuous mode
[  127.393432][   T11] batman_adv: batadv0: Interface deactivated:
batadv_slave_0
[  127.395198][   T11] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[  127.399196][   T11] batman_adv: batadv0: Interface deactivated:
batadv_slave_1
[  127.400831][   T11] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[  127.404132][   T11] bridge_slave_1: left allmulticast mode
[  127.405385][   T11] bridge_slave_1: left promiscuous mode
[  127.406979][   T11] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[  127.411057][   T11] bridge_slave_0: left allmulticast mode
[  127.412025][   T11] bridge_slave_0: left promiscuous mode
[  127.413135][   T11] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[  127.423598][   T11] veth1_macvtap: left promiscuous mode
[  127.424211][   T11] veth0_macvtap: left promiscuous mode
[  127.425254][   T11] veth1_vlan: left promiscuous mode
[  127.425850][   T11] veth0_vlan: left promiscuous mode
[  127.427781][   T11] veth1_macvtap: left promiscuous mode
[  127.428744][   T11] veth0_macvtap: left promiscuous mode
[  127.429592][   T11] veth1_vlan: left promiscuous mode
[  127.430202][   T11] veth0_vlan: left promiscuous mode
[  127.431961][   T11] veth1_macvtap: left promiscuous mode
[  127.432549][   T11] veth0_macvtap: left promiscuous mode
[  127.433382][   T11] veth1_vlan: left promiscuous mode
[  127.434000][   T11] veth0_vlan: left promiscuous mode
[  127.828054][   T11] team0 (unregistering): Port device team_slave_1 remo=
ved
[  127.841985][   T11] team0 (unregistering): Port device team_slave_0 remo=
ved
[  127.852461][   T11] bond0 (unregistering): (slave bond_slave_1):
Releasing backup interface
[  127.863168][   T11] bond0 (unregistering): (slave bond_slave_0):
Releasing backup interface
[  127.916740][   T11] bond0 (unregistering): Released all slaves
[  128.114888][   T11] team0 (unregistering): Port device team_slave_1 remo=
ved
[  128.123304][   T11] team0 (unregistering): Port device team_slave_0 remo=
ved
[  128.138250][   T11] bond0 (unregistering): (slave bond_slave_1):
Releasing backup interface
[  128.150962][   T11] bond0 (unregistering): (slave bond_slave_0):
Releasing backup interface
[  128.220915][   T11] bond0 (unregistering): Released all slaves
[  128.387330][   T11] team0 (unregistering): Port device team_slave_1 remo=
ved
[  128.393487][   T11] team0 (unregistering): Port device team_slave_0 remo=
ved
[  128.400283][   T11] bond0 (unregistering): (slave bond_slave_1):
Releasing backup interface
[  128.405893][   T11] bond0 (unregistering): (slave bond_slave_0):
Releasing backup interface
[  128.474976][   T11] bond0 (unregistering): Released all slaves
[  129.921396][   T11] ref_tracker: net notrefcnt@ffff8880245d9fe0 has
1/1 users at
[  129.921396][   T11]      sk_alloc+0xa8d/0xb90
[  129.921396][   T11]      inet6_create+0x380/0x1290
[  129.921396][   T11]      __sock_create+0x328/0x800
[  129.921396][   T11]      rds_tcp_listen_init+0xd3/0x4e0
[  129.921396][   T11]      rds_tcp_init_net+0x13a/0x3e0
[  129.921396][   T11]      ops_init+0xb9/0x650
[  129.921396][   T11]      setup_net+0x422/0xa40
[  129.921396][   T11]      copy_net_ns+0x2fa/0x660
[  129.921396][   T11]      create_new_namespaces+0x3ea/0xb10
[  129.921396][   T11]      unshare_nsproxy_namespaces+0xc1/0x1f0
[  129.921396][   T11]      ksys_unshare+0x3f5/0x9c0
[  129.921396][   T11]      __x64_sys_unshare+0x31/0x40
[  129.921396][   T11]      do_syscall_64+0x41/0x110
[  129.921396][   T11]      entry_SYSCALL_64_after_hwframe+0x63/0x6b
[  129.921396][   T11]
[  129.934511][ T4551] systemd-journald[4551]: Compressed data object
529 -> 323 using ZSTD
[  129.934699][   T11] ------------[ cut here ]------------
[  129.936294][   T11] WARNING: CPU: 1 PID: 11 at
lib/ref_tracker.c:179 ref_tracker_dir_exit+0x3e3/0x680
[  129.937749][   T11] Modules linked in:
[  129.938708][   T11] CPU: 1 PID: 11 Comm: kworker/u8:0 Not tainted
6.7.0-rc3-00033-g3b47bc037bd4-dirty #4
[  129.939985][   T11] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-1.fc38 04/01/2014
[  129.941180][   T11] Workqueue: netns cleanup_net
[  129.941807][   T11] RIP: 0010:ref_tracker_dir_exit+0x3e3/0x680
[  129.942750][   T11] Code: 0d 02 00 00 4d 39 f5 49 8b 06 4d 89 f7 0f
85 0e ff ff ff 48 8b 2c 24 e8 2b c1 f6 fc 48 8b 74 24 18 4
[  129.945143][   T11] RSP: 0018:ffffc90000107b78 EFLAGS: 00010286
[  129.945925][   T11] RAX: 0000000080000000 RBX: dffffc0000000000
RCX: 0000000000000000
[  129.947126][   T11] RDX: 0000000000000001 RSI: ffffffff8accbc20
RDI: 0000000000000001
[  129.948142][   T11] RBP: ffff8880245d9fe0 R08: 0000000000000001
R09: fffffbfff24241e9
[  129.949154][   T11] R10: ffffffff92120f4f R11: 0000000000000003
R12: ffff8880245da030
[  129.950129][   T11] R13: ffff8880245da030 R14: ffff8880245da030
R15: ffff8880245da030
[  129.951127][   T11] FS:  0000000000000000(0000)
GS:ffff88823bc00000(0000) knlGS:0000000000000000
[  129.952236][   T11] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  129.953009][   T11] CR2: 000056418e092340 CR3: 000000000cf77000
CR4: 0000000000750ef0
[  129.953803][   T11] PKRU: 55555554
[  129.954177][   T11] Call Trace:
[  129.954519][   T11]  <TASK>
[  129.954832][   T11]  ? show_regs+0x8f/0xa0
[  129.955459][   T11]  ? __warn+0xe6/0x390
[  129.955889][   T11]  ? ref_tracker_dir_exit+0x3e3/0x680
[  129.956437][   T11]  ? report_bug+0x3b9/0x580
[  129.956924][   T11]  ? handle_bug+0x67/0x90
[  129.957371][   T11]  ? exc_invalid_op+0x17/0x40
[  129.957856][   T11]  ? asm_exc_invalid_op+0x1a/0x20
[  129.958589][   T11]  ? ref_tracker_dir_exit+0x3e3/0x680
[  129.959146][   T11]  ? ref_tracker_dir_exit+0x3e2/0x680
[  129.959797][   T11]  ? ref_tracker_dir_snprint+0xd0/0xd0
[  129.960358][   T11]  ? __kmem_cache_free+0xc0/0x180
[  129.960879][   T11]  cleanup_net+0x8d4/0xb20
[  129.961437][   T11]  ? unregister_pernet_device+0x80/0x80
[  129.962015][   T11]  process_one_work+0x886/0x15d0
[  129.962535][   T11]  ? unregister_pernet_device+0x80/0x80
[  129.963102][   T11]  ? workqueue_congested+0x300/0x300
[  129.963706][   T11]  ? assign_work+0x19c/0x240
[  129.964185][   T11]  worker_thread+0x8b9/0x1290
[  129.964681][   T11]  ? process_one_work+0x15d0/0x15d0
[  129.965216][   T11]  kthread+0x2c6/0x3a0
[  129.965643][   T11]  ? _raw_spin_unlock_irq+0x23/0x50
[  129.966183][   T11]  ? kthread_complete_and_exit+0x40/0x40
[  129.966780][   T11]  ret_from_fork+0x45/0x80
[  129.967239][   T11]  ? kthread_complete_and_exit+0x40/0x40
[  129.967811][   T11]  ret_from_fork_asm+0x11/0x20
[  129.968539][   T11]  </TASK>
[  129.968865][   T11] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[  129.969594][   T11] CPU: 1 PID: 11 Comm: kworker/u8:0 Not tainted
6.7.0-rc3-00033-g3b47bc037bd4-dirty #4
[  129.970564][   T11] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-1.fc38 04/01/2014
[  129.971705][   T11] Workqueue: netns cleanup_net
[  129.972355][   T11] Call Trace:
[  129.972699][   T11]  <TASK>
[  129.973000][   T11]  dump_stack_lvl+0xd3/0x1b0
[  129.973481][   T11]  panic+0x6dc/0x790
[  129.973894][   T11]  ? panic_smp_self_stop+0xa0/0xa0
[  129.974464][   T11]  ? show_trace_log_lvl+0x363/0x4f0
[  129.975156][   T11]  ? check_panic_on_warn+0x1f/0xb0
[  129.975953][   T11]  ? ref_tracker_dir_exit+0x3e3/0x680
[  129.976587][   T11]  check_panic_on_warn+0xab/0xb0
[  129.977215][   T11]  __warn+0xf2/0x390
[  129.977858][   T11]  ? ref_tracker_dir_exit+0x3e3/0x680
[  129.978453][   T11]  report_bug+0x3b9/0x580
[  129.978978][   T11]  handle_bug+0x67/0x90
[  129.979605][   T11]  exc_invalid_op+0x17/0x40
[  129.980166][   T11]  asm_exc_invalid_op+0x1a/0x20
[  129.980774][   T11] RIP: 0010:ref_tracker_dir_exit+0x3e3/0x680
[  129.981516][   T11] Code: 0d 02 00 00 4d 39 f5 49 8b 06 4d 89 f7 0f
85 0e ff ff ff 48 8b 2c 24 e8 2b c1 f6 fc 48 8b 74 24 18 4
[  129.983639][   T11] RSP: 0018:ffffc90000107b78 EFLAGS: 00010286
[  129.984314][   T11] RAX: 0000000080000000 RBX: dffffc0000000000
RCX: 0000000000000000
[  129.985461][   T11] RDX: 0000000000000001 RSI: ffffffff8accbc20
RDI: 0000000000000001
[  129.986696][   T11] RBP: ffff8880245d9fe0 R08: 0000000000000001
R09: fffffbfff24241e9
[  129.987706][   T11] R10: ffffffff92120f4f R11: 0000000000000003
R12: ffff8880245da030
[  129.988714][   T11] R13: ffff8880245da030 R14: ffff8880245da030
R15: ffff8880245da030
[  129.989901][   T11]  ? ref_tracker_dir_exit+0x3e2/0x680
[  129.990759][   T11]  ? ref_tracker_dir_snprint+0xd0/0xd0
[  129.991536][   T11]  ? __kmem_cache_free+0xc0/0x180
[  129.992132][   T11]  cleanup_net+0x8d4/0xb20
[  129.992693][   T11]  ? unregister_pernet_device+0x80/0x80
[  129.993368][   T11]  process_one_work+0x886/0x15d0
[  129.994278][   T11]  ? unregister_pernet_device+0x80/0x80
[  129.994897][   T11]  ? workqueue_congested+0x300/0x300
[  129.995533][   T11]  ? assign_work+0x19c/0x240
[  129.996118][   T11]  worker_thread+0x8b9/0x1290
[  129.996913][   T11]  ? process_one_work+0x15d0/0x15d0
[  129.997521][   T11]  kthread+0x2c6/0x3a0
[  129.997989][   T11]  ? _raw_spin_unlock_irq+0x23/0x50
[  129.998664][   T11]  ? kthread_complete_and_exit+0x40/0x40
[  129.999378][   T11]  ret_from_fork+0x45/0x80
[  129.999981][   T11]  ? kthread_complete_and_exit+0x40/0x40
[  130.000580][   T11]  ret_from_fork_asm+0x11/0x20
[  130.001142][   T11]  </TASK>
[  130.001751][   T11] Kernel Offset: disabled
[  130.002231][   T11] Rebooting in 86400 seconds..

I am willing to help you and tell me what commit or branch should I
test for your patch.
Thanks.

Eric Dumazet <edumazet@google.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8830=E6=
=97=A5=E5=91=A8=E5=9B=9B 17:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 30, 2023 at 9:46=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Nov 30, 2023 at 9:42=E2=80=AFAM xingwei lee <xrivendell7@gmail.=
com> wrote:
> > >
> > > Hello
> > > I reproduced this bug with repro.txt and repro.c
> > >
> > >
> >
> >
> > Is your syzbot instance ready to accept patches for testing ?
> >
> > Otherwise, a repro which happens to  work 'by luck' might not work for =
me.
> >
> > The bug here is a race condition with rds subsystem being dismantled
> > at netns dismantle, the 'repro' could be anything really.
>
> Can you test the following patch ?
> Thanks.
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index fef349dd72fa735b5915fc03e29cbb155b2aff2c..36d2871ac24f383e4e5d1af11=
68000f076011aae
> 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2197,8 +2197,6 @@ static void __sk_destruct(struct rcu_head *head)
>
>         if (likely(sk->sk_net_refcnt))
>                 put_net_track(sock_net(sk), &sk->ns_tracker);
> -       else
> -               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, false=
);
>
>         sk_prot_free(sk->sk_prot_creator, sk);
>  }
> @@ -2212,6 +2210,9 @@ void sk_destruct(struct sock *sk)
>                 use_call_rcu =3D true;
>         }
>
> +       if (unlikely(!sk->sk_net_refcnt))
> +               __netns_tracker_free(sock_net(sk), &sk->ns_tracker, false=
);
> +
>         if (use_call_rcu)
>                 call_rcu(&sk->sk_rcu, __sk_destruct);
>         else
