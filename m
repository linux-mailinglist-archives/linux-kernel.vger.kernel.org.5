Return-Path: <linux-kernel+bounces-105873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AEE87E5C5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D2F0B21A31
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B3D2C1A2;
	Mon, 18 Mar 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ox1qvdrE"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D892C684;
	Mon, 18 Mar 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754220; cv=none; b=qlMlFLHkdPDmlgQl6CfvSpY/uvJ6H2OKhJczXFu1NAW9WJ5a9SyNYjCqzgeLyx1h7kCNAzJ6XngvuVToaTkK8xHOQ97pCnGHIA8Ste2U/zvs4bhMhE3vvteSXLtwC+1BKZDns4uTj8uzqu7Pe+OjnmxBSAa0NBS975/RLlNWC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754220; c=relaxed/simple;
	bh=AvG05bOAqCfW3mtdtc14/HmRdKKW+RFh9E+I4yU3QTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+5bYxivxsbqfKJdTdWZnyP5GdIxBNWAOKP4BGWnKrSDBMkzdvgDe9H2hAMRvRtTk50Bc3qxUKhD5aRDpe4z93P8cT6I4TZJ/asLSXX+RbStUgBQ0JXhGhbXw84PAnxvIm6hn03ZEqMIFw6LCTO+7tkdRFzpBeh3qUQo8yoVaZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ox1qvdrE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HLjwKV031842;
	Mon, 18 Mar 2024 02:30:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=isW5mqa9NPx5U3PbC7doE
	zW3t1L+uU6y/zaitkdS8ko=; b=Ox1qvdrEJnLfTDd6QzITnqtwPOkd01fIDr2MN
	H/apKEKFkBYT3sPQZwQRs+g209pLR7b1e8LpluideucEZ3nNRV6nt9P1bRuV1yzc
	jF3e7VTS/kej7ZN9LEIr3LkxCMoOZ7xGwO45UQR8iomnXrzEVJsWVjaxb4qtt25K
	25Fkyt4CvswbsCNP/FF4jU2WtlyQe5DE2dhQ8xX8S4UgQfsuxHfx/cXs9JGohmvx
	9Ql8Q8cp2hpUv1DObbCMk9BVmPXuiB0RACam5vUtbEMrs6FJtU7x+khbXXv98oXI
	id0DNOd2195p9JIO8b8BCL70BDKJrOUjKI89LcklXGKh8qC/Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ww8skmj0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 02:30:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 18 Mar 2024 02:30:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 18 Mar 2024 02:30:09 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id EEAE33F7087;
	Mon, 18 Mar 2024 02:30:05 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [v2 net PATCH 1/5] octeontx2: Detect the mbox up or down message via register
Date: Mon, 18 Mar 2024 14:59:54 +0530
Message-ID: <1710754198-18632-2-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1710754198-18632-1-git-send-email-sbhatta@marvell.com>
References: <1710754198-18632-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: e-qjCWLSO6YURWcs-nDJV_4c89cmbcw3
X-Proofpoint-GUID: e-qjCWLSO6YURWcs-nDJV_4c89cmbcw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-18_01,2023-05-22_02

A single line of interrupt is used to receive up notifications
and down reply messages from AF to PF (similarly from PF to its VF).
PF acts as bridge and forwards VF messages to AF and sends respsones
back from AF to VF. When an async event like link event is received
by up message when PF is in middle of forwarding VF message then
mailbox errors occur because PF state machine is corrupted.
Since VF is a separate driver or VF driver can be in a VM it is
not possible to serialize from the start of communication at VF.
Hence to differentiate between type of messages at PF this patch makes
sender to set mbox data register with distinct values for up and down
messages. Sender also checks whether previous interrupt is received
before triggering current interrupt by waiting for mailbox data register
to become zero.

Fixes: 5a6d7c9daef3 ("octeontx2-pf: Mailbox communication with AF")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   |  43 +++++++-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   6 ++
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c |  17 ++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  14 ++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   2 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  20 ++--
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 113 ++++++++++++++-------
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |  71 ++++++++-----
 9 files changed, 205 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index b92264d..1e5aa53 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -214,11 +214,12 @@ int otx2_mbox_busy_poll_for_rsp(struct otx2_mbox *mbox, int devid)
 }
 EXPORT_SYMBOL(otx2_mbox_busy_poll_for_rsp);
 
-void otx2_mbox_msg_send(struct otx2_mbox *mbox, int devid)
+static void otx2_mbox_msg_send_data(struct otx2_mbox *mbox, int devid, u64 data)
 {
 	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
 	struct mbox_hdr *tx_hdr, *rx_hdr;
 	void *hw_mbase = mdev->hwbase;
+	u64 intr_val;
 
 	tx_hdr = hw_mbase + mbox->tx_start;
 	rx_hdr = hw_mbase + mbox->rx_start;
@@ -254,14 +255,52 @@ void otx2_mbox_msg_send(struct otx2_mbox *mbox, int devid)
 
 	spin_unlock(&mdev->mbox_lock);
 
+	/* Check if interrupt pending */
+	intr_val = readq((void __iomem *)mbox->reg_base +
+		     (mbox->trigger | (devid << mbox->tr_shift)));
+
+	intr_val |= data;
 	/* The interrupt should be fired after num_msgs is written
 	 * to the shared memory
 	 */
-	writeq(1, (void __iomem *)mbox->reg_base +
+	writeq(intr_val, (void __iomem *)mbox->reg_base +
 	       (mbox->trigger | (devid << mbox->tr_shift)));
 }
+
+void otx2_mbox_msg_send(struct otx2_mbox *mbox, int devid)
+{
+	otx2_mbox_msg_send_data(mbox, devid, MBOX_DOWN_MSG);
+}
 EXPORT_SYMBOL(otx2_mbox_msg_send);
 
+void otx2_mbox_msg_send_up(struct otx2_mbox *mbox, int devid)
+{
+	otx2_mbox_msg_send_data(mbox, devid, MBOX_UP_MSG);
+}
+EXPORT_SYMBOL(otx2_mbox_msg_send_up);
+
+bool otx2_mbox_wait_for_zero(struct otx2_mbox *mbox, int devid)
+{
+	u64 data;
+
+	data = readq((void __iomem *)mbox->reg_base +
+		     (mbox->trigger | (devid << mbox->tr_shift)));
+
+	/* If data is non-zero wait for ~1ms and return to caller
+	 * whether data has changed to zero or not after the wait.
+	 */
+	if (!data)
+		return true;
+
+	usleep_range(950, 1000);
+
+	data = readq((void __iomem *)mbox->reg_base +
+		     (mbox->trigger | (devid << mbox->tr_shift)));
+
+	return data == 0;
+}
+EXPORT_SYMBOL(otx2_mbox_wait_for_zero);
+
 struct mbox_msghdr *otx2_mbox_alloc_msg_rsp(struct otx2_mbox *mbox, int devid,
 					    int size, int size_rsp)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 61ab7f6..eb2a20b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -16,6 +16,9 @@
 
 #define MBOX_SIZE		SZ_64K
 
+#define MBOX_DOWN_MSG		1
+#define MBOX_UP_MSG		2
+
 /* AF/PF: PF initiated, PF/VF VF initiated */
 #define MBOX_DOWN_RX_START	0
 #define MBOX_DOWN_RX_SIZE	(46 * SZ_1K)
@@ -101,6 +104,7 @@ int otx2_mbox_regions_init(struct otx2_mbox *mbox, void __force **hwbase,
 			   struct pci_dev *pdev, void __force *reg_base,
 			   int direction, int ndevs, unsigned long *bmap);
 void otx2_mbox_msg_send(struct otx2_mbox *mbox, int devid);
+void otx2_mbox_msg_send_up(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_wait_for_rsp(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_busy_poll_for_rsp(struct otx2_mbox *mbox, int devid);
 struct mbox_msghdr *otx2_mbox_alloc_msg_rsp(struct otx2_mbox *mbox, int devid,
@@ -118,6 +122,8 @@ static inline struct mbox_msghdr *otx2_mbox_alloc_msg(struct otx2_mbox *mbox,
 	return otx2_mbox_alloc_msg_rsp(mbox, devid, size, 0);
 }
 
+bool otx2_mbox_wait_for_zero(struct otx2_mbox *mbox, int devid);
+
 /* Mailbox message types */
 #define MBOX_MSG_MASK				0xFFFF
 #define MBOX_MSG_INVALID			0xFFFE
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
index dfd2358..d39d86e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
@@ -121,13 +121,17 @@ int mcs_add_intr_wq_entry(struct mcs *mcs, struct mcs_intr_event *event)
 static int mcs_notify_pfvf(struct mcs_intr_event *event, struct rvu *rvu)
 {
 	struct mcs_intr_info *req;
-	int err, pf;
+	int pf;
 
 	pf = rvu_get_pf(event->pcifunc);
 
+	mutex_lock(&rvu->mbox_lock);
+
 	req = otx2_mbox_alloc_msg_mcs_intr_notify(rvu, pf);
-	if (!req)
+	if (!req) {
+		mutex_unlock(&rvu->mbox_lock);
 		return -ENOMEM;
+	}
 
 	req->mcs_id = event->mcs_id;
 	req->intr_mask = event->intr_mask;
@@ -135,10 +139,11 @@ static int mcs_notify_pfvf(struct mcs_intr_event *event, struct rvu *rvu)
 	req->hdr.pcifunc = event->pcifunc;
 	req->lmac_id = event->lmac_id;
 
-	otx2_mbox_msg_send(&rvu->afpf_wq_info.mbox_up, pf);
-	err = otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pf);
-	if (err)
-		dev_warn(rvu->dev, "MCS notification to pf %d failed\n", pf);
+	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pf);
+
+	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
+
+	mutex_unlock(&rvu->mbox_lock);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 07d4859..0b65a18 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2119,7 +2119,7 @@ MBOX_MESSAGES
 	}
 }
 
-static void __rvu_mbox_handler(struct rvu_work *mwork, int type)
+static void __rvu_mbox_handler(struct rvu_work *mwork, int type, bool poll)
 {
 	struct rvu *rvu = mwork->rvu;
 	int offset, err, id, devid;
@@ -2186,6 +2186,9 @@ static void __rvu_mbox_handler(struct rvu_work *mwork, int type)
 	}
 	mw->mbox_wrk[devid].num_msgs = 0;
 
+	if (poll)
+		otx2_mbox_wait_for_zero(mbox, devid);
+
 	/* Send mbox responses to VF/PF */
 	otx2_mbox_msg_send(mbox, devid);
 }
@@ -2193,15 +2196,18 @@ static void __rvu_mbox_handler(struct rvu_work *mwork, int type)
 static inline void rvu_afpf_mbox_handler(struct work_struct *work)
 {
 	struct rvu_work *mwork = container_of(work, struct rvu_work, work);
+	struct rvu *rvu = mwork->rvu;
 
-	__rvu_mbox_handler(mwork, TYPE_AFPF);
+	mutex_lock(&rvu->mbox_lock);
+	__rvu_mbox_handler(mwork, TYPE_AFPF, true);
+	mutex_unlock(&rvu->mbox_lock);
 }
 
 static inline void rvu_afvf_mbox_handler(struct work_struct *work)
 {
 	struct rvu_work *mwork = container_of(work, struct rvu_work, work);
 
-	__rvu_mbox_handler(mwork, TYPE_AFVF);
+	__rvu_mbox_handler(mwork, TYPE_AFVF, false);
 }
 
 static void __rvu_mbox_up_handler(struct rvu_work *mwork, int type)
@@ -2376,6 +2382,8 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		}
 	}
 
+	mutex_init(&rvu->mbox_lock);
+
 	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
 	if (!mbox_regions) {
 		err = -ENOMEM;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index f390525..3583468 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -591,6 +591,8 @@ struct rvu {
 	spinlock_t		mcs_intrq_lock;
 	/* CPT interrupt lock */
 	spinlock_t		cpt_intr_lock;
+
+	struct mutex		mbox_lock; /* Serialize mbox up and down msgs */
 };
 
 static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 38acdc7..72e060c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -232,7 +232,7 @@ static void cgx_notify_pfs(struct cgx_link_event *event, struct rvu *rvu)
 	struct cgx_link_user_info *linfo;
 	struct cgx_link_info_msg *msg;
 	unsigned long pfmap;
-	int err, pfid;
+	int pfid;
 
 	linfo = &event->link_uinfo;
 	pfmap = cgxlmac_to_pfmap(rvu, event->cgx_id, event->lmac_id);
@@ -255,16 +255,22 @@ static void cgx_notify_pfs(struct cgx_link_event *event, struct rvu *rvu)
 			continue;
 		}
 
+		mutex_lock(&rvu->mbox_lock);
+
 		/* Send mbox message to PF */
 		msg = otx2_mbox_alloc_msg_cgx_link_event(rvu, pfid);
-		if (!msg)
+		if (!msg) {
+			mutex_unlock(&rvu->mbox_lock);
 			continue;
+		}
+
 		msg->link_info = *linfo;
-		otx2_mbox_msg_send(&rvu->afpf_wq_info.mbox_up, pfid);
-		err = otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pfid);
-		if (err)
-			dev_warn(rvu->dev, "notification to pf %d failed\n",
-				 pfid);
+
+		otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pfid);
+
+		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pfid);
+
+		mutex_unlock(&rvu->mbox_lock);
 	} while (pfmap);
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 0691030..7e16a34 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -815,7 +815,7 @@ static inline int otx2_sync_mbox_up_msg(struct mbox *mbox, int devid)
 
 	if (!otx2_mbox_nonempty(&mbox->mbox_up, devid))
 		return 0;
-	otx2_mbox_msg_send(&mbox->mbox_up, devid);
+	otx2_mbox_msg_send_up(&mbox->mbox_up, devid);
 	err = otx2_mbox_wait_for_rsp(&mbox->mbox_up, devid);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index e5fe67e..3c8841b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -292,8 +292,8 @@ static int otx2_pf_flr_init(struct otx2_nic *pf, int num_vfs)
 	return 0;
 }
 
-static void otx2_queue_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
-			    int first, int mdevs, u64 intr, int type)
+static void otx2_queue_vf_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
+			       int first, int mdevs, u64 intr)
 {
 	struct otx2_mbox_dev *mdev;
 	struct otx2_mbox *mbox;
@@ -307,40 +307,26 @@ static void otx2_queue_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
 
 		mbox = &mw->mbox;
 		mdev = &mbox->dev[i];
-		if (type == TYPE_PFAF)
-			otx2_sync_mbox_bbuf(mbox, i);
 		hdr = mdev->mbase + mbox->rx_start;
 		/* The hdr->num_msgs is set to zero immediately in the interrupt
-		 * handler to  ensure that it holds a correct value next time
-		 * when the interrupt handler is called.
-		 * pf->mbox.num_msgs holds the data for use in pfaf_mbox_handler
-		 * pf>mbox.up_num_msgs holds the data for use in
-		 * pfaf_mbox_up_handler.
+		 * handler to ensure that it holds a correct value next time
+		 * when the interrupt handler is called. pf->mw[i].num_msgs
+		 * holds the data for use in otx2_pfvf_mbox_handler and
+		 * pf->mw[i].up_num_msgs holds the data for use in
+		 * otx2_pfvf_mbox_up_handler.
 		 */
 		if (hdr->num_msgs) {
 			mw[i].num_msgs = hdr->num_msgs;
 			hdr->num_msgs = 0;
-			if (type == TYPE_PFAF)
-				memset(mbox->hwbase + mbox->rx_start, 0,
-				       ALIGN(sizeof(struct mbox_hdr),
-					     sizeof(u64)));
-
 			queue_work(mbox_wq, &mw[i].mbox_wrk);
 		}
 
 		mbox = &mw->mbox_up;
 		mdev = &mbox->dev[i];
-		if (type == TYPE_PFAF)
-			otx2_sync_mbox_bbuf(mbox, i);
 		hdr = mdev->mbase + mbox->rx_start;
 		if (hdr->num_msgs) {
 			mw[i].up_num_msgs = hdr->num_msgs;
 			hdr->num_msgs = 0;
-			if (type == TYPE_PFAF)
-				memset(mbox->hwbase + mbox->rx_start, 0,
-				       ALIGN(sizeof(struct mbox_hdr),
-					     sizeof(u64)));
-
 			queue_work(mbox_wq, &mw[i].mbox_up_wrk);
 		}
 	}
@@ -356,8 +342,10 @@ static void otx2_forward_msg_pfvf(struct otx2_mbox_dev *mdev,
 	/* Msgs are already copied, trigger VF's mbox irq */
 	smp_wmb();
 
+	otx2_mbox_wait_for_zero(pfvf_mbox, devid);
+
 	offset = pfvf_mbox->trigger | (devid << pfvf_mbox->tr_shift);
-	writeq(1, (void __iomem *)pfvf_mbox->reg_base + offset);
+	writeq(MBOX_DOWN_MSG, (void __iomem *)pfvf_mbox->reg_base + offset);
 
 	/* Restore VF's mbox bounce buffer region address */
 	src_mdev->mbase = bbuf_base;
@@ -547,7 +535,7 @@ static void otx2_pfvf_mbox_up_handler(struct work_struct *work)
 end:
 		offset = mbox->rx_start + msg->next_msgoff;
 		if (mdev->msgs_acked == (vf_mbox->up_num_msgs - 1))
-			__otx2_mbox_reset(mbox, 0);
+			__otx2_mbox_reset(mbox, vf_idx);
 		mdev->msgs_acked++;
 	}
 }
@@ -564,8 +552,7 @@ static irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
 	if (vfs > 64) {
 		intr = otx2_read64(pf, RVU_PF_VFPF_MBOX_INTX(1));
 		otx2_write64(pf, RVU_PF_VFPF_MBOX_INTX(1), intr);
-		otx2_queue_work(mbox, pf->mbox_pfvf_wq, 64, vfs, intr,
-				TYPE_PFVF);
+		otx2_queue_vf_work(mbox, pf->mbox_pfvf_wq, 64, vfs, intr);
 		if (intr)
 			trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
 		vfs = 64;
@@ -574,7 +561,7 @@ static irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
 	intr = otx2_read64(pf, RVU_PF_VFPF_MBOX_INTX(0));
 	otx2_write64(pf, RVU_PF_VFPF_MBOX_INTX(0), intr);
 
-	otx2_queue_work(mbox, pf->mbox_pfvf_wq, 0, vfs, intr, TYPE_PFVF);
+	otx2_queue_vf_work(mbox, pf->mbox_pfvf_wq, 0, vfs, intr);
 
 	if (intr)
 		trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
@@ -821,20 +808,22 @@ static void otx2_pfaf_mbox_handler(struct work_struct *work)
 	struct mbox *af_mbox;
 	struct otx2_nic *pf;
 	int offset, id;
+	u16 num_msgs;
 
 	af_mbox = container_of(work, struct mbox, mbox_wrk);
 	mbox = &af_mbox->mbox;
 	mdev = &mbox->dev[0];
 	rsp_hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+	num_msgs = rsp_hdr->num_msgs;
 
 	offset = mbox->rx_start + ALIGN(sizeof(*rsp_hdr), MBOX_MSG_ALIGN);
 	pf = af_mbox->pfvf;
 
-	for (id = 0; id < af_mbox->num_msgs; id++) {
+	for (id = 0; id < num_msgs; id++) {
 		msg = (struct mbox_msghdr *)(mdev->mbase + offset);
 		otx2_process_pfaf_mbox_msg(pf, msg);
 		offset = mbox->rx_start + msg->next_msgoff;
-		if (mdev->msgs_acked == (af_mbox->num_msgs - 1))
+		if (mdev->msgs_acked == (num_msgs - 1))
 			__otx2_mbox_reset(mbox, 0);
 		mdev->msgs_acked++;
 	}
@@ -945,12 +934,14 @@ static void otx2_pfaf_mbox_up_handler(struct work_struct *work)
 	int offset, id, devid = 0;
 	struct mbox_hdr *rsp_hdr;
 	struct mbox_msghdr *msg;
+	u16 num_msgs;
 
 	rsp_hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+	num_msgs = rsp_hdr->num_msgs;
 
 	offset = mbox->rx_start + ALIGN(sizeof(*rsp_hdr), MBOX_MSG_ALIGN);
 
-	for (id = 0; id < af_mbox->up_num_msgs; id++) {
+	for (id = 0; id < num_msgs; id++) {
 		msg = (struct mbox_msghdr *)(mdev->mbase + offset);
 
 		devid = msg->pcifunc & RVU_PFVF_FUNC_MASK;
@@ -959,10 +950,11 @@ static void otx2_pfaf_mbox_up_handler(struct work_struct *work)
 			otx2_process_mbox_msg_up(pf, msg);
 		offset = mbox->rx_start + msg->next_msgoff;
 	}
-	if (devid) {
+	/* Forward to VF iff VFs are really present */
+	if (devid && pci_num_vf(pf->pdev)) {
 		otx2_forward_vf_mbox_msgs(pf, &pf->mbox.mbox_up,
 					  MBOX_DIR_PFVF_UP, devid - 1,
-					  af_mbox->up_num_msgs);
+					  num_msgs);
 		return;
 	}
 
@@ -972,16 +964,49 @@ static void otx2_pfaf_mbox_up_handler(struct work_struct *work)
 static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 {
 	struct otx2_nic *pf = (struct otx2_nic *)pf_irq;
-	struct mbox *mbox;
+	struct mbox *mw = &pf->mbox;
+	struct otx2_mbox_dev *mdev;
+	struct otx2_mbox *mbox;
+	struct mbox_hdr *hdr;
+	u64 mbox_data;
 
 	/* Clear the IRQ */
 	otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
 
-	mbox = &pf->mbox;
 
-	trace_otx2_msg_interrupt(mbox->mbox.pdev, "AF to PF", BIT_ULL(0));
+	mbox_data = otx2_read64(pf, RVU_PF_PFAF_MBOX0);
+
+	if (mbox_data & MBOX_UP_MSG) {
+		mbox_data &= ~MBOX_UP_MSG;
+		otx2_write64(pf, RVU_PF_PFAF_MBOX0, mbox_data);
+
+		mbox = &mw->mbox_up;
+		mdev = &mbox->dev[0];
+		otx2_sync_mbox_bbuf(mbox, 0);
+
+		hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+		if (hdr->num_msgs)
+			queue_work(pf->mbox_wq, &mw->mbox_up_wrk);
+
+		trace_otx2_msg_interrupt(pf->pdev, "UP message from AF to PF",
+					 BIT_ULL(0));
+	}
+
+	if (mbox_data & MBOX_DOWN_MSG) {
+		mbox_data &= ~MBOX_DOWN_MSG;
+		otx2_write64(pf, RVU_PF_PFAF_MBOX0, mbox_data);
+
+		mbox = &mw->mbox;
+		mdev = &mbox->dev[0];
+		otx2_sync_mbox_bbuf(mbox, 0);
+
+		hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+		if (hdr->num_msgs)
+			queue_work(pf->mbox_wq, &mw->mbox_wrk);
 
-	otx2_queue_work(mbox, pf->mbox_wq, 0, 1, 1, TYPE_PFAF);
+		trace_otx2_msg_interrupt(pf->pdev, "DOWN reply from AF to PF",
+					 BIT_ULL(0));
+	}
 
 	return IRQ_HANDLED;
 }
@@ -3087,6 +3112,7 @@ static void otx2_vf_link_event_task(struct work_struct *work)
 	struct otx2_vf_config *config;
 	struct cgx_link_info_msg *req;
 	struct mbox_msghdr *msghdr;
+	struct delayed_work *dwork;
 	struct otx2_nic *pf;
 	int vf_idx;
 
@@ -3095,10 +3121,21 @@ static void otx2_vf_link_event_task(struct work_struct *work)
 	vf_idx = config - config->pf->vf_configs;
 	pf = config->pf;
 
+	mutex_lock(&pf->mbox.lock);
+
+	dwork = &config->link_event_work;
+
+	if (!otx2_mbox_wait_for_zero(&pf->mbox_pfvf[0].mbox_up, vf_idx)) {
+		schedule_delayed_work(dwork, msecs_to_jiffies(100));
+		mutex_unlock(&pf->mbox.lock);
+		return;
+	}
+
 	msghdr = otx2_mbox_alloc_msg_rsp(&pf->mbox_pfvf[0].mbox_up, vf_idx,
 					 sizeof(*req), sizeof(struct msg_rsp));
 	if (!msghdr) {
 		dev_err(pf->dev, "Failed to create VF%d link event\n", vf_idx);
+		mutex_unlock(&pf->mbox.lock);
 		return;
 	}
 
@@ -3107,7 +3144,11 @@ static void otx2_vf_link_event_task(struct work_struct *work)
 	req->hdr.sig = OTX2_MBOX_REQ_SIG;
 	memcpy(&req->link_info, &pf->linfo, sizeof(req->link_info));
 
-	otx2_sync_mbox_up_msg(&pf->mbox_pfvf[0], vf_idx);
+	otx2_mbox_wait_for_zero(&pf->mbox_pfvf[0].mbox_up, vf_idx);
+
+	otx2_mbox_msg_send_up(&pf->mbox_pfvf[0].mbox_up, vf_idx);
+
+	mutex_unlock(&pf->mbox.lock);
 }
 
 static int otx2_sriov_enable(struct pci_dev *pdev, int numvfs)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 35e06048..ced456c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -89,16 +89,20 @@ static void otx2vf_vfaf_mbox_handler(struct work_struct *work)
 	struct otx2_mbox *mbox;
 	struct mbox *af_mbox;
 	int offset, id;
+	u16 num_msgs;
 
 	af_mbox = container_of(work, struct mbox, mbox_wrk);
 	mbox = &af_mbox->mbox;
 	mdev = &mbox->dev[0];
 	rsp_hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
-	if (af_mbox->num_msgs == 0)
+	num_msgs = rsp_hdr->num_msgs;
+
+	if (num_msgs == 0)
 		return;
+
 	offset = mbox->rx_start + ALIGN(sizeof(*rsp_hdr), MBOX_MSG_ALIGN);
 
-	for (id = 0; id < af_mbox->num_msgs; id++) {
+	for (id = 0; id < num_msgs; id++) {
 		msg = (struct mbox_msghdr *)(mdev->mbase + offset);
 		otx2vf_process_vfaf_mbox_msg(af_mbox->pfvf, msg);
 		offset = mbox->rx_start + msg->next_msgoff;
@@ -151,6 +155,7 @@ static void otx2vf_vfaf_mbox_up_handler(struct work_struct *work)
 	struct mbox *vf_mbox;
 	struct otx2_nic *vf;
 	int offset, id;
+	u16 num_msgs;
 
 	vf_mbox = container_of(work, struct mbox, mbox_up_wrk);
 	vf = vf_mbox->pfvf;
@@ -158,12 +163,14 @@ static void otx2vf_vfaf_mbox_up_handler(struct work_struct *work)
 	mdev = &mbox->dev[0];
 
 	rsp_hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
-	if (vf_mbox->up_num_msgs == 0)
+	num_msgs = rsp_hdr->num_msgs;
+
+	if (num_msgs == 0)
 		return;
 
 	offset = mbox->rx_start + ALIGN(sizeof(*rsp_hdr), MBOX_MSG_ALIGN);
 
-	for (id = 0; id < vf_mbox->up_num_msgs; id++) {
+	for (id = 0; id < num_msgs; id++) {
 		msg = (struct mbox_msghdr *)(mdev->mbase + offset);
 		otx2vf_process_mbox_msg_up(vf, msg);
 		offset = mbox->rx_start + msg->next_msgoff;
@@ -178,40 +185,48 @@ static irqreturn_t otx2vf_vfaf_mbox_intr_handler(int irq, void *vf_irq)
 	struct otx2_mbox_dev *mdev;
 	struct otx2_mbox *mbox;
 	struct mbox_hdr *hdr;
+	u64 mbox_data;
 
 	/* Clear the IRQ */
 	otx2_write64(vf, RVU_VF_INT, BIT_ULL(0));
 
+	mbox_data = otx2_read64(vf, RVU_VF_VFPF_MBOX0);
+
 	/* Read latest mbox data */
 	smp_rmb();
 
-	/* Check for PF => VF response messages */
-	mbox = &vf->mbox.mbox;
-	mdev = &mbox->dev[0];
-	otx2_sync_mbox_bbuf(mbox, 0);
+	if (mbox_data & MBOX_DOWN_MSG) {
+		mbox_data &= ~MBOX_DOWN_MSG;
+		otx2_write64(vf, RVU_VF_VFPF_MBOX0, mbox_data);
+
+		/* Check for PF => VF response messages */
+		mbox = &vf->mbox.mbox;
+		mdev = &mbox->dev[0];
+		otx2_sync_mbox_bbuf(mbox, 0);
 
-	trace_otx2_msg_interrupt(mbox->pdev, "PF to VF", BIT_ULL(0));
+		hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+		if (hdr->num_msgs)
+			queue_work(vf->mbox_wq, &vf->mbox.mbox_wrk);
 
-	hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
-	if (hdr->num_msgs) {
-		vf->mbox.num_msgs = hdr->num_msgs;
-		hdr->num_msgs = 0;
-		memset(mbox->hwbase + mbox->rx_start, 0,
-		       ALIGN(sizeof(struct mbox_hdr), sizeof(u64)));
-		queue_work(vf->mbox_wq, &vf->mbox.mbox_wrk);
+		trace_otx2_msg_interrupt(mbox->pdev, "DOWN reply from PF to VF",
+					 BIT_ULL(0));
 	}
-	/* Check for PF => VF notification messages */
-	mbox = &vf->mbox.mbox_up;
-	mdev = &mbox->dev[0];
-	otx2_sync_mbox_bbuf(mbox, 0);
-
-	hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
-	if (hdr->num_msgs) {
-		vf->mbox.up_num_msgs = hdr->num_msgs;
-		hdr->num_msgs = 0;
-		memset(mbox->hwbase + mbox->rx_start, 0,
-		       ALIGN(sizeof(struct mbox_hdr), sizeof(u64)));
-		queue_work(vf->mbox_wq, &vf->mbox.mbox_up_wrk);
+
+	if (mbox_data & MBOX_UP_MSG) {
+		mbox_data &= ~MBOX_UP_MSG;
+		otx2_write64(vf, RVU_VF_VFPF_MBOX0, mbox_data);
+
+		/* Check for PF => VF notification messages */
+		mbox = &vf->mbox.mbox_up;
+		mdev = &mbox->dev[0];
+		otx2_sync_mbox_bbuf(mbox, 0);
+
+		hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+		if (hdr->num_msgs)
+			queue_work(vf->mbox_wq, &vf->mbox.mbox_up_wrk);
+
+		trace_otx2_msg_interrupt(mbox->pdev, "UP message from PF to VF",
+					 BIT_ULL(0));
 	}
 
 	return IRQ_HANDLED;
-- 
2.7.4


