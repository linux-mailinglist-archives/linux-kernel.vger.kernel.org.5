Return-Path: <linux-kernel+bounces-116561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9285F889ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48368292F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F4161917;
	Mon, 25 Mar 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="hZpX8sq5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VrKCoNt4"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB715644B;
	Mon, 25 Mar 2024 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345816; cv=none; b=m+hhz3bT2oky+u1Px2FBgq1OEXJ76vbrkpA5ocy3X5qHxn5hsA3UOA84vdYaF9u+XQVMFKF/Hkf/ccBx7sysAXsGULLo6g78o9I830yXnTroHYd0ugkohh9e2JciEnjls7+beahtMIlDRE5i+3+oYej6E3kVyI6H6TWVt++87RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345816; c=relaxed/simple;
	bh=Rfm4MeqPFpiKKJ1RubZpQs/+VCp5DpCuNUt5KfcdJ30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2u7LPgXLUmBh2iPdPIyNEEeCniRCTAbVCEEYSFkwFrnfjqRllNwOMkHT7/o+tNXdDCAjPckTxgj5sL0SeCI2bntGgBmsH9GfACoTa8Hp8dV0Q+HxjsBLy8b4QU1hiA5ZIJLwPsGCkg/xDTivc7S2/E+oHBnEaqOIY/d98qeiCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=hZpX8sq5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VrKCoNt4; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id A47D113800F7;
	Mon, 25 Mar 2024 01:50:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 25 Mar 2024 01:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711345813; x=
	1711432213; bh=mquhRl8UuQw7ysCxwHkJ/bbRbAxKTiS/ILd7PkDmBG8=; b=h
	ZpX8sq5bck6q/j4SAQI3OleU8lKCA9upJKrEpzfI7JykKHiyfAjgNxhuXUSpsJOT
	bZWEkAVwB2p6KulrL9I35D3tKeKvGea4fJV2Ax4e+NRrQCDMbD8go65jNCNASF4U
	mRa6RAjkDLoAJl5ob0RUx1DQjYFFRSjONIR2uV5OUpTYynD3iNSS+umUgql0mujX
	fD6J5XXVDi1C/w+2HRv2AUV5zyj7xszj2MbkgVJyT68c/AhpS4svtxOc4PfxpxtA
	u/D+n08bRLPaS4taxK4FwOcc/fPKq3thLb/LVzVIL3GRBscf0jhLnC2MlQ8Q9AT0
	H2RwsQk4Xao88dFpPVI6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711345813; x=
	1711432213; bh=mquhRl8UuQw7ysCxwHkJ/bbRbAxKTiS/ILd7PkDmBG8=; b=V
	rKCoNt4rAISDxlyemHwuDMy+LRYlrJkIImRr0/x5tIGA2aGZuQRUIU7xbEySOlzR
	6ZGyk3HYyRMeZ2oYGrdH/5iEBPpD9jRkULgWKfVeVs4ZlFBB7reofPrS5XKjR/bW
	0xHioBDrnKyoL8tE7iL2zwmbdaqnQE+O0WzGEaElQqIbCqTez1ic7CbIQCpe51RJ
	ziwBp+X1RxS7YaUORy8NN/iqzJSB3mpfic7YSFRmlxMFBxfaQnZb/kqJlaMEApyH
	sCsP1rnXDbnAAooBaAX10jl932CXmBo5IyQhV3ztzEM1JStlG9QrhDtYVlTD4BQ9
	lXiAD1/FAHXfapbreTZ7g==
X-ME-Sender: <xms:lRABZrIdmVmKENqZmb1StJJO8ZpRxBy-cdpEdPGpgWyUQ3u-IybP-Q>
    <xme:lRABZvKs7bqM6tJduEhPwQN7pdGS_JbCtVoHHfbWfZR6vjb9C7sxX26j9Hn-26poS
    jjwInGAtMyf8wH8b7o>
X-ME-Received: <xmr:lRABZjtnDGMsGKp-wPC--h8eu6wmIwHi1WaSPjrkkJhUOUn_RFN4rwQmoUr5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:lRABZkZiTurrC1cq0ZjCRJFwATaBP0fRP8eBQ-sXYvaeFCoBp5_dMA>
    <xmx:lRABZiaAdrhjyU-ozcRFT8qoBsDeCJXtOvAR-T_ocf9py2zwaHmR7A>
    <xmx:lRABZoBQhZlODHwVVxJxNxc9G2BJvmxQeJF2xMSzkyvwaqGeZvu99A>
    <xmx:lRABZgbYs8y2ehYxGdaWp0nG6esEQGc_sBh5kptX0VICpxUIaZdHyg>
    <xmx:lRABZnNTMdIjuX9MfoVye9s6Ve5gdQw7ax4wui-sMGloCUuMwAQt4g>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 01:50:11 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/9] platform/x86: asus-wmi: add support for Vivobook GPU MUX
Date: Mon, 25 Mar 2024 18:49:31 +1300
Message-ID: <20240325054938.489732-3-luke@ljones.dev>
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

Add support for the Vivobook dgpu MUX available on the ASUS Viviobook
and some of the other ranges (Zen).

This MUX functions exactly the same as the existing ROG MUX support so
the existing functionality now detects which MUX is available and uses
that for control.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 18 +++++++++++++-----
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 54ce0fb26f42..285821ef819b 100644
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
@@ -4538,7 +4539,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
-	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
 	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->ppt_pl2_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL2_SPPT);
@@ -4560,6 +4560,14 @@ static int asus_wmi_add(struct platform_device *pdev)
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


