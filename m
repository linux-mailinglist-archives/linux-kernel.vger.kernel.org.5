Return-Path: <linux-kernel+bounces-137568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2194A89E40F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50A91F21A94
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A141581F3;
	Tue,  9 Apr 2024 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQxpZCE2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E3156F4E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692938; cv=none; b=ldZmGcMsgbNDWT7UUnfloMRaK6sbn5gZSW7bDfs6k2vhDp7rwDJfD9BLC+lsn+OzYTyyJFmQsUkV/ewr9DliqLp+6NYr0U1VR6G/Cpl4bF9RdVIiSHXpomDagIDHG60Rx40myvB+CfGs86CcmUExKOYv09BkRZdpU+WX2aFrL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692938; c=relaxed/simple;
	bh=BKcWmZZnN2N2645VQtJaW8isi6HlmohHD9/K4VPBE6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UeYW0QIl8JC6fA8+g6MNgGlhQexXF8GuIcbo3muO5pP4PG+BA7PwJMy/LIPRhFG3u8TDNVs6l45AtEiEI+ntTyjJyYlvDm+YU1wb17HxUxnUP1zP8yx+04ha6JKbg1tJPp06NAwAXzLJm3M5yiPB+v7Prcgr3c+uEI2F9ROHisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQxpZCE2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712692936; x=1744228936;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BKcWmZZnN2N2645VQtJaW8isi6HlmohHD9/K4VPBE6Y=;
  b=GQxpZCE2ICiZYhlbHny9anxbZn4352UFvqLO8u+3t5/lPdykXklWJnR+
   ZxkU/F4kE847TMrsaHMLNL8REFr5ROSpBB06EB79SlogRLjV6XlFMWZia
   Cp0D0MAVnJ6zMP9c6bec/dTyvErk0gY71MqB6Fv9sNy6D5kqJdDoJyytP
   QgzU+HOk5361LaYA/HESO5m8x9MM9NvQeW7ADhyE6l+dwVpuQ93kBYFwv
   ye7Zs35Kxnupa11lhQ3SwfiqcbMLaywDH+XvcLEe61G4u4ZSeTIVexInu
   5hk/WA6SB213GgMIcER0EEcaHMwCX8Jak0cEg0G0AkWe7JYf3lyEc1WSr
   Q==;
X-CSE-ConnectionGUID: lam0vk6eQ+ypTB7WH69DVw==
X-CSE-MsgGUID: yWB2jM10RJK2p2dcYjI8QQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="10996842"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="10996842"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 13:02:15 -0700
X-CSE-ConnectionGUID: RO/DTNXpSj2+XpSBF3MjmQ==
X-CSE-MsgGUID: C1LbVe6RQRGEdWuPFtf0Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24824245"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 13:02:14 -0700
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v4 1/2] devcoredump: Add dev_coredump_put()
Date: Tue,  9 Apr 2024 13:02:05 -0700
Message-ID: <20240409200206.108452-1-jose.souza@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is useful for modules that do not want to keep coredump available
after its unload.
Otherwise, the coredump would only be removed after DEVCD_TIMEOUT
seconds.

v2:
- dev_coredump_put() documentation updated (Mukesh)

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/base/devcoredump.c  | 23 +++++++++++++++++++++++
 include/linux/devcoredump.h |  5 +++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 7e2d1f0d903a6..82aeb09b3d1b5 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -304,6 +304,29 @@ static ssize_t devcd_read_from_sgtable(char *buffer, loff_t offset,
 				  offset);
 }
 
+/**
+ * dev_coredump_put - remove device coredump
+ * @dev: the struct device for the crashed device
+ *
+ * dev_coredump_put() removes coredump, if exists, for a given device from
+ * the file system and free its associated data otherwise, does nothing.
+ *
+ * It is useful for modules that do not want to keep coredump
+ * available after its unload.
+ */
+void dev_coredump_put(struct device *dev)
+{
+	struct device *existing;
+
+	existing = class_find_device(&devcd_class, NULL, dev,
+				     devcd_match_failing);
+	if (existing) {
+		devcd_free(existing, NULL);
+		put_device(existing);
+	}
+}
+EXPORT_SYMBOL_GPL(dev_coredump_put);
+
 /**
  * dev_coredumpm - create device coredump with read/free methods
  * @dev: the struct device for the crashed device
diff --git a/include/linux/devcoredump.h b/include/linux/devcoredump.h
index c008169ed2c6f..c8f7eb6cc1915 100644
--- a/include/linux/devcoredump.h
+++ b/include/linux/devcoredump.h
@@ -63,6 +63,8 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 
 void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 		    size_t datalen, gfp_t gfp);
+
+void dev_coredump_put(struct device *dev);
 #else
 static inline void dev_coredumpv(struct device *dev, void *data,
 				 size_t datalen, gfp_t gfp)
@@ -85,6 +87,9 @@ static inline void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 {
 	_devcd_free_sgtable(table);
 }
+static inline void dev_coredump_put(struct device *dev)
+{
+}
 #endif /* CONFIG_DEV_COREDUMP */
 
 #endif /* __DEVCOREDUMP_H */
-- 
2.44.0


