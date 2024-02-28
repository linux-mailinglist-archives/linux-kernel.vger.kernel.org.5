Return-Path: <linux-kernel+bounces-85064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E5A86AFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B04F4B262DE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B2014C58E;
	Wed, 28 Feb 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NaRc1nr8"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962D7351C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125669; cv=none; b=cOoq8+B14sV9VcAIrJHBhxZH6GXRdFfVp1RmE2bmkqU3Tvv38w0YifZD2UQ6XJ2FD+8Yu+blYoQFuxeiBCH6hvR3lY9uThqVY7Kkv/x9bAtckimV6M/0Z4mn4khsZCVgG4HQnzsHaKdu9JeLlH7aFtYKoWTOFXgM2s8on8umk5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125669; c=relaxed/simple;
	bh=VQmgSmjY24QmAlPhVkark0CkaMkACTSy+vcYg2Cpvgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgFv9/0TgNmx/5hRLoNjwaEl/hbvoNAB+79qytQYWtn+GC2RRdE7KWsuAZYaE25QLNIIGZs2//fhFXxHz0E4UFC7vwpqi4zg7IHWbKmvWW1VqYsGXqrTjweyoL4+3GeDxr2HmGuk227bvnQ8PUaNpXIUbKqnZeTBE3h64JaNnbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NaRc1nr8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412b83cfb44so3675e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709125665; x=1709730465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ds6k2OGgjr+66jCurt8bfyj79IHMsZPOvgk2Z6jYguY=;
        b=NaRc1nr81YxTKxvC3HjZHiNMZPLFG/4Pfd0JTsEmXFi5rW2GdkKceQHg/8pw5fBYPI
         LeF/KRZMwfdfNcRJBYih1tnxhLjsZa6wQV/CFjtJmj5OPqrJ1GwTlNJzE9ssE5C5L5aR
         yhtJzIq/LXP/UtCE7sQxFjJi88jRPWQlGyicYvBFT6gf4q1fkE2QLPIIFzVUZyum6v0/
         UD4DtSjf0DYXPseMnJsTG3igvJ94C8sn+wjSgpsiqxftFeepiSMFQJzH8XFiX8g+MgD5
         GANlvy3/MqVHjaT0EjpX3G/ShqO6NQaNQKmjREUdYCebbgtXFR7MJIfxmEbp0JiSA+RZ
         KTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125665; x=1709730465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ds6k2OGgjr+66jCurt8bfyj79IHMsZPOvgk2Z6jYguY=;
        b=GpQqerh/jQmNXi+W3pD9KL2/IFFdLEkxmIHqWUIpnYTMQY10on0VqrgGvLd16W3Uh0
         aj6vQbcJt+4rja8/y20AQ8rX3bZjyUkn8STi/EFNsAn/gwIXHn6hDAVwbGXyHPAM0mkP
         nKmPbvWMMb+rt/4finnodA/Gd022iS4/QBdkRtuqH1H6aHv+fbGuFH1UXpIQcuHt9PCL
         gL6B8+XFnHOx0znF+sOrqcRhWeHXNHr87Z06kTBTSXAm8vmNS6YtfqXYO52+qDC0hx9a
         HFKFruBOqGfW00q861nDsAY3izvBfPkm0Ki7Xe7kqCkwBR2sw4o0yxrf5df+/HE30mvp
         ORyA==
X-Gm-Message-State: AOJu0YwrU5tXHHyBeb+rsL/rxqSwlFwn6Ro9rcve0J1zDcK+8Ziv2Pt2
	+m9eYSKS9hiQiOOoxV2GXGeIyVCDCOBJpolgvRyOLbEsP+lIUXV4GUd+iNKWiCo=
X-Google-Smtp-Source: AGHT+IEzohgPC0Sma7dMAYNpX/Dsy4kHDmtryX7DdCeZVa+F22ZZdWGJvDH8qqYsAxciG9U3WQUuLg==
X-Received: by 2002:adf:ea88:0:b0:33d:d251:9220 with SMTP id s8-20020adfea88000000b0033dd2519220mr6885228wrm.17.1709125664871;
        Wed, 28 Feb 2024 05:07:44 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bq1-20020a5d5a01000000b0033e05499cd6sm225875wrb.59.2024.02.28.05.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:07:44 -0800 (PST)
Date: Wed, 28 Feb 2024 14:07:41 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, pablo@netfilter.org, laforge@gnumonks.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	kovalev@altlinux.org, nickel@altlinux.org, dutyrok@altlinux.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] gtp: fix use-after-free and null-ptr-deref in
 gtp_newlink()
Message-ID: <Zd8wHT5bclgLvJld@nanopsycho>
References: <20240228114703.465107-1-oficerovas@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240228114703.465107-1-oficerovas@altlinux.org>

Wed, Feb 28, 2024 at 12:47:03PM CET, oficerovas@altlinux.org wrote:
>The gtp_link_ops operations structure for the subsystem must be
>registered after registering the gtp_net_ops pernet operations structure.
>
>Syzkaller hit 'general protection fault in gtp_genl_dump_pdp' bug:
>
>[ 1010.702740] gtp: GTP module unloaded
>[ 1010.715877] general protection fault, probably for non-canonical addres=
s 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
>[ 1010.715888] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000=
000000000f]
>[ 1010.715895] CPU: 1 PID: 128616 Comm: a.out Not tainted 6.8.0-rc6-std-de=
f-alt1 #1
>[ 1010.715899] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.=
16.0-alt1 04/01/2014
>[ 1010.715908] RIP: 0010:gtp_newlink+0x4d7/0x9c0 [gtp]
>[ 1010.715915] Code: 80 3c 02 00 0f 85 41 04 00 00 48 8b bb d8 05 00 00 e8=
 ed f6 ff ff 48 89 c2 48 89 c5 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <8=
0> 3c 02 00 0f 85 4f 04 00 00 4c 89 e2 4c 8b 6d 00 48 b8 00 00 00
>[ 1010.715920] RSP: 0018:ffff888020fbf180 EFLAGS: 00010203
>[ 1010.715929] RAX: dffffc0000000000 RBX: ffff88800399c000 RCX: 0000000000=
000000
>[ 1010.715933] RDX: 0000000000000001 RSI: ffffffff84805280 RDI: 0000000000=
000282
>[ 1010.715938] RBP: 000000000000000d R08: 0000000000000001 R09: 0000000000=
000000
>[ 1010.715942] R10: 0000000000000001 R11: 0000000000000001 R12: ffff888003=
99cc80
>[ 1010.715947] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000=
000400
>[ 1010.715953] FS:  00007fd1509ab5c0(0000) GS:ffff88805b300000(0000) knlGS=
:0000000000000000
>[ 1010.715958] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[ 1010.715962] CR2: 0000000000000000 CR3: 000000001c07a000 CR4: 0000000000=
750ee0
>[ 1010.715968] PKRU: 55555554
>[ 1010.715972] Call Trace:
>[ 1010.715985]  ? __die_body.cold+0x1a/0x1f
>[ 1010.715995]  ? die_addr+0x43/0x70
>[ 1010.716002]  ? exc_general_protection+0x199/0x2f0
>[ 1010.716016]  ? asm_exc_general_protection+0x1e/0x30
>[ 1010.716026]  ? gtp_newlink+0x4d7/0x9c0 [gtp]
>[ 1010.716034]  ? gtp_net_exit+0x150/0x150 [gtp]
>[ 1010.716042]  __rtnl_newlink+0x1063/0x1700
>[ 1010.716051]  ? rtnl_setlink+0x3c0/0x3c0
>[ 1010.716063]  ? is_bpf_text_address+0xc0/0x1f0
>[ 1010.716070]  ? kernel_text_address.part.0+0xbb/0xd0
>[ 1010.716076]  ? __kernel_text_address+0x56/0xa0
>[ 1010.716084]  ? unwind_get_return_address+0x5a/0xa0
>[ 1010.716091]  ? create_prof_cpu_mask+0x30/0x30
>[ 1010.716098]  ? arch_stack_walk+0x9e/0xf0
>[ 1010.716106]  ? stack_trace_save+0x91/0xd0
>[ 1010.716113]  ? stack_trace_consume_entry+0x170/0x170
>[ 1010.716121]  ? __lock_acquire+0x15c5/0x5380
>[ 1010.716139]  ? mark_held_locks+0x9e/0xe0
>[ 1010.716148]  ? kmem_cache_alloc_trace+0x35f/0x3c0
>[ 1010.716155]  ? __rtnl_newlink+0x1700/0x1700
>[ 1010.716160]  rtnl_newlink+0x69/0xa0
>[ 1010.716166]  rtnetlink_rcv_msg+0x43b/0xc50
>[ 1010.716172]  ? rtnl_fdb_dump+0x9f0/0x9f0
>[ 1010.716179]  ? lock_acquire+0x1fe/0x560
>[ 1010.716188]  ? netlink_deliver_tap+0x12f/0xd50
>[ 1010.716196]  netlink_rcv_skb+0x14d/0x440
>[ 1010.716202]  ? rtnl_fdb_dump+0x9f0/0x9f0
>[ 1010.716208]  ? netlink_ack+0xab0/0xab0
>[ 1010.716213]  ? netlink_deliver_tap+0x202/0xd50
>[ 1010.716220]  ? netlink_deliver_tap+0x218/0xd50
>[ 1010.716226]  ? __virt_addr_valid+0x30b/0x590
>[ 1010.716233]  netlink_unicast+0x54b/0x800
>[ 1010.716240]  ? netlink_attachskb+0x870/0x870
>[ 1010.716248]  ? __check_object_size+0x2de/0x3b0
>[ 1010.716254]  netlink_sendmsg+0x938/0xe40
>[ 1010.716261]  ? netlink_unicast+0x800/0x800
>[ 1010.716269]  ? __import_iovec+0x292/0x510
>[ 1010.716276]  ? netlink_unicast+0x800/0x800
>[ 1010.716284]  __sock_sendmsg+0x159/0x190
>[ 1010.716290]  ____sys_sendmsg+0x712/0x880
>[ 1010.716297]  ? sock_write_iter+0x3d0/0x3d0
>[ 1010.716304]  ? __ia32_sys_recvmmsg+0x270/0x270
>[ 1010.716309]  ? lock_acquire+0x1fe/0x560
>[ 1010.716315]  ? drain_array_locked+0x90/0x90
>[ 1010.716324]  ___sys_sendmsg+0xf8/0x170
>[ 1010.716331]  ? sendmsg_copy_msghdr+0x170/0x170
>[ 1010.716337]  ? lockdep_init_map_type+0x2c7/0x860
>[ 1010.716343]  ? lockdep_hardirqs_on_prepare+0x430/0x430
>[ 1010.716350]  ? debug_mutex_init+0x33/0x70
>[ 1010.716360]  ? percpu_counter_add_batch+0x8b/0x140
>[ 1010.716367]  ? lock_acquire+0x1fe/0x560
>[ 1010.716373]  ? find_held_lock+0x2c/0x110
>[ 1010.716384]  ? __fd_install+0x1b6/0x6f0
>[ 1010.716389]  ? lock_downgrade+0x810/0x810
>[ 1010.716396]  ? __fget_light+0x222/0x290
>[ 1010.716403]  __sys_sendmsg+0xea/0x1b0
>[ 1010.716409]  ? __sys_sendmsg_sock+0x40/0x40
>[ 1010.716419]  ? lockdep_hardirqs_on_prepare+0x2b3/0x430
>[ 1010.716425]  ? syscall_enter_from_user_mode+0x1d/0x60
>[ 1010.716432]  do_syscall_64+0x30/0x40
>[ 1010.716438]  entry_SYSCALL_64_after_hwframe+0x62/0xc7
>[ 1010.716444] RIP: 0033:0x7fd1508cbd49
>[ 1010.716452] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48=
 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <4=
8> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ef 70 0d 00 f7 d8 64 89 01 48
>[ 1010.716456] RSP: 002b:00007fff18872348 EFLAGS: 00000202 ORIG_RAX: 00000=
0000000002e
>[ 1010.716463] RAX: ffffffffffffffda RBX: 000055f72bf0eac0 RCX: 00007fd150=
8cbd49
>[ 1010.716468] RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000=
000006
>[ 1010.716473] RBP: 00007fff18872360 R08: 00007fff18872360 R09: 00007fff18=
872360
>[ 1010.716478] R10: 00007fff18872360 R11: 0000000000000202 R12: 000055f72b=
f0e1b0
>[ 1010.716482] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000=
000000
>[ 1010.716491] Modules linked in: gtp(+) udp_tunnel ib_core uinput af_pack=
et rfkill qrtr joydev hid_generic usbhid hid kvm_intel iTCO_wdt intel_pmc_b=
xt iTCO_vendor_support kvm snd_hda_codec_generic ledtrig_audio irqbypass cr=
ct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel snd_hda_intel =
nls_utf8 snd_intel_dspcfg nls_cp866 psmouse aesni_intel vfat crypto_simd fa=
t cryptd glue_helper snd_hda_codec pcspkr snd_hda_core i2c_i801 snd_hwdep i=
2c_smbus xhci_pci snd_pcm lpc_ich xhci_pci_renesas xhci_hcd qemu_fw_cfg tin=
y_power_button button sch_fq_codel vboxvideo drm_vram_helper drm_ttm_helper=
 ttm vboxsf vboxguest snd_seq_midi snd_seq_midi_event snd_seq snd_rawmidi s=
nd_seq_device snd_timer snd soundcore msr fuse efi_pstore dm_mod ip_tables =
x_tables autofs4 virtio_gpu virtio_dma_buf drm_kms_helper cec rc_core drm v=
irtio_rng virtio_scsi rng_core virtio_balloon virtio_blk virtio_net virtio_=
console net_failover failover ahci libahci libata evdev scsi_mod input_leds=
 serio_raw virtio_pci intel_agp
>[ 1010.716674]  virtio_ring intel_gtt virtio [last unloaded: gtp]
>[ 1010.716693] ---[ end trace 04990a4ce61e174b ]---
>
>Cc: stable@vger.kernel.org
>Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
>Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneli=
ng Protocol (GTP-U)")

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

