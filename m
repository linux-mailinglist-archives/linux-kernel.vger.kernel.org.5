Return-Path: <linux-kernel+bounces-125740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AB1892B7D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F941F212BD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5C52D638;
	Sat, 30 Mar 2024 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0GrYD4m"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C18BFC;
	Sat, 30 Mar 2024 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711806872; cv=none; b=fJd19SYNO8WavivY/PzYWyuS1WwlMsaPqasDgFn0ewFLyx39wGlVef0JQlZlchBFxgeYmSV5hIqKyHCWhhPFUgv+gROriKoz10E3LcpgW5J6S3Oufa6vyRx4przrniZrkvWMa+HEXPL6nDNSh4nV/y/O6m0lmvAbsfa80oSopKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711806872; c=relaxed/simple;
	bh=fedmjVSg0DUkzLNTvNvlEWO9S467LP+p2s3GtiDdmBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xq/GvcNR9dq1CV119upPag2xC1cQctcgFGoYldctQeepxQlzJnv5MI5DIRTHtYKxMRGAgTGKOqx6+OV2IkU0VMgsiBpwpOxUi0p5+hBlE13D+3mgXElzN/Ll2Kj4Llzut/0J6suUr3fK6rOR39foCmJmotQxH+8G2sEOGSf7M3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0GrYD4m; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e00d1e13a2so19697255ad.0;
        Sat, 30 Mar 2024 06:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711806870; x=1712411670; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oqh2nZliN5w5CydPn9rkbQtrtD4gRqfg8XL3I/NhjWQ=;
        b=d0GrYD4mJVJyY8ZJf/2cTDD2DRfW506BtcfkC0czCrldLBLrn/L6xZ1pRoG73h1GiX
         QL8LT6QTMtGUl49Pd4VxEz3wnqQaxkcnekW3FGYBmSqUT9xsx77njHcoQiPF5QCQr4Pz
         o4OR65bhHJw/iKL+AjmXrggze+6W80ewo6BFu4m7qiW4/vVLJYafpwY+lEt4tjRExiXp
         26tnQ5nmQXkPpQs/MogVwfPS/i0r0vbWCDyvam0qDGakGiM3xLJ7wokkK1ondHQNvaYc
         6ryNjuPnLZebi5vrYDstC1WWajptgC17Ar5He2t3Icr1CqYUlycHn/Dp4TT3r4dlnFMI
         y3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711806870; x=1712411670;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oqh2nZliN5w5CydPn9rkbQtrtD4gRqfg8XL3I/NhjWQ=;
        b=B/GN7R8YfUa6HcxJypUysCORQXtjOSWZQV/NUAV89BAWFmhUMmcHiwx+Is7KPvetiF
         B7Vl6q3tZVxT5BbTVyie/3eprgxucsC9BGvzZMxIk82QYLijjY9/l87bQLjdkJNYQZVn
         b9FqGtnxDxWnAoYQAhAQR1M+393l/Mzj2z+jQGmLKJlkvjcRqanoxc7Hzq7TPVDay00L
         iYd4q44rW7pRIpXVagCAgZkpWSs3FFY9RIHkTFGpAYlnflCAS3TQDp/t4H33WDUnB5iv
         V30Fyb/KeRv7l5/50Za+sVP8bFd7QcmOrfgoK8y/Ox4E6CoYqfjn7tmS1XX+Oa0vHBEA
         ihRg==
X-Forwarded-Encrypted: i=1; AJvYcCX00c6PlGBy0RyLuPLoKIp6JMyRbysefUoOB+gIEj5NqrzLyQsY4bk1pg4jdQsxrDlax+X4T+lJVkjvtYgyzkVrZA52owVIeJTTLJI7gSKThKYeh+IJYHLQH/x7aeHRea89r8VYEXOIUnJ1r00mfosfOj67
X-Gm-Message-State: AOJu0YxkCVm+yssR8y/RP4nY3Lc5PKG1zrZOwnQYgMEiuuGeabvhzm4q
	x1+ZDihCtPQC0ToRtM/WAnIBv6GPlKQCSFq1HB3dT2ojVTieGZz779T3webNz3A=
X-Google-Smtp-Source: AGHT+IHJAfl9nwTCg8S5xj8XlnhljcNjKRD0XBtulcVCZbbgtY27MBizPM6f5asDQjBwaT7Zg+3Ofg==
X-Received: by 2002:a17:902:d4c3:b0:1e0:b5e8:7467 with SMTP id o3-20020a170902d4c300b001e0b5e87467mr5920862plg.3.1711806869527;
        Sat, 30 Mar 2024 06:54:29 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([2409:40e3:103e:d98f:6ff5:fd6a:83ef:b115])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b001dcb654d1a5sm5249616plg.21.2024.03.30.06.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 06:54:29 -0700 (PDT)
Date: Sat, 30 Mar 2024 19:24:19 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: alison.schofield@intel.com, paul@paul-moore.com, mic@digikod.net,
	fabio.maria.de.francesco@linux.intel.com,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc: outreachy@lists.linux.dev, linux-security-module@vger.kernel.org
Subject: [PATCH v2] landlock: Use kmem for landlock_object
Message-ID: <ZggZi/EFICvb4xTU@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
struct landlock_object and update the related dependencies to improve
memory allocation and deallocation performance. This patch does not
change kfree() and kfree_rcu() calls because according to kernel commit
ae65a5211d90("mm/slab: document kfree() as allowed for
kmem_cache_alloc() objects"), starting from kernel 6.4 with
CONFIG_SLOB, kfree() is safe to use for such objects.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---

Changes in v2: Used clang-format and corrected the removal of kfree_rcu.
Tried to use KMEM macro but due to lack of cache pointer in that macro,
had to explicitly define landlock_object_cache, as done in security.c.

 security/landlock/object.c | 12 +++++++++++-
 security/landlock/object.h |  2 ++
 security/landlock/setup.c  |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/security/landlock/object.c b/security/landlock/object.c
index 1f50612f0185..cfc367725624 100644
--- a/security/landlock/object.c
+++ b/security/landlock/object.c
@@ -17,6 +17,15 @@
 
 #include "object.h"
 
+static struct kmem_cache *landlock_object_cache;
+
+void __init landlock_object_cache_init(void)
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
diff --git a/security/landlock/object.h b/security/landlock/object.h
index 5f28c35e8aa8..d9967ef16ec1 100644
--- a/security/landlock/object.h
+++ b/security/landlock/object.h
@@ -15,6 +15,8 @@
 
 struct landlock_object;
 
+void __init landlock_object_cache_init(void);
+
 /**
  * struct landlock_object_underops - Operations on an underlying object
  */
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index f6dd33143b7f..525820fc03ec 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -33,6 +33,7 @@ const struct lsm_id landlock_lsmid = {
 
 static int __init landlock_init(void)
 {
+	landlock_object_cache_init();
 	landlock_add_cred_hooks();
 	landlock_add_ptrace_hooks();
 	landlock_add_fs_hooks();
-- 
2.40.1


