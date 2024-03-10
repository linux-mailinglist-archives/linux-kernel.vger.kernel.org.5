Return-Path: <linux-kernel+bounces-98111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711C4877544
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FCF2822F8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 04:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAD817556;
	Sun, 10 Mar 2024 04:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="AWrc1Ahm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFYOOjlX"
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907A200A6;
	Sun, 10 Mar 2024 04:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710044540; cv=none; b=P1txaR9Vb0tlQc6rHozh5N9fwcSAu7Qgtxqr5XxQhmHkMihKGTIINNA3KfaH0s6CwiB+XCpeT702nnQt9LU5NKveI26g7c934ycRb3o15/u9ccow5pHQAtGj/c/OQplTYR13///Ohb8a36AhZhy4UHq5nkoWxPlWgwZiDHs7p40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710044540; c=relaxed/simple;
	bh=6x4rOujCk6PjmetK1+thfv9gMafF0qqaZsS56g2DwnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EhRDifayWeVXwM0+DeP+e/B2KNZzCUqhueYgiSY1uy/sbIeiq+qZhBYUkGHoXB24uCcX69On40MAOpguC6SiAktXctYPuZ0c+Yxsq6d6TKONalUArJQfpRqcGVwrypGvi+qVmahLYec44a18KPK0udqbdPYcL/VTYE3raB39V2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=AWrc1Ahm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFYOOjlX; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 20F201C0007B;
	Sat,  9 Mar 2024 23:22:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 09 Mar 2024 23:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1710044536; x=1710130936; bh=pP1xzu5THbxC+z+FgZ5lH
	zlSutCRYC/t015Db/fFKrM=; b=AWrc1Ahm9TVCQIdyPBguZcxbVtoQrHiQSWS/g
	gEIpYwVgYv22W1q/89v5NSfzKscUIn/0CYL7i5+eUU5bHKzzpxyLBiPJ1EvQzK51
	6J4rmKdsqagxJxuL6PEawliIkfMPqkir1tB1Xrf3+D1wcsPg+Pql72+L6S+TZouv
	q9ldnThjB5S3YYMxL5otfh/aZR4UQ3iCmO7RbNGMNMC9jpEJAfS/YjiriNSnhzwU
	eh/7Kv8fZUkojhMtzFfidTlVDtktKWZlhKk4+xyi8e7J4HAciWtrWw6TQ+b9IwS3
	LUPcAj6eiwt4B/i682QUlF/XMYN7NVoNJ8ICV0JkGLjsHXL1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710044536; x=1710130936; bh=pP1xzu5THbxC+z+FgZ5lHzlSutCR
	YC/t015Db/fFKrM=; b=eFYOOjlXxHUIX5Y1ZfPR7q466upv+H1hhCi5vaxRBELS
	BoQpJ4STc9O6luBubasohwqhO9WJK17SYBm/NmzGWCGcXqsa6K3HczxQn7tEQnBM
	ku8UbbI6avyGfQOfSWHOL2U0AkTSwXTKTHIXSBDs+xloE/aAQYRmbTsFWCw+SjgC
	f7uzS6F6K34Zu1vb7Ye5ttjgFzF8zJyIItiXigFSRYbkgImFq8WiD+A7XWHEq8Z/
	HVlAxzhUf22iqzyFEs+wXOvkcHm1E/M7Cz+X0PE26kNc/PCbx07BJdgRLhYe2Aao
	+myyV7FLBx12JZQYpcdw2olI4wPoP/5gQ8R4rN1MgQ==
X-ME-Sender: <xms:eDXtZRlhq82iNz5Xug7eV1h2EMNhfNUf_TDk-R6Wnh9GK3bWUiC6Rg>
    <xme:eDXtZc3pNgToO_uqCfe_3N6gukH2WOlZcqjBVNRF6HhGT4WRXno41_-OE0dbWh3Yg
    ZylNDx8Q-HioO6Gnms>
X-ME-Received: <xmr:eDXtZXoSzGf3mDPFNe_NzGLSxmRLFnT2N9efETXDMq7Lnc-Az9sWexSkQwF7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieekgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:eDXtZRnm2KM7RQQYluBPA74HSSpRgkSyZQFQeUnDpljju5naOID3xA>
    <xmx:eDXtZf0yZKswfBAz2gxl4gPSYcThCWy_6BdStfDIuoeBTI4IYWlmQA>
    <xmx:eDXtZQugm-doUM1o-KviYf-NQPFbRiXbTj2DHuLwM9n3s-VGHdX-3Q>
    <xmx:eDXtZaQYxT__sANUbXaGupFE2taXKUL5Ij2e37ZF7WrNCGXxLBJAFmiu6u8>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Mar 2024 23:22:14 -0500 (EST)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86: asus-wmi: add support variant of TUF RGB
Date: Sun, 10 Mar 2024 17:22:08 +1300
Message-ID: <20240310042208.80062-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
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
 drivers/platform/x86/asus-wmi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

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
-- 
2.44.0


