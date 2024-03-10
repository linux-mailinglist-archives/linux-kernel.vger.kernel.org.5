Return-Path: <linux-kernel+bounces-98130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CE187757A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51291C219A4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF8111A8;
	Sun, 10 Mar 2024 05:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="uqe6MBoo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nR3l/aWZ"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6492F18AE4;
	Sun, 10 Mar 2024 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710050010; cv=none; b=OEpfiRVEJAH5wHpzWqMuFh3LiDdTKCp8o1iNyHNLOOCRTLTFSJBH+g3Z/1ue+M00byp1929Dof4CvX8pGrqR/nbcOvUQZvZzEimxcl2CZQ6yb+M2WI0553VMs7dbUX9P3c/2owaQ6ShJFYOq6FA9dY53NHt1tBr+wUPPqEuip70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710050010; c=relaxed/simple;
	bh=bprTNHJle+DV7HCfoKq77YpUJ2WNM87VdLWG7oaL5Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4uS5X9notk4dcX1Da57Y9GSyNnBEtD0VETbxbroaGdgcrADyBwWH3fKyQujuFdq0W1h5qo3rFmScP0ogC/3+dES747nz8d7U/lCkCVeFrV9NU4tfEdEPcW+8Ef4LxRJi7VwlGF6/AeHd9YG9Wv495tEkQv+pRDGhiRTrZ7PjrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=uqe6MBoo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nR3l/aWZ; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 3A3101C00084;
	Sun, 10 Mar 2024 00:53:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 10 Mar 2024 00:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1710050006; x=
	1710136406; bh=1e1I4TRA/RbifJ+fx9lJitt9PeXr3vejatHWkHEO/ho=; b=u
	qe6MBooKaTBEoLUDSqBwPScnflgjIvUIbHaCYCz4/GqDby3vgk8gXEZHwPFVJEiF
	bU8KHZD4ftSvI2wvCc/VRQPgo2KzGuGCN15GxxaditR9FSFvttQIwq5uejv/dbSx
	Z/clzBc4Ua573b9/AMN2Iu53L+7zYyQ8OHPLQt4Qd0kneLwm5peTAeOzTB9AeoAH
	aPnu05m7r67H92NugzwJjI8P+Jw9+KLwKIUSegtCe95gbSMfc4QIrkqmmG3Cih3/
	S2t/KjXplC8sG5TlO61NLSYHPdrOjzLfKZh3TNWzJT3ni3vtf8CJGIPFhU3xAegC
	4ecje8RWVoJJGGUwXhR8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710050006; x=
	1710136406; bh=1e1I4TRA/RbifJ+fx9lJitt9PeXr3vejatHWkHEO/ho=; b=n
	R3l/aWZebgiaLvWWrf+ogMJCbr01doIHfXD7gU7G2hssswwC+rnK5M65Jt/rjJ3e
	kvGpZ8Uzoqtz9Im8hGhoteQe28Au05M6549lQSV5SjzcEdG/IHbiTSla8bmIS5hH
	X32c0ao300BdZq4U7ePfI+ozXaTd6eNyyYG5Tf0pUQtc0Aa1mI7pLE18/nMVO4X+
	vkA+0wb99oJJJD5fZ979wlwYRaw+Au1K3Z+Gz8p+Ncwuza8+aRpBW5VDoFhp/nha
	yymoi5MgpKp+nm+hZDIaQ2AxLs7umO43jMo79A7xD/s1hOVcwp1Pv5ZILnb+RKq+
	iyxx44P60LHIDZJW3hmQA==
X-ME-Sender: <xms:1krtZbCf3NlOZRrytIK4hse6hs7QHmbWKvY3qSGLoQCObBLgVpWtSw>
    <xme:1krtZRg6nhi_WoCUX5zMADomttbkaTs38zr2uUa02oWT_HZKqJWAjOii7eHPkNL7k
    U_QTlhDLeMRw6azFqE>
X-ME-Received: <xmr:1krtZWmkEPkzd_iTKB1UkCz3kNppNipS68l3KGLjiGIsKrsXD30SUefGjtSj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieekgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:1krtZdzCe-NloewoCO0pHXRwBYFDYR_i_03gOv94Filquq6RYUjQCA>
    <xmx:1krtZQRk17N7vdw00P_VY9x1b0Dv4-A9menDq5LfFWZXnPuYsquuBg>
    <xmx:1krtZQbKJ0PTTXOZ4N-t4cIYaNYUl6LGwSLemmX1Beu7MXW_AZW8mQ>
    <xmx:1krtZWM3v_iGUmO7gE_K9t3LfyXZsbDEta8VsxjGRux_U78aaaOXwD2T7Ow>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 00:53:24 -0500 (EST)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/1] platform/x86: asus-wmi: add support for Vivobook GPU MUX
Date: Sun, 10 Mar 2024 18:53:12 +1300
Message-ID: <20240310055312.11293-2-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240310055312.11293-1-luke@ljones.dev>
References: <20240310055312.11293-1-luke@ljones.dev>
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


