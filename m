Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B0978D131
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbjH3AiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbjH3AiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:38:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C3F122;
        Tue, 29 Aug 2023 17:37:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68bed2c786eso3511234b3a.0;
        Tue, 29 Aug 2023 17:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693355877; x=1693960677; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIcXbpX8tnWENSZb3UK/qF6sfIxkS9IgL1xa8sIsyvY=;
        b=gOJbqpQ8IpC9/HfJ+x5EqiWgy9/YFh/V0kZrry8w2f6BrGs8asfGeBgeiw1pFn1lzK
         mQYFYOsQvlDFjtSgQmxa1Yy7COV0GDOMe4Vq3xDA5TrdRHz2FbPnfyVUoEuWrQPoyCN7
         IwR0fepOz7PQcJz4mSV2We3ie8UHijYSxGVGQvZmzBXpMdyQtpbq3xGgF+WBeiRfWX9g
         6TvfBj4gTI7B4e79Xbl8pTTf899N1s3KMj/CdfnP/g/FtCSmWHeEwkyLvzt3ig4j46Af
         8e6NW+tQcZkmlBqMX6P2IEslxegU21vLUQw6EbcvKY1fL/V8QTnukPtOeEbP1bAAlqiv
         Smgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693355877; x=1693960677;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OIcXbpX8tnWENSZb3UK/qF6sfIxkS9IgL1xa8sIsyvY=;
        b=Q+XUo4uiD40SxfFKBzwZLBW+5AyV2dq1pflqT1vIUs/ovcJvwL+PDxlJzb3ErqVnGc
         tPveKrGOJnzLURX8g869HrwVPyxAgiQ4DO/Ho7fgkqnBu1bGV1NbVr0VRyKtP679Xxwj
         YSy+IMfIq5/gwJ6iDEnBH3T2n9eG+Ee2lZ9gPTeTimoej1J+vYpuVODn4fcYYN81TTVq
         0J0e2WreC3WF6SnnZKGMmYe7JhnFXGHe/gI7MPhIcaMEYRvvE+kzksP5VqDHupBc3dGT
         N9WkaPbghwj5UD8EouzFwwEIBL7tvo1aBvsvNV0Jg5K+EXS5dWxjqQWNOX9C8WHvIDcy
         I5sA==
X-Gm-Message-State: AOJu0Ywzp92903rWs1kwABgdIlG5GAmgIvjr4yEA1zsIcY7wYvJEoe8A
        x8C1sw6EchM/GmKzP/1BM28=
X-Google-Smtp-Source: AGHT+IEtpJmO6nyBZRDvNlU6uMKF8p5HJd86RzqvGZ/sYcKl3mhrN9kEy4eTAZPE+NM+ysMKKpK4nA==
X-Received: by 2002:a05:6a20:f398:b0:136:42c8:693c with SMTP id qr24-20020a056a20f39800b0013642c8693cmr836037pzb.6.1693355877341;
        Tue, 29 Aug 2023 17:37:57 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id bt27-20020a63291b000000b0056b920051b3sm9698508pgb.7.2023.08.29.17.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 17:37:56 -0700 (PDT)
Message-ID: <a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com>
Date:   Wed, 30 Aug 2023 07:37:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Hao Jia <jiahao.os@bytedance.com>, Ben Segall <bsegall@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Igor Raits <igor.raits@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: WARNING: CPU: 13 PID: 3837105 at kernel/sched/sched.h:1561
 __cfsb_csd_unthrottle+0x149/0x160
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

> Hello, we recently got a few kernel crashes with following backtrace. H=
appened on 6.4.12 (and 6.4.11 I think) but did not happen (I think) on 6.=
4.4.
>=20
> [293790.928007] ------------[ cut here ]------------
> [293790.929905] rq->clock_update_flags & RQCF_ACT_SKIP
> [293790.929919] WARNING: CPU: 13 PID: 3837105 at kernel/sched/sched.h:1=
561 __cfsb_csd_unthrottle+0x149/0x160
> [293790.933694] Modules linked in: xt_owner(E) xt_REDIRECT(E) mptcp_dia=
g(E) xsk_diag(E) raw_diag(E) unix_diag(E) af_packet_diag(E) netlink_diag(=
E) tcp_diag(E) udp_diag(E) inet_diag(E) rpcsec_gss_krb5(E) auth_rpcgss(E)=
 nfsv4(E) nfs(E) lockd(E) grace(E) fscache(E) netfs(E) nbd(E) rbd(E) libc=
eph(E) dns_resolver(E) xt_set(E) ipt_rpfilter(E) ip_set_hash_ip(E) ip_set=
_hash_net(E) bpf_preload(E) xt_multiport(E) veth(E) wireguard(E) libchach=
a20poly1305(E) chacha_x86_64(E) poly1305_x86_64(E) ip6_udp_tunnel(E) udp_=
tunnel(E) curve25519_x86_64(E) libcurve25519_generic(E) libchacha(E) nf_c=
onntrack_netlink(E) xt_nat(E) xt_statistic(E) xt_addrtype(E) ipt_REJECT(E=
) nf_reject_ipv4(E) ip_set(E) ip_vs_sh(E) ip_vs_wrr(E) ip_vs_rr(E) ip_vs(=
E) xt_MASQUERADE(E) nft_chain_nat(E) xt_mark(E) xt_conntrack(E) xt_commen=
t(E) nft_compat(E) nf_tables(E) nfnetlink(E) br_netfilter(E) bridge(E) st=
p(E) llc(E) iptable_nat(E) nf_nat(E) iptable_filter(E) ip_tables(E) overl=
ay(E) dummy(E) sunrpc(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4=
(E)
> [293790.933738]  binfmt_misc(E) tls(E) isofs(E) intel_rapl_msr(E) intel=
_rapl_common(E) kvm_amd(E) virtio_gpu(E) ccp(E) virtio_dma_buf(E) drm_shm=
em_helper(E) virtio_net(E) vfat(E) kvm(E) i2c_i801(E) drm_kms_helper(E) n=
et_failover(E) irqbypass(E) syscopyarea(E) fat(E) i2c_smbus(E) failover(E=
) sysfillrect(E) virtio_balloon(E) sysimgblt(E) drm(E) fuse(E) ext4(E) mb=
cache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E) ahci(E) libahci(E) crct10dif_pc=
lmul(E) crc32_pclmul(E) polyval_clmulni(E) libata(E) polyval_generic(E) g=
hash_clmulni_intel(E) sha512_ssse3(E) virtio_blk(E) serio_raw(E) btrfs(E)=
 xor(E) zstd_compress(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) dm_mirr=
or(E) dm_region_hash(E) dm_log(E) dm_mod(E)
> [293790.946262] Unloaded tainted modules: edac_mce_amd(E):1
> [293790.956625] CPU: 13 PID: 3837105 Comm: QueryWorker-30f Tainted: G  =
      W   E      6.4.12-1.gdc.el9.x86_64 #1
> [293790.957963] Hardware name: RDO OpenStack Compute/RHEL, BIOS edk2-20=
230301gitf80f052277c8-2.el9 03/01/2023
> [293790.959681] RIP: 0010:__cfsb_csd_unthrottle+0x149/0x160
> [293790.960933] Code: 37 fa ff 0f 0b e9 17 ff ff ff 80 3d 41 59 fc 01 0=
0 0f 85 21 ff ff ff 48 c7 c7 98 03 95 9d c6 05 2d 59 fc 01 01 e8 77 37 fa=
 ff <0f> 0b 41 8b 85 88 09 00 00 e9 00 ff ff ff 66 0f 1f 84 00 00 00 00
> [293790.964077] RSP: 0000:ffffb708e7217db8 EFLAGS: 00010086
> [293790.965160] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000=
0000000027
> [293790.966340] RDX: ffff905482c5f708 RSI: 0000000000000001 RDI: ffff90=
5482c5f700
> [293790.967839] RBP: ffff9029bb0e9e00 R08: 0000000000000000 R09: 000000=
00ffff7fff
> [293790.969496] R10: ffffb708e7217c58 R11: ffffffff9e3e2c88 R12: 000000=
00000317c0
> [293790.970859] R13: ffff903602c317c0 R14: 0000000000000000 R15: ffff90=
5482c726b8
> [293790.972085] FS:  00007ff3b66fe640(0000) GS:ffff905482c40000(0000) k=
nlGS:0000000000000000
> [293790.973678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [293790.974663] CR2: 00007f16889036c0 CR3: 0000002072e34004 CR4: 000000=
0000770ee0
> [293790.976108] PKRU: 55555554
> [293790.977048] Call Trace:
> [293790.978013]  <TASK>
> [293790.978678]  ? __warn+0x80/0x130
> [293790.979727]  ? __cfsb_csd_unthrottle+0x149/0x160
> [293790.980824]  ? report_bug+0x195/0x1a0
> [293790.981806]  ? handle_bug+0x3c/0x70
> [293790.982884]  ? exc_invalid_op+0x14/0x70
> [293790.983837]  ? asm_exc_invalid_op+0x16/0x20
> [293790.984626]  ? __cfsb_csd_unthrottle+0x149/0x160
> [293790.985599]  ? __cfsb_csd_unthrottle+0x149/0x160
> [293790.986583]  unregister_fair_sched_group+0x73/0x1d0
> [293790.987682]  sched_unregister_group_rcu+0x1a/0x40
> [293790.988752]  rcu_do_batch+0x199/0x4d0
> [293790.989643]  rcu_core+0x267/0x420
> [293790.990418]  __do_softirq+0xc8/0x2ab
> [293790.991285]  __irq_exit_rcu+0xb9/0xf0
> [293790.992555]  sysvec_apic_timer_interrupt+0x3c/0x90
> [293790.993477]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> [293790.994171] RIP: 0033:0x7ff4dca91f60
> [293790.994801] Code: 75 15 49 8b f7 c5 f8 77 49 ba 80 6c bf f3 f4 7f 0=
0 00 41 ff d2 eb 0d 4b 89 7c 13 f8 49 83 c2 f8 4d 89 57 70 48 8b c3 c5 f8=
 77 <48> 83 c4 50 5d 4d 8b 97 08 01 00 00 41 85 02 c3 49 8d 14 fc 8b 7a
> [293790.997256] RSP: 002b:00007ff3b66fd190 EFLAGS: 00000246
> [293790.998138] RAX: 0000000655fd6ed0 RBX: 0000000655fd6ed0 RCX: 000000=
0000000004
> [293790.999184] RDX: 0000000000000000 RSI: 000000066cf4939c RDI: 00007f=
f4f1180eb7
> [293791.000220] RBP: 0000000000000004 R08: 000000066cf48530 R09: 000000=
066cf493a8
> [293791.001274] R10: 00000000000007f0 R11: 00007ff3bc00ca80 R12: 000000=
0000000000
> [293791.002222] R13: 000000066cf49390 R14: 00000000cd9e9272 R15: 00007f=
f39c033800
> [293791.002966]  </TASK>
> [293791.003489] ---[ end trace 0000000000000000 ]---
> [293791.004440] ------------[ cut here ]------------
> [293791.005479] rq->clock_update_flags < RQCF_ACT_SKIP
> [293791.005493] WARNING: CPU: 0 PID: 3920513 at kernel/sched/sched.h:14=
96 update_curr+0x162/0x1d0
>=20
> Sadly I don't have more info but hopefully this stacktrace will be enou=
gh.
>=20

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: ebb83d84e49b54 https://bugzilla.kernel.org/show_bug.=
cgi?id=3D217843

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217843

--=20
An old man doll... just what I always wanted! - Clara
