Return-Path: <linux-kernel+bounces-416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71568140C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB8C283FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790E7107A8;
	Fri, 15 Dec 2023 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="1b8ySxpm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pv50p00im-ztdg10021901.me.com (pv50p00im-ztdg10021901.me.com [17.58.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F61078F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1702611814; bh=pu4d5aNzA1zqsUzUFwgPinQJl+CtlywCevtlg+7cEw8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=1b8ySxpmUmF/WfrjnX7hWNTOFJXzRUlqS+zypQV+Z3pT5zSf3XGZP6XcgWAOvssI7
	 RWMTcncJrbal6ww0qvfHjbCGfUV7GUddbxj303J307YALcGK0dQKtHBSak3ri8wCjm
	 8Ura9mNB7SpAFkwXFVZSokF8Ao2sXriVurQLUfC8BvP1SDepw6yEMBmKs/PQUOC2Dn
	 PsJk8SqTzsIoB/KiaXEH1UNWB06meJTCKihdhVw8HgFpbwRR2grSMFLT2B0ET5uK/U
	 1GdDfZKGn+/Ze3d5sh7iky0zU4/le4cpIolAIFl3rjiHM29diH6a7X2Wi4vzl9CJ/O
	 +Ei9iTA7stBgA==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id B57338151D;
	Fri, 15 Dec 2023 03:43:27 +0000 (UTC)
From: sxwjean@me.com
To: vbabka@suse.cz,
	42.hyeyoo@gmail.com,
	cl@linux.com,
	linux-mm@kvack.org
Cc: penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	roman.gushchin@linux.dev,
	corbet@lwn.net,
	keescook@chromium.org,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	quic_jjohnson@quicinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH v4 3/4] mm/slub: replace slub_$params with slab_$params in slub.rst
Date: Fri, 15 Dec 2023 11:41:49 +0800
Message-Id: <20231215034150.108783-4-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215034150.108783-1-sxwjean@me.com>
References: <20231215034150.108783-1-sxwjean@me.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: irjatwxLXpPhIhTP0epExD4SmTt0yzW1
X-Proofpoint-ORIG-GUID: irjatwxLXpPhIhTP0epExD4SmTt0yzW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_17,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2312150026

From: Xiongwei Song <xiongwei.song@windriver.com>

We've unified slab parameters with "slab_$params", then we can use
slab_$params in Documentation/mm/slub.rst.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 Documentation/mm/slub.rst | 60 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
index be75971532f5..6579a55b7852 100644
--- a/Documentation/mm/slub.rst
+++ b/Documentation/mm/slub.rst
@@ -9,7 +9,7 @@ SLUB can enable debugging only for selected slabs in order to avoid
 an impact on overall system performance which may make a bug more
 difficult to find.
 
-In order to switch debugging on one can add an option ``slub_debug``
+In order to switch debugging on one can add an option ``slab_debug``
 to the kernel command line. That will enable full debugging for
 all slabs.
 
@@ -26,16 +26,16 @@ be enabled on the command line. F.e. no tracking information will be
 available without debugging on and validation can only partially
 be performed if debugging was not switched on.
 
-Some more sophisticated uses of slub_debug:
+Some more sophisticated uses of slab_debug:
 -------------------------------------------
 
-Parameters may be given to ``slub_debug``. If none is specified then full
+Parameters may be given to ``slab_debug``. If none is specified then full
 debugging is enabled. Format:
 
-slub_debug=<Debug-Options>
+slab_debug=<Debug-Options>
 	Enable options for all slabs
 
-slub_debug=<Debug-Options>,<slab name1>,<slab name2>,...
+slab_debug=<Debug-Options>,<slab name1>,<slab name2>,...
 	Enable options only for select slabs (no spaces
 	after a comma)
 
@@ -60,23 +60,23 @@ Possible debug options are::
 
 F.e. in order to boot just with sanity checks and red zoning one would specify::
 
-	slub_debug=FZ
+	slab_debug=FZ
 
 Trying to find an issue in the dentry cache? Try::
 
-	slub_debug=,dentry
+	slab_debug=,dentry
 
 to only enable debugging on the dentry cache.  You may use an asterisk at the
 end of the slab name, in order to cover all slabs with the same prefix.  For
 example, here's how you can poison the dentry cache as well as all kmalloc
 slabs::
 
-	slub_debug=P,kmalloc-*,dentry
+	slab_debug=P,kmalloc-*,dentry
 
 Red zoning and tracking may realign the slab.  We can just apply sanity checks
 to the dentry cache with::
 
-	slub_debug=F,dentry
+	slab_debug=F,dentry
 
 Debugging options may require the minimum possible slab order to increase as
 a result of storing the metadata (for example, caches with PAGE_SIZE object
@@ -84,20 +84,20 @@ sizes).  This has a higher liklihood of resulting in slab allocation errors
 in low memory situations or if there's high fragmentation of memory.  To
 switch off debugging for such caches by default, use::
 
-	slub_debug=O
+	slab_debug=O
 
 You can apply different options to different list of slab names, using blocks
 of options. This will enable red zoning for dentry and user tracking for
 kmalloc. All other slabs will not get any debugging enabled::
 
-	slub_debug=Z,dentry;U,kmalloc-*
+	slab_debug=Z,dentry;U,kmalloc-*
 
 You can also enable options (e.g. sanity checks and poisoning) for all caches
 except some that are deemed too performance critical and don't need to be
 debugged by specifying global debug options followed by a list of slab names
 with "-" as options::
 
-	slub_debug=FZ;-,zs_handle,zspage
+	slab_debug=FZ;-,zs_handle,zspage
 
 The state of each debug option for a slab can be found in the respective files
 under::
@@ -105,7 +105,7 @@ under::
 	/sys/kernel/slab/<slab name>/
 
 If the file contains 1, the option is enabled, 0 means disabled. The debug
-options from the ``slub_debug`` parameter translate to the following files::
+options from the ``slab_debug`` parameter translate to the following files::
 
 	F	sanity_checks
 	Z	red_zone
@@ -129,7 +129,7 @@ in order to reduce overhead and increase cache hotness of objects.
 Slab validation
 ===============
 
-SLUB can validate all object if the kernel was booted with slub_debug. In
+SLUB can validate all object if the kernel was booted with slab_debug. In
 order to do so you must have the ``slabinfo`` tool. Then you can do
 ::
 
@@ -150,29 +150,29 @@ list_lock once in a while to deal with partial slabs. That overhead is
 governed by the order of the allocation for each slab. The allocations
 can be influenced by kernel parameters:
 
-.. slub_min_objects=x		(default 4)
-.. slub_min_order=x		(default 0)
-.. slub_max_order=x		(default 3 (PAGE_ALLOC_COSTLY_ORDER))
+.. slab_min_objects=x		(default 4)
+.. slab_min_order=x		(default 0)
+.. slab_max_order=x		(default 3 (PAGE_ALLOC_COSTLY_ORDER))
 
-``slub_min_objects``
+``slab_min_objects``
 	allows to specify how many objects must at least fit into one
 	slab in order for the allocation order to be acceptable.  In
 	general slub will be able to perform this number of
 	allocations on a slab without consulting centralized resources
 	(list_lock) where contention may occur.
 
-``slub_min_order``
+``slab_min_order``
 	specifies a minimum order of slabs. A similar effect like
-	``slub_min_objects``.
+	``slab_min_objects``.
 
-``slub_max_order``
-	specified the order at which ``slub_min_objects`` should no
+``slab_max_order``
+	specified the order at which ``slab_min_objects`` should no
 	longer be checked. This is useful to avoid SLUB trying to
-	generate super large order pages to fit ``slub_min_objects``
+	generate super large order pages to fit ``slab_min_objects``
 	of a slab cache with large object sizes into one high order
 	page. Setting command line parameter
 	``debug_guardpage_minorder=N`` (N > 0), forces setting
-	``slub_max_order`` to 0, what cause minimum possible order of
+	``slab_max_order`` to 0, what cause minimum possible order of
 	slabs allocation.
 
 SLUB Debug output
@@ -219,7 +219,7 @@ Here is a sample of slub debug output::
  FIX kmalloc-8: Restoring Redzone 0xc90f6d28-0xc90f6d2b=0xcc
 
 If SLUB encounters a corrupted object (full detection requires the kernel
-to be booted with slub_debug) then the following output will be dumped
+to be booted with slab_debug) then the following output will be dumped
 into the syslog:
 
 1. Description of the problem encountered
@@ -239,7 +239,7 @@ into the syslog:
 	pid=<pid of the process>
 
    (Object allocation / free information is only available if SLAB_STORE_USER is
-   set for the slab. slub_debug sets that option)
+   set for the slab. slab_debug sets that option)
 
 2. The object contents if an object was involved.
 
@@ -262,7 +262,7 @@ into the syslog:
 	the object boundary.
 
 	(Redzone information is only available if SLAB_RED_ZONE is set.
-	slub_debug sets that option)
+	slab_debug sets that option)
 
    Padding <address> : <bytes>
 	Unused data to fill up the space in order to get the next object
@@ -296,7 +296,7 @@ Emergency operations
 
 Minimal debugging (sanity checks alone) can be enabled by booting with::
 
-	slub_debug=F
+	slab_debug=F
 
 This will be generally be enough to enable the resiliency features of slub
 which will keep the system running even if a bad kernel component will
@@ -311,13 +311,13 @@ and enabling debugging only for that cache
 
 I.e.::
 
-	slub_debug=F,dentry
+	slab_debug=F,dentry
 
 If the corruption occurs by writing after the end of the object then it
 may be advisable to enable a Redzone to avoid corrupting the beginning
 of other objects::
 
-	slub_debug=FZ,dentry
+	slab_debug=FZ,dentry
 
 Extended slabinfo mode and plotting
 ===================================
-- 
2.34.1


