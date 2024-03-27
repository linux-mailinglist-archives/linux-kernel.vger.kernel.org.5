Return-Path: <linux-kernel+bounces-122165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD0988F2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E02B2234A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462061552EB;
	Wed, 27 Mar 2024 23:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+6EDexu"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8014F11F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581729; cv=none; b=E3yd4KLxRfZsRgEsErU2jkBJfRBzAJkIJf/dyFz1u3ya2bS/K4uvDWiDVW55kGrJlAy+Kp2HXvIkrXDE69f5mChrrbsrq9WkduTicDY+ACOdOkUcYpZILxE4qCaXM+aq5hVeDsD+VVsiCLsJ+IhV8b1QnUbiMAIusPlGntKGgZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581729; c=relaxed/simple;
	bh=genQle1dnjC/tcYAhJLWj2ZdmStfOip7SwdldmDZJ10=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S2x3Xsm7bo2jIXYwaLNYq4AYuSbuy99PWzA1SEIErsTGXdtbEXBw67972lEBUksJ3TTuZIPcTGqEejWE5/gfrTWbmVjzk5PNhczbYN/QwQ8HVXojzloX0VGmXXkbOn4fjNU4FosBvtzdIu6mW80fF6goQNvvzBTV1Lz8psEy+eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+6EDexu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1df01161b39so3389355ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711581727; x=1712186527; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+mD4qrrRfeWTdIqZYGCrVV289ijc09GRQuxlRnO0N+Q=;
        b=L+6EDexuvcUQFPHTEWIJUHlqk+5lw8JRNavXbPQznyxM5DLI585HvTzwTKlYQ1S03p
         QtZJlNPp34d9i1gaGnu3PUHNETsTdjXCWPmcKI9KZ46Tk1pHbdCej/yfTN+YzBgbKzkM
         oXrHL9RjlCNF0YyfcUCk13Q6WQPCRIGSeyLL2ud3/qZIpkCpmXPy03OSp2RE8TJdI4nq
         oX0Uo4j9A7IyeGUjDS/8QcdjZoaHXwYI9ZxZMHoFpb2dy/oukOqbfAs9fAlqVLn00i+z
         sYNN+KWPoYlmxNGA+RYvCHBAgBk8H4RgYL8374Yx6W+SBdhS3+AAB4cblwEuNtMdnPXO
         FkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711581727; x=1712186527;
        h=content-disposition:mime-version:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mD4qrrRfeWTdIqZYGCrVV289ijc09GRQuxlRnO0N+Q=;
        b=lSH2tHcBHQXIH5gDV4ewuv6DXl5d3QvCF+ypr6oPlihuMQQiW/S86PvP9Mo0H+YOGw
         XBI91VAWGjUtrfnMs4JRtmTE2QL1ySKH+/2lcCyPX5NL4HFWz69MPYUNiXWjfqPPv7U+
         9BUsq+EiQKZi/XOKd20Cf0wMskCgI7ix+yZ+84WER6qHtPp39d/QMYq8TwS+LMqJAMlP
         PoP0CZ1ew1ihczhyxaix7UhAEXZgisjgIi0nRAgWKrtJXDWYoJRGK82bVYaPzElVkjCb
         ul0rk3FZYVDkR5e32o5v/4C7MjoSwuJ1oHn164TMEkOcfihGkQP3UfzlBoLpNhZWtwQV
         YZmA==
X-Forwarded-Encrypted: i=1; AJvYcCVpQpFcYVkf+fyO92oKrpiHSXZ1PurSeI8UbqNMYENTOhe0tlN+WSjkRQk+1eqUk3IQMEsyEKYColUJEdMDeSdj7xDp3VaZIOEEkrfV
X-Gm-Message-State: AOJu0YxSIXi6dovSM6Fvwww51OyORmotj9Zipx4Wcs+hFe6w2eQ8+iER
	oB+599s+M2iU5sYpkwuGLgdLiKQbPfmNx47ndwa05QR9GF+r8NPjBXeP0Vi1l7w=
X-Google-Smtp-Source: AGHT+IGZQaRcemCZ5KSFdtOfMK2+k/2WDtxscZha6+vWJRcDx88RUiNrhozYlw7oFmDM1u1K+KGTTQ==
X-Received: by 2002:a17:903:230a:b0:1e0:b75a:8f8b with SMTP id d10-20020a170903230a00b001e0b75a8f8bmr1607050plh.45.1711581727139;
        Wed, 27 Mar 2024 16:22:07 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.68])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902d0d400b001d8aa88f59esm81649pln.110.2024.03.27.16.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 16:22:06 -0700 (PDT)
Date: Thu, 28 Mar 2024 04:52:01 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: fabio.maria.de.francesco@linux.intel.com, mic@digikod.net,
	florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	alison.schofield@intel.com
Cc: paul@paul-moore.com, outreachy@lists.linux.dev
Message-ID: <ZgSqGXDOg3CPZfaQ@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

linux-security-module@vger.kernel.org, ayushtiw0110@gmail.com 
Bcc: 
Subject: [PATCH] LANDLOCK: use kmem_cache for landlock_object
Reply-To: 

Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
struct landlock_object and update the related dependencies.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 security/landlock/fs.c     |  2 +-
 security/landlock/object.c | 14 ++++++++++++--
 security/landlock/object.h |  4 ++++
 security/landlock/setup.c  |  2 ++
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index fc520a06f9af..227dd67dd902 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -124,7 +124,7 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	if (unlikely(rcu_access_pointer(inode_sec->object))) {
 		/* Someone else just created the object, bail out and retry. */
 		spin_unlock(&inode->i_lock);
-		kfree(new_object);
+		kmem_cache_free(landlock_object_cache, new_object);
 
 		rcu_read_lock();
 		goto retry;
diff --git a/security/landlock/object.c b/security/landlock/object.c
index 1f50612f0185..df1354215617 100644
--- a/security/landlock/object.c
+++ b/security/landlock/object.c
@@ -17,6 +17,15 @@
 
 #include "object.h"
 
+struct kmem_cache *landlock_object_cache;
+
+void __init landlock_object_init(void)
+{
+	landlock_object_cache = kmem_cache_create(
+		"landlock_object_cache", sizeof(struct landlock_object), 0,
+		SLAB_PANIC, NULL);
+}
+
 struct landlock_object *
 landlock_create_object(const struct landlock_object_underops *const underops,
 		       void *const underobj)
@@ -25,7 +34,8 @@ landlock_create_object(const struct landlock_object_underops *const underops,
 
 	if (WARN_ON_ONCE(!underops || !underobj))
 		return ERR_PTR(-ENOENT);
-	new_object = kzalloc(sizeof(*new_object), GFP_KERNEL_ACCOUNT);
+	new_object =
+		kmem_cache_zalloc(landlock_object_cache, GFP_KERNEL_ACCOUNT);
 	if (!new_object)
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&new_object->usage, 1);
@@ -62,6 +72,6 @@ void landlock_put_object(struct landlock_object *const object)
 		 * @object->underobj to @object (if it still exists).
 		 */
 		object->underops->release(object);
-		kfree_rcu(object, rcu_free);
+		kmem_cache_free(landlock_object_cache, object);
 	}
 }
diff --git a/security/landlock/object.h b/security/landlock/object.h
index 5f28c35e8aa8..8ba1af3ddc2e 100644
--- a/security/landlock/object.h
+++ b/security/landlock/object.h
@@ -13,6 +13,10 @@
 #include <linux/refcount.h>
 #include <linux/spinlock.h>
 
+extern struct kmem_cache *landlock_object_cache;
+
+void __init landlock_object_init(void);
+
 struct landlock_object;
 
 /**
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index f6dd33143b7f..a5fca4582ee1 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -16,6 +16,7 @@
 #include "net.h"
 #include "ptrace.h"
 #include "setup.h"
+#include "object.h"
 
 bool landlock_initialized __ro_after_init = false;
 
@@ -33,6 +34,7 @@ const struct lsm_id landlock_lsmid = {
 
 static int __init landlock_init(void)
 {
+	landlock_object_init();
 	landlock_add_cred_hooks();
 	landlock_add_ptrace_hooks();
 	landlock_add_fs_hooks();
-- 
2.40.1


