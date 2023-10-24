Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336967D4B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjJXIyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjJXIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:54:06 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDD719B7;
        Tue, 24 Oct 2023 01:53:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b2b1ad7ee6so2703072b6e.2;
        Tue, 24 Oct 2023 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698137616; x=1698742416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9ge7DvX5uTQGrTHmKjRH1P6TrhyZBVDxOOvmHA4GjM=;
        b=Gd1BLtpeXkwNRI4fFa5zLd0CBqt558mKJzqa5sC+9UtRLavKuF4wYSkeYqzxKEazyb
         HB0yUKh1bLl8SSkwUOU3EOycnIkWcN+MnqzW69MrQVXMlGc2OJiMlxvvLTb7qnLisUKb
         xoC2qk0j29c9qaXn/v/sGEpj9cKSC0M8t0jR3fzbkuimus+i87bpwqJe5WA1MYbMxLyt
         3f13EIe0PgEylhvUsNcyMQK0ou/4Yks5aYcCQjxgwh0v05oevGi89sEjg0sA0E3Gagje
         WLb9WH8hBcj27+K06Fvj3Lf+rv7/CnEWATG1ZcVR4Kxelvik17rNq7cC8rimuKV2v9te
         h1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698137616; x=1698742416;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9ge7DvX5uTQGrTHmKjRH1P6TrhyZBVDxOOvmHA4GjM=;
        b=u3cWjaFodW8CSlotn1U+ttGnjsAn4V42+OWnAfXb4zPcq77cOttzcelt2yQ1n3KXid
         wxgN1e7R/R+SH3BFU6ywLBv0n2B3bwAwxSRY44sIC6S4LMbuqtLxPnmRYLT9ho21ajYc
         iD7Xgkazr/CNhrLbeO35zq5nlNWyearPEcZRZdHQ4e4Fs8bCiJr+uT1upKRFRkxeX8vD
         UndcZC2qPgKQYDl/OgH7Mm+6L6Zk51GDN9dMvLc/m37BVQ0U7Clufv1Z+RJhCxoxGHRp
         cg+DIwwdmqMTaTp8xvyASyI7pcnZGXohsc3M9LRgqvTxu6Mu9OlGRqva2IzhZWwWeLf5
         a8UA==
X-Gm-Message-State: AOJu0YxygXWVpQIaPtzHmsWJmRoDi6XcHDGvIVbNjqcgW3qvJ6yHGYrN
        rWc9a+wL4pkcUC9gUEvVOGdWeFnKaE8=
X-Google-Smtp-Source: AGHT+IEqqPr0OzOsAFNyW/iW2ScTpruPjIzH8Zt03Y43R1aLW2vVe7XfXJ6SeJHIxhf4kD6UumPAtA==
X-Received: by 2002:a05:6808:144d:b0:3ae:5e0e:1671 with SMTP id x13-20020a056808144d00b003ae5e0e1671mr16232011oiv.4.1698137616505;
        Tue, 24 Oct 2023 01:53:36 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t4-20020a63f344000000b0056606274e54sm6919560pgj.31.2023.10.24.01.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 01:53:36 -0700 (PDT)
Message-ID: <17a017b9-9807-48ef-bc7b-be8f5df750c5@gmail.com>
Date:   Tue, 24 Oct 2023 15:53:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: kernel tried to execute NX-protected page - exploit attempt?
 (uid: 0) (qbittorrent with tx-nocache-copy)
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Benjamin Poirier <bpoirier@suse.de>,
        Tom Herbert <therbert@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        CM76 <cmaff76@gmail.com>
References: <2bf06faa-a0a7-4dee-90cd-a054b4e4c947@gmail.com>
In-Reply-To: <2bf06faa-a0a7-4dee-90cd-a054b4e4c947@gmail.com>
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

Hi CM76,

On 24/10/2023 15:15, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
>> I believe this is also an issue with the Broadcom bnx2 drivers since i=
t only seem to happen when I enable "tx-nocache-copy" in ethtool. =20
>>
>> The issue started when I was running Mainline/stable Kernel v6.5.x on =
another machine, after google-ing a bit I landed on an article from redha=
t that pointed at the possibility of an issue caused by a failing hardwar=
e. I was renting the server, so I didn't bother to fill a bug report and =
assumed it was the server that was going bad. But then it happened again =
on my other server as soon as I switched the bittorrent client to the sam=
e I was using on that other server. I turned "tx-nocache-copy" off and ra=
n mainline kernel v6.5 (on Ubuntu 23.04) for a day or two without issue. =
After that I switched the kernel back to Ubuntu's kernel (v6.2) and the s=
erver ran for a couple more days without issue. Two days ago I turned "tx=
-nocache-copy" on again out of curiosity (kernel v6.2), and the server di=
dn't run into any issue with this setting set to on. This morning I upgra=
ded to Ubuntu 23.10 that runs their version of Kernel v6.5. The kernel pa=
nicked and server rebooted a couple of hours later.=20
>>
>>
>> The issue seem to be triggered with a certain configuration of applica=
tions, I've ran Mainline/stable kernel 6.5.x since its release (and befor=
e that v6.4.x) with the rtorrent bittorrent client and "tx-nocache-copy" =
turned on, the kernel didn't run into any issue for weeks until I switche=
d to another bittorrent client (qbittorrent) last week. It doesn't seem t=
o matter when it happens, the kernel can Opps when the client is download=
ing a single small sized torrent to when it's downloading multiple torren=
ts at the same time.=20
>>
>>
>> I tried to use the crash utiliy to get the backtrace but it doesn't se=
em to work correctly. I get "crash: invalid structure member offset: modu=
le_core_size FILE: kernel.c  LINE: 3781  FUNCTION: module_init()" when I =
try to load the kernel dump.=20
>>
>> The kernel panic happens with 6.5.x Mainline/stable kernel as well as =
the 6.5 kernel that comes with ubuntu 23.10.
>>
>> The bittorrent clients run as systemd services with normal user privil=
eges and "ProtectKernelModules=3Dyes" "NoNewPrivileges=3Dyes" set in the =
systemd service.=20
>>
>> I joined the full dmesg as attachement, and I can send the kdump gener=
ated kernel dump file if needed.=20
>>
>>
>> ------------------------
>> [12090.273551] kernel tried to execute NX-protected page - exploit att=
empt? (uid: 0)
>> [12090.273577] BUG: unable to handle page fault for address: ffff9441c=
9734458
>> [12090.273590] #PF: supervisor instruction fetch in kernel mode
>> [12090.273602] #PF: error_code(0x0011) - permissions violation
>> [12090.273614] PGD 157401067 P4D 157401067 PUD 23ffff067 PMD 108a81063=
 PTE 8000000109734063
>> [12090.273632] Oops: 0011 [#1] PREEMPT SMP PTI
>> [12090.273643] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Not tainted=
 6.5.0-9-generic #9-Ubuntu
>> [12090.273658] Hardware name: Dell Inc. PowerEdge R210 II/03X6X0, BIOS=
 2.10.0 05/24/2018
>> [12090.273674] RIP: 0010:0xffff9441c9734458
>> [12090.273694] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 <00> 00 00 00 00 00 00 00 58 44 73 c9 41 94 ff ff 00 00 00 00 00 00
>> [12090.273723] RSP: 0018:ffffb3c380138980 EFLAGS: 00010282
>> [12090.273734] RAX: ffff9441c9734458 RBX: ffff9441c9734400 RCX: 000000=
0000000000
>> [12090.273746] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff94=
41c9734400
>> [12090.273758] RBP: ffffb3c380138990 R08: 0000000000000000 R09: 000000=
0000000000
>> [12090.273771] R10: 0000000000000000 R11: 0000000000000000 R12: ffff94=
41c9734400
>> [12090.273783] R13: 00000000000005dc R14: ffff9441c49dda00 R15: ffffff=
ff9e55ec40
>> [12090.273795] FS:  0000000000000000(0000) GS:ffff9442f7c40000(0000) k=
nlGS:0000000000000000
>> [12090.273811] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [12090.273823] CR2: ffff9441c9734458 CR3: 0000000155a3a006 CR4: 000000=
00001706e0
>> [12090.273837] Call Trace:
>> [12090.273845]  <IRQ>
>> [12090.273851]  ? show_regs+0x6d/0x80
>> [12090.273864]  ? __die+0x24/0x80
>> [12090.273873]  ? page_fault_oops+0x99/0x1b0
>> [12090.273884]  ? kernelmode_fixup_or_oops+0xb2/0x140
>> [12090.273896]  ? __bad_area_nosemaphore+0x1a5/0x2c0
>> [12090.273908]  ? bad_area_nosemaphore+0x16/0x30
>> [12090.273918]  ? do_kern_addr_fault+0x7b/0xa0
>> [12090.273927]  ? exc_page_fault+0x1a4/0x1b0
>> [12090.273939]  ? asm_exc_page_fault+0x27/0x30
>> [12090.273952]  ? skb_release_head_state+0x27/0xb0
>> [12090.273964]  consume_skb+0x33/0xf0
>> [12090.273973]  tcp_mtu_probe+0x565/0x5d0
>> [12090.273984]  tcp_write_xmit+0x579/0xab0
>> [12090.273994]  __tcp_push_pending_frames+0x37/0x110
>> [12090.274005]  tcp_rcv_established+0x264/0x730
>> [12090.274015]  ? security_sock_rcv_skb+0x39/0x60
>> [12090.274027]  tcp_v4_do_rcv+0x169/0x2a0
>> [12090.274037]  tcp_v4_rcv+0xd92/0xe00
>> [12090.274046]  ? raw_v4_input+0xaa/0x240
>> [12090.274056]  ip_protocol_deliver_rcu+0x3c/0x210
>> [12090.274068]  ip_local_deliver_finish+0x77/0xa0
>> [12090.274078]  ip_local_deliver+0x6e/0x120
>> [12090.274089]  ? __pfx_ip_local_deliver_finish+0x10/0x10
>> [12090.274369]  ip_sublist_rcv_finish+0x6f/0x80
>> [12090.274638]  ip_sublist_rcv+0x171/0x220
>> [12090.274931]  ? __pfx_ip_rcv_finish+0x10/0x10
>> [12090.275201]  ip_list_rcv+0x102/0x140
>> [12090.275459]  __netif_receive_skb_list_core+0x22d/0x250
>> [12090.275714]  netif_receive_skb_list_internal+0x1a3/0x2d0
>> [12090.275967]  napi_complete_done+0x74/0x1c0
>> [12090.276218]  bnx2_poll_msix+0xa1/0xe0 [bnx2]
>> [12090.276468]  __napi_poll+0x33/0x1f0
>> [12090.276708]  net_rx_action+0x181/0x2e0
>> [12090.276943]  __do_softirq+0xd9/0x346
>> [12090.277172]  ? handle_irq_event+0x52/0x80
>> [12090.277393]  ? handle_edge_irq+0xda/0x250
>> [12090.277604]  __irq_exit_rcu+0x75/0xa0
>> [12090.277812]  irq_exit_rcu+0xe/0x20
>> [12090.278015]  common_interrupt+0xa4/0xb0
>> [12090.278217]  </IRQ>
>> [12090.278411]  <TASK>
>> [12090.278602]  asm_common_interrupt+0x27/0x40
>> [12090.278798] RIP: 0010:cpuidle_enter_state+0xda/0x730
>> [12090.278992] Code: 11 04 ff e8 a8 f5 ff ff 8b 53 04 49 89 c7 0f 1f 4=
4 00 00 31 ff e8 26 bb 02 ff 80 7d d0 00 0f 85 61 02 00 00 fb 0f 1f 44 00=
 00 <45> 85 f6 0f 88 f7 01 00 00 4d 63 ee 49 83 fd 0a 0f 83 17 05 00 00
>> [12090.279402] RSP: 0018:ffffb3c3800cbe18 EFLAGS: 00000246
>> [12090.279612] RAX: 0000000000000000 RBX: ffff9442f7c7ec00 RCX: 000000=
0000000000
>> [12090.279827] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000000=
0000000000
>> [12090.280042] RBP: ffffb3c3800cbe68 R08: 0000000000000000 R09: 000000=
0000000000
>> [12090.280259] R10: 0000000000000000 R11: 0000000000000000 R12: ffffff=
ff9d0d24a0
>> [12090.280478] R13: 0000000000000003 R14: 0000000000000003 R15: 00000a=
fefc75867b
>> [12090.280698]  ? cpuidle_enter_state+0xca/0x730
>> [12090.280918]  ? finish_task_switch.isra.0+0x89/0x2b0
>> [12090.281142]  cpuidle_enter+0x2e/0x50
>> [12090.281363]  call_cpuidle+0x23/0x60
>> [12090.281583]  cpuidle_idle_call+0x11d/0x190
>> [12090.281804]  do_idle+0x82/0xf0
>> [12090.282022]  cpu_startup_entry+0x1d/0x20
>> [12090.282240]  start_secondary+0x129/0x160
>> [12090.282460]  secondary_startup_64_no_verify+0x17e/0x18b
>> [12090.282685]  </TASK>
>> [12090.282902] Modules linked in: tcp_diag inet_diag ip6table_filter i=
p6_tables xt_LOG nf_log_syslog xt_recent xt_limit xt_tcpudp xt_conntrack =
iptable_filter xt_CT xt_set iptable_raw bpfilter ip_set_hash_ip ip_set_ha=
sh_net ip_set_hash_ipport ip_set_list_set ip_set_bitmap_port ip_set_hash_=
netiface ip_set nfnetlink binfmt_misc intel_rapl_msr intel_rapl_common x8=
6_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul polyval_clm=
ulni polyval_generic ghash_clmulni_intel aesni_intel crypto_simd cryptd r=
apl intel_cstate ipmi_ssif mgag200 drm_shmem_helper cfg80211 input_leds d=
rm_kms_helper dcdbas at24 i2c_i801 lpc_ich i2c_smbus ie31200_edac acpi_ip=
mi i2c_algo_bit ipmi_si ipmi_devintf ipmi_msghandler sch_fq tcp_bbr nf_co=
nntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c drm efi_pstore dmi_sysfs =
ip_tables x_tables autofs4 hid_generic usbhid hid crc32_pclmul ahci mpt3s=
as libahci raid_class bnx2 scsi_transport_sas wmi
>> [12090.285082] CR2: ffff9441c9734458
>> ----
>=20

Please see [1] for how to decode stack trace symbols.
And also, the most important thing to get this regression fixed
is to find culprit commit by bisecting (for reference see
Documentation/admin-guide/bug-bisect.rst).

[1]: https://lore.kernel.org/all/CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2j=
ypN_Qf9oojw@mail.gmail.com/

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

