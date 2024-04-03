Return-Path: <linux-kernel+bounces-128875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F2896163
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642C41F28CDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED839FC0C;
	Wed,  3 Apr 2024 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="f9smeFMq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kId7om7H"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB6BA20;
	Wed,  3 Apr 2024 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104175; cv=none; b=eEnPcyOCZ4XdNoTMZQfq2B4FBdLgcnLqex4zUY92Om/rE2SgwsnyDw0Rck1eBTSAz0KPyLhQPMWyKrZeNB/8oSza1IK/mqaCRfA7j0pVTl9z8fRhzBe/N50Ba+z6OevZRP3sSbrJsYMRhifnbIZyAX4Il3X/sr0aXD3vIVyXatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104175; c=relaxed/simple;
	bh=GzuvuOvws/RzzTJJXSZCAEGLMvlQ71NBop7ZeG+pCF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmJXokcovK38VB3llqGsuIsOp4ZWqcZ9b4gonTIPC1+SppAivRgHTzrSiGxSZes06ooaS1Vg3kcm/TpFdlqORT1k1wpHb9m5mpEcbfPPqkXKR28n3rpORhDOz6nQehKl/RFpe8iRdHtKYLi42K9Kch5djzfBuqOXBYGkUEludb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=f9smeFMq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kId7om7H; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 68328114010D;
	Tue,  2 Apr 2024 20:29:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 02 Apr 2024 20:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712104173;
	 x=1712190573; bh=P5LXGlefIOM49fPBmsSM3dL394MZfKo71EIHeY4AXcs=; b=
	f9smeFMqzAFInwL/TVZCkvF88NRsXWhB3BUprSfpmMZDYqRTo4tp6GP74loHCVkj
	VWkA8NzQ2SDe7s/BJtPHyt3czjf3/Tk/n+fNnkZFzwzlj4xReN7qQxDHhIqy3uS9
	67k/W3td1McZSYtiGDjGsF8hjr8t5+2CRpqpWuFmoWpfC6QUP1RuVpFU5ICK9P9l
	1jA6WzO52rgBzGUI9n+QEuo7XOtvfSN5FmTPpluC2Y8dpNJ7wPD/wQpRwDghzMyp
	crwjPl3ggM2ZSrD9X5eGrcwY3PA8kWvmSPfYje7BS+GRZjx0RCvabDbQ3EIpvd9Q
	CjKrPUeS3kjNwI1+cL1GuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712104173; x=
	1712190573; bh=P5LXGlefIOM49fPBmsSM3dL394MZfKo71EIHeY4AXcs=; b=k
	Id7om7HUoklf3N3dTIcpcKtOIiMRdmSWCuEFJUShD9AAMVIHk5vaMJRrPq/9TNGq
	iHU7A5DcLMP4a3Sf4zFDVW0lGBTXy5HBPPXfbvlt16GMnujKQddg8FC0/fEkY74R
	evez/zLbMltlHA9d4iroD9xdGHlhxAmgw68EYjqTieNr9bDQq2CAHjCjPyafx7Gm
	e46jpyjhLaJZ/cLx7DS3PVglJr2qjab+GVOBPPwASHYCxczmjj9sbRG4gDU2TKwd
	4/yvjqIM458ice4tTA2wvIp79MrxKHo0UdeNH1S+O/2zlRD/n/BgKaj5V1ltVyHU
	idH83SAI0Vc9tvpNfkcwA==
X-ME-Sender: <xms:7aIMZtbk1MQnULhlVBIGcpCAnzs7_ALEDuLGffHE0JLeN5l0Ws6jqQ>
    <xme:7aIMZkbPe-WEXjM7mJjWN_mq5wL539jEt3ufarc1GZstrZEkzy1E203mS60gAqkvL
    0A9NNF6U9ya0U40x1w>
X-ME-Received: <xmr:7aIMZv982LH_MPZ4ytFo4d2p7QUjsGKb0bRL5N2qwnKRqIUHWsfDyaq6Cjk5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:7aIMZrq-cdsdijf271aChD8yIZa4kMHZ9ejriA__iM3JF0ZeEyXqWQ>
    <xmx:7aIMZooVhfzyCy_toFwcDVyktwsujgH_mGOy2mzQfirVsGTms5-4ug>
    <xmx:7aIMZhTEIh7Ai8fMg9_Qt3b20iycrFSTMAzslU9YnKbNKcPnmxtS9A>
    <xmx:7aIMZgoGBZ67tte23L317TiEV4PpaRsFQ1WO1ObMhL6TIu03a7mdfA>
    <xmx:7aIMZpcrPUBuISwWiFzDbQgao8sx_nqk698JwEU0Dsc4LE5SqmHP6WOZ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 20:29:30 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 2/9] platform/x86: asus-wmi: add support for Vivobook GPU MUX
Date: Wed,  3 Apr 2024 13:29:10 +1300
Message-ID: <20240403002917.2870959-3-luke@ljones.dev>
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

Add support for the Vivobook dgpu MUX available on the ASUS Viviobook
and some of the other ranges (Zen).

This MUX functions exactly the same as the existing ROG MUX support so
the existing functionality now detects which MUX is available and uses
that for control.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 22 +++++++++++++---------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 588c099103de..7d5990d16b2e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -270,7 +270,7 @@ struct asus_wmi {
 	bool egpu_enable_available;
 	bool egpu_connect_available;
 	bool dgpu_disable_available;
-	bool gpu_mux_mode_available;
+	u32 gpu_mux_dev;
 
 	/* Tunables provided by ASUS for gaming laptops */
 	bool ppt_pl2_sppt_available;
@@ -693,8 +693,8 @@ static ssize_t dgpu_disable_store(struct device *dev,
 	if (disable > 1)
 		return -EINVAL;
 
-	if (asus->gpu_mux_mode_available) {
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+	if (asus->gpu_mux_dev) {
+		result = asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
 		if (result < 0)
 			/* An error here may signal greater failure of GPU handling */
 			return result;
@@ -759,8 +759,8 @@ static ssize_t egpu_enable_store(struct device *dev,
 		return err;
 	}
 
-	if (asus->gpu_mux_mode_available) {
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+	if (asus->gpu_mux_dev) {
+		result = asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
 		if (result < 0) {
 			/* An error here may signal greater failure of GPU handling */
 			pr_warn("Failed to get gpu mux status: %d\n", result);
@@ -813,7 +813,7 @@ static ssize_t gpu_mux_mode_show(struct device *dev,
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result;
 
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+	result = asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
 	if (result < 0)
 		return result;
 
@@ -859,7 +859,7 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
 		}
 	}
 
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
+	err = asus_wmi_set_devstate(asus->gpu_mux_dev, optimus, &result);
 	if (err) {
 		dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
 		return err;
@@ -4237,7 +4237,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
 	else if (attr == &dev_attr_gpu_mux_mode.attr)
-		ok = asus->gpu_mux_mode_available;
+		ok = asus->gpu_mux_dev != 0;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -4503,7 +4503,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
-	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
 	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->ppt_pl2_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL2_SPPT);
@@ -4522,6 +4521,11 @@ static int asus_wmi_add(struct platform_device *pdev)
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


