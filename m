Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06B875B2DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjGTPfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjGTPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:34:52 -0400
Received: from frasgout13.his.huawei.com (ecs-14-137-139-46.compute.hwclouds-dns.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703131BC1;
        Thu, 20 Jul 2023 08:34:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4R6Gft0xYyz9xyNR;
        Thu, 20 Jul 2023 23:23:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBHquXFU7lkGHDRBA--.21759S4;
        Thu, 20 Jul 2023 16:34:10 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, pbrobinson@gmail.com,
        zbyszek@in.waw.pl, wiktor@metacode.biz,
        devel@lists.sequoia-pgp.org, gnupg-devel@gnupg.org,
        ebiggers@kernel.org, Jason@zx2c4.com, mail@maciej.szmigiero.name,
        antony@vennard.ch, konstantin@linuxfoundation.org,
        James.Bottomley@HansenPartnership.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 2/9] crypto: Export public key algorithm information
Date:   Thu, 20 Jul 2023 17:32:38 +0200
Message-Id: <20230720153247.3755856-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
References: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHquXFU7lkGHDRBA--.21759S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy7ur13WrW8Gw47uw1UGFg_yoWrGFWDpr
        s09a1rX3y8ZFy7KryS9FyFyryft3yF9r15tanrXw1fAFn7tw18Jrs2vrZrCF1kXFsrJ3yr
        ua97ZF9rGw18GaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4y-0wAAsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Export the public keys algorithm identifiers, so that user space can
reference them when passing data to the kernel.

Define and export the pub_key_algo_name array, so that kernel subsystems
can get the string associated to the public key algorithm identifier.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/Kconfig                    |  3 +++
 crypto/Makefile                   |  1 +
 crypto/pub_key_info.c             | 20 ++++++++++++++++++++
 include/crypto/pub_key_info.h     | 15 +++++++++++++++
 include/uapi/linux/pub_key_info.h | 22 ++++++++++++++++++++++
 5 files changed, 61 insertions(+)
 create mode 100644 crypto/pub_key_info.c
 create mode 100644 include/crypto/pub_key_info.h
 create mode 100644 include/uapi/linux/pub_key_info.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 650b1b3620d..2558025461b 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1420,6 +1420,9 @@ endmenu
 config CRYPTO_HASH_INFO
 	bool
 
+config CRYPTO_PUB_KEY_INFO
+	bool
+
 if !KMSAN # avoid false positives from assembly
 if ARM
 source "arch/arm/crypto/Kconfig"
diff --git a/crypto/Makefile b/crypto/Makefile
index 953a7e105e5..fcdb5918e58 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -206,6 +206,7 @@ obj-$(CONFIG_XOR_BLOCKS) += xor.o
 obj-$(CONFIG_ASYNC_CORE) += async_tx/
 obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += asymmetric_keys/
 obj-$(CONFIG_CRYPTO_HASH_INFO) += hash_info.o
+obj-$(CONFIG_CRYPTO_PUB_KEY_INFO) += pub_key_info.o
 crypto_simd-y := simd.o
 obj-$(CONFIG_CRYPTO_SIMD) += crypto_simd.o
 
diff --git a/crypto/pub_key_info.c b/crypto/pub_key_info.c
new file mode 100644
index 00000000000..d12a08e5972
--- /dev/null
+++ b/crypto/pub_key_info.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Public key info: Public key algorithms information
+ */
+
+#include <linux/export.h>
+#include <crypto/pub_key_info.h>
+
+const char *const pub_key_algo_name[PKEY_ALGO__LAST] = {
+	[PKEY_ALGO_RSA]		= "rsa",
+	[PKEY_ALGO_ECDSA]	= "ecdsa",
+	[PKEY_ALGO_ECDSA_P192]	= "ecdsa-nist-p192",
+	[PKEY_ALGO_ECDSA_P256]	= "ecdsa-nist-p256",
+	[PKEY_ALGO_ECDSA_P384]	= "ecdsa-nist-p384",
+	[PKEY_ALGO_ECRDSA]	= "ecrdsa",
+	[PKEY_ALGO_SM2]		= "sm2",
+};
+EXPORT_SYMBOL_GPL(pub_key_algo_name);
diff --git a/include/crypto/pub_key_info.h b/include/crypto/pub_key_info.h
new file mode 100644
index 00000000000..ea411792778
--- /dev/null
+++ b/include/crypto/pub_key_info.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Public key info: Public key algorithms information
+ */
+
+#ifndef _CRYPTO_PUB_KEY_INFO_H
+#define _CRYPTO_PUB_KEY_INFO_H
+
+#include <uapi/linux/pub_key_info.h>
+
+extern const char *const pub_key_algo_name[PKEY_ALGO__LAST];
+
+#endif /* _CRYPTO_PUB_KEY_INFO_H */
diff --git a/include/uapi/linux/pub_key_info.h b/include/uapi/linux/pub_key_info.h
new file mode 100644
index 00000000000..a5595969156
--- /dev/null
+++ b/include/uapi/linux/pub_key_info.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Public key info: Public key algorithms information
+ */
+
+#ifndef _UAPI_LINUX_PUB_KEY_INFO_H
+#define _UAPI_LINUX_PUB_KEY_INFO_H
+
+enum pub_key_algo {
+	PKEY_ALGO_RSA,
+	PKEY_ALGO_ECDSA,
+	PKEY_ALGO_ECDSA_P192,
+	PKEY_ALGO_ECDSA_P256,
+	PKEY_ALGO_ECDSA_P384,
+	PKEY_ALGO_ECRDSA,
+	PKEY_ALGO_SM2,
+	PKEY_ALGO__LAST,
+};
+
+#endif /* _UAPI_LINUX_PUB_KEY_INFO_H */
-- 
2.34.1

