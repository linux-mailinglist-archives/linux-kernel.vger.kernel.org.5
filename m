Return-Path: <linux-kernel+bounces-127252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BDC8948CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD198283E99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5F71119B;
	Tue,  2 Apr 2024 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="Mnv44cG4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXUAWk47"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8AEAF0;
	Tue,  2 Apr 2024 01:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021720; cv=none; b=Do0WmgNfD9jQaHTUwJ5MzBhQK58FLgqlOxjp47OR5V/J5KppZ5DNyZXHWgAlH3ZWNXBZ8l0QEuvPk+73jeiBlYD2LUoCeNBTtDybOJ741BjoL2djONEuO/6VaIMdGSEkgRdfbSc/rWnSJtDoPd9LtGzSPYOnp/plHGLVbXJT+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021720; c=relaxed/simple;
	bh=VlFnQWohpOZ9H8lYI15ZLOMd+VWAsFfD7NYlWG/+vlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2eTR9BvZXbLIKxHUcmDdU2Cwajy7Na5chedtojcF7LStLqq6q2y5HK0ovFp+R63elAbt1jmKvCjVRtla1Fs+JmMpzdb1iU28bTfKIkzuKpt/CdmyduzxvWHuB5IQkpsCoqHbJ+lf7/eLqenlJj4gwQATErrkGEogR4h/Z0EyuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=Mnv44cG4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXUAWk47; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id A602C3200063;
	Mon,  1 Apr 2024 21:35:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 01 Apr 2024 21:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712021717; x=
	1712108117; bh=sxh/Rrmhzz2YW/e0eSDoLDFtMzpiCcqlo7diCdJKm7I=; b=M
	nv44cG47I0hF5pwvqQkbelwgogN51qis37p7eeeIZG21wL9FU1ys3ZmgAp+GvaEe
	T22xei5rMnKzoazgnHivIpMM9L7Ylll4vK/pYyHD9xAhifYkMrjKkvVoRAvWt1ed
	D8Z8Le6YSRn2yuF0b3izzos1B22fdqi5jmHe0E8dYfoBIAwxuc3cB8wD5zF64ofm
	0Fbp1d/cdt1gw5iBhlbeG+CIbZtaOpS9cHaBQ3IJNkw3oPZFuk9My5e6yNUzdZOK
	mArJyreFPxQnw6MJ6BMFLoFLhHI4vY1MFdIoBQohdziiQgoMoCXRXacgj5VbwDQV
	n9tiL1E0TWinOXmYrJAWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712021717; x=
	1712108117; bh=sxh/Rrmhzz2YW/e0eSDoLDFtMzpiCcqlo7diCdJKm7I=; b=P
	XUAWk47lPqxrzu1jrDc+fzHCL2licxXQA/TD3YbWxHmTIY90cs7bZ4Wv0FVpHgVR
	Ax2Q/PE36sfcu2EhRQKuHVSgH19On0lBNkkA600rc2gX3A8F4FgT6bqzVP3xR3aE
	2phD41x+fsVfADCBm3HWfHvg72p6lwXPZGuA5hyC23Z6wBUZzW/N/7N08xlyrVGz
	RDyjVo3hBoc2mBaP4pM6YUId9yCJbmmEth8keQTZw/rlXhLTVYqU2zC5gyP6z98v
	rSBaP+1/PMGFdo1uT/hF7blfsB+zaD0FfdkZtVDWfziko1BFMe6dvdzMB45h+wqB
	ecoMDoBlyw2BHK89cxe/A==
X-ME-Sender: <xms:1WALZtk0tABsHSBp-8_S3sBMVquQyN1XgKE8sq67F4uI7RyYMejfvg>
    <xme:1WALZo2SN2L4Udl70rlthvGot3jiL3VDl7ju4CgJ_B9DUoXQ_gc49A3shTpq4-Cql
    CNpuxH50BWUlYk8pss>
X-ME-Received: <xmr:1WALZjpssBb-fl3criWqRWXfZYKN7rO00ik31C-szuLaeYv2JAclfSu3BACF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:1WALZtmctYCEJZ8pJEErTwdMZahPNumsinUHpcVVKkYF09cfuvbdDw>
    <xmx:1WALZr2CjvoH-BkcNaq5Wd0ckMq4aePONPIrqDNX1_vzaPDEuypwGA>
    <xmx:1WALZssURqUa7l7c5yzcporktYvudhyYoh5YLxDTLp5v7aOUsMn65w>
    <xmx:1WALZvXNRv1tmrfw86BlglqzLDdzCMv4xcDqqvIOV0cNPN-fmCkj8g>
    <xmx:1WALZr_GQvNSA1GiLJe21nwRpPuveA_6DzylFKWbTK61J-FnDdCXPg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 21:35:14 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 3/9] platform/x86: asus-wmi: add support variant of TUF RGB
Date: Tue,  2 Apr 2024 14:34:47 +1300
Message-ID: <20240402013453.18205-4-luke@ljones.dev>
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

Adds support for a second TUF RGB wmi call that some versions of the TUF
laptop come with. Also adjusts existing support to select whichever is
available.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 14 ++++++++++----
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 7d7a9c8ee529..fa5735af7675 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -270,7 +270,7 @@ struct asus_wmi {
 	bool nv_dyn_boost_available;
 	bool nv_temp_tgt_available;
 
-	bool kbd_rgb_mode_available;
+	u32 kbd_rgb_dev;
 	bool kbd_rgb_state_available;
 
 	bool throttle_thermal_policy_available;
@@ -870,6 +870,7 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	u32 cmd, mode, r, g, b, speed;
 	int err;
 
@@ -906,7 +907,7 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
 		speed = 0xeb;
 	}
 
-	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
+	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, asus->kbd_rgb_dev,
 			cmd | (mode << 8) | (r << 16) | (g << 24), b | (speed << 8), NULL);
 	if (err)
 		return err;
@@ -1549,7 +1550,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 {
 	int rv = 0, num_rgb_groups = 0, led_val;
 
-	if (asus->kbd_rgb_mode_available)
+	if (asus->kbd_rgb_dev)
 		kbd_rgb_mode_groups[num_rgb_groups++] = &kbd_rgb_mode_group;
 	if (asus->kbd_rgb_state_available)
 		kbd_rgb_mode_groups[num_rgb_groups++] = &kbd_rgb_state_group;
@@ -4487,7 +4488,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
-	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->ppt_pl2_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL2_SPPT);
 	asus->ppt_pl1_spl_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL1_SPL);
@@ -4512,6 +4512,12 @@ static int asus_wmi_add(struct platform_device *pdev)
 		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX_VIVO;
 	}
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
+		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE;
+	} else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2)) {
+		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
+	}
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index b48b024dd844..3e9a01467c67 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -132,6 +132,7 @@
 
 /* TUF laptop RGB modes/colours */
 #define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
+#define ASUS_WMI_DEVID_TUF_RGB_MODE2	0x0010005A
 
 /* TUF laptop RGB power/state */
 #define ASUS_WMI_DEVID_TUF_RGB_STATE	0x00100057
-- 
2.44.0


