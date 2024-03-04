Return-Path: <linux-kernel+bounces-90944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C07870751
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6911528299A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C2F4D9ED;
	Mon,  4 Mar 2024 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYZoXbaS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B08C495F0;
	Mon,  4 Mar 2024 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570219; cv=none; b=FjYv2ciytNIqAqyF5SVPd5YIH5zHCjnVRwEiqNGwgLjJ5Gt5V0+p96hOiXM6BAqZnESVT7R4VOofPhw7fKJ6LMexJN+WwdZAlHO5gOxz8jdfxnzwzTuelHZxALPeyBYEnVq+FPVdRmrk1hM/QdTA12oKkfKOdL/9UO3k5yy0iW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570219; c=relaxed/simple;
	bh=xOyOxEs2LoaPprIcK9amuUKq49ywZ782kUPidDTbhpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GpSXLv4jN2JMAXLW+Mr9pH+d2ty8bte+S/q3qdOAFu6n5g6J+9erv1W4LFIQEL0WbWUa+uKEa+9i4HwjdPb4oKUvEFjMzSY1bj8dwBkk3ZBXqOY19ZRw8eSEdJBoXBvf40JJBnB5QCU1ONqRDpJQYfV6tRPbs9hIBbAaXrv2gWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYZoXbaS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412e795f458so5010535e9.3;
        Mon, 04 Mar 2024 08:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709570216; x=1710175016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D57LV4PQlM/pc6do6owRfCiEmFwq5OiC/rPbAO2Ui6E=;
        b=KYZoXbaSMOFw8K/OSrgdGeCZN+jK3CMjmG3/huWGbn7OhCtttDXLiLJsMn22TC4xci
         kZITrCn6bFzs+YSslxN4Pd913PoyDxDaGYaTpQM5xKlNqg0pV73XrdhrgIM8ExFbQVMW
         3RKjV55C3Zqet6JkHYbxDvlUDyLyOmTCAvo7Atj2P6Tu42Tsg5EPIe9amOoJDN6nif6U
         dSIfkH8hN/0wj11q+m1cRJiO/DMtRyA8R9tp84mBxp5tGYNA2Ixf2t/wJSh0dtbHuvK3
         yQZnet4sNb4eNyR4lAWb0Uy9k2wOfLiYPVUgGkNiqtt0CzvLtWZseb4vgRyJGzrqcOQS
         6q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709570216; x=1710175016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D57LV4PQlM/pc6do6owRfCiEmFwq5OiC/rPbAO2Ui6E=;
        b=nxVSCwg6/+x+KWpS3xKWjhGpj0BeBZwdDqox7IEv74IsQYfRR0rwFunEVN6/oOZ4bE
         PdyGEu5klxs306nssZNFWOB2/o0uM6wQTT/OXDkCS7wIi9ZmE3fT3HFhBgNJjETZJcSo
         THE0HEUefqUh5H9xFV2FWj5Y3U9gv/MieI4h1mV/MKknsq8sCNiLZbqkZy9hOo4YEbud
         QIDgr5FcsG9FSm62/561UfqsWplv5KRp6Pp76mRfVLaTcngY1wFvcV5d5lQAhXPv297K
         l2fCXVMYg6fwiLtC8lFsNGT/sOYibZmAofJjWDWy2r9JkB1iow0FwkALmcWt0+7Mk3ZA
         8Jtg==
X-Forwarded-Encrypted: i=1; AJvYcCW6oHTicWpSXEinUxJ+njYqS0ATCGFWecSOaNe0rmW+B+3sFrfENy4tIAZiLZgG2OKQqm6Hb/KrZ/AaCSfI4gz4wvG0B2+bWEi6MNSO5dxEhalpf8BqYpuRf2QA6X/qMSa5a689+2Gpb+/hxdqKLxrc+FiS
X-Gm-Message-State: AOJu0YwoHFBWBiPava60URzV8KRqGZ9wP/RpbmG8rxEAbxcKUWptw9Oe
	QsZAJNj+vLvTIFeATrs2RgNZQaNhVfAtR4yhYqWYSqgMCE5EWbTJ
X-Google-Smtp-Source: AGHT+IGwhHmhMCQY5Wj9Ojyw77j2lS7hN7OmHTas5EyAlXpHFn/hpF7T3R90MIEi3AEaS8ApQIaj/g==
X-Received: by 2002:a05:600c:4f83:b0:412:bef7:317c with SMTP id n3-20020a05600c4f8300b00412bef7317cmr8052982wmq.13.1709570216101;
        Mon, 04 Mar 2024 08:36:56 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k4-20020a05600c1c8400b00412e556d4besm2679933wms.48.2024.03.04.08.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:36:55 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] apparmor: remove useless static inline function is_deleted
Date: Mon,  4 Mar 2024 16:36:55 +0000
Message-Id: <20240304163655.771616-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The inlined function is_deleted is redundant, it is not called at all
from any function in security/apparmor/file.c and so it can be removed.

Cleans up clang scan build warning:
security/apparmor/file.c:153:20: warning: unused function
'is_deleted' [-Wunused-function]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 security/apparmor/file.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index c03eb7c19f16..d52a5b14dad4 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -144,19 +144,6 @@ int aa_audit_file(const struct cred *subj_cred,
 	return aa_audit(type, profile, &ad, file_audit_cb);
 }
 
-/**
- * is_deleted - test if a file has been completely unlinked
- * @dentry: dentry of file to test for deletion  (NOT NULL)
- *
- * Returns: true if deleted else false
- */
-static inline bool is_deleted(struct dentry *dentry)
-{
-	if (d_unlinked(dentry) && d_backing_inode(dentry)->i_nlink == 0)
-		return true;
-	return false;
-}
-
 static int path_name(const char *op, const struct cred *subj_cred,
 		     struct aa_label *label,
 		     const struct path *path, int flags, char *buffer,
-- 
2.39.2


