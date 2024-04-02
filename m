Return-Path: <linux-kernel+bounces-127258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5958948D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF2E1C22CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1921017732;
	Tue,  2 Apr 2024 01:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="uN3cdGK3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sU5OpiXS"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C5175AD;
	Tue,  2 Apr 2024 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021747; cv=none; b=HnEg1sdNtBxKkyQNYP1/w/CIu4l1JB9uaIAukBCYKPz4zwAnVf5wk1BnqwFaEKg1fxcwRx0j8wX8+fz6kj0EG9yl4XR8WPibaX0M25erDLZT+XBKvZWG5t4Ofi+2dR5nbg4N3iBxnA5GIDXL4T5OGEzcCRaQdFnNRPYat2NKczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021747; c=relaxed/simple;
	bh=LWvRLZ6ZP/TG24Y7QiIJ886vAPHlgfmu6CJrx56yyWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnMSaR1QSAS/YLIOCzKE5UBSixgs1ZO0h8d/BTJ6ms9Syg6LaWT1KK9O4IAct5h07zx99vq1wQZ0k4PkT2RxgURgifSYkWKM43u2JPjnJ458k5dVm/jQYxqQCJVzAvOKNOtMFQ0c/YYot4rkx5KKfsAR0RgeyNEXUr+YJypCny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=uN3cdGK3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sU5OpiXS; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 75ADA1C000CA;
	Mon,  1 Apr 2024 21:35:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 01 Apr 2024 21:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712021743; x=
	1712108143; bh=wqpLB8ycW4eZTT9R9plE9TxSPiwaqargq3piwMKd6n4=; b=u
	N3cdGK3RN275pgn9YiiCkTZiY0kjZ8GQJBSqfeI5dV6RD333wIjK3GIFJTCOOjW6
	2tj38b65EOyBe5wHOQA2/pHrC++6x+Qd8eZ3mj6iFYOejjyZdufbk7RN454+VkAf
	wy16iicukeSz8/2HsBQue9fhD7JleLltrkWv1hxBzIix8xvdi423ZnmjJTHDUZvy
	zdalZEmS+O7+5YF5aSvkiAUXtoKtPrYqLmxnikxAYZMZpQe83LU2sqm6vmrdbIxk
	RBd0Aaee0De8xtvcbWQkKygMhZTS9/ABafxwYaHZ2zOsF2ZExsaMHA1iDdQYGJ5T
	sHk7tIqI1R1BAIs2/HSjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712021743; x=
	1712108143; bh=wqpLB8ycW4eZTT9R9plE9TxSPiwaqargq3piwMKd6n4=; b=s
	U5OpiXSP42ECADu6bl16rJiNPfUpIVYKbloIRU0RcRpKzCFV7D/HOLdZWU4CeZXu
	IVMjHIA+baeOWy43UZDzHuiZLUmBIEYwmP7JnGL7BGn9hOLzcJdpFlfbwvZrByec
	JWyDtIv963LgYcnypQ8KibIOhGzRibRbfLvFRmQZA0oeOHwza19t3MtpejzFMIMZ
	Iz1SgpRB5jJwhJwaCXYBROQS4msURa3LdhLywpcYLhkY8tcq6ksPjvOBSH5iIlH0
	KrQtWmx18sk/iXeJMI4JrD6iQRGtEytSpqMwpZAqVRj5E6lF680f6yv46HsM94Ow
	AzlYgyTLsz9YCpf/cc2Dg==
X-ME-Sender: <xms:72ALZpkscmtcaYnFR6FOe9e_-N7-OB_XkyzCtvHdZ33c4RombDCapA>
    <xme:72ALZk2PsGZi2DNq6YTzOdd3F9LuX9Xt_1gaBVI6o9LOMci1uzGmgFLTmcQV_dQDe
    dTL0ETNqgWSHuo4LFw>
X-ME-Received: <xmr:72ALZvqJSDJCuraorMmkTTf5A1ehTVJMbzGQcyBJTI-QuVlIEqMWS8B_x7Ea>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepfeen
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:72ALZpnHNNggkrZAfUliU-Xc35TRk8xcCsjSfefB1ctccyMpsR5opg>
    <xmx:72ALZn02HGUrBlI0SqgBTOhdC-Zf8xike8tNjPYdAYGM9mQ8QOKAgA>
    <xmx:72ALZosdGohhRAdukg5ljjZHSjkxPSj5MjgZxUGh3TuOe6OoASEQ9Q>
    <xmx:72ALZrUHa6KjCPxV--yBrXzBoArqLEilvRpe8I1fwSYmPW3n6uSABA>
    <xmx:72ALZhrqF22CzoV3ODJu-Jarum8trvLePR2nwyCwENpWTaQk6txsaO3NupU>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 21:35:41 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 9/9] platform/x86: asus-wmi: cleanup main struct to avoid some holes
Date: Tue,  2 Apr 2024 14:34:53 +1300
Message-ID: <20240402013453.18205-10-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402013453.18205-1-luke@ljones.dev>
References: <20240402013453.18205-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganises some attr-available calls to remove a few unrequired
booleans in the main driver struct which combined with some
reorganisation prevents a series of large holes seen with pahole.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a6b648457908..7163cce7079c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -243,6 +243,9 @@ struct asus_wmi {
 	u32 tablet_switch_dev_id;
 	bool tablet_switch_inverted;
 
+	/* The ROG Ally device requires the MCU USB device be disconnected before suspend */
+	bool ally_mcu_usb_switch;
+
 	enum fan_type fan_type;
 	enum fan_type gpu_fan_type;
 	enum fan_type mid_fan_type;
@@ -255,9 +258,7 @@ struct asus_wmi {
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
-	bool charge_mode_available;
 	bool egpu_enable_available;
-	bool egpu_connect_available;
 	bool dgpu_disable_available;
 	u32 gpu_mux_dev;
 
@@ -298,9 +299,6 @@ struct asus_wmi {
 
 	bool fnlock_locked;
 
-	/* The ROG Ally device requires the MCU USB device be disconnected before suspend */
-	bool ally_mcu_usb_switch;
-
 	struct asus_wmi_debug debug;
 
 	struct asus_wmi_driver *driver;
@@ -4373,11 +4371,11 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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
@@ -4405,7 +4403,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_boot_sound.attr)
 		devid = ASUS_WMI_DEVID_BOOT_SOUND;
 	else if (attr == &dev_attr_panel_od.attr)
-		ok = asus->panel_overdrive_available;
+		devid = ASUS_WMI_DEVID_PANEL_OD;
 	else if (attr == &dev_attr_mini_led_mode.attr)
 		ok = asus->mini_led_dev_id != 0;
 	else if (attr == &dev_attr_available_mini_led_mode.attr)
@@ -4656,12 +4654,9 @@ static int asus_wmi_add(struct platform_device *pdev)
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


