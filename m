Return-Path: <linux-kernel+bounces-98132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9F87757E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B631C21D67
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1231DA4D;
	Sun, 10 Mar 2024 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="YD3pDqgK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NrA9mehr"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964117C8B;
	Sun, 10 Mar 2024 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710050285; cv=none; b=agiI1SLPXzsgt2l1y79nKnPUtF/Glhtr209aiZESH2bn51KYq0+3XEDHU4cp+AoFrZBPbM7CBjnbXgGMf6UPvb74gj3w6StRYQCcsq4YFz5Sh5tSs5ewGffLkvzbn82PzcZs7qSidZSPmhxhzdA+ckOCX9LpFsbwmuNv8zjkEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710050285; c=relaxed/simple;
	bh=9D/Rpsjg1W4DuYt6+hmmghHyz1IBq4YxIL56LVAGzOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stHI5RZUd4gOWeVPrSpJox+aSZepVo6FORm7SAKMrfTcdFrPDMispRQNTCBW0G9jq1ztDG/91I2smqe0EKfiTsv9w2gg5ExSbp1S6QbacbHriqGfg9qBMv84Pxkcc2ts/em5vwrXz8k2KAs/szTIbUcjOOwLG8+2HnV9oSgBAUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=YD3pDqgK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NrA9mehr; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id E0F0E1C00065;
	Sun, 10 Mar 2024 00:58:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 10 Mar 2024 00:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1710050282; x=
	1710136682; bh=1wY8JkJ/BIMQBaotYejH43DwlDabfijX4mzOGOMHayQ=; b=Y
	D3pDqgKyUN61H+qUHbxjHS+GkC8qOVaFtsOztz+AK/Fc9hVvsBeuDxgy26zwgXs5
	BFTdGovR7N4pNjEdneaPvnpC8O23jednBohumLdWTZqTtNYjByYyk5zSjK9HppcS
	vIye2WIeYhXH92dp20iaYbv7fFZJxodLbseznbcNV0QcpzHIqI5aMd6alh+tlSIe
	IWr42KDmD99wl+1l5osILIfN948wDnYKKFAZlmZhaodw5UqE1cb+uVONVY1EEzq6
	icROEMqUOhqODzJC/OnuJMYI4pXZKkXUNR4vdb5hRrSAWFOcLBy/bimgQirNGBnl
	ODNe9od2cpridApqp29fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710050282; x=
	1710136682; bh=1wY8JkJ/BIMQBaotYejH43DwlDabfijX4mzOGOMHayQ=; b=N
	rA9mehr01bmFyBj8FMqikJLCDMmmkPMJJPamd5dmSlCDov8Ct1bVRgos8qLegevl
	tbPfkIjV1J3dyGcNrgkAcPEsbQZSqYifz81Ds0J+toq16sjtFqz/x9bE9e62uKny
	F3QbHqMu+3+2LfNjQRpodCmGIIgk4B1XVVqez6PpmRlK9pujxrKgyHzWHEPg+CLE
	YCD4pOAzNMM64W9Hv5NKDncNzzP72kX+611sDGeEwfcLPFMfNoj96lsefD+NFbQC
	TNwen581mtbJlUGhdFSpCV8g8OT17benhyh9kDXxodWNDtGBIQdinXnZEMxzWCre
	/Mru3NRlrkP3TlJckvhFw==
X-ME-Sender: <xms:6kvtZZ_wYFLVDd6SpxMR8ODp6AvX_4TbbYRnQq8kuictX3jkk89lpQ>
    <xme:6kvtZdtp_yfM2VQnmmQKAAQhhW3RHZok8tRFLuGt4gmvFEysWxFAkRs8yKaA0z4vb
    KeevMUdfTlF7AGYILc>
X-ME-Received: <xmr:6kvtZXAsH_hrNoyE9N3cJftrX9q4gORoZShWXcPnb2hesuZDEW8QkGxiZlez>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieekgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:6kvtZdf3VQM314WfC5KgNYshsR_qoduM0c9FSzjbCHjB0c1x4pLIZw>
    <xmx:6kvtZeN0vdB9Q2HqN5k2Bm8YpPJriIHeN6Kb1HrYBWtIUqnKpKwz2g>
    <xmx:6kvtZflS2TMeu1HGhlar-9rSAmz1Luz3sy2YZSFY1brSVcyyL-B3ng>
    <xmx:6kvtZbrwlOKXO-5P1LmlH4vUAcYjf9JJZX7vf4Ex0e7sN3ENafN4FPxoERU>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 00:57:59 -0500 (EST)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 1/1] platform/x86: asus-wmi: add support variant of TUF RGB
Date: Sun, 10 Mar 2024 18:57:50 +1300
Message-ID: <20240310055750.13160-2-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240310055750.13160-1-luke@ljones.dev>
References: <20240310055750.13160-1-luke@ljones.dev>
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
 drivers/platform/x86/asus-wmi.c            | 12 +++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 2cf695289655..ca8c73c15fcc 100644
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
@@ -4537,6 +4539,14 @@ static int asus_wmi_add(struct platform_device *pdev)
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


