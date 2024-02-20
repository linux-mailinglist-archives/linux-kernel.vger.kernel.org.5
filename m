Return-Path: <linux-kernel+bounces-72485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9932285B416
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A392853AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F935A783;
	Tue, 20 Feb 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QLit7++T"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13657313
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414772; cv=none; b=E02xn/aV0PYEUGzG7Y2V6XFEO9Tx1FGDOFnSp4ifecK94uhCF/zAl3xc26/nGLDik7jmVBnzxZqocc+zYSZZS2r0daAKp9LEPIQgtzU4UzIWk2jeR+sNw2Kg11VLadw8YaKca4f//YHgnlWgN+Pz2FrkmIJxm5X2Vk0O/1EHFcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414772; c=relaxed/simple;
	bh=6hjxIBlVEHiZgBQC5OWkhdV6eDazh/Seko02QlXVUiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TXL3vSjd6qthxu/Vv3Yw5fqoHAjlxWOuzNlLuDBX9BkKZ/Hh4E2XBZ3BQjFBSja6JEIk4SnszYdqiWxea6oIXdetLkq2FS5QZm+KJdkGc/r7yJow13XNMVyQ4OLwHUll2wGvCKiaQotl4IUDvatpPEyta3fIlevZkaXRGXkBYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QLit7++T; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708414767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xizuTIf0aeWPVO5b7muJlc7kocl9C1dtiUtcYvVswr4=;
	b=QLit7++Tdxz2vRB+q/K3lLezSh6O5cUAfCotvhVuHTi4mL5qGl0NB3ZVxG+eHOoCwA7ZZm
	sNdVFDT6cRUXk686B04b2XPlV0236WolyhD6KoT8zOXspCROov5bjRZ9fH6eB+hh4Mh+JZ
	kVuCUlqof+2sXLi5A4+OcnZZ0Zjt+ZE=
From: chengming.zhou@linux.dev
To: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] MAINTAINERS: add Chengming Zhou as a zswap reviewer
Date: Tue, 20 Feb 2024 07:38:51 +0000
Message-Id: <20240220073851.865113-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

I have been actively contributing to zswap and reviewing zswap patches
for a while, and I am already getting CC'd on most of them. So add
myself as a reviewer, will continue to work on it and help with the
review process.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b6c5c92e49db..2b290afe6ab7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24415,6 +24415,7 @@ ZSWAP COMPRESSED SWAP CACHING
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Yosry Ahmed <yosryahmed@google.com>
 M:	Nhat Pham <nphamcs@gmail.com>
+R:	Chengming Zhou <chengming.zhou@linux.dev>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/admin-guide/mm/zswap.rst
-- 
2.40.1


