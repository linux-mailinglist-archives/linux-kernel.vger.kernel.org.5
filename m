Return-Path: <linux-kernel+bounces-27820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3082F65E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574951C23B30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227622E83F;
	Tue, 16 Jan 2024 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibH4wbVD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4322E83C;
	Tue, 16 Jan 2024 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434280; cv=none; b=S799PL2hDDTgVe1IDFr6J44dffsVhm4o1kWm8VXEfV3rvgwa9+jM8t/2wPefFXtaCZ2GGUjmZhr5Nk7bS7Sltibk+jp9Sl3xaeTh1YZGCfk6moVEussQXVuN6nK2dfmw+NwQMbVKOUB9BhT2Itxd7XdhT45a8TsOQtrBih83cKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434280; c=relaxed/simple;
	bh=xbDbzMEtgVcUrOQCXkaSw4wRsKzePZtQjF/09aWkAeA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=CkYUFMZGF/hdzJI5pKisTkuxBFfPhVociJZttLGS101LLtsgorAPyZ/t6SgO7X/oQbu12sZVmsPlJxJOB2d2ByM6dXYQlKifbMsCDACGT6rHjcD3MiXmp8WvI72HLSqibUx28TdF1eAd9LYyl48hpLwxG2Bmqoju6pCCeW9oYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibH4wbVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8B5C433C7;
	Tue, 16 Jan 2024 19:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434280;
	bh=xbDbzMEtgVcUrOQCXkaSw4wRsKzePZtQjF/09aWkAeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibH4wbVDI62oJIDwqokJqAZ5zJJUQQ5aRhUZqW2GpGQSifIb2XZBcsMFFkDnghyBR
	 4xSanzU5LSeD4RZltpNHqevTk7TyG5G8LLyJT0cZz5Q4b3dvT2D/6xhoIM1ro5jFD8
	 0GeixOPAHk9et67Sm5NkNMHMH2dKrOhIh99b7OHUYM+vXuukmhOZCVAT5Yls3ky2d8
	 IYoXn4ybGIG24f6dS+zzeSMxAWVa4GRu65aGJ0wGU3DAlJSPXs/Mx+oG/KxBJx3STC
	 fF4J18st49642p2XkHQOtgHE86C5ZK7Fh+9B/E0FW5NeDARw7XPADL9p9ZdVPgFakQ
	 DUWypLAtjP55Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	sujuan.chen@mediatek.com,
	chui-hao.chiu@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 049/108] wifi: mt76: mt7996: add PCI IDs for mt7992
Date: Tue, 16 Jan 2024 14:39:15 -0500
Message-ID: <20240116194225.250921-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

[ Upstream commit 3d3f117a259a65353bf2714a18e25731b3ca5770 ]

Add PCI device IDs to enable mt7992 chipsets support.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index c5301050ff8b..67c015896243 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -17,11 +17,13 @@ static u32 hif_idx;
 
 static const struct pci_device_id mt7996_pci_device_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7990) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7992) },
 	{ },
 };
 
 static const struct pci_device_id mt7996_hif_device_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7991) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x799a) },
 	{ },
 };
 
@@ -60,7 +62,9 @@ static void mt7996_put_hif2(struct mt7996_hif *hif)
 static struct mt7996_hif *mt7996_pci_init_hif2(struct pci_dev *pdev)
 {
 	hif_idx++;
-	if (!pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x7991, NULL))
+
+	if (!pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x7991, NULL) &&
+	    !pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x799a, NULL))
 		return NULL;
 
 	writel(hif_idx | MT_PCIE_RECOG_ID_SEM,
@@ -113,7 +117,7 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 
 	mt76_pci_disable_aspm(pdev);
 
-	if (id->device == 0x7991)
+	if (id->device == 0x7991 || id->device == 0x799a)
 		return mt7996_pci_hif2_probe(pdev);
 
 	dev = mt7996_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0],
-- 
2.43.0


