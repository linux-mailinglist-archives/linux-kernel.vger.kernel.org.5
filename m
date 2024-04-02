Return-Path: <linux-kernel+bounces-127251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD18A8948C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E012E1C220C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A885BD27E;
	Tue,  2 Apr 2024 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="TL6aR5T5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jxjJRl7l"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C7DF5C;
	Tue,  2 Apr 2024 01:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021716; cv=none; b=HN2sIII+aaNZlbgt9W3j8HQAXPjKq/WJmJ04BCqVeX9o826Sy25ric0zNaINDZuuBfqKUu3ATdRWYKqVsg/0v79eNJJg+kvwzGH3SBo+gjN4abnFQi+H6OZDVygDkW7zZhXWn1gqZDDyMOgri5qUp+2QXEfz9vQJsJQJoF8dpzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021716; c=relaxed/simple;
	bh=GZWEVn8G/uQMwOWqYVr7CTuehidwQQATMJGfjS7zqxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYnHkeoIvG+w29mlfN5BpkRfk70ngSH/V0lzOr6sh6T2+KzFGD6HZsEK1eA+o3tK79jMY2I24/uAGOTY8NphQdzevyGgnqp7D6WKSQxhwRIYF0WijOhs5Dwgr5bGRCeQ5YXofr1noAqRkyYueX9FJUk7fxlVAUW5dhOeLcqA1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=TL6aR5T5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jxjJRl7l; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 03B4C18000D8;
	Mon,  1 Apr 2024 21:35:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 01 Apr 2024 21:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712021712; x=
	1712108112; bh=AVkTFXHHLbT1e2e17mF5uzhsB1HTTSXhK3RoWMmKN4E=; b=T
	L6aR5T5YnlG5vjI6YRsciXOURmKmOVFXVJwZ+ykf5RxGQ0i+j+uBdr6Ccr6YsjlZ
	BEbMvgEL1UvagMBx39nLqMrCimEnDpsBiFWhiuj7KTa9JNoR5McP51cXWPADr9Ep
	SsqjTe908OU945I4SBVnKAvi9CRU1vVXFU+zhVFtTzcPGSJ3JKXDzmYovFd6pGkr
	S1pd0mPWubzoRMtQM2EMlPhpgc/ij0ogUJyxGtueHWdmlf5j6yp2AELERtZ0qAnl
	TSKvV7ec+a5xWBq5EvZV9Do/PeeH5ZLTHwEXifDPos7HfjyBufrVi33m4mxh6BnU
	yCyw+DZRwvDwA+J70MB+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712021712; x=
	1712108112; bh=AVkTFXHHLbT1e2e17mF5uzhsB1HTTSXhK3RoWMmKN4E=; b=j
	xjJRl7lBItyK/Ph9eZDceJFWf+e4ql/cMAhZa5g7on3FI9slJGmNCHZ2H3b0hxgO
	TECgyfy83Fj4wD+Q2jvYDOVU+gKkvUgGMqJQe+sBDvSEIGPdP419eRWd803Ws8pp
	v/lPm59VEoyVEN5czLop+ODQgt7zfRwFMsX14kh8UZ2YKEwUOilh2jZGkMniJeUE
	vt5LgeqmMTsWie+x8oFaSHE+ZdTh2A9vAdTm0Qnv8qn7TgrCUz5zJWYpfsnZPORi
	Q/2zcs3OadIuWTtlUfvD8l64AKckYq74ll1HOeW4sjsOzpD8mTSdHhefEsUzkXA+
	PODI44OUlRzmJX6ibo9sw==
X-ME-Sender: <xms:0GALZsvcjwWFJOzkIVJ2IgoXZtOgmELhryXq3Nnz4s1qX4BU0SAJLQ>
    <xme:0GALZpeAuXuPhle_akB95FJWCOjsTidmB7bcKH8GRSGVJ65zxwMKkrrQ8PUo4_Hzg
    X4evA9weeG6OckjlMQ>
X-ME-Received: <xmr:0GALZnzCF8zFwJgCR7cDzilA1xct0WcNXK3OnXvB2Mo2UmoFAbv_60YmK2qk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:0GALZvOiDFYNMgVe8kYOag5wbjoQSFAsEkwULC1rLHZighmYIgXKXg>
    <xmx:0GALZs93DyxNQLKsykmVyIo9CI8lzHavOx2-MPwlqV9wUvoixmz5kQ>
    <xmx:0GALZnWZ9B1J7-mme74a6cAZl4VRtrE_okKdCVdBdzEn1sUDz_ZNwg>
    <xmx:0GALZlcGfuM3fgLOKbZN77C386UoHDamO42YdvK7UmFWeL98mdDB7g>
    <xmx:0GALZswKqmDao0GF5iHZ7fT38CtgT0TGd0fugoZ530XTQ7-E9odFhul8-gE>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 21:35:09 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 2/9] platform/x86: asus-wmi: add support for Vivobook GPU MUX
Date: Tue,  2 Apr 2024 14:34:46 +1300
Message-ID: <20240402013453.18205-3-luke@ljones.dev>
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

Add support for the Vivobook dgpu MUX available on the ASUS Viviobook
and some of the other ranges (Zen).

This MUX functions exactly the same as the existing ROG MUX support so
the existing functionality now detects which MUX is available and uses
that for control.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 23 +++++++++++++---------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 646f70c65097..7d7a9c8ee529 100644
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
@@ -4507,6 +4506,12 @@ static int asus_wmi_add(struct platform_device *pdev)
 		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE2;
 	}
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX)) {
+		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX;
+	} else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX_VIVO)) {
+		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX_VIVO;
+	}
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


