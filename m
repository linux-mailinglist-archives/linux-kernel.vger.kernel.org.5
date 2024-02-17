Return-Path: <linux-kernel+bounces-69845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802D5858F6E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A261F22C47
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49DD7AE73;
	Sat, 17 Feb 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxdbM24u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14E6A025;
	Sat, 17 Feb 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708174337; cv=none; b=fF55UPsOVTEZdlDSB2kUPPQFsS+filkrPXsR5abT/lRT9h9Tzf40dOy0jEypn6oMWpeqEPkXHX+3QgMnUcQmfNkZzMIlsEcCSUAuEFFkhOezzRMiYjB5aL+AEVkGh+jpyirWR0+tHZc6N0DHrzKwwAlifrS0R/nv/41tdY4P6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708174337; c=relaxed/simple;
	bh=Ee3XDJNpfdTjv5LyZOoehAGlyXESSiYI284+s3xfG5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYWi5KxDRSePPkE42bJL4rA64oU5RhGGU894nL1of2pBbA5o/B6d4GpYsO/4BK6uZwRaUpCYKrx/rltoGT8dAh0Njl3jkh9HHkMI2NhKmLElFu5o8EXBx15We+1ZvrtP2AH0HqH5BwFy6K5fmKtckRYqkHRQPUWZDrxGuwlxnjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxdbM24u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94FB2C433C7;
	Sat, 17 Feb 2024 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708174336;
	bh=Ee3XDJNpfdTjv5LyZOoehAGlyXESSiYI284+s3xfG5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YxdbM24uAzVsleuKMhT7QdHR6XFlGj8dICGqhRBRabSBx26SRIID3xfJ1BbBOca8E
	 RabV4x4w+4aJIccqpGoWNJD/9YYdlWqVKvPKVvO8M1nzWSknJ3P9jUOBEmICxjC5wb
	 evCjRuBrzgG6vYGLW/mu63xhN9RStCBlyFTeCoOEPSmkzYShg9cj6jtwzBF3it0/4O
	 UkKU11xqVMagrGqfDgFjt/FyJqiIZBceynQAAUqqm7qndbSjCk16+/Eldr7USb253a
	 B2ahLtx3vzizvuEhxO8CFFzk8Xwexxy06fwC9BuogOTu0v5TJc//sErnYu2t2Z1Pjs
	 IRK5K8bDdPs7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760AEC48BF5;
	Sat, 17 Feb 2024 12:52:16 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 17 Feb 2024 20:52:06 +0800
Subject: [PATCH RFC v2 1/5] dt-bindings: clock: histb-clock: Add missing
 common clock and Hi3798MV200 specific clock definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-clk-mv200-v2-1-b782e4eb66f7@outlook.com>
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
In-Reply-To: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708174332; l=1498;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=tAwhkwf2RTqZatW50V1J+QSR6rpA9D5O9tBXY261zlg=;
 b=Wd4NvzYkBjaJB8dBpsrrkE8Gp7ildNtAqBwU4yBYpdyeqle9YokQaZBaZsx2cDuJ8kNaJQ231
 adt6aXJIFTKB6GQJn8m4LtiU6fz/9iFOtuSNY1AXpwKDZvI8/AJEzYp
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


