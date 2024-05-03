Return-Path: <linux-kernel+bounces-167488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A568BAA2B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C556E1C21B70
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6641E14F9D5;
	Fri,  3 May 2024 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkA02YFj"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8314A601
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729835; cv=none; b=qp+n+3+tdKhNoTgqKYNVHh8oWbV5gcxzn2xiNS0yb3gjnFRgDmI1RUNm9Uj5GU941oCGOKo2nwcB33kBZG6tRLKqBMB82SqSWnroYnx4VNLUssIA4dKuCol69fHr0oW4q9EcXoUgFa6kImpvvbjXULa1/GNke2OMttQoaSDMLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729835; c=relaxed/simple;
	bh=9Di2FkeIFOduQtnDEZw5Cz1U2fbjjAw7LIM/336g1k8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qz2ZvYQeJ09Nvy2yR7aDh/erv8UADo5RF2XqMRbkgCFUFiI0qB8YbxLAUU7M31O8/T8tW/VR5hlMudBsQG9I87uVW9/e1ShN+8akmZOegVR/+5iGvfczq9yD/3DRcBRhRDOppE2qePx7oQ0AIxl6oq+O8l1muXwWpzqMlPd/2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkA02YFj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec8d265389so3389475ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714729832; x=1715334632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XbIFWMJbm46ABCEZghwIka4n+0EiK+K27u1UogEz3qM=;
        b=kkA02YFjiF9iHjxTuGSidkQNyuP8/lwpIQKdWBbIWvbW22UrqE7WtCYqiUo7pEYwUD
         PPV3oPVXM1Z1stDTMtbW3Ye0iJ7iOUSpOb2OIjHv5RDfHDzpneaEtRHjXSEpTCx7D1uB
         7eM9z/OMSVEkn0JiWxBSop0NA4V9gQJIb/SrY8Yh0xTWx2nReZPw6i2FKavEcYeJKPTH
         L6eYkWMdk36IL8dETq81O8YtvgzQniTrzxOqP5aESTfppJpczA3yGXiqAsrDL5zKMHo2
         CtpQ/fTbSu0QvYurBTel1tS5KYK5k6AsaM1kz/aHC+FDDb8QPwiUSdRFLtaOvtv+t5TM
         fs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714729832; x=1715334632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbIFWMJbm46ABCEZghwIka4n+0EiK+K27u1UogEz3qM=;
        b=jPb9vJRL6UNQqpciLIjYZxI9lA3ewjpg0fWjTGBMfU+116paChgxe/6/ej3l+3USum
         9Nz868Z9w+cPzAkACm/X6u6PWYOsUkewcwczLLPZeeQMWvqbRKKkgqR76jEAEEw+m1fi
         in5VgqsmLc4rI7InnbnLcZciy2HwpVS3f3VDg1l67uwPHmXaYNFapWcVHlRB1CSHveRU
         KEG7yvzdPKZ5sE7oSWc3b6koINnx74bWtfTQmdEVX80+zRSG2Z8VDTxLIdjOOSQMBatM
         0HxebtdvKs0fYtnvRGIGr4TlGzQL8Jzr/mnuvOTLCqnFWB+z//cWO6WiqDhZWGAwzb7o
         br6A==
X-Forwarded-Encrypted: i=1; AJvYcCVzYg2BypmTzpka8CVJXPh3xQ6nBJzwTR5KMxqv8x/nDuUQGlyfHBxyeLs4oGcytkNTwlcVZVD9oJ5rfsfkgXQoiVI2miNT9VeUDHwE
X-Gm-Message-State: AOJu0YzZFfXf4KQpGu0SscP3o2ef+6rpcCoHCsm8COyYOLvb4Ph2AYYg
	oJ2G9gvrkMTK5zFcaid+M4FcBHZlbhCMym/LA1FABEuBKB2g87nB
X-Google-Smtp-Source: AGHT+IFrrnUeg1/9tnJoxphrYCutsVqK1aBW2OCIgiOzjy5644o7ZgXkmSsWe6YH7QgSl44ghsAr4Q==
X-Received: by 2002:a05:6a20:914a:b0:1ad:8f18:8621 with SMTP id x10-20020a056a20914a00b001ad8f188621mr2584834pzc.6.1714729832416;
        Fri, 03 May 2024 02:50:32 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b001eb3d459143sm2849758plg.48.2024.05.03.02.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:50:31 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	nathan@kernel.org
Cc: ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	jserv@ccns.ncku.edu.tw,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] maple_tree: Fix build failure with W=1 and LLVM=1
Date: Fri,  3 May 2024 17:50:27 +0800
Message-Id: <20240503095027.747838-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling library code using "make W=1 LLVM=1 lib/", clang
generated the following compilation errors:

lib/maple_tree.c:351:21: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
static inline void *mte_set_full(const struct maple_enode *node)
                    ^
lib/maple_tree.c:356:21: error: unused function 'mte_clear_full' [-Werror,-Wunused-function]
static inline void *mte_clear_full(const struct maple_enode *node)
                    ^
lib/maple_tree.c:361:20: error: unused function 'mte_has_null' [-Werror,-Wunused-function]
static inline bool mte_has_null(const struct maple_enode *node)
                   ^
3 errors generated.

Remove unused static inline functions to resolve compilation errors
with clang.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/maple_tree.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 55e1b35bf877..cd3f5399f9f3 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -348,21 +348,6 @@ static inline void *mte_safe_root(const struct maple_enode *node)
 	return (void *)((unsigned long)node & ~MAPLE_ROOT_NODE);
 }
 
-static inline void *mte_set_full(const struct maple_enode *node)
-{
-	return (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
-}
-
-static inline void *mte_clear_full(const struct maple_enode *node)
-{
-	return (void *)((unsigned long)node | MAPLE_ENODE_NULL);
-}
-
-static inline bool mte_has_null(const struct maple_enode *node)
-{
-	return (unsigned long)node & MAPLE_ENODE_NULL;
-}
-
 static __always_inline bool ma_is_root(struct maple_node *node)
 {
 	return ((unsigned long)node->parent & MA_ROOT_PARENT);
-- 
2.34.1


