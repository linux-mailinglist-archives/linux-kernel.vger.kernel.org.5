Return-Path: <linux-kernel+bounces-27862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5067B82F6E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E711F23C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAAC60ED9;
	Tue, 16 Jan 2024 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf1k3fEY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D260EC1;
	Tue, 16 Jan 2024 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434390; cv=none; b=FYOWohoNemuet1WcqPfR6bM2niWOehKUjGxgUs/tYPw6M5b9UQ9gPNylNjFmf8Ef4383fyPHLYnw0EI/oi2wSoVdP5CLjC0gCf4rQIAhFgTC4lnR5So8ikWZ50fM/10rkKdBP2gBs4rTYJ8FMvfjYfjx8jaqxKb7z+Ykfiy8GBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434390; c=relaxed/simple;
	bh=M5NBJihdGXl/xoW/iYGnKLMkD/5lFppI4LK0FmskZeA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=MhfWNI1Bo/rwUON6XoX4+UsQwNHPLUO9+RzStMXJ65/7B+FBVINXXNgb1n4Vdy1jfJcyWV7CNKKshFuP2XQLVaEvYK8J9YB1PTYIQSq8Z8l6Rb8SeUiC53QPl3fVCoMo7mm8pDyD6321gYY8ThdOxqB2TlH3WH6MykHGgx/7/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bf1k3fEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363B9C43394;
	Tue, 16 Jan 2024 19:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434390;
	bh=M5NBJihdGXl/xoW/iYGnKLMkD/5lFppI4LK0FmskZeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bf1k3fEY3uvbH/hma/OVqPVnnBMo43H+YSFW65ze7eSnt72nKN2K/kxLmMRJpY/r4
	 qZWrWR8veDuw+ZhAWSr2d+3+1TknXi+uur7ltQOZcpeBGQonaPzy6JnIX4l8chKmgI
	 dfqfBVoUpyBz98shDCIvoNYW404dnjF4Jv+iP1YnjpRDZHCGfojPSHH7fzDlW1JsSs
	 7DQtGKb0aCFRzS9A/w49NNxCkQ1D4316g3GNDawcz4nJKmjPTIwLtf3wdNXZDl3V1M
	 GVbiVkk+yLr1NWX8b9DkSoDCq2kKHNXbbU5kEghJNmEOQS1We1csurfQXV4VixBNQu
	 GQ/4Hj8PFBPPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jes.Sorensen@gmail.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 090/108] wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices
Date: Tue, 16 Jan 2024 14:39:56 -0500
Message-ID: <20240116194225.250921-90-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Zenm Chen <zenmchen@gmail.com>

[ Upstream commit 4e87ca403e2008b9e182239e1abbf6876a55eb33 ]

Add additional USB IDs found in the vendor driver from
https://github.com/Mange/rtl8192eu-linux-driver to support more
RTL8192EU devices.

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20231217123017.1982-1-zenmchen@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 43ee7592bc6e..180907319e8c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7961,6 +7961,18 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192eu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x818c, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* D-Link DWA-131 rev C1 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3312, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* TP-Link TL-WN8200ND V2 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0126, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Mercusys MW300UM */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0100, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Mercusys MW300UH */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0104, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
 #endif
 { }
 };
-- 
2.43.0


