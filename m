Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799137F4917
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344245AbjKVOgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjKVOgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:36:45 -0500
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E771AC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1700663801; bh=XgzjOA6VpboUIsRQsEa1gBHvNAppeoyf1BK3/lsO7ME=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=wlRIYxOKQN7njqHYi+70m8lPG9FNloZ/OdsLuREfLjMZIM8hG5gzKlHkuvUph9q6D
         +bNnQmTgHis1orJIKSEB2URIbFRk1lt4/xHeVCSLwQOQcCOpytnMbZlgj6KLeUWq1L
         wZcTPqOjDUUGpaSar+q5W3kyYBsfeiuRj+fLuy9hgVqHUugcRVcDKD/IieGQuFV/6o
         ghxsXSj/J3J9hUG2COAMzHug83bqURMctL2C6QJnbN3XqJeadP+GlAH4EJyNLjwgY/
         odoa5pbQxI4gLWUp+/BhUto2ZvnU0jv6mkxosVRuuUKIicP1KNxoHmy1Taw4AID8bm
         aboBe2u/Y6Lig==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 5770A3A0C18;
        Wed, 22 Nov 2023 14:36:36 +0000 (UTC)
From:   sxwjean@me.com
To:     42.hyeyoo@gmail.com, vbabka@suse.cz, linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH v2] Documentation: kernel-parameters: remove slab_max_order and noaliencache
Date:   Wed, 22 Nov 2023 22:36:03 +0800
Message-Id: <20231122143603.85297-1-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: l_lta4UJLzCFmn3o1DnHmhiV8lrNyLv4
X-Proofpoint-ORIG-GUID: l_lta4UJLzCFmn3o1DnHmhiV8lrNyLv4
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=840 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2311220104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

Since slab allocator has already been removed. There is no users about
slab_max_order and noaliencache, so let's remove them.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
v2: Hyeonggon Yoo <42.hyeyoo@gmail.com> suggested that noaliencache should be
removed too. Here adding this change. The patch is based on [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-remove-slab-v2r1

v1: https://lore.kernel.org/linux-mm/20231120091214.150502-1-sxwjean@me.com/T/#m55ebb45851bc86d650baf65dfe8296d33c5b1126
---
 Documentation/admin-guide/kernel-parameters.txt | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..d56a5beefe24 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3740,10 +3740,6 @@
 	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
-	noaliencache	[MM, NUMA, SLAB] Disables the allocation of alien
-			caches in the slab allocator.  Saves per-node memory,
-			but will impact performance.
-
 	noalign		[KNL,ARM]
 
 	noaltinstr	[S390] Disables alternative instructions patching
@@ -5887,12 +5883,6 @@
 			own.
 			For more information see Documentation/mm/slub.rst.
 
-	slab_max_order=	[MM, SLAB]
-			Determines the maximum allowed order for slabs.
-			A high setting may cause OOMs due to memory
-			fragmentation.  Defaults to 1 for systems with
-			more than 32MB of RAM, 0 otherwise.
-
 	slub_debug[=options[,slabs][;[options[,slabs]]...]	[MM, SLUB]
 			Enabling slub_debug allows one to determine the
 			culprit if slab objects become corrupted. Enabling
-- 
2.34.1

