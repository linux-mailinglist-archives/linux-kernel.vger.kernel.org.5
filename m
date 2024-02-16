Return-Path: <linux-kernel+bounces-68534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988C9857BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3491B281BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D4B78672;
	Fri, 16 Feb 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8nhCM3H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226897765E;
	Fri, 16 Feb 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083475; cv=none; b=swA95ZrsZxKfaUOTY4uwmF7LZS/EzppnLZ/13dp+YozoCtLgSgzPdTBTSG8b3/YLy8o1CtaMwkHFxe4IiTjT0iJBmeO2Wqlp/hyMiElZ1Eago8lS2AqQtpO5lDLvnpBlZXDXRg26dIFq6R3/GEk1qGLrvL03wXkdmnDpvkYqVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083475; c=relaxed/simple;
	bh=Ee3XDJNpfdTjv5LyZOoehAGlyXESSiYI284+s3xfG5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gPujHCea5SJ89ronpHomvAvsW5QBxwyMV/A4CCc2oFj4Ivg0OqSDoZE//+VhWgcs3w/LYHIhs6+Sb4wUxapmPZ1DYWEueKJpP+2lmZJCqHtA6h97gwKWiXU1W1dOvLaN+yMDzZ/S7bYsHViYLKiTQlhcaUoaBE5ExrON1TLWsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8nhCM3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A133DC433C7;
	Fri, 16 Feb 2024 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708083474;
	bh=Ee3XDJNpfdTjv5LyZOoehAGlyXESSiYI284+s3xfG5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R8nhCM3HTWkTUwzHZpCaT/xGQ2lX912f1MteTk+kvEWGykOfWx+LebFpNdUSAJH4i
	 b4KYo8FA3WT1+aDGZirS7OCDlJAq0TC7Z7Qr0Ry7oB+9c6qAWkjEQr7cPLclN/vslk
	 h14LJD81SpzFIdB5wYShtpiqtqH5ImRqS6DiaMRKttO5nYbP6Bd9EGXrzUAW7aXH+q
	 5JC6BTm0pGi2K9LHNlEB/AKJWTsToVzq71r5hEhdT/ty6z1tWNXKGa5KPQivmCG/8R
	 XaZQntGAoDQO/fL2wWAF10veWla5iIR76YSC30iHRVqj9PmdP5kzR5my9WveRBgZjX
	 B8Rj9icpqlP2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85967C48BF3;
	Fri, 16 Feb 2024 11:37:54 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 19:37:51 +0800
Subject: [PATCH RFC 1/4] dt-binding: clock: histb-clock: Add missing common
 clock and Hi3798MV200 specific clock definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-clk-mv200-v1-1-a29ace29e636@outlook.com>
References: <20240216-clk-mv200-v1-0-a29ace29e636@outlook.com>
In-Reply-To: <20240216-clk-mv200-v1-0-a29ace29e636@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708083473; l=1498;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=tAwhkwf2RTqZatW50V1J+QSR6rpA9D5O9tBXY261zlg=;
 b=iDRutFD2DFwCa0WQEGfH2onaWJKNPNlOX1lDKu3ofXpRVSfd0kfpOrwvenhJkrUfKfiFmlAKF
 wMx+9hDBmW0AkPs5SNNdiyYnuGIehYApTQeP1Q95nEqqj4M14RmWty9
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

According to the datasheet, some clocks are missing, add their
definitions first.

Some aliases for hi3798mv200 are also introduced.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 include/dt-bindings/clock/histb-clock.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
index e64e5770ada6..68a53053586a 100644
--- a/include/dt-bindings/clock/histb-clock.h
+++ b/include/dt-bindings/clock/histb-clock.h
@@ -58,6 +58,27 @@
 #define HISTB_USB3_UTMI_CLK1		48
 #define HISTB_USB3_PIPE_CLK1		49
 #define HISTB_USB3_SUSPEND_CLK1		50
+#define HISTB_SDIO1_BIU_CLK		51
+#define HISTB_SDIO1_CIU_CLK		52
+#define HISTB_SDIO1_DRV_CLK		53
+#define HISTB_SDIO1_SAMPLE_CLK		54
+#define HISTB_ETH0_PHY_CLK		55
+#define HISTB_ETH1_PHY_CLK		56
+#define HISTB_WDG0_CLK			57
+#define HISTB_USB2_UTMI0_CLK		HISTB_USB2_UTMI_CLK
+#define HISTB_USB2_UTMI1_CLK		58
+#define HISTB_USB3_REF_CLK		59
+#define HISTB_USB3_GM_CLK		60
+#define HISTB_USB3_GS_CLK		61
+
+/* Hi3798MV200 specific clocks */
+
+// reuse clocks of histb
+#define HI3798MV200_GMAC_CLK		HISTB_ETH0_MAC_CLK
+#define HI3798MV200_GMACIF_CLK		HISTB_ETH0_MACIF_CLK
+#define HI3798MV200_FEMAC_CLK		HISTB_ETH1_MAC_CLK
+#define HI3798MV200_FEMACIF_CLK		HISTB_ETH1_MACIF_CLK
+#define HI3798MV200_FEPHY_CLK		HISTB_ETH1_PHY_CLK
 
 /* clocks provided by mcu CRG */
 #define HISTB_MCE_CLK			1

-- 
2.43.0


