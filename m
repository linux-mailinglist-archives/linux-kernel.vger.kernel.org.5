Return-Path: <linux-kernel+bounces-91550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2447E87138D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4FDB23CC9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00EE18EA5;
	Tue,  5 Mar 2024 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h12Cf+4K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835018036;
	Tue,  5 Mar 2024 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709605196; cv=none; b=TAzBSTga3MsStMBG/ZAb/amVDHQ6mHO4TT4i7V4UtUfiViSIRwS38KioX9YbI0ZybBVr2fTo0YemXOGvk6lyADqB4SWQa/q9gMyRAtL1hIB3holVXf/uOA2iPVByb/4OeUbSeDQtUOgumt5n76F27YHDbYcFhz/1sTsa9cYJfkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709605196; c=relaxed/simple;
	bh=OjEyTLXhFc+NhOgfRwXQxvPYuk8lc7ZeewXgBolvWEE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pZk/SLZa7xBcr34S4uZSqEeGdEGOOlU2bs49zbmtmbxRL1lbNe+wYRSMH5DiGuOwc33lWayqh4PMKJXb0cWdN4Ko1fWDckgIGQtlxFsIk4x2Nd/55ARfkQLAJ307he9YT+wIhYpZk568QF8wu7bQSSefsLnN+xZkccgQW7d4+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h12Cf+4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71496C433F1;
	Tue,  5 Mar 2024 02:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709605196;
	bh=OjEyTLXhFc+NhOgfRwXQxvPYuk8lc7ZeewXgBolvWEE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=h12Cf+4K1QuvB721uPks71ZEUTDhNNR6OOZx4fsENXc7SRu2KyISRoyRk8xdfwgZ4
	 aN13SMM9dfxhM+grVAQbboVZscB+jIhSLtGfveqb51pyO4C6Wzz575d340FvaP7Gsb
	 DkaFPXos9nkthKrjj1vqR1jGOI44fULA+X02QkF2rvbs4JFr3NuxRDwFNC31zkAQ97
	 G5tDWW1sGe+xCdwzvsxBGibbDC4/XJII+rY1NurYYMH5Ft+kwukjanIaPTBkaGi0N+
	 AXCQVs75fAY8Nnmx9I0CJYXaW1FN3oMG4xgvAGMF4OUTPSQPfCZuXrE5fcJAEmZ3Mo
	 jaYQaqvAgbdIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5909BC48BF6;
	Tue,  5 Mar 2024 02:19:56 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v4 0/5] phy: hisi-inno-phy: add support for
 hi3798mv200-usb2-phy
Date: Tue, 05 Mar 2024 10:19:45 +0800
Message-Id: <20240305-inno-phy-v4-0-a03204c9cf1c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEGB5mUC/23MQQ7CIBCF4asY1mJgwEJdeQ/jorRgiQoNVGLT9
 O7SrjC6fJP5/hlFHayO6LSbUdDJRutdHny/Q23fuJvGtssbAQFOgFbYOufx0E+4gU4KMJUSXKH
 8PgRt7HtLXa559zaOPkxbOdH1+ieSKCaYNqqmYMiRMXP2r/Hh/f3Q+idaMwlKKgoKmTJlhJZCE
 V3rX8oKCqSgLFNZs7YzsmJM8W+6LMsHym4NAxgBAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Shawn Guo <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709605195; l=2411;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=OjEyTLXhFc+NhOgfRwXQxvPYuk8lc7ZeewXgBolvWEE=;
 b=L1PzroKfL3Lrklu5Bbd5wFX9r9Oln+xKJJB9OLCWiUKOMVvyE0zmNJHRM880u54UfyPSXfw/0
 gioCHDnUnmLB1gSXXwhLXVh7SeaFDmgy08Ixh93KJY/Uuos2SWCHwPh
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

This should be considered a hack. The proper solution would be
extracting write_reg logic to a separate regmap driver. Leaving only
"write BIT(2) to address 0x6" to the PHY driver.

A proper fix should be implemented later.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v4:
- remove reference to histb-clock.h
- remove fallback compatible as it has no use.
- remove phy_type (belongs to host controller)
- fix bot error (Rob Herring)
- split YAML convertion into two commits, the other add mv100 compatible (Krzysztof Kozlowski)
- Link to v3: https://lore.kernel.org/r/20240220-inno-phy-v3-0-893cdf8633b4@outlook.com

Changes in v3:
- address a few binding issue mistakenly missing in v2 (Krzysztof Kozlowski)
  - add msg about hi3798mv100 being added to compatible list
  - remove minItems for compatible
  - remove | for reg:
- fix existing dts (hi3798cv200.dtsi) due to binding change.
- Link to v2: https://lore.kernel.org/r/20240217-inno-phy-v2-0-3bf7e87b0e9e@outlook.com

Changes in v2:
- rewrite commit msg to show why hisilicon,hi3798mv100-usb2-phy is added during YAML convertion.
- split required: to multiple line
- add allOf to wrap if:
- remove perictrl wrapper and the second phy in the example
- tested the binding both for mv200 and cv200 dts. fix some silly errors.
- remove Pengcheng Li from To:
Above all are suggested by Krzysztof
- use reset_control_array_* APIs to ensure all resets are controlled
- Link to v1: https://lore.kernel.org/r/20240216-inno-phy-v1-0-1ab912f0533f@outlook.com

---
Yang Xiwen (5):
      phy: hisilicon: hisi-inno-phy: enable clocks for every ports
      dt-bindings: phy: hisi-inno-usb2: convert to YAML
      dt-bindings: phy: hisilicon,inno-usb2-phy: add support for Hi3798MV100 INNO PHY
      dt-bindings: phy: hisi-inno-usb2: add compatible of hisilicon,hi3798mv200-usb2-phy
      phy: hisilicon: hisi-inno-phy: add support for Hi3798MV200 INNO PHY

 .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 119 +++++++++++++++++++++
 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  71 ------------
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |  70 +++++++-----
 3 files changed, 162 insertions(+), 98 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240216-inno-phy-a2d872f6b74b

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


