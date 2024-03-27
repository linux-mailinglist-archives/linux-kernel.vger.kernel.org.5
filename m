Return-Path: <linux-kernel+bounces-121113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 825EA88E27A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1492E1F2981E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F665171E77;
	Wed, 27 Mar 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxKzOdoC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E8171E63;
	Wed, 27 Mar 2024 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542114; cv=none; b=kBKK0DfqBe7ozu7qnoG0LToaIrGNiEL48EetZ8dARJ1atM+LC50xMmLIdkMtYYG3Li9trI1ROpw7ILtMrVdNFNi+ePrwsGP7vq8NoQhZn0gJHhIrH0X7peexrKzabOen2yTwWVw2DveWeI6sKCK2OJdpaQVDIyUTByZETx70i0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542114; c=relaxed/simple;
	bh=jBv5ziu7G1EKG3yyoWDjuh6Cqon7VND+2PutxfHY9ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGauYswtQdDaHZXoBw3PntzQGM6BmW6bgpi79RzuslHzHLv5+dZQnWI0BPCX6k57F4KyKqB8qt4Xuq8enfRWJAu2WuwCQAsO6JfPLWfMUbPPCqNn3rLQwM9oCF/I925fPZWtdWSvb7D3JS+/RkJ7fiiNVbhkg6b172IgW18bJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxKzOdoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62613C43390;
	Wed, 27 Mar 2024 12:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542114;
	bh=jBv5ziu7G1EKG3yyoWDjuh6Cqon7VND+2PutxfHY9ng=;
	h=From:To:Cc:Subject:Date:From;
	b=FxKzOdoCFULlq3Ejr1L7k9iza0XHOD4fdPolx3El9AcEbL3Oy4Sp5ivwzkXDSSpF0
	 5a39jhpOgQYpLkUB0kEnkhgOCMOqKQC7rr9+tQ5fWlYDSOKgZ8sL5twF+xPRVnLll0
	 6s0w9X2lfWhoAE6fiBorPJjwU/DAB9499cKAqsehLIfnVfTvicu+gYdSHR414r78lK
	 sr6CEmFKLmpshmYmRolu3hsObO5UBXkM5GPalGCWuwWPJhxEKimPzg0LUONTp8qFv3
	 /1QtH3z22vSwkQKt+vTmNdnUPEdY99Kyixcv5APjbeJ2TUQD209S5ORahw37+QF6eH
	 tyiqx7pQpYJRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	waynec@nvidia.com
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "phy: tegra: xusb: Add API to retrieve the port number of phy" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:21:52 -0400
Message-ID: <20240327122152.2837220-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d843f031d9e90462253015bc0bd9e3852d206bf2 Mon Sep 17 00:00:00 2001
From: Wayne Chang <waynec@nvidia.com>
Date: Thu, 7 Mar 2024 11:03:27 +0800
Subject: [PATCH] phy: tegra: xusb: Add API to retrieve the port number of phy

This patch introduces a new API, tegra_xusb_padctl_get_port_number,
to the Tegra XUSB Pad Controller driver. This API is used to identify
the USB port that is associated with a given PHY.

The function takes a PHY pointer for either a USB2 PHY or USB3 PHY as input
and returns the corresponding port number. If the PHY pointer is invalid,
it returns -ENODEV.

Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20240307030328.1487748-2-waynec@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/tegra/xusb.c       | 13 +++++++++++++
 include/linux/phy/tegra/xusb.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 142ebe0247cc0..983a6e6173bd2 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -1531,6 +1531,19 @@ int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
 }
 EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_usb3_companion);
 
+int tegra_xusb_padctl_get_port_number(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane;
+
+	if (!phy)
+		return -ENODEV;
+
+	lane = phy_get_drvdata(phy);
+
+	return lane->index;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_port_number);
+
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("Tegra XUSB Pad Controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.h
index 70998e6dd6fdc..6ca51e0080ec0 100644
--- a/include/linux/phy/tegra/xusb.h
+++ b/include/linux/phy/tegra/xusb.h
@@ -26,6 +26,7 @@ void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy);
 int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
 int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
 					 unsigned int port);
+int tegra_xusb_padctl_get_port_number(struct phy *phy);
 int tegra_xusb_padctl_enable_phy_sleepwalk(struct tegra_xusb_padctl *padctl, struct phy *phy,
 					   enum usb_device_speed speed);
 int tegra_xusb_padctl_disable_phy_sleepwalk(struct tegra_xusb_padctl *padctl, struct phy *phy);
-- 
2.43.0





