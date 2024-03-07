Return-Path: <linux-kernel+bounces-95288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C883F874BCE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4D21F2154C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786DC12838A;
	Thu,  7 Mar 2024 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ueX+ADsU"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC284FAF;
	Thu,  7 Mar 2024 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805684; cv=none; b=Sk+7FknTLAeood4DV9exl44IMpqQ7Q2X6U9L2A5o1W3Ttbl2vvRmEx1sppvZzMNMfUdvELN//Cwlsp6f9id8Ui0ZyeOOuD9JJ5dO8hkhRxuBaurbP9jLhroAmQ6uDD3AXbCHuFrTeiNo37zBzjHkEeiedNJdTRVFNB4HhPfr12M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805684; c=relaxed/simple;
	bh=5wlNMC5COMEC+nVBo7GQbYItjwO3yGW0ypj2q0PmPZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCyebIYkDgI43zdPOlqwVtlFddycuIwM5SI4999pXbbDcg4vyht/fkm9yTU8OKusz6LaZYFxXVkzBTrLal+rfrgnNsqlClXrkFRQJTxQT556l2UIq1AWA0C5L7FvWlFXTAWv6Q7TDBRDynxFdRvhoEwb62zwD40/2eMUk2qLRB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ueX+ADsU; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709805680; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QJG4XVpyDbqfH79yfrnsyf6IB4nYg+t5eEXV9gnRZiM=;
	b=ueX+ADsUfBNPMpqZ/wJJaSHcOU0qF7KMvGgYAcZILXyxBB2d/XD3TXiVqadPPqG8dZZY5OQIwhgGusRz2P+sekTXI7Ik6PVzGr02fTh2knDmm0YOaKP+Owij+Sk2owpbDYSwF70cm7ylXCUUUE6IXgktykp5wOzfMOYTCj5PmJA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2-HiFU_1709805356;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2-HiFU_1709805356)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 17:55:58 +0800
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
Subject: [PATCH net-next v2 08/11] net/smc: add operations to merge sndbuf with peer DMB
Date: Thu,  7 Mar 2024 17:55:33 +0800
Message-Id: <20240307095536.29648-9-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240307095536.29648-1-guwen@linux.alibaba.com>
References: <20240307095536.29648-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some scenarios using Emulated-ISM device, sndbuf can share the same
physical memory region with peer DMB to avoid data copy from one side
to the other. In such case the sndbuf is only a descriptor that
describes the shared memory and does not actually occupy memory, it's
more like a ghost buffer.

      +----------+                     +----------+
      | socket A |                     | socket B |
      +----------+                     +----------+
            |                               |
       +--------+                       +--------+
       | sndbuf |                       |  DMB   |
       |  desc  |                       |  desc  |
       +--------+                       +--------+
            |                               |
            |                          +----v-----+
            +-------------------------->  memory  |
                                       +----------+

So here introduces three new SMC-D device operations to check if this
feature is supported by device, and to {attach|detach} ghost sndbuf to
peer DMB. For now only loopback-ism supports this.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 include/net/smc.h |  3 +++
 net/smc/smc_ism.c | 40 ++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_ism.h |  4 ++++
 3 files changed, 47 insertions(+)

diff --git a/include/net/smc.h b/include/net/smc.h
index 6273c3a8b24a..01387631d8a6 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -62,6 +62,9 @@ struct smcd_ops {
 	int (*register_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb,
 			    void *client);
 	int (*unregister_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
+	int (*support_dmb_nocopy)(struct smcd_dev *dev);
+	int (*attach_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
+	int (*detach_dmb)(struct smcd_dev *dev, u64 token);
 	int (*add_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
 	int (*del_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
 	int (*set_vlan_required)(struct smcd_dev *dev);
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index c50910300a03..67ab9bce202a 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -246,6 +246,46 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 	return rc;
 }
 
+bool smc_ism_support_dmb_nocopy(struct smcd_dev *smcd)
+{
+	/* for now only loopback-ism supports
+	 * merging sndbuf with peer DMB to avoid
+	 * data copies between them.
+	 */
+	return (smcd->ops->support_dmb_nocopy &&
+		smcd->ops->support_dmb_nocopy(smcd));
+}
+
+int smc_ism_attach_dmb(struct smcd_dev *dev, u64 token,
+		       struct smc_buf_desc *dmb_desc)
+{
+	struct smcd_dmb dmb;
+	int rc = 0;
+
+	if (!dev->ops->attach_dmb)
+		return -EINVAL;
+
+	memset(&dmb, 0, sizeof(dmb));
+	dmb.dmb_tok = token;
+	rc = dev->ops->attach_dmb(dev, &dmb);
+	if (!rc) {
+		dmb_desc->sba_idx = dmb.sba_idx;
+		dmb_desc->token = dmb.dmb_tok;
+		dmb_desc->cpu_addr = dmb.cpu_addr;
+		dmb_desc->dma_addr = dmb.dma_addr;
+		dmb_desc->len = dmb.dmb_len;
+	}
+	return rc;
+}
+
+int smc_ism_detach_dmb(struct smcd_dev *dev, u64 token)
+{
+	if (!dev->ops->detach_dmb)
+		return -EINVAL;
+
+	return dev->ops->detach_dmb(dev, token);
+}
+
 static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 				  struct sk_buff *skb,
 				  struct netlink_callback *cb)
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 2ea169c1301c..83cf99265160 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -48,6 +48,10 @@ int smc_ism_put_vlan(struct smcd_dev *dev, unsigned short vlan_id);
 int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
 			 struct smc_buf_desc *dmb_desc);
 int smc_ism_unregister_dmb(struct smcd_dev *dev, struct smc_buf_desc *dmb_desc);
+bool smc_ism_support_dmb_nocopy(struct smcd_dev *smcd);
+int smc_ism_attach_dmb(struct smcd_dev *dev, u64 token,
+		       struct smc_buf_desc *dmb_desc);
+int smc_ism_detach_dmb(struct smcd_dev *dev, u64 token);
 int smc_ism_signal_shutdown(struct smc_link_group *lgr);
 void smc_ism_get_system_eid(u8 **eid);
 u16 smc_ism_get_chid(struct smcd_dev *dev);
-- 
2.32.0.3.g01195cf9f


