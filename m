Return-Path: <linux-kernel+bounces-121127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDFB88E2A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD15F1F2B95F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7676F1741F4;
	Wed, 27 Mar 2024 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCsoSzgq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12181741D9;
	Wed, 27 Mar 2024 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542145; cv=none; b=q9/tCyqu/tjh4hMdtBVUz6HEAVragJRZvcO+hjcXgRilMCz/2H1HCqvpsYQtmHsxB0qwL8jUT6MgC0+imWc3e37eFfQg07wRAwKfi5fog+J2015DgUFWmeP+qdv9D85I0Twy+YZLsjcB2yjfppQzqSHl3zNHLsvxG9L7Wq9BLIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542145; c=relaxed/simple;
	bh=obkURlhBHAKHE8xVthfoKQaujgJoT6xVDQt6hnursTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cmsp2R26jhTjufdI0wExjRSpjxMvUnzmPqPSXBSphWmd00YlFuo/MnyaWlq5/ylNOhXV/yybXofvh1VnrvKrFccTYBDNW9abbv/k7zGX04s7YIeliLNIjp/nH0IWvmf6C3Mj+YD8LwFQxxG685U+9f/+B4gidVqVlARvYwV1NkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCsoSzgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680A3C433C7;
	Wed, 27 Mar 2024 12:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542145;
	bh=obkURlhBHAKHE8xVthfoKQaujgJoT6xVDQt6hnursTY=;
	h=From:To:Cc:Subject:Date:From;
	b=aCsoSzgqngG2yz92vGG72QAt4NTdokMe1X38CCdIn0Wy6jmsVxO2DP3iSlBJJFw9U
	 s2ndjV0sT4unS5HcCSPOF54GOgUi+gN0jNinWQZJxIKZWgIJiBXZOOZyPiV/Ye6koi
	 dRu91zeFtallPgg5bOM2OVpM84aKTEzwTU+/zFj2VMHWuFTTO12bdGQ7OuNVcJeecJ
	 pbvre+Bxm3oBPISVbjfk0NpI7MgChy9nIeXbtRyazOQY8l4NOk6Q6E1Lj3Oa71Bv4q
	 XdhZC2u8Y9hwOc+FRYanU/syTerZbemxkww1KsvhewR0yDMsPAPLnYFAuShOCYIRG9
	 305AubdBMDf2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	morrownr@gmail.com
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "wifi: rtw88: Add missing VID/PIDs for 8811CU and 8821CU" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:22:23 -0400
Message-ID: <20240327122223.2837673-1-sashal@kernel.org>
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

From b8a62478f3b143592d1241de1a7f5f8629ad0f49 Mon Sep 17 00:00:00 2001
From: Nick Morrow <morrownr@gmail.com>
Date: Tue, 27 Feb 2024 02:34:40 +0000
Subject: [PATCH] wifi: rtw88: Add missing VID/PIDs for 8811CU and 8821CU

Add VID/PIDs that are known to be missing for this driver.

Removed /* 8811CU */ and /* 8821CU */ as they are redundant
since the file is specific to those chips.

Removed /* TOTOLINK A650UA v3 */ as the manufacturer. It has a REALTEK
VID so it may not be specific to this adapter.

Verified and tested.

Cc: stable@vger.kernel.org
Signed-off-by: Nick Morrow <morrownr@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/4ume7mjw63u7.XlMUvUuacW2ErhOCdqlLkw2@1EHFQ.trk.elasticemail.com
---
 .../net/wireless/realtek/rtw88/rtw8821cu.c    | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
index 7a5cbdc31ef79..e2c7d9f876836 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
@@ -9,24 +9,36 @@
 #include "usb.h"
 
 static const struct usb_device_id rtw_8821cu_id_table[] = {
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xb82b, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x2006, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8731, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xb820, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc821, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xb82b, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc80c, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc820, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc821, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82a, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82b, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8821CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc811, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8811CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x8811, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* 8811CU */
-	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0x2006, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* TOTOLINK A650UA v3 */
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(RTW_USB_VENDOR_ID_REALTEK, 0xc82c, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x331d, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* D-Link */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xc811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xd811, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edimax */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8821cu_id_table);
-- 
2.43.0





