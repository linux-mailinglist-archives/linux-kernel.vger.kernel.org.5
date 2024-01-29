Return-Path: <linux-kernel+bounces-43020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EE8840A50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6399D1C22C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC6615530D;
	Mon, 29 Jan 2024 15:42:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C67154441
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542942; cv=none; b=FjfmoppxdtS+lGpgOXnPLDVDhxLveyeOG/mwUDfVN1DNFmdnV1uyA5X9K4db8m+HAllkllngc8RNlvTwcMWvGOND7opBcAZnelgDc1nA4f+H7TFtQ8uqwf+Wific6Y/YDHI0AoA83o+AHv+23Y6ZYyl5n8/SOzhraN6KLeMBUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542942; c=relaxed/simple;
	bh=OGvTxJpBW59bIMhu/9lm0a0d931d0KXXmSVZWIsC/pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H7147CYq1qchAD7rjHKUfO0hO3P7AzigRl2xp5jDYEiWhUtXyO3OhCWmmGITk4m5Bs47sJ7PJ28m+oBCkHYiaqiqK5Ypwp+2eGwCGS3tV2u+h01tFWfgeYROujE/Hu2NXt8bmsIcvECavlAPNIWCWUj9qOYcHHaLDjUY7u91dTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F116DA7;
	Mon, 29 Jan 2024 07:43:04 -0800 (PST)
Received: from e127643.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2D2D3F738;
	Mon, 29 Jan 2024 07:42:17 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com
Cc: James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 08/12] coresight: Remove unused stubs
Date: Mon, 29 Jan 2024 15:40:39 +0000
Message-Id: <20240129154050.569566-9-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129154050.569566-1-james.clark@arm.com>
References: <20240129154050.569566-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are a bit annoying to keep up to date when the function signatures
change. But if CONFIG_CORESIGHT isn't enabled, then they're not used
anyway so just delete them.

Signed-off-by: James Clark <james.clark@arm.com>
---
 include/linux/coresight.h | 79 ---------------------------------------
 1 file changed, 79 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 4400d554a16b..c5be46d7f85c 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -391,8 +391,6 @@ struct coresight_ops {
 	const struct coresight_ops_helper *helper_ops;
 };
 
-#if IS_ENABLED(CONFIG_CORESIGHT)
-
 static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
 					      u32 offset)
 {
@@ -611,83 +609,6 @@ void coresight_relaxed_write64(struct coresight_device *csdev,
 			       u64 val, u32 offset);
 void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
 
-#else
-static inline struct coresight_device *
-coresight_register(struct coresight_desc *desc) { return NULL; }
-static inline void coresight_unregister(struct coresight_device *csdev) {}
-static inline int
-coresight_enable_sysfs(struct coresight_device *csdev) { return -ENOSYS; }
-static inline void coresight_disable_sysfs(struct coresight_device *csdev) {}
-
-static inline int coresight_timeout(struct csdev_access *csa, u32 offset,
-				    int position, int value)
-{
-	return 1;
-}
-
-static inline int coresight_claim_device_unlocked(struct coresight_device *csdev)
-{
-	return -EINVAL;
-}
-
-static inline int coresight_claim_device(struct coresight_device *csdev)
-{
-	return -EINVAL;
-}
-
-static inline void coresight_disclaim_device(struct coresight_device *csdev) {}
-static inline void coresight_disclaim_device_unlocked(struct coresight_device *csdev) {}
-
-static inline bool coresight_loses_context_with_cpu(struct device *dev)
-{
-	return false;
-}
-
-static inline u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
-{
-	WARN_ON_ONCE(1);
-	return 0;
-}
-
-static inline u32 coresight_read32(struct coresight_device *csdev, u32 offset)
-{
-	WARN_ON_ONCE(1);
-	return 0;
-}
-
-static inline void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset)
-{
-}
-
-static inline void coresight_relaxed_write32(struct coresight_device *csdev,
-					     u32 val, u32 offset)
-{
-}
-
-static inline u64 coresight_relaxed_read64(struct coresight_device *csdev,
-					   u32 offset)
-{
-	WARN_ON_ONCE(1);
-	return 0;
-}
-
-static inline u64 coresight_read64(struct coresight_device *csdev, u32 offset)
-{
-	WARN_ON_ONCE(1);
-	return 0;
-}
-
-static inline void coresight_relaxed_write64(struct coresight_device *csdev,
-					     u64 val, u32 offset)
-{
-}
-
-static inline void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
-{
-}
-
-#endif		/* IS_ENABLED(CONFIG_CORESIGHT) */
-
 extern int coresight_get_cpu(struct device *dev);
 
 struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
-- 
2.34.1


