Return-Path: <linux-kernel+bounces-160726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A72D38B4204
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4CBB222AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761B3376E9;
	Fri, 26 Apr 2024 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="b8vg+1gk"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46A37163
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714168903; cv=none; b=mP5AySoiWxxx4fIqTZxSu86COVphrcxdr58mMRDlgq0IHJxFiWTFDqSfujyjebA1ug4rG3mZdpxyMJB1Qbzg2SPEvRoaIUKq8+FBQo6PaAevpBa4pQjVzEN5v4CHLLka4+cnfQo/MZjJKcEk1VSLp0LvwKtD2jIdMV6uwkg851w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714168903; c=relaxed/simple;
	bh=12evQ9RO5KwT8EVOLbTdF0+8edFHUWGZFX3EE3n2bmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNizc+HDJveQET7PsVfJGri/+q8rvzENjDOO+V9Gf0Xyol2aR8cmgrZU4uJsiPfmFs8IKQ93ak7oY8BnlSiA0KjDEDovCBeh+6il+oTapGsFC7yuNkhoKw0DAc6xd9IsenzQDQR8Ml75zKz5D6/nIhJ3vs1m0lT7ju7xfm6JzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=b8vg+1gk; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so2878659a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714168900; x=1714773700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BB2zFTU/erO4wKsgmr35cNULPijutgrXH6T0vxGc6pY=;
        b=b8vg+1gkvqOc8L3OI2L7c+EiRigjwp6CSe3IZ2XTl2ZFzHI+HNAZ1QSWESTv11WHWk
         a5p08Kr6lR4WwO09pP9FNvHTnkDnPK7+YM1mscRFe8sl6g6gGyR+0fK1r0wuOEdwkn1N
         gYb6vAAgEje5hHQFjTzHFh0cvioPYhCyuxWwlz2WPiQasaOKa8A4uT40SSAqLC7w4VeM
         4QPcM3pRNGzhDT8klzospkG0J72eWO2On22ly/bJZZKZlevUSKBj32yjKZdSiG801GzL
         scokmcFv+/6p4sdcvCvkBp+/SXvjccoYC9GwBnHu47IoO0QFo8fh/URO/RUWrDf67yJC
         mTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714168900; x=1714773700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BB2zFTU/erO4wKsgmr35cNULPijutgrXH6T0vxGc6pY=;
        b=dw/qxt5nzY1RVD2H1eAiK2ujwFjOfhZwJdeu4IleD41ZTuqqAojReLrm5TAz60GrCn
         lzzMTBaLFFx03CkSY7kWcWFFMtSQ76yxAZfCVa5wxozF+UE225wKgBZ/Vn75s1fPWr2P
         H5lWP5T8c8LlPuAnF7DWks5HuIJ0bLwf44dhqfrKy/QN4gYPrEZh0P04bUiUMaxWKfZg
         ycKkyk2wOJqzReuqIkhjovQnSedJtv3kpXr6qC6dMT0V5IRHFgnfKwiSA2QipX4k7o0s
         vhIHcJSHGWybXSoMsuPNmRP+WarJubpZejaLEsXVs5Fi7dSk5TMZDIbN/VsMULOXNSRl
         Lj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlhRdfP3YihFcAUydSs2p7h1ustONja9mV4bcl7GT1uF3rmErhtBr3NTpdx1wtEhTBtiLoBL7A4VBEdAuwE3GfQmMJpjrbHISjanJq
X-Gm-Message-State: AOJu0YwnENHMRpJ4jt6rCRnhvPEx9/b9KI9W8xDb9kyk/blllK+jqt8r
	R11CtzsRB5TpiRGvVftKhqHgSKnl3nXfUAKFTVClZBQ9akQ4XBpXiBk7L9i5GE4=
X-Google-Smtp-Source: AGHT+IHwJ31F8r0Gkiz3UIjqIwqVvHqBw/6zhyN+VKRD2TKkKzS2KqGxPMJQfVuGryBMrXQQAFyKjA==
X-Received: by 2002:a50:d4c8:0:b0:570:5e7f:62cb with SMTP id e8-20020a50d4c8000000b005705e7f62cbmr2100446edj.29.1714168899809;
        Fri, 26 Apr 2024 15:01:39 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id r19-20020aa7cb93000000b00572031756a8sm6560719edt.16.2024.04.26.15.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 15:01:39 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] xfs: Use kmemdup() instead of kmalloc() and memcpy()
Date: Sat, 27 Apr 2024 00:00:47 +0200
Message-ID: <20240426220046.181251-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following two Coccinelle/coccicheck warnings reported by
memdup.cocci:

	xfs_dir2.c:343:15-22: WARNING opportunity for kmemdup
	xfs_attr_leaf.c:1062:13-20: WARNING opportunity for kmemdup

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 5 ++---
 fs/xfs/libxfs/xfs_dir2.c      | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index ac904cc1a97b..7346ee9aa4ca 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1059,12 +1059,11 @@ xfs_attr3_leaf_to_shortform(
 
 	trace_xfs_attr_leaf_to_sf(args);
 
-	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
+	tmpbuffer = kmemdup(bp->b_addr, args->geo->blksize,
+			GFP_KERNEL | __GFP_NOFAIL);
 	if (!tmpbuffer)
 		return -ENOMEM;
 
-	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
-
 	leaf = (xfs_attr_leafblock_t *)tmpbuffer;
 	xfs_attr3_leaf_hdr_from_disk(args->geo, &ichdr, leaf);
 	entry = xfs_attr3_leaf_entryp(leaf);
diff --git a/fs/xfs/libxfs/xfs_dir2.c b/fs/xfs/libxfs/xfs_dir2.c
index 4821519efad4..3ebb959cdaf0 100644
--- a/fs/xfs/libxfs/xfs_dir2.c
+++ b/fs/xfs/libxfs/xfs_dir2.c
@@ -340,12 +340,11 @@ xfs_dir_cilookup_result(
 					!(args->op_flags & XFS_DA_OP_CILOOKUP))
 		return -EEXIST;
 
-	args->value = kmalloc(len,
+	args->value = kmemdup(name, len,
 			GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_RETRY_MAYFAIL);
 	if (!args->value)
 		return -ENOMEM;
 
-	memcpy(args->value, name, len);
 	args->valuelen = len;
 	return -EEXIST;
 }
-- 
2.44.0


