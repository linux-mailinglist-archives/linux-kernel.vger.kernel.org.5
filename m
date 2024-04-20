Return-Path: <linux-kernel+bounces-152153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE9A8AB9F0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A931F213B3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CEE10799;
	Sat, 20 Apr 2024 05:59:23 +0000 (UTC)
Received: from out28-82.mail.aliyun.com (out28-82.mail.aliyun.com [115.124.28.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C8205E26;
	Sat, 20 Apr 2024 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713592762; cv=none; b=D59BDgHm174Eu91c6zvhYi14+f/tb34sO+kEvO8/PA8dM6KgmiOAU+HyHfIgGCdPZ2ZXFAFBSwjGJLnJPzKlfTHvXU89hPr5F5G2YzdBnhnLmvZoG7/G+AOnX4O3JiEwFkrstd1PWbz0L6q6GxdBElw7RoU0zdmvQxUwQp9wfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713592762; c=relaxed/simple;
	bh=L7LEAeeFi76tapTFaoihau6WO33yqYq/UdxRKzuYYNs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=DwZYrKbX+pm7xcESRLY1fVTpiK947BH3VQRI2xG1OkjV+fNOpoiLJyy+05cqvvvtm3wtNe5Rcl0hEPKV/g7XQ5wgWsH/Hl/MrOt7BgM5aHfCJVQnMt5BH7ScJKU2KbB6RMyNJPK8apyQsmOU98tA+T7VAfUdHhz4bKrz0fAqOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04437548|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0029862-0.00172556-0.995288;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.XGdcklp_1713592747;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.XGdcklp_1713592747)
          by smtp.aliyun-inc.com;
          Sat, 20 Apr 2024 13:59:08 +0800
Date: Sat, 20 Apr 2024 13:59:15 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shay Drory <shayd@nvidia.com>
Subject: Re: Linux 6.6.28
Cc: linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org,
 torvalds@linux-foundation.org,
 stable@vger.kernel.org,
 lwn@lwn.net,
 jslaby@suse.cz
In-Reply-To: <2024041758-unvaried-agreement-8d7b@gregkh>
References: <2024041758-unvaried-agreement-8d7b@gregkh>
Message-Id: <20240420135914.2AD9.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Becky! ver. 2.81.06 [en]

Hi,

> I'm announcing the release of the 6.6.28 kernel.
>=20
> All users of the 6.6 kernel series must upgrade.
>=20
> The updated 6.6.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git li=
nux-6.6.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=
=3Dsummary

Linux 6.6.28 failed to boot with the following panic *1 on a server with
mellonax CX-6 VPI NIC, but 6.6.27/6.1.87 boot well.

After reverting 'net/mlx5: Restore mistakenly dropped parts in register dev=
link
flow', linux boot well.

There is already a patch(*2 ) in upstream, but yet not in queue-6.6(for the
coming 6.6.29).


*1 panic info:
[   15.114364] BUG: unable to handle page fault for address: 00000000000011=
18
[   15.114815] infiniband bnxt_re0: Device registered with IB successfully
[   15.114822] #PF: supervisor read access in kernel mode
[   15.134119] #PF: error_code(0x0000) - not-present page
[   15.139652] PGD 0 P4D 0
[   15.142553] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   15.143055] infiniband bnxt_re1: Device registered with IB successfully
[   15.147233] CPU: 1 PID: 1253 Comm: kworker/1:4 Not tainted 6.6.28-1.el7.=
x86_64 #1
[   15.147236] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.21.0 =
12/11/2023
[   15.147238] Workqueue: events work_for_cpu_fn
[   15.174498] RIP: 0010:esw_port_metadata_get+0x19/0x30 [mlx5_core]
[   15.181056] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 =
0f 1e fa 0f 1f 44 00 00 53 48 89 d3 e8 ce 28 9a cc 48 8b 80 b0 09 00 00 <8b=
> 80 18 11 00 00 88 03 31 c0 80 23 01 5b c3 cc cc cc cc 0f 1f 40
[   15.200401] RSP: 0000:ffff9ec05bf1fb98 EFLAGS: 00010286
[   15.205930] RAX: 0000000000000000 RBX: ffff9ec05bf1fbe4 RCX: 00000000000=
00028
[   15.213364] RDX: ffff9ec05bf1fbe4 RSI: 0000000000000013 RDI: ffff8bdd1d6=
96000
[   15.220801] RBP: ffffffffc1134c60 R08: 0000000000000000 R09: 00000000000=
00000
[   15.228235] R10: ffff9ec05bf1fbf8 R11: 0000000000001000 R12: ffff8bdd1d6=
96000
[   15.235671] R13: ffff8bdd9541c720 R14: 0000000000000000 R15: 00000000000=
00000
[   15.243098] FS:  0000000000000000(0000) GS:ffff8c3b7ea00000(0000) knlGS:=
0000000000000000
[   15.251480] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.257520] CR2: 0000000000001118 CR3: 00000004f9220003 CR4: 00000000007=
706e0
[   15.264955] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   15.272383] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   15.279800] PKRU: 55555554
[   15.282790] Call Trace:
[   15.285523]  <TASK>
[   15.287905]  ? __die_body+0x1e/0x60
[   15.291675]  ? page_fault_oops+0x151/0x490
[   15.296050]  ? __update_idle_core+0x27/0xc0
[   15.300505]  ? exc_page_fault+0x6b/0x150
[   15.304700]  ? asm_exc_page_fault+0x26/0x30
[   15.309149]  ? esw_port_metadata_get+0x19/0x30 [mlx5_core]
[   15.315066]  ? esw_port_metadata_get+0x12/0x30 [mlx5_core]
[   15.320940]  devlink_nl_param_fill.constprop.23+0x88/0x5d0
[   15.326679]  ? __alloc_skb+0x87/0x190
[   15.330594]  ? __kmalloc_node_track_caller+0x55/0x130
[   15.335897]  ? __kmalloc_node_track_caller+0x55/0x130
[   15.341196]  ? kmalloc_reserve+0x65/0xf0
[   15.345370]  ? __alloc_skb+0xd9/0x190
[   15.349280]  devlink_param_notify.constprop.20+0x72/0xd0
[   15.354845]  devl_params_register+0x150/0x250
[   15.359456]  esw_offloads_init+0x181/0x1a0 [mlx5_core]
[   15.364967]  mlx5_eswitch_init+0x4be/0x6e0 [mlx5_core]
[   15.370471]  mlx5_init_once+0xf0/0x550 [mlx5_core]
[   15.375601]  mlx5_init_one_devl_locked+0x7a/0x1d0 [mlx5_core]
[   15.381676]  mlx5_init_one+0x2e/0x60 [mlx5_core]
[   15.386616]  probe_one+0x2b6/0x410 [mlx5_core]
[   15.391382]  local_pci_probe+0x45/0xa0
[   15.395367]  work_for_cpu_fn+0x17/0x30
[   15.399345]  process_scheduled_works+0x8a/0x380
[   15.404102]  worker_thread+0x165/0x2d0
[   15.408082]  ? __pfx_worker_thread+0x10/0x10
[   15.412578]  kthread+0xf2/0x120
[   15.415952]  ? __pfx_kthread+0x10/0x10
[   15.419928]  ret_from_fork+0x31/0x40
[   15.423724]  ? __pfx_kthread+0x10/0x10
[   15.427692]  ret_from_fork_asm+0x1b/0x30
[   15.431827]  </TASK>
[   15.434218] Modules linked in: xor bnxt_re zstd_compress raid6_pq ib_uve=
rbs sd_mod ib_core t10_pi mlx5_core(+) pci_hyperv_intf mlxfw ahci libahci b=
nx2x mpi3mr psample i40e libata tls bnxt_en megaraid_sas scsi_transport_sas=
 crc32c_intel mgag200 mdio i2c_algo_bit wmi dm_mirror dm_region_hash dm_log=
 dm_mod
[   15.461684] CR2: 0000000000001118
[   15.465213] ---[ end trace 0000000000000000 ]---
[   15.476059] pstore: backend (erst) writing error (-28)
[   15.481415] RIP: 0010:esw_port_metadata_get+0x19/0x30 [mlx5_core]
[   15.487856] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 =
0f 1e fa 0f 1f 44 00 00 53 48 89 d3 e8 ce 28 9a cc 48 8b 80 b0 09 00 00 <8b=
> 80 18 11 00 00 88 03 31 c0 80 23 01 5b c3 cc cc cc cc 0f 1f 40
[   15.507043] RSP: 0000:ffff9ec05bf1fb98 EFLAGS: 00010286
[   15.512493] RAX: 0000000000000000 RBX: ffff9ec05bf1fbe4 RCX: 00000000000=
00028
[   15.519852] RDX: ffff9ec05bf1fbe4 RSI: 0000000000000013 RDI: ffff8bdd1d6=
96000
[   15.527209] RBP: ffffffffc1134c60 R08: 0000000000000000 R09: 00000000000=
00000
[   15.534568] R10: ffff9ec05bf1fbf8 R11: 0000000000001000 R12: ffff8bdd1d6=
96000
[   15.541934] R13: ffff8bdd9541c720 R14: 0000000000000000 R15: 00000000000=
00000
[   15.549299] FS:  0000000000000000(0000) GS:ffff8c3b7ea00000(0000) knlGS:=
0000000000000000
[   15.557618] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.563607] CR2: 0000000000001118 CR3: 00000004f9220003 CR4: 00000000007=
706e0
[   15.570981] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   15.578356] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   15.585733] PKRU: 55555554
[   15.588679] Kernel panic - not syncing: Fatal exception
[   15.594163] Kernel Offset: 0xbc00000 from 0xffffffff81000000 (relocation=
 range: 0xffffffff80000000-0xffffffffbfffffff)


*2=20
=46rom bf729988303a27833a86acb561f42b9a3cc12728 Mon Sep 17 00:00:00 2001
From: Shay Drory <shayd@nvidia.com>
Date: Thu, 11 Apr 2024 14:54:41 +0300
Subject: [PATCH] net/mlx5: Restore mistakenly dropped parts in register
 devlink flow

Fixes: c6e77aa9dd82 ("net/mlx5: Register devlink first under devlink lock")


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/04/20




