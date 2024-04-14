Return-Path: <linux-kernel+bounces-143960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFD88A4015
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F901C20DE2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3255A200CB;
	Sun, 14 Apr 2024 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vZq7sxaf"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72411C2AD;
	Sun, 14 Apr 2024 04:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713067405; cv=none; b=Upsb05Io/6XgmzRvlV9Wi/SATsi829NTImBy8es4A5ZZCeDjU3LAU0N8W39dL4mkBME5absmSBvYlvxwvkPTJ00zg0FFi7uRPVNtpyr4RDFHmLwjaSVeYb44YjGChhEIWyVUaqQJFvlTRfctjOOavomQjhctTBUYbe9Nac8G3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713067405; c=relaxed/simple;
	bh=1POp8nMLlC2kpBtjJUqT4DJMKwuYZb62HESyYP7l6RU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W4CPVowgCV9mzdZwUH27LPUJc2XYTiemjzIegGjQbIBzUNJdRD4y20Ce77GWrGnuCPPQc8iOhGoSTyI5BjvlW8J/LHboEVEiNnKOmtly1vosRnmMpIjSJ0OyU6PnpnP87PVZCa3sg1IEO0NDXg+fb+/rCJiHN8cHZwtO1ZiYCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vZq7sxaf; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713067395; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xsjzF5J8zfGPlbgaJEWorbHtuP2WT/ypyLMgvWj5Kao=;
	b=vZq7sxafsic+aeP8u160pt70HeUUlFe+b8A3AEUTYOZqpn8pjyZDItdXyQpIF53mv809cp482oUF180xDR5CB4SxLLSblNKyOA+H5WPZTjcKlUzLVanDjCFQlLEZVBrMx/doI4h4xsPjrNwS4/4AZzMNI+S7KRa/PcV3kjYWEO4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W4RwFnP_1713067393;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W4RwFnP_1713067393)
          by smtp.aliyun-inc.com;
          Sun, 14 Apr 2024 12:03:14 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	twinkler@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 03/11] net/smc: implement ID-related operations of loopback-ism
Date: Sun, 14 Apr 2024 12:02:56 +0800
Message-Id: <20240414040304.54255-4-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240414040304.54255-1-guwen@linux.alibaba.com>
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements operations related to IDs for the loopback-ism device.
loopback-ism uses an Extended GID that is a 128-bit GID instead of the
existing ISM 64-bit GID, and uses the CHID defined with the reserved
value 0xFFFF.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 62 ++++++++++++++++++++++++++++++++++++++----
 net/smc/smc_loopback.h |  3 ++
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index c364e3e6e3fb..0349632a76c4 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -18,11 +18,62 @@
 #include "smc_ism.h"
 #include "smc_loopback.h"
 
+#define SMC_LO_V2_CAPABLE	0x1 /* loopback-ism acts as ISMv2 */
+
 static const char smc_lo_dev_name[] = "loopback-ism";
 static struct smc_lo_dev *lo_dev;
 
+static void smc_lo_generate_ids(struct smc_lo_dev *ldev)
+{
+	struct smcd_gid *lgid = &ldev->local_gid;
+	uuid_t uuid;
+
+	uuid_gen(&uuid);
+	memcpy(&lgid->gid, &uuid, sizeof(lgid->gid));
+	memcpy(&lgid->gid_ext, (u8 *)&uuid + sizeof(lgid->gid),
+	       sizeof(lgid->gid_ext));
+
+	ldev->chid = SMC_LO_RESERVED_CHID;
+}
+
+static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
+			     u32 vid_valid, u32 vid)
+{
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	/* rgid should be the same as lgid */
+	if (!ldev || rgid->gid != ldev->local_gid.gid ||
+	    rgid->gid_ext != ldev->local_gid.gid_ext)
+		return -ENETUNREACH;
+	return 0;
+}
+
+static int smc_lo_supports_v2(void)
+{
+	return SMC_LO_V2_CAPABLE;
+}
+
+static void smc_lo_get_local_gid(struct smcd_dev *smcd,
+				 struct smcd_gid *smcd_gid)
+{
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	smcd_gid->gid = ldev->local_gid.gid;
+	smcd_gid->gid_ext = ldev->local_gid.gid_ext;
+}
+
+static u16 smc_lo_get_chid(struct smcd_dev *smcd)
+{
+	return ((struct smc_lo_dev *)smcd->priv)->chid;
+}
+
+static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
+{
+	return &((struct smc_lo_dev *)smcd->priv)->dev;
+}
+
 static const struct smcd_ops lo_ops = {
-	.query_remote_gid	= NULL,
+	.query_remote_gid = smc_lo_query_rgid,
 	.register_dmb		= NULL,
 	.unregister_dmb		= NULL,
 	.add_vlan_id		= NULL,
@@ -31,10 +82,10 @@ static const struct smcd_ops lo_ops = {
 	.reset_vlan_required	= NULL,
 	.signal_event		= NULL,
 	.move_data		= NULL,
-	.supports_v2		= NULL,
-	.get_local_gid		= NULL,
-	.get_chid		= NULL,
-	.get_dev		= NULL,
+	.supports_v2 = smc_lo_supports_v2,
+	.get_local_gid = smc_lo_get_local_gid,
+	.get_chid = smc_lo_get_chid,
+	.get_dev = smc_lo_get_dev,
 };
 
 static struct smcd_dev *smcd_lo_alloc_dev(const struct smcd_ops *ops,
@@ -94,6 +145,7 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
 
 static int smc_lo_dev_init(struct smc_lo_dev *ldev)
 {
+	smc_lo_generate_ids(ldev);
 	return smcd_lo_register_dev(ldev);
 }
 
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index c6c97e2c461d..c11529b15041 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -20,10 +20,13 @@
 
 #if IS_ENABLED(CONFIG_SMC_LO)
 #define SMC_LO_MAX_DMBS		5000
+#define SMC_LO_RESERVED_CHID	0xFFFF
 
 struct smc_lo_dev {
 	struct smcd_dev *smcd;
 	struct device dev;
+	u16 chid;
+	struct smcd_gid local_gid;
 };
 
 int smc_loopback_init(void);
-- 
2.32.0.3.g01195cf9f


