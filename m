Return-Path: <linux-kernel+bounces-100359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D654879643
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29662281D94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD917F475;
	Tue, 12 Mar 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M1CbidzZ"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952147EF0A;
	Tue, 12 Mar 2024 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253699; cv=none; b=Tr0KUXVYGCE9buhfRZxlQbe79p2//IaFw4yp01+iOZgjqqUXb9k2w2aLbC5Nq+wgKlMLAtfC5yf7miWARleaphn/72ZlHVOa7Q6PF573esvJAZgepJGYQfNyH51P18HIIO+H9wtdwOZY2C/Z1DoS4Ax2/2BA1mT+Hfg6wGkgmD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253699; c=relaxed/simple;
	bh=kXecMe5+xFbr3xg4e2sybOMm0fNZzc4qLpLSpou9hEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyRUh9Nwxeu1vNBqm1BK8VtAiL0ASkQ5xx5EV+LyeGWfyu5jzyPaQZND+aX6c/SSw3Nd6lbKJtCqmPtcJFVmPPOEYWhjxTJ+yqcorl+Ddwh0tXmOGLTSm0iNe5a6Zn2lsx/z/XkTetf8M7tKwMAbjfrWAAhEDwamLpXqHA+GnX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M1CbidzZ; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710253694; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Z6k1zdrLqjI91xyzA7ayUzFg0c/nRe/MW+IYcg3K3hw=;
	b=M1CbidzZroSoIXU7xa6CsFfI0qNtGFUOpRnABZdwqjzac+LyZtUMyjdVpTNCxDAUT5UVRAYAoNW6jnn/g9TJukmPOJXNm1PqbyfWzMzT75695+xAeVjte0UdPzKKUwks8Oo5248+6luf/s7PpGieVr0H6DZQuCUASvtJkHv9AzA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2M60WP_1710253692;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2M60WP_1710253692)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 22:28:13 +0800
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
Subject: [PATCH net-next v3 07/11] net/smc: register loopback-ism into SMC-D device list
Date: Tue, 12 Mar 2024 22:27:39 +0800
Message-Id: <20240312142743.41406-8-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240312142743.41406-1-guwen@linux.alibaba.com>
References: <20240312142743.41406-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After loopback-ism device gets ready, add it to the SMC-D device list as
an ISMv2 device.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ism.c      | 11 +++++++----
 net/smc/smc_ism.h      |  1 +
 net/smc/smc_loopback.c | 20 +++++++++++++-------
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 26743a14cf27..c50910300a03 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -91,6 +91,11 @@ bool smc_ism_is_v2_capable(void)
 	return smc_ism_v2_capable;
 }
 
+void smc_ism_set_v2_capable(void)
+{
+	smc_ism_v2_capable = true;
+}
+
 /* Set a connection using this DMBE. */
 void smc_ism_set_conn(struct smc_connection *conn)
 {
@@ -454,11 +459,9 @@ static void smcd_register_dev(struct ism_dev *ism)
 	if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
 		smc_pnetid_by_table_smcd(smcd);
 
+	if (smcd->ops->supports_v2())
+		smc_ism_set_v2_capable();
 	mutex_lock(&smcd_dev_list.mutex);
-	if (list_empty(&smcd_dev_list.list)) {
-		if (smcd->ops->supports_v2())
-			smc_ism_v2_capable = true;
-	}
 	/* sort list: devices without pnetid before devices with pnetid */
 	if (smcd->pnetid[0])
 		list_add_tail(&smcd->list, &smcd_dev_list.list);
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 165cd013404b..2ea169c1301c 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -52,6 +52,7 @@ int smc_ism_signal_shutdown(struct smc_link_group *lgr);
 void smc_ism_get_system_eid(u8 **eid);
 u16 smc_ism_get_chid(struct smcd_dev *dev);
 bool smc_ism_is_v2_capable(void);
+void smc_ism_set_v2_capable(void);
 int smc_ism_init(void);
 void smc_ism_exit(void);
 int smcd_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 7335acb03920..c3e1133da8d7 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -275,10 +275,12 @@ static int smcd_lo_register_dev(struct smc_lo_dev *ldev)
 		return -ENOMEM;
 	ldev->smcd = smcd;
 	smcd->priv = ldev;
-
-	/* TODO:
-	 * register loopback-ism to smcd_dev list.
-	 */
+	smc_ism_set_v2_capable();
+	mutex_lock(&smcd_dev_list.mutex);
+	list_add(&smcd->list, &smcd_dev_list.list);
+	mutex_unlock(&smcd_dev_list.mutex);
+	pr_warn_ratelimited("smc: adding smcd device %s\n",
+			    smc_lo_dev_name);
 	return 0;
 }
 
@@ -286,9 +288,13 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
 {
 	struct smcd_dev *smcd = ldev->smcd;
 
-	/* TODO:
-	 * unregister loopback-ism from smcd_dev list.
-	 */
+	pr_warn_ratelimited("smc: removing smcd device %s\n",
+			    smc_lo_dev_name);
+	smcd->going_away = 1;
+	smc_smcd_terminate_all(smcd);
+	mutex_lock(&smcd_dev_list.mutex);
+	list_del_init(&smcd->list);
+	mutex_unlock(&smcd_dev_list.mutex);
 	kfree(smcd->conn);
 	kfree(smcd);
 }
-- 
2.32.0.3.g01195cf9f


