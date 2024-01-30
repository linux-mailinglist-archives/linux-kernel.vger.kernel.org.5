Return-Path: <linux-kernel+bounces-44363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58848420E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7D2288D58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2124565BCD;
	Tue, 30 Jan 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WqkfrpWM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fxmqXdce";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WqkfrpWM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fxmqXdce"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97865BB9;
	Tue, 30 Jan 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609635; cv=none; b=tFFSqyfiPlmRHW0LnSt3epIT2YvqNvWPAiyqMtagDhciqGrrOX8dL6knxi2685/iqXOOQhwvVLx8IsuC4xtwQ7jOpTmCa2U80rVuuiFIAhkZjaUGuV0uciWMp5WjoEK6PO9fZVdNCKDs8Y5wEsn15IGk9g4NS7dDzem24YQvwZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609635; c=relaxed/simple;
	bh=ebwcJYHABdjmsH5ZUROMIvOoKuO8rxTQG5c3BzIWhBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyPHqXnhJY16MQaafvcQTD5KeeYZERkUK3q3n2r5jRY4AcjVk/CQxL5TTggQKRBRa9fXTMsXyjFDd9Poc5rZBBMW+Z3ViGExkUXEyuL6xekpmav1JO3Joes/nZr0iURI7pRQAroMCnbQQQcGuh4bYGJFsa1CuhYsKih4/rSOfGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WqkfrpWM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fxmqXdce; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WqkfrpWM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fxmqXdce; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 57D741F83F;
	Tue, 30 Jan 2024 10:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706609631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f3y+0iAPNbDl3HJP1v1zTF4zdJz4UdOj3bK+QYK5UT8=;
	b=WqkfrpWMHbGoM0n/J+fFxu2DH8Uc1steR+aUD+3Ul2WlwJqIWAGFZ/LkYZPY/Toa56Tvrf
	PWC5bId5hVtLc6eQe+WY9XU5GE3UXtEvmlM8kx4pj5yJAqTQGQLGa1+ZuDASdHBr8bS8hg
	8jaHbXzIU3lWM3hnvDiVc+IJyokIHlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706609631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f3y+0iAPNbDl3HJP1v1zTF4zdJz4UdOj3bK+QYK5UT8=;
	b=fxmqXdceamCXtKCAs8bstX1dTJmnLUFq/zG/YObfKX3L8bF48eh+CGtIBaTWonfqGEa/xm
	BaM00/16P9PGtYAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706609631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f3y+0iAPNbDl3HJP1v1zTF4zdJz4UdOj3bK+QYK5UT8=;
	b=WqkfrpWMHbGoM0n/J+fFxu2DH8Uc1steR+aUD+3Ul2WlwJqIWAGFZ/LkYZPY/Toa56Tvrf
	PWC5bId5hVtLc6eQe+WY9XU5GE3UXtEvmlM8kx4pj5yJAqTQGQLGa1+ZuDASdHBr8bS8hg
	8jaHbXzIU3lWM3hnvDiVc+IJyokIHlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706609631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f3y+0iAPNbDl3HJP1v1zTF4zdJz4UdOj3bK+QYK5UT8=;
	b=fxmqXdceamCXtKCAs8bstX1dTJmnLUFq/zG/YObfKX3L8bF48eh+CGtIBaTWonfqGEa/xm
	BaM00/16P9PGtYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA35013A66;
	Tue, 30 Jan 2024 10:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VxEBLd7LuGWZLAAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Tue, 30 Jan 2024 10:13:50 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 58312eee;
	Tue, 30 Jan 2024 10:13:45 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Cc: keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v3] keys: update key quotas in key_put()
Date: Tue, 30 Jan 2024 10:13:44 +0000
Message-ID: <20240130101344.28936-1-lhenriques@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Delaying key quotas update when key's refcount reaches 0 in key_put() has
been causing some issues in fscrypt testing, specifically in fstest
generic/581.  This commit fixes this test flakiness by dealing with the
quotas immediately, and leaving all the other clean-ups to the key garbage
collector.

This is done by moving the updates to the qnkeys and qnbytes fields in
struct key_user from key_gc_unused_keys() into key_put().  Unfortunately,
this also means that we need to switch to the irq-version of the spinlock
that protects these fields and use spin_lock_{irqsave,irqrestore} in all the
code that touches these fields.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
Changes since v2:
- Updated commit message as suggested by Jarkko, adding details on the
  implementation

 security/keys/gc.c     |  8 --------
 security/keys/key.c    | 32 ++++++++++++++++++++++----------
 security/keys/keyctl.c | 11 ++++++-----
 3 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index eaddaceda14e..7d687b0962b1 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -155,14 +155,6 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 
 		security_key_free(key);
 
-		/* deal with the user's key tracking and quota */
-		if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
-			spin_lock(&key->user->lock);
-			key->user->qnkeys--;
-			key->user->qnbytes -= key->quotalen;
-			spin_unlock(&key->user->lock);
-		}
-
 		atomic_dec(&key->user->nkeys);
 		if (state != KEY_IS_UNINSTANTIATED)
 			atomic_dec(&key->user->nikeys);
diff --git a/security/keys/key.c b/security/keys/key.c
index 5b10641debd5..ec155cfaae38 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -231,6 +231,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	struct key *key;
 	size_t desclen, quotalen;
 	int ret;
+	unsigned long irqflags;
 
 	key = ERR_PTR(-EINVAL);
 	if (!desc || !*desc)
@@ -260,7 +261,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 		unsigned maxbytes = uid_eq(uid, GLOBAL_ROOT_UID) ?
 			key_quota_root_maxbytes : key_quota_maxbytes;
 
-		spin_lock(&user->lock);
+		spin_lock_irqsave(&user->lock, irqflags);
 		if (!(flags & KEY_ALLOC_QUOTA_OVERRUN)) {
 			if (user->qnkeys + 1 > maxkeys ||
 			    user->qnbytes + quotalen > maxbytes ||
@@ -270,7 +271,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 
 		user->qnkeys++;
 		user->qnbytes += quotalen;
-		spin_unlock(&user->lock);
+		spin_unlock_irqrestore(&user->lock, irqflags);
 	}
 
 	/* allocate and initialise the key and its description */
@@ -328,10 +329,10 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	kfree(key->description);
 	kmem_cache_free(key_jar, key);
 	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA)) {
-		spin_lock(&user->lock);
+		spin_lock_irqsave(&user->lock, irqflags);
 		user->qnkeys--;
 		user->qnbytes -= quotalen;
-		spin_unlock(&user->lock);
+		spin_unlock_irqrestore(&user->lock, irqflags);
 	}
 	key_user_put(user);
 	key = ERR_PTR(ret);
@@ -341,10 +342,10 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	kmem_cache_free(key_jar, key);
 no_memory_2:
 	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA)) {
-		spin_lock(&user->lock);
+		spin_lock_irqsave(&user->lock, irqflags);
 		user->qnkeys--;
 		user->qnbytes -= quotalen;
-		spin_unlock(&user->lock);
+		spin_unlock_irqrestore(&user->lock, irqflags);
 	}
 	key_user_put(user);
 no_memory_1:
@@ -352,7 +353,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	goto error;
 
 no_quota:
-	spin_unlock(&user->lock);
+	spin_unlock_irqrestore(&user->lock, irqflags);
 	key_user_put(user);
 	key = ERR_PTR(-EDQUOT);
 	goto error;
@@ -381,8 +382,9 @@ int key_payload_reserve(struct key *key, size_t datalen)
 	if (delta != 0 && test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
 		unsigned maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
 			key_quota_root_maxbytes : key_quota_maxbytes;
+		unsigned long flags;
 
-		spin_lock(&key->user->lock);
+		spin_lock_irqsave(&key->user->lock, flags);
 
 		if (delta > 0 &&
 		    (key->user->qnbytes + delta > maxbytes ||
@@ -393,7 +395,7 @@ int key_payload_reserve(struct key *key, size_t datalen)
 			key->user->qnbytes += delta;
 			key->quotalen += delta;
 		}
-		spin_unlock(&key->user->lock);
+		spin_unlock_irqrestore(&key->user->lock, flags);
 	}
 
 	/* change the recorded data length if that didn't generate an error */
@@ -646,8 +648,18 @@ void key_put(struct key *key)
 	if (key) {
 		key_check(key);
 
-		if (refcount_dec_and_test(&key->usage))
+		if (refcount_dec_and_test(&key->usage)) {
+			unsigned long flags;
+
+			/* deal with the user's key tracking and quota */
+			if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
+				spin_lock_irqsave(&key->user->lock, flags);
+				key->user->qnkeys--;
+				key->user->qnbytes -= key->quotalen;
+				spin_unlock_irqrestore(&key->user->lock, flags);
+			}
 			schedule_work(&key_gc_work);
+		}
 	}
 }
 EXPORT_SYMBOL(key_put);
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 10ba439968f7..4bc3e9398ee3 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -954,6 +954,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 	long ret;
 	kuid_t uid;
 	kgid_t gid;
+	unsigned long flags;
 
 	uid = make_kuid(current_user_ns(), user);
 	gid = make_kgid(current_user_ns(), group);
@@ -1010,7 +1011,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 			unsigned maxbytes = uid_eq(uid, GLOBAL_ROOT_UID) ?
 				key_quota_root_maxbytes : key_quota_maxbytes;
 
-			spin_lock(&newowner->lock);
+			spin_lock_irqsave(&newowner->lock, flags);
 			if (newowner->qnkeys + 1 > maxkeys ||
 			    newowner->qnbytes + key->quotalen > maxbytes ||
 			    newowner->qnbytes + key->quotalen <
@@ -1019,12 +1020,12 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 
 			newowner->qnkeys++;
 			newowner->qnbytes += key->quotalen;
-			spin_unlock(&newowner->lock);
+			spin_unlock_irqrestore(&newowner->lock, flags);
 
-			spin_lock(&key->user->lock);
+			spin_lock_irqsave(&key->user->lock, flags);
 			key->user->qnkeys--;
 			key->user->qnbytes -= key->quotalen;
-			spin_unlock(&key->user->lock);
+			spin_unlock_irqrestore(&key->user->lock, flags);
 		}
 
 		atomic_dec(&key->user->nkeys);
@@ -1056,7 +1057,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 	return ret;
 
 quota_overrun:
-	spin_unlock(&newowner->lock);
+	spin_unlock_irqrestore(&newowner->lock, flags);
 	zapowner = newowner;
 	ret = -EDQUOT;
 	goto error_put;

