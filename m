Return-Path: <linux-kernel+bounces-136802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3C489D851
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4ED28BD48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87D612E1DB;
	Tue,  9 Apr 2024 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="r+nxKpPe"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735912BF2D;
	Tue,  9 Apr 2024 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662953; cv=none; b=QZ39bTz+Bpr4AYv708RYW6LQzVG9AzHvWaOotnr78ASS8opN+OYhaXULgjU27N1pwphodqH+7Qy0d+QO7WsSAGZtJ45/5UCzEZxboCghouOTkkdUBmjWr7wl0uy/UyS/WYLtB5BL0ghKgeiZR8bgxwzsRYaT/xzoT3bqQ1pUX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662953; c=relaxed/simple;
	bh=1IKHkg+bFOK+XIFwPPhCXS2tjDgeASO3rycSgHf2rZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlqsDbvYuBLwGfS/DOTTgXqaLNqMQiolQ6iCyjkJSivryVFFA+t0cO58qNgfjM2dHfbArr83sdWtf6+Dwguv9aRw9i6BX8fDyFPCM4GT5gVkqBREleM9ODOpgGzj7BAZGgq88hMLp6uWJUwu6f3/4v9uBSUb8Q9bbOxaTTW1NQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=r+nxKpPe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712662950;
	bh=1IKHkg+bFOK+XIFwPPhCXS2tjDgeASO3rycSgHf2rZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r+nxKpPevPYF5KeaMrPZbMUBWhwIroSMLfrTCJAyZ2z7biBlV7Itac+bNYWXqg9AX
	 x9wnbrJnbg1v/wRm9okRoXB/1y97SMuMIOJk/BzdVYBTIMDJACi2M91C3+Db5aN46G
	 w82qJMCOha7zlg+40XhKJIEJ/P/nYP9AeR4jWR7qkPYMxOSupgAQlx28Y4P19FbU5p
	 5c9e7DVeJsBlD05j1N39auPKoot74PRZjF5/qGT5m4cANizhQH+lkaYXaJ3keqv8pn
	 wJXxnr/dggeGXAdfslqaJxkLvB51wpJdFO1p0r28+YVn3m1Lo5WWZyMnq9E+ox/J8y
	 cmG4JeFVEh+5Q==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5D3133782127;
	Tue,  9 Apr 2024 11:42:29 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 5/5] arm64: dts: mediatek: mt8395-nio-12l: Add power supplies for CPU/GPU scaling
Date: Tue,  9 Apr 2024 13:42:11 +0200
Message-ID: <20240409114211.310462-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409114211.310462-1-angelogioacchino.delregno@collabora.com>
References: <20240409114211.310462-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the necessary power supplies to safely enable CPU and GPU frequency
scaling.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8395-radxa-nio-12l.dts     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 5cbe969da425..bf6b539e6c06 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -140,6 +140,38 @@ apu_mem: memory@62000000 {
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&mt6359_vcore_buck_reg>;
+};
+
+&cpu1 {
+	cpu-supply = <&mt6359_vcore_buck_reg>;
+};
+
+&cpu2 {
+	cpu-supply = <&mt6359_vcore_buck_reg>;
+};
+
+&cpu3 {
+	cpu-supply = <&mt6359_vcore_buck_reg>;
+};
+
+&cpu4 {
+	cpu-supply = <&mt6315_6_vbuck1>;
+};
+
+&cpu5 {
+	cpu-supply = <&mt6315_6_vbuck1>;
+};
+
+&cpu6 {
+	cpu-supply = <&mt6315_6_vbuck1>;
+};
+
+&cpu7 {
+	cpu-supply = <&mt6315_6_vbuck1>;
+};
+
 &eth {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&rgmii_phy>;
@@ -343,6 +375,14 @@ typec_con_mux: endpoint {
 	};
 };
 
+&mfg0 {
+	domain-supply = <&mt6315_7_vbuck1>;
+};
+
+&mfg1 {
+	domain-supply = <&mt6359_vsram_others_ldo_reg>;
+};
+
 /* MMC0 Controller: eMMC (HS400). Power lines are shared with UFS! */
 &mmc0 {
 	pinctrl-names = "default", "state_uhs";
-- 
2.44.0


