Return-Path: <linux-kernel+bounces-88151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C0586DDEC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597591F247BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDC16A8B8;
	Fri,  1 Mar 2024 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lzSP4O1m";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="oXtxSOiJ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DD56A8B2;
	Fri,  1 Mar 2024 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284476; cv=none; b=cJTjpmCnFkVQAHANnwkolI99q21lUtNYPMd3Mpxe5U2xilj0Cv3tNxCSVfyPmfEe+PnqK5LvIxIOaP/P7jE5dFUAd/6v4uPfOn1bbwOVH4UMX5r88ZsNKwGWYW8/noiMdZ8iG2H8cRzx7eIOt4KkxN9ope49sjYqiE2tG4ZqldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284476; c=relaxed/simple;
	bh=FrwHZ9w9xTTtYLHM0eJYuip9mto9w9P9KtfcdJQDA8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JWcPsHc/Dm5AdlonCPoCN9JwJPmLQLeJAjbpF5kteD2/fsC/QrF3NkX+1yWw7t+y0O9/JiQOi2DggKCVXHgzBcKy85LaKcnrgM2pkOxh0KzLRzl2JJnV+EEF153DiN8DKm5R4Vn+fB45Akn8jXXKC3TOrAnYw5UrOui9e3M9kT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lzSP4O1m; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=oXtxSOiJ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709284474; x=1740820474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cE70ciaNhFvA6Vb21y4hOf+k8Cex8gPGVr4Ivb9Yb0w=;
  b=lzSP4O1ms1mwiLmTx8dYsAuMP3fkmEeRkv4iaN2BuhKQKhywJ9U479Cz
   +WTRiuHgloI7oqpWWcA5PIY/36PYfL8HMn2yf0PgaGSg7CTioOjMl2gqc
   vz8ZwYY0y8R7y9tqE+dVxdHve2lEG3SslPHYKYzsy/jrsJbq5fgMOLZAq
   m3h2vKnRKl7ixsVDhSkLyXwpCuaAbdawYNVszrjH11Ng2r3Txxm9AHAmM
   yHRqX7ugljbBKuxm+cHn/UO4ywbJ+R8hivTJIwEzwT/jL3EW3eJkubzX0
   ECS/qRuEBCCWATPHPM1k/nNY0dujj4RrgOcccoXKN2Nt5E/WqFbrg3zYF
   A==;
X-IronPort-AV: E=Sophos;i="6.06,195,1705359600"; 
   d="scan'208";a="35682438"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Mar 2024 10:14:31 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6AAD717351F;
	Fri,  1 Mar 2024 10:14:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1709284467; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=cE70ciaNhFvA6Vb21y4hOf+k8Cex8gPGVr4Ivb9Yb0w=;
	b=oXtxSOiJoNpjQf//aROsg9t0Ti1Qr5QnpjiDkY2keH2SNMqvQVdA22VXKscdLZ3czIoYVe
	9q0FxYIIWkbuUBmofcXu2S2AqT969dPUHtFyagRoIf7Gjah8yhKW9qjVsM1VoD6v40+FJn
	DWzbcsgZjqw4qXYttvpcSHR5hgNyQAlvy65E4iuj3pWpQe+lf+ert65fygW4dWNa1lTNv/
	WYcK/1mMUSk68+s/JqX3oMVqGDsDN/20CaQiJojETV9tJi4qI8N+gGpmhV+tcIU1qohEwo
	hZuvSQGfG477763yM/Z1uxIgNtcLFiyqCnwxrEanNX3ZkW47Op7EtxDhWMOMXA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: [PATCH 2/5] arm64: dts: imx8mn: Add empty DSI output endpoint
Date: Fri,  1 Mar 2024 10:14:10 +0100
Message-Id: <20240301091413.3050689-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301091413.3050689-1-alexander.stein@ew.tq-group.com>
References: <20240301091413.3050689-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Also add a corresponding label so overlays can reference that node.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 619cedd8407c4..81ba70d7880b5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1104,6 +1104,13 @@ dsim_from_lcdif: endpoint {
 							remote-endpoint = <&lcdif_to_dsim>;
 						};
 					};
+
+					port@1 {
+						reg = <1>;
+
+						mipi_dsi_out: endpoint {
+						};
+					};
 				};
 			};
 
-- 
2.34.1


