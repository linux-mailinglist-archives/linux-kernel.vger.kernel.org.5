Return-Path: <linux-kernel+bounces-145875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DF58A5C39
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CD91F22A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C96156F37;
	Mon, 15 Apr 2024 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="k1mUfXcy"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14271B50;
	Mon, 15 Apr 2024 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212880; cv=none; b=AZlV2PqkNzt+skFzfmf2IgDyxpvqA5/ohTA1O6eOpkM1zAcDmz/MBBGtjNk3WeTYBi3fOP/bSM5vbKJsNYFQl3i1Y/jDgdjJrjcujhPhkfmtjvg0Xpxh+Iu9Y6eZe2UUgFGIlAVMENVsx2XFgxguZxulwc08AMP+uwfj8QZqs1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212880; c=relaxed/simple;
	bh=20FFn4xWIkAMgaR8ZOBJJUqa2qzmnCc5kBb0iWBK/TY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7C/0e+e5XgIOP06iYk40lMkzBakd8QsMyNi0waq5zP8Dhjf6RN5gzO3VJKvhg1+5FD0yI+Adz2Wvwya5DbbSNlFz2RWrdhYmUFhIXxWTnpe+8uYa5knehfbEBsiSn2lIBdSOYpqDeVhhkxk+cyw2wObVFAIWpDK5pi4+sloqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=k1mUfXcy; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id wSuarbPSmGdLLwSuar5one; Mon, 15 Apr 2024 22:26:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713212805;
	bh=D6eSL9AbemWWH5HHmLNd9+N8gZj7u/Hg1vi/mWHhr7o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=k1mUfXcylQ5lbkfSJPUOF7WwKpk0Ekoys2XugPd1Ac7PjqNQCngJGGJFf2yi0v70+
	 jR8KC7DcQg6BmOXgaAt8PL4HAyc5RWyA8/2teKMq6CHrviozSk3VuPZRQzSYmNwIEZ
	 5rY/JJhivs+Snq20TYUw0qRCxXpLJhgEZkcU4x7wt26+VrMQEM9EP4T8I4B8fl+BSm
	 f2UZ0zis6wAhaJmIdjfj83qDxvq5GgrJSg37A5GGSwwWBVBCoEMccVfM99Cc1gKn8A
	 HDzEOcEJU+BTAPX3GQzS6ByPYU56f6uz6Th8aic2MfE7vwohGwHB9Qmfxa8FNwp9IN
	 u2n1ZGiwTO5fQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Apr 2024 22:26:45 +0200
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
Subject: [PATCH v2] wifi: ath11k: Fix error handling in ath11k_wmi_p2p_noa_event()
Date: Mon, 15 Apr 2024 22:26:41 +0200
Message-ID: <07f1fc75b2d5b4173ae1b7bb1da5be7f6fc608c8.1713212781.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if (noa_descriptors > WMI_P2P_MAX_NOA_DESCRIPTORS), there is a mix of
return and goto. In such a case, 'td' should be freed to avoid a memory
leak.

While at it, change ath11k_wmi_p2p_noa_event() to return void.
'0' was returned in all cases, even in case of error and the only caller
does not handle the return value.
This is also more consistent with most of functions called from
ath11k_wmi_tlv_op_rx().

Fixes: 2408379f15a1 ("wifi: ath11k: implement handling of P2P NoA event")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in V2
   - Change ath11k_wmi_p2p_noa_event() to return void.   [Jeff Johnson]
   - Update commit message accordingly

V1: https://lore.kernel.org/all/6ee80f65f736db1646f6f201f60816cf35b6f3fe.1713180046.git.christophe.jaillet@wanadoo.fr/
---
 drivers/net/wireless/ath/ath11k/wmi.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index c74aa3f95658..e9ae305a8a61 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8650,30 +8650,27 @@ static void ath11k_wmi_gtk_offload_status_event(struct ath11k_base *ab,
 	kfree(tb);
 }
 
-static int ath11k_wmi_p2p_noa_event(struct ath11k_base *ab,
-				    struct sk_buff *skb)
+static void ath11k_wmi_p2p_noa_event(struct ath11k_base *ab,
+				     struct sk_buff *skb)
 {
 	const void **tb;
 	const struct wmi_p2p_noa_event *ev;
 	const struct ath11k_wmi_p2p_noa_info *noa;
 	struct ath11k *ar;
-	int ret, vdev_id;
+	int vdev_id;
 	u8 noa_descriptors;
 
 	tb = ath11k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
 	if (IS_ERR(tb)) {
-		ret = PTR_ERR(tb);
-		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
-		return ret;
+		ath11k_warn(ab, "failed to parse tlv: %ld\n", PTR_ERR(tb));
+		return;
 	}
 
 	ev = tb[WMI_TAG_P2P_NOA_EVENT];
 	noa = tb[WMI_TAG_P2P_NOA_INFO];
 
-	if (!ev || !noa) {
-		ret = -EPROTO;
+	if (!ev || !noa)
 		goto out;
-	}
 
 	vdev_id = ev->vdev_id;
 	noa_descriptors = u32_get_bits(noa->noa_attr,
@@ -8682,7 +8679,6 @@ static int ath11k_wmi_p2p_noa_event(struct ath11k_base *ab,
 	if (noa_descriptors > WMI_P2P_MAX_NOA_DESCRIPTORS) {
 		ath11k_warn(ab, "invalid descriptor num %d in P2P NoA event\n",
 			    noa_descriptors);
-		return -EINVAL;
 		goto out;
 	}
 
@@ -8695,7 +8691,6 @@ static int ath11k_wmi_p2p_noa_event(struct ath11k_base *ab,
 	if (!ar) {
 		ath11k_warn(ab, "invalid vdev id %d in P2P NoA event\n",
 			    vdev_id);
-		ret = -EINVAL;
 		goto unlock;
 	}
 
@@ -8705,7 +8700,6 @@ static int ath11k_wmi_p2p_noa_event(struct ath11k_base *ab,
 	rcu_read_unlock();
 out:
 	kfree(tb);
-	return 0;
 }
 
 static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
-- 
2.44.0


