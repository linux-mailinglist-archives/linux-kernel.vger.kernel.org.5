Return-Path: <linux-kernel+bounces-108305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AB38808F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF379284CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB778C1D;
	Wed, 20 Mar 2024 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="Gt4dm51H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rttkw+Ug"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD2F7489;
	Wed, 20 Mar 2024 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710897298; cv=none; b=dn4KT8VmDt3JaKsbb2h7+LR6usixUUas52vKCriSmvNbfIltR5VYDRmYtkJ7nbnlKyuJOFUUgTq7rkGavTwchoZzHLQFqEGQ9BbL0ww8V1fVPxTgYYLtacCCLQncsiEeaGK/8UW1TcXHR1oenUHrCtBt/9wlZ0jbasAgJQjDWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710897298; c=relaxed/simple;
	bh=BjnMLKjkNUbrcxUIF8uWrV1uE+fE/qD6xcmyM3Lxmbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFEDCkxLAsNw8bdV1ZniEP7S/EPFH/yy/TREaTJL53UTJznTWBd9ejw6l6/ebHT/5kZ9QV5Mu4WO9X/iDgIEBUiJv5h91JXhBfYudrxRzj6WK9VqezCGCbC+x/iwjltfHdJRn48NBQS1ysbb0Ri104jafxviznHGQ5H5zyaYzTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=Gt4dm51H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rttkw+Ug; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 62F4C114009E;
	Tue, 19 Mar 2024 21:14:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 19 Mar 2024 21:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1710897295; x=
	1710983695; bh=VRlPA1TAw3enotEme11vuMgRKd+qvSQrfzvEn9zdNn8=; b=G
	t4dm51HIza3hGKwFKLVEoKVRAKSgRwaI7+YVkdtPDbppmIFe2CdTremz1qJkz/7Z
	SVpqbcC9sfweFUWFr/4jvLqNn0MMu/yRlKNLzuQrCTlLt+P8cC1hdGdaVKXbYGMR
	rkF9IqEAMhlwNHZlr6jVsJb1E3IAvwG7DGqb5RmDpFV1VOoX+llGr2bahk6TVidi
	0C8WrtgrhO/+86lKth4PNuZcGgaNMjao6JiKY7yUSeebHByQyts8596zI4iKBkoH
	WjBI72yguZ1ecDjsEtmBigCZEEQne8jq4NQ8vx26FxvHceZQ73xNzw1pS2b2XGvb
	SZTCkCNAcT/788/2whPCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710897295; x=
	1710983695; bh=VRlPA1TAw3enotEme11vuMgRKd+qvSQrfzvEn9zdNn8=; b=R
	ttkw+UglV/IMAB2EoySZ6/5UWygW7Xb93HMHGfdvY2U1XB6hOecCQv5+FbBcueQa
	Z8Ps87sODydqD1rmZTMhrufKqQ4Lak30LdYi1mohb8uMauY6QtaZRyFjFNWzEqZo
	Iy2RZUiUKtSRuoiyNcd4716Dal8aEVMwgevnpSh3VW3gOj8pLQtabYaVjecinBEW
	DS5agSkLnMq686kqgkhVqTxCn/5rD4uywNG/GgW6tleYinwbVe6wIw48AeONTnnm
	Udr7M8IMgtzyt9dMv2tRi4bTBIN20vUMSMTEDHj20cZzF6725nC8yEi+CXFCNW1P
	Mw1PEAphPlRjkU8QmMr6w==
X-ME-Sender: <xms:jzj6Zaljfn22CBdt6uyAX4G3IHQsm5LEIrIqOXEPP7pw7CQiygykWg>
    <xme:jzj6ZR1hHLKY1j0Q4Hx5tSR6LCySQ6n1Gv1_LslRqqxWxUERe6X9wrUIzvmgMTg3l
    -_LEV7lz40J86vwnUQ>
X-ME-Received: <xmr:jzj6ZYq_cflcS4hilCZp0VEyAabSiukZpVxhJVz52GvjIx3AU-FNd4_CSMwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:jzj6Zen1n-viCvAhMMV5QMexJm0aRWF1mssd8IIeosFL6WUNBUnPCA>
    <xmx:jzj6ZY3OGgdWFyyK2m2Buo-8pfncNrml7aYusMnPAsNnigfKRueU3Q>
    <xmx:jzj6ZVs830zXDHIxPb3wUURRrAWRMe8KwzH91wY2g8vP6lPyyV99ag>
    <xmx:jzj6ZUUGyEvtrkz9K8mP0-n_wS5-lKQcQLcc-cPpwSodk9LzCcs7gg>
    <xmx:jzj6ZSoF4A31hS3xhn50THukegwoJ8t9rzjr2c3aGJTu2AWj2ruVUQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 21:14:52 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/1] platform/x86: asus-wmi: add support variant of TUF RGB
Date: Wed, 20 Mar 2024 14:14:42 +1300
Message-ID: <20240320011442.11608-2-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320011442.11608-1-luke@ljones.dev>
References: <20240320011442.11608-1-luke@ljones.dev>
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
index b9a2fb8007c0..0d8a2b82cc06 100644
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
@@ -4515,7 +4517,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
-	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->ppt_pl2_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL2_SPPT);
 	asus->ppt_pl1_spl_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL1_SPL);
@@ -4544,6 +4545,14 @@ static int asus_wmi_add(struct platform_device *pdev)
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


