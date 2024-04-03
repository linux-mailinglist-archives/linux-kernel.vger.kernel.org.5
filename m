Return-Path: <linux-kernel+bounces-128876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F201C896165
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2011E1C22D17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291FD168DE;
	Wed,  3 Apr 2024 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="DoWkP3SD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ReAvqCzh"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD6610940;
	Wed,  3 Apr 2024 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104179; cv=none; b=jfXua4o1CvHLFnVbU46gR0FKCwV1FcO5Xaxaww/aqTR4KPIWcsf/jawUMkYU4HS2aIdPujhpabUUFoamTpxBNuSe5crIYbV4sps6JUg6qhLKTjBCe2YdJ3cpVYOUwKTvpblUUX5wlrAYns0vXuayoxkSIe8t+ohuiSIO8p0uUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104179; c=relaxed/simple;
	bh=QyAaEvEWvdwGHJ6mey1nMDjh83cdeCXThJC2zX5mkmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4pSQcyaW1m6TaPycsGae1Y7JyZWedARhn5WV+DzVdPacXdWQ3YczNx0nfw0/GQCMe9c4oSTaqX4xX/A1inOl38BTPJi6jJvS4ILA1HSzuBT54cNPMO2DSIhRzxFdkh4G81ASOCYECYZEcoWcAeH+xZr4rApBoGaegORzeUrpWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=DoWkP3SD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ReAvqCzh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2532B13800CF;
	Tue,  2 Apr 2024 20:29:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Apr 2024 20:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712104176;
	 x=1712190576; bh=2fj3thS8y4SJzaCc3D6wE/ySSWe0qGjNLMn7kw6VApU=; b=
	DoWkP3SDqL5ubw6pnMKmVLx+IZo2EIHAkqcBXmlR+u3pK6KDZ6Vl8kD0b3/fqvz7
	rpeLMLZktPoVsbhmvVyOyGEPcVFuMr0I/nu5Od/cCOWDK5oO9T2pac50SiYb645p
	60PDAsZA+Np4J4g0bf1M4awxrLISKTAlrJU6iWLJKGA+HptmGoQsefGkXUUgEfhr
	dQJ3ZKc9Jzxa+jnxKUsS+r3UvR/e5fdBUgcB79m8oBSiXZYPOXWK8s/xCLGXfhCW
	5fZ9K9qQrSUQjI5K6OfVNpf45NA/a8gqo+ktfYcmoW+4W5SfGbZd1sPTfFhsVHct
	fItt86zXZ9t+JXUAqIyKfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712104176; x=
	1712190576; bh=2fj3thS8y4SJzaCc3D6wE/ySSWe0qGjNLMn7kw6VApU=; b=R
	eAvqCzhoNKba8avusTI0LuQyOd57diycYuae7Xchsh1wMICKvAY4cCGM78xleoFg
	cqSTC7sKfYE+VCUCO6rLFEOLBZwKRoinNtCLMeBt2F6qe9LJCNhYgJ2/C/l+LXEd
	bu46A64EtI0WfXdfNZTz1QNJ2Ksx7cUL6hk0oP47qViWUDdUwCFd4k01/FVAgA6K
	59MjX93+BTI8/qKB2yF8mnJZvUmDOdIxMk0YRiortnfZVkjZhZ3eeYe4bp4c3LLR
	0jeSnZxsO7hDSFwqQIH8iR51F/bVmIOtFvwAmLD4SPg2sGcOvQVulqHWOJgNNqHx
	7cr+OUr9ATMljbCRlEAGQ==
X-ME-Sender: <xms:76IMZshpJvkJvcwRv9DBtxQ6FD6fQtZgVEHFWLn6n218H6v9iiH58g>
    <xme:76IMZlDWutS6GDdSTt1DcQj0HcLziG7ZrDX_yi2cBXyLIW-3T4Lrev00t2pTB5CJj
    tkiMbdNpgEFa1Z_FO8>
X-ME-Received: <xmr:76IMZkF4OVnOAatdXTGrnvglcuHSPvEMvq5FglJiXMBrQgTYol1_xPMw3ISi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:76IMZtQFUh4WkVoDF1ncvPEKTiZxXmYBTFFwGhqsikYX23uxl5dpfw>
    <xmx:76IMZpy33A3_mU1kAzF0qYCjkOZrmG_Vy4gQ6-TmRzucZpHHHzUMAQ>
    <xmx:76IMZr7xpkC_3U8GmSA8j5I842rfhEN-x5f7yuuw45aN57ivOkuBcQ>
    <xmx:76IMZmwzC5Zz-wX3fyRz8Yuo9FqtebXzeL5T4EzQ8axsyY4yFNdTyw>
    <xmx:8KIMZgnRoSljSu_2W5Xw1KfzgRd-o3JZgVQNlgDy1q5uztRFEuTSiBjI>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 20:29:33 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 3/9] platform/x86: asus-wmi: add support variant of TUF RGB
Date: Wed,  3 Apr 2024 13:29:11 +1300
Message-ID: <20240403002917.2870959-4-luke@ljones.dev>
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

Adds support for a second TUF RGB wmi call that some versions of the TUF
laptop come with. Also adjusts existing support to select whichever is
available.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 13 +++++++++----
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 7d5990d16b2e..b6a8b4eefdb3 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -281,7 +281,7 @@ struct asus_wmi {
 	bool nv_dyn_boost_available;
 	bool nv_temp_tgt_available;
 
-	bool kbd_rgb_mode_available;
+	u32 kbd_rgb_dev;
 	bool kbd_rgb_state_available;
 
 	bool throttle_thermal_policy_available;
@@ -881,6 +881,7 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	u32 cmd, mode, r, g, b, speed;
 	int err;
 
@@ -917,7 +918,7 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
 		speed = 0xeb;
 	}
 
-	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
+	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, asus->kbd_rgb_dev,
 			cmd | (mode << 8) | (r << 16) | (g << 24), b | (speed << 8), NULL);
 	if (err)
 		return err;
@@ -1560,7 +1561,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 {
 	int rv = 0, num_rgb_groups = 0, led_val;
 
-	if (asus->kbd_rgb_mode_available)
+	if (asus->kbd_rgb_dev)
 		kbd_rgb_mode_groups[num_rgb_groups++] = &kbd_rgb_mode_group;
 	if (asus->kbd_rgb_state_available)
 		kbd_rgb_mode_groups[num_rgb_groups++] = &kbd_rgb_state_group;
@@ -4503,7 +4504,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
-	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->ppt_pl2_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL2_SPPT);
 	asus->ppt_pl1_spl_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL1_SPL);
@@ -4526,6 +4526,11 @@ static int asus_wmi_add(struct platform_device *pdev)
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


