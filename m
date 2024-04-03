Return-Path: <linux-kernel+bounces-128984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823E68962B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A901C236C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F5D1BC37;
	Wed,  3 Apr 2024 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Pj5hFXWc"
Received: from out203-205-251-73.mail.qq.com (out203-205-251-73.mail.qq.com [203.205.251.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B6729CA;
	Wed,  3 Apr 2024 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712112852; cv=none; b=lR1N8K2P/XbcQ7fW4y6agbst2pCuTeMjTvtTzHv7yDbVF7QTcCbYr3mZwwyPnwxnhdoJyvs3wROrgiI7DHbEMHISQ8neqQeRDvml8QMG9G3NWCzVwy+wTk1Q2CEBRdA5xW1eMr/CYruo0hB9vYw0wmxPtm6iox8WnzNF2L2ThE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712112852; c=relaxed/simple;
	bh=WO0yhmP7aDuL5Ijpdwik2fkUvfL8+DARWRnEAoOzdME=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=gBgGjOpd/mt4Vn8mevJ4eX8na6bDlUtGWYo3SCdzzDNSIby2xjwsTLSW0kUjyZeSAoAaSKPxD2YgUyAmYmVNiLZ7fRWQSRNmVdFj3bu/OMoNPSRYmq9Pden8/6Rjs0fnWFWAWY0ve4/bsjYTtgly3Kcbhb0mDyzd3I4UIo6kWZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Pj5hFXWc; arc=none smtp.client-ip=203.205.251.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712112847; bh=EErZkKra0XeGY2iNAPwkwZ4Bk62p3Qrgv9IdIa4U0lw=;
	h=From:To:Cc:Subject:Date;
	b=Pj5hFXWcrhBr7pY0uqmtvTDFnrXEeunlv8SiD3gR/qKBHchPAi7V65AZgbFEKDaBG
	 dqN4UgPfZW/2srTR1ycebQMbCFd8eR7HgXwiSC+/quMpFBhqvcgcnVs0IgnzuE+TlB
	 skjstmDVda9G+TRxcF9dEtmhW3DnL588Huh771y8=
Received: from localhost.localdomain ([153.3.164.50])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id D8284E80; Wed, 03 Apr 2024 10:54:02 +0800
X-QQ-mid: xmsmtpt1712112842t6y8mxulq
Message-ID: <tencent_C699E9540505523424F11A9BD3D21B86840A@qq.com>
X-QQ-XMAILINFO: Nh9rHd4LJNLEhO7Ar0Vx/lAaGZ5gmlRV1igCRrU3qWmsPOw8HzyPxWvQm5b/dw
	 P6hBrtj1rz5fmjJZM2CE62Dq18cKqTlBQB0Zk+y6fqD4eyOky5kxzIKZY/TdAKxA6QNe/EJB8yBI
	 Do1qCPApRxc8PKCJYOjL8Av0aL/ewrmnSZQ8jXQ8GXxMpVBgsHQUVEUvg5CZwnlJy4HxROPHTZvg
	 tjqnubt1d1BGKhkaY/qUVfDLFJrW91n2gQwLKaNc9CrHGpsfZOu7PnuHIQcmd5guB6JofiM8b8RH
	 kAEyo9gwcdTK5eAk/H9YOQUfaCDCwD4COfloLyA2hwIesJ16Q7fYYtVO1zN4Izjx0Ir12bBm2G8U
	 eRqxEwPGTMV7a12T6hgdeJ2yIW4B1Ae5FXr1UJ6VdbD97khPL3jcSvOIT7BTdtCCg3WrGPJBCSDG
	 lVDl/SrYvdCg+BBWBL3oC4FsX6WdkhwMeZWlydxKCU3qD7+fsA3UvqqoVLesyDiIF1ny2FVXC90A
	 lfI+447EDglZiIgG/som2YOAX3AhzEc+TBlT1HL6swSkXc5DPOosopbeWap+HdIffcLzmme06o/9
	 XrmjVjX6OpLofK98KWm/xNjRcvbjcGbygYW0y5/xpV3VOVG+nXslpQ+T6jFR/cNv6ebcx4qclRNM
	 Uhoz99luMbBAtfFWfIDYr9N4gdyGk9+Fcp4+Kj0tucXFkv1ZE9xD/qZY2laqPC72AF/APbMGrPin
	 9MQEa2jtTiPORwIDOGbaFcV7nzwmAm/DZozx+Yg6+e7N7u+/V7aBf/nUM1lAovht10ttXwEBlnAh
	 kPBf/tHPt4XB+aoUX2EoSiRfI831erzxlHMnJfw0iSCbToVGVqhFJn0/8MK1jGkOLAY1QsA7G5Gp
	 lm3PeyF+3M/lfSOfWkHZ6NmlJWMmSE8M6UC4Vwt5mO27Q1DtCqlE/IdDz3O2r2Tpcl488apB4S89
	 7G61EJYfuREPGs/E1gU66TdZrxEsEBWH4H8dS5pbnQHYbSZj836tahAs8bYCqLJTxT07hE64xS1N
	 Ah/+ei0CZ4/Krsrs/p
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: linke li <lilinke99@qq.com>
To: 
Cc: xujianhao01@gmail.com,
	linke li <lilinke99@qq.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] net: ethernet: mtk_eth_soc: Reuse value using READ_ONCE instead of re-rereading it
Date: Wed,  3 Apr 2024 10:54:00 +0800
X-OQ-MSGID: <20240403025400.48088-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mtk_flow_entry_update_l2, the hwe->ib1 is read using READ_ONCE at the
beginning of the function, checked, and then re-read from hwe->ib1,
may void all guarantees of the checks. Reuse the value that was read by
READ_ONCE to ensure the consistency of the ib1 throughout the function.

Signed-off-by: linke li <lilinke99@qq.com>
---
 drivers/net/ethernet/mediatek/mtk_ppe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index b2a5d9c3733d..8b3cdfc4d407 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -580,7 +580,7 @@ mtk_flow_entry_update_l2(struct mtk_ppe *ppe, struct mtk_flow_entry *entry)
 
 		idle = cur_idle;
 		entry->data.ib1 &= ~ib1_ts_mask;
-		entry->data.ib1 |= hwe->ib1 & ib1_ts_mask;
+		entry->data.ib1 |= ib1 & ib1_ts_mask;
 	}
 }
 
-- 
2.39.3 (Apple Git-146)


