Return-Path: <linux-kernel+bounces-105387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4522287DD34
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 13:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927AA281569
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A28E1B28D;
	Sun, 17 Mar 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og3cQA1N"
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DDF171A4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710679573; cv=none; b=h+elQH8tcBlf+hAJI/KfOKLXnKLDkTSvK7rOYeX5S5YpJtaCXX9p4VEpE9TwggdCcqUOe9ZzZ1D6w0koqChEIR5fxphn7FNWa2wLqXEX4ZU2IVpo1j0P2wPtsD55hc5SSt/0TgvcEpXxmrzc+COMYFjVYBFWfIYrRI/wpo0FTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710679573; c=relaxed/simple;
	bh=CxhjitrigcZMPkY5tR2pEokND8L8gkUCBYr16EYhEdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEXAkRNzwwqnw8xmT+opMS0Yu7hotGnJ08TOrF2KWIKl/PCSnONOZMWJmkNYEFrvyPMmxVrNDvB+D7CRXfu6WLnS0yn9FKrSBca/qRLFixZVn3izN9sEkgCsdTRWKT5NbZCW/eIiz3RgVWuCeh8pYFhEfPSWnhlvTlRZZl38eCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og3cQA1N; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-513e4dd6ca4so497573e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710679569; x=1711284369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/6wpTwlyyoDwkhztnd9V7WxL2PhOEJDNpVAABQDTTwo=;
        b=Og3cQA1NQ6J/KCIuq+jlvDE6pk8uYqLXBOkxHFkNQJq1fqL5ShYbKk4+mCbjlldb9r
         8YIUsTX8UN+QMOyXR/V4lg8MonC56ekgSBQGDk/cY8K/au4Wai7OUvowbBGqoOOWdO/j
         TkypV2vKA1ph8dhNt51xG0OeBuT3I2jzU7lwExZOqSrBvWF6cQNG/8DndWBdKTFFahy0
         adaSM1rEZxM1NIVHIOvGUn8A/nUcYhqhJqF1IixoBK/h4k7IV/SlaL/CQF+DX86rCMGl
         +Om+7fwxvQrVwcV7ARGbgESvJUuM5uyQAJVbzp4bvyRpm0erZPtZxi4S6JTyusLrKD+8
         XEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710679569; x=1711284369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6wpTwlyyoDwkhztnd9V7WxL2PhOEJDNpVAABQDTTwo=;
        b=aAO87ZxIFkTeo9wzhS99BN6Psbe4oUexh1oJ5xn1kWre6jNgENTVGYGFBUnsjnYM7K
         YpXIif/aHi+NkNOFwoLPYBmoz16Wm+wSDpvMchCnD/Xz2UwO8XwYN1bsaplyYpu62wwv
         zdet00biLZsONUfYwGewJPKJreAkeWhw0BgcCRa+r/EsYefoGf5Om00TPiW/CgXyFrGW
         JhPshN/8EnOkJwicQNjRQsx7DivxdvRoyTbZKMegKVJkNnqw6VerLZGaKtVbDfKUk8qt
         eWhgGyrWi4ZbiWUUwCacXXP2hESdvhTBsz82JwuSTDyfkv/flQ36/eiYsvsCkugJrZKT
         cL8g==
X-Forwarded-Encrypted: i=1; AJvYcCV78iKcb0/5vmtBKKLUZ9MKHurK+BWn4DHRZfVpTEwTAcedheHLj/QYWzGMem3tgSVvKRWuUeITNIsY6SWL0PiJyaQs5zK+wmt0ezsp
X-Gm-Message-State: AOJu0Yy1VtThBIKXI+QeVRjVsoyEXytdTmBytKK3qyVCBzRhFXnywdy4
	hdpcSPTTe1q98q0KF2CrUDheGMMZP4YRP/fJYi1VNEcJ40CvWKXh
X-Google-Smtp-Source: AGHT+IGYZgGVG8seASnrFtCqZDZUPnzsE4DBU9StDxk91y9Yt90ULIw52akDJU1hgsmSzwFQPVZkyw==
X-Received: by 2002:a19:e004:0:b0:513:d3ba:8da1 with SMTP id x4-20020a19e004000000b00513d3ba8da1mr3154810lfg.13.1710679569378;
        Sun, 17 Mar 2024 05:46:09 -0700 (PDT)
Received: from localhost.localdomain ([217.107.126.141])
        by smtp.gmail.com with ESMTPSA id q8-20020a056512210800b00513bd949eb1sm1234824lfr.17.2024.03.17.05.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 05:46:09 -0700 (PDT)
From: yorha.op@gmail.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Alex Rusuf <yorha.op@gmail.com>
Subject: [PATCH 1/1] mm/gup: pass flags by value in faultin_page
Date: Sun, 17 Mar 2024 15:46:11 +0300
Message-ID: <20240317124611.81280-1-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From: Alex Rusuf <yorha.op@gmail.com>

There's no need to pass flags as a pointer,
because it's not expected to be changed now.

Signed-off-by: Alex Rusuf <yorha.op@gmail.com>
---
 mm/gup.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 231711efa390..f308785fa530 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -915,19 +915,19 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
  * to 0 and -EBUSY returned.
  */
 static int faultin_page(struct vm_area_struct *vma,
-		unsigned long address, unsigned int *flags, bool unshare,
+		unsigned long address, unsigned int flags, bool unshare,
 		int *locked)
 {
 	unsigned int fault_flags = 0;
 	vm_fault_t ret;
 
-	if (*flags & FOLL_NOFAULT)
+	if (flags & FOLL_NOFAULT)
 		return -EFAULT;
-	if (*flags & FOLL_WRITE)
+	if (flags & FOLL_WRITE)
 		fault_flags |= FAULT_FLAG_WRITE;
-	if (*flags & FOLL_REMOTE)
+	if (flags & FOLL_REMOTE)
 		fault_flags |= FAULT_FLAG_REMOTE;
-	if (*flags & FOLL_UNLOCKABLE) {
+	if (flags & FOLL_UNLOCKABLE) {
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 		/*
 		 * FAULT_FLAG_INTERRUPTIBLE is opt-in. GUP callers must set
@@ -935,12 +935,12 @@ static int faultin_page(struct vm_area_struct *vma,
 		 * That's because some callers may not be prepared to
 		 * handle early exits caused by non-fatal signals.
 		 */
-		if (*flags & FOLL_INTERRUPTIBLE)
+		if (flags & FOLL_INTERRUPTIBLE)
 			fault_flags |= FAULT_FLAG_INTERRUPTIBLE;
 	}
-	if (*flags & FOLL_NOWAIT)
+	if (flags & FOLL_NOWAIT)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT;
-	if (*flags & FOLL_TRIED) {
+	if (flags & FOLL_TRIED) {
 		/*
 		 * Note: FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_TRIED
 		 * can co-exist
@@ -974,7 +974,7 @@ static int faultin_page(struct vm_area_struct *vma,
 	}
 
 	if (ret & VM_FAULT_ERROR) {
-		int err = vm_fault_to_errno(ret, *flags);
+		int err = vm_fault_to_errno(ret, flags);
 
 		if (err)
 			return err;
@@ -1236,7 +1236,7 @@ static long __get_user_pages(struct mm_struct *mm,
 
 		page = follow_page_mask(vma, start, foll_flags, &ctx);
 		if (!page || PTR_ERR(page) == -EMLINK) {
-			ret = faultin_page(vma, start, &foll_flags,
+			ret = faultin_page(vma, start, foll_flags,
 					   PTR_ERR(page) == -EMLINK, locked);
 			switch (ret) {
 			case 0:
-- 
2.42.0


