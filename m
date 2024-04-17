Return-Path: <linux-kernel+bounces-148471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE608A830B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0781F23427
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E383813D293;
	Wed, 17 Apr 2024 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3appNkR"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC2613CF87;
	Wed, 17 Apr 2024 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356536; cv=none; b=lIeuP1Tj00mjEvfKOkqvEZL+byZ8DpsIgi35aSAJGE+uH34lxT0XRVUd/WoxDaBmUvegxDKI5lybXS7FkpitMJcj6iiaL8ItT57feZ7xeOy4P1irn4C6NsOFkwwF3r1M0aogHawVfnXdyhFqxsup3GrBuG3nC/jnLNuPT5VKCaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356536; c=relaxed/simple;
	bh=eNdPSLbQ08oIwVxA3DSSN1bgvrlYuVTEEZlegEhyhrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LnyxJhTVQ1nMbQil+E/KmueIcPeyIidMJiYuxTNEvoGAK/vITIsP3WhZcrJdprVPHIghfqKUEs8aPQaedhp0AmGcQGPv8Tsom3XdHAJVtwaTaHf+gXtGkJ/ulC7hX/yY2bBlXm4Qptz7YnZvKNZxTiD/Q8KQD6C5K8oEdWDXe+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3appNkR; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ea2f95ec67so2867026a34.2;
        Wed, 17 Apr 2024 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713356534; x=1713961334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r01JeIowVP/LWyk0N5hwlS9X40SHgKNE7NAoAweOa44=;
        b=D3appNkRZLbQPoYoIuRdHoQ0V1JERPId6mE4APE+weEN/Z6SAabm97AwOcCJgqCEa5
         0xb5RSvEc3lwxgJJYkkhKQS3aEfSFtbjuSf3Wd1Y0/7dp4IsFrP+Swtm9COrbc2Sq6GT
         XOPvoVS8N3g+AT77GdZ0FkThLb46OBmOiDFeV/O5mr1YGnwMaRUPJCiX+CdW6rbfk2kT
         zScfL2y4cgP6ndcNQ1ufeqTfHjEyv4G+k8eoWVlS8elH8tTXeQudlZL/pXSHKBzUnj2F
         TXOqi+kMOwDrGfHiNw+pO8Wxmr6U9h64eIkx7xPRfoz2jEmmrnk6XkRN0Qy9lrt+90eZ
         PdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713356534; x=1713961334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r01JeIowVP/LWyk0N5hwlS9X40SHgKNE7NAoAweOa44=;
        b=jwAf33QrSh+ED5+94YSFJ8Sn002Y2VotGJOol9hX1ZxzhiuCWtfJ2f83B40R41rGDt
         Zi9czqgSbBrsaF8QHLugjMxpVgD2PO+VsAh7e2hZDnDrzmpfurKxV4PPd6ZNnS7qG1EO
         sT8da1qmBs7dvkWEthJG3Q7gdvOU5Z8tCvh4vbnu3GEq64nTr/zZtOAEQo3gc2JTeub5
         P4dgYSe6pDghI/6auuSG/Fe1KjySCYmc3zBiVavxL8ZggOxXyameDobF78yQYtS/mlcx
         NjGSqCrOq70X2BNAD9UdTiEg/8AO2eQoecWqohrBY7b+vxFpu8rNnRYdGj8lKOfvvPqD
         JFBA==
X-Forwarded-Encrypted: i=1; AJvYcCWZNwOaeFeMu1GUZc8kzgXvvNTIWcNOkJDRJx8tm0wAp3KV6BcuE1A7ncOmIhqIcdtYRn/dqKZhnzUGPE9CWvTHJKSu8JacQkhVp5h/OtPcY6N1G45mOuupzywI2QVbZxtyJKVTDqre
X-Gm-Message-State: AOJu0YxZmqOLmzYRNYyxeu1Vb8NYqdHcwKhuD468XTwGtjX1OvgYSNIG
	F4kXE6/uvy5ths/OHNzao7TWex32tvISUiZNBuCeGg19vUA84h0v
X-Google-Smtp-Source: AGHT+IGLoiqjcjiRF/T66uGJfinnCondW9gD4nSCRJDv1UIWWlO41HvlhlYxHS4cKCwiAhUSg/6LvA==
X-Received: by 2002:a05:6870:45a1:b0:221:8e01:4c6f with SMTP id y33-20020a05687045a100b002218e014c6fmr19834721oao.36.1713356533744;
        Wed, 17 Apr 2024 05:22:13 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id j3-20020a635503000000b005e83b64021fsm10361649pgb.25.2024.04.17.05.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 05:22:13 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: david@fromorbit.com
Cc: chandan.babu@oracle.com,
	djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v3 RESEND] xfs: remove redundant batch variables for serialization
Date: Wed, 17 Apr 2024 20:07:35 +0800
Message-Id: <20240417120734.853960-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

Historically, when generic percpu counters were introduced in xfs for
free block counters by commit 0d485ada404b ("xfs: use generic percpu
counters for free block counter"), the counters used a custom batch
size. In xfs_mod_freecounter(), originally named xfs_mod_fdblocks(),
this patch attempted to serialize the program using a smaller batch size
as parameter to the addition function as the counter approaches 0.

Commit 8c1903d3081a ("xfs: inode and free block counters need to use
__percpu_counter_compare") pointed out the error in commit 0d485ada404b
("xfs: use generic percpu counters for free block counter") mentioned
above and said that "Because the counters use a custom batch size, the
comparison functions need to be aware of that batch size otherwise the
comparison does not work correctly". Then percpu_counter_compare() was
replaced with __percpu_counter_compare() with parameter
XFS_FDBLOCKS_BATCH.

After commit 8c1903d3081a ("xfs: inode and free block counters need to
use __percpu_counter_compare"), the existence of the batch variable is
no longer necessary, so this patch is proposed to simplify the code by
removing it.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
Changelog:

v3: Resend for the second time 

v2: https://lore.kernel.org/linux-xfs/20230918043344.890817-1-alexjlzheng@tencent.com/

v1: https://lore.kernel.org/linux-xfs/20230908235713.GP28202@frogsfrogsfrogs/T/#t
---
 fs/xfs/xfs_mount.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index aed5be5508fe..8e47a3040893 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1144,7 +1144,6 @@ xfs_mod_freecounter(
 	int64_t			lcounter;
 	long long		res_used;
 	uint64_t		set_aside = 0;
-	s32			batch;
 	bool			has_resv_pool;
 
 	ASSERT(counter == &mp->m_fdblocks || counter == &mp->m_frextents);
@@ -1177,20 +1176,6 @@ xfs_mod_freecounter(
 		return 0;
 	}
 
-	/*
-	 * Taking blocks away, need to be more accurate the closer we
-	 * are to zero.
-	 *
-	 * If the counter has a value of less than 2 * max batch size,
-	 * then make everything serialise as we are real close to
-	 * ENOSPC.
-	 */
-	if (__percpu_counter_compare(counter, 2 * XFS_FDBLOCKS_BATCH,
-				     XFS_FDBLOCKS_BATCH) < 0)
-		batch = 1;
-	else
-		batch = XFS_FDBLOCKS_BATCH;
-
 	/*
 	 * Set aside allocbt blocks because these blocks are tracked as free
 	 * space but not available for allocation. Technically this means that a
@@ -1204,7 +1189,7 @@ xfs_mod_freecounter(
 	 */
 	if (has_resv_pool)
 		set_aside = xfs_fdblocks_unavailable(mp);
-	percpu_counter_add_batch(counter, delta, batch);
+	percpu_counter_add_batch(counter, delta, XFS_FDBLOCKS_BATCH);
 	if (__percpu_counter_compare(counter, set_aside,
 				     XFS_FDBLOCKS_BATCH) >= 0) {
 		/* we had space! */
-- 
2.39.3


