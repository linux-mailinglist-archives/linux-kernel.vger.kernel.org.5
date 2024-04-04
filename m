Return-Path: <linux-kernel+bounces-131097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D764E898311
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFD91C2684B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3967A01;
	Thu,  4 Apr 2024 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QUIfpFik"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5767750
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218870; cv=none; b=SFZGy3u/m5p2q4n5qWtK2vSW7HSyRLqGmY/sKkvofXAZLw94Pzdxk1SuYTpMbDCk7eurwQWd7dE12uRBReBtt4s0P4aDYdp1tpqnChiFkkQqPvdX1VMqysqNbJ0QaGw2dST0QoccMT54HmZtxXiQkvEkjz8qYexzM9v+UAitGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218870; c=relaxed/simple;
	bh=ZEtC6p3eqLajMjSFMEfgcznQoOgf/GOK5EvLHiJ18k8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3P+TgbW+LXsE0C1L/G0tkTE7nrxKteNCF7C4zstXwJsBlxEaDk2uAPtsFEbqmGFWmoiIpCSPyxWZ27XwYrM2wJCz6++Px65GAiZ/A57XL62BWvoedcH7lzx/Ab93k39ZTOcAOGubDFgmhBd3BD119l9AW+sv8jHIVOcSl0qBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QUIfpFik; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712218867;
	bh=ZEtC6p3eqLajMjSFMEfgcznQoOgf/GOK5EvLHiJ18k8=;
	h=From:To:Cc:Subject:Date:From;
	b=QUIfpFikDU1gQstK+WVQ7bUPCL1a3RRJEdM0fDR9v0qyLyoXHZt7BI6PXVHUG13Te
	 HQs3XV55VoppCjXHij20Igpnrp4AvSeA/uhyVcBzmBOLhyQvs6zz2MtWkMVNvyaKoO
	 oxmyQwHDldv84KduEQnF9KT1pXbHXflpZb9ZhzTE71uawyCUxnHyu/yjLhVhELDZFy
	 1xur4Om8W3Lo7O5803zxGJt1lCbGX0sVIGJTJhixqBEdq7nNEPCJqybdolHycT8Ko8
	 CaRpm3rSz0sGZcRoAvyV0/ZVT76+udpreaOR1st2JlZBN81OVieERaeibPnMWLgVZI
	 QUI+jvmOV4HVA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B6B2837813A4;
	Thu,  4 Apr 2024 08:21:06 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	wenst@chromium.org,
	kernel@collabora.com
Subject: [PATCH] soc: mediatek: mtk-socinfo: Add entry for MT8395AV/ZA Genio 1200
Date: Thu,  4 Apr 2024 10:20:56 +0200
Message-ID: <20240404082056.93454-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the MT8395 SoC with commercial name Genio 1200.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mtk-socinfo.c
index 4494cca1d075..6943ab29f095 100644
--- a/drivers/soc/mediatek/mtk-socinfo.c
+++ b/drivers/soc/mediatek/mtk-socinfo.c
@@ -56,6 +56,7 @@ static struct socinfo_data socinfo_data_table[] = {
 	MTK_SOCINFO_ENTRY("MT8195", "MT8195GV/EHZA", "Kompanio 1200", 0x81950304, CELL_NOT_USED),
 	MTK_SOCINFO_ENTRY("MT8195", "MT8195TV/EZA", "Kompanio 1380", 0x81950400, CELL_NOT_USED),
 	MTK_SOCINFO_ENTRY("MT8195", "MT8195TV/EHZA", "Kompanio 1380", 0x81950404, CELL_NOT_USED),
+	MTK_SOCINFO_ENTRY("MT8395", "MT8395AV/ZA", "Genio 1200", 0x83950100, CELL_NOT_USED),
 };
 
 static int mtk_socinfo_create_socinfo_node(struct mtk_socinfo *mtk_socinfop)
-- 
2.44.0


