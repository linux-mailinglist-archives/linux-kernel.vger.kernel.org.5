Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7E280B4B9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 15:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjLINwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 08:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLINw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 08:52:28 -0500
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F94710C4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 05:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1702129955; bh=S2vYkOAy+YL782OEnnJ/iLs01ZLLsMblP1/4x1SmMJs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=an+P+TM8XZyz/Xqd2l7iWWFoAKTP2xMW1h1lBv9g7PwTN3gpn1Kdd2focQ+S77vXQ
         bZBEoJK45jlKbGueeP6uc4tO0LBxNvSGyuq+d+FphLN2MNkP7/nHArnsk22dcFFKlU
         Y0IqwO5mopJD9gbSX6JYL6GLnfttfthC+dlST1ul8D6TX5lwcQk2lzJ9gvLb6anjpU
         pZl66xpHk2oG+mo0c/S0iimMKTVz8goiwQ6y+jRYcI492OHNGOzhS14AeNVHvVXtTr
         d1I3efCM+NdDWWgUMCJlwUsMVTw79+CDTnLcqMyHMbog6oXiD6Jh1vbbWQg5CeWaUy
         ZZk6ZhOqn9Ckg==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 2C39F2C0221;
        Sat,  9 Dec 2023 13:52:28 +0000 (UTC)
From:   sxwjean@me.com
To:     vbabka@suse.cz, 42.hyeyoo@gmail.com, cl@linux.com,
        linux-mm@kvack.org
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, corbet@lwn.net, keescook@chromium.org,
        arnd@arndb.de, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH v3 1/4] Documentation: kernel-parameters: remove noaliencache
Date:   Sat,  9 Dec 2023 21:52:00 +0800
Message-Id: <20231209135203.303508-2-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209135203.303508-1-sxwjean@me.com>
References: <20231209135203.303508-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 383jkZtHx_QieSF1aujsIMLABp7ydMQp
X-Proofpoint-GUID: 383jkZtHx_QieSF1aujsIMLABp7ydMQp
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 malwarescore=0 mlxlogscore=731 mlxscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2312090120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

ince slab allocator has already been removed. There is no users of
the noaliencachei parameter, so let's remove it.

Suggested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
v5: Collect Reviewed-by tag.
v4: Collect Reviewed-by tag.
v3: Remove the changes for slab_max_order.
v2: Add changes for removing "noaliencache".
    https://lore.kernel.org/linux-mm/20231122143603.85297-1-sxwjean@me.com/
v1: Remove slab_max_order.
    https://lore.kernel.org/linux-mm/20231120091214.150502-2-sxwjean@me.com/
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..9f94baeb2f82 100644
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
-- 
2.34.1

