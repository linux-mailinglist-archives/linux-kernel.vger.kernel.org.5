Return-Path: <linux-kernel+bounces-116559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FD788A0A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1182C481A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FE1160880;
	Mon, 25 Mar 2024 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="OJKGiTmJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DChUIr4x"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F8814883B;
	Mon, 25 Mar 2024 05:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345839; cv=none; b=LWhVxGBoz80f8Ai5m8VzA+w65t1nOd5MJIeqx0WsyvJ3EI60y6t7q4zOqumlmc6wLbJFJ/7+cXTsfHL725vsvsbX0WyNKK2l2ur/+joHW2LuvVVFXABFfbpPoM6njb8kbmMrSa6T1L03xJjT4Itrz4QpcsI0rMFXSDUFEFfkCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345839; c=relaxed/simple;
	bh=taiR2LqNvN/VeHRdruzcyhYIqXtoIGbp/aHvz+qX/bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfc/3wNo7+YcI10r9B3Lv+yVN4omQsmrp3JV3AdjyHageQsZ4fkvVULOdEADKlC7uYN1iZ1gcXNuU0NZ0hb357ti1JO4tzIKBPYQOwPejQe3xYxAVXMgOE+97wJ+wy1kw57ZzTrUvD86ZongG7muGfsopskpAcc/NDNrheF+G7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=OJKGiTmJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DChUIr4x; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id A28445C0055;
	Mon, 25 Mar 2024 01:50:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 25 Mar 2024 01:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711345836; x=
	1711432236; bh=wHviqYyVaAzxPv74LZp8KS2hwn6YZgLgxNlEoO1eLIg=; b=O
	JKGiTmJ8nLMIWlhhebolC+z8EAwxHFTZKYEQpQ+dqwQ94T91h//ttFRDXLob0TQI
	N1tDWycj2VVd68Jo1Afhs/VWHCkHE1rppsAWx+W/6nnZUQvJ+MSJbyWNSW8CEMRy
	Rz6TxF+GGIaoC4D4980YJJSwu6yBHFVF/EBTyjO/bBUS8exNoWl8E7p83dEQAhE1
	9Zi1qcheeT7k3C7x64DpE00Mko5tZHmyQSenDa5Qa9xaz1tDTCCBIrMaa2F5wT7l
	Prbh1IY7BGXvHTDx+VUH2LWc0vWEbI1Lu8WKQ9QlsuKFmPkG6wZLE0lMhT5DBHg+
	aj/4MxiZSiK3+dFmZlSkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711345836; x=
	1711432236; bh=wHviqYyVaAzxPv74LZp8KS2hwn6YZgLgxNlEoO1eLIg=; b=D
	ChUIr4xvlDJCm1cndbzx+IR2PWaRi6UoqBKf8N7m5q9bpddq6qyNFNVFT0k5BSFi
	69SASCF+GJQkcqyIRxTqXLmsHGtYhqnalOprZhTqSb4rtX7XZxmHTzLlmctTV7F1
	AvJvjz/EoKY/kLwdo9hzQslv96bzWGYDHtHqDfNLF2r9oF8M0avZoTQD3Fc5BAnI
	crDsPBDST8XDskq/yxEOlGrixL3FLIKi4REut+daPDSbNUexcS9VLUIsaxJrmKbu
	cMNCsiYU6GRmCB1jAeyQ1WNsDTMX790QJ9Tyw0iH75VMipMnm71IcOc7x5EzDg/1
	OhLeCcUECQrxQghJKPqaQ==
X-ME-Sender: <xms:rBABZh0MDl-0I1ei0yRCi-7Sarlffhjr97rs483ECzxRkrhhAGvv_g>
    <xme:rBABZoFSj7C0k2GSYCUNwiUGX5fKqIlXxQ15Zj8C4yWSsMPwxERD0mBmGbiuO4Ix3
    fbZsiWkZiLvOApQFPg>
X-ME-Received: <xmr:rBABZh5fctWwoH_EEhKMFR9noySOAcue5tAFBbfuI9N61DoommxWaaqRDlHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:rBABZu3fspsBrNzl7DsT-C9axfH8cgkvMso4i4PWibfxzDCcoQ6AsQ>
    <xmx:rBABZkEKGDGBd4ndAqt6ocQ7UfWmoJ-7zau0_UBGFBkdSIlSMHZ5sQ>
    <xmx:rBABZv9fRdPHdeAMjawdz_Yez9kbYWQKWtJT3bhs8Gq3Hun5Ms5E7Q>
    <xmx:rBABZhmLelwE36MRjEyOWShjCbNcRlMVS1J9nsyFBJA0ANFcp0Pb4w>
    <xmx:rBABZpPdnPBMDpO5LriUUzk70Ojw_J91LOGvvLed37rz7t8BdyEe0A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 01:50:33 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 9/9] platform/x86: asus-wmi: cleanup main struct to avoid some holes
Date: Mon, 25 Mar 2024 18:49:38 +1300
Message-ID: <20240325054938.489732-10-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325054938.489732-1-luke@ljones.dev>
References: <20240325054938.489732-1-luke@ljones.dev>
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
 drivers/platform/x86/asus-wmi.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9927a48b2dc3..e2aadb61b490 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -251,6 +251,9 @@ struct asus_wmi {
 	u32 tablet_switch_dev_id;
 	bool tablet_switch_inverted;
 
+	/* The ROG Ally device requires the MCU USB device be disconnected before suspend */
+	bool ally_mcu_usb_switch;
+
 	enum fan_type fan_type;
 	enum fan_type gpu_fan_type;
 	enum fan_type mid_fan_type;
@@ -263,9 +266,7 @@ struct asus_wmi {
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
-	bool charge_mode_available;
 	bool egpu_enable_available;
-	bool egpu_connect_available;
 	bool dgpu_disable_available;
 	bool gpu_mux_mode_available;
 	u32 gpu_mux_dev;
@@ -279,8 +280,8 @@ struct asus_wmi {
 	u32 nv_dynamic_boost;
 	u32 nv_temp_target;
 
-	bool kbd_rgb_mode_available;
 	u32 kbd_rgb_dev;
+	bool kbd_rgb_mode_available;
 	bool kbd_rgb_state_available;
 
 	bool throttle_thermal_policy_available;
@@ -297,7 +298,6 @@ struct asus_wmi {
 	// The RSOC controls the maximum charging percentage.
 	bool battery_rsoc_available;
 
-	bool panel_overdrive_available;
 	bool mini_led_mode_available;
 	u32 mini_led_dev_id;
 
@@ -309,9 +309,6 @@ struct asus_wmi {
 
 	bool fnlock_locked;
 
-	/* The ROG Ally device requires the MCU USB device be disconnected before suspend */
-	bool ally_mcu_usb_switch;
-
 	struct asus_wmi_debug debug;
 
 	struct asus_wmi_driver *driver;
@@ -4411,11 +4408,11 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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
@@ -4443,7 +4440,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_boot_sound.attr)
 		devid = ASUS_WMI_DEVID_BOOT_SOUND;
 	else if (attr == &dev_attr_panel_od.attr)
-		ok = asus->panel_overdrive_available;
+		devid = ASUS_WMI_DEVID_PANEL_OD;
 	else if (attr == &dev_attr_mini_led_mode.attr)
 		ok = asus->mini_led_mode_available;
 
@@ -4709,12 +4706,9 @@ static int asus_wmi_add(struct platform_device *pdev)
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


