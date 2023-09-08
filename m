Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B67990C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbjIHUD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344458AbjIHUD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47CB1B1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694203374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4V6bm459ozDimu1heDZpH+ZMi6MrCIxlIoO52rIEKGg=;
        b=EyPYY9Nf+VsSKq+x0nZagV//r6Gg45xFBWo1dW1udqEyiibSG/Z5GkaCRDR+h/CyAWk/mx
        OqpngClcXI/a7jTebBGFaM8D7czKhzR2d8SMJ22DIsMIouGlMhSNM52m8re0Jkzn7AoyCw
        rSk4PfgaItberM0gG7F62LC9e0T2Sh8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-hf-upcDMPLm8sPpn-AIaew-1; Fri, 08 Sep 2023 16:02:52 -0400
X-MC-Unique: hf-upcDMPLm8sPpn-AIaew-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4121a931b1fso3336161cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 13:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203372; x=1694808172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4V6bm459ozDimu1heDZpH+ZMi6MrCIxlIoO52rIEKGg=;
        b=l1AURkn2dbDsdFSB6YNqjx8OFxyY1mjlGdx5IkMzWzij1o3Zidsy0FLuX4AduWK0QP
         Y4Uxv8KRHp8+ULZLK31pOhDgw3+9B4sQ7EZWL1mbcD+evcG0QDPvqeFQ/viFPyaJu1/3
         pGhcZ/j5yw5k0Z5JcRH3ZmpZyVNrwc4GbgJewnU28+TIQfHHPpNZYWyOS460inweRzXG
         98fBcWho19AV3PAt3iE7CqbNdP9kl/Y+x1z3wHOFBX3L8KIOJqwjsnmlug/J0ZaBfXHe
         TqcmSn8YWURUTTr0ngYKVnq99Q5tmbEN93sVZF3swyJi0n6JSumq5Pmeucigakm79r3P
         xQAA==
X-Gm-Message-State: AOJu0YzWDRbS2dUJdhgsCVtYKHhw7qJFUGqpW4mqiyTHoZ89yHbxYt8J
        OKJRRnEDlAm4RQ8LZKK5nekxJctLmWOrgyq5XeYBPxl122nhMlecP1lOoiNK3hL8n8Njz5cFN3t
        uL4+/NrTS0Csxf9uwTnPcmu4K
X-Received: by 2002:a05:622a:1997:b0:40f:da40:88a with SMTP id u23-20020a05622a199700b0040fda40088amr3927398qtc.4.1694203372365;
        Fri, 08 Sep 2023 13:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUR/6fW5sKr+U41wFGsfMKmuUv8vxb4fBBYTs7l3DnJhhPgBBiRmpLahG272yCMwIEUruJgg==
X-Received: by 2002:a05:622a:1997:b0:40f:da40:88a with SMTP id u23-20020a05622a199700b0040fda40088amr3927365qtc.4.1694203372058;
        Fri, 08 Sep 2023 13:02:52 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id x19-20020ac85393000000b0041511b21a7csm262984qtp.40.2023.09.08.13.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:02:51 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>
Cc:     VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>
Subject: [PATCH v2 1/5] string.h: add array-wrappers for (v)memdup_user()
Date:   Fri,  8 Sep 2023 21:59:40 +0200
Message-ID: <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694202430.git.pstanner@redhat.com>
References: <cover.1694202430.git.pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, user array duplications are sometimes done without an
overflow check. Sometimes the checks are done manually; sometimes the
array size is calculated with array_size() and sometimes by calculating
n * size directly in code.

Introduce wrappers for arrays for memdup_user() and vmemdup_user() to
provide a standardized and safe way for duplicating user arrays.

This is both for new code as well as replacing usage of (v)memdup_user()
in existing code that uses, e.g., n * size to calculate array sizes.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 include/linux/string.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..8c9fc76c7154 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -5,7 +5,9 @@
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/errno.h>	/* for E2BIG */
+#include <linux/overflow.h>	/* for check_mul_overflow() */
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -14,6 +16,44 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/**
+ * memdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result is physically
+ * contiguous, to be freed by kfree().
+ */
+static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (unlikely(check_mul_overflow(n, size, &nbytes)))
+		return ERR_PTR(-EOVERFLOW);
+
+	return memdup_user(src, nbytes);
+}
+
+/**
+ * vmemdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result may be not
+ * physically contiguous. Use kvfree() to free.
+ */
+static inline void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (unlikely(check_mul_overflow(n, size, &nbytes)))
+		return ERR_PTR(-EOVERFLOW);
+
+	return vmemdup_user(src, nbytes);
+}
+
 /*
  * Include machine specific inline routines
  */
-- 
2.41.0

