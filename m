Return-Path: <linux-kernel+bounces-130767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB48897CE2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69BF1F29427
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A669AC12C;
	Thu,  4 Apr 2024 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="sGaeZ7mw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A88Y/rcB"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DA8462;
	Thu,  4 Apr 2024 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189839; cv=none; b=FBo9MAO+os4JaRESyIVAnKuMHCTyo4fFaY4Km8UjWyuBBGk4Kgl/ExzlZPehgJM47HJL5X3sb1mEBrlcXRNv0whXztFaWCx4h6qOAOiWqw/bQaV/Jr6ddaYUNskVvCERl0SlQZspM6jZC4+c0l22UOxHRa3d+6U3DddnW+HULq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189839; c=relaxed/simple;
	bh=BDM+uHjAeszpHyFFAxX7i9RiVw2Ng2s5OMK1+h3nC4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqDrr73L0L7OgMNEoS3VGbsPsAPGeqBQXrC0OV3k+PXUA+92lLEzjxP2y5gOCWIk2E1dWfI4/hO/7+nNDVry3VtCjN0sfDbhRlsCP3IiI7D8h1hGuEcM6k1N1r/SRNzEq0D6iLJmqZSQ1cHEp7RcSTxaN51RaPkobJTL8S1tLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=sGaeZ7mw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A88Y/rcB; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id B309318000DD;
	Wed,  3 Apr 2024 20:17:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 03 Apr 2024 20:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712189836;
	 x=1712276236; bh=DqglvZr5k/JEAGAixTdTEp4OkixttBJt7dLokKdRZbg=; b=
	sGaeZ7mwiqGYLpHU7sSszI8Cdtxsk8/+lqoNEfnNjO560Je3UIPUEwFIVCrk9LAh
	kiEhcpaTZ9cemwVXo+iPzVstUGueW0RXpNR6MqtOp/cbUaL0NfGiaQPR6BaJDyn3
	N0Yk80nPh5dRLfoKFuIBger4E3sC4GgRR2rTtXzxGW8mXnVYT8rCzW1rMQ7r/mSf
	4G3Dx/NN86c1ioH3lfP5+lZjrpPU1cH42xg/L27SD5juRkopZLRzU/M+7IQrylAK
	xWmzIOyNTiv+FNWXg2+GbK3gyn2r6PPA23yTfIn/+X8ZjQIqcquNlsUEP2YRQ44l
	YLOMslvsz8IDRpY8Io8rCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712189836; x=
	1712276236; bh=DqglvZr5k/JEAGAixTdTEp4OkixttBJt7dLokKdRZbg=; b=A
	88Y/rcBJz2ow5femLbum5fKlqlAvsNtp9SvhqQrOFCkvYnLbKVScpc++4tHtGiat
	QnT2Wf87SbBEpKM0+j4WKtOuMS1P/tiTCbgOaxEXM51s9Wdvue3oSnSklzi1mwLu
	54SBa3CHxRmgr6FpJTV/oCcqcELHg/UZ5CViS7Li15m9Gmj6NlmjRCQ6m+KjnoIy
	ZmW/75BvyuuERrF57v8RnmDsBbD0SbscIhTnsS9ZO/eypknlbct1GfgRQuksFmnQ
	lJ1UgW3zZpLwh9tKIgrJI3N7oiXnevjgi3cVk+qywTklV0ooCPJHcsLP5641SPde
	L9Bbe3rR5fOWMC4hDWGPQ==
X-ME-Sender: <xms:jPENZmTTKD75uvEk6ex68A2MD3pLAhsEPKmb72TdoMKd-qH2L2J7gg>
    <xme:jPENZrz1cwXtCKGcTMsaTHzGxDTtxPLLNs-__QBVbwgG4W9ttFyfO0-wHnFqJXX0R
    trshE80nFgGmXYim74>
X-ME-Received: <xmr:jPENZj3h1gnCj64ObOmnUlRbI3hxLG1j7c1bSFSB_2nkxITEEkrlrhkWbpzj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:jPENZiAh-g1Bx1gVvRaCmH94gK4LD-Hq9bHcNp_yD_MoMuLyeDN_6g>
    <xmx:jPENZvieBjMjlrOW_BDbTNPFnr_lPTR8--R6H1rsnHo0VL14pKv5ZQ>
    <xmx:jPENZuobK8pHSf-ofAnjunvFmL3RsHWhSog69gj3ujySNl_VRlp5hw>
    <xmx:jPENZiiwxOmtzVIJdSBbeKauBcQrpyUfhrdVBrYcwXqCQyYfdtAS4g>
    <xmx:jPENZqXZwQ4Cauq38HC74DToaD4i3VzbUH6WhjWjL_BSiXSA2mM6Zjwn>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 20:17:13 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 3/9] platform/x86: asus-wmi: add support variant of TUF RGB
Date: Thu,  4 Apr 2024 13:16:46 +1300
Message-ID: <20240404001652.86207-4-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404001652.86207-1-luke@ljones.dev>
References: <20240404001652.86207-1-luke@ljones.dev>
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
index 1ab4380e9771..6896d056d227 100644
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
@@ -4505,7 +4506,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
-	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->ppt_pl2_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL2_SPPT);
 	asus->ppt_pl1_spl_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL1_SPL);
@@ -4528,6 +4528,11 @@ static int asus_wmi_add(struct platform_device *pdev)
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


