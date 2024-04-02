Return-Path: <linux-kernel+bounces-127297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8F289495C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E971C23B2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B29F9EC;
	Tue,  2 Apr 2024 02:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="pKbxvHiA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sTrQVriB"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2467014F61;
	Tue,  2 Apr 2024 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024792; cv=none; b=LNBC8uGy2cY2YEzfAxIYeLslmmQToDc57th4gMV1KTD84kD5opml9gZ0l64dKH7K8HTDs9nhCxFHsmqMOY8d/lrVSCjR6+LaecRO6bHrM2hNXn+yee5wiZ6r1mDOxibxOYw4HjJm/0qQ5Z53KZ4sN0XMANEarqIolYk0E5U7sZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024792; c=relaxed/simple;
	bh=XrDifZLBnt4fCjvKUzd9ltht3O/1IZaK2plN2UfMYnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVsqEdaFHv05P0yvW6oZAsT0rFmwTwrCjdWSBnpGLr/vRoTvDsAWW3Vi30QcSqWSaSP0tjNGsAR2Pvs+r3vls4TpHbTgIHPXurHZCaq91MUD3LdxJkr1kb2t8qD/L/mfM0LdVHU9AvQUTiJtbIKLd184ZS1F0oxp19UsCPs5jpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=pKbxvHiA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sTrQVriB; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0352218000D8;
	Mon,  1 Apr 2024 22:26:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 01 Apr 2024 22:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712024789; x=
	1712111189; bh=xGYXj3+OYpZ/y0v09IWuHlu1qJrw9PujBX8roj5cEGs=; b=p
	KbxvHiA/dJd22WzuhQOZ7TVmuD+TnBMr21QqmBYyoH8WNfNS2K5cPqZtvftTsZzn
	jUZ6Lc1oEsX/Yo1s6Ngd8z8Ej3MZGfRW/cUBNP8kYGUcwsfuPNY37vfzaQOz4IBf
	I3JJMbOskN6TKuoy4psHKEJ60t87kzfWCRNhezPJibXiC09m+t0fQOGHhi/FGgcY
	p55FfTkgHjE/6vs+/yQqI0IYIhEW+M0pLQUBsHApyxfgAyam1XE8BxbnujO6RPHe
	jeMx8jwGhEHZJHyz7j9njuvkj4QnJZK58JgW5XUQwXoxstjps1f90rPFRnCnMcO/
	ZVUlkKcHlIMaRja4ZiQJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712024789; x=
	1712111189; bh=xGYXj3+OYpZ/y0v09IWuHlu1qJrw9PujBX8roj5cEGs=; b=s
	TrQVriBCu/Ob/99ijq0EQlqzdwSRhi/SPfnRgwr7ZogGaKAOldQVKwcIewfxGzuL
	6Z9B6wKbJt15FRRpvD8Y19oJqOtMM2qgx1xfAajIvUVdOvP1lhhShPZGyS0DigqC
	f5Xn/YHICAGIxyK1gWBlq1M6U+/WmpxUQf8OjE6eYuNljfrtbG8wY/QZEhtTEVC6
	MhK2+vCCFpJ+qYOzg63QsTeStwdpBdZCnxt0zds785aHez8DTSXEg3D2o5lPion6
	dGzI+Qit2Maufo/VbE7k4DP/ic1y+wF3gFHA5S5WHDxrjbPZNZrebrb/KHiXnUzH
	1vJCoEHHkfC/FeakWYdGA==
X-ME-Sender: <xms:1WwLZoyoCx3oG0f94V-3J_4a3IQHwgX7m3OARfKud7boILz64uMWYg>
    <xme:1WwLZsSnaug5kXw85CiBRFmv2G42l9jegq3p3ofuXDhMcs4RotnJmUCto5ky1irDN
    cQWWmDBqjrWTN_LhXs>
X-ME-Received: <xmr:1WwLZqXeM2ArGN41CwT75ZytXELK3yjOzOfWyXT6qBh0dj6qve2iR7UvrFK6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:1WwLZmh2HSv15r-_8KMp6LFveKnbnKyLPnLe0qJt8tWF09Zd5MZTmg>
    <xmx:1WwLZqCeEGjhS4BkhGdMhBxDPa_FYkyF10IdsysHJNeRFNV_lL2ryQ>
    <xmx:1WwLZnLm_blzcV7s76PQvoEUfDuVlIquy261_favPIUDKp0WQ2O4tg>
    <xmx:1WwLZhAc2w2FE3JS1oqwDi2qA4claf5W5Szn2VlkBnt4K9SPff0aXw>
    <xmx:1WwLZs1IJAK-fjlxKvLu0YlQ_Xcj77GZ8hPfQVloopFzCsoeD5P60RMtJVU>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 22:26:26 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 3/9] platform/x86: asus-wmi: add support variant of TUF RGB
Date: Tue,  2 Apr 2024 15:26:01 +1300
Message-ID: <20240402022607.34625-4-luke@ljones.dev>
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

Adds support for a second TUF RGB wmi call that some versions of the TUF
laptop come with. Also adjusts existing support to select whichever is
available.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 13 +++++++++----
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 797531300138..b5bd42e5f4ef 100644
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
@@ -4510,6 +4510,11 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX_VIVO))
 		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX_VIVO;
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE))
+		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE;
+	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
+		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
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


