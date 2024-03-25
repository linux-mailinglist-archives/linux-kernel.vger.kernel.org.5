Return-Path: <linux-kernel+bounces-116653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C0888A1E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC152A3891
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135B67EF11;
	Mon, 25 Mar 2024 10:20:48 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 39490127B6A;
	Mon, 25 Mar 2024 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352180; cv=none; b=C0xgduHE1LIvusMG8IaK04hXDwh3OGZEThM17mPC/rnXYo03ygZhuTK91szaUSp7bQPoJC8xzHfxuxCnbvhOaGCmzcYCBDeZ3P8TfAY2lWzfUKLOfSWMSeu2gfUvC22Pkaw6jh29GYi/ap+V92JfA0HH/pCP3jGL3+lLEXlV+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352180; c=relaxed/simple;
	bh=B3EMYWMj93nwUmYvmia6ouNwv5W/jt4RGyZlxKAL1wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=tBANDvk4SprJLwszpKy4PA0yzPQSJNGfOr3PD+zi1uUImwvfNL2Llnve231ebqmumHZUvxi2P7cjlFXcHxRK6OgH1gYT3KcKkQrYlCfse7UVpa7+ggV2cWXZIq1971/GtoDRp+Sm1MQJubPFhhL1GMq1Z5g0AEVdLVnp1LNUpvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id D797C602E36DA;
	Mon, 25 Mar 2024 15:36:08 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] octeontx2-pf: remove unused variables req_hdr and rsp_hdr
Date: Mon, 25 Mar 2024 15:35:51 +0800
Message-Id: <20240325073549.823832-2-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240325073549.823832-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang static checker(scan-buid):
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:503:2: warning:
Value stored to 'rsp_hdr' is never read [deadcode.DeadStores]

Remove these unused variables to save some space.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 3f46d5e0fb2e..637b05c79c42 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -450,7 +450,6 @@ static void otx2_pfvf_mbox_handler(struct work_struct *work)
 	struct mbox_msghdr *msg = NULL;
 	int offset, vf_idx, id, err;
 	struct otx2_mbox_dev *mdev;
-	struct mbox_hdr *req_hdr;
 	struct otx2_mbox *mbox;
 	struct mbox *vf_mbox;
 	struct otx2_nic *pf;
@@ -461,9 +460,8 @@ static void otx2_pfvf_mbox_handler(struct work_struct *work)
 
 	mbox = &pf->mbox_pfvf[0].mbox;
 	mdev = &mbox->dev[vf_idx];
-	req_hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
 
-	offset = ALIGN(sizeof(*req_hdr), MBOX_MSG_ALIGN);
+	offset = ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
 
 	for (id = 0; id < vf_mbox->num_msgs; id++) {
 		msg = (struct mbox_msghdr *)(mdev->mbase + mbox->rx_start +
@@ -494,7 +492,6 @@ static void otx2_pfvf_mbox_up_handler(struct work_struct *work)
 	struct otx2_nic *pf = vf_mbox->pfvf;
 	struct otx2_mbox_dev *mdev;
 	int offset, id, vf_idx = 0;
-	struct mbox_hdr *rsp_hdr;
 	struct mbox_msghdr *msg;
 	struct otx2_mbox *mbox;
 
@@ -502,8 +499,7 @@ static void otx2_pfvf_mbox_up_handler(struct work_struct *work)
 	mbox = &pf->mbox_pfvf[0].mbox_up;
 	mdev = &mbox->dev[vf_idx];
 
-	rsp_hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
-	offset = mbox->rx_start + ALIGN(sizeof(*rsp_hdr), MBOX_MSG_ALIGN);
+	offset = mbox->rx_start + ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
 
 	for (id = 0; id < vf_mbox->up_num_msgs; id++) {
 		msg = mdev->mbase + offset;
-- 
2.30.2


