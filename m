Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D0B7E506F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjKHGrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHGrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:47:17 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA428F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:47:15 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c431ca7826so1438722b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 22:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1699426035; x=1700030835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6aKtTjNDRBAbkTJx1/gQ1fqt7H+SbuhGHosyUpxruvU=;
        b=ELpwII6+EuVgV4C8ZGvbNIAQxLAV8cKYzpeckJqQjFDv69SM7a52ypjl87s10A0E+b
         wU5bZezmhgOOaicLvoEoMZwmM6f5JIYwxXUxg0UPyXbfMBCireh0nvrVzRcKVf/LeR6Y
         EKlO9w8sk1sbZ3tp0yqAc1FVysWXoKZnw6PWoaYE4wRlgD2k/Uy8EKE+mRTmG3K0kaP7
         vZT7VmKA/DYhRDmAL2CPBlJF2R6Fk6Wj3GKQ3RmG6Bvq1MxoW0yeVeFc7wdvtKAk2tDb
         Ie583YvQFntDvuGJfp7Lfqdbj8C9WdkGJavZoIn130wnv8JOXcY0lPAH1YIA2U7SbPZC
         Qb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699426035; x=1700030835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aKtTjNDRBAbkTJx1/gQ1fqt7H+SbuhGHosyUpxruvU=;
        b=Mf+k564psqghIqYd/hC7o2ZlngF7kV1gS8u5NPg56+Ff6gkZs+WTNVIq6/BdsjMNqQ
         oFnmBGVYOdZitH+hoLRW94dYsWSG6KkYTCbPhu/asBWSX8qDbj7laz9R2BvmExyfe/Ow
         PG5z92MaL/pW6xkZ+DAyenc1jERGkKv8TbcyfuvlIowO37WdSiAJ0Qasbn8R4rt3HHzp
         6XDdk6Q36Kp+8vardyyaJ4LkrL+D4AuJGsl5Ll6Sta6+bL20/GEuzQNSRBcYrr1muRXv
         ceDUmEfsX2QG7XQ5lQY0vRabgJJbJkvgZOBdLAO78Sv6tOu5elLiXHBREFdaTBK3x/V4
         IQhg==
X-Gm-Message-State: AOJu0Yw7bU8X+3T6op9zr1yb7iUkn1PQTb0Rt2La5UjwJ3F/VjBpAG6i
        8Ps7NNcggImmi5AqN1xw6epuAHBhhAKNhTF7OhU=
X-Google-Smtp-Source: AGHT+IEum2aQzFSBiV8R3XcvFFH6JKn1SMYjG8T6E2d8kkkcMerbJPymQYVkZWtiPiRWELwIJg7+pA==
X-Received: by 2002:a05:6a21:71c7:b0:181:39a7:4fd4 with SMTP id ay7-20020a056a2171c700b0018139a74fd4mr1141079pzc.30.1699426034700;
        Tue, 07 Nov 2023 22:47:14 -0800 (PST)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b001c3a8b135ebsm933831plb.282.2023.11.07.22.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 22:47:14 -0800 (PST)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     j.vosburgh@gmail.com
Cc:     andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] boning: use a read-write lock in bonding_show_bonds()
Date:   Wed,  8 Nov 2023 06:46:41 +0000
Message-Id: <20231108064641.65209-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

call stack:
......
PID: 210933  TASK: ffff92424e5ec080  CPU: 13  COMMAND: "kworker/u96:2"
[ffffa7a8e96bbac0] __schedule at ffffffffb0719898
[ffffa7a8e96bbb48] schedule at ffffffffb0719e9e
[ffffa7a8e96bbb68] rwsem_down_write_slowpath at ffffffffafb3167a
[ffffa7a8e96bbc00] down_write at ffffffffb071bfc1
[ffffa7a8e96bbc18] kernfs_remove_by_name_ns at ffffffffafe3593e
[ffffa7a8e96bbc48] sysfs_unmerge_group at ffffffffafe38922
[ffffa7a8e96bbc68] dpm_sysfs_remove at ffffffffb021c96a
[ffffa7a8e96bbc80] device_del at ffffffffb0209af8
[ffffa7a8e96bbcd0] netdev_unregister_kobject at ffffffffb04a6b0e
[ffffa7a8e96bbcf8] unregister_netdevice_many at ffffffffb046d3d9
[ffffa7a8e96bbd60] default_device_exit_batch at ffffffffb046d8d1
[ffffa7a8e96bbdd0] ops_exit_list at ffffffffb045e21d
[ffffa7a8e96bbe00] cleanup_net at ffffffffb045ea46
[ffffa7a8e96bbe60] process_one_work at ffffffffafad94bb
[ffffa7a8e96bbeb0] worker_thread at ffffffffafad96ad
[ffffa7a8e96bbf10] kthread at ffffffffafae132a
[ffffa7a8e96bbf50] ret_from_fork at ffffffffafa04b92

290858 PID: 278176  TASK: ffff925deb39a040  CPU: 32  COMMAND: "node-exporter"
[ffffa7a8d14dbb80] __schedule at ffffffffb0719898
[ffffa7a8d14dbc08] schedule at ffffffffb0719e9e
[ffffa7a8d14dbc28] schedule_preempt_disabled at ffffffffb071a24e
[ffffa7a8d14dbc38] __mutex_lock at ffffffffb071af28
[ffffa7a8d14dbcb8] __mutex_lock_slowpath at ffffffffb071b1a3
[ffffa7a8d14dbcc8] mutex_lock at ffffffffb071b1e2
[ffffa7a8d14dbce0] rtnl_lock at ffffffffb047f4b5
[ffffa7a8d14dbcf0] bonding_show_bonds at ffffffffc079b1a1 [bonding]
[ffffa7a8d14dbd20] class_attr_show at ffffffffb02117ce
[ffffa7a8d14dbd30] sysfs_kf_seq_show at ffffffffafe37ba1
[ffffa7a8d14dbd50] kernfs_seq_show at ffffffffafe35c07
[ffffa7a8d14dbd60] seq_read_iter at ffffffffafd9fce0
[ffffa7a8d14dbdc0] kernfs_fop_read_iter at ffffffffafe36a10
[ffffa7a8d14dbe00] new_sync_read at ffffffffafd6de23
[ffffa7a8d14dbe90] vfs_read at ffffffffafd6e64e
[ffffa7a8d14dbed0] ksys_read at ffffffffafd70977
[ffffa7a8d14dbf10] __x64_sys_read at ffffffffafd70a0a
[ffffa7a8d14dbf20] do_syscall_64 at ffffffffb070bf1c
[ffffa7a8d14dbf50] entry_SYSCALL_64_after_hwframe at ffffffffb080007c
......

Problem description:

Thread 210933 holds the rtnl_mutex and tries to acquire the kernfs_rwsem,
but there are many readers which hold the kernfs_rwsem, so it has to sleep
for a long time to wait the readers release the lock. Thread 278176 and any
other threads which call bonding_show_bonds() also need to wait because
they try to accuire the rtnl_mutex.

bonding_show_bonds() uses rtnl_mutex to protect the bond_list traversal.
However, the addition and deletion of bond_list are only performed in
bond_init()/bond_uninit(), so we can intoduce a separate read-write lock
to synchronize bond list mutation.

What's the benefits of this change?

1) All threads which call bonding_show_bonds() only wait when the
registration or unregistration of bond device happens.

2) There are many other users of rtnl_mutex, so bonding_show_bonds()
won't compete with them.

In a word, this change reduces the lock contention of rtnl_mutex.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 drivers/net/bonding/bond_main.c  | 4 ++++
 drivers/net/bonding/bond_sysfs.c | 6 ++++--
 include/net/bonding.h            | 3 +++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 51d47eda1c87..ac4773d19beb 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5951,7 +5951,9 @@ static void bond_uninit(struct net_device *bond_dev)
 
 	bond_set_slave_arr(bond, NULL, NULL);
 
+	write_lock(&bonding_dev_lock);
 	list_del(&bond->bond_list);
+	write_unlock(&bonding_dev_lock);
 
 	bond_debug_unregister(bond);
 }
@@ -6364,7 +6366,9 @@ static int bond_init(struct net_device *bond_dev)
 	spin_lock_init(&bond->stats_lock);
 	netdev_lockdep_set_classes(bond_dev);
 
+	write_lock(&bonding_dev_lock);
 	list_add_tail(&bond->bond_list, &bn->dev_list);
+	write_unlock(&bonding_dev_lock);
 
 	bond_prepare_sysfs_group(bond);
 
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 2805135a7205..e107c1d7a6bf 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -28,6 +28,8 @@
 
 #define to_bond(cd)	((struct bonding *)(netdev_priv(to_net_dev(cd))))
 
+DEFINE_RWLOCK(bonding_dev_lock);
+
 /* "show" function for the bond_masters attribute.
  * The class parameter is ignored.
  */
@@ -40,7 +42,7 @@ static ssize_t bonding_show_bonds(const struct class *cls,
 	int res = 0;
 	struct bonding *bond;
 
-	rtnl_lock();
+	read_lock(&bonding_dev_lock);
 
 	list_for_each_entry(bond, &bn->dev_list, bond_list) {
 		if (res > (PAGE_SIZE - IFNAMSIZ)) {
@@ -55,7 +57,7 @@ static ssize_t bonding_show_bonds(const struct class *cls,
 	if (res)
 		buf[res-1] = '\n'; /* eat the leftover space */
 
-	rtnl_unlock();
+	read_unlock(&bonding_dev_lock);
 	return res;
 }
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 5b8b1b644a2d..584ba4b5b8df 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -777,6 +777,9 @@ extern struct rtnl_link_ops bond_link_ops;
 /* exported from bond_sysfs_slave.c */
 extern const struct sysfs_ops slave_sysfs_ops;
 
+/* exported from bond_sysfs.c */
+extern rwlock_t bonding_dev_lock;
+
 /* exported from bond_3ad.c */
 extern const u8 lacpdu_mcast_addr[];
 
-- 
2.25.1

