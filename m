Return-Path: <linux-kernel+bounces-21777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 807C282941B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FF71F21D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5DE3EA75;
	Wed, 10 Jan 2024 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVyzr681"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63433D98C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704870944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3LBEoP+OVX8UUvtwqHYPUzM09NfmAQKAOTayWOj3vA=;
	b=aVyzr681vZ4l0CeFmJsBPca0h3QuqqpnUnIBR1xgCtA6B7OfVgbpS549INK2nyjoHhTZHQ
	ubrfMvjZBTVwnny1MeCiZhM2lB3YmkeSnH2+wt2E0TOjE2eJrOp4VBKYfZNyPd6PqNpVFL
	3vChWzpTq3xcdyf4S3vW2nDihBAqxuA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-X2FAWZGzN1azlHHFzhdO9Q-1; Wed, 10 Jan 2024 02:15:38 -0500
X-MC-Unique: X2FAWZGzN1azlHHFzhdO9Q-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ce105ddef5so1654940a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704870937; x=1705475737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3LBEoP+OVX8UUvtwqHYPUzM09NfmAQKAOTayWOj3vA=;
        b=WoeMVpLDeni1ImA/vaTuJSrrmmdkAFTHYDY0SrwVk0jPdAnA8cgRsFsa0wLcZB63d2
         GvH8xtyk2H7oSPg4tdXQJ57tO9KQ/pVNX9zOHEbv3kFsHW8MIt7xJsTBVe2aPcktaF7G
         td86ChP6zwaApztzJ1l34toqnnA8lblvmRZWBIv6M4HIwtsG1Zf8IeFZ11ve14mMYJL3
         N7nLcW+tts7QyLQX3GcCeFdEL2uG5pkC//UFvCVxqMKDmqrqzu2PpPyNnKZnjdOhnI2g
         6SYZSQqXULYxn3Q0+oDBMUWwf6BeA/6xLRCEAOXGTemHrxv77MfD07CxAFRK9eaok5uZ
         Nf2g==
X-Gm-Message-State: AOJu0YydB3KTaSdmY/rcuAvx9KZAOiVwHzL+I9zfrzLU4UFfcYqQWNPv
	+iStjlwPVZm5xzsd25rvCiuNDq5ZKkQHuzrmxw5jKYSheoMRl9w1T7eojVVf7JS5gHy2It6qqle
	k+uySK1UGON0zUZr0D/OzKtfHJ8XKVQ5H
X-Received: by 2002:a05:6a20:549e:b0:199:c19b:a256 with SMTP id i30-20020a056a20549e00b00199c19ba256mr404149pzk.48.1704870937095;
        Tue, 09 Jan 2024 23:15:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3nLLyWzEHi8GA97DXbubxlvK/ZzzZcacj++eTqbSYnzzAxKQ7SEAvlr+1Nh2nV5RIQChmgA==
X-Received: by 2002:a05:6a20:549e:b0:199:c19b:a256 with SMTP id i30-20020a056a20549e00b00199c19ba256mr404133pzk.48.1704870936721;
        Tue, 09 Jan 2024 23:15:36 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001d46a313b42sm2888381pls.268.2024.01.09.23.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:15:36 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v2 3/5] crash_dump: retrieve dm crypt key in kdump kernel
Date: Wed, 10 Jan 2024 15:15:18 +0800
Message-ID: <20240110071522.1308935-4-coxu@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110071522.1308935-1-coxu@redhat.com>
References: <20240110071522.1308935-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Crash kernel will retrieve the dm crypt volume key based on the
dmcryptkey command line parameter. When user space writes the key
description to /sys/kernel/crash_dm_crypt_key, the crash kernel will
save the encryption key to the user keyring. Then user space e.g.
cryptsetup's --volume-key-keyring API can use it to unlock the encrypted
device.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_dump.h   |   2 +
 kernel/crash_dump_dm_crypt.c | 115 ++++++++++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index acc55626afdc..b44adc3962da 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -15,6 +15,8 @@
 extern unsigned long long elfcorehdr_addr;
 extern unsigned long long elfcorehdr_size;
 
+extern unsigned long long luks_volume_key_addr;
+
 #ifdef CONFIG_CRASH_DUMP
 extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
 extern void elfcorehdr_free(unsigned long long addr);
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 3a0b0b773598..755017fa5c1b 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -1,7 +1,82 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/key.h>
+#include <linux/keyctl.h>
 #include <keys/user-type.h>
 #include <linux/crash_dump.h>
 
+unsigned long long dm_crypt_key_addr;
+EXPORT_SYMBOL_GPL(dm_crypt_key_addr);
+
+static int __init setup_dmcryptkey(char *arg)
+{
+	char *end;
+
+	if (!arg)
+		return -EINVAL;
+	dm_crypt_key_addr = memparse(arg, &end);
+	if (end > arg)
+		return 0;
+
+	dm_crypt_key_addr = 0;
+	return -EINVAL;
+}
+
+early_param("dmcryptkey", setup_dmcryptkey);
+
+/*
+ * Architectures may override this function to read dm crypt key
+ */
+ssize_t __weak dm_crypt_key_read(char *buf, size_t count, u64 *ppos)
+{
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	return read_from_oldmem(&iter, count, ppos, false);
+}
+
+static int retrive_kdump_dm_crypt_key(u8 *buffer, unsigned int *sz)
+{
+	unsigned int key_size;
+	size_t dm_crypt_keybuf_sz;
+	unsigned int *size_ptr;
+	char *dm_crypt_keybuf;
+	u64 addr;
+	int r;
+
+	if (dm_crypt_key_addr == 0) {
+		pr_debug("dm crypt key memory address inaccessible");
+		return -EINVAL;
+	}
+
+	addr = dm_crypt_key_addr;
+
+	/* Read dm crypt key size */
+	r = dm_crypt_key_read((char *)&key_size, sizeof(unsigned int), &addr);
+
+	if (r < 0)
+		return r;
+
+	pr_debug("Retrieve dm crypt key: size=%u\n", key_size);
+	/* Read in dm cryptrkey */
+	dm_crypt_keybuf_sz = sizeof(unsigned int) + key_size * sizeof(u8);
+	dm_crypt_keybuf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					      get_order(dm_crypt_keybuf_sz));
+	if (!dm_crypt_keybuf)
+		return -ENOMEM;
+
+	addr = dm_crypt_key_addr;
+	r = dm_crypt_key_read((char *)dm_crypt_keybuf, dm_crypt_keybuf_sz, &addr);
+
+	if (r < 0)
+		return r;
+	size_ptr = (unsigned int *)dm_crypt_keybuf;
+	memcpy(buffer, size_ptr + 1, key_size * sizeof(u8));
+	pr_debug("Retrieve dm crypt key (size=%u): %48ph...\n", key_size, buffer);
+	*sz = key_size;
+	return 0;
+}
+
 static u8 *dm_crypt_key;
 static unsigned int dm_crypt_key_size;
 
@@ -23,6 +98,43 @@ static DECLARE_DELAYED_WORK(wipe_dm_crypt_key_work, _wipe_dm_crypt_key);
 
 static unsigned __read_mostly wipe_key_delay = 120; /* 2 mins */
 
+static int retore_dm_crypt_key_to_thread_keyring(const char *key_desc)
+{
+	key_ref_t keyring_ref, key_ref;
+	int ret;
+
+	/* find the target keyring (which must be writable) */
+	keyring_ref = lookup_user_key(KEY_SPEC_USER_KEYRING, 0x01, KEY_NEED_WRITE);
+	if (IS_ERR(keyring_ref)) {
+		pr_alert("Failed to get keyring");
+		return PTR_ERR(keyring_ref);
+	}
+
+	dm_crypt_key = kmalloc(128, GFP_KERNEL);
+	ret = retrive_kdump_dm_crypt_key(dm_crypt_key, &dm_crypt_key_size);
+	if (ret) {
+		kfree(dm_crypt_key);
+		return ret;
+	}
+
+	/* create or update the requested key and add it to the target keyring */
+	key_ref = key_create_or_update(keyring_ref, "user", key_desc,
+				       dm_crypt_key, dm_crypt_key_size,
+				       KEY_USR_ALL, KEY_ALLOC_IN_QUOTA);
+
+	if (!IS_ERR(key_ref)) {
+		ret = key_ref_to_ptr(key_ref)->serial;
+		key_ref_put(key_ref);
+		pr_alert("Success adding key %s", key_desc);
+	} else {
+		ret = PTR_ERR(key_ref);
+		pr_alert("Error when adding key");
+	}
+
+	key_ref_put(keyring_ref);
+	return ret;
+}
+
 static int crash_save_temp_dm_crypt_key(const char *key_desc, size_t count)
 {
 	const struct user_key_payload *ukp;
@@ -60,7 +172,8 @@ int crash_sysfs_dm_crypt_key_write(const char *key_desc, size_t count)
 {
 	if (!is_kdump_kernel())
 		return crash_save_temp_dm_crypt_key(key_desc, count);
-	return -EINVAL;
+	else
+		return retore_dm_crypt_key_to_thread_keyring(key_desc);
 }
 EXPORT_SYMBOL(crash_sysfs_dm_crypt_key_write);
 
-- 
2.43.0


