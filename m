Return-Path: <linux-kernel+bounces-24508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A50382BD9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95451F2604C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E38957309;
	Fri, 12 Jan 2024 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tUBRlSgd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B557301;
	Fri, 12 Jan 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705052807;
	bh=A/hew+ECsb7JQ+PjQNHeZlTkpaBAsK7nTKJy6ngYdtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tUBRlSgdePqmZVTbVSZIknDo47NeVJQVISZ74IJR7cPoo2g7QYn87wxsMr5/dyq+k
	 7zkZ2sWwm18VEH23wPsVpWTLmUPTk1Vyas9lzzyy53v8dPXd0Pgi2FTZKNXcdrLbSj
	 pEaSWPpotNfjYcOmTHvZXh4TXUwpgcDbTfxgVLucyLUgs1R/4SuKRLmJw94/ogfrnC
	 5uHncEdbleY3fo3Jr1vuLvJ+DTJ16Z1UcxXDBFWCH/HOkIuEdjkUK/5x/LjBS6sbhf
	 KfazfqoJkPdN9oLsMdo97bUVK+OZMFggFijsamLD3JQh0FUvZyxATHtn+stTeGPMJ5
	 qAoRnPXTepPzg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DC63B3782035;
	Fri, 12 Jan 2024 09:46:46 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	nfraprado@collabora.com,
	macpaul.lin@mediatek.com,
	sean.wang@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 09/15] arm64: dts: mediatek: radxa-nio-12l: Enable System Companion Processor
Date: Fri, 12 Jan 2024 10:46:26 +0100
Message-ID: <20240112094632.66310-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112094632.66310-1-angelogioacchino.delregno@collabora.com>
References: <20240112094632.66310-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SCP is used by the SoC for various tasks, including initializing
hardware video encoding/decoding hardware and managing other remote
processors. Enable this node and assign its own DMA pool to it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 8492cf52413f..5a9e33013209 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -587,6 +587,11 @@ &pmic {
 	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&scp {
+	memory-region = <&scp_mem>;
+	status = "okay";
+};
+
 &spmi {
 	#address-cells = <2>;
 	#size-cells = <0>;
-- 
2.43.0


