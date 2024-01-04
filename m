Return-Path: <linux-kernel+bounces-17053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999BD8247AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31AA5B21E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29116288D7;
	Thu,  4 Jan 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="HJKUGDYh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F871286BB;
	Thu,  4 Jan 2024 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout2.routing.net (Postfix) with ESMTP id 97F7B5FF8F;
	Thu,  4 Jan 2024 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1704389986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u31vqb832iBo503aU0D4rkKh2sGRkH9JUeHiMN+G1mE=;
	b=HJKUGDYhE03OgtP34sIwOijceDMSih37DZxiGdTGjoRC6DSEuYCZJZalZv/0hv2/AF2UdM
	PJpPtswhQMBQwdshvoWrOxUHwgznbLGVSQCnA/bfkR9LPlrQjRjD7sgOSnZbAnVyhptJAa
	F26E5mR9V7cLPGIYmpgXC2RB3I/hQbc=
Received: from frank-G5.. (fttx-pool-157.180.226.237.bambit.de [157.180.226.237])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id BF7BB100738;
	Thu,  4 Jan 2024 17:39:45 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: linux-mediatek@lists.infradead.org
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: reset: mediatek: add MT7988 LVTS reset ID
Date: Thu,  4 Jan 2024 18:39:29 +0100
Message-Id: <20240104173930.13907-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104173930.13907-1-linux@fw-web.de>
References: <20240104173930.13907-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: d6c2a594-df4e-40d7-80ec-fbc130c01098

From: Frank Wunderlich <frank-w@public-files.de>

---
 include/dt-bindings/reset/mediatek,mt7988-resets.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
index 493301971367..3f1e4ec07ad5 100644
--- a/include/dt-bindings/reset/mediatek,mt7988-resets.h
+++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
@@ -10,4 +10,8 @@
 /* ETHWARP resets */
 #define MT7988_ETHWARP_RST_SWITCH		0
 
+/* INFRA resets */
+#define MT7988_INFRA_RST0_THERM_CTRL_SWRST	9
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT7988 */
+
-- 
2.34.1


