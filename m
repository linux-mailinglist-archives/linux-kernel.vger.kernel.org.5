Return-Path: <linux-kernel+bounces-127296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B6389495A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11ED1F23451
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D9414A99;
	Tue,  2 Apr 2024 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="bDG3MInv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nC7FM6pX"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4D14003;
	Tue,  2 Apr 2024 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024789; cv=none; b=I/xaQ1beifhD5wf4c3EbZKIDQPKQSz6oSaOsC2yadU+cUbKewx6MT9cP8XLCpjiSVTFqYnYaJSMcta+a8MyL1Ln59QYQMY82iMqQSvX6KYAop0lyjqEaEx834UWTwtosjgpl47N5v5TGzyKamNCCEKT07LAtqB0HLBVjeBqftm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024789; c=relaxed/simple;
	bh=Yx+3WmSsz+NPr8WZNCY2nTQdyVHc18JH0+8Yquj71ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDk6JJdyr5CYtAi+aJKlbaQ7HQDtF+/RYRjEVt2NMm8oGDDLSlBMgdTp4G4x6wLZJXTL2KGjeCtjZEEFzcVOhUaXiqwQJgR1Ja80omZ2S85scLRCS7z4i2XF+B/AlQ2M7/Ree6JI/aYGB8QQeSs8rJU+pqc/1nfeCO2pFnb2yqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=bDG3MInv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nC7FM6pX; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id F0AFC1C000D0;
	Mon,  1 Apr 2024 22:26:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 01 Apr 2024 22:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712024785; x=
	1712111185; bh=erdmGTaD3HvDZKlB15DdC5j7W9Wro6lcol+amycaFKI=; b=b
	DG3MInvtcx7G5L8hjCI2jJTA6d2zLl1eAZyevCqxFZ7omZf9UQwmPAlE+X0x7oOW
	kS5dl9VAF0ZdspmCagGz8XOkMbPtB9QJCyf5oluFvmf6fKgs7Hl7G8gVw1PVtj0Z
	YCl6X5SBwEL9N/uDvtqw1tpeSmEQNi7H+nIoaFR25UpxGtTA8ouBk2CvBfcCaqLu
	SeD625/MmS40+aODQAeUuraNh2BkzDORhZDLxjyZ14Iunaj651sLUssJsh6EFO+9
	XYceAYne9t+dawx5PWov/Sz+wYzokXcZ0zHpKkqh0H3MORENlIWGoFkgzrjKmnce
	Rq/Y6gouhEbnqs1RPC0BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712024785; x=
	1712111185; bh=erdmGTaD3HvDZKlB15DdC5j7W9Wro6lcol+amycaFKI=; b=n
	C7FM6pX5HYcxLplsISXjB8M9ThSqLaBlzw+Xx+cvbcJBSEmuQpROKA1Vz4ICALox
	mWuccOERtI6ei04YhyBAP4JT3KIYgutkeS8ctRMWR+2s9ECW+zSIoSeXtgQBHi8J
	l6xzmHgaAzsUS8JpydLEp/VuoaYIJj15ny7N/MqeFPNH1pQeyBaFlsWYkZ2h5TZs
	rnU4uvFDH3r8rii26VDOENhTWAZDUkkmdaRnKa1vFOoNnqbsFMppWB9DY2smqLme
	4zVntqDbgCjFQe4XCcrmRfHsneZEdPcoV8ycE0M/aU5bd0eAMM2WR0qw8WCy1NZY
	aOTERxljU1XKa7bQL9veg==
X-ME-Sender: <xms:0WwLZvrYA8urmgZE6bqMFfev5NskvV_7i2_iFoPR_mnFaxg7FlHu9A>
    <xme:0WwLZpoaAgDPNWjYvMlv3gne85MWRbxh_98mKGKt8bDHjmi9FgDh42WV80cFltWxQ
    bq0UBcORNZINhQB1KE>
X-ME-Received: <xmr:0WwLZsMHJO44hNdbFkVdTPAPcBnCBQOSysLZaz_uKrHLzq5DUFdtueC6ZeQm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:0WwLZi7s90o6GnM-KmD_PNIk4aPN8DJ6hddTbqFSe1WzaU_RvWLf_g>
    <xmx:0WwLZu6nbITrOhpm5J5dFSZEZ_EWvtKe6XK9C9psIggTK56IaQ8iZQ>
    <xmx:0WwLZqjwcbWQ_Ku4WoAYfr-NNl7IeFlo2y2OCEwUaDudMpdzxay_VQ>
    <xmx:0WwLZg75N514Ys-k4FucrYSA6qwoR-QL-N7IclVw6fAIQeMo1uAimQ>
    <xmx:0WwLZrtwYVBWtjx4x8QU-ckOkTzkOKE-z0SUK-DeW7JKrp2QuAACB8rxWDc>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 22:26:22 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 2/9] platform/x86: asus-wmi: add support for Vivobook GPU MUX
Date: Tue,  2 Apr 2024 15:26:00 +1300
Message-ID: <20240402022607.34625-3-luke@ljones.dev>
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

Add support for the Vivobook dgpu MUX available on the ASUS Viviobook
and some of the other ranges (Zen).

This MUX functions exactly the same as the existing ROG MUX support so
the existing functionality now detects which MUX is available and uses
that for control.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 22 +++++++++++++---------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 2330f02ff76f..797531300138 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -259,7 +259,7 @@ struct asus_wmi {
 	bool egpu_enable_available;
 	bool egpu_connect_available;
 	bool dgpu_disable_available;
-	bool gpu_mux_mode_available;
+	u32 gpu_mux_dev;
 
 	/* Tunables provided by ASUS for gaming laptops */
 	bool ppt_pl2_sppt_available;
@@ -682,8 +682,8 @@ static ssize_t dgpu_disable_store(struct device *dev,
 	if (disable > 1)
 		return -EINVAL;
 
-	if (asus->gpu_mux_mode_available) {
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+	if (asus->gpu_mux_dev) {
+		result = asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
 		if (result < 0)
 			/* An error here may signal greater failure of GPU handling */
 			return result;
@@ -748,8 +748,8 @@ static ssize_t egpu_enable_store(struct device *dev,
 		return err;
 	}
 
-	if (asus->gpu_mux_mode_available) {
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+	if (asus->gpu_mux_dev) {
+		result = asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
 		if (result < 0) {
 			/* An error here may signal greater failure of GPU handling */
 			pr_warn("Failed to get gpu mux status: %d\n", result);
@@ -802,7 +802,7 @@ static ssize_t gpu_mux_mode_show(struct device *dev,
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result;
 
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+	result = asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
 	if (result < 0)
 		return result;
 
@@ -848,7 +848,7 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
 		}
 	}
 
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
+	err = asus_wmi_set_devstate(asus->gpu_mux_dev, optimus, &result);
 	if (err) {
 		dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
 		return err;
@@ -4221,7 +4221,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_gpu_mux_mode.attr)
-		ok = asus->gpu_mux_mode_available;
+		ok = asus->gpu_mux_dev != 0;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -4487,7 +4487,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
-	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
 	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->ppt_pl2_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL2_SPPT);
@@ -4506,6 +4505,11 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE2))
 		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE2;
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX))
+		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX;
+	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX_VIVO))
+		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX_VIVO;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 9cadce10ad9a..b48b024dd844 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -128,6 +128,7 @@
 
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
 #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
+#define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026
 
 /* TUF laptop RGB modes/colours */
 #define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
-- 
2.44.0


