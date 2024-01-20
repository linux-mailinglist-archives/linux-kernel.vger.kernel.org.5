Return-Path: <linux-kernel+bounces-31938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A48C833711
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 00:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49FE282187
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 23:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAD614ABB;
	Sat, 20 Jan 2024 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="cf2HrC8m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LZjagTr0"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860314A98;
	Sat, 20 Jan 2024 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705793399; cv=none; b=XMoJPyYRQAm184jHhIctI1Y3LDMfbaeZ8HXDD8zWp+o9Szbe164hPhl/aknS1l/1HrUlkyPykcQWBGFKR0ywIJrR328Ihw8X7csW6xx+mL7mnLpkrOBimT/4qHrfg6AH/wkO+EBNb61dqXbJdv2Gc4OLE0z6y/Joxl8XASJXSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705793399; c=relaxed/simple;
	bh=gYxQpuVqxVWQkJvr3V8GaYIGnpPdH4JHwRwYm+3Culs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLhmJwNGRqW4XDU/12pQBjiCgrik17dEdeKUcR4rLXT2+ydgBRSdiFnAQMLuIK6G4eiUUA4cqvcrjHtPrWEEXGzGFTB3IrkoUNzvdKFNMLwKytmkiUWrrK9l6ZpuxJKIR/HiA6E6lTBE0ZtllsoSguf0l9OoA2E4Rwpn3EdSiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=cf2HrC8m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LZjagTr0; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 0DF373200A40;
	Sat, 20 Jan 2024 18:29:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 20 Jan 2024 18:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1705793394; x=
	1705879794; bh=WGvMaEsDltLoKXJgl9GSQOJtstKvutWc7SjgzovOw38=; b=c
	f2HrC8mjhLbVIlK7oWYepvY5TStNV+Vh73y2tN6QkizI8WvEprMpH+pc8mGMpPlB
	Dcvh0pV2AtyO6bRGf9EA4qXmfSJxHT+s0mkhgqJLe/0zX1l2qtEBRIj+UvLYQR8Y
	qtRV4vjtO7rySI6IZkM75W0mGJvOgwbx/oyyI77OALx9GQHAx8fAYv6ScH4r+114
	B1mAbgzpLPCRm0hfk+YoQ80j3EQhJh34QkCq29xTRLcRCJEOZjK79UIsUupI3ul7
	YF3B1a/yvLPA07fXz+cHNXEpHkI408bf7gwg3enE9R8F5WP0b7l5G1AHr7zz2FAZ
	u7ZFU1M+XSu9R3e+xpRnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705793394; x=
	1705879794; bh=WGvMaEsDltLoKXJgl9GSQOJtstKvutWc7SjgzovOw38=; b=L
	ZjagTr0ocJCNOojS+rhJfy8k9ExRIJ33lirPciH4g64kQ4XrdB2DwR5huqTMQD0a
	pSc9XZfKSBHdcFv27Wkvj8WkSDwXZ+n0imOillo/FfwtnDLKyVXO8/XF8XzWsypt
	4V1qZkx/fjf9roAZ/SEeA0z97dKOsKccynGL/uLo+ug7MMDGcnK1kb/Cn8IeYFK6
	QS8PwJeJUqQ11lgTW3+M5VfwdKdy4cQYieK8i7CjgleBqxRYZ1yGKzLmJKADWl+N
	feW1LbIGLZQHU5xvHpYG4L/Zur9ojlLu7H4cnzpIM27ibL+c+8mv+lGIw9hO92RX
	RFVuW7BQGE9SwDnMGPauA==
X-ME-Sender: <xms:clesZWByInibY4FYPxqB1nGu_XlV39At9fKpylIkPbVt704MGDqPKg>
    <xme:clesZQgP4xH3SoUxxqPL55zF6YZwVK7hiT77IWUs6PiPW6OT3KREvCaIJacNFZc0p
    A-zoCnfT-v7jcv5o20>
X-ME-Received: <xmr:clesZZnu7l-2isMRlta_J9VzXKLK0-BafE_o1CUc4GlLIW3JpoLKN8ULdFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueet
    hefgvdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:clesZUx5CGtBy5uUKOVPsx2pIns8lSfnITagzKjQR5US4dD9JefnxA>
    <xmx:clesZbSx6SVUs_9Mqoq7gr2A_mo0LQnwR-hsTtavQVJSx9kTtdQVlA>
    <xmx:clesZfb9_oQO58FfShN_i3H-ZbsxtvCtf1oQZmDtYRVB4qCgSoz2Yw>
    <xmx:clesZcJoZIElVQsRwi7G3FQUrVKDadFgzB8t1ry1RD6kAbrqHg1PIA>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jan 2024 18:29:53 -0500 (EST)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: corbet@lwn.net,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: Support for mode FN key
Date: Sat, 20 Jan 2024 18:29:34 -0500
Message-ID: <20240120232949.317337-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New Thinkpads have added a 'Mode' Function key that on Windows allows
you to choose the active profile (low-power, balanced, performance)

Added suppoort for this hotkey (F8), and have it cycle through the
options available.

Tested on X1 Carbon G12.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 .../admin-guide/laptops/thinkpad-acpi.rst     |  7 ++++++-
 drivers/platform/x86/thinkpad_acpi.c          | 20 ++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
index 98d304010170..7f674a6cfa8a 100644
--- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
+++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
@@ -444,7 +444,9 @@ event	code	Key		Notes
 
 0x1008	0x07	FN+F8		IBM: toggle screen expand
 				Lenovo: configure UltraNav,
-				or toggle screen expand
+				or toggle screen expand.
+				On newer platforms (2024+)
+				replaced by 0x131f (see below)
 
 0x1009	0x08	FN+F9		-
 
@@ -504,6 +506,9 @@ event	code	Key		Notes
 
 0x1019	0x18	unknown
 
+0x131f	...	FN+F8	        Platform Mode change.
+				Implemented in driver.
+
 ...	...	...
 
 0x1020	0x1F	unknown
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c4895e9bc714..ceb22f8d8442 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -166,6 +166,7 @@ enum tpacpi_hkey_event_t {
 	TP_HKEY_EV_VOL_MUTE		= 0x1017, /* Mixer output mute */
 	TP_HKEY_EV_PRIVACYGUARD_TOGGLE	= 0x130f, /* Toggle priv.guard on/off */
 	TP_HKEY_EV_AMT_TOGGLE		= 0x131a, /* Toggle AMT on/off */
+	TP_HKEY_EV_PROFILE_TOGGLE	= 0x131f, /* Toggle platform profile */
 
 	/* Reasons for waking up from S3/S4 */
 	TP_HKEY_EV_WKUP_S3_UNDOCK	= 0x2304, /* undock requested, S3 */
@@ -3731,6 +3732,7 @@ static bool hotkey_notify_extended_hotkey(const u32 hkey)
 	switch (hkey) {
 	case TP_HKEY_EV_PRIVACYGUARD_TOGGLE:
 	case TP_HKEY_EV_AMT_TOGGLE:
+	case TP_HKEY_EV_PROFILE_TOGGLE:
 		tpacpi_driver_event(hkey);
 		return true;
 	}
@@ -11118,7 +11120,23 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
 		else
 			dytc_control_amt(!dytc_amt_active);
 	}
-
+	if (hkey_event == TP_HKEY_EV_PROFILE_TOGGLE) {
+		switch (dytc_current_profile) {
+		case PLATFORM_PROFILE_LOW_POWER:
+			dytc_profile_set(NULL, PLATFORM_PROFILE_BALANCED);
+			break;
+		case PLATFORM_PROFILE_BALANCED:
+			dytc_profile_set(NULL, PLATFORM_PROFILE_PERFORMANCE);
+			break;
+		case PLATFORM_PROFILE_PERFORMANCE:
+			dytc_profile_set(NULL, PLATFORM_PROFILE_LOW_POWER);
+			break;
+		default:
+			pr_warn("Profile HKEY unexpected profile %d", dytc_current_profile);
+		}
+		/* Notify user space the profile changed */
+		platform_profile_notify();
+	}
 }
 
 static void hotkey_driver_event(const unsigned int scancode)
-- 
2.43.0


