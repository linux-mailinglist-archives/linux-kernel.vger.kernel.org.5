Return-Path: <linux-kernel+bounces-98127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B4877573
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5687B2190E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D3611187;
	Sun, 10 Mar 2024 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="MQ6CGgKU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OaEHpFM+"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2282317550;
	Sun, 10 Mar 2024 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710049526; cv=none; b=VhS7+Dqw43slnDH94b/nxsvb1UVBP3ZRvbKAM9uWe1JQCCEUGr0r022H/LfoEtZLNYsW+gQExNz8aXN3YXqT+z2jlFFwK4be8Tvsl3woIFxO27YNs5so0w8q4ouuaRaoRKt3qae9G0YjL13dqhNwtMK0CFoa33qDpiYBt45yn6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710049526; c=relaxed/simple;
	bh=jM3W7oyEIGZtvFbs0jdRxwqTdVYD5+zHO6IbTe7uYSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfNcec8v7pP+n/b/FcoO5Ntc1lVzW7ncGAHU3X2dE5qci5veNHLeVxfqz7Us1w+VoGFyuQobHMT6QBbH4srF7rriKecyhgQAxgTJJ13HCs3gVLxp0TRFR/78pp3SRwkNkX4EPkaXSzSxmXilhp4GXbtkWvRFP4msRdHNb28gR/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=MQ6CGgKU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OaEHpFM+; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id D79B61C0007B;
	Sun, 10 Mar 2024 00:45:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 10 Mar 2024 00:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1710049523; x=
	1710135923; bh=iNGEngSWEAntTRUMP+C0LJTifEPw1RuXRNqGR65xM2Y=; b=M
	Q6CGgKUGkP28h+cHiHuyl7ZHU537mIHN+vzGDWnfkcdwxkPdJXHmC0UP2ogklwl4
	PPGcAfqWhof6HWuDduUuj/zUcKFoLtCjk1d7TJdbkmk4/Y5uDKRriAQWK2Mmjywx
	Xat7l/ncS0o0U34Z0vG5XqIf/yEay+jBL/76uw2cns75xvk8OM22rbPr+NBjm7XJ
	7TtaMGI982jsy60H4suquXwTFGRNijXOZbSjH9LQQrclazQXX6zFc2wIz5PTBSa2
	4x/Hrjr8DyPhuu0wj/LV4JMK0u/v+82oUpFJVbX0fAWo5sYUyMdIQ2XTHCf3tcin
	KZnq77U4gz8grqwfmf8dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710049523; x=
	1710135923; bh=iNGEngSWEAntTRUMP+C0LJTifEPw1RuXRNqGR65xM2Y=; b=O
	aEHpFM+qewq0heKD2JJcmE5eXcAgDG7HqBhHYYYVPoFkg5cFN5koFih29eUfOyYL
	d5TJXUZuuabiewkNsp8m/6z56QMxRYVlO+KmskzJNehnw5W6zfTlvfhVy8/dOCUy
	I/5nsyB1liBG7QDYLwltbifYQ3kCT2wnddoY9Iyduvps96p3bKCReD9jTABWfVT2
	IS1ApJZht9vKUbKFg15n9Cr5GsA3qs/7RMqadp2PbItKp02j11snCBxyuwaK7glf
	SRzxJ2dGD2H2PKMFz0UMNlmGbc6AFT5pN8M4s60jSsLikokEblOR/jtATqbBkbBc
	Xg2ZKwQjnJ/TFOYSChaKQ==
X-ME-Sender: <xms:8kjtZX5Avnm48PFNwiceh2wIkRdu8AW0VoFWv-0Uv75tEOQRsC8MDg>
    <xme:8kjtZc7FEMQHcnd3oPC_-iLiEXvpOQVBomVEllEpJLTGA1SgO5giL_Jkwfn5v8kxj
    faXBMl-KTAjhe-mBVc>
X-ME-Received: <xmr:8kjtZeekI4J-bZLwp19gzQNeG8s7iVzWTbcJhuwXtkJ5IuSQYr17GquZaDL5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieekgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:8kjtZYIsLAtBguOowU7sqa5xj8-6U1Ftq27qrQAy23XieUvl6rTh6g>
    <xmx:8kjtZbKD53HbjFGb2xcYP2XiK2xt_Cp_492pkzImbGd9VkrhNst7uA>
    <xmx:8kjtZRyb48TldilTrVW8UA615XSz1JmdQHzuDdCNo0xviMDW3lffQw>
    <xmx:80jtZYGvWFEJwFSHNbAv_T-4I2eMds54gYHriMSfAcoesNCXNGf-Doq4AHA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 00:45:20 -0500 (EST)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 1/1] platform/x86: asus-wmi: add support for Vivobook GPU MUX
Date: Sun, 10 Mar 2024 18:45:08 +1300
Message-ID: <20240310054508.8528-2-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240310054508.8528-1-luke@ljones.dev>
References: <20240310054508.8528-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust existing MUX support to select whichever MUX support is available
so that ASUS Vivobook MUX can also be used if detected.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 18 +++++++++++++-----
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 94cc589607b3..2cf695289655 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -268,6 +268,7 @@ struct asus_wmi {
 	bool egpu_connect_available;
 	bool dgpu_disable_available;
 	bool gpu_mux_mode_available;
+	u32 gpu_mux_dev;
 
 	/* Tunables provided by ASUS for gaming laptops */
 	bool ppt_pl2_sppt_available;
@@ -682,7 +683,7 @@ static ssize_t dgpu_disable_store(struct device *dev,
 		return -EINVAL;
 
 	if (asus->gpu_mux_mode_available) {
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+		result = asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
 		if (result < 0)
 			/* An error here may signal greater failure of GPU handling */
 			return result;
@@ -748,7 +749,7 @@ static ssize_t egpu_enable_store(struct device *dev,
 	}
 
 	if (asus->gpu_mux_mode_available) {
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+		result = asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
 		if (result < 0) {
 			/* An error here may signal greater failure of GPU handling */
 			pr_warn("Failed to get gpu mux status: %d\n", result);
@@ -801,7 +802,7 @@ static ssize_t gpu_mux_mode_show(struct device *dev,
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result;
 
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+	result = asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
 	if (result < 0)
 		return result;
 
@@ -847,7 +848,7 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
 		}
 	}
 
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
+	err = asus_wmi_set_devstate(asus->gpu_mux_dev, optimus, &result);
 	if (err) {
 		dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
 		return err;
@@ -4507,7 +4508,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
-	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
 	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->ppt_pl2_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL2_SPPT);
@@ -4529,6 +4529,14 @@ static int asus_wmi_add(struct platform_device *pdev)
 		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE2;
 	}
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX)) {
+		asus->gpu_mux_mode_available = true;
+		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX;
+	} else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX_VIVO)) {
+		asus->gpu_mux_mode_available = true;
+		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX_VIVO;
+	}
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 9cadce10ad9a..b0320cb5ebe3 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -131,6 +131,7 @@
 
 /* TUF laptop RGB modes/colours */
 #define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
+#define ASUS_WMI_DEVID_TUF_RGB_MODE2	0x0010005a
 
 /* TUF laptop RGB power/state */
 #define ASUS_WMI_DEVID_TUF_RGB_STATE	0x00100057
-- 
2.44.0


