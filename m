Return-Path: <linux-kernel+bounces-168079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E308BB362
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553721F22BE4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFF2502A1;
	Fri,  3 May 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUOpQoXU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6939857C8A
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761757; cv=none; b=Y8fTnNDKHqGwfm34A+Qj8zrrz7xFCuJjKRLrp8DZVZTYPJdGF0OQbh/kAyPE/1b27UaiOto3345U2vGiTV178PPMvG/vMJPty2hRhC++1posDUYRybGQe/dqFHP/T7LziNfFCzZt5rQv5KPl8CXzEUomxizVnurK4pb3VDGNnHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761757; c=relaxed/simple;
	bh=q4xkNgHhMhLTgKFwLy/peK8W9gb/1njcDFxZND/a0m0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S8ELtV8rhru2Wv1KzLPxgFAiGOK+YZkaz0FVO0ckUyUS4Is7zQIzRIB28cmhbnmUHMrgVB+ZmqSjjNrJR+ZVZLmDhietoV6cNL10jzC5J+s+uEhohou7qKzTEBLJ2hUB+cx95umTDYsrg7kn0wIqhN3U6K4JQN5Zu6bvqk/y2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUOpQoXU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714761756; x=1746297756;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q4xkNgHhMhLTgKFwLy/peK8W9gb/1njcDFxZND/a0m0=;
  b=AUOpQoXUy3UxtaG80tXkVhV/hde0bG/Nrky3njtFsiGBhfh5jVAigKMi
   qilfFOJ0CcEr2vp+t9fX+JJtiVcHucW2CYuw3ii8mNH85PoQ8D0S5eaui
   Osg6PtfNfKsFUWKZNgNJ7W3FeWItjzgNtEOxRFAfCswfSE0gZYr9vK48z
   Gzhf7C6qQrawmMlwUmn84TrbQP/vq1olmiW7lLVeMfXPLZf4k2s6HW2hX
   QyHSND05Q1Ue2YLnA5ZMhTmkqVJ/yVfLTZneMxxeeN/h50QBnsaSTwJsl
   xJuwShwizHLBZsVG6Yo8hbxp8lHzrI6PZTjHTTYmPs0CNCgQjzuNcCkja
   Q==;
X-CSE-ConnectionGUID: j38AMJgjRD6W+pnCzRnebw==
X-CSE-MsgGUID: Ul02x0LDTVaftZiw6fhYuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10415183"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10415183"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 11:42:36 -0700
X-CSE-ConnectionGUID: L7Jb2MVnRRqBAFDbvzalPg==
X-CSE-MsgGUID: jsIjoHonTVqgZoTeH/PC6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27634376"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 03 May 2024 11:42:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3FCBE19E; Fri,  3 May 2024 21:42:33 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v1 1/1] mtd: cfi: Get rid of redundant 'else'
Date: Fri,  3 May 2024 21:42:30 +0300
Message-ID: <20240503184230.2927283-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the snippets like the following

	if (...)
		return / goto / break / continue ...;
	else
		...

the 'else' is redundant. Get rid of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/mtd/cfi.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
index 947410faf9e2..35ca19ae21ae 100644
--- a/include/linux/mtd/cfi.h
+++ b/include/linux/mtd/cfi.h
@@ -308,32 +308,32 @@ static inline uint8_t cfi_read_query(struct map_info *map, uint32_t addr)
 {
 	map_word val = map_read(map, addr);
 
-	if (map_bankwidth_is_1(map)) {
+	if (map_bankwidth_is_1(map))
 		return val.x[0];
-	} else if (map_bankwidth_is_2(map)) {
+	if (map_bankwidth_is_2(map))
 		return cfi16_to_cpu(map, val.x[0]);
-	} else {
-		/* No point in a 64-bit byteswap since that would just be
-		   swapping the responses from different chips, and we are
-		   only interested in one chip (a representative sample) */
-		return cfi32_to_cpu(map, val.x[0]);
-	}
+	/*
+	 * No point in a 64-bit byteswap since that would just be
+	 * swapping the responses from different chips, and we are
+	 * only interested in one chip (a representative sample)
+	 */
+	return cfi32_to_cpu(map, val.x[0]);
 }
 
 static inline uint16_t cfi_read_query16(struct map_info *map, uint32_t addr)
 {
 	map_word val = map_read(map, addr);
 
-	if (map_bankwidth_is_1(map)) {
+	if (map_bankwidth_is_1(map))
 		return val.x[0] & 0xff;
-	} else if (map_bankwidth_is_2(map)) {
+	if (map_bankwidth_is_2(map))
 		return cfi16_to_cpu(map, val.x[0]);
-	} else {
-		/* No point in a 64-bit byteswap since that would just be
-		   swapping the responses from different chips, and we are
-		   only interested in one chip (a representative sample) */
-		return cfi32_to_cpu(map, val.x[0]);
-	}
+	/*
+	 * No point in a 64-bit byteswap since that would just be
+	 * swapping the responses from different chips, and we are
+	 * only interested in one chip (a representative sample)
+	 */
+	return cfi32_to_cpu(map, val.x[0]);
 }
 
 void cfi_udelay(int us);
-- 
2.43.0.rc1.1336.g36b5255a03ac


