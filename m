Return-Path: <linux-kernel+bounces-59580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D47884F944
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBF31C26614
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AFA84FDC;
	Fri,  9 Feb 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t1BDHh9F"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B59684A3D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494655; cv=none; b=tILrVyk9JO6z1PS1SEOdlkHHeox3nBo8KZGes7XF+ScUZXJy7v2Y3ZQGAq2/LjX8VDEFRPFzYIIzDNBG2UKTnK9aYcjsA6XQ4+6nsVHNa5XNCmZV5uDY+Rs11ICR9zI3EdupI4YPclA8UD+JiLjwh+4GQoxU64d/D425QtwNW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494655; c=relaxed/simple;
	bh=6zR1uMVzWkGNF/dE6RUZHIwwY29JlvmRR/9uFn5iBGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i17MgejSNFSn1rbYVlQDsl21ejj/QG+1+cHBJswt7giXbHQb/4sHbNwwOE/slQ9ubJw9U5G5Jm483nlHeymfJfBhx68z7PfUFluLIUmkys/B1k5ELSZ7G+8KjhWuMdV1/QHIf1xEj0yqw9ywrb6yB7xZOtDM3Ug2uQGmrrttUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t1BDHh9F; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707494651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZS1PtvnnaBuC7mRDWwKyfKlVaCDuPoVccBiLzWLlLM=;
	b=t1BDHh9Fl0UANizoUaVvPXrbqJsoqqBTovs+7oQOWh8/DHltaK0+w3qQusb9NHEmG3nAd8
	BqT3gR36CsRNvo9GB2n1AlKs/pNer8hTwvvkDfBeQJOco4dwbPlhcIz6HElC5dlAm7m72f
	9w7QtlC7TQLc05f6/IQ2z1T6cwf+QqE=
From: Sergei Shtepa <sergei.shtepa@linux.dev>
To: axboe@kernel.dk,
	hch@infradead.org,
	corbet@lwn.net,
	snitzer@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 8/8] block: Kconfig, Makefile and MAINTAINERS files
Date: Fri,  9 Feb 2024 17:02:04 +0100
Message-Id: <20240209160204.1471421-9-sergei.shtepa@linux.dev>
In-Reply-To: <20240209160204.1471421-1-sergei.shtepa@linux.dev>
References: <20240209160204.1471421-1-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allows to build a blksnap module and add it to the kernel tree.

Signed-off-by: Sergei Shtepa <sergei.shtepa@linux.dev>
---
 MAINTAINERS                    | 17 +++++++++++++++++
 drivers/block/Kconfig          |  2 ++
 drivers/block/Makefile         |  2 ++
 drivers/block/blksnap/Kconfig  | 12 ++++++++++++
 drivers/block/blksnap/Makefile | 15 +++++++++++++++
 5 files changed, 48 insertions(+)
 create mode 100644 drivers/block/blksnap/Kconfig
 create mode 100644 drivers/block/blksnap/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 960512bec428..fc95d3e1fd66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3608,6 +3608,23 @@ M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
 F:	drivers/leds/leds-blinkm.c
 
+BLOCK DEVICE FILTERING MECHANISM
+M:	Sergei Shtepa <sergei.shtepa@linux.dev>
+L:	linux-block@vger.kernel.org
+S:	Supported
+F:	Documentation/block/blkfilter.rst
+F:	block/blk-filter.c
+F:	include/linux/blk-filter.h
+F:	include/uapi/linux/blk-filter.h
+
+BLOCK DEVICE SNAPSHOTS MODULE
+M:	Sergei Shtepa <sergei.shtepa@linux.dev>
+L:	linux-block@vger.kernel.org
+S:	Supported
+F:	Documentation/block/blksnap.rst
+F:	drivers/block/blksnap/*
+F:	include/uapi/linux/blksnap.h
+
 BLOCK LAYER
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5b9d4aaebb81..74d2d55526a3 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -404,4 +404,6 @@ config BLKDEV_UBLK_LEGACY_OPCODES
 
 source "drivers/block/rnbd/Kconfig"
 
+source "drivers/block/blksnap/Kconfig"
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..9a2a9a56a247 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -40,3 +40,5 @@ obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
 
 swim_mod-y	:= swim.o swim_asm.o
+
+obj-$(CONFIG_BLKSNAP) += blksnap/
diff --git a/drivers/block/blksnap/Kconfig b/drivers/block/blksnap/Kconfig
new file mode 100644
index 000000000000..ce3e33d52c71
--- /dev/null
+++ b/drivers/block/blksnap/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Snapshots of block devices configuration
+#
+
+config BLKSNAP
+	tristate "Snapshots of block devices (Experimental)"
+	help
+	  Allow to create snapshots and track block changes for block devices.
+	  It can be used to create backups of block devices. Snapshots are
+	  temporary and are released when backup is completed. Change block
+	  tracking allows to create incremental or differential backups.
diff --git a/drivers/block/blksnap/Makefile b/drivers/block/blksnap/Makefile
new file mode 100644
index 000000000000..8d528b95579a
--- /dev/null
+++ b/drivers/block/blksnap/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+blksnap-y := 		\
+	cbt_map.o	\
+	chunk.o		\
+	diff_area.o	\
+	diff_buffer.o	\
+	diff_storage.o	\
+	event_queue.o	\
+	main.o		\
+	snapimage.o	\
+	snapshot.o	\
+	tracker.o
+
+obj-$(CONFIG_BLKSNAP)	 += blksnap.o
-- 
2.34.1


