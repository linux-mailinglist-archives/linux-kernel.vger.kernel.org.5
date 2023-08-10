Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B711777A28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjHJOKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjHJOKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:10:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B001B4;
        Thu, 10 Aug 2023 07:10:20 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc0d39b52cso6832125ad.2;
        Thu, 10 Aug 2023 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691676620; x=1692281420;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ju/yta5GeO8EOaUrANgQEIymTdD2gePBP9cyUkb8XU=;
        b=qdtirndf3XPqqHFKx2zxD5Eb69RzoH7/97dE6AFVvgF0APX8a6Zk+xKKoK7ynEjZh8
         3ObdkgNB9HRsJxOKNbjyhmJwz9awoWhq+MGRfC+LeU3bXcZBaNE5OFBmnSwI28lGNFG/
         EDaIgQOfCmEAGAc0r0v5ModJ7W0BVAijgnQjaVMComzXiOepGAU1g1gzGg/wLkJsKBJ1
         ecSzW0zg4/MD798E4LLjw8ZX6KDyQUkuv5vyktmn+EtGW1mbP8mZ6qsL0Ri7NCklU+A/
         v/0uxjOcJ0tUT/34AVruM/4k6NxCJdqyzwRKbXuSimuWddf6mC8P9Lr0mAmirEJF1i2h
         q6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691676620; x=1692281420;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4ju/yta5GeO8EOaUrANgQEIymTdD2gePBP9cyUkb8XU=;
        b=A1L/nRKqBnPLP+lNRmR7ldGc5dowFYWxDnnGOPzqQodL4LlvTk6RbsxkSftUF/SQ+2
         WNa80FNjIt88bgiaPBybyjVafqtFYOw0iIvJQKT+fF6XjliZSMKjr/pgPG+9gHkfxeTy
         WA5zp+AMMTYmYFcZRlz909KavdwAx9xaFBo45ff2ae5MdmIRsAoD1UasDaGfS2IA/xsS
         +Gj8VtT0CE+SoQ3y1pvhcXhIYts/uPM4C8ex0E7JhxU8jzrZjKjYfR7ZxQYcKRY0BqpX
         UHrWBuAtRbh6HEMK/wfZr8Ai8gWoIi0KtvSAC5JcAi9H0jVeTvxeC6qmeEM93ALHCzs2
         ttqA==
X-Gm-Message-State: AOJu0YxGOjVvnKNfYVbKTu2XiwrdsRlT5oTka90QxVc8z9D1LuHVGnsy
        Bs7Cc1M0FnNr3gxZmgcisenkGrs/3As=
X-Google-Smtp-Source: AGHT+IENR8z6jonizzO/Be7BUUKZ5/4oWHZ960K1QQA3p3uCpKgWi5cSKc+np0SOc0Z1nHBoz7dzKA==
X-Received: by 2002:a17:902:db03:b0:1b8:1687:b53 with SMTP id m3-20020a170902db0300b001b816870b53mr2797892plx.26.1691676619328;
        Thu, 10 Aug 2023 07:10:19 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902788900b001bc6536051bsm1791127pll.184.2023.08.10.07.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 07:10:19 -0700 (PDT)
Message-ID: <dd576088-2d95-4ab4-30a3-a9a132d7a9fa@gmail.com>
Date:   Thu, 10 Aug 2023 21:10:11 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Chieh-Min Wang <chiehminw@synology.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        LimeTech <tomm@lime-technology.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Netfilter <netfilter-devel@vger.kernel.org>,
        Netfilter Core Team <coreteam@netfilter.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: kernel: WARNING: CPU: 0 PID: 16269 at
 net/netfilter/nf_conntrack_core.c:1210
Content-Type: text/plain; charset=UTF-8
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

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> This call trace occurs consistently when using the docker macvlan drive=
r where the bridge's parent is a Linux bridge.
>=20
> Below is the typical configuration of br0 and docker macvlan
>=20
> # commands to configure eth0 / br0 (br0 uses dhcp to obtain IP address)=

> ip link add name br0 type bridge stp_state 0 forward_delay 0 nf_call_ip=
tables 1 nf_call_ip6tables 1 nf_call_arptables 1
> ip link set br0 up
> ip link set eth0 down
> ip -4 addr flush dev eth0
> ip -6 addr flush dev eth0
> ip link set eth0 promisc on master br0 up
>=20
> # command to configure docker macvlan network on br0
> docker network create -d macvlan --subnet=3D10.0.101.0/24 --gateway=3D1=
0.0.101.1 --aux-address=3Dserver=3D10.0.101.13 -o parent=3Dbr0 br0
>=20
> We are currently running 6.1.43 kernel but this issue has been happenin=
g with all previous kernels for a least a couple of years now.  For examp=
le:
> https://www.spinics.net/lists/netfilter/msg59040.html
>=20
> Also syzbot detected this same issue in 6.5.0-rc2
> https://www.spinics.net/lists/netfilter-devel/msg81831.html
>=20
> Finally we also tried creating a vhost interface attached to br0 and th=
en set that as the docker macvlan "parent" - same result.
>=20
>=20
> Aug  8 10:06:51 ODROID kernel: ------------[ cut here ]------------
> Aug  8 10:06:51 ODROID kernel: WARNING: CPU: 0 PID: 16269 at net/netfil=
ter/nf_conntrack_core.c:1210 __nf_conntrack_confirm+0xa4/0x2b0 [nf_conntr=
ack]
> Aug  8 10:06:51 ODROID kernel: Modules linked in: xt_CHECKSUM ipt_REJEC=
T nf_reject_ipv4 ip6table_mangle ip6table_nat iptable_mangle vhost_net tu=
n vhost vhost_iotlb tap xt_nat xt_tcpudp veth xt_conntrack nf_conntrack_n=
etlink nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter xfs cmac ci=
fs asn1_decoder cifs_arc4 cifs_md4 oid_registry dns_resolver md_mod zfs(P=
O) zunicode(PO) zzstd(O) zlua(O) zavl(PO) icp(PO) zcommon(PO) znvpair(PO)=
 spl(O) tcp_diag inet_diag emc2103 iptable_nat xt_MASQUERADE nf_nat nf_co=
nntrack nf_defrag_ipv6 nf_defrag_ipv4 wireguard curve25519_x86_64 libcurv=
e25519_generic libchacha20poly1305 chacha_x86_64 poly1305_x86_64 ip6_udp_=
tunnel udp_tunnel libchacha ip6table_filter ip6_tables iptable_filter ip_=
tables x_tables efivarfs af_packet 8021q garp mrp macvlan bridge stp llc =
bonding tls r8125(O) intel_rapl_msr intel_rapl_common x86_pkg_temp_therma=
l intel_powerclamp coretemp kvm_intel i915 kvm crct10dif_pclmul crc32_pcl=
mul crc32c_intel ghash_clmulni_intel sha512_ssse3 iosf_mbi drm_buddy
> Aug  8 10:06:51 ODROID kernel: aesni_intel i2c_algo_bit ttm drm_display=
_helper crypto_simd drm_kms_helper cryptd mei_hdcp mei_pxp nvme rapl i2c_=
i801 sr_mod input_leds intel_cstate drm i2c_smbus cdrom nvme_core joydev =
led_class video wmi intel_gtt ahci agpgart backlight libahci mei_me intel=
_pmc_core i2c_core syscopyarea sysfillrect mei sysimgblt fb_sys_fops ther=
mal fan button unix [last unloaded: r8125(O)]
> Aug  8 10:06:51 ODROID kernel: CPU: 0 PID: 16269 Comm: kworker/u8:0 Tai=
nted: P           O       6.1.43-Unraid #2
> Aug  8 10:06:51 ODROID kernel: Hardware name: HARDKERNEL ODROID-H2/ODRO=
ID-H2, BIOS 5.13 04/27/2020
> Aug  8 10:06:51 ODROID kernel: Workqueue: events_unbound macvlan_proces=
s_broadcast [macvlan]
> Aug  8 10:06:51 ODROID kernel: RIP: 0010:__nf_conntrack_confirm+0xa4/0x=
2b0 [nf_conntrack]
> Aug  8 10:06:51 ODROID kernel: Code: 44 24 10 e8 e2 e1 ff ff 8b 7c 24 0=
4 89 ea 89 c6 89 04 24 e8 7e e6 ff ff 84 c0 75 a2 48 89 df e8 9b e2 ff ff=
 85 c0 89 c5 74 18 <0f> 0b 8b 34 24 8b 7c 24 04 e8 18 dd ff ff e8 93 e3 f=
f ff e9 72 01
> Aug  8 10:06:51 ODROID kernel: RSP: 0018:ffffc90000003d98 EFLAGS: 00010=
202
> Aug  8 10:06:51 ODROID kernel: RAX: 0000000000000001 RBX: ffff88814a7ac=
400 RCX: 9c0c70d57470940d
> Aug  8 10:06:51 ODROID kernel: RDX: 0000000000000000 RSI: 0000000000000=
001 RDI: ffff88814a7ac400
> Aug  8 10:06:51 ODROID kernel: RBP: 0000000000000001 R08: 2fcce5ef4761f=
5d5 R09: 28e40e9ae48c7a5f
> Aug  8 10:06:51 ODROID kernel: R10: f5516b05dfc149e9 R11: ffffc90000003=
d60 R12: ffffffff82a11d00
> Aug  8 10:06:51 ODROID kernel: R13: 0000000000011231 R14: ffff88814c989=
d00 R15: 0000000000000000
> Aug  8 10:06:51 ODROID kernel: FS:  0000000000000000(0000) GS:ffff88846=
fc00000(0000) knlGS:0000000000000000
> Aug  8 10:06:51 ODROID kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
> Aug  8 10:06:51 ODROID kernel: CR2: 0000000000537d30 CR3: 000000018567a=
000 CR4: 0000000000350ef0
> Aug  8 10:06:51 ODROID kernel: Call Trace:
> Aug  8 10:06:51 ODROID kernel: <IRQ>
> Aug  8 10:06:51 ODROID kernel: ? __warn+0xab/0x122
> Aug  8 10:06:51 ODROID kernel: ? report_bug+0x109/0x17e
> Aug  8 10:06:51 ODROID kernel: ? __nf_conntrack_confirm+0xa4/0x2b0 [nf_=
conntrack]
> Aug  8 10:06:51 ODROID kernel: ? handle_bug+0x41/0x6f
> Aug  8 10:06:51 ODROID kernel: ? exc_invalid_op+0x13/0x60
> Aug  8 10:06:51 ODROID kernel: ? asm_exc_invalid_op+0x16/0x20
> Aug  8 10:06:51 ODROID kernel: ? __nf_conntrack_confirm+0xa4/0x2b0 [nf_=
conntrack]
> Aug  8 10:06:51 ODROID kernel: ? __nf_conntrack_confirm+0x9e/0x2b0 [nf_=
conntrack]
> Aug  8 10:06:51 ODROID kernel: ? nf_nat_inet_fn+0x60/0x1a8 [nf_nat]
> Aug  8 10:06:51 ODROID kernel: nf_conntrack_confirm+0x25/0x54 [nf_connt=
rack]
> Aug  8 10:06:51 ODROID kernel: nf_hook_slow+0x3a/0x96
> Aug  8 10:06:51 ODROID kernel: ? ip_protocol_deliver_rcu+0x164/0x164
> Aug  8 10:06:51 ODROID kernel: NF_HOOK.constprop.0+0x79/0xd9
> Aug  8 10:06:51 ODROID kernel: ? ip_protocol_deliver_rcu+0x164/0x164
> Aug  8 10:06:51 ODROID kernel: __netif_receive_skb_one_core+0x77/0x9c
> Aug  8 10:06:51 ODROID kernel: process_backlog+0x8c/0x116
> Aug  8 10:06:51 ODROID kernel: __napi_poll.constprop.0+0x28/0x124
> Aug  8 10:06:51 ODROID kernel: net_rx_action+0x159/0x24f
> Aug  8 10:06:51 ODROID kernel: __do_softirq+0x126/0x288
> Aug  8 10:06:51 ODROID kernel: do_softirq+0x7f/0xab
> Aug  8 10:06:51 ODROID kernel: </IRQ>
> Aug  8 10:06:51 ODROID kernel: <TASK>
> Aug  8 10:06:51 ODROID kernel: __local_bh_enable_ip+0x4c/0x6b
> Aug  8 10:06:51 ODROID kernel: netif_rx+0x52/0x5a
> Aug  8 10:06:51 ODROID kernel: macvlan_broadcast+0x10a/0x150 [macvlan]
> Aug  8 10:06:51 ODROID kernel: ? _raw_spin_unlock+0x14/0x29
> Aug  8 10:06:51 ODROID kernel: macvlan_process_broadcast+0xbc/0x12f [ma=
cvlan]
> Aug  8 10:06:51 ODROID kernel: process_one_work+0x1a8/0x295
> Aug  8 10:06:51 ODROID kernel: worker_thread+0x18b/0x244
> Aug  8 10:06:51 ODROID kernel: ? rescuer_thread+0x281/0x281
> Aug  8 10:06:51 ODROID kernel: kthread+0xe4/0xef
> Aug  8 10:06:51 ODROID kernel: ? kthread_complete_and_exit+0x1b/0x1b
> Aug  8 10:06:51 ODROID kernel: ret_from_fork+0x1f/0x30
> Aug  8 10:06:51 ODROID kernel: </TASK>
> Aug  8 10:06:51 ODROID kernel: ---[ end trace 0000000000000000 ]---

See Bugzilla for the full thread.

AFAIK, this is manifestation of earlier syzbot report [2] that haven't
seen any response yet.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217777
[2]: https://lore.kernel.org/all/000000000000497c3c060175aed9@google.com/=


--=20
An old man doll... just what I always wanted! - Clara
