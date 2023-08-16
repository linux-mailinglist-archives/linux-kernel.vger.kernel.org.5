Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7762B77E241
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245404AbjHPNMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245386AbjHPNL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:11:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013AE1FF3;
        Wed, 16 Aug 2023 06:11:56 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQpQ36Y4fzVjyX;
        Wed, 16 Aug 2023 21:09:47 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 21:11:53 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <dhowells@redhat.com>, <jarkko@kernel.org>, <yuehaibing@huawei.com>
CC:     <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] KEYS: Remove unused declarations
Date:   Wed, 16 Aug 2023 21:11:22 +0800
Message-ID: <20230816131122.43240-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These declarations are never implemented, remove it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/keys/dns_resolver-type.h | 4 ----
 include/linux/key.h              | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/include/keys/dns_resolver-type.h b/include/keys/dns_resolver-type.h
index 218ca22fb056..1b89088a2837 100644
--- a/include/keys/dns_resolver-type.h
+++ b/include/keys/dns_resolver-type.h
@@ -12,8 +12,4 @@
 
 extern struct key_type key_type_dns_resolver;
 
-extern int request_dns_resolver_key(const char *description,
-				    const char *callout_info,
-				    char **data);
-
 #endif /* _KEYS_DNS_RESOLVER_TYPE_H */
diff --git a/include/linux/key.h b/include/linux/key.h
index 938d7ecfb495..f16deadebca9 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -436,9 +436,6 @@ extern key_ref_t keyring_search(key_ref_t keyring,
 				const char *description,
 				bool recurse);
 
-extern int keyring_add_key(struct key *keyring,
-			   struct key *key);
-
 extern int keyring_restrict(key_ref_t keyring, const char *type,
 			    const char *restriction);
 
-- 
2.34.1

