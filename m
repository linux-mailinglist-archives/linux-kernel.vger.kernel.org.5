Return-Path: <linux-kernel+bounces-163095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9538B6565
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E740B22BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A39C194C70;
	Mon, 29 Apr 2024 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qftsq9t3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1319069A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429040; cv=none; b=kAHCWesoJqNBg1j4rYLbFvFwJ1mYR1i+1ihEPqdSicLi+F/YZwktCUwabOvW9B1WtqAKUEG7WFmANzHq3EBny+8ltf0z5RAYIdEfyiQcHaok9u3r/RusyGAlTHLfB+PZBAq0iZ94PDSVysZ5YvgWLMaQXfY/PB4Itt6pnznm/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429040; c=relaxed/simple;
	bh=oBVqI12B9dk8m32PErPVKEZP3bzYUd+pYrIzHdiB2lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BJFuIy68NFD6MSmG6owtZIr3Ufg3r6IqWywSGQw9nfEcNNGoRxxRS+YH5VPO4/rSE7Q/N4JNSdbTDZT2rPwEEnt5hUU8AlOyv6v9sbXNwTnVVMDIuK+4skuKmNTqXerFsmChD5iIJLMmcip51AafR/pad2rz9sWGx/7huNXIhk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qftsq9t3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e5715a9ebdso41825255ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714429037; x=1715033837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EZhleW+Ps4WRPrVdrP1CYU/kHoFoEgDlGeETjkUbRe4=;
        b=Qftsq9t3NZOYf14vcLbiQBDNy0EF9D/rB4IsjR9DngDV9UpGa/preuRyujK090kw6N
         iPHd6AfYpeDbJZIfFf0YB7y8Fw0h4IN06DzDo7h+TQ7U1ZgNBJ19wSPM0jMVZbR+cFpu
         rYQBFMpA6Sfixi9iYoy2mMfeH6yIocNpGkUq52GDoH4rLSzDoVc+EYTbnmfLHwmlwNbo
         xh+4JSWKd3TLyWBJiblnWlDKI6B+kmIuGNjL5hHDsFzTZNGIjFl+j3z0QIMcHR2RwpYA
         Zv5MvKuTMYxtoVcLrinP0PK2+roue0Qpd5tnZTT+iyOiz8vy+7enOMElPVtkRDsPEyfp
         /VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714429037; x=1715033837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZhleW+Ps4WRPrVdrP1CYU/kHoFoEgDlGeETjkUbRe4=;
        b=p4UI3+5mDcn8wxGtlob3ihTj8S8CyGdD/POMpX2SPnscTCLy4G5j7aEOV8Q6d2perY
         9TTAXt+g0/jD0akpd6Dybqr94ebHhwQYyU+ag7mM8Ov3mvXjc5YC9RjBToiQmWZNMQJy
         2Z9bCDfeLXRWb2kXPuRUQq3j6fPYoMYCl58nYlSBEq0pYQrIpBOnljIXzUs/Zoo/Oeut
         JTFTmu+QSuP8HEe4gRcS0nmRPNtmavu3D7hJH7I1pJnqx4Dz5M5b0ui9BM36wkIVW4gD
         AAFJUzN/nTXr5BDOLWw+MbSKTVjy5F2JfZgA+o4iPlFG1GW+f+dQfeh7psPbhx7FUi3l
         /O7w==
X-Forwarded-Encrypted: i=1; AJvYcCX3Mmht8CDP4eTpHxxPCPjAuU25rllnURzfeXDBb3w9VIGwLft6FingIyhAGxLzRywF9g6V37vEblyjuQGT0zchqjQSHAKNTr5nlVT7
X-Gm-Message-State: AOJu0YwAKF6ZWI3jT8ysfpRIyjV8cfSSWzlZJKIzhKK+flz8+FFWM2in
	75gVw8eiFfxs8yyd+mjWSOj40i4zNbw4PB7fn3iS5faiStL9xGDUmPYleTlxNzY=
X-Google-Smtp-Source: AGHT+IH+MfK5HUbzYyMP7HAxYBTBpvjoDI8KPFVUXaywGlC17QuAZLhZK7OiLAHejhmAsM08nY+r9w==
X-Received: by 2002:a17:903:187:b0:1e5:a3b2:4ba3 with SMTP id z7-20020a170903018700b001e5a3b24ba3mr11936145plg.56.1714429036489;
        Mon, 29 Apr 2024 15:17:16 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00c:2308:970:8782:f539:c9c7])
        by smtp.gmail.com with ESMTPSA id i15-20020a170902c94f00b001eb30118300sm5713396pla.132.2024.04.29.15.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:17:16 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: lkft-triage@lists.linaro.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	dcaratti@redhat.com,
	cpaasch@apple.com,
	pabeni@redhat.com,
	xmu@redhat.com,
	maxim@isovalent.com,
	edumazet@google.com,
	anders.roxell@linaro.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: selftests: tc-testing: tdc.sh:  WARNING: at kernel/locking/lockdep.c:1226 lockdep_register_key
Date: Tue, 30 Apr 2024 03:47:06 +0530
Message-Id: <20240429221706.1492418-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While running selftests: tc-testing: tdc.sh the following kernel warnings,
kernel Bug, kernel oops and kernel panic noticed with Linux next-20240429
tag kernel as per the available data.

This build config is from kselftest merge config[1].

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

selftests: tc-testing: tdc.sh log and crash log
---------------

[ 1826.047350] kselftest: Running tests in tc-testing
TAP version 13
1..1
# timeout set to 900
# selftests: tc-testing: tdc.sh
# netdevsim
[ 1826.536738] Mirror/redirect action on
[ 1826.704305] Simple TC action Loaded
[ 1827.053726] u32 classifier
[ 1827.056463]     Performance counters on
[ 1827.060324]     input device check on
[ 1827.064007]     Actions configured
# Module em_ipset not found... skipping.
# em_ipt

<trim>

# sch_hhf
# sch_htb
# sch_teql
#  -- ns/SubPlugin.__init__
#  -- scapy/SubPlugin.__init__
# Executing 1099 tests in parallel and 60 in serial
# Using 36 batches and 4 workers
[ 1834.080968] tc (27632) used greatest stack depth: 9848 bytes left
[ 1844.138708] ------------[ cut here ]------------
[ 1844.143341] WARNING: CPU: 0 PID: 27197 at kernel/locking/lockdep.c:1226 lockdep_register_key (kernel/locking/lockdep.c:1226 (discriminator 1)) 
[ 1844.152735] Modules linked in: algif_hash sch_teql sch_htb sch_hhf sch_hfsc sch_gred sch_fq_pie sch_pie sch_ets sch_etf sch_drr sch_codel sch_choke sch_cbs sch_cake em_u32 em_text em_nbyte em_meta em_ipt em_cmp em_canid cls_u32 cls_route cls_matchall cls_flow cls_basic act_vlan act_tunnel_key act_skbmod act_skbedit act_simple act_sample act_police act_nat act_mpls act_mirred act_gate act_ctinfo act_ct nf_flow_table act_connmark act_csum act_pedit cls_fw xt_mark xt_length nft_compat nft_tproxy nf_tproxy_ipv6 nf_tproxy_ipv4 nft_socket nf_socket_ipv4 nf_socket_ipv6 nf_tables veth x86_pkg_temp_thermal fuse configfs
[ 1844.206814] CPU: 0 PID: 27197 Comm: python3 Not tainted 6.9.0-rc6-next-20240429 #1
[ 1844.214382] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS 2.7 12/07/2021
[ 1844.221774] RIP: 0010:lockdep_register_key (kernel/locking/lockdep.c:1226 (discriminator 1)) 
[ 1844.226826] Code: 0f 84 e3 00 00 00 4a 8b 04 e5 80 b1 bf 9f 48 85 c0 75 11 e9 a8 00 00 00 48 8b 00 48 85 c0 0f 84 9c 00 00 00 48 39 c3 75 ef 90 <0f> 0b 90 8b 3d 91 51 ad 04 85 ff 75 2c 9c 58 f6 c4 02 0f 85 ee 00
All code
========
   0:	0f 84 e3 00 00 00    	je     0xe9
   6:	4a 8b 04 e5 80 b1 bf 	mov    -0x60404e80(,%r12,8),%rax
   d:	9f 
   e:	48 85 c0             	test   %rax,%rax
  11:	75 11                	jne    0x24
  13:	e9 a8 00 00 00       	jmpq   0xc0
  18:	48 8b 00             	mov    (%rax),%rax
  1b:	48 85 c0             	test   %rax,%rax
  1e:	0f 84 9c 00 00 00    	je     0xc0
  24:	48 39 c3             	cmp    %rax,%rbx
  27:	75 ef                	jne    0x18
  29:	90                   	nop
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	90                   	nop
  2d:	8b 3d 91 51 ad 04    	mov    0x4ad5191(%rip),%edi        # 0x4ad51c4
  33:	85 ff                	test   %edi,%edi
  35:	75 2c                	jne    0x63
  37:	9c                   	pushfq 
  38:	58                   	pop    %rax
  39:	f6 c4 02             	test   $0x2,%ah
  3c:	0f                   	.byte 0xf
  3d:	85 ee                	test   %ebp,%esi
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	90                   	nop
   3:	8b 3d 91 51 ad 04    	mov    0x4ad5191(%rip),%edi        # 0x4ad519a
   9:	85 ff                	test   %edi,%edi
   b:	75 2c                	jne    0x39
   d:	9c                   	pushfq 
   e:	58                   	pop    %rax
   f:	f6 c4 02             	test   $0x2,%ah
  12:	0f                   	.byte 0xf
  13:	85 ee                	test   %ebp,%esi
	...
[ 1844.245573] RSP: 0018:ffffb881880734f8 EFLAGS: 00010046
[ 1844.250797] RAX: ffff9d321d473690 RBX: ffff9d321d473690 RCX: 0000000080000000
[ 1844.257923] RDX: 0000000000000001 RSI: ffffffff9b35030d RDI: ffffffff9b35030d
[ 1844.265053] RBP: ffffb88188073520 R08: 0000000000000001 R09: 00000000ffffffff
[ 1844.272203] R10: 0000000000000000 R11: 0000000000000001 R12: 000000000000078b
[ 1844.279329] R13: ffff9d32063c9d00 R14: 0000000000000206 R15: ffffffff9fbfedd8
[ 1844.286461] FS:  00007f751447b4c0(0000) GS:ffff9d3567a00000(0000) knlGS:0000000000000000
[ 1844.294546] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1844.300282] CR2: 00007f75135b0450 CR3: 00000001063d4006 CR4: 00000000003706f0
[ 1844.307408] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1844.314539] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1844.321664] Call Trace:
[ 1844.324108]  <TASK>
[ 1844.326205] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 1844.329613] ? __warn (kernel/panic.c:693) 
[ 1844.332844] ? lockdep_register_key (kernel/locking/lockdep.c:1226 (discriminator 1)) 
[ 1844.337291] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 1844.340957] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 1844.344449] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 1844.348288] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 1844.352478] ? __is_module_percpu_address (kernel/module/main.c:449 (discriminator 3)) 
[ 1844.357527] ? __is_module_percpu_address (kernel/module/main.c:449 (discriminator 3)) 
[ 1844.362580] ? lockdep_register_key (kernel/locking/lockdep.c:1226 (discriminator 1)) 
[ 1844.367053] qdisc_alloc (include/linux/spinlock.h:326 net/sched/sch_generic.c:949) 
[ 1844.370569] ? lock_acquire (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5756 (discriminator 4) kernel/locking/lockdep.c:5719 (discriminator 4)) 
[ 1844.374315] qdisc_create_dflt (net/sched/sch_generic.c:1003 (discriminator 1)) 
[ 1844.378327] dev_activate (net/sched/sch_generic.c:1169 include/linux/netdevice.h:2503 net/sched/sch_generic.c:1186 net/sched/sch_generic.c:1245) 
[ 1844.381995] __dev_open (net/core/dev.c:1468) 
[ 1844.385486] __dev_change_flags (net/core/dev.c:8763) 
[ 1844.389671] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:27) 
[ 1844.393686] dev_change_flags (net/core/dev.c:8836) 
[ 1844.397524] do_setlink (net/core/rtnetlink.c:2886) 
[ 1844.401106] ? stack_depot_save (lib/stackdepot.c:687) 
[ 1844.405116] ? __nla_validate_parse (include/net/netlink.h:1267 lib/nlattr.c:622) 
[ 1844.409560] ? rtnl_newlink (net/core/rtnetlink.c:3724) 
[ 1844.413218] ? rtnetlink_rcv_msg (net/core/rtnetlink.c:6594) 
[ 1844.417489] ? netlink_rcv_skb (net/netlink/af_netlink.c:2564) 
[ 1844.421493] ? rtnetlink_rcv (net/core/rtnetlink.c:6613) 
[ 1844.425238] ? netlink_unicast (net/netlink/af_netlink.c:1335 net/netlink/af_netlink.c:1361) 
[ 1844.429329] ? netlink_sendmsg (net/netlink/af_netlink.c:1905) 
[ 1844.433419] ? __sys_sendto (net/socket.c:730 (discriminator 1) net/socket.c:745 (discriminator 1) net/socket.c:2191 (discriminator 1)) 
[ 1844.437259] ? __x64_sys_sendto (net/socket.c:2199) 
[ 1844.441272] ? x64_sys_call (arch/x86/entry/syscall_64.c:33) 
[ 1844.445290] __rtnl_newlink (net/core/rtnetlink.c:3680) 
[ 1844.449138] ? preempt_count_sub (kernel/sched/core.c:5889 kernel/sched/core.c:5885 kernel/sched/core.c:5907) 
[ 1844.453243] rtnl_newlink (net/core/rtnetlink.c:3728) 
[ 1844.456733] rtnetlink_rcv_msg (net/core/rtnetlink.c:6594) 
[ 1844.460835] ? __pfx_rtnetlink_rcv_msg (net/core/rtnetlink.c:6488) 
[ 1844.465452] netlink_rcv_skb (net/netlink/af_netlink.c:2564) 
[ 1844.469287] rtnetlink_rcv (net/core/rtnetlink.c:6613) 
[ 1844.472863] netlink_unicast (net/netlink/af_netlink.c:1335 net/netlink/af_netlink.c:1361) 
[ 1844.476788] netlink_sendmsg (net/netlink/af_netlink.c:1905) 
[ 1844.480718] __sys_sendto (net/socket.c:730 (discriminator 1) net/socket.c:745 (discriminator 1) net/socket.c:2191 (discriminator 1)) 
[ 1844.484397] __x64_sys_sendto (net/socket.c:2199) 
[ 1844.488246] x64_sys_call (arch/x86/entry/syscall_64.c:33) 
[ 1844.492083] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
[ 1844.495747] ? trace_napi_poll (include/trace/events/napi.h:14 (discriminator 2)) 
[ 1844.499677] ? __napi_poll.constprop.0 (net/core/dev.c:6714 (discriminator 1)) 
[ 1844.504382] ? net_rx_action (net/core/dev.c:6777 net/core/dev.c:6893) 
[ 1844.508311] ? trace_preempt_on (kernel/trace/trace_preemptirq.c:105) 
[ 1844.512320] ? __do_softirq (kernel/softirq.c:401 (discriminator 2) kernel/softirq.c:583 (discriminator 2)) 
[ 1844.516159] ? __local_bh_enable (kernel/softirq.c:343 (discriminator 1)) 
[ 1844.520262] ? irqentry_exit_to_user_mode (kernel/entry/common.c:234) 
[ 1844.525227] ? irqentry_exit (kernel/entry/common.c:367) 
[ 1844.528978] ? common_interrupt (arch/x86/kernel/irq.c:247) 
[ 1844.532990] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[ 1844.538050] RIP: 0033:0x7f7514586b93
[ 1844.541658] Code: 8b 15 71 72 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 80 3d 51 fa 0c 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
All code
========
   0:	8b 15 71 72 0c 00    	mov    0xc7271(%rip),%edx        # 0xc7277
   6:	f7 d8                	neg    %eax
   8:	64 89 02             	mov    %eax,%fs:(%rdx)
   b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  12:	eb b8                	jmp    0xffffffffffffffcc
  14:	0f 1f 00             	nopl   (%rax)
  17:	80 3d 51 fa 0c 00 00 	cmpb   $0x0,0xcfa51(%rip)        # 0xcfa6f
  1e:	41 89 ca             	mov    %ecx,%r10d
  21:	74 14                	je     0x37
  23:	b8 2c 00 00 00       	mov    $0x2c,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 75                	ja     0xa7
  32:	c3                   	retq   
  33:	0f 1f 40 00          	nopl   0x0(%rax)
  37:	55                   	push   %rbp
  38:	48 83 ec 30          	sub    $0x30,%rsp
  3c:	44                   	rex.R
  3d:	89                   	.byte 0x89
  3e:	4c                   	rex.WR
  3f:	24                   	.byte 0x24

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 75                	ja     0x7d
   8:	c3                   	retq   
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	55                   	push   %rbp
   e:	48 83 ec 30          	sub    $0x30,%rsp
  12:	44                   	rex.R
  13:	89                   	.byte 0x89
  14:	4c                   	rex.WR
  15:	24                   	.byte 0x24
[ 1844.560401] RSP: 002b:00007ffc23a81e48 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[ 1844.567970] RAX: ffffffffffffffda RBX: 00007ffc23a81ef8 RCX: 00007f7514586b93
[ 1844.575101] RDX: 0000000000000020 RSI: 00007f7511b49260 RDI: 0000000000000010
[ 1844.582224] RBP: 0000000000000000 R08: 00007ffc23a81f70 R09: 000000000000000c
[ 1844.589349] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[ 1844.596474] R13: ffffffffc4653600 R14: 0000000000000000 R15: 0000000000000000
[ 1844.603612]  </TASK>
[ 1844.605799] irq event stamp: 224795
[ 1844.609292] hardirqs last enabled at (224795): _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 1844.618937] hardirqs last disabled at (224794): _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:108 (discriminator 1) kernel/locking/spinlock.c:162 (discriminator 1)) 
[ 1844.628150] softirqs last enabled at (224790): __dev_open (net/core/dev.c:1467) 
[ 1844.636495] softirqs last disabled at (224788): __dev_open (include/linux/bottom_half.h:20 (discriminator 1) include/linux/netdevice.h:4497 (discriminator 1) net/core/dev.c:8689 (discriminator 1) net/core/dev.c:1466 (discriminator 1)) 
[ 1844.644843] ---[ end trace 0000000000000000 ]---
[ 1846.004811] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1846.011772] #PF: supervisor write access in kernel mode
[ 1846.016998] #PF: error_code(0x0002) - not-present page
[ 1846.022131] PGD 0 P4D 0
[ 1846.024670] Oops: Oops: 0002 [#1] PREEMPT SMP PTI
[ 1846.029375] CPU: 0 PID: 23358 Comm: kworker/u16:5 Tainted: G        W          6.9.0-rc6-next-20240429 #1
[ 1846.038933] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS 2.7 12/07/2021
[ 1846.046318] Workqueue: netns cleanup_net
[ 1846.050244] RIP: 0010:lockdep_unregister_key (include/linux/list.h:988 (discriminator 2) include/linux/rculist.h:513 (discriminator 2) kernel/locking/lockdep.c:6460 (discriminator 2)) 
[ 1846.055469] Code: c0 4c 89 2d f1 41 ad 04 75 11 e9 f5 00 00 00 48 8b 00 48 85 c0 0f 84 e9 00 00 00 48 39 c3 75 ef 48 8b 10 48 8b 48 08 48 85 d2 <48> 89 11 74 04 48 89 4a 08 48 b9 22 01 00 00 00 00 ad de ba 01 00
All code
========
   0:	c0 4c 89 2d f1       	rorb   $0xf1,0x2d(%rcx,%rcx,4)
   5:	41 ad                	rex.B lods %ds:(%rsi),%eax
   7:	04 75                	add    $0x75,%al
   9:	11 e9                	adc    %ebp,%ecx
   b:	f5                   	cmc    
   c:	00 00                	add    %al,(%rax)
   e:	00 48 8b             	add    %cl,-0x75(%rax)
  11:	00 48 85             	add    %cl,-0x7b(%rax)
  14:	c0 0f 84             	rorb   $0x84,(%rdi)
  17:	e9 00 00 00 48       	jmpq   0x4800001c
  1c:	39 c3                	cmp    %eax,%ebx
  1e:	75 ef                	jne    0xf
  20:	48 8b 10             	mov    (%rax),%rdx
  23:	48 8b 48 08          	mov    0x8(%rax),%rcx
  27:	48 85 d2             	test   %rdx,%rdx
  2a:*	48 89 11             	mov    %rdx,(%rcx)		<-- trapping instruction
  2d:	74 04                	je     0x33
  2f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  33:	48 b9 22 01 00 00 00 	movabs $0xdead000000000122,%rcx
  3a:	00 ad de 
  3d:	ba                   	.byte 0xba
  3e:	01 00                	add    %eax,(%rax)

Code starting with the faulting instruction
===========================================
   0:	48 89 11             	mov    %rdx,(%rcx)
   3:	74 04                	je     0x9
   5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   9:	48 b9 22 01 00 00 00 	movabs $0xdead000000000122,%rcx
  10:	00 ad de 
  13:	ba                   	.byte 0xba
  14:	01 00                	add    %eax,(%rax)
[ 1846.074217] RSP: 0018:ffffb88184affbd8 EFLAGS: 00010046
[ 1846.079442] RAX: ffff9d321d473690 RBX: ffff9d321d473690 RCX: 0000000000000000
[ 1846.086573] RDX: 0000000000000000 RSI: ffffffff9b35030d RDI: ffffffff9b35030d
[ 1846.093699] RBP: ffffb88184affbf8 R08: 0000000000000001 R09: 0000000000000004
[ 1846.100831] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000078b
[ 1846.107964] R13: ffff9d3204285680 R14: 0000000000000246 R15: ffff9d321d4b9000
[ 1846.115097] FS:  0000000000000000(0000) GS:ffff9d3567a00000(0000) knlGS:0000000000000000
[ 1846.123183] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1846.128927] CR2: 0000000000000000 CR3: 00000001158be005 CR4: 00000000003706f0
[ 1846.136065] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1846.143220] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1846.150352] Call Trace:
[ 1846.152796]  <TASK>
[ 1846.154895] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 1846.158301] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 1846.161360] ? page_fault_oops (arch/x86/mm/fault.c:715) 
[ 1846.165463] ? do_user_addr_fault (arch/x86/mm/fault.c:1267) 
[ 1846.169826] ? trace_irq_disable (include/trace/events/preemptirq.h:36 (discriminator 2)) 
[ 1846.173926] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1520 arch/x86/mm/fault.c:1570) 
[ 1846.177853] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 1846.182067] ? __is_module_percpu_address (kernel/module/main.c:449 (discriminator 3)) 
[ 1846.187141] ? __is_module_percpu_address (kernel/module/main.c:449 (discriminator 3)) 
[ 1846.192196] ? lockdep_unregister_key (include/linux/list.h:988 (discriminator 2) include/linux/rculist.h:513 (discriminator 2) kernel/locking/lockdep.c:6460 (discriminator 2)) 
[ 1846.196815] __qdisc_destroy (net/sched/sch_generic.c:1074) 
[ 1846.200653] qdisc_put (net/sched/sch_generic.c:1100) 
[ 1846.203884] shutdown_scheduler_queue (net/sched/sch_generic.c:1154) 
[ 1846.208418] dev_shutdown (include/linux/netdevice.h:2502 (discriminator 1) net/sched/sch_generic.c:1484 (discriminator 1)) 
[ 1846.211998] unregister_netdevice_many_notify (include/net/tcx.h:169 net/core/dev.c:11196) 
[ 1846.217401] default_device_exit_batch (net/core/dev.c:11743) 
[ 1846.222201] ops_exit_list (net/core/net_namespace.c:175) 
[ 1846.225778] cleanup_net (net/core/net_namespace.c:636 (discriminator 3)) 
[ 1846.229358] process_one_work (kernel/workqueue.c:3222) 
[ 1846.233373] worker_thread (kernel/workqueue.c:3297 (discriminator 2) kernel/workqueue.c:3384 (discriminator 2)) 
[ 1846.237122] ? __pfx_worker_thread (kernel/workqueue.c:3330) 
[ 1846.241395] kthread (kernel/kthread.c:389) 
[ 1846.244540] ? __pfx_kthread (kernel/kthread.c:342) 
[ 1846.248294] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 1846.251872] ? __pfx_kthread (kernel/kthread.c:342) 
[ 1846.255627] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[ 1846.259557]  </TASK>
[ 1846.261751] Modules linked in: algif_hash sch_teql sch_htb sch_hhf sch_hfsc sch_gred sch_fq_pie sch_pie sch_ets sch_etf sch_drr sch_codel sch_choke sch_cbs sch_cake em_u32 em_text em_nbyte em_meta em_ipt em_cmp em_canid cls_u32 cls_route cls_matchall cls_flow cls_basic act_vlan act_tunnel_key act_skbmod act_skbedit act_simple act_sample act_police act_nat act_mpls act_mirred act_gate act_ctinfo act_ct nf_flow_table act_connmark act_csum act_pedit cls_fw xt_mark xt_length nft_compat nft_tproxy nf_tproxy_ipv6 nf_tproxy_ipv4 nft_socket nf_socket_ipv4 nf_socket_ipv6 nf_tables veth x86_pkg_temp_thermal fuse configfs
[ 1846.315824] CR2: 0000000000000000
[ 1846.319135] ---[ end trace 0000000000000000 ]---
[ 1846.323752] RIP: 0010:lockdep_unregister_key (include/linux/list.h:988 (discriminator 2) include/linux/rculist.h:513 (discriminator 2) kernel/locking/lockdep.c:6460 (discriminator 2)) 
[ 1846.328980] Code: c0 4c 89 2d f1 41 ad 04 75 11 e9 f5 00 00 00 48 8b 00 48 85 c0 0f 84 e9 00 00 00 48 39 c3 75 ef 48 8b 10 48 8b 48 08 48 85 d2 <48> 89 11 74 04 48 89 4a 08 48 b9 22 01 00 00 00 00 ad de ba 01 00
All code
========
   0:	c0 4c 89 2d f1       	rorb   $0xf1,0x2d(%rcx,%rcx,4)
   5:	41 ad                	rex.B lods %ds:(%rsi),%eax
   7:	04 75                	add    $0x75,%al
   9:	11 e9                	adc    %ebp,%ecx
   b:	f5                   	cmc    
   c:	00 00                	add    %al,(%rax)
   e:	00 48 8b             	add    %cl,-0x75(%rax)
  11:	00 48 85             	add    %cl,-0x7b(%rax)
  14:	c0 0f 84             	rorb   $0x84,(%rdi)
  17:	e9 00 00 00 48       	jmpq   0x4800001c
  1c:	39 c3                	cmp    %eax,%ebx
  1e:	75 ef                	jne    0xf
  20:	48 8b 10             	mov    (%rax),%rdx
  23:	48 8b 48 08          	mov    0x8(%rax),%rcx
  27:	48 85 d2             	test   %rdx,%rdx
  2a:*	48 89 11             	mov    %rdx,(%rcx)		<-- trapping instruction
  2d:	74 04                	je     0x33
  2f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  33:	48 b9 22 01 00 00 00 	movabs $0xdead000000000122,%rcx
  3a:	00 ad de 
  3d:	ba                   	.byte 0xba
  3e:	01 00                	add    %eax,(%rax)

Code starting with the faulting instruction
===========================================
   0:	48 89 11             	mov    %rdx,(%rcx)
   3:	74 04                	je     0x9
   5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   9:	48 b9 22 01 00 00 00 	movabs $0xdead000000000122,%rcx
  10:	00 ad de 
  13:	ba                   	.byte 0xba
  14:	01 00                	add    %eax,(%rax)
[ 1846.347724] RSP: 0018:ffffb88184affbd8 EFLAGS: 00010046
[ 1846.352952] RAX: ffff9d321d473690 RBX: ffff9d321d473690 RCX: 0000000000000000
[ 1846.360094] RDX: 0000000000000000 RSI: ffffffff9b35030d RDI: ffffffff9b35030d
[ 1846.367226] RBP: ffffb88184affbf8 R08: 0000000000000001 R09: 0000000000000004
[ 1846.374358] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000078b
[ 1846.381491] R13: ffff9d3204285680 R14: 0000000000000246 R15: ffff9d321d4b9000
[ 1846.388623] FS:  0000000000000000(0000) GS:ffff9d3567a00000(0000) knlGS:0000000000000000
[ 1846.396708] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1846.402445] CR2: 0000000000000000 CR3: 00000001158be005 CR4: 00000000003706f0
[ 1846.409569] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1846.416693] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1846.423818] Kernel panic - not syncing: Fatal exception
[ 1846.429068] Kernel Offset: 0x1a000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1846.439851] ---[ end Kernel panic - not syncing: Fatal exception ]---


metadata:
---
git_ref: master
git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
git_sha: b0a2c79c6f3590b74742cbbc76687014d47972d8
git_describe: next-20240429
kernel_version: 6.9.0-rc6
kernel-config:
[1]  https://storage.tuxsuite.com/public/linaro/lkft/builds/2flbq1tpkBZoI95SsSfbE7zCTse/config

Links:
---
- Test log: https://lkft.validation.linaro.org/scheduler/job/7524858#L1919
- Build: https://storage.tuxsuite.com/public/linaro/lkft/builds/2flbq1tpkBZoI95SsSfbE7zCTse/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240429/testrun/23711809/suite/log-parser-test/tests/

--
Linaro LKFT
https://lkft.linaro.org

