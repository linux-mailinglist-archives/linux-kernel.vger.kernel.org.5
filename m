Return-Path: <linux-kernel+bounces-43564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9B884158B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791D42802A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1EC15959D;
	Mon, 29 Jan 2024 22:21:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E1B15A487;
	Mon, 29 Jan 2024 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566912; cv=none; b=p0mOayeE/l85jZVO8tAyhHKU5pQljnc3Uc3Yo25/851fFjGNI033Q27NxLCkOqOA1T3SIG1KaVAYK2NZnsQJ8Z5+K80t9gCI2dzbgfDBHSWLEKY6qRyPnsfl003aG2jZP9q37HNbCnebtTf1MPF4Uus0/6akBgoE8dhAPSMpzCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566912; c=relaxed/simple;
	bh=oOPOwPKkNlYTlZSmDmjbqlOQsyotqqzxidVhCLCgLEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTiUVYFQ1xY/502Df++cdfb6ZLoHewQbympVxsrcsmd913Un9+wEzbnOZxj8tvQ6JkPcuBcL0ebMEjRnx9jQ8VegNGIv08oDIBk5GaXWB+b646i0I6HxyK64ldCuTbBtzYEJQ98UtWst/s0YNyFO3Lx5PkaupFm/D+1svaARNw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDF9C433F1;
	Mon, 29 Jan 2024 22:21:50 +0000 (UTC)
Date: Mon, 29 Jan 2024 17:22:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240129172200.1725f01b@gandalf.local.home>
In-Reply-To: <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
	<20240129120125.605e97af@gandalf.local.home>
	<CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
	<CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
	<CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
	<20240129152600.7587d1aa@gandalf.local.home>
	<CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 12:51:59 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> [0004-tracefs-dentry-lookup-crapectomy.patch  text/x-patch (11761 bytes)] 

I had to add:

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index cd6de3244442..89897d934302 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -230,7 +230,6 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 {
 	struct eventfs_inode *ei;
 
-	mutex_lock(&eventfs_mutex);
 	do {
 		// The parent is stable because we do not do renames
 		dentry = dentry->d_parent;
@@ -247,7 +246,6 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 		}
 		// Walk upwards until you find the events inode
 	} while (!ei->is_events);
-	mutex_unlock(&eventfs_mutex);
 
 	update_top_events_attr(ei, dentry->d_sb);
 

As eventfs_find_events() is only called by update_inode_attr() which is
only called by: lookup_file() and lookup_dir_entry() which are called by
eventfs_root_lookup() where eventfs_mutex is already held.

But crashes with just a:

 # ls /sys/kernel/tracing/events

[   66.423983] ------------[ cut here ]------------
[   66.426447] kernel BUG at fs/dcache.c:1876!
[   66.428363] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[   66.430320] CPU: 4 PID: 863 Comm: ls Not tainted 6.8.0-rc1-test-00009-gcaff43732484-dirty #463
[   66.433192] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   66.436122] RIP: 0010:d_instantiate+0x69/0x70
[   66.437537] Code: 00 4c 89 e7 e8 18 f0 49 01 48 89 df 48 89 ee e8 0d fe ff ff 4c 89 e7 5b 5d 41 5c e9 e1 f3 49 01 5b 5d 41 5c c3 cc cc cc cc 90 <0f> 0b 90 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[   66.442759] RSP: 0018:ffffc900015f7830 EFLAGS: 00010282
[   66.444315] RAX: 0000000000000000 RBX: ffff8881006aec40 RCX: ffffffffb77fcbff
[   66.446237] RDX: dffffc0000000000 RSI: ffff888127c46ec0 RDI: ffff8881006aed70
[   66.448170] RBP: ffff888127c46ec0 R08: 0000000000000001 R09: fffffbfff7766c4f
[   66.450094] R10: ffffffffbbb3627f R11: 0000000000000000 R12: 00000000000081a0
[   66.452007] R13: ffff88810f850000 R14: 0000000000000000 R15: 0000000000000000
[   66.455224] FS:  00007fe1e56d9800(0000) GS:ffff88823c800000(0000) knlGS:0000000000000000
[   66.457484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   66.459139] CR2: 0000556b5293b000 CR3: 000000010f056001 CR4: 0000000000170ef0
[   66.461192] Call Trace:
[   66.462094]  <TASK>
[   66.462915]  ? die+0x36/0x90
[   66.463928]  ? do_trap+0x133/0x230
[   66.465089]  ? d_instantiate+0x69/0x70
[   66.466325]  ? d_instantiate+0x69/0x70
[   66.467532]  ? do_error_trap+0x90/0x130
[   66.468787]  ? d_instantiate+0x69/0x70
[   66.470020]  ? handle_invalid_op+0x2c/0x40
[   66.471340]  ? d_instantiate+0x69/0x70
[   66.472559]  ? exc_invalid_op+0x2e/0x50
[   66.473807]  ? asm_exc_invalid_op+0x1a/0x20
[   66.475154]  ? d_instantiate+0x1f/0x70
[   66.476396]  ? d_instantiate+0x69/0x70
[   66.477629]  eventfs_root_lookup+0x366/0x660
[   66.479021]  ? __pfx_eventfs_root_lookup+0x10/0x10
[   66.480567]  ? print_circular_bug_entry+0x170/0x170
[   66.482107]  ? lockdep_init_map_type+0xd3/0x3a0
[   66.485243]  __lookup_slow+0x194/0x2a0
[   66.486410]  ? __pfx___lookup_slow+0x10/0x10
[   66.487694]  ? rwsem_read_trylock+0x118/0x1b0
[   66.489057]  ? i915_ttm_backup+0x2a0/0x5e0
[   66.490358]  ? down_read+0xbb/0x240
[   66.491506]  ? down_read+0xbb/0x240
[   66.492674]  ? trace_preempt_on+0xc8/0xe0
[   66.493962]  ? i915_ttm_backup+0x2a0/0x5e0
[   66.495291]  walk_component+0x166/0x220
[   66.496564]  path_lookupat+0xa9/0x2e0
[   66.497766]  ? __pfx_mark_lock+0x10/0x10
[   66.499026]  filename_lookup+0x19c/0x350
[   66.500335]  ? __pfx_filename_lookup+0x10/0x10
[   66.501688]  ? __pfx___lock_acquire+0x10/0x10
[   66.502996]  ? __pfx___lock_acquire+0x10/0x10
[   66.504305]  ? _raw_read_unlock_irqrestore+0x40/0x80
[   66.505765]  ? stack_depot_save_flags+0x1f0/0x790
[   66.507137]  vfs_statx+0xe1/0x270
[   66.508196]  ? __pfx_vfs_statx+0x10/0x10
[   66.509385]  ? __virt_addr_valid+0x155/0x330
[   66.510667]  ? __pfx_lock_release+0x10/0x10
[   66.511924]  do_statx+0xac/0x110
[   66.515394]  ? __pfx_do_statx+0x10/0x10
[   66.516631]  ? getname_flags.part.0+0xd6/0x260
[   66.517956]  __x64_sys_statx+0xa0/0xc0
[   66.519079]  do_syscall_64+0xca/0x1e0
[   66.520206]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
[   66.521674] RIP: 0033:0x7fe1e586e2ea
[   66.522780] Code: 48 8b 05 31 bb 0d 00 ba ff ff ff ff 64 c7 00 16 00 00 00 e9 a5 fd ff ff e8 03 10 02 00 0f 1f 00 41 89 ca b8 4c 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2e 89 c1 85 c0 74 0f 48 8b 05 f9 ba 0d 00 64
[   66.527728] RSP: 002b:00007fff06f5ef98 EFLAGS: 00000246 ORIG_RAX: 000000000000014c
[   66.529922] RAX: ffffffffffffffda RBX: 0000556b52935d18 RCX: 00007fe1e586e2ea
[   66.531863] RDX: 0000000000000900 RSI: 00007fff06f5f0d0 RDI: 00000000ffffff9c
[   66.533832] RBP: 0000000000000002 R08: 00007fff06f5efa0 R09: 0000000000000000
[   66.535768] R10: 0000000000000002 R11: 0000000000000246 R12: 00007fff06f5f0d0
[   66.537733] R13: 0000000000000005 R14: 0000556b52935d00 R15: 0000000000000003
[   66.539682]  </TASK>
[   66.540454] Modules linked in: vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock ip_tables
[   66.543272] ---[ end trace 0000000000000000 ]---


void d_instantiate(struct dentry *entry, struct inode * inode)
{
	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));  <<<--- HERE
	if (inode) {
		security_d_instantiate(entry, inode);
		spin_lock(&inode->i_lock);
		__d_instantiate(entry, inode);
		spin_unlock(&inode->i_lock);
	}
}

-- Steve

