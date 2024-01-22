Return-Path: <linux-kernel+bounces-33401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620D5836942
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86FB1F22174
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A04CB25;
	Mon, 22 Jan 2024 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q6xcOg5C";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q6xcOg5C"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598774C3B8;
	Mon, 22 Jan 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936196; cv=none; b=l1i8kjOxn1wfqWzPvAwSciS8Ko9va7Hm3bcYigLuTjnsHME2FzYN/OuLRU5WUXcexMbbfKi29xLtoCaM71x4Ek8kW/A4SgEjYc7h58mp9Wsr6OamHygZQ9sIUhbFOiase2PNrsaJfAXJ9jdI078bREKedi6mmasSCi5aORg+T80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936196; c=relaxed/simple;
	bh=AiIoSLcwsun2PlpW5QDuZoGLBPNqiCkAIUpUdBT+5Mw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URZ2SObohTxBBhhl+7XQkum1HkpnEs26RUzW9NtWEK+kW1V0jcIF6ntQbCL5369j7i9VcQWHDV90KG0wMB/R0Tf6w4JaOC5mxcbfL9kfDAIAX19zqQZ5FsgmnabN1WJNshgkDIUPw6BeA5CVz+D/c9RsM8BsaAt5ef5zaL14muw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q6xcOg5C; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q6xcOg5C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 85E131FC0C;
	Mon, 22 Jan 2024 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705936192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pozb3WSw1zm1C/RTEp0MsUZiC9SjbgDDQtxfpkBejig=;
	b=q6xcOg5C2tjM0fPx9cPMG0jMk9DaMbvz9N5hxG5k27AsOAUf+HkMk+UV+8NODc0QoUMYT+
	Uv8PYcKIYh4vH9JbqwSaMpunOx715U1qiG0JCSqCNx18EztXqq7Qy3X2CiLFcJpBoRkat1
	iNz1kZj4lXQAllQIh1dmjard+kcv7WI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705936192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pozb3WSw1zm1C/RTEp0MsUZiC9SjbgDDQtxfpkBejig=;
	b=q6xcOg5C2tjM0fPx9cPMG0jMk9DaMbvz9N5hxG5k27AsOAUf+HkMk+UV+8NODc0QoUMYT+
	Uv8PYcKIYh4vH9JbqwSaMpunOx715U1qiG0JCSqCNx18EztXqq7Qy3X2CiLFcJpBoRkat1
	iNz1kZj4lXQAllQIh1dmjard+kcv7WI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40F7F136A4;
	Mon, 22 Jan 2024 15:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D4Q3DkCFrmXNYwAAD6G6ig
	(envelope-from <petr.pavlu@suse.com>); Mon, 22 Jan 2024 15:09:52 +0000
From: Petr Pavlu <petr.pavlu@suse.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tom.zanussi@linux.intel.com
Cc: vedang.patel@intel.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] tracing: Ensure visibility when inserting an element into tracing_map
Date: Mon, 22 Jan 2024 16:09:28 +0100
Message-Id: <20240122150928.27725-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=q6xcOg5C
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 85E131FC0C
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

Running the following two commands in parallel on a multi-processor
AArch64 machine can sporadically produce an unexpected warning about
duplicate histogram entries:

 $ while true; do
     echo hist:key=id.syscall:val=hitcount > \
       /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
     cat /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/hist
     sleep 0.001
   done
 $ stress-ng --sysbadaddr $(nproc)

The warning looks as follows:

[ 2911.172474] ------------[ cut here ]------------
[ 2911.173111] Duplicates detected: 1
[ 2911.173574] WARNING: CPU: 2 PID: 12247 at kernel/trace/tracing_map.c:983 tracing_map_sort_entries+0x3e0/0x408
[ 2911.174702] Modules linked in: iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) af_packet(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) ena(E) tiny_power_button(E) qemu_fw_cfg(E) button(E) fuse(E) efi_pstore(E) ip_tables(E) x_tables(E) xfs(E) libcrc32c(E) aes_ce_blk(E) aes_ce_cipher(E) crct10dif_ce(E) polyval_ce(E) polyval_generic(E) ghash_ce(E) gf128mul(E) sm4_ce_gcm(E) sm4_ce_ccm(E) sm4_ce(E) sm4_ce_cipher(E) sm4(E) sm3_ce(E) sm3(E) sha3_ce(E) sha512_ce(E) sha512_arm64(E) sha2_ce(E) sha256_arm64(E) nvme(E) sha1_ce(E) nvme_core(E) nvme_auth(E) t10_pi(E) sg(E) scsi_mod(E) scsi_common(E) efivarfs(E)
[ 2911.174738] Unloaded tainted modules: cppc_cpufreq(E):1
[ 2911.180985] CPU: 2 PID: 12247 Comm: cat Kdump: loaded Tainted: G            E      6.7.0-default #2 1b58bbb22c97e4399dc09f92d309344f69c44a01
[ 2911.182398] Hardware name: Amazon EC2 c7g.8xlarge/, BIOS 1.0 11/1/2018
[ 2911.183208] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[ 2911.184038] pc : tracing_map_sort_entries+0x3e0/0x408
[ 2911.184667] lr : tracing_map_sort_entries+0x3e0/0x408
[ 2911.185310] sp : ffff8000a1513900
[ 2911.185750] x29: ffff8000a1513900 x28: ffff0003f272fe80 x27: 0000000000000001
[ 2911.186600] x26: ffff0003f272fe80 x25: 0000000000000030 x24: 0000000000000008
[ 2911.187458] x23: ffff0003c5788000 x22: ffff0003c16710c8 x21: ffff80008017f180
[ 2911.188310] x20: ffff80008017f000 x19: ffff80008017f180 x18: ffffffffffffffff
[ 2911.189160] x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000a15134b8
[ 2911.190015] x14: 0000000000000000 x13: 205d373432323154 x12: 5b5d313131333731
[ 2911.190844] x11: 00000000fffeffff x10: 00000000fffeffff x9 : ffffd1b78274a13c
[ 2911.191716] x8 : 000000000017ffe8 x7 : c0000000fffeffff x6 : 000000000057ffa8
[ 2911.192554] x5 : ffff0012f6c24ec0 x4 : 0000000000000000 x3 : ffff2e5b72b5d000
[ 2911.193404] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0003ff254480
[ 2911.194259] Call trace:
[ 2911.194626]  tracing_map_sort_entries+0x3e0/0x408
[ 2911.195220]  hist_show+0x124/0x800
[ 2911.195692]  seq_read_iter+0x1d4/0x4e8
[ 2911.196193]  seq_read+0xe8/0x138
[ 2911.196638]  vfs_read+0xc8/0x300
[ 2911.197078]  ksys_read+0x70/0x108
[ 2911.197534]  __arm64_sys_read+0x24/0x38
[ 2911.198046]  invoke_syscall+0x78/0x108
[ 2911.198553]  el0_svc_common.constprop.0+0xd0/0xf8
[ 2911.199157]  do_el0_svc+0x28/0x40
[ 2911.199613]  el0_svc+0x40/0x178
[ 2911.200048]  el0t_64_sync_handler+0x13c/0x158
[ 2911.200621]  el0t_64_sync+0x1a8/0x1b0
[ 2911.201115] ---[ end trace 0000000000000000 ]---

The problem appears to be caused by CPU reordering of writes issued from
__tracing_map_insert().

The check for the presence of an element with a given key in this
function is:

 val = READ_ONCE(entry->val);
 if (val && keys_match(key, val->key, map->key_size)) ...

The write of a new entry is:

 elt = get_free_elt(map);
 memcpy(elt->key, key, map->key_size);
 entry->val = elt;

The "memcpy(elt->key, key, map->key_size);" and "entry->val = elt;"
stores may become visible in the reversed order on another CPU. This
second CPU might then incorrectly determine that a new key doesn't match
an already present val->key and subsequently insert a new element,
resulting in a duplicate.

Fix the problem by adding a write barrier between
"memcpy(elt->key, key, map->key_size);" and "entry->val = elt;", and for
good measure, also use WRITE_ONCE(entry->val, elt) for publishing the
element. The sequence pairs with the mentioned "READ_ONCE(entry->val);"
and the "val->key" check which has an address dependency.

The barrier is placed on a path executed when adding an element for
a new key. Subsequent updates targeting the same key remain unaffected.

From the user's perspective, the issue was introduced by commit
c193707dde77 ("tracing: Remove code which merges duplicates"), which
followed commit cbf4100efb8f ("tracing: Add support to detect and avoid
duplicates"). The previous code operated differently; it inherently
expected potential races which result in duplicates but merged them
later when they occurred.

Fixes: c193707dde77 ("tracing: Remove code which merges duplicates")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/tracing_map.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index c774e560f2f9..a4dcf0f24352 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -574,7 +574,12 @@ __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 				}
 
 				memcpy(elt->key, key, map->key_size);
-				entry->val = elt;
+				/*
+				 * Ensure the initialization is visible and
+				 * publish the elt.
+				 */
+				smp_wmb();
+				WRITE_ONCE(entry->val, elt);
 				atomic64_inc(&map->hits);
 
 				return entry->val;

base-commit: 9d1694dc91ce7b80bc96d6d8eaf1a1eca668d847
-- 
2.35.3


