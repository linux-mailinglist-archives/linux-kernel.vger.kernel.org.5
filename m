Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9360F801FFB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 01:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjLCAQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 19:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjLCAQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 19:16:50 -0500
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BF813A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 16:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1701562616; bh=UkWhhz1yudvdliDY1UWHxKQEvL85ZeI0mAdRV1sW2sg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=RSk4Wv8HOlDt444Dd514CovTON6ThDBwPzt8bfiKU3So/xoPLs3dqqLgySypd73w5
         Ce43wlTVFk6cGdRZJu9MQJ+nDwCsOVN3CKjFf26VbgzJ1ZqQGyCYWladSIrlLeK4yE
         xDmeCZm69IWM91ROpKZh8NsAMNW+xTHcbzoxD+LNT7AUzRPTiMVXygrzltt4wjqH9a
         RsD/YmBQGS/BfTFWn6JH5B5D0ZEZS+2oG4jf+UUhyaDUrsW6IpxIlim9WgIE0GYdL3
         dIXXXeDPuwlPCu29+xET+LaHvo8Npdjd2mzkPBpXcJnHMq3IpbjGQ5ygwSDoo2SlLP
         LumH+YK5mjH+A==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 75430C800C0;
        Sun,  3 Dec 2023 00:16:50 +0000 (UTC)
From:   sxwjean@me.com
To:     vbabka@suse.cz, 42.hyeyoo@gmail.com, cl@linux.com,
        linux-mm@kvack.org
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, corbet@lwn.net, keescook@chromium.org,
        arnd@arndb.de, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH v2 3/3] mm/slub: correct the default value of slub_min_objects in doc
Date:   Sun,  3 Dec 2023 08:15:01 +0800
Message-Id: <20231203001501.126339-4-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203001501.126339-1-sxwjean@me.com>
References: <20231203001501.126339-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Rtt4dbLleoIBTkMumi-JfIC8Wq0WE36R
X-Proofpoint-ORIG-GUID: Rtt4dbLleoIBTkMumi-JfIC8Wq0WE36R
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2312030000
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
index be75971532f5..1f4399581449 100644
--- a/Documentation/mm/slub.rst
+++ b/Documentation/mm/slub.rst
@@ -150,7 +150,7 @@ list_lock once in a while to deal with partial slabs. That overhead is
 governed by the order of the allocation for each slab. The allocations
 can be influenced by kernel parameters:
 
-.. slub_min_objects=x		(default 4)
+.. slub_min_objects=x		(default 0)
 .. slub_min_order=x		(default 0)
 .. slub_max_order=x		(default 3 (PAGE_ALLOC_COSTLY_ORDER))
 
-- 
2.34.1

