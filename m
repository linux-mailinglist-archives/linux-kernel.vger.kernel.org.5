Return-Path: <linux-kernel+bounces-128540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2778A895C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E061F23A03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEA415DBD8;
	Tue,  2 Apr 2024 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mwQdviqu"
Received: from msa.smtpout.orange.fr (msa-209.smtpout.orange.fr [193.252.23.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3015B557;
	Tue,  2 Apr 2024 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084708; cv=none; b=QRxf3nng5yS0TRviyfWbae9EeJRYKBabDG7TWzKXvfluYxb0N8SSL/CH70SDzePRPBG6gqSBo0Dnk/mTplHe2TSXtz8PfTqGQiZa4YR5pLOpBykxbZkbupFMRtAejq5J/Vr2icrcKWIxjWMD6/Zc9atZwSetJIINEF/W5fJjvFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084708; c=relaxed/simple;
	bh=kwS3OFemD+CoFC/VCnAgVw9Q22mZZPnHTqgKqaV9KE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEACIoI4+fTRmN9VMYHM2cGNjUU7j3ZnY5uzSTa9qAPH9PwYF8d5V5Udkm82J3+s9LAGVibg6Lq0XVAxOzLzgTR7jErPdKFA9SuS6qIKKQSWazzMb6e7b8qtDSrEr/FLTcoJKND5YtPhj/LCZMxgMBPRUrdiAgdUx906IgORg/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mwQdviqu; arc=none smtp.client-ip=193.252.23.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id rjIXreq63bxcHrjIYrcKYp; Tue, 02 Apr 2024 20:55:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1712084155;
	bh=l5BYZcX/ubDaEhlB2OsDSUhwIwWkP6ApQYe4UEhGpww=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mwQdviqu1SnMvOpCqr3ecoBAcjiyL3n3k9etd9llmy458xo9wrCbllEbtE4Bq7KGv
	 sYnxteRKq2nV63ihrRR0xGT/HfYrFFF/tRdNqN5pjg3ZObsnlppGZObbapQ/o0TBvw
	 Td5woGwM+mJi3rSLDJPZeWJy624kZsvciSrZLEuZST3vejkyKI8fG4vehFXnpsCRRq
	 zTlwICc4cfaK4JeUaCJ4aOYpUpzRaokzrEi5GH2WXaeUc9yoj8658UwZgXJvHjqGQR
	 jEjhqxW5v/OTx1kYgR2KUhaUGPjucd0xKA2dRx8bzBYMwWPibhEprFUhbU9JY0dBIp
	 0LZFeqW8Cwhlw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 02 Apr 2024 20:55:55 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: fman: Remove some unused fields in some structure
Date: Tue,  2 Apr 2024 20:55:50 +0200
Message-ID: <425222d4f6c584e8316ccb7b2ef415a85c96e455.1712084103.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct muram_info", the 'size' field is unused.
In "struct memac_cfg", the 'fixed_link' field is unused.

Remove them.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

For fman_memac.c, I think that it is a left-over from commit 5d93cfcf7360
("net: dpaa: Convert to phylink").
Maybe, #include <linux/phy_fixed.h> can be removed too, but it is not the
purpose of this patch.
---
 drivers/net/ethernet/freescale/fman/fman_memac.c | 1 -
 drivers/net/ethernet/freescale/fman/fman_muram.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 758535adc9ff..92b8f4ab26f1 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -267,7 +267,6 @@ struct memac_cfg {
 	bool reset_on_init;
 	bool pause_ignore;
 	bool promiscuous_mode_enable;
-	struct fixed_phy_status *fixed_link;
 	u16 max_frame_length;
 	u16 pause_quanta;
 	u32 tx_ipg_length;
diff --git a/drivers/net/ethernet/freescale/fman/fman_muram.c b/drivers/net/ethernet/freescale/fman/fman_muram.c
index f557d68e5b76..1ed245a2ee01 100644
--- a/drivers/net/ethernet/freescale/fman/fman_muram.c
+++ b/drivers/net/ethernet/freescale/fman/fman_muram.c
@@ -12,7 +12,6 @@
 struct muram_info {
 	struct gen_pool *pool;
 	void __iomem *vbase;
-	size_t size;
 	phys_addr_t pbase;
 };
 
-- 
2.44.0


