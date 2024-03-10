Return-Path: <linux-kernel+bounces-98110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDBB877540
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40ABF1C20EDB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 04:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230BF13AC0;
	Sun, 10 Mar 2024 04:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="IIngjn+6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QG9EU2wm"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA21170B;
	Sun, 10 Mar 2024 04:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710043926; cv=none; b=lXxtrzCiILwM6Y4oyD69RVTi+95TJVE+/TuEiNSm1xPEGy6+S7e6ennBZZqz2dQBx/sqSrZacfQk8KY4ouZibY75iP7CyPiAEyEVbtGMIrpY7pkf1JzrQqXep9tTnGzsX15hMo4DlSxTEENxQvm1GntqZXMDIo2s9MRZz9JTQjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710043926; c=relaxed/simple;
	bh=bZJRFPdOlX+idhTE4m/nqAYeZ09IMIb1p4XUCC2Qiqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZllHtjKwJbvzL7S4wkBb+tDQbU+3ARqcuEZWqENzzYZfnblu+ZHL9Lx29ZwXVlzuwDhwQu61jc7aqFYZvczdL6miy86JH0JEOUzKLNQtbnmwkFsD0f+pbB5uJGfDqVURUauFEiG621LHHd7ooha6VMSaQxeoehV2or2myoCUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=IIngjn+6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QG9EU2wm; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 407701800070;
	Sat,  9 Mar 2024 23:12:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 09 Mar 2024 23:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1710043921; x=1710130321; bh=ww8f7l9ZjuwJeMsYmqKPs
	DDdnpoOaqxy8bHZ/0881gA=; b=IIngjn+67FZt8QmWnsHl1ncDCxOkqMBGcXSfH
	FLhUPaG16PD19+IgcRPbxSFDwXcx1N46mKmKjcsaAMFh51DRGYreofHr0mLmZRwa
	P4F8bXQmt7pkHvuZQh4NRVUeZF4rCW/Me3CbZ+gxK+2yYoRvfsWg9d8fhz2SAXaZ
	BDyI429/CnS9sa18oazukvX3lsDQwrQ4DEMun+iTaPVoqWnL10dEKgDQJeUqiYkG
	qhXptsYPDirKfPef//4gJJX0jTr+2MLodDpfaVCCh9Lq9Yyku+LLFN/0udD0VTqK
	tn0fwOQhmFMfax6+zpGotlhgeSgEQTLIvnhZBrGtnZF5dTX5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710043921; x=1710130321; bh=ww8f7l9ZjuwJeMsYmqKPsDDdnpoO
	aqxy8bHZ/0881gA=; b=QG9EU2wmTNYq/raXYpVCt9MDhfpWNWclOprbyTxWCdz/
	jcEMLI5JYgLaPBfHYdam2q9tTBeNGRQxyBivJAoEoEunBUhgLQ+Kkm0igGE+lDEM
	ztrf+PXnqFIkzBldp4JcPoaO0p6SF1Ube4ZHUQzW0RVyVAZFDGuoNwwXFHSs3MWX
	foJjLT/QpJUBePVxGLlIGEsM5v4KU6RpH44Ps5UxWj0Pio7nNZQfYWm5cZ5I4wqe
	iRo8dAqHEullX/80ExTNpMTbpknyZSf6PJbw9Q9gp48LoTBXNTjIpXJ1SgVrvx9p
	Ufm2Xaxwwf8iwQWRpAJfz01UrCIGlaupIJpgwZQrWA==
X-ME-Sender: <xms:ETPtZTOMFCU_zKCocshPT9s2x7OtzrzK2hMQgSyjsVyFm9RwpJu60g>
    <xme:ETPtZd-frwCMe_HCd7WLJIInIeEg4LCrpHTZrnHN5QJVw_6RpLfxwmpUkw6jE_3VF
    LtARaGTNM57AvBxxWo>
X-ME-Received: <xmr:ETPtZSTEXc9-hZvFt_I08nk6gXKeq3y1UFnr_5XRRDZ90Wnb8nJsf6pONtY_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieekgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:ETPtZXtHONdKfhNNyU3UMz6aFnjiyuYpn7ItP5gRrocbKNEjScSfsA>
    <xmx:ETPtZbe11v59ck4nYw90pAM_K3c-xDlPLMY2P24VA3Uk38rCqM65mQ>
    <xmx:ETPtZT1lSCCQRi8fqMazD51a8SS1j7PxVcnD0Kg_zJygEqga7XzAAA>
    <xmx:ETPtZS46MoAka8DzybLNiRkdcIgVdN6AU4kvAI0L500QuyiUfd1dLZaupnA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Mar 2024 23:11:59 -0500 (EST)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86: asus-wmi: add support for Vivobook GPU MUX
Date: Sun, 10 Mar 2024 17:11:52 +1300
Message-ID: <20240310041152.75413-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
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
 drivers/platform/x86/asus-wmi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

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
-- 
2.44.0


