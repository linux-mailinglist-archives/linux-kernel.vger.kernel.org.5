Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160887D49C0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjJXIQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjJXIQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:16:03 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7841DD7D;
        Tue, 24 Oct 2023 01:16:00 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-57de6e502fcso2585817eaf.3;
        Tue, 24 Oct 2023 01:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698135359; x=1698740159; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72JdeJNwY3FQrBEDRdOhWW6gHzKFb+BLgAoumnRBYm0=;
        b=epJcnpfQq5jv0Xc0MNFbSPVVGjcxh/dd8iG65BHUmNPX02QRergDa45o8iNDOGZpFR
         zF/7fzBim3D/CK5XDQ/VisIz9ZJc7adQ4HzG/e/vyI4QHyUcCaz3HXL8wb7ncWv0fDsq
         otlCVpuVquXf6UXPY5useqqmGGVkHAGAQbvVKodYvuDgypHcfnUu0XNX/pCQZKliLPI3
         CpsHjPK+opW2mgdjvVfy0RIcVAZeLeEchP6CjroeYQLelIRHE7GMbvKa4xQxnzomHGRp
         R557vSIRORjvc8+SVBOAmQJx8Hgijr3j7XIU5fUPDDZrZMKc2kw0LsnDy6gdSngk77iA
         9M4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698135359; x=1698740159;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=72JdeJNwY3FQrBEDRdOhWW6gHzKFb+BLgAoumnRBYm0=;
        b=jnc6tW/Zu3NCvEwb0l/zJjsDpWgooq0nUAgSH+dG7kcN7ftOwQLoqRCTjjNGMtV4PJ
         Y3ttmLRlLSOzSmddIjwplTpc9WUzjf1mV3AJoYtoQzJ6PKE31AZfrW8jH0+sYfvm9bX2
         H79rZOyFnxvN1ZcgLtQS5tXit/hnaTa7zMSe78j487ZilVMz5tPcYVWX0VmenJhgztXZ
         aK1r2jQz6QVDfvMlAZOosFqQ59KO7iS0v+OsD0kNFiSXFBuqwFB9Yv+A/B2QF9Aef4sI
         xK9KIYWbYgRKn470VDaYRzk9khZfV2kjXWfU0bwSzBp2Q6ROMrfaCZVT095Jr7cBZJl+
         lQrw==
X-Gm-Message-State: AOJu0Ywi82w9bmsWzCVBrF7W02ZlubjdJXpzOVyZx7Dme5B9D/+2Gs6m
        xomnL9yGA5o2A1UDYWukP289QcL4Nr8=
X-Google-Smtp-Source: AGHT+IHnOfoj+M3ou/w0N9u9Sc2yqaafsgt89fp/A4/9JV7cO4PvO427kvCpwPjpmsej/9Gc2A+OFg==
X-Received: by 2002:a05:6358:fd01:b0:168:e637:a819 with SMTP id ui1-20020a056358fd0100b00168e637a819mr3896284rwb.12.1698135359327;
        Tue, 24 Oct 2023 01:15:59 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c21-20020aa79535000000b006889081281bsm7183718pfp.138.2023.10.24.01.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 01:15:58 -0700 (PDT)
Message-ID: <2bf06faa-a0a7-4dee-90cd-a054b4e4c947@gmail.com>
Date:   Tue, 24 Oct 2023 15:15:54 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Benjamin Poirier <bpoirier@suse.de>,
        Tom Herbert <therbert@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        CM76 <cmaff76@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: kernel tried to execute NX-protected page - exploit attempt?
 (uid: 0) (qbittorrent with tx-nocache-copy)
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

> I believe this is also an issue with the Broadcom bnx2 drivers since it=
 only seem to happen when I enable "tx-nocache-copy" in ethtool. =20
>=20
> The issue started when I was running Mainline/stable Kernel v6.5.x on a=
nother machine, after google-ing a bit I landed on an article from redhat=
 that pointed at the possibility of an issue caused by a failing hardware=
=2E I was renting the server, so I didn't bother to fill a bug report and=
 assumed it was the server that was going bad. But then it happened again=
 on my other server as soon as I switched the bittorrent client to the sa=
me I was using on that other server. I turned "tx-nocache-copy" off and r=
an mainline kernel v6.5 (on Ubuntu 23.04) for a day or two without issue.=
 After that I switched the kernel back to Ubuntu's kernel (v6.2) and the =
server ran for a couple more days without issue. Two days ago I turned "t=
x-nocache-copy" on again out of curiosity (kernel v6.2), and the server d=
idn't run into any issue with this setting set to on. This morning I upgr=
aded to Ubuntu 23.10 that runs their version of Kernel v6.5. The kernel p=
anicked and server rebooted a couple of hours later.=20
>=20
>=20
> The issue seem to be triggered with a certain configuration of applicat=
ions, I've ran Mainline/stable kernel 6.5.x since its release (and before=
 that v6.4.x) with the rtorrent bittorrent client and "tx-nocache-copy" t=
urned on, the kernel didn't run into any issue for weeks until I switched=
 to another bittorrent client (qbittorrent) last week. It doesn't seem to=
 matter when it happens, the kernel can Opps when the client is downloadi=
ng a single small sized torrent to when it's downloading multiple torrent=
s at the same time.=20
>=20
>=20
> I tried to use the crash utiliy to get the backtrace but it doesn't see=
m to work correctly. I get "crash: invalid structure member offset: modul=
e_core_size FILE: kernel.c  LINE: 3781  FUNCTION: module_init()" when I t=
ry to load the kernel dump.=20
>=20
> The kernel panic happens with 6.5.x Mainline/stable kernel as well as t=
he 6.5 kernel that comes with ubuntu 23.10.
>=20
> The bittorrent clients run as systemd services with normal user privile=
ges and "ProtectKernelModules=3Dyes" "NoNewPrivileges=3Dyes" set in the s=
ystemd service.=20
>=20
> I joined the full dmesg as attachement, and I can send the kdump genera=
ted kernel dump file if needed.=20
>=20
>=20
> ------------------------
> [12090.273551] kernel tried to execute NX-protected page - exploit atte=
mpt? (uid: 0)
> [12090.273577] BUG: unable to handle page fault for address: ffff9441c9=
734458
> [12090.273590] #PF: supervisor instruction fetch in kernel mode
> [12090.273602] #PF: error_code(0x0011) - permissions violation
> [12090.273614] PGD 157401067 P4D 157401067 PUD 23ffff067 PMD 108a81063 =
PTE 8000000109734063
> [12090.273632] Oops: 0011 [#1] PREEMPT SMP PTI
> [12090.273643] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Not tainted =
6.5.0-9-generic #9-Ubuntu
> [12090.273658] Hardware name: Dell Inc. PowerEdge R210 II/03X6X0, BIOS =
2.10.0 05/24/2018
> [12090.273674] RIP: 0010:0xffff9441c9734458
> [12090.273694] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 <00> 00 00 00 00 00 00 00 58 44 73 c9 41 94 ff ff 00 00 00 00 00 00
> [12090.273723] RSP: 0018:ffffb3c380138980 EFLAGS: 00010282
> [12090.273734] RAX: ffff9441c9734458 RBX: ffff9441c9734400 RCX: 0000000=
000000000
> [12090.273746] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff944=
1c9734400
> [12090.273758] RBP: ffffb3c380138990 R08: 0000000000000000 R09: 0000000=
000000000
> [12090.273771] R10: 0000000000000000 R11: 0000000000000000 R12: ffff944=
1c9734400
> [12090.273783] R13: 00000000000005dc R14: ffff9441c49dda00 R15: fffffff=
f9e55ec40
> [12090.273795] FS:  0000000000000000(0000) GS:ffff9442f7c40000(0000) kn=
lGS:0000000000000000
> [12090.273811] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12090.273823] CR2: ffff9441c9734458 CR3: 0000000155a3a006 CR4: 0000000=
0001706e0
> [12090.273837] Call Trace:
> [12090.273845]  <IRQ>
> [12090.273851]  ? show_regs+0x6d/0x80
> [12090.273864]  ? __die+0x24/0x80
> [12090.273873]  ? page_fault_oops+0x99/0x1b0
> [12090.273884]  ? kernelmode_fixup_or_oops+0xb2/0x140
> [12090.273896]  ? __bad_area_nosemaphore+0x1a5/0x2c0
> [12090.273908]  ? bad_area_nosemaphore+0x16/0x30
> [12090.273918]  ? do_kern_addr_fault+0x7b/0xa0
> [12090.273927]  ? exc_page_fault+0x1a4/0x1b0
> [12090.273939]  ? asm_exc_page_fault+0x27/0x30
> [12090.273952]  ? skb_release_head_state+0x27/0xb0
> [12090.273964]  consume_skb+0x33/0xf0
> [12090.273973]  tcp_mtu_probe+0x565/0x5d0
> [12090.273984]  tcp_write_xmit+0x579/0xab0
> [12090.273994]  __tcp_push_pending_frames+0x37/0x110
> [12090.274005]  tcp_rcv_established+0x264/0x730
> [12090.274015]  ? security_sock_rcv_skb+0x39/0x60
> [12090.274027]  tcp_v4_do_rcv+0x169/0x2a0
> [12090.274037]  tcp_v4_rcv+0xd92/0xe00
> [12090.274046]  ? raw_v4_input+0xaa/0x240
> [12090.274056]  ip_protocol_deliver_rcu+0x3c/0x210
> [12090.274068]  ip_local_deliver_finish+0x77/0xa0
> [12090.274078]  ip_local_deliver+0x6e/0x120
> [12090.274089]  ? __pfx_ip_local_deliver_finish+0x10/0x10
> [12090.274369]  ip_sublist_rcv_finish+0x6f/0x80
> [12090.274638]  ip_sublist_rcv+0x171/0x220
> [12090.274931]  ? __pfx_ip_rcv_finish+0x10/0x10
> [12090.275201]  ip_list_rcv+0x102/0x140
> [12090.275459]  __netif_receive_skb_list_core+0x22d/0x250
> [12090.275714]  netif_receive_skb_list_internal+0x1a3/0x2d0
> [12090.275967]  napi_complete_done+0x74/0x1c0
> [12090.276218]  bnx2_poll_msix+0xa1/0xe0 [bnx2]
> [12090.276468]  __napi_poll+0x33/0x1f0
> [12090.276708]  net_rx_action+0x181/0x2e0
> [12090.276943]  __do_softirq+0xd9/0x346
> [12090.277172]  ? handle_irq_event+0x52/0x80
> [12090.277393]  ? handle_edge_irq+0xda/0x250
> [12090.277604]  __irq_exit_rcu+0x75/0xa0
> [12090.277812]  irq_exit_rcu+0xe/0x20
> [12090.278015]  common_interrupt+0xa4/0xb0
> [12090.278217]  </IRQ>
> [12090.278411]  <TASK>
> [12090.278602]  asm_common_interrupt+0x27/0x40
> [12090.278798] RIP: 0010:cpuidle_enter_state+0xda/0x730
> [12090.278992] Code: 11 04 ff e8 a8 f5 ff ff 8b 53 04 49 89 c7 0f 1f 44=
 00 00 31 ff e8 26 bb 02 ff 80 7d d0 00 0f 85 61 02 00 00 fb 0f 1f 44 00 =
00 <45> 85 f6 0f 88 f7 01 00 00 4d 63 ee 49 83 fd 0a 0f 83 17 05 00 00
> [12090.279402] RSP: 0018:ffffb3c3800cbe18 EFLAGS: 00000246
> [12090.279612] RAX: 0000000000000000 RBX: ffff9442f7c7ec00 RCX: 0000000=
000000000
> [12090.279827] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000=
000000000
> [12090.280042] RBP: ffffb3c3800cbe68 R08: 0000000000000000 R09: 0000000=
000000000
> [12090.280259] R10: 0000000000000000 R11: 0000000000000000 R12: fffffff=
f9d0d24a0
> [12090.280478] R13: 0000000000000003 R14: 0000000000000003 R15: 00000af=
efc75867b
> [12090.280698]  ? cpuidle_enter_state+0xca/0x730
> [12090.280918]  ? finish_task_switch.isra.0+0x89/0x2b0
> [12090.281142]  cpuidle_enter+0x2e/0x50
> [12090.281363]  call_cpuidle+0x23/0x60
> [12090.281583]  cpuidle_idle_call+0x11d/0x190
> [12090.281804]  do_idle+0x82/0xf0
> [12090.282022]  cpu_startup_entry+0x1d/0x20
> [12090.282240]  start_secondary+0x129/0x160
> [12090.282460]  secondary_startup_64_no_verify+0x17e/0x18b
> [12090.282685]  </TASK>
> [12090.282902] Modules linked in: tcp_diag inet_diag ip6table_filter ip=
6_tables xt_LOG nf_log_syslog xt_recent xt_limit xt_tcpudp xt_conntrack i=
ptable_filter xt_CT xt_set iptable_raw bpfilter ip_set_hash_ip ip_set_has=
h_net ip_set_hash_ipport ip_set_list_set ip_set_bitmap_port ip_set_hash_n=
etiface ip_set nfnetlink binfmt_misc intel_rapl_msr intel_rapl_common x86=
_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul polyval_clmu=
lni polyval_generic ghash_clmulni_intel aesni_intel crypto_simd cryptd ra=
pl intel_cstate ipmi_ssif mgag200 drm_shmem_helper cfg80211 input_leds dr=
m_kms_helper dcdbas at24 i2c_i801 lpc_ich i2c_smbus ie31200_edac acpi_ipm=
i i2c_algo_bit ipmi_si ipmi_devintf ipmi_msghandler sch_fq tcp_bbr nf_con=
ntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c drm efi_pstore dmi_sysfs i=
p_tables x_tables autofs4 hid_generic usbhid hid crc32_pclmul ahci mpt3sa=
s libahci raid_class bnx2 scsi_transport_sas wmi
> [12090.285082] CR2: ffff9441c9734458
> ----

Later, the reporter (Cc'ed) narrowed down the culprit range:

> Probably has nothing to do with the Broadcom bnx2 driver. The server cr=
ashed with "tx-nocache-copy" set to off.=20
>=20
> I added the dmesg as attachment, the backtrace and kmem of the RIP addr=
ess are below.
>=20
> I ran qbittorrent on a different server with the same hardware config b=
ack in June this year, the server was running Mainline/Stable kernel vers=
ion 6.3.x then 6.4.0 and the server never rebooted once.

See Bugzilla for the full thread and attached dmesg logs.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?=
id=3D218033
#regzbot title: kernel panic when downloading torrent with qbittorrent wi=
th tx-nocache-copy on

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218033

--=20
An old man doll... just what I always wanted! - Clara
