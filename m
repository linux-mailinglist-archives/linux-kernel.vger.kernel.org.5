Return-Path: <linux-kernel+bounces-51424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC26848B10
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0FCB22255
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D806C567D;
	Sun,  4 Feb 2024 04:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB5bylwV"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD07465;
	Sun,  4 Feb 2024 04:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707021807; cv=none; b=he9gh9a9JuqFvI9/Pig7vQ1mHe7QoCPFYHVIe7A7bg5zKJ2azXyh6sbLHSKmjVVUOK0f+nCHjke4cwvW5tu/ViYQVO4sueraML5UOGM8FbAvmJFYaysdBDdhXF2fwcHQQYo3QZc2SHcQHyrfQ9I0cdc9U3oVseZkCobUTdtjWHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707021807; c=relaxed/simple;
	bh=MhG1u2KwcRXQB60CoVgu2vlfbo2nYRBz9tNq8Go3+YA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TfGk9aSgZnDFiJxxJ7uUteUHPtZk/lsmX3b8qtDy7u0eCAM+5y4VwwpMAQ3IdWMMdhsboe1MlAk4y7MWFIyvps3W5woWe5UCxVdlRyhVUZ6K3xwL40Zu9kiTmzRuNuTGf6mo005KevgZktTmK+lij1P221DHIGlWG+vvjWurkfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB5bylwV; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5600f79607eso1257214a12.0;
        Sat, 03 Feb 2024 20:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707021803; x=1707626603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q3kBtxxL4VO3WYdtIvm8IZkFAj2RFAPSHZXFLvTp7QI=;
        b=IB5bylwVdSd8btI/+C7xZFfkOEP3VXJcgUxZArKHwbB89Q5I9JAnxkwTB7Z0ARTiwM
         R0hRNtHmfocc1cdeZdXl5gCdC1nuAU96+DRzok9rMhMfQA23VYzCjL3NkcbdebiJJdP/
         skpqZ1MLWYPzCQm+iZy/zlrtXCF30wDFyRfmLSkmhDdRBwVO9ELqe3X1aSEiYN/1FkLD
         Z/KRa7fTImYgKE19y0/UZmvCqGPPJmN6RomRHarpfDGJ35X31bC+IATUKIH1MZLANTfm
         ztjTwZxGk0eYvUnK2nVq7FgUQtlnQQB0TcZDU1LugglXVVIM/CDi6RArN+07ccrjRNmr
         DonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707021803; x=1707626603;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3kBtxxL4VO3WYdtIvm8IZkFAj2RFAPSHZXFLvTp7QI=;
        b=AfUpmSef/nvQteMoU0k2AgQBO1OQHgxlfKoLMjiXD33/Yk8JHVkyn1HIHilhi2vRwK
         Iz5gXaa/0D4CI613Nph5ECqk/DWFb51N8MnrH+LWQh1izK58HjjunxIU18rWVvHPE0AG
         P1jzHn78XB3tarPJrqMohP9TBiREYfuxIp9xwfs0b2ZQdJsTJkaLlyTOU/JzKzOOCmHE
         yyUA0Ujx1K88UvP8LPMgEAH4qCaSEhvFT40JZdsYGJMAP1MEwZTsRNWkCLdGvP7yCqzI
         vKCZU6dbLfKsGe2Rh4YJh9HSyPhMvlHSVoUvT8BMT96Tmzez0aNLLCJe9lpRyEAjMwVE
         tytA==
X-Gm-Message-State: AOJu0Yw8YCaT39T4ciFYF5Yt3RpgG/gtBWwbiz8udWXuHwE6VwSa6Ddv
	C79IcJD4DSm7exYcryioIB0+x6hV9QSqvc8dlXPFsZ+rLIbF0rHUJ1828x4wx5EwYjrxghFL1K8
	Hcm21EFEJeoa41uJV9e5f6loxjut6vThfRTMARQ==
X-Google-Smtp-Source: AGHT+IGVfFEqhuH2lesZXMAW+oN7+ske2gC+okX7GaHk6yZD6onVD0CaPVwFwaK9EXd9cSmAgUVw1VgwYCJ3oEMoNK4=
X-Received: by 2002:a05:6402:31a2:b0:560:56a3:6ef4 with SMTP id
 dj2-20020a05640231a200b0056056a36ef4mr44606edb.26.1707021802937; Sat, 03 Feb
 2024 20:43:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0KHRgtCw0YEg0J3QuNGH0LjQv9C+0YDQvtCy0LjRhw==?= <stasn77@gmail.com>
Date: Sun, 4 Feb 2024 07:43:24 +0300
Message-ID: <CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-ddMYHSw4wK0Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After trying again to create the ipset with timeout option I get a kernel panic
# ipset create throttled-ips hash:ip family inet hashsize 1024 maxelem
100000 timeout 600 bucketsize 12 initval 0x22b96e3a
ipset v7.20: Set cannot be created: set with the same name already exists


[Sat Feb  3 21:51:43 2024] Kernel 6.6.16- started...
[Sat Feb  3 21:51:44 2024] ------------[ cut here ]------------
[Sat Feb  3 21:51:44 2024] WARNING: CPU: 0 PID: 0 at
__run_timers.part.0+0x45d/0x570
[Sat Feb  3 21:51:44 2024] Modules linked in: netconsole configfs
xt_multiport xt_HL xt_TCPMSS xt_tcpudp xt_comment xt_mark
iptable_mangle iptable_raw iptable_filter xt_MASQUERADE xt_set
iptable_nat nfnetlink_cttimeout nfnetlink_log ip_set_list_set
ip_set_hash_ipport ip_set_hash_ip ip_set_hash_netiface ip_set_hash_net
ip_set nf_nat_sip nf_nat_ftp nf_nat_tftp nf_nat_irc nf_nat_amanda
nf_nat_h323 nf_nat_snmp_basic asn1_decoder nf_nat_pptp nf_nat
nf_conntrack_irc nf_conntrack_snmp nf_conntrack_netbios_ns
nf_conntrack_broadcast nf_conntrack_sip nf_conntrack_tftp
nf_conntrack_pptp ts_kmp nf_conntrack_amanda nf_conntrack_sane
nf_conntrack_h323 xt_conntrack nf_conntrack_ftp xt_dns(O)
nf_conntrack_netlink nfnetlink ipt_NETFLOW(O) ip6_tables ip_tables
xt_ndpi(O) xt_RATELIMIT(O) nf_conntrack_rtcache nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c crc32c_generic crc32c_intel
x_tables vrf sha1_ssse3 sha1_generic hmac ipv6 ixgbevf ixgbe mdio
mdio_devres libphy ifb virtio_rng rng_core button
[Sat Feb  3 21:51:44 2024] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G
       O       6.6.16- #12
[Sat Feb  3 21:51:44 2024] RIP: 0010:__run_timers.part.0+0x45d/0x570
[Sat Feb  3 21:51:44 2024] Code: 21 0d f5 7e 89 ca 89 c8 81 e2 00 00
00 80 44 09 f2 65 0f b1 15 0c 0d f5 7e 39 c1 75 e0 48 89 df e8 38 b0
48 00 e9 53 ff ff ff <0f> 0b e9 4c ff ff ff 44 89 f2 4c 89 fe 48 c7 c7
e0 9a 8f 81 c6 05
[Sat Feb  3 21:51:44 2024] RSP: 0018:ffff88807d805f20 EFLAGS: 00010046
[Sat Feb  3 21:51:44 2024] RAX: 0000000000000000 RBX: ffff88807d81c9c0
RCX: ffff88807d805f20
[Sat Feb  3 21:51:44 2024] RDX: ffff888003207768 RSI: 00000000000000a5
RDI: ffff88807d81c9e8
[Sat Feb  3 21:51:44 2024] RBP: ffff88807d805f20 R08: 0000000003ffeee2
R09: 7fffffffffffffff
[Sat Feb  3 21:51:44 2024] R10: ffffffff81a050c0 R11: 0000000000000082
R12: dead000000000122
[Sat Feb  3 21:51:44 2024] R13: 0000000000000000 R14: ffffffff81a050c8
R15: 0000000000000000
[Sat Feb  3 21:51:44 2024] FS:  0000000000000000(0000)
GS:ffff88807d800000(0000) knlGS:0000000000000000
[Sat Feb  3 21:51:44 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Sat Feb  3 21:51:44 2024] CR2: 00007fb98e5e95b0 CR3: 0000000001a12003
CR4: 00000000001706b0
[Sat Feb  3 21:51:44 2024] Call Trace:
[Sat Feb  3 21:51:44 2024]  <IRQ>
[Sat Feb  3 21:51:44 2024]  ? __warn+0x6c/0x130
[Sat Feb  3 21:51:44 2024]  ? report_bug+0x136/0x1b0
[Sat Feb  3 21:51:44 2024]  ? handle_bug+0x36/0x70
[Sat Feb  3 21:51:44 2024]  ? exc_invalid_op+0x17/0x1a0
[Sat Feb  3 21:51:44 2024]  ? asm_exc_invalid_op+0x16/0x20
[Sat Feb  3 21:51:44 2024]  ? __run_timers.part.0+0x45d/0x570
[Sat Feb  3 21:51:44 2024]  ? ktime_get+0x30/0x90
[Sat Feb  3 21:51:44 2024]  ? clockevents_program_event+0x76/0xd0
[Sat Feb  3 21:51:44 2024]  __do_softirq+0xb4/0x1e8
[Sat Feb  3 21:51:44 2024]  irq_exit_rcu+0x5d/0x80
[Sat Feb  3 21:51:44 2024]  sysvec_apic_timer_interrupt+0x66/0x80
[Sat Feb  3 21:51:44 2024]  </IRQ>
[Sat Feb  3 21:51:44 2024]  <TASK>
[Sat Feb  3 21:51:44 2024]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[Sat Feb  3 21:51:44 2024] RIP: 0010:default_idle+0xb/0x10
[Sat Feb  3 21:51:44 2024] Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00
00 4d 29 c8 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc eb 07 0f 00
2d 47 27 2b 00 fb f4 <fa> c3 0f 1f 00 65 48 8b 04 25 c0 10 02 00 f0 80
48 02 20 48 8b 10
[Sat Feb  3 21:51:44 2024] RSP: 0018:ffffffff81a03eb0 EFLAGS: 00000206
[Sat Feb  3 21:51:44 2024] RAX: ffff88807d81fa80 RBX: 0000000000000000
RCX: 4000000000000000
[Sat Feb  3 21:51:44 2024] RDX: 0000000000000000 RSI: 0000000000000000
RDI: 00000000000d8494
[Sat Feb  3 21:51:44 2024] RBP: ffffffff81a08a40 R08: 0000000000000001
R09: 0000000000000000
[Sat Feb  3 21:51:44 2024] R10: 0000000000100000 R11: 000000000122662f
R12: ffffffff81a08a40
[Sat Feb  3 21:51:44 2024] R13: ffff88807ffda040 R14: ffffffff81a085e0
R15: 0000000000013c70
[Sat Feb  3 21:51:44 2024]  default_idle_call+0x1f/0x26
[Sat Feb  3 21:51:44 2024]  do_idle+0x92/0xf0
[Sat Feb  3 21:51:44 2024]  cpu_startup_entry+0x21/0x30
[Sat Feb  3 21:51:44 2024]  rest_init+0x9e/0xa0
[Sat Feb  3 21:51:44 2024]  arch_call_rest_init+0x5/0x20
[Sat Feb  3 21:51:44 2024]  start_kernel+0x3f3/0x460
[Sat Feb  3 21:51:44 2024]  x86_64_start_reservations+0x14/0x30
[Sat Feb  3 21:51:44 2024]  x86_64_start_kernel+0xa9/0xc0
[Sat Feb  3 21:51:44 2024]  secondary_startup_64_no_verify+0x174/0x17b
[Sat Feb  3 21:51:44 2024]  </TASK>
[Sat Feb  3 21:51:44 2024] ---[ end trace 0000000000000000 ]---


reverting netfilter-ipset-fix-performance-regression-in-swap-o.patch
fixes panic.

