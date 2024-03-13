Return-Path: <linux-kernel+bounces-101686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAFF87AA84
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3551F22FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6051047A55;
	Wed, 13 Mar 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="IU1f/G9R"
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD546441;
	Wed, 13 Mar 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344169; cv=none; b=o9fHmB1k8uu96f6Bn31DZ8Zv6gO9nDzlCzVRkZYt9ZPXXkaQ/2OTiIEfnygqroOZyfDbr6AWO0vIuAtA2pN1todpCgGcOkv9+78JWT1Ott+mOSYH2tOb3EIQ8gFRxTed7N8n8eG7+OzqwwDqduT8K449+iyo4oEtCoIVs4fRd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344169; c=relaxed/simple;
	bh=O7uOKiFVPAmuNg68j9at/KETUNZl0bI/kM2wWFUizh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ofcet0SfAQgZ92wBKK5ElPf0KVgpPZRdznlD5wPlWGKZ339QeWr4mhdq8BP5cVSeogzKaImrTMKSl4i+ze8a7SlGoIVddD026y1yS6Oc68wpseKFRQhV3MpWp5U5Hc7itNC9np5V5o93klKlZ/s/zWj3EsU40FK+rxGup5EMoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=IU1f/G9R; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 59DD3DFBBDDDA;
	Wed, 13 Mar 2024 18:35:53 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zvWePlngsIes; Wed, 13 Mar 2024 18:35:53 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 1E113DFBBDDD8;
	Wed, 13 Mar 2024 18:35:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 1E113DFBBDDD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1710344153;
	bh=Zn7e/vbnoFOlSvvvgW+KMY6UzRzOSfRxr3SxgN8pnw8=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=IU1f/G9RZN2S7tK1x8h2PbJgYIgunLztFCGVz3xYlPjo5EsMOz8WGDueB6FtjShra
	 pVJ9O3TdAfeTwri4DZAfvuIwykJr+U5VfSo3bcO0ig9WCGG3ZjK7+m/KQRvA5ggIMZ
	 dH2peLUAu3ij3EdFA6fwNjSFufoGhQN8ZS3W6TIDYf6XOMYQdgoM5lhq3B7xIQWnwn
	 yRT2qFTeTU+LF7ViTQWVL9Ib3Ogs60GMM80DlbvZB5qZJ5JunHrOQ8t5vU/uXzbSp7
	 YYru0aittpo6zRw+HLEyJBm0jvW3k0m17fNIgE6HdWErafvrwGSrLdg19EqQakxo2n
	 qHXNL8oG2NwVg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iMZCX_rECthx; Wed, 13 Mar 2024 18:35:53 +0300 (MSK)
Received: from localhost.localdomain (unknown [62.217.186.174])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id D8557DFBBDDD7;
	Wed, 13 Mar 2024 18:35:52 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: Raju Rangoju <rajur@chelsio.com>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org (open list:CXGB4 ETHERNET DRIVER (CXGB4)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] cxgb4: unnecessary check for 0 in the free_sge_txq_uld() function
Date: Wed, 13 Mar 2024 11:34:36 -0400
Message-ID: <20240313153437.124749-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The free_sge_txq_old() function has an unnecessary txq check of 0.
This check is not necessary, since the txq pointer is initialized by the
uldtxq[i] address from the operation &txq_info->uldtxq[i], which ensures
that txq is not equal to 0.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ab677ff4ad15 ("cxgb4: Allocate Tx queues dynamically")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c b/drivers/net=
/ethernet/chelsio/cxgb4/cxgb4_uld.c
index 17faac715882..5c13bcb4550d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c
@@ -406,7 +406,7 @@ free_sge_txq_uld(struct adapter *adap, struct sge_uld=
_txq_info *txq_info)
 	for (i =3D 0; i < nq; i++) {
 		struct sge_uld_txq *txq =3D &txq_info->uldtxq[i];
=20
-		if (txq && txq->q.desc) {
+		if (txq->q.desc) {
 			tasklet_kill(&txq->qresume_tsk);
 			t4_ofld_eq_free(adap, adap->mbox, adap->pf, 0,
 					txq->q.cntxt_id);
--=20
2.43.0


