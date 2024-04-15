Return-Path: <linux-kernel+bounces-144986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 086DE8A4DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC54B243D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B618605B6;
	Mon, 15 Apr 2024 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kSRxP7JX"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2067A01;
	Mon, 15 Apr 2024 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180342; cv=none; b=LI+qMku9B91Dfv3mIr2mAhU6giI9pCqM2EL8A921E35+PcM/woNlNjaX2ETpzLnMq3V9aLlByKIB0Vgh0d19aC9eJjgSsz86dIqea8mE8io/stPGvdJBoGQs+geRNCvzhFFdrDb73vQneDVh/IMa9Z0V1/hYGmfhdKLe+VsSrDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180342; c=relaxed/simple;
	bh=9QKS3M7DS/KsSM721mf5dJ+Ca/wHULMChlgtx9OyE4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CAF0h/By4jGLsKCBgzrTh0oKvsC+zDPtuRmma0Zwzfw9bHhxt1yMxXtPxn1K1bPayV6qIwl563buWcJfSxaIofN5FUKJxlTXRSpg5/kGlcP89qKT8gUHJbsGoFOcu9Lx034NtCVedKbFS+v80VkhNJWoVALxheg7xkpByg1YUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kSRxP7JX; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id wKRerx2nqPlGBwKReriKR4; Mon, 15 Apr 2024 13:24:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713180261;
	bh=ub4eBCk8TBPNCwE8W3RDmCm3hBSXAehuhbWgGV6jTnI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kSRxP7JX6jTcA8/uJSqnnk9ne7reFCXZZm1Mfa5+Xnymb251WK/qMJ6mCXM9NBsn4
	 h8pZelhfJFAdPZwqeY+ljhvdmwxFyoBVtL09gzURZKmnIzfKrqvKydE+qI6ljA2DW1
	 hkberrIoc28ydprnSygtlOyFW8Zk86A3eiWvOiya7U78rTsujl2rJAIRFnCNR9kaPF
	 4BEe5wSLNgcZi2boq5I+tRauo96eqol87XDwHFJA/nAO1lN1L/k7lNPTpdDlAYMufm
	 rH6evc+nXnSneuk+sHFlFzAG1DZMkIqPc+VA0E+JJr8vw/d+ATIiCQGJ9Ed8NZyPZZ
	 tFRYenYaUgZ0g==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Apr 2024 13:24:21 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Kang Yang <quic_kangyang@quicinc.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH] wifi: ath11k: Fix error handling in ath11k_wmi_p2p_noa_event()
Date: Mon, 15 Apr 2024 13:23:46 +0200
Message-ID: <6ee80f65f736db1646f6f201f60816cf35b6f3fe.1713180046.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if (noa_descriptors > WMI_P2P_MAX_NOA_DESCRIPTORS), there is a mix of
return and goto. in such a case, 'ret' should be assigned an error code and
the 'td' should be freed to avoid a memory leak.

While at it, return 'ret' instead of 0 in case of error.
This is actually harmless, because the only caller does not handle the
return value.

Fixes: 2408379f15a1 ("wifi: ath11k: implement handling of P2P NoA event")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index c74aa3f95658..589a1b5ec517 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8657,7 +8657,7 @@ static int ath11k_wmi_p2p_noa_event(struct ath11k_base *ab,
 	const struct wmi_p2p_noa_event *ev;
 	const struct ath11k_wmi_p2p_noa_info *noa;
 	struct ath11k *ar;
-	int ret, vdev_id;
+	int ret = 0, vdev_id;
 	u8 noa_descriptors;
 
 	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
@@ -8682,7 +8682,7 @@ static int ath11k_wmi_p2p_noa_event(struct ath11k_base *ab,
 	if (noa_descriptors > WMI_P2P_MAX_NOA_DESCRIPTORS) {
 		ath11k_warn(ab, "invalid descriptor num %d in P2P NoA event\n",
 			    noa_descriptors);
-		return -EINVAL;
+		ret = -EINVAL;
 		goto out;
 	}
 
@@ -8705,7 +8705,7 @@ static int ath11k_wmi_p2p_noa_event(struct ath11k_base *ab,
 	rcu_read_unlock();
 out:
 	kfree(tb);
-	return 0;
+	return ret;
 }
 
 static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
-- 
2.44.0


