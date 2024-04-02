Return-Path: <linux-kernel+bounces-127304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEEE89496B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590CD1F2441B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CDD18B14;
	Tue,  2 Apr 2024 02:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="rtkEOFh3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sgwVjwHv"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F11C292;
	Tue,  2 Apr 2024 02:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024820; cv=none; b=nJfEtpp05MkJrNi4DBxnIHBIFxSFzLxQ3SU0Yw7DznPwJWglcF3DeNbaLreJs6u/OYo2reAxTWyjfQF9GizRats69IEswCgCvDUxantvJ7brEB2K49/QsxqE4/9PRJ96EVkYX/WlVwI+qRA+cIL4ZrQyUyqC7y+3le1TyRg5zVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024820; c=relaxed/simple;
	bh=IvySbLvN0x2n9rr5E3rUiKz+vzOelwZwKBjqRKjCn0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLiN74oC/IZ7OBFx80MjNQz6w7i3vFfe+HeTq5d3Tu1kovnlNvu2aJBGcw8PoernYhCTS9Vw3nS69kJw/oKoMpuW4/TlI15UzIdrRgd3hoFBJULFt7N0/QNaQIdYXWbc13YJNyzz72OWEjjAmAzlJIQQaKEuFmh/cjYaH1Jv4IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=rtkEOFh3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sgwVjwHv; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 6D7CF1C000DA;
	Mon,  1 Apr 2024 22:26:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 01 Apr 2024 22:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712024816; x=
	1712111216; bh=t003vrTNOcOKt/t5DUn3QjGdbpxhSKS+qSrgHTwtnoY=; b=r
	tkEOFh3CSAwpHd52SmoLDXx5etAtSQZWETFw5Kief1XeNfY7ZNzRl3fYu72P2rbz
	Pcg4sNU5oeq0hsFYkiLvFyIdoMxnMgEnBU6J5ePNQu0ZZ6c68jS1pa7g4GXiJGJs
	5AQXEcPIPZ3luZSJTdFIoCMuHXgmu2e22ctQG6UPJelZ5t8FXO67qV3SXhicJfoD
	+GD0Jw405U8/bYj9xS5XoxsQcT6tW1Ig4zMlSCnweQk4SOVwO+aClnjp213GgdwB
	DKAa6xvHbn9zhHZaKa5Vm+AwiJvQTLr+MF915mz/dz6iFP1RNFhU1pt0S0HdQYcK
	I/7uaN0pGX9ZY84jaWxqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712024816; x=
	1712111216; bh=t003vrTNOcOKt/t5DUn3QjGdbpxhSKS+qSrgHTwtnoY=; b=s
	gwVjwHv9eoJHLvgQKmjv93s/vXzMbxrrgVAWBahmyQ8g7P2Np8/Q0kSN619rFyAC
	V2FIIs22hGi5+aNROPeX/vY1gfHrUjcGrKMXTCDI7dCZ0/CxSklKd8jYvoB0tkQz
	pqW4BJ9VM1T7W+5GD3/q+hiGMiHMhhIVyk9dZpWAdA3+IsOYrt8XyiA1zu1aeW/z
	SLigEsZ06VZZThjAtplVxuBfhRnYUsAUCrX0+k3ucvvlDYL7YVsp5rsUMJjDbzNs
	1CAqRWvXNwpC7jrH9xR66xjRXeyCw3dzhYR1KKakty86YsDU9NuuiusitsD4LFmK
	+YZeuGDrTvpW7lJWIyY0g==
X-ME-Sender: <xms:8GwLZsHvrb2PM4WJVgOkugSwtIIVifZI4d0GNwm93wHzJkfXtJepNA>
    <xme:8GwLZlWXWLRh1pbdTlD_1SP77DuljUJUAuouZZFbWMax29bEcZZJtyzpMLrkyGjdk
    E-vd6VQmIz2n6b02ts>
X-ME-Received: <xmr:8GwLZmIla5FzlOuyDAxtiLjckQdXREuc-9ItsoRe2GkhqamnE92O1ZJ0fRMp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:8GwLZuFicOUOyCZVLKEBIYfELaPPT0uz9lk6AlGqaiXBgZGmgYjQzw>
    <xmx:8GwLZiUEYCty9utAL4R4zHDkHubryN0mB8OAw_mzCZQQ_ILP-6V2WA>
    <xmx:8GwLZhOenSSd7AxDn2Ifj1nnPsZZFChrkwjuJpPjxZOWv_ErkKn2rg>
    <xmx:8GwLZp3xQtluGzpqYjhnQIpza3RxLyaD5eAUKk_BznR5O7VpBHxQVg>
    <xmx:8GwLZkLH6jPEOx1QgnAAtXUCfhxElB4cNqdhQNVjEIGbZhQ0m3Sjcacp1xw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 22:26:53 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 9/9] platform/x86: asus-wmi: cleanup main struct to avoid some holes
Date: Tue,  2 Apr 2024 15:26:07 +1300
Message-ID: <20240402022607.34625-10-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402022607.34625-1-luke@ljones.dev>
References: <20240402022607.34625-1-luke@ljones.dev>
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
index cf872eed0986..c8a8ddaeff29 100644
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


