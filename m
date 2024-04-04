Return-Path: <linux-kernel+bounces-130774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A7C897CF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5771F2A120
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281151C6B7;
	Thu,  4 Apr 2024 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="vhfJmPvq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="axl4b+IU"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D31C6A4;
	Thu,  4 Apr 2024 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189865; cv=none; b=OkVbzq6Nd44v2IIUDgIEdwv50X+030lLzxgYbMXehcTwSwL0jTIR7OB9uJVsUXrBg0Ce4Bu9ki2gdnSybgwOJrZ27kz5mBQxXwwEWkCkAFjQSqCdtb3Db1zmIeFB2hNvHDpcNoMPsJmyrjHvJCDITHcjwv9WjFCamxCX4WVskgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189865; c=relaxed/simple;
	bh=VKZYrJDBI4Tg+jJYZ5tYzIFr1wEKASSqze+TdUIUhYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKoQtGIL8RE4zqrMGPfy8Qh1AJ4D2J7SFtJF2wFUhfyU/BqqWhmq0eU/Db7yQMxyRD38RGzCcww6vJGfQRYPTByey5MD3s0XfPIDM/iLCLpLzVVoe2dGMfPcI/3dakneFKwy2BgPimabrvg/YdDbP+kW2gVfZUo5Bm+qyRA8NLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=vhfJmPvq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=axl4b+IU; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9BD9E18000DD;
	Wed,  3 Apr 2024 20:17:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 03 Apr 2024 20:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712189862;
	 x=1712276262; bh=SWwR8iaMb1pyiVmb4GJOb8En73DRDg4SXGzGWsHKjIM=; b=
	vhfJmPvqCkuxfiRTB7SAkmwQZsqAmMy+0MBdSWJIsi2PSAErVqv9QKaXHbGEmA2j
	fAVAfGfehC1vZY2WBm99ll/l4b6ctE1BUHljSOdhxWM0bd3FOUCLfUOA8Jp3ev96
	7C4oJMV3APOB5dE2gogV4/x0awN/7Azds3laYV95aTF5K/ULy4h4EjxuoypmD1E0
	cndgtbzgnpvVe1jTcnBcJEXI3SEUqtFli1AVBl/gqyQHLWBz7uu0/62NX1tDanQu
	7WM9IFqvlPqtEttmgZ9/BDveZuyWXxT/Zvyjdf7xmTbW4qKs82Qlji0u234i18Om
	hommiemUKWmVp8aFpIzThA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712189862; x=
	1712276262; bh=SWwR8iaMb1pyiVmb4GJOb8En73DRDg4SXGzGWsHKjIM=; b=a
	xl4b+IUtOsntKPlOEqzUBQZkulhzXdZrQTLU8RYX9Z1vIql/L4FWEC1nHBtmPfOD
	OjGfwh9KMfM+j0tDfCAyI5iji0fO31BRQNHvZzA7r1kbCwLDW1dbcuFgrdxwsNNK
	Zv2zS/+e+7GOjl51DvjVaDW+4U+jUWrsRuCRnOgki5jNPrl0VV/3MVt8nL6X7cLG
	20cDbPIwv5JoPg5yG/egqknAKsnD4tGdmrT/DPynChp6se+KJU3OT3oe1BXMuqbJ
	6kyrmMjOYKf5Q8qW0PTAypwnh28EspThfLOeoiWbyMBIv0TZLjFUXD5CfJJEjbPE
	xrhIkzkFEvMmsHzqRkJzQ==
X-ME-Sender: <xms:pfENZrVlpi05RBI-FklAIX4BysVUy8nJBTU6buFln1eJKoZFcyRfIQ>
    <xme:pfENZjkIDPAQ3245KpzNdnePB26Hmiw6Ky7k4H3xS31HN1V8lNHueiyYWilQ3E51i
    EFsci7MVSyO6xIJW40>
X-ME-Received: <xmr:pfENZnYOb_74TOdBsClWZyMeAV5mDunffN4qNevY0VC1IY2prmUOMq9lMYCq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpeeg
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:pfENZmWY8gnn5Iwd-pBo1kXAXZ0zAHoUpmKRlUy0otms8OkG1idSDQ>
    <xmx:pfENZllllYAieemXmbiuLJ_sU7Yue7V809jyOk9Mj7IbDNfmUWEvAw>
    <xmx:pfENZje5nBX_UEPt4C4R_7IFCh-bV8SSjgdXN4cqaq5OzA1rYa18NQ>
    <xmx:pfENZvHXc-XaI49aPe70eBv8f-ZX_iCRbQpFzkDUVNWaFuYfK-PTQw>
    <xmx:pvENZjaifIX-FT5p4rs368vYXXofWO4oft3WugS5r3NfqFl00D1qRBob>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 20:17:39 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 9/9] platform/x86: asus-wmi: cleanup main struct to avoid some holes
Date: Thu,  4 Apr 2024 13:16:52 +1300
Message-ID: <20240404001652.86207-10-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404001652.86207-1-luke@ljones.dev>
References: <20240404001652.86207-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reorganises some attr-available calls to remove a few unrequired
booleans in the main driver struct which combined with some
reorganisation prevents a series of large holes seen with pahole.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index d06d9e0c498c..2d2b4eca7fd8 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -254,6 +254,9 @@ struct asus_wmi {
 	u32 tablet_switch_dev_id;
 	bool tablet_switch_inverted;
 
+	/* The ROG Ally device requires the MCU USB device be disconnected before suspend */
+	bool ally_mcu_usb_switch;
+
 	enum fan_type fan_type;
 	enum fan_type gpu_fan_type;
 	enum fan_type mid_fan_type;
@@ -266,9 +269,7 @@ struct asus_wmi {
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
-	bool charge_mode_available;
 	bool egpu_enable_available;
-	bool egpu_connect_available;
 	bool dgpu_disable_available;
 	u32 gpu_mux_dev;
 
@@ -309,9 +310,6 @@ struct asus_wmi {
 
 	bool fnlock_locked;
 
-	/* The ROG Ally device requires the MCU USB device be disconnected before suspend */
-	bool ally_mcu_usb_switch;
-
 	struct asus_wmi_debug debug;
 
 	struct asus_wmi_driver *driver;
@@ -4391,11 +4389,11 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_als_enable.attr)
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
 	else if (attr == &dev_attr_charge_mode.attr)
-		ok = asus->charge_mode_available;
+		devid = ASUS_WMI_DEVID_CHARGE_MODE;
 	else if (attr == &dev_attr_egpu_enable.attr)
 		ok = asus->egpu_enable_available;
 	else if (attr == &dev_attr_egpu_connected.attr)
-		ok = asus->egpu_connect_available;
+		devid = ASUS_WMI_DEVID_EGPU_CONNECTED;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_gpu_mux_mode.attr)
@@ -4423,7 +4421,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_boot_sound.attr)
 		devid = ASUS_WMI_DEVID_BOOT_SOUND;
 	else if (attr == &dev_attr_panel_od.attr)
-		ok = asus->panel_overdrive_available;
+		devid = ASUS_WMI_DEVID_PANEL_OD;
 	else if (attr == &dev_attr_mini_led_mode.attr)
 		ok = asus->mini_led_dev_id != 0;
 	else if (attr == &dev_attr_available_mini_led_mode.attr)
@@ -4674,12 +4672,9 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->nv_dynamic_boost = 5;
 	asus->nv_temp_target = 75;
 
-	asus->charge_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CHARGE_MODE);
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
-	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
-	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
 	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
 						&& dmi_match(DMI_BOARD_NAME, "RC71L");
 
-- 
2.44.0


