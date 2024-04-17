Return-Path: <linux-kernel+bounces-148996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F898A8A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F02283D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE6C17277A;
	Wed, 17 Apr 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="FRW1jy6t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZCVnAQ6"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0B172769;
	Wed, 17 Apr 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375100; cv=none; b=KNTEVpmCqeeCsagPpYwejI4vP2dBID1GzCbO+igSdQr9hTbbEqY61g+IHXZAPYwLgpm19HayIwrChiAVbZ6Dvj32Hgv87/Vqhjawk0lqIm8ndY6U/J/9IlLuFCTk0sjeNtNixRgb/nRmmDrAUDkVFBpIt1HVggj8plN5wHDKkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375100; c=relaxed/simple;
	bh=5mq/3VaDjM+a0aZuQQ8ckJMi8Tqqj3fYB2vmVsLvSMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNIZ5aIBq9yDUCf5Z7i0XOlg/k4tShH6IGYoHbRnvl/tjejJBJbB2KqWjZzaoj8ACtcW91FfD4Jp1W2f2XFm3d/q7g6r5HZN3QbHg2p8j1EXl74fD1zZdM4S2TKfReI0od5moVOCtQbp1NN9t8iK02WlQqyby3nUXJKP4IPshqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=FRW1jy6t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZCVnAQ6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D80DD11400C2;
	Wed, 17 Apr 2024 13:31:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 17 Apr 2024 13:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713375097; x=
	1713461497; bh=DhmHMbnueY9obyK3Uu3OflyO7wvdBkCNYtIONEP8n/c=; b=F
	RW1jy6t0xW2zo4T5QhlFZJhRf+xTFcrImgwBtGicxoTanubLLxq3YzqUBeIeXyiV
	KIw4neE81KJfJmgJD/axlRG96fAXh3rlFj87psuyOBLJPuAy3EXg3lsa7SBwsIp0
	ia12czfe8G2cc/XzaUQ4FUWJl3eVp6tSEtFEJcWZ040ZXTvAcg0G0eNSi8WahOq/
	RN5jkmeHRsoR+EPFVh++KyuL+/xVHgMO820sNx8QkyjfqC/n8EUeTUfWdM+8Pptv
	zjh8rIHOIiyF8O7xdYCZObUZ45T/sTBbsbTSl4/1wQQHwT7XpbSAw2T4tdoGmr2D
	YRsTRzZH2cfapf9OF+hcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713375097; x=
	1713461497; bh=DhmHMbnueY9obyK3Uu3OflyO7wvdBkCNYtIONEP8n/c=; b=d
	ZCVnAQ68OX2WGmj1CGIPC8cl0J9mgyWBbrfa4jRtajtrPgdiVoA+WLUFf7dD1Kx4
	5i9RQAdzOZTPyBcgcTtd1L23eUxgq0MMa3/h0bSEckzbBjmSvumPBabaDVl9B9DW
	+IkLJ03wW9HlQEnKxWvjxAavh+UWHrHd0DKe5wTqP5oc11Df/hJ+hEKDhoODEaPm
	Vm2LplCa8EcPvRgZiqqYb4jYMKM852csSHu54cn4BAT1wVgPasjxzR8wyK1IBOyn
	ftb0S4wIVZ/YBIptlWLBBcV558OedxcwE3qm069L2+OcOW2/cpJBbewjHKhFQN5m
	NP+890mg9ZiCde5jEg9NA==
X-ME-Sender: <xms:eQcgZljIVPRKxr0JoLC9yYYabksxUXTZhW5uEqQQ9CCHrV6MbOLxDw>
    <xme:eQcgZqB5Ln0SEnn_VBDtzK00lt0NFemkiqENxphuuPODhFeY_nwSDAkq_UQDuADI9
    Io3RSlv5mOKi6Q07ZY>
X-ME-Received: <xmr:eQcgZlHh7-QfBRrU0bNh6WTtCU5iLofq9qmwHZULIceqVor18yCq0D0MEqr5VXQvd20UKTA0JlmI4C8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejkedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:eQcgZqQhITgL5QmHY68eEt1MOzavn056kNc4K5UMmkKmACek4ROwbQ>
    <xmx:eQcgZixvyCFe7zO49-SaI-0NpiQ1xwIhLcsz-AdUMdPtrYIuPvz6SQ>
    <xmx:eQcgZg56r5t_tYqiPPrOnbOa1L2I75sqYO8FtCP1O6E3zdcwbYu7dg>
    <xmx:eQcgZnwd5QzDoGnWTfeDi4PKrSM3k7pxFP6PXKVN8aVXF3g5AbagvA>
    <xmx:eQcgZk4scLOMvNS8gHvHJtl_KoB6X093jX-L_stOrD3GLALVALU2IGMP>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Apr 2024 13:31:36 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	hmh@hmh.eng.br,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	njoshi1@lenovo.com,
	vsankar@lenovo.com,
	peter.hutterer@redhat.com,
	Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH v2 4/4] platform/x86: thinkpad_acpi: Support hotkey to disable trackpoint doubletap
Date: Wed, 17 Apr 2024 13:31:09 -0400
Message-ID: <20240417173124.9953-4-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417173124.9953-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20240417173124.9953-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hotkey combination FN+G can be used to disable the trackpoint
doubletap feature on Windows.
Add matching functionality for Linux.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
Changes in v2: 
 - Improved comments on keycodes in init function

 drivers/platform/x86/thinkpad_acpi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a2f21e958d39..370b9285156c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -167,6 +167,7 @@ enum tpacpi_hkey_event_t {
 	TP_HKEY_EV_VOL_MUTE		= 0x1017, /* Mixer output mute */
 	TP_HKEY_EV_PRIVACYGUARD_TOGGLE	= 0x130f, /* Toggle priv.guard on/off */
 	TP_HKEY_EV_AMT_TOGGLE		= 0x131a, /* Toggle AMT on/off */
+	TP_HKEY_EV_DOUBLETAP_TOGGLE	= 0x131c, /* Toggle trackpoint doubletap on/off */
 	TP_HKEY_EV_PROFILE_TOGGLE	= 0x131f, /* Toggle platform profile */
 
 	/* Reasons for waking up from S3/S4 */
@@ -356,6 +357,7 @@ static struct {
 	u32 hotkey_poll_active:1;
 	u32 has_adaptive_kbd:1;
 	u32 kbd_lang:1;
+	u32 trackpoint_doubletap:1;
 	struct quirk_entry *quirks;
 } tp_features;
 
@@ -3346,7 +3348,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_HANGUP_PHONE,		/* Decline incoming call */
 		KEY_UNKNOWN,			/* AMT_TOGGLE handled in driver, 0x31a */
 		KEY_UNKNOWN,			/* Camera Shutter Switch, 0X31b */
-		KEY_UNKNOWN,			/* DOUBLETAP_TOGGLE, 0x31c */
+		KEY_UNKNOWN,			/* DOUBLETAP_TOGGLE handled in driver, 0x31c */
 		KEY_VENDOR,                     /* System debug info, 0x31D */
 		KEY_PROG1,                      /* Trackpoint doubletap */
 		},
@@ -3606,6 +3608,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 	hotkey_poll_setup_safe(true);
 
+	/* Enable doubletap by default */
+	tp_features.trackpoint_doubletap = 1;
+
 	return 0;
 }
 
@@ -3747,6 +3752,7 @@ static bool hotkey_notify_extended_hotkey(const u32 hkey)
 	case TP_HKEY_EV_PRIVACYGUARD_TOGGLE:
 	case TP_HKEY_EV_AMT_TOGGLE:
 	case TP_HKEY_EV_PROFILE_TOGGLE:
+	case TP_HKEY_EV_DOUBLETAP_TOGGLE:
 		tpacpi_driver_event(hkey);
 		return true;
 	}
@@ -4011,7 +4017,7 @@ static bool hotkey_notify_6xxx(const u32 hkey,
 
 static bool hotkey_notify_8xxx(const u32 hkey)
 {
-	if (hkey == TP_HKEY_EV_TRACK_DOUBLETAP) {
+	if (hkey == TP_HKEY_EV_TRACK_DOUBLETAP && tp_features.trackpoint_doubletap) {
 		tpacpi_input_send_key(TP_ACPI_HOTKEYSCAN_DOUBLETAP);
 		return true;
 	}
@@ -11229,6 +11235,8 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
 		/* Notify user space the profile changed */
 		platform_profile_notify();
 	}
+	if (hkey_event == TP_HKEY_EV_DOUBLETAP_TOGGLE)
+		tp_features.trackpoint_doubletap = !tp_features.trackpoint_doubletap;
 }
 
 static void hotkey_driver_event(const unsigned int scancode)
-- 
2.44.0


