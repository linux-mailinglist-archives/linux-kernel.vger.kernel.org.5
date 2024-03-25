Return-Path: <linux-kernel+bounces-116562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456B8889FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD4ABA3576
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0653D161932;
	Mon, 25 Mar 2024 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="a+lvbqni";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xuu7FC5q"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E1148828;
	Mon, 25 Mar 2024 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345819; cv=none; b=oLgACZlK4HbR/fklvVLha1uDSvFslyKKTpo5tkyh20Sdfly3R6tsmwMvIv/C8ePJBqKxBMo6lzz7gZc9QjQCOiBzeeWDRpAxLvUGWJh0APL1N17rx/N0tC+ET6HrI9p+kLK7OaeNy012XPbuBMc501yAL/+EF+K6pvTzwIgMcpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345819; c=relaxed/simple;
	bh=KwpUxPjB+e9aDlWPffbROPh7AUKzoxmOitBiQ1q996A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTYtTueVsmBGG7ppb8SEtDmNsHaaXJ9/W8A+C9kAngMk5q3DdUSkKwTSIlr3/+JQrr9zJajIHe+X/ZcOIT/Wp4Yhb6g9Wt5M8wo+SratDVGtgkamFkPdB5vzSPeMoTuSVS/9E14ToJkNalSj6F1SMRh7LxLfoY3JaLrm0+fkgjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=a+lvbqni; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xuu7FC5q; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BD3891140099;
	Mon, 25 Mar 2024 01:50:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 01:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711345816; x=
	1711432216; bh=D9UhyeGa8+IY4DzspNpO/uLthQOKl8Mdkma1pmolh1A=; b=a
	+lvbqnijnzt/PYFGc4lQcEoQi0hQqWSW+SzoYXVYFpLQGTGr+RTmXJxPMqS9yyGn
	cucvMvVJMlKoJmT3sRMaqgoAMDoNsKtCIsPGJzt4gcMaYUILj5Wn/HSmEjt7sbEH
	sPUNle6MFxVoINOQiTzb4H61Fzfz+jo2vQrHW+W8IJZ/i9CGlw/xNfNz0SIFvmmM
	RdwERCK+t9DV4LVILcfO3EtCE6jM+mBEfECDds/5m2PpHheHDt/1iRWiV2vjp1Yy
	ayaEVo0FFeKlBfqjlkxED2QiZMAviRfODtlSzbAFJ6IlbbvCnRCatWeYmJVsr7Wy
	d8m7KA8bIyZdz/YKJ5trw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711345816; x=
	1711432216; bh=D9UhyeGa8+IY4DzspNpO/uLthQOKl8Mdkma1pmolh1A=; b=x
	uu7FC5qvCxRcCR9QQeeK/mzNjP2sOUObQ1JdsIDwNiv+1aAsWZUhqgGEmquDVKtX
	vlh9BVL9fuTmEemqXqs36I8y/MYlsExQtiZ1mNHM0MExMbVJ6WdOHiosDXWkjJjY
	D2Fa6BObHL+z99E8mK9R+4r4f4/GW85OEKK0LltM3ftt4fC9m0zgiZ3QXU5gi+qP
	Qd2jIugEU7RrYamCFFIEl394bsUqoDevAPkUqybT5Rj/hpwf6MZkqwqgcRPxJKky
	N5jUGS9IV9/lNXVT9RrnsDBDd2d/D4MLbGjqdkvHmeZRvN7OBSDid6nLR6QQQNgr
	jP39EqbYaHzSEItlEbDyA==
X-ME-Sender: <xms:mBABZl7Hpqw6rPnlYfz-rdirb21gtWOXHBbd25Q8gKjGLWchTq5BzA>
    <xme:mBABZi5zv_COEZT0d8E9Kvd3GwkaH_SFxHlcyTqx8OB6snY9aEPf8lC9nEYK1pnmk
    nG-rzkoeBtn-PDpaF4>
X-ME-Received: <xmr:mBABZse2x4z1O9XUQ-9_bHFANY04Thr55YBXsjm_7cp9e9CBNHqcTJzDT-8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:mBABZuIIl7XA2xAQpM7JnjJBazSId11-8Y9zYUYhWm92-z5DTdSf-A>
    <xmx:mBABZpKY5WsuMa2eV-BUJ5uBLYVgeWtRs5MNxzTdE6uzy2GbiYFpvQ>
    <xmx:mBABZny-U_uv4KR477qqwQvFOoVQTTdOBTINtcuVRyY_Drestk3NHg>
    <xmx:mBABZlIUudRIQZBCAEzZYU9kUcZuKxQ2--c5PvPFb3ZBcz1dvDJv4Q>
    <xmx:mBABZh_A7GVyKGYSzj256h3ZPfnPZKvSa5CjMCUEhffYVyq7uCrYGw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 01:50:13 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 3/9] platform/x86: asus-wmi: add support variant of TUF RGB
Date: Mon, 25 Mar 2024 18:49:32 +1300
Message-ID: <20240325054938.489732-4-luke@ljones.dev>
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

Adds support for a second TUF RGB wmi call that some versions of the TUF
laptop come with. Also adjusts existing support to select whichever is
available.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 13 +++++++++++--
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 285821ef819b..094a93f24667 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -280,6 +280,7 @@ struct asus_wmi {
 	bool nv_temp_tgt_available;
 
 	bool kbd_rgb_mode_available;
+	u32 kbd_rgb_dev;
 	bool kbd_rgb_state_available;
 
 	bool throttle_thermal_policy_available;
@@ -870,6 +871,7 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	u32 cmd, mode, r, g, b, speed;
 	int err;
 
@@ -906,7 +908,7 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
 		speed = 0xeb;
 	}
 
-	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
+	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, asus->kbd_rgb_dev,
 			cmd | (mode << 8) | (r << 16) | (g << 24), b | (speed << 8), NULL);
 	if (err)
 		return err;
@@ -4539,7 +4541,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
-	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->ppt_pl2_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL2_SPPT);
 	asus->ppt_pl1_spl_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL1_SPL);
@@ -4568,6 +4569,14 @@ static int asus_wmi_add(struct platform_device *pdev)
 		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX_VIVO;
 	}
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
+		asus->kbd_rgb_mode_available = true;
+		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE;
+	} else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2)) {
+		asus->kbd_rgb_mode_available = true;
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


