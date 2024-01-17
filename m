Return-Path: <linux-kernel+bounces-29331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8239830CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B60628731F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C894723761;
	Wed, 17 Jan 2024 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="M6/QKBL9"
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E22223750;
	Wed, 17 Jan 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705517255; cv=none; b=s/nICqK9auj6YfzqBXPOU/BZ8REdLg6XdgNQIoGEFseubMfVaFLnn36z5IlsognJ6MGKpxHFQjRoSBcqs0VDWnMoASGF1PoUw8sKbm+sPiGPHzau7BrQ3CDaG3V+NOov5smWhm7zfy8LqiaLTUtwkfgm3li3/Hu5uacSBbOKWJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705517255; c=relaxed/simple;
	bh=gozWPMqk/rhDpsDJOgN1+wlwUjEtXnVyTAYjJMeFUyc=;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mail-ID; b=NPOEdmxgWYeMwgyARgzBHpLJLwjljhL15iyL1aL6ZeOeA742wf0GY7F39Pp6o09PwY/zI5+aITZ07xG5IVbhBbA7WoFh3qi0IDb3UzL7bIWBxsTFfvuliJ9pSrutwFFKOjNGVZArUhMR9xbLWiOOeNjq28h1SFyj9he2FCajWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=M6/QKBL9; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout3.routing.net (Postfix) with ESMTP id 945F8605FE;
	Wed, 17 Jan 2024 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1705516876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eehw8xyDiZKe3Ta/XcMEznmzFYJTK+Bv5i2VMfGjjM0=;
	b=M6/QKBL945SLCiX3SObAD3UVp8V1jXvZ7+OCFilnQu/Zw5KRlyJbuuF8uWUmxQOI2KcyV4
	gVWaOMUugPfb8bPDoXE7+AIz1QMLTXiw09d45jilzZ5SQ91oQTAZ/9NP4JT/yRmB9oIaKA
	eSm6ZRLutKlprpiC/6ZdgqUNQ2ysvyU=
Received: from frank-G5.. (fttx-pool-217.61.151.254.bambit.de [217.61.151.254])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id B06A610022F;
	Wed, 17 Jan 2024 18:41:15 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/2] clk: mediatek: add infracfg reset controller for mt7988
Date: Wed, 17 Jan 2024 19:41:11 +0100
Message-Id: <20240117184111.62371-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117184111.62371-1-linux@fw-web.de>
References: <20240117184111.62371-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 19467ab5-d765-4cf7-a1c2-db41340e92b1

From: Frank Wunderlich <frank-w@public-files.de>

Infracfg can also operate as reset controller, add support for it.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v3:
- start with RST0 (LVTS is in RST1)
- rename reset offset to contain SOC to not collide with constants
  defined in reset.h
---
 drivers/clk/mediatek/clk-mt7988-infracfg.c | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg.c b/drivers/clk/mediatek/clk-mt7988-infracfg.c
index 8011ef278bea..449041f8abbc 100644
--- a/drivers/clk/mediatek/clk-mt7988-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7988-infracfg.c
@@ -14,6 +14,10 @@
 #include "clk-gate.h"
 #include "clk-mux.h"
 #include <dt-bindings/clock/mediatek,mt7988-clk.h>
+#include <dt-bindings/reset/mediatek,mt7988-resets.h>
+
+#define	MT7988_INFRA_RST0_SET_OFFSET	0x70
+#define	MT7988_INFRA_RST1_SET_OFFSET	0x80
 
 static DEFINE_SPINLOCK(mt7988_clk_lock);
 
@@ -249,12 +253,31 @@ static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA3(CLK_INFRA_133M_PCIE_CK_P3, "infra_133m_pcie_ck_p3", "sysaxi_sel", 31),
 };
 
+static u16 infra_rst_ofs[] = {
+	MT7988_INFRA_RST0_SET_OFFSET,
+	MT7988_INFRA_RST1_SET_OFFSET,
+};
+
+static u16 infra_idx_map[] = {
+	[MT7988_INFRA_RST0_PEXTP_MAC_SWRST] = 0 * RST_NR_PER_BANK + 6,
+	[MT7988_INFRA_RST1_THERM_CTRL_SWRST] = 1 * RST_NR_PER_BANK + 9,
+};
+
+static struct mtk_clk_rst_desc infra_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = infra_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(infra_rst_ofs),
+	.rst_idx_map = infra_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(infra_idx_map),
+};
+
 static const struct mtk_clk_desc infra_desc = {
 	.clks = infra_clks,
 	.num_clks = ARRAY_SIZE(infra_clks),
 	.mux_clks = infra_muxes,
 	.num_mux_clks = ARRAY_SIZE(infra_muxes),
 	.clk_lock = &mt7988_clk_lock,
+	.rst_desc = &infra_rst_desc,
 };
 
 static const struct of_device_id of_match_clk_mt7988_infracfg[] = {
-- 
2.34.1


