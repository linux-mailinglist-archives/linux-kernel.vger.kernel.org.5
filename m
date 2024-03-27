Return-Path: <linux-kernel+bounces-121208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1088E3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B325E2A460D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76518787C;
	Wed, 27 Mar 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJElV26U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E888F187869;
	Wed, 27 Mar 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542350; cv=none; b=umL/smUQ1ewQZ/1lIa4CE6+3QLxfvq4aEwFrvvw7sypEK23EMyPhh1li13KvTmgonO66glGiPBvrZaaMB5yAvRt8D8IglHA0f6XfvTW8e/tdNGyEB52Tlwc14PQPY9yiLkJF1X7+eBdvtkS2HtX2PUgB/0j6OcQFTj4+pffa1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542350; c=relaxed/simple;
	bh=MT4vR3hNJ7n3FM3oLVR/swhbI/4PaOX2ngnGVtr8j/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4ygS9O1dTpdXwL8rtsffoDY8Io+BWdtjsJeB6R4y3SzRTejH1hYoVpBHb9++j276cYJ6o74MDRuJzHPkPXW0dJY9W5sjedd0wVBNPNHV9nL1bjUWmuuXQyQ26RUtVBQYNIoLwV7VY+GO6B7uZAu4z6aXrOfUx0Pu5A457XI8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJElV26U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00893C433C7;
	Wed, 27 Mar 2024 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542349;
	bh=MT4vR3hNJ7n3FM3oLVR/swhbI/4PaOX2ngnGVtr8j/U=;
	h=From:To:Cc:Subject:Date:From;
	b=cJElV26U1cC5DFBOJ3EeWCtWh5kXCiPGJWANxZGVnjbiIMvZsYUxmPoac8oXkCBWK
	 sJMy3ntP0SKjm9y4MoufIRJiwZWp4FV+ZkhnxyomHRoF7d8E5GyM065z5AguI5VTSo
	 DERiKhon/8I4QQqYgG/SZqmup89Q3UfqGMZft5c6FhWCHAS6/iQLE4PoaTMYhYpPul
	 1HStn4j5mao4h7tpZxO1wV6TpiYTADIe4Ywj+pQCioy4erZEIWr5/yQVAMTwB8kHgO
	 tcPLTiIdjEi6PyzK5SdlaizH50QkIXf7HJNjeZQWPNSDUVNxQ+cHSFW21/4iRL2X1Z
	 +i4WucH2Fef7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	waynec@nvidia.com
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "phy: tegra: xusb: Add API to retrieve the port number of phy" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:25:47 -0400
Message-ID: <20240327122548.2840551-1-sashal@kernel.org>
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

The patch below does not apply to the 4.19-stable tree.
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





