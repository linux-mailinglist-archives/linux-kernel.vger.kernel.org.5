Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08D87D4C19
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjJXJ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjJXJ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:26:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E42B19B5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:25:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so10165a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698139541; x=1698744341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeojdCUjcd3duImQfWD3kwvOxa2loPoxPnqbLL/r7ZA=;
        b=BJc9QY7e/F40XH0xEihgLD6mCIiLLjkZrXmoY2/mKjSytBhPNqiSRHrvAmd+dCbj/U
         C4fvuY34wtjaXc2R/X0S87Hf2loUWcQ67FnyoTn80YxGhG9M5EdFTKtOWA8Y4xb0SJEt
         HRzqdBqc58lt8P3nDXD3h6k3gaXtxO/HUaPWUDmJQtK/y5TMvKvl8QlA+I6xCM8llxuF
         hnEnh5yZlpdJR5BWHGQqf3fVD1aFBH6Yn5FxJfivRp44o+ODbBclhHH7kVSs5MIVsoQC
         3HqgNtZ9JC9HtqS021s/DSj/TpJ9VJ832HJSsssL+5Yyc4FMuAP7zeFCuLOoj7UUEQfv
         /Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139541; x=1698744341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeojdCUjcd3duImQfWD3kwvOxa2loPoxPnqbLL/r7ZA=;
        b=tnr640p73BH8dQ5hIAgUMND2pDUgapU2OxYIF9pp6BeXiFXh5+0YkMSCk2pqMs+YE+
         z1A8h9XRCdwvXo/4J5KNQvYe/834fLgf+KVEcoFv5L8EPBpCXAp0CgxMtFKtnyQdIsd1
         M8KnMm3hMxvaJuPU9NYorysMUrr5rE6bh9u7phC/MuO3kUfToA22MLtXu+CaDlyZzdhc
         8LpN6wA9mTxjW/I6hQ1oLJoUhFRbndfAwC0Lmv12RrMhDhB4EqS6C9OgODhr6n1g0VWf
         JoQGxD2aOwwDHRcX9DKe6xcG4ajsRXOVVICOkTnEBg8uPJ84+8GvwIZcMaR/CDkWQG0I
         69Bg==
X-Gm-Message-State: AOJu0YzqubjOEMmoHNnkNG2pSgPOhCsSjnQJOQZHxU9CNiXcCaT9Yk8+
        zASoSw+wreImv5cCmWg6C2QTh92maMMMDrqM70cbzmYw5SAwMuQ4k/gSfA==
X-Google-Smtp-Source: AGHT+IHPhOrpFO6GG+mYY0EVavaNnXlLQDydOf6WO+4g4d/hHIIeL/IsgVtv4kMcMxLJVw6MP4mbBYghpXUSANGWiVs=
X-Received: by 2002:a05:6402:32c:b0:540:9f24:6006 with SMTP id
 q12-20020a056402032c00b005409f246006mr66754edw.6.1698139541247; Tue, 24 Oct
 2023 02:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <2bf06faa-a0a7-4dee-90cd-a054b4e4c947@gmail.com> <17a017b9-9807-48ef-bc7b-be8f5df750c5@gmail.com>
In-Reply-To: <17a017b9-9807-48ef-bc7b-be8f5df750c5@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 24 Oct 2023 11:25:27 +0200
Message-ID: <CANn89iJxCqGeEM2sJbs8TU00Rj-iddoyoabvB7x4eEaPwCKTMA@mail.gmail.com>
Subject: Re: Fwd: kernel tried to execute NX-protected page - exploit attempt?
 (uid: 0) (qbittorrent with tx-nocache-copy)
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Poirier <bpoirier@suse.de>,
        Tom Herbert <therbert@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        CM76 <cmaff76@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 10:53=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
>
> Hi CM76,
>
> On 24/10/2023 15:15, Bagas Sanjaya wrote:
> > Hi,
> >
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> >
> >> I believe this is also an issue with the Broadcom bnx2 drivers since i=
t only seem to happen when I enable "tx-nocache-copy" in ethtool.
> >>
> >> The issue started when I was running Mainline/stable Kernel v6.5.x on =
another machine, after google-ing a bit I landed on an article from redhat =
that pointed at the possibility of an issue caused by a failing hardware. I=
 was renting the server, so I didn't bother to fill a bug report and assume=
d it was the server that was going bad. But then it happened again on my ot=
her server as soon as I switched the bittorrent client to the same I was us=
ing on that other server. I turned "tx-nocache-copy" off and ran mainline k=
ernel v6.5 (on Ubuntu 23.04) for a day or two without issue. After that I s=
witched the kernel back to Ubuntu's kernel (v6.2) and the server ran for a =
couple more days without issue. Two days ago I turned "tx-nocache-copy" on =
again out of curiosity (kernel v6.2), and the server didn't run into any is=
sue with this setting set to on. This morning I upgraded to Ubuntu 23.10 th=
at runs their version of Kernel v6.5. The kernel panicked and server reboot=
ed a couple of hours later.
> >>
> >>
> >> The issue seem to be triggered with a certain configuration of applica=
tions, I've ran Mainline/stable kernel 6.5.x since its release (and before =
that v6.4.x) with the rtorrent bittorrent client and "tx-nocache-copy" turn=
ed on, the kernel didn't run into any issue for weeks until I switched to a=
nother bittorrent client (qbittorrent) last week. It doesn't seem to matter=
 when it happens, the kernel can Opps when the client is downloading a sing=
le small sized torrent to when it's downloading multiple torrents at the sa=
me time.
> >>
> >>
> >> I tried to use the crash utiliy to get the backtrace but it doesn't se=
em to work correctly. I get "crash: invalid structure member offset: module=
_core_size FILE: kernel.c  LINE: 3781  FUNCTION: module_init()" when I try =
to load the kernel dump.
> >>
> >> The kernel panic happens with 6.5.x Mainline/stable kernel as well as =
the 6.5 kernel that comes with ubuntu 23.10.
> >>
> >> The bittorrent clients run as systemd services with normal user privil=
eges and "ProtectKernelModules=3Dyes" "NoNewPrivileges=3Dyes" set in the sy=
stemd service.
> >>
> >> I joined the full dmesg as attachement, and I can send the kdump gener=
ated kernel dump file if needed.
> >>
> >>
> >> ------------------------
> >> [12090.273551] kernel tried to execute NX-protected page - exploit att=
empt? (uid: 0)
> >> [12090.273577] BUG: unable to handle page fault for address: ffff9441c=
9734458
> >> [12090.273590] #PF: supervisor instruction fetch in kernel mode
> >> [12090.273602] #PF: error_code(0x0011) - permissions violation
> >> [12090.273614] PGD 157401067 P4D 157401067 PUD 23ffff067 PMD 108a81063=
 PTE 8000000109734063
> >> [12090.273632] Oops: 0011 [#1] PREEMPT SMP PTI
> >> [12090.273643] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Not tainted=
 6.5.0-9-generic #9-Ubuntu
> >> [12090.273658] Hardware name: Dell Inc. PowerEdge R210 II/03X6X0, BIOS=
 2.10.0 05/24/2018
> >> [12090.273674] RIP: 0010:0xffff9441c9734458
> >> [12090.273694] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 <00> 00 00 00 00 00 00 00 58 44 73 c9 41 94 ff ff 00 00 00 00 00 00
> >> [12090.273723] RSP: 0018:ffffb3c380138980 EFLAGS: 00010282
> >> [12090.273734] RAX: ffff9441c9734458 RBX: ffff9441c9734400 RCX: 000000=
0000000000
> >> [12090.273746] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff94=
41c9734400
> >> [12090.273758] RBP: ffffb3c380138990 R08: 0000000000000000 R09: 000000=
0000000000
> >> [12090.273771] R10: 0000000000000000 R11: 0000000000000000 R12: ffff94=
41c9734400
> >> [12090.273783] R13: 00000000000005dc R14: ffff9441c49dda00 R15: ffffff=
ff9e55ec40
> >> [12090.273795] FS:  0000000000000000(0000) GS:ffff9442f7c40000(0000) k=
nlGS:0000000000000000
> >> [12090.273811] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [12090.273823] CR2: ffff9441c9734458 CR3: 0000000155a3a006 CR4: 000000=
00001706e0
> >> [12090.273837] Call Trace:
> >> [12090.273845]  <IRQ>
> >> [12090.273851]  ? show_regs+0x6d/0x80
> >> [12090.273864]  ? __die+0x24/0x80
> >> [12090.273873]  ? page_fault_oops+0x99/0x1b0
> >> [12090.273884]  ? kernelmode_fixup_or_oops+0xb2/0x140
> >> [12090.273896]  ? __bad_area_nosemaphore+0x1a5/0x2c0
> >> [12090.273908]  ? bad_area_nosemaphore+0x16/0x30
> >> [12090.273918]  ? do_kern_addr_fault+0x7b/0xa0
> >> [12090.273927]  ? exc_page_fault+0x1a4/0x1b0
> >> [12090.273939]  ? asm_exc_page_fault+0x27/0x30
> >> [12090.273952]  ? skb_release_head_state+0x27/0xb0
> >> [12090.273964]  consume_skb+0x33/0xf0
> >> [12090.273973]  tcp_mtu_probe+0x565/0x5d0
> >> [12090.273984]  tcp_write_xmit+0x579/0xab0
> >> [12090.273994]  __tcp_push_pending_frames+0x37/0x110
> >> [12090.274005]  tcp_rcv_established+0x264/0x730
> >> [12090.274015]  ? security_sock_rcv_skb+0x39/0x60
> >> [12090.274027]  tcp_v4_do_rcv+0x169/0x2a0
> >> [12090.274037]  tcp_v4_rcv+0xd92/0xe00
> >> [12090.274046]  ? raw_v4_input+0xaa/0x240
> >> [12090.274056]  ip_protocol_deliver_rcu+0x3c/0x210
> >> [12090.274068]  ip_local_deliver_finish+0x77/0xa0
> >> [12090.274078]  ip_local_deliver+0x6e/0x120
> >> [12090.274089]  ? __pfx_ip_local_deliver_finish+0x10/0x10
> >> [12090.274369]  ip_sublist_rcv_finish+0x6f/0x80
> >> [12090.274638]  ip_sublist_rcv+0x171/0x220
> >> [12090.274931]  ? __pfx_ip_rcv_finish+0x10/0x10
> >> [12090.275201]  ip_list_rcv+0x102/0x140
> >> [12090.275459]  __netif_receive_skb_list_core+0x22d/0x250
> >> [12090.275714]  netif_receive_skb_list_internal+0x1a3/0x2d0
> >> [12090.275967]  napi_complete_done+0x74/0x1c0
> >> [12090.276218]  bnx2_poll_msix+0xa1/0xe0 [bnx2]
> >> [12090.276468]  __napi_poll+0x33/0x1f0
> >> [12090.276708]  net_rx_action+0x181/0x2e0
> >> [12090.276943]  __do_softirq+0xd9/0x346
> >> [12090.277172]  ? handle_irq_event+0x52/0x80
> >> [12090.277393]  ? handle_edge_irq+0xda/0x250
> >> [12090.277604]  __irq_exit_rcu+0x75/0xa0
> >> [12090.277812]  irq_exit_rcu+0xe/0x20
> >> [12090.278015]  common_interrupt+0xa4/0xb0
> >> [12090.278217]  </IRQ>
> >> [12090.278411]  <TASK>
> >> [12090.278602]  asm_common_interrupt+0x27/0x40
> >> [12090.278798] RIP: 0010:cpuidle_enter_state+0xda/0x730
> >> [12090.278992] Code: 11 04 ff e8 a8 f5 ff ff 8b 53 04 49 89 c7 0f 1f 4=
4 00 00 31 ff e8 26 bb 02 ff 80 7d d0 00 0f 85 61 02 00 00 fb 0f 1f 44 00 0=
0 <45> 85 f6 0f 88 f7 01 00 00 4d 63 ee 49 83 fd 0a 0f 83 17 05 00 00
> >> [12090.279402] RSP: 0018:ffffb3c3800cbe18 EFLAGS: 00000246
> >> [12090.279612] RAX: 0000000000000000 RBX: ffff9442f7c7ec00 RCX: 000000=
0000000000
> >> [12090.279827] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000000=
0000000000
> >> [12090.280042] RBP: ffffb3c3800cbe68 R08: 0000000000000000 R09: 000000=
0000000000
> >> [12090.280259] R10: 0000000000000000 R11: 0000000000000000 R12: ffffff=
ff9d0d24a0
> >> [12090.280478] R13: 0000000000000003 R14: 0000000000000003 R15: 00000a=
fefc75867b
> >> [12090.280698]  ? cpuidle_enter_state+0xca/0x730
> >> [12090.280918]  ? finish_task_switch.isra.0+0x89/0x2b0
> >> [12090.281142]  cpuidle_enter+0x2e/0x50
> >> [12090.281363]  call_cpuidle+0x23/0x60
> >> [12090.281583]  cpuidle_idle_call+0x11d/0x190
> >> [12090.281804]  do_idle+0x82/0xf0
> >> [12090.282022]  cpu_startup_entry+0x1d/0x20
> >> [12090.282240]  start_secondary+0x129/0x160
> >> [12090.282460]  secondary_startup_64_no_verify+0x17e/0x18b
> >> [12090.282685]  </TASK>
> >> [12090.282902] Modules linked in: tcp_diag inet_diag ip6table_filter i=
p6_tables xt_LOG nf_log_syslog xt_recent xt_limit xt_tcpudp xt_conntrack ip=
table_filter xt_CT xt_set iptable_raw bpfilter ip_set_hash_ip ip_set_hash_n=
et ip_set_hash_ipport ip_set_list_set ip_set_bitmap_port ip_set_hash_netifa=
ce ip_set nfnetlink binfmt_misc intel_rapl_msr intel_rapl_common x86_pkg_te=
mp_thermal intel_powerclamp coretemp crct10dif_pclmul polyval_clmulni polyv=
al_generic ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl intel_cs=
tate ipmi_ssif mgag200 drm_shmem_helper cfg80211 input_leds drm_kms_helper =
dcdbas at24 i2c_i801 lpc_ich i2c_smbus ie31200_edac acpi_ipmi i2c_algo_bit =
ipmi_si ipmi_devintf ipmi_msghandler sch_fq tcp_bbr nf_conntrack nf_defrag_=
ipv6 nf_defrag_ipv4 libcrc32c drm efi_pstore dmi_sysfs ip_tables x_tables a=
utofs4 hid_generic usbhid hid crc32_pclmul ahci mpt3sas libahci raid_class =
bnx2 scsi_transport_sas wmi
> >> [12090.285082] CR2: ffff9441c9734458
> >> ----
> >
>
> Please see [1] for how to decode stack trace symbols.
> And also, the most important thing to get this regression fixed
> is to find culprit commit by bisecting (for reference see
> Documentation/admin-guide/bug-bisect.rst).
>
> [1]: https://lore.kernel.org/all/CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2j=
ypN_Qf9oojw@mail.gmail.com/
>
> Thanks.

This has been fixed already two weeks ago.

commit 71c299c711d1f44f0bf04f1fea66baad565240f1
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Tue Oct 10 10:36:51 2023 -0700

    net: tcp: fix crashes trying to free half-baked MTU probes

    tcp_stream_alloc_skb() initializes the skb to use tcp_tsorted_anchor
    which is a union with the destructor. We need to clean that
    TCP-iness up before freeing.

    Fixes: 736013292e3c ("tcp: let tcp_mtu_probe() build headless packets")
    Reviewed-by: Eric Dumazet <edumazet@google.com>
    Link: https://lore.kernel.org/r/20231010173651.3990234-1-kuba@kernel.or=
g
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
