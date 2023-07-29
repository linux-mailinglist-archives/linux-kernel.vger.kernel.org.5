Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32968767B93
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 04:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjG2Ck5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 22:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjG2Ckt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 22:40:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFCF1711;
        Fri, 28 Jul 2023 19:40:47 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RCTHS3N5wzrRh6;
        Sat, 29 Jul 2023 10:39:48 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 29 Jul
 2023 10:40:45 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <dhowells@redhat.com>, <jarkko@kernel.org>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <yuehaibing@huawei.com>
CC:     <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 -next] keys: Remove unused extern declarations
Date:   Sat, 29 Jul 2023 10:40:26 +0800
Message-ID: <20230729024026.32228-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Since commit b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
iterate_over_keyring() is never used, so can be removed.

And commit b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate keys")
left behind keyring_search_instkey().

Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate keys")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v3: Add Fixes tag
v2: Also remove keyring_search_instkey()
---
 security/keys/internal.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index 3c1e7122076b..471cf36dedc0 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -109,13 +109,6 @@ extern void __key_link_end(struct key *keyring,
 extern key_ref_t find_key_to_update(key_ref_t keyring_ref,
 				    const struct keyring_index_key *index_key);
 
-extern struct key *keyring_search_instkey(struct key *keyring,
-					  key_serial_t target_id);
-
-extern int iterate_over_keyring(const struct key *keyring,
-				int (*func)(const struct key *key, void *data),
-				void *data);
-
 struct keyring_search_context {
 	struct keyring_index_key index_key;
 	const struct cred	*cred;
-- 
2.34.1

