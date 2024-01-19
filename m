Return-Path: <linux-kernel+bounces-30961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4698326DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C71CB23E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD713CF40;
	Fri, 19 Jan 2024 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qaf1uNM7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522463C486;
	Fri, 19 Jan 2024 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657275; cv=none; b=fmTjodymeSM66Nr3h7jYUj1Cy7L1wl9qe9mfm2sQx6ljvMBpnx5pZx+JiUkhCWdfB0t+AKmY8/B4XAEMk6nd6BtLEANKg3q5wCM5+b413J/bHUz9VPs/+CJ5Ptn2hdMoutFs5QsoMal0B6kefgFQ6s4jsACDcpUoZrWmfZRhL5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657275; c=relaxed/simple;
	bh=h9uUY0ElHE1xPzVp2yObyryTAaJ1/QLLOx9ZjW31TdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4Azm1SBUuQG2H6TUZ8ixuqMb2PLHGLEiCbok5C6HK8beO09YKR+NjKqKR0y1VWIS5xFAuoBLWFrXzb1wllzSKXN0ZJ+rR7sTwjDqS3ToPp2owdmWpHZkwVSBbjOp2Paa/1dy9bVkV0yS+nyntPwiC60swuNjCm58VKDPHdUBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qaf1uNM7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705657272;
	bh=h9uUY0ElHE1xPzVp2yObyryTAaJ1/QLLOx9ZjW31TdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qaf1uNM7ZnUmYSVUcKvWGgF5F05PjhQqk0WXXNVvw9pKdbaakpS2bQvUvQunYRpyL
	 P6/KX//n8V+IzCWiQvySCN0f5ivQKCwwr7jIRqt97C/bDA5607BJ7X2pSFrs/K1Spr
	 +b5pXsObiYIei8G+U0kSqucmSi6cJMLK/1q/5LEp8jNhMdBF3IHQW4SPEzN9Xcn41F
	 FUxc3mWSFkQq6Q80+TyhRrwkwZVbDQcuMD6CmsO1Z9pDMfeuMJ51xkKrCkGsgHvdmr
	 iztszn5SOuYz3f5PwEsFmnWzdMGML5IuUFc+lWZYsHQ3gtNTX3jOS9iY4xcFxnTAzy
	 45X0Nd+OykChg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B54243782081;
	Fri, 19 Jan 2024 09:41:11 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunfeng.yun@mediatek.com
Cc: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux@roeck-us.net,
	heikki.krogerus@linux.intel.com,
	cy_huang@richtek.com,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] usb: typec: tcpci_mt6360: Retrieve interrupt by index
Date: Fri, 19 Jan 2024 10:41:05 +0100
Message-ID: <20240119094105.98312-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
References: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This IP has only one interrupt and names are not needed in this case:
change to use platform_get_irq() instead, dropping the PD_IRQB name.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/usb/typec/tcpm/tcpci_mt6360.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
index 02b7fd302265..171592ae1bbe 100644
--- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
+++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
@@ -153,7 +153,7 @@ static int mt6360_tcpc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	mti->irq = platform_get_irq_byname(pdev, "PD_IRQB");
+	mti->irq = platform_get_irq(pdev, 0);
 	if (mti->irq < 0)
 		return mti->irq;
 
-- 
2.43.0


