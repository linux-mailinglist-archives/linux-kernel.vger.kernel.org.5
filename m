Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534247EF5EB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjKQQMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjKQQMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:12:36 -0500
Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF12111D;
        Fri, 17 Nov 2023 08:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5097; q=dns/txt; s=iport;
  t=1700237552; x=1701447152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/NH0YWL5gm8V0phm/O3rkb1/g0nTScLJ9wh4qMptA9M=;
  b=SwYNuwk/05wy3c3g8hVSq3woYVX6p7PeM/Yfryd1m+6u+3cjONH/2M3p
   I2hXrIWUr/0ml6pWnkQIZPM+YTjux7fX1ODYu/MyygQlseDejJ4FUmZxH
   MBfJj9yMmdLhnwRRYhF0URWmMsA4LQ4p7Su8+Wbb5dvK4mCER7lXCVs9e
   4=;
X-CSE-ConnectionGUID: VPnjM9NWQdGesiVwHAeUUg==
X-CSE-MsgGUID: MxUbRDLGRvmROIrSK6C1JA==
X-IronPort-AV: E=Sophos;i="6.04,206,1695686400"; 
   d="scan'208";a="9619884"
Received: from aer-iport-nat.cisco.com (HELO aer-core-9.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 16:12:29 +0000
Received: from localhost (dhcp-10-61-101-82.cisco.com [10.61.101.82])
        (authenticated bits=0)
        by aer-core-9.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3AHGCSUJ047870
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 17 Nov 2023 16:12:28 GMT
From:   Ariel Miculas <amiculas@cisco.com>
To:     linux-doc@vger.kernel.org
Cc:     serge@hallyn.com, Ariel Miculas <amiculas@cisco.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] docs: filesystems: document the squashfs specific mount options
Date:   Fri, 17 Nov 2023 18:12:14 +0200
Message-ID: <20231117161215.140282-1-amiculas@cisco.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.101.82, dhcp-10-61-101-82.cisco.com
X-Outbound-Node: aer-core-9.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SQUASHFS_CHOICE_DECOMP_BY_MOUNT is set, the "threads" mount option
can be used to specify the decompression mode: single-threaded,
multi-threaded, percpu or the number of threads used for decompression.
When SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set, SQUASHFS_DECOMP_MULTI
and SQUASHFS_MOUNT_DECOMP_THREADS are both set, the "threads" option can
also be used to specify the number of threads used for decompression.
This mount option is only mentioned in fs/squashfs/Kconfig, which makes
it difficult to find.

Another mount option available is "errors", which can be configured to
panic the kernel when squashfs errors are encountered.

Add both these options to the squashfs documentation, making them more
noticeable.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
V2 -> V3: When SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set, the "threads"
mount option also requires SQUASHFS_MOUNT_DECOMP_THREADS to be set, in
addition to SQUASHFS_DECOMP_MULTI

V1 -> V2: When SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set, the "threads"
mount option also requires SQUASHFS_DECOMP_MULTI to be set

 Documentation/filesystems/squashfs.rst | 60 ++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/filesystems/squashfs.rst b/Documentation/filesystems/squashfs.rst
index df42106bae71..4af8d6207509 100644
--- a/Documentation/filesystems/squashfs.rst
+++ b/Documentation/filesystems/squashfs.rst
@@ -64,6 +64,66 @@ obtained from this site also.
 The squashfs-tools development tree is now located on kernel.org
 	git://git.kernel.org/pub/scm/fs/squashfs/squashfs-tools.git
 
+2.1 Mount options
+-----------------
+===================    =========================================================
+errors=%s              Specify whether squashfs errors trigger a kernel panic
+                       or not
+
+		       ==========  =============================================
+                         continue  errors don't trigger a panic (default)
+                            panic  trigger a panic when errors are encountered,
+                                   similar to several other filesystems (e.g.
+                                   btrfs, ext4, f2fs, GFS2, jfs, ntfs, ubifs)
+
+                                   This allows a kernel dump to be saved,
+                                   useful for analyzing and debugging the
+                                   corruption.
+                       ==========  =============================================
+threads=%s             Select the decompression mode or the number of threads
+
+                       If SQUASHFS_CHOICE_DECOMP_BY_MOUNT is set:
+
+		       ==========  =============================================
+                           single  use single-threaded decompression (default)
+
+                                   Only one block (data or metadata) can be
+                                   decompressed at any one time. This limits
+                                   CPU and memory usage to a minimum, but it
+                                   also gives poor performance on parallel I/O
+                                   workloads when using multiple CPU machines
+                                   due to waiting on decompressor availability.
+                            multi  use up to two parallel decompressors per core
+
+                                   If you have a parallel I/O workload and your
+                                   system has enough memory, using this option
+                                   may improve overall I/O performance. It
+                                   dynamically allocates decompressors on a
+                                   demand basis.
+                           percpu  use a maximum of one decompressor per core
+
+                                   It uses percpu variables to ensure
+                                   decompression is load-balanced across the
+                                   cores.
+                        1|2|3|...  configure the number of threads used for
+                                   decompression
+
+                                   The upper limit is num_online_cpus() * 2.
+                       ==========  =============================================
+
+                       If SQUASHFS_CHOICE_DECOMP_BY_MOUNT is **not** set and
+                       SQUASHFS_DECOMP_MULTI, SQUASHFS_MOUNT_DECOMP_THREADS are
+                       both set:
+
+		       ==========  =============================================
+                          2|3|...  configure the number of threads used for
+                                   decompression
+
+                                   The upper limit is num_online_cpus() * 2.
+                       ==========  =============================================
+
+===================    =========================================================
+
 3. Squashfs Filesystem Design
 -----------------------------
 
-- 
2.42.1

