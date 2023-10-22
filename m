Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9D17D25A3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 21:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjJVTkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 15:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjJVTkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 15:40:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91911FB
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 12:40:36 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5C0623FADC
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 19:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698003635;
        bh=47jpj8y9wBd7Zg0OmQJRAjuqRq+DYCKjX3d9uClSbpk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=PAEgI/urxMwyeuPRnk98RIyEvk+Tmu+agMC9TUd46N45eoj9i/vZR+mwqhi5VG8ri
         NrR7rb9aW0yTkARG1sH0MogtvZ30wA5orsl/biNCI4WTui2pntXrG5QGfq95c9X+VD
         3Bm/FHAma7kYzyZS8XwMlixPWu1Ozbl+FVizB80QwnkPxelm2bbTwo0qbD6ybbxQGi
         bJgthf2tqYwf/5e+jpB6xSOXhR90K5enjkS9Yqr7aJloyFc1HQQutNukSaiuahQRMn
         7yjLLiB23LfzwWQ/HlMI3qqykuglPEv449JT60DTDLMxdDsRUvcjbW8v2rtVXfwDdZ
         Udgk2uAJfu+/g==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32da215295fso1015112f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 12:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698003634; x=1698608434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47jpj8y9wBd7Zg0OmQJRAjuqRq+DYCKjX3d9uClSbpk=;
        b=lTO9gzyGk24wplHwXw3Ocn19E4DXmoQirLNR6hDM7+vEF/o15uqeyxqIkUPcKn2ttV
         ZMPm+91u/AvGHVInGZ/4o/cwL/Hm2B/qeA7ZtxNwkxtftvl8ygA6Uy6mkodZPnQdXY5V
         GSZZQJMq5XtFFv80BYE0iCGe9fN2mZa83pIArwi2be3xCJFau2A/tCzsIUSVRuxTV0sY
         kvw5n/q3hzP5PbhItDgEu4Pq+9o793oI5ioWDdtgFUlRtC+BRc/p3Aryf263ewoxVnf/
         vXDHsfJO4ytQkajzn3qqvbJDfHnoSPz+LtCHXP/J+6kB9LisSFdcyEnCdJBjLIOZnTMB
         DXWA==
X-Gm-Message-State: AOJu0Yxkw4nf8yeZQGOMFOBwKd0kyd+Q5WtYWJBDxydHwFrANFq6ohZH
        pjskcaFNWFyCjJ4P4dt1N8o+RE9ZkhIBMEBIk6W+gwaZv/T8L5QUM4FJb5ESUDQS8yH1pj6XAc7
        lyB411pNqZvxAKQ2tzC+/PU34EPGMNT7zjsWF7oICQn+ZGSzswrRk
X-Received: by 2002:adf:ef8b:0:b0:32d:96a7:9551 with SMTP id d11-20020adfef8b000000b0032d96a79551mr4967358wro.36.1698003634505;
        Sun, 22 Oct 2023 12:40:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpLdRBIeVWYwo3xURbI5pzw5n3xFTx5Mo5MIsfkN8aLsxEaxi5atFcCBTp7YwPa6dq+CuLMg==
X-Received: by 2002:adf:ef8b:0:b0:32d:96a7:9551 with SMTP id d11-20020adfef8b000000b0032d96a79551mr4967354wro.36.1698003634173;
        Sun, 22 Oct 2023 12:40:34 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id q18-20020adff792000000b0030647449730sm6208438wrp.74.2023.10.22.12.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 12:40:33 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-crypto@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: switch SECURITY_APPARMOR_HASH from sha1 to sha256
Date:   Sun, 22 Oct 2023 20:40:26 +0100
Message-Id: <20231022194026.313584-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sha1 is insecure and has colisions, thus it is not useful for even
lightweight policy hash checks. Switch to sha256, which on modern
hardware is fast enough.

Separately as per NIST Policy on Hash Functions, sha1 usage must be
withdrawn by 2030. This config option currently is one of many that
holds up sha1 usage.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 security/apparmor/Kconfig      | 12 ++++++------
 security/apparmor/apparmorfs.c | 16 ++++++++--------
 security/apparmor/crypto.c     |  6 +++---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index e0d1dd0a19..64cc3044a4 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -57,10 +57,10 @@ config SECURITY_APPARMOR_INTROSPECT_POLICY
 	  cpu is paramount.
 
 config SECURITY_APPARMOR_HASH
-	bool "Enable introspection of sha1 hashes for loaded profiles"
+	bool "Enable introspection of sha256 hashes for loaded profiles"
 	depends on SECURITY_APPARMOR_INTROSPECT_POLICY
 	select CRYPTO
-	select CRYPTO_SHA1
+	select CRYPTO_SHA256
 	default y
 	help
 	  This option selects whether introspection of loaded policy
@@ -74,10 +74,10 @@ config SECURITY_APPARMOR_HASH_DEFAULT
        depends on SECURITY_APPARMOR_HASH
        default y
        help
-         This option selects whether sha1 hashing of loaded policy
-	 is enabled by default. The generation of sha1 hashes for
-	 loaded policy provide system administrators a quick way
-	 to verify that policy in the kernel matches what is expected,
+	 This option selects whether sha256 hashing of loaded policy
+	 is enabled by default. The generation of sha256 hashes for
+	 loaded policy provide system administrators a quick way to
+	 verify that policy in the kernel matches what is expected,
 	 however it can slow down policy load on some devices. In
 	 these cases policy hashing can be disabled by default and
 	 enabled only if needed.
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index a608a6bd76..082581397d 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1474,7 +1474,7 @@ int __aa_fs_create_rawdata(struct aa_ns *ns, struct aa_loaddata *rawdata)
 	rawdata->dents[AAFS_LOADDATA_REVISION] = dent;
 
 	if (aa_g_hash_policy) {
-		dent = aafs_create_file("sha1", S_IFREG | 0444, dir,
+		dent = aafs_create_file("sha256", S_IFREG | 0444, dir,
 					      rawdata, &seq_rawdata_hash_fops);
 		if (IS_ERR(dent))
 			goto fail;
@@ -1644,11 +1644,11 @@ static const char *rawdata_get_link_base(struct dentry *dentry,
 	return target;
 }
 
-static const char *rawdata_get_link_sha1(struct dentry *dentry,
+static const char *rawdata_get_link_sha256(struct dentry *dentry,
 					 struct inode *inode,
 					 struct delayed_call *done)
 {
-	return rawdata_get_link_base(dentry, inode, done, "sha1");
+	return rawdata_get_link_base(dentry, inode, done, "sha256");
 }
 
 static const char *rawdata_get_link_abi(struct dentry *dentry,
@@ -1665,8 +1665,8 @@ static const char *rawdata_get_link_data(struct dentry *dentry,
 	return rawdata_get_link_base(dentry, inode, done, "raw_data");
 }
 
-static const struct inode_operations rawdata_link_sha1_iops = {
-	.get_link	= rawdata_get_link_sha1,
+static const struct inode_operations rawdata_link_sha256_iops = {
+	.get_link	= rawdata_get_link_sha256,
 };
 
 static const struct inode_operations rawdata_link_abi_iops = {
@@ -1739,7 +1739,7 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 	profile->dents[AAFS_PROF_ATTACH] = dent;
 
 	if (profile->hash) {
-		dent = create_profile_file(dir, "sha1", profile,
+		dent = create_profile_file(dir, "sha256", profile,
 					   &seq_profile_hash_fops);
 		if (IS_ERR(dent))
 			goto fail;
@@ -1749,9 +1749,9 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 #ifdef CONFIG_SECURITY_APPARMOR_EXPORT_BINARY
 	if (profile->rawdata) {
 		if (aa_g_hash_policy) {
-			dent = aafs_create("raw_sha1", S_IFLNK | 0444, dir,
+			dent = aafs_create("raw_sha256", S_IFLNK | 0444, dir,
 					   profile->label.proxy, NULL, NULL,
-					   &rawdata_link_sha1_iops);
+					   &rawdata_link_sha256_iops);
 			if (IS_ERR(dent))
 				goto fail;
 			aa_get_proxy(profile->label.proxy);
diff --git a/security/apparmor/crypto.c b/security/apparmor/crypto.c
index 6724e2ff6d..aad486b2fc 100644
--- a/security/apparmor/crypto.c
+++ b/security/apparmor/crypto.c
@@ -106,16 +106,16 @@ static int __init init_profile_hash(void)
 	if (!apparmor_initialized)
 		return 0;
 
-	tfm = crypto_alloc_shash("sha1", 0, 0);
+	tfm = crypto_alloc_shash("sha256", 0, 0);
 	if (IS_ERR(tfm)) {
 		int error = PTR_ERR(tfm);
-		AA_ERROR("failed to setup profile sha1 hashing: %d\n", error);
+		AA_ERROR("failed to setup profile sha256 hashing: %d\n", error);
 		return error;
 	}
 	apparmor_tfm = tfm;
 	apparmor_hash_size = crypto_shash_digestsize(apparmor_tfm);
 
-	aa_info_message("AppArmor sha1 policy hashing enabled");
+	aa_info_message("AppArmor sha256 policy hashing enabled");
 
 	return 0;
 }
-- 
2.34.1

