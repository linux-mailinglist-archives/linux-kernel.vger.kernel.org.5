Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681C178A3AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 02:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjH1Ag4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 20:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjH1Agi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 20:36:38 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1EF11C;
        Sun, 27 Aug 2023 17:36:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so1876795b3a.2;
        Sun, 27 Aug 2023 17:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693182994; x=1693787794;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivOQcdaoTWVydwvl9Ru3QBt872Zg+413JYitvyHrkBM=;
        b=lie7XWYa9rSXsBP4gC5B75UQtxV4VQsWLcOEZyiOP97oLMAkakfBGhX+I/mCy4pSN8
         nUuQbtDUcViLOy3eLzpDGlfh7eYNJL+BKUdzCtGII0upLHQZZvB78HxwULBio5lg01ZK
         ZJs7XflAJM7x9Ehcb8cfULl6kkstuBlPpUQgcaLV6xtfZbleAxcNrv3F1mqbrCGs7+yg
         GRvFUtRn0h30Jqs2FAydnIGMhiTgJGkIIuNKY3ccFWW4RJZn/gF+wlcI8ptN282rNKTv
         gqTsFMTmwENTyT2/ynC7yxLlBJu20uoKlMPvZUlAZ6ri/c+oh08JSJMcQq1y4ie95IZw
         FnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693182994; x=1693787794;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ivOQcdaoTWVydwvl9Ru3QBt872Zg+413JYitvyHrkBM=;
        b=BH0khFt9k97deG2PqJvi2JGtrcNp0Zm2liwHYt/tkPKvkGH7sqUTc8Bc2f6kNSYjpP
         J8lPE2eolBYlWptmQU2ud44oO8rP57hAmz3/nCjxFcagk1OfUXE5r936rUREQ3yg0w5C
         WqXfrqrtGVULP7W8nE0ach1006wt3QF7vMPql78fTA0wUxRDTNmTvc04E/eZveQkDwXE
         dKRxFqdpQ+vosmDR/RJfCGkKtIvQus3yE2kiAuISagoxk1423eyU43bZy1+QxpKb0rp2
         KDp1kQbcHpe7+/XmMTO/wx+mcAYI9m6bz6lYpB4Zlj0gci0xQDEWw0sxx1gHhKD/v6iH
         L+vQ==
X-Gm-Message-State: AOJu0YyLqy8Az3LonT6KKpN/Rk7dUXY1h+nAuX55JolB93FySqKdQ3qY
        kAH8sk8pQESXNTALDR/U0VE=
X-Google-Smtp-Source: AGHT+IH70CBcpN1RX2MRDlahrnWSSjubIMWjno271gxty6M3agcMCkWWZX947W8YmVWBDJumE0cZdQ==
X-Received: by 2002:aa7:8887:0:b0:68a:51dc:50c0 with SMTP id z7-20020aa78887000000b0068a51dc50c0mr24416389pfe.32.1693182994193;
        Sun, 27 Aug 2023 17:36:34 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7870f000000b00666e649ca46sm5409518pfo.101.2023.08.27.17.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 17:36:33 -0700 (PDT)
Message-ID: <e2b4ee49-0998-ff3b-f817-5076d0b43b77@gmail.com>
Date:   Mon, 28 Aug 2023 07:36:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        stephane.poignant@protonmail.com,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Netfilter <netfilter-devel@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Since 6.1: flow_dissector.c __skb_flow_dissect+0xa91/0x1cd0
 raises WARNING in specific circumstances
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

I notice a regression report on Bugzilla [1]. Quoting from it:

> ## Overall description
>=20
> After migration from kernel 5.10 to 6.1, i started to encounter the fol=
lowing warning although they do not seem to have any significant function=
al impact.
> Following further investigation, it appears that the warning appears wh=
en both of the following conditions are:
>  - At least one policy based routing rules with L4 selectors (among oth=
ers, L3 matchers and fwmark DO NOT trigger the issue)
>  - A nftable or iptable filtering policy with at least one action rejec=
ting traffic with TCP reset (drop action, or reject with ICMP unreachable=
 DO NOT trigger)
>=20
> The first time a packet matches the reject policy, and that a RST segme=
nt is forged and sent, a kernel WARNING as follows will show up in the dm=
esg:
> ```
> WARNING: CPU: 0 PID: 0 at net/core/flow_dissector.c:1016 __skb_flow_dis=
sect+0xa91/0x1cd0
> ```
>=20
> Traffic does not appear to be affected, including the RST segment that =
is reliably delivered in spite of the WARNING.
>=20
>=20
> ## Expected behaviour
>=20
> The warning should not appear, in this particular setup the namespace o=
f the RST packet should be resolved to the default one.
>=20
>=20
> ## Reproducing steps
>=20
> The following minimalistic configuration will reproduce the issue:
>=20
> - Running last 6.1 "vanilla" kernel at the time of writing:
> ```
> root@v-debian12:~# uname -a
> Linux v-debian12 6.1.47 #1 SMP PREEMPT_DYNAMIC Fri Aug 25 13:23:01 CEST=
 2023 x86_64 GNU/Linux
> ```
> NB: Issue won't happen on different 5.10 kernels that i tried
>=20
> - A routing policy with a rule that uses L4 selectors:
> ```
> root@v-debian12:~# cat /etc/iproute2/rt_tables.d/wanalt.conf
> 100 wanalt
>=20
> root@v-debian12:~# ip rule ls
> 0:	from all lookup local
> 100:	from all ipproto udp dport 27000-27999 lookup wanalt
> 32766:	from all lookup main
> 32767:	from all lookup default
>=20
> root@v-debian12:~# ip route ls
> default via 192.168.56.1 dev enp0s8
> 192.168.56.0/24 dev enp0s8 proto kernel scope link src 192.168.56.3
>=20
> root@v-debian12:~# ip route ls table wanalt
> default via 192.168.56.2 dev enp0s8
> ```
>=20
> - A nftables or iptables rules that rejects some traffic with tcp reset=
:
> ```
> root@v-debian12:~# nft list ruleset
> table inet filter {
> 	chain input {
> 		type filter hook input priority filter; policy accept;
> 		tcp dport 12345 log reject with tcp reset
> 	}
>=20
> 	chain output {
> 		type filter hook output priority filter; policy accept;
> 		tcp sport 12345 tcp flags rst / fin,syn,rst log
> 	}
> }
> ```
> (NB: the rule in thhhe output chain is only for debugging purpose, it l=
et us see what packet caused the warning in the dmesg)
>=20
> - from another VM, we attempt to connect to port 12345 on the reproduci=
ng host:
> ```
> root@v-debian11:~# nc 192.168.56.3 12345
> ```
>=20
> - the following appears in the dmesg of the reproducing host:
> ```
> # the packet that matched the reject rule
> 2023-08-26T14:04:35.619764+02:00 v-debian12 kernel: [ 3335.550250] IN=3D=
enp0s8 OUT=3D MAC=3D08:00:27:76:64:62:08:00:27:69:c9:e5:08:00 SRC=3D192.1=
68.56.4 DST=3D192.168.56.3 LEN=3D60 TOS=3D0x00 PREC=3D0x00 TTL=3D64 ID=3D=
30150 DF PROTO=3DTCP SPT=3D48576 DPT=3D12345 WINDOW=3D64240 RES=3D0x00 SY=
N URGP=3D0
>=20
> # the warning showing up
> 2023-08-26T14:04:35.619791+02:00 v-debian12 kernel: [ 3335.550267] ----=
--------[ cut here ]------------
> 2023-08-26T14:04:35.619793+02:00 v-debian12 kernel: [ 3335.550269] WARN=
ING: CPU: 0 PID: 0 at net/core/flow_dissector.c:1016 __skb_flow_dissect+0=
xa91/0x1cd0
> 2023-08-26T14:04:35.619795+02:00 v-debian12 kernel: [ 3335.550277] Modu=
les linked in: nf_log_syslog(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_r=
eject_ipv6(E) nft_reject(E) nft_log(E) nf_tables(E) libcrc32c(E) nfnetlin=
k(E) intel_rapl_msr(E) intel_rapl_common(E) intel_pmc_core(E) intel_power=
clamp(E) ghash_clmulni_intel(E) sha512_ssse3(E) sha512_generic(E) vmwgfx(=
E) aesni_intel(E) drm_ttm_helper(E) snd_pcm(E) crypto_simd(E) iTCO_wdt(E)=
 cryptd(E) intel_pmc_bxt(E) ttm(E) iTCO_vendor_support(E) rapl(E) watchdo=
g(E) snd_timer(E) drm_kms_helper(E) snd(E) joydev(E) soundcore(E) vboxgue=
st(E) pcspkr(E) rng_core(E) ac(E) button(E) evdev(E) serio_raw(E) sg(E) b=
infmt_misc(E) drm(E) fuse(E) dm_mod(E) loop(E) efi_pstore(E) configfs(E) =
ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mb=
cache(E) jbd2(E) sd_mod(E) t10_pi(E) crc64_rocksoft(E) crc64(E) crc_t10di=
f(E) sr_mod(E) cdrom(E) crct10dif_generic(E) ata_generic(E) ahci(E) libah=
ci(E) ata_piix(E) crct10dif_pclmul(E) crct10dif_common(E) crc32_pclmul(E)=
 crc32c_intel(E) psmouse(E)
> 2023-08-26T14:04:35.619796+02:00 v-debian12 kernel: [ 3335.550336]  lib=
ata(E) scsi_mod(E) scsi_common(E) lpc_ich(E) i2c_piix4(E) e1000(E) batter=
y(E) video(E) wmi(E)
> 2023-08-26T14:04:35.619797+02:00 v-debian12 kernel: [ 3335.550345] CPU:=
 0 PID: 0 Comm: swapper/0 Tainted: G            E      6.1.47 #1
> 2023-08-26T14:04:35.619797+02:00 v-debian12 kernel: [ 3335.550348] Hard=
ware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006=

> 2023-08-26T14:04:35.619798+02:00 v-debian12 kernel: [ 3335.550350] RIP:=
 0010:__skb_flow_dissect+0xa91/0x1cd0
> 2023-08-26T14:04:35.619799+02:00 v-debian12 kernel: [ 3335.550354] Code=
: 00 bf 02 00 00 00 49 89 0c 12 66 89 78 02 41 8b 55 00 e9 e7 f6 ff ff 49=
 8b 44 24 18 48 85 c0 74 09 4c 8b 78 30 e9 30 f7 ff ff <0f> 0b e9 f6 f7 f=
f ff f6 c2 20 0f 84 e4 f6 ff ff 41 0f b7 45 0e 4c
> 2023-08-26T14:04:35.619809+02:00 v-debian12 kernel: [ 3335.550356] RSP:=
 0018:ffffc130800036b0 EFLAGS: 00010246
> 2023-08-26T14:04:35.619810+02:00 v-debian12 kernel: [ 3335.550358] RAX:=
 0000000000000000 RBX: 0000000000000008 RCX: ffffc13080003810
> 2023-08-26T14:04:35.619811+02:00 v-debian12 kernel: [ 3335.550360] RDX:=
 ffffffff94240e40 RSI: ffff9b53c770ee00 RDI: 0000000000000000
> 2023-08-26T14:04:35.619812+02:00 v-debian12 kernel: [ 3335.550361] RBP:=
 ffffc13080003798 R08: 0000000000000000 R09: 0000000000000000
> 2023-08-26T14:04:35.619813+02:00 v-debian12 kernel: [ 3335.550363] R10:=
 ffffc13080003810 R11: ffff9b53e812ba80 R12: ffff9b53c770ee00
> 2023-08-26T14:04:35.619814+02:00 v-debian12 kernel: [ 3335.550364] R13:=
 ffffffff94240e40 R14: ffff9b53c6456080 R15: 0000000000000000
> 2023-08-26T14:04:35.619814+02:00 v-debian12 kernel: [ 3335.550366] FS: =
 0000000000000000(0000) GS:ffff9b53fdc00000(0000) knlGS:0000000000000000
> 2023-08-26T14:04:35.619815+02:00 v-debian12 kernel: [ 3335.550368] CS: =
 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2023-08-26T14:04:35.619816+02:00 v-debian12 kernel: [ 3335.550369] CR2:=
 00007ffdda939440 CR3: 000000004d326005 CR4: 00000000000706f0
> 2023-08-26T14:04:35.619817+02:00 v-debian12 kernel: [ 3335.550371] Call=
 Trace:
> 2023-08-26T14:04:35.619817+02:00 v-debian12 kernel: [ 3335.550374]  <IR=
Q>
> 2023-08-26T14:04:35.619818+02:00 v-debian12 kernel: [ 3335.550378]  ? _=
_warn+0x7d/0xc0
> 2023-08-26T14:04:35.619819+02:00 v-debian12 kernel: [ 3335.550382]  ? _=
_skb_flow_dissect+0xa91/0x1cd0
> 2023-08-26T14:04:35.619820+02:00 v-debian12 kernel: [ 3335.550385]  ? r=
eport_bug+0xe6/0x170
> 2023-08-26T14:04:35.619821+02:00 v-debian12 kernel: [ 3335.550388]  ? h=
andle_bug+0x41/0x70
> 2023-08-26T14:04:35.619821+02:00 v-debian12 kernel: [ 3335.550391]  ? e=
xc_invalid_op+0x13/0x60
> 2023-08-26T14:04:35.619822+02:00 v-debian12 kernel: [ 3335.550393]  ? a=
sm_exc_invalid_op+0x16/0x20
> 2023-08-26T14:04:35.619832+02:00 v-debian12 kernel: [ 3335.550397]  ? _=
_skb_flow_dissect+0xa91/0x1cd0
> 2023-08-26T14:04:35.619833+02:00 v-debian12 kernel: [ 3335.550401]  ? _=
_inet_dev_addr_type+0xe8/0x180
> 2023-08-26T14:04:35.619834+02:00 v-debian12 kernel: [ 3335.550405]  ip_=
route_me_harder+0x143/0x330
> 2023-08-26T14:04:35.619835+02:00 v-debian12 kernel: [ 3335.550411]  nf_=
send_reset+0x17c/0x2d0 [nf_reject_ipv4]
> 2023-08-26T14:04:35.619835+02:00 v-debian12 kernel: [ 3335.550417]  nft=
_reject_inet_eval+0xa9/0xf2 [nft_reject_inet]
> 2023-08-26T14:04:35.619836+02:00 v-debian12 kernel: [ 3335.550422]  nft=
_do_chain+0x198/0x5d0 [nf_tables]
> 2023-08-26T14:04:35.619837+02:00 v-debian12 kernel: [ 3335.550439]  nft=
_do_chain_inet+0xa4/0x110 [nf_tables]
> 2023-08-26T14:04:35.619838+02:00 v-debian12 kernel: [ 3335.550454]  nf_=
hook_slow+0x41/0xc0
> 2023-08-26T14:04:35.619838+02:00 v-debian12 kernel: [ 3335.550458]  ip_=
local_deliver+0xce/0x110
> 2023-08-26T14:04:35.619839+02:00 v-debian12 kernel: [ 3335.550461]  ? i=
p_protocol_deliver_rcu+0x230/0x230
> 2023-08-26T14:04:35.619840+02:00 v-debian12 kernel: [ 3335.550464]  ip_=
sublist_rcv_finish+0x7e/0x90
> 2023-08-26T14:04:35.619840+02:00 v-debian12 kernel: [ 3335.550466]  ip_=
sublist_rcv+0x183/0x230
> 2023-08-26T14:04:35.619841+02:00 v-debian12 kernel: [ 3335.550468]  ? _=
_netif_receive_skb_core.constprop.0+0xaf/0xf00
> 2023-08-26T14:04:35.619842+02:00 v-debian12 kernel: [ 3335.550472]  ip_=
list_rcv+0x139/0x170
> 2023-08-26T14:04:35.619843+02:00 v-debian12 kernel: [ 3335.550475]  __n=
etif_receive_skb_list_core+0x29e/0x2c0
> 2023-08-26T14:04:35.619843+02:00 v-debian12 kernel: [ 3335.550479]  net=
if_receive_skb_list_internal+0x1cd/0x300
> 2023-08-26T14:04:35.619844+02:00 v-debian12 kernel: [ 3335.550483]  ? e=
1000_clean_rx_irq+0x369/0x500 [e1000]
> 2023-08-26T14:04:35.619845+02:00 v-debian12 kernel: [ 3335.550492]  nap=
i_complete_done+0x6d/0x1a0
> 2023-08-26T14:04:35.619845+02:00 v-debian12 kernel: [ 3335.550495]  e10=
00_clean+0x296/0x6a0 [e1000]
> 2023-08-26T14:04:35.619846+02:00 v-debian12 kernel: [ 3335.550505]  ? v=
bg_heartbeat_host_config+0x90/0x90 [vboxguest]
> 2023-08-26T14:04:35.619847+02:00 v-debian12 kernel: [ 3335.550512]  __n=
api_poll+0x2b/0x160
> 2023-08-26T14:04:35.619848+02:00 v-debian12 kernel: [ 3335.550515]  net=
_rx_action+0x2a5/0x360
> 2023-08-26T14:04:35.619848+02:00 v-debian12 kernel: [ 3335.550518]  ? _=
_napi_schedule+0x8e/0xb0
> 2023-08-26T14:04:35.619849+02:00 v-debian12 kernel: [ 3335.550521]  __d=
o_softirq+0xf0/0x2fe
> 2023-08-26T14:04:35.619850+02:00 v-debian12 kernel: [ 3335.550525]  __i=
rq_exit_rcu+0xc7/0x130
> 2023-08-26T14:04:35.619850+02:00 v-debian12 kernel: [ 3335.550528]  com=
mon_interrupt+0xb9/0xd0
> 2023-08-26T14:04:35.619851+02:00 v-debian12 kernel: [ 3335.550531]  </I=
RQ>
> 2023-08-26T14:04:35.619852+02:00 v-debian12 kernel: [ 3335.550532]  <TA=
SK>
> 2023-08-26T14:04:35.619852+02:00 v-debian12 kernel: [ 3335.550533]  asm=
_common_interrupt+0x22/0x40
> 2023-08-26T14:04:35.619853+02:00 v-debian12 kernel: [ 3335.550535] RIP:=
 0010:mwait_idle+0x54/0x80
> 2023-08-26T14:04:35.619854+02:00 v-debian12 kernel: [ 3335.550539] Code=
: 31 d2 48 89 d1 65 48 8b 04 25 c0 fb 01 00 0f 01 c8 48 8b 00 a8 08 75 14=
 66 90 0f 00 2d 05 f5 5c 00 31 c0 48 89 c1 fb 0f 01 c9 <eb> 06 fb 0f 1f 4=
4 00 00 65 48 8b 04 25 c0 fb 01 00 3e 80 60 02 df
> 2023-08-26T14:04:35.619855+02:00 v-debian12 kernel: [ 3335.550540] RSP:=
 0018:ffffffff94003e98 EFLAGS: 00000246
> 2023-08-26T14:04:35.619855+02:00 v-debian12 kernel: [ 3335.550542] RAX:=
 0000000000000000 RBX: ffffffff9401aa40 RCX: 0000000000000000
> 2023-08-26T14:04:35.619856+02:00 v-debian12 kernel: [ 3335.550544] RDX:=
 0000000000000000 RSI: ffffffff9399cba6 RDI: ffffffff939761d1
> 2023-08-26T14:04:35.619857+02:00 v-debian12 kernel: [ 3335.550545] RBP:=
 0000000000000000 R08: 000003a6bb03287e R09: 0000000000000000
> 2023-08-26T14:04:35.619857+02:00 v-debian12 kernel: [ 3335.550546] R10:=
 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> 2023-08-26T14:04:35.619858+02:00 v-debian12 kernel: [ 3335.550547] R13:=
 0000000000000000 R14: ffffffff9401a118 R15: 0000000000000000
> 2023-08-26T14:04:35.619859+02:00 v-debian12 kernel: [ 3335.550550]  ? d=
efault_idle+0x10/0x10
> 2023-08-26T14:04:35.619859+02:00 v-debian12 kernel: [ 3335.550553]  def=
ault_idle_call+0x36/0xf0
> 2023-08-26T14:04:35.619860+02:00 v-debian12 kernel: [ 3335.550556]  do_=
idle+0x225/0x2b0
> 2023-08-26T14:04:35.619861+02:00 v-debian12 kernel: [ 3335.550560]  cpu=
_startup_entry+0x19/0x20
> 2023-08-26T14:04:35.619862+02:00 v-debian12 kernel: [ 3335.550562]  res=
t_init+0xcb/0xd0
> 2023-08-26T14:04:35.619862+02:00 v-debian12 kernel: [ 3335.550565]  arc=
h_call_rest_init+0xa/0x14
> 2023-08-26T14:04:35.619863+02:00 v-debian12 kernel: [ 3335.550572]  sta=
rt_kernel+0x6fe/0x727
> 2023-08-26T14:04:35.619873+02:00 v-debian12 kernel: [ 3335.550575]  sec=
ondary_startup_64_no_verify+0xe5/0xeb
> 2023-08-26T14:04:35.619875+02:00 v-debian12 kernel: [ 3335.550580]  </T=
ASK>
> 2023-08-26T14:04:35.619875+02:00 v-debian12 kernel: [ 3335.550581] ---[=
 end trace 0000000000000000 ]---
>=20
> # the RST packet that caused the warning
> 2023-08-26T14:04:35.619876+02:00 v-debian12 kernel: [ 3335.550593] IN=3D=
 OUT=3Denp0s8 SRC=3D192.168.56.3 DST=3D192.168.56.4 LEN=3D40 TOS=3D0x00 P=
REC=3D0x00 TTL=3D64 ID=3D0 DF PROTO=3DTCP SPT=3D12345 DPT=3D48576 WINDOW=3D=
0 RES=3D0x00 ACK RST URGP=3D0
> ```
>=20
>=20
> ## Known workarounds
>=20
> The issue is benign and does not prevent the traffic from being sent co=
rrectly so there is no strict necessity for a workaround.
> On my affected setup i could prevent the warning from showing up by mar=
king traffic for the alternate uplink using nftables and rewriting the ro=
uting policy to only use L3 and fwmark selectors.

See Bugzilla for the full thread.

Anyway, I'm adding it to be tracked by regzbot:

#regzbot introduced: v5.10..v6.1 https://bugzilla.kernel.org/show_bug.cgi=
?id=3D217826
#regzbot title: flow_dissector warning but netfilter traffic unaffected

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217826

--=20
An old man doll... just what I always wanted! - Clara
