Return-Path: <linux-kernel+bounces-27999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC6982F8E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD4C1C25389
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A315BFCA;
	Tue, 16 Jan 2024 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSz0A157"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3713AA57;
	Tue, 16 Jan 2024 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434809; cv=none; b=KWiEnw0E46OMfkBH9/6RfXCVG0Qy6bnqzIl7ypEnOF2oRnIGpdGZ4/ujq7DXqpTsYO6jC3m5mVxjamYDgvEdfewCbizaobmw60R3bo/mhmFw7OGeifG/WvkMwuRcDvfyGRQeoyhDlHLWf86SifuRJQ6Z+I6iYIFNLrjhesnFLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434809; c=relaxed/simple;
	bh=llWvpXxjDPWACCEY9hArCKrbKcJDJUBu4XluRVvG/VY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=T1CPI+m96rH2RaoSMtcPKYU3tlvFHwxcSnQXsln9IureSRcLVMR8aXdu0JGu5hce9GQARmdIxlj4EagaqAs2K3mfLaGP5k/hsQISmaIhFFU4ura1Xeotsty9i0ObvxyblZWsiHsgQiyVQkwlgQJX1ZVgIJ4mthYoQ87wgEBATAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSz0A157; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E04AC433C7;
	Tue, 16 Jan 2024 19:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434809;
	bh=llWvpXxjDPWACCEY9hArCKrbKcJDJUBu4XluRVvG/VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eSz0A157Nk2s5nopZFFd3HV5V9YDmi05T5PntJ+PurnES5Dk/S5C5ce6X2V005Xoc
	 ghIRkTbDaGcJrRsP2RDwZ0b9v479BcREgKG31UOiN7OE3S78OZ72uUPXf9XWIIBom8
	 dXhgmzbAy1R5IbomsUDQ5fyXpNFqVMI5TaC0ebtaPDj86ACAn8YdxdDlCpckUtyzUr
	 2BOk4WWbrnEwjRLyNGEuwkwzCOq2wLNJSAXaYHe+CbRGpL99AcvTPCtR6pfGjpmyip
	 6K7KQB/B4pxi5L3Rtoz9QFbbVFWeLTEj2ej1bGWQZMwa17H5XyeCVdnmnLiUyw8VVQ
	 WeEVR0zkz8eiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jes.Sorensen@gmail.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 087/104] wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices
Date: Tue, 16 Jan 2024 14:46:53 -0500
Message-ID: <20240116194908.253437-87-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 5d102a1246a3..77b356fedd82 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7959,6 +7959,18 @@ static const struct usb_device_id dev_table[] = {
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


