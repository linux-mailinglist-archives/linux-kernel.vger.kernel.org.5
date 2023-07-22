Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226F975D952
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 05:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjGVDJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 23:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVDJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:09:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181FF3A9C;
        Fri, 21 Jul 2023 20:09:23 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R7BFt3Stkz18LhY;
        Sat, 22 Jul 2023 11:08:34 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 11:09:21 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dhowells@redhat.com>, <jarkko@kernel.org>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] keys: Remove unused extern declaration iterate_over_keyring()
Date:   Sat, 22 Jul 2023 11:08:32 +0800
Message-ID: <20230722030832.33680-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
this is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/keys/internal.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index 3c1e7122076b..95a82eec1816 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -112,10 +112,6 @@ extern key_ref_t find_key_to_update(key_ref_t keyring_ref,
 extern struct key *keyring_search_instkey(struct key *keyring,
 					  key_serial_t target_id);
 
-extern int iterate_over_keyring(const struct key *keyring,
-				int (*func)(const struct key *key, void *data),
-				void *data);
-
 struct keyring_search_context {
 	struct keyring_index_key index_key;
 	const struct cred	*cred;
-- 
2.34.1

