Return-Path: <linux-kernel+bounces-128882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 934CA896171
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1174A1F29FB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E682D3AC34;
	Wed,  3 Apr 2024 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="iXHwBp3K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s71guyJD"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E32226288;
	Wed,  3 Apr 2024 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104195; cv=none; b=AWnJJx50hPSeKGaxKK9QZl7V9Gz+IlhouTQ9NI6aJhnC8viM8Vav7sY7msUGFhI7CDOZbdRVXk/COskD7L4xtEAoZ0J9IkyG7U5fmOMA1zUS9MCziaJVbvwD+mb9RvZyEIHlQ4kAaAIEaDYIBQe/2GFCZT0Uxa3snPkCcCYR2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104195; c=relaxed/simple;
	bh=bCbber1Nyn7koWEB95L7XP5P29hH8vZSiF4GmVJqO+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igWa6XIsGc/h8d/HqumNDT1867ZMlpcq+DWB+TNlctZHncUVjeRZy4Tmx9zfC9t1Sp/fj1WsVMzCQ08I6kIW9SIjHThJTs0R5pgoEUZSmyOZpohVIZ5IL2vty7IsUYTvnrWu/sqOIVDqQCVp/XBG3Sy3Wj1t5tTsYYATSYDV7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=iXHwBp3K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s71guyJD; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 87BE3114010F;
	Tue,  2 Apr 2024 20:29:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Apr 2024 20:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712104192;
	 x=1712190592; bh=Z5OnXQIuZf57gwSDw8vHx6pbscFm1+SvEePYmb8TQ8c=; b=
	iXHwBp3KxsKrpeao5heDGHXtnCB28gVy15OEHdE6dN5vzmfqsGs0l8tQaTwY+T50
	pBgdOTYpHzczGGGG71HYowJyUI+wyohJ4VGn4eK1sUBurINzhBPrDzB5gOgNlFG4
	H0sTs0C1rOIP8hDGdvuJajS6F9cyUWNrA9I2NuV4YWJITvUaTRuxJXR6McjjlNeB
	TIiQtxVrhGXPw+xwnyV9Ld52NhQjn1RV8Benm0S5NE1ta3UcDGVLIIoXa8nEZdh8
	HKFyU3ORZCqFwIBEWmaMLYHORcrKiSMfhO9VOtF+WLf7izIJ3byqkhmTfPZ8Nwgl
	gLLcRcFNsTjK4VzWSFCGWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712104192; x=
	1712190592; bh=Z5OnXQIuZf57gwSDw8vHx6pbscFm1+SvEePYmb8TQ8c=; b=s
	71guyJDxRUp2vdXR46slhx/Oa1uIFTxfSe9B7zWD68KWoyu+7X1kMhyVW6jGqrDh
	jQUNvxMkcHzxfDs9X3Y6pspa+417V3Tv9ZsKSWjLh3jk1HsTsfY/B9n8xZPystdB
	kQys80JLBKtXpSP4l0wry3GZlzKCNVJMY0pyELePgJrmBBgYQBaTaQWazzs2PIE/
	IYFI80IG6pwmtVvqvot8SH4cXLssflF0mIc9kWsGr3UKtFFflds+SLAeu14kgQl2
	twb2p0Xb2tV1nWu8oK5WNTt4L48ymf9Jg2TqMc4W4h5TGzWx+t5frRI6KZIrEY0y
	Y4HlHEJuHxwfzlyaDaLoQ==
X-ME-Sender: <xms:AKMMZnql2AamQ2GvTQ7qtJAuZVPyJy01kYu47OcxZbvjPzR4ilmUQg>
    <xme:AKMMZhotWC-cEz3-P-G5cD9EgHiHUe6NxQSloNW4Ie8iEYuIZXZpf4AzBkKQ4qtb_
    Yjbj83SOK6rnuXPKHs>
X-ME-Received: <xmr:AKMMZkPoaHiv9KHWvxSFGQAtPzqu5MQZxx3_HxFziRUhIX6mhTUGTsmmEp7v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpeeg
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:AKMMZq6C_gGUPCI4wnUSDumSw2IodfbJij_iQsuyFczADB0UwP68rQ>
    <xmx:AKMMZm68cRt_nOjlWpCGngB6QP0BgdZhP8ZOoUJiq3fDwK5UD5hBgQ>
    <xmx:AKMMZiirBnm4N4CT7VSDqnDdeEB6NqBvqxs5EYmXUPNDzqEa4nTUJA>
    <xmx:AKMMZo5hGnFX_0J3jzzgQ6gk6_3G84_BFNQCTHmOi3n2OHCgCobLfA>
    <xmx:AKMMZjtdAtWcaWRpSMTQcYO5fSi4-NV0E4pVlZVhv0aRygCQnbq_FbnH>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 20:29:50 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 9/9] platform/x86: asus-wmi: cleanup main struct to avoid some holes
Date: Wed,  3 Apr 2024 13:29:17 +1300
Message-ID: <20240403002917.2870959-10-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403002917.2870959-1-luke@ljones.dev>
References: <20240403002917.2870959-1-luke@ljones.dev>
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
index bf36ac11ad02..b02dcff7d63e 100644
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
@@ -4389,11 +4387,11 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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
@@ -4421,7 +4419,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_boot_sound.attr)
 		devid = ASUS_WMI_DEVID_BOOT_SOUND;
 	else if (attr == &dev_attr_panel_od.attr)
-		ok = asus->panel_overdrive_available;
+		devid = ASUS_WMI_DEVID_PANEL_OD;
 	else if (attr == &dev_attr_mini_led_mode.attr)
 		ok = asus->mini_led_dev_id != 0;
 	else if (attr == &dev_attr_available_mini_led_mode.attr)
@@ -4672,12 +4670,9 @@ static int asus_wmi_add(struct platform_device *pdev)
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


