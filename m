Return-Path: <linux-kernel+bounces-12366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4034981F3B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640011C21583
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9325253;
	Thu, 28 Dec 2023 01:40:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2646BF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T0rkk3gcSz29gby;
	Thu, 28 Dec 2023 09:38:38 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id BACD01A0192;
	Thu, 28 Dec 2023 09:39:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:16 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 17/17] Documentation: ubifs: Add ubifs repair whitepaper
Date: Thu, 28 Dec 2023 09:41:12 +0800
Message-ID: <20231228014112.2836317-18-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231228014112.2836317-1-chengzhihao1@huawei.com>
References: <20231228014112.2836317-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)

Add documentation for UBIFS repair.
Add 'ubifs' dir under 'Documentation/filesystems/', and move all docs
related to UBIFS into 'Documentation/filesystems/ubifs'.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 Documentation/filesystems/index.rst           |   3 +-
 .../authentication.rst}                       |   0
 Documentation/filesystems/ubifs/index.rst     |  11 +
 .../filesystems/{ubifs.rst => ubifs/main.rst} |   0
 Documentation/filesystems/ubifs/repair.rst    | 235 ++++++++++++++++++
 MAINTAINERS                                   |   5 +-
 6 files changed, 250 insertions(+), 4 deletions(-)
 rename Documentation/filesystems/{ubifs-authentication.rst => ubifs/authentication.rst} (100%)
 create mode 100644 Documentation/filesystems/ubifs/index.rst
 rename Documentation/filesystems/{ubifs.rst => ubifs/main.rst} (100%)
 create mode 100644 Documentation/filesystems/ubifs/repair.rst

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 09cade7eaefc..7a7e3c0a5289 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -116,8 +116,7 @@ Documentation for filesystem implementations.
    sysfs
    sysv-fs
    tmpfs
-   ubifs
-   ubifs-authentication
+   ubifs/index
    udf
    virtiofs
    vfat
diff --git a/Documentation/filesystems/ubifs-authentication.rst b/Documentation/filesystems/ubifs/authentication.rst
similarity index 100%
rename from Documentation/filesystems/ubifs-authentication.rst
rename to Documentation/filesystems/ubifs/authentication.rst
diff --git a/Documentation/filesystems/ubifs/index.rst b/Documentation/filesystems/ubifs/index.rst
new file mode 100644
index 000000000000..fba59a916e89
--- /dev/null
+++ b/Documentation/filesystems/ubifs/index.rst
@@ -0,0 +1,11 @@
+===============
+UBI File System
+===============
+
+
+.. toctree::
+   :maxdepth: 1
+
+   main
+   repair
+   authentication
diff --git a/Documentation/filesystems/ubifs.rst b/Documentation/filesystems/ubifs/main.rst
similarity index 100%
rename from Documentation/filesystems/ubifs.rst
rename to Documentation/filesystems/ubifs/main.rst
diff --git a/Documentation/filesystems/ubifs/repair.rst b/Documentation/filesystems/ubifs/repair.rst
new file mode 100644
index 000000000000..212fa886b1a1
--- /dev/null
+++ b/Documentation/filesystems/ubifs/repair.rst
@@ -0,0 +1,235 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. UBIFS Repairing
+.. sigma star gmbh
+.. 2023
+
+====================
+UBIFS Repair Support
+====================
+
+Introduction
+============
+
+UBIFS repair provides a way to fix inconsistent UBIFS image(which is corrupted
+by hardware exceptions or UBIFS realization bugs) and makes filesystem become
+consistent, just like fsck tools(eg. fsck.ext4, fsck.f2fs, fsck.fat, etc.) do.
+
+Why do we need UBIFS repair?
+============================
+
+The inconsistent UBIFS image is produced by mainly two aspects:
+
+- *Hardware exceptions*: Some of them are ecc uncorrectable errors(eg. [1]_
+  [2]_), some of them are caused by intermittent writing protection(unstable
+  voltage).
+- *UBIFS realization bugs*: Some of them are known bugs which are fixable (eg.
+  [3]_ [4]_ [5]_ [6]_ [7]_ [8]_ [9]_ [10]_ [11]_ [12]_, etc.), some of them are
+  unknown bugs(eg. [13]_), some of them are hard to fix(eg. [14]_).
+
+Once the UBIFS image becomes inconsistent, userspace applications won't work
+properly, as we all know, UBIFS is mainly applied in embedded system, which
+could affect many domains(eg. communications, IoT, family network, etc.). The
+only way to rescue device is formating UBI device and mkfs, which will lost all
+userdata, and it could be intolerable for some important situations.
+
+So, a filesystem repair tool is urgent for UBIFS, even it has been born for 15
+years, and it's not too late to do it for there will be more embedded devices in
+the future IOT world.
+
+Implementation
+==============
+
+Design
+------
+
+The direct idea of fixing an UBIFS image may be similar to mounting process:
+
+- Step 1: Read superblock.
+- Step 2: Read master node.
+- Step 3: Replay journal.
+- Step 4: Traverse TNC, check and drop bad znodes, scan files according to TNC.
+- Step 5: ...
+
+.. [LINK_1] This method has 3 disadvantages, and point 2 and 3 are unsolvable:
+
+- 1. It depends on too many areas, for example master, log. Repair will be
+  failed if each one of these areas becomes corrupted.
+- 2. The amount of files can be recovered is decided by the degree of corruption
+  in TNC. All files will be lost if the max level znode is corrupted.
+- 3. If we do step 3 before step 4 and TNC is corrupted, step 3 could be failed
+  while updating TNC, which makes repair failed. If we do step 4 before step 3
+  and gc occurred in last mounting, empty('0xFF') area could be scanned based on
+  TNC, the node corresponding to bad TNC branch could be a good one because the
+  empty area has been gced and journal replaying is not performed (TNC could be
+  updated after replaying jouranl); Or the node corresponding to bad TNC branch
+  could be a bad one, because hardware exceptions happened. So it is hard to
+  decide the order between journal replaying and TNC traversing. Similar order
+  problem exists between journal replaying and LPT traversing too.
+
+To sum up, UBIFS repair should depend on less meta areas and recover as much
+repairable data as possible.
+
+Since UBIFS assign sqnum for each node, it makes possible to distinguish new and
+old verions for same file, so the main idea is scanning all nodes and then
+rebuild TNC and recalculate space statistics informaion.
+
+Repair process
+--------------
+
+There are 13 steps for reparing an UBIFS image:
+
+- Step 1: Read superblock.
+- Step 2: Scan nodes(inode node/dentry node/data node/truncation node) from
+  all LEBs, corrupted nodes(eg. incorrect crc, bad inode size, bad dentry name
+  length, etc.) are dropped during scanning. Valid inode nodes(nlink > 0) and
+  dentry nodes(inum != 0) are put into two valid trees separately, also, deleted
+  inode nodes (nlink is 0) and deleted dentry nodes(inum is 0) are put into two
+  deleted trees separately. Other nodes are put into corresponding file. The
+  final recovered file(xattr is treated as a file) is organized as:
+
+::
+
+         (rbtree, inum indexed)
+              /      \
+            file1   file2
+            /   \
+          file3 file4
+
+        file {
+          inode node // each file has 1 inode node
+          dentry (sub rb_tree, sqnum indexed) // '/' has no dentries, otherwise
+                                              // at least 1 dentry is required.
+          trun node // the newest one truncation node
+          data (sub rb_tree, block number indexed) // Each file may have 0
+                                                   // many data nodes
+        }
+
+- Step 3: Traverse nodes from deleted trees, remove inode nodes and dentry nodes
+  with smaller sqnum from valid trees. valid_inos - del_inos = *left_inos*,
+  valid_dents - del_dents = *left_dents*.
+
+.. [LINK_2] This step handles deleting case, for example, file A is deleted,
+   deleted inode node and deleted dentry node are written, if we ignore the
+   deleted nodes, file A can be recovered after repairing because undeleted
+   inode node and undeleted dentry node can be scanned. There's an exception,
+   if deleted inode node and deleted dentry node are reclaimed(by gc) after
+   deletion, file A is recovered.
+
+- Step 4: Traverse *left_inos* and *left_dents*, insert inode node and dentry
+  nodes into corresponding files.
+  Each file corresponds to a real file or xattr, it contains 1 inode node, multi
+  dentry nodes, multi data nodes, 1 newest truncation node(if exists).
+- Step 5: Drop invalid files. For example, nonconsistent file type between inode
+  node and dentry nodes, file has no dentry nodes(excepts '/'), encrypted file
+  has no xattr information, etc.
+- Step 6: Extract reachable directory entries tree. Make sure that all files can
+  be searched from '/', unreachable file is deleted.
+- Step 7: Correct the file information. Traverse all files and calculate
+  information (nlink, size, xattr_cnt, etc.) for each file just like
+  check_leaf() does, correct inode node based on calculated information.
+- Step 8: Record used LEBs. Traverse all files'(including effective nodes on
+  deleted trees in step 2) position, after this step UBIFS repair knows which
+  LEB is empty.
+- Step 9: Re-write data. Read data from LEB and write back data, make sure that
+  all LEB is ended with empty data(0xFF). It will prevent failed gc scanning in
+  next mounting.
+- Step 10: Build TNC. Construct TNC according to all files' nodes, just like
+  mkfs does, then write TNC on flash.
+- Step 11: Build LPT. Construct LPT according to all nodes' position, just like
+  mkfs does, then write TNC on flash.
+- Step 12: Clean up log area and orphan area. Recovery process is finished, log
+  area and orphan area can be erased.
+- Step 13: Write master node. Since all meta areas are ready, master node can
+  be updated.
+
+Evaluation
+==========
+
+Based on the implementation of ubifs repair, there are following advantages and
+limitations.
+
+Advantages
+----------
+
+- 1. Power-cut during repairing is tolerant, UBIFS repair always do full
+  scanning and final valid nodes won't be erased from flash, so UBIFS repair
+  can always rebuild filesystem based on scanning nodes even it is breaked by
+  power-cut.
+- 2. The UBIFS image can be fixed as long as the super block is not corrupted.
+  If there exists no valid nodes on flash, UBIFS repair will create a new '/'
+  just like create_default_filesystem() does.
+- 3. Encrypted UBIFS image is supported, because dentry name and data content of
+  file are not necessary for UBIFS repair process.
+
+Limitations
+-----------
+
+- 1. Deleted files could be recovered [LINK_2]_. Similar problem exists on data
+  nodes, for example, 8K-size file A(dn0, dn1) is truncated as 0, 4K data(dn2)
+  is then written from offset 4K in file A. The dn0 and dn2 is recovered after
+  repairing, but only dn2 is expected to be recovered. UBIFS repair cannot solve
+  it, because the real existence information of nodes depends on TNC, but TNC
+  should not be depended for UBIFS repair, see [LINK_1]_.
+- 2. All valid nodes are loaded in memory, if there are too many files, it could
+  trigger OOM while repairing. Similar problem exists in dbg_check_filesystem().
+- 3. Authenticated UBIFS image is not supported for now, it can be supported by
+  extending new fields in repair interface(used to passing authentication
+  information) and implementing parsing authenticated nodes.
+
+How to use?
+===========
+
+UBIFS repair is suggested to be invoked when UBIFS image becomes inconsistent,
+for example:
+
+- UBIFS image cannot be mounted caused by corrupted data(eg. bad crc, bad lpt,
+  bad tnc, bad master node, bad log area, etc.) or inconsistent meta data(eg.
+  inode size is smaller than data length, lost dentry node, lost inode node,
+  wrong nlink, etc.).
+- Errors occurr in file accessing/reading, and error messages are related to
+  inconsistent meta data.
+- UBIFS becomes readonly caused by inconsistent meta data(eg. assertion failure
+  on metadata checking).
+- Other problems related to inconsistent UBIFS image.
+
+Invoke UBIFS repair by: echo ``UBIFS_DEV`` > /sys/kernel/debug/ubifs/repair_fs,
+``UBIFS_DEV`` could be:
+
+- ubiX_Y: X means UBI device number and Y means UBI volume number.
+  For example: echo "ubi0_0" > /sys/kernel/debug/ubifs/repair_fs
+- /dev/ubiX_Y: X means UBI device number and Y means UBI volume number.
+  For example: echo "/dev/ubi0_0" > /sys/kernel/debug/ubifs/repair_fs
+- ubiX:NAME: X means UBI device number and NAME means UBI volume name.
+  For example: echo "ubi0:userdata" > /sys/kernel/debug/ubifs/repair_fs
+
+References
+==========
+
+.. [1] https://lore.kernel.org/linux-mtd/1582293853-136727-1-git-send-email-chengzhihao1@huawei.com/
+
+.. [2] https://lore.kernel.org/linux-mtd/CAMxq0fNSWrUFMmmTs8Ri9gFOvS+KQJvZN3-_KuiqXi9bbmCB0Q@mail.gmail.com/
+
+.. [3] https://lore.kernel.org/linux-mtd/20211227032246.2886878-6-chengzhihao1@huawei.com/
+
+.. [4] https://lore.kernel.org/linux-mtd/1638777819.2925845.1695222544742.JavaMail.zimbra@robart.cc/T/#u
+
+.. [5] https://lore.kernel.org/linux-mtd/20190515203113.19398-1-richard@nod.at/
+
+.. [6] https://lore.kernel.org/linux-mtd/20190404223438.29408-1-richard@nod.at/
+
+.. [7] https://lore.kernel.org/linux-mtd/20210316085214.25024-1-guochun.mao@mediatek.com/
+
+.. [8] https://lore.kernel.org/linux-mtd/20180611225228.28931-1-richard@nod.at/
+
+.. [9] https://lore.kernel.org/linux-mtd/20180611214109.14424-1-richard@nod.at/
+
+.. [10] https://lore.kernel.org/linux-mtd/1476823591-6137-1-git-send-email-richard@nod.at/
+
+.. [11] https://lore.kernel.org/linux-mtd/1474495050-13529-1-git-send-email-pascal.eberhard@gmail.com/
+
+.. [12] https://lore.kernel.org/linux-mtd/1342340237-29656-1-git-send-email-dedekind1@gmail.com/
+
+.. [13] https://linux-mtd.infradead.narkive.com/bfcHzD0j/ubi-ubifs-corruptions-during-random-power-cuts
+
+.. [14] https://bugzilla.kernel.org/show_bug.cgi?id=218309
diff --git a/MAINTAINERS b/MAINTAINERS
index 7cef2d2ef8d7..6703dfb10369 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22161,8 +22161,9 @@ W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git next
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git fixes
 F:	Documentation/ABI/testing/sysfs-fs-ubifs
-F:	Documentation/filesystems/ubifs-authentication.rst
-F:	Documentation/filesystems/ubifs.rst
+F:	Documentation/filesystems/ubifs/authentication.rst
+F:	Documentation/filesystems/ubifs/main.rst
+F:	Documentation/filesystems/ubifs/repair.rst
 F:	fs/ubifs/
 
 UBLK USERSPACE BLOCK DRIVER
-- 
2.31.1


