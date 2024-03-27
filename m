Return-Path: <linux-kernel+bounces-121203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C28A88E3E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4586029CC61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4DC185F02;
	Wed, 27 Mar 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mjdpvojb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6CB18522E;
	Wed, 27 Mar 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542337; cv=none; b=OLum/NfpOla9s8QE80i5BhnpAWh39GccANteF35oFPOfIBcfBYVFMyPWTK6o4PN/loV40PGPAqtWFusB1VUjuXxicngs/DyPMbsJT18oRCd5MFdmHp94VtVA8dT8chuLTtvpepvJZ44XmnQ1Ui4jadGWCUrPaJEMAwXjUdhHHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542337; c=relaxed/simple;
	bh=IXGj7gDGkyso8Gc8zTpkguwTv7FyFRFp+3Fdl7+V+V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EgYPKIvZQjBEQbeh2Uzq/EjVOZ7Z3XVcN5jtbEYWN7jU+QamUYr8sfh/NDiMI23KqHkXlFKOmayii8mumj3sTFS1QI9hIrFfrhHHcuWb3XXlvsGCV080ELfT2I2eIiG53o9NhCFt0v7eTPB8ElLudsU1TrgkTLt5hq1+FJJCQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mjdpvojb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8E2C433F1;
	Wed, 27 Mar 2024 12:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542336;
	bh=IXGj7gDGkyso8Gc8zTpkguwTv7FyFRFp+3Fdl7+V+V8=;
	h=From:To:Cc:Subject:Date:From;
	b=Mjdpvojb9cQR9hQ5DD4xKu8Irp06zfdugQQxvdsplxjcWcnlPUQLjKRCYJZxVohPX
	 SL1Abrg2el9cmw5Fc6aXTqQbIhO+I2URuY8RPBo/VC3FGBjKF1ip16V80bXU9og2Lz
	 vUlDCJYi6X7C5V1wggxGYlZGKoiOxH2MWkQIer+557xzw2j2nsCL1SBHhmGa+vbtrF
	 UD8lrTl9jWbKERmCfO+J56JkUKf5uAog0jhSexP/ahs83lpEL/wL6FrumO1QoIiZHS
	 M/ZGyfVD9F2ELw27Y8OaoSITecdqxuSzFtdsu64cjhTktlKGkKRMvXJeqsam6ZPUlt
	 Q/kfQeFPw4mcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pchelkin@ispras.ru
Cc: Alexander Aring <aahringo@redhat.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "mac802154: fix llsec key resources release in mac802154_llsec_key_del" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:25:34 -0400
Message-ID: <20240327122535.2840351-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e8a1e58345cf40b7b272e08ac7b32328b2543e40 Mon Sep 17 00:00:00 2001
From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Wed, 28 Feb 2024 19:38:39 +0300
Subject: [PATCH] mac802154: fix llsec key resources release in
 mac802154_llsec_key_del

mac802154_llsec_key_del() can free resources of a key directly without
following the RCU rules for waiting before the end of a grace period. This
may lead to use-after-free in case llsec_lookup_key() is traversing the
list of keys in parallel with a key deletion:

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 4 PID: 16000 at lib/refcount.c:25 refcount_warn_saturate+0x162/0x2a0
Modules linked in:
CPU: 4 PID: 16000 Comm: wpan-ping Not tainted 6.7.0 #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x162/0x2a0
Call Trace:
 <TASK>
 llsec_lookup_key.isra.0+0x890/0x9e0
 mac802154_llsec_encrypt+0x30c/0x9c0
 ieee802154_subif_start_xmit+0x24/0x1e0
 dev_hard_start_xmit+0x13e/0x690
 sch_direct_xmit+0x2ae/0xbc0
 __dev_queue_xmit+0x11dd/0x3c20
 dgram_sendmsg+0x90b/0xd60
 __sys_sendto+0x466/0x4c0
 __x64_sys_sendto+0xe0/0x1c0
 do_syscall_64+0x45/0xf0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76

Also, ieee802154_llsec_key_entry structures are not freed by
mac802154_llsec_key_del():

unreferenced object 0xffff8880613b6980 (size 64):
  comm "iwpan", pid 2176, jiffies 4294761134 (age 60.475s)
  hex dump (first 32 bytes):
    78 0d 8f 18 80 88 ff ff 22 01 00 00 00 00 ad de  x.......".......
    00 00 00 00 00 00 00 00 03 00 cd ab 00 00 00 00  ................
  backtrace:
    [<ffffffff81dcfa62>] __kmem_cache_alloc_node+0x1e2/0x2d0
    [<ffffffff81c43865>] kmalloc_trace+0x25/0xc0
    [<ffffffff88968b09>] mac802154_llsec_key_add+0xac9/0xcf0
    [<ffffffff8896e41a>] ieee802154_add_llsec_key+0x5a/0x80
    [<ffffffff8892adc6>] nl802154_add_llsec_key+0x426/0x5b0
    [<ffffffff86ff293e>] genl_family_rcv_msg_doit+0x1fe/0x2f0
    [<ffffffff86ff46d1>] genl_rcv_msg+0x531/0x7d0
    [<ffffffff86fee7a9>] netlink_rcv_skb+0x169/0x440
    [<ffffffff86ff1d88>] genl_rcv+0x28/0x40
    [<ffffffff86fec15c>] netlink_unicast+0x53c/0x820
    [<ffffffff86fecd8b>] netlink_sendmsg+0x93b/0xe60
    [<ffffffff86b91b35>] ____sys_sendmsg+0xac5/0xca0
    [<ffffffff86b9c3dd>] ___sys_sendmsg+0x11d/0x1c0
    [<ffffffff86b9c65a>] __sys_sendmsg+0xfa/0x1d0
    [<ffffffff88eadbf5>] do_syscall_64+0x45/0xf0
    [<ffffffff890000ea>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

Handle the proper resource release in the RCU callback function
mac802154_llsec_key_del_rcu().

Note that if llsec_lookup_key() finds a key, it gets a refcount via
llsec_key_get() and locally copies key id from key_entry (which is a
list element). So it's safe to call llsec_key_put() and free the list
entry after the RCU grace period elapses.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 5d637d5aabd8 ("mac802154: add llsec structures and mutators")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Alexander Aring <aahringo@redhat.com>
Message-ID: <20240228163840.6667-1-pchelkin@ispras.ru>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 include/net/cfg802154.h |  1 +
 net/mac802154/llsec.c   | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index cd95711b12b8e..76d2cd2e2b309 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -401,6 +401,7 @@ struct ieee802154_llsec_key {
 
 struct ieee802154_llsec_key_entry {
 	struct list_head list;
+	struct rcu_head rcu;
 
 	struct ieee802154_llsec_key_id id;
 	struct ieee802154_llsec_key *key;
diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 8d2eabc71bbeb..f13b07ebfb98a 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -265,19 +265,27 @@ int mac802154_llsec_key_add(struct mac802154_llsec *sec,
 	return -ENOMEM;
 }
 
+static void mac802154_llsec_key_del_rcu(struct rcu_head *rcu)
+{
+	struct ieee802154_llsec_key_entry *pos;
+	struct mac802154_llsec_key *mkey;
+
+	pos = container_of(rcu, struct ieee802154_llsec_key_entry, rcu);
+	mkey = container_of(pos->key, struct mac802154_llsec_key, key);
+
+	llsec_key_put(mkey);
+	kfree_sensitive(pos);
+}
+
 int mac802154_llsec_key_del(struct mac802154_llsec *sec,
 			    const struct ieee802154_llsec_key_id *key)
 {
 	struct ieee802154_llsec_key_entry *pos;
 
 	list_for_each_entry(pos, &sec->table.keys, list) {
-		struct mac802154_llsec_key *mkey;
-
-		mkey = container_of(pos->key, struct mac802154_llsec_key, key);
-
 		if (llsec_key_id_equal(&pos->id, key)) {
 			list_del_rcu(&pos->list);
-			llsec_key_put(mkey);
+			call_rcu(&pos->rcu, mac802154_llsec_key_del_rcu);
 			return 0;
 		}
 	}
-- 
2.43.0





