Return-Path: <linux-kernel+bounces-24498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B28182BD83
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8236F1C253A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B8A57874;
	Fri, 12 Jan 2024 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ie5C2kIt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0042057;
	Fri, 12 Jan 2024 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705052744;
	bh=kBy0xyGHqh5AeAuImQCMQR9+EKgyLvr9VzSgQV6Ok8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ie5C2kIt8oI4QqfJrr7QGgQRxd/AYoR9Ackq+/ffMp31ZqIPvOGKByOEBVFHMWTN7
	 YeLz1AfbfgO83r/fBBKF9iFbbYucx20hg3Skm7Ourt/zS/tbSBIwji7gKyoayRqSb4
	 G/M0oafeRDg+FYCIOTMdkg9O6RScQnz5h0HvOqHVih3DucDHD2L0DYWL2bDjHpmoeT
	 TB3VAmyR4cS9MwwyOUZZ8qpctQZOtXEaAMu55nziHl2r2CrkHvshS8JBzDtK0kRStF
	 crGnhanSItDoyIDnRHK0Sy0q3F1TbteGzROylsGXgWm45DZLgsMakNmgtGCP5RkDtC
	 zKu5LkHdMdAEA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8B4683782021;
	Fri, 12 Jan 2024 09:45:43 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 2/2] usb: typec: tcpci_mt6360: Rename interrupt PD_IRQB to PD-IRQB
Date: Fri, 12 Jan 2024 10:45:38 +0100
Message-ID: <20240112094538.65639-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112094538.65639-1-angelogioacchino.delregno@collabora.com>
References: <20240112094538.65639-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the sake of avoiding underscores in devicetrees, rename PD_IRQB
to PD-IRQB.

Since at the moment there is no user of this driver (yet!), it is not
necessary to retain backwards compatibility.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/usb/typec/tcpm/tcpci_mt6360.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
index 02b7fd302265..745463283323 100644
--- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
+++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
@@ -153,7 +153,7 @@ static int mt6360_tcpc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	mti->irq = platform_get_irq_byname(pdev, "PD_IRQB");
+	mti->irq = platform_get_irq_byname(pdev, "PD-IRQB");
 	if (mti->irq < 0)
 		return mti->irq;
 
-- 
2.43.0


