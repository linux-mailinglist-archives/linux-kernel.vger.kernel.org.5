Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FCE80B4BB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 15:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjLINxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 08:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjLINxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 08:53:15 -0500
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6221712
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 05:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1702129997; bh=C/CNUr2LNMn6Qo2xusn2tYrx0721oOslxNy000GbTmM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=NbLX2F/cUDL44mi2SabkraD2VVk0hY3/rQGXB0k0Wvss5Rl3/TzCj3rrYn2EQbwSW
         FQ7gPhh95AINJgEs4XfJfywasGju3vyAlydBFrDe41RjZvk0ZoahwBhtPuiGNznmHl
         jhcxu3Nz44xIXu3D0og6FisvlzScDOozYJI0/52yW50wFS8n2lr7+LQSYJrga/uD4Y
         l6HvHiS5lt0fS+PLUa6tcFt8Tg4GrGsdrmbhDaYXwx2NjPbIvHknXaSNMZ1v2ZCrVr
         Qo4v7h12JT9DGYqaZLqFGEND+Q9Q+r7gOoRRvIHo0utE6b3NWWlhbltUmoHMgWNLu/
         RqlVNJzHrBdYg==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 2C2122C0207;
        Sat,  9 Dec 2023 13:53:10 +0000 (UTC)
From:   sxwjean@me.com
To:     vbabka@suse.cz, 42.hyeyoo@gmail.com, cl@linux.com,
        linux-mm@kvack.org
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, corbet@lwn.net, keescook@chromium.org,
        arnd@arndb.de, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH v3 4/4] mm/slub: correct the default value of slub_min_objects in doc
Date:   Sat,  9 Dec 2023 21:52:03 +0800
Message-Id: <20231209135203.303508-5-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209135203.303508-1-sxwjean@me.com>
References: <20231209135203.303508-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SFeMuhdIpG0w4U9kk62gVDJSZEQihs1C
X-Proofpoint-GUID: SFeMuhdIpG0w4U9kk62gVDJSZEQihs1C
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
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

There is no a value assigned to slub_min_objects by default, it always
is 0 that is initialized by compiler if no assigned value by command line.
min_objects is calculated based on processor numbers in calculate_order().
For more details, see commit 9b2cd506e5f2 ("slub: Calculate min_objects
based on number of processors.")

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 Documentation/mm/slub.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
index 6579a55b7852..56b27f493ba7 100644
--- a/Documentation/mm/slub.rst
+++ b/Documentation/mm/slub.rst
@@ -150,7 +150,7 @@ list_lock once in a while to deal with partial slabs. That overhead is
 governed by the order of the allocation for each slab. The allocations
 can be influenced by kernel parameters:
 
-.. slab_min_objects=x		(default 4)
+.. slab_min_objects=x		(default 0)
 .. slab_min_order=x		(default 0)
 .. slab_max_order=x		(default 3 (PAGE_ALLOC_COSTLY_ORDER))
 
-- 
2.34.1

