Return-Path: <linux-kernel+bounces-112855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD5B887F0B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CB31C210A2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A40C3FE37;
	Sun, 24 Mar 2024 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="ec8Kipxb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VAL8N/sF"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E481C291;
	Sun, 24 Mar 2024 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711314521; cv=none; b=PxHBZ2Xw9fG2kjYV28z1ntiELn2k8E9IOqBC5iYtyP2LzgpWaAG9ECMrwemWvUKhIhi0Bo8df8V7JStY935GaPj67tiEFoIrZ6vWVz3VaeYdYH3qNj1FAioHj547QahIcDgFDWnzZrb0VLf+QHdjdQkIqxByLongjsw6oR/eBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711314521; c=relaxed/simple;
	bh=LPqpb/BTLXp5dEMIZD2PSr8NXmFsTBoT9dhSycYnLhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzmPP4+1thkoqNHkUibESLrpxWLjVIdzUwV5+qWLemQCTvKE1fmhAFwaTj5RuyCepnJmOFIIfuNQ14NT9PbTPwhEw0s4fXzUhDvpGavbylFwvWrQ0E6424uX5W8KKQuzrVrp3lk6W1cpVxpIv1rVvedYXe5DUeZJqUotwQip/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=ec8Kipxb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VAL8N/sF; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6361811400F5;
	Sun, 24 Mar 2024 17:08:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 24 Mar 2024 17:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711314518; x=
	1711400918; bh=lkjwIduruMi5XWo7srkLWDeR2ShYX9J54RxCXveF3IE=; b=e
	c8KipxblEsfe2xO3yWVPYh2e/SrbALb6c6wFJ6UvJWHKDIKlHubdCJ7lYlGuXj+C
	LYf//CwZeOddSWvcLNJLjfHYYoHEbxU5ok5OvSoa61hKZkoEo6Z3RBnVr6T9udgv
	t7VJFqiukfb5HVg4F1ozj3VtXK+kMg1z6XWxBl6JEVGes22Nz3e6WhWPf3uhyiIw
	Rnc55/RFqlYd0Vaw+BzjnglCQ0oMFDSLMVjdsl5lcE5C6cxmqnT15akSWeHzaGaV
	Dd07t4gprkLSw6+rcTxbUttSV2xC3y4ETn1iG1kdI32zGYRY+vPh0bdTiRklWf3g
	dOqep8Ydl2eO/rCjsZspA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711314518; x=
	1711400918; bh=lkjwIduruMi5XWo7srkLWDeR2ShYX9J54RxCXveF3IE=; b=V
	AL8N/sFCz2LnqQ1RQHk6JF0XeznA7zEM+UQCmNR5lDKcQ79VhQy6q8rfkuSLWWBV
	EyuDctxNaihBquyh6IC7vNDB8miIf/u0Lp1Wo2xp1EyYd909Ky793CPNHcEdz5B8
	2XgfgNYLy0j4b3I8fk5Y/qc1OIeooBzhdbk0cgHfB3P7zvcXJ6JfSnqyHvyUCten
	HFNx5YeLrQHqSgMV3pT+c8qSI/U5kwsq4gsZBmcU1zHSMtrbkSN1uxch8q0ni22z
	fT/DlqKWHvWjTPIBBpncEpxCu/kszlWaPXQHsxsVN+d0yJFm4rs9NHAzZq7g2p4c
	Hnh56OuxDdXKCHiJH88Ag==
X-ME-Sender: <xms:VpYAZlYgopMuK7oXIW6BMmkrB1if_Pbsc21mwnrql0ooJS5jqKegeA>
    <xme:VpYAZsYkUzAXWi3qtaylMJoW1xpGVFR-QjquLxa20PRLXCqKp9ItUpe5C-Dw-62tT
    p3H9qAc0fIcfLSCNKQ>
X-ME-Received: <xmr:VpYAZn_kWNhU38XgsMoKvVOzHi_eAhfBYIYeMFB4KJNiZEGOSMwyiLdFxY7u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:VpYAZjrQGgf5C5sCJ2wFNQUeOmGHjOHyViu9Te0oPZmT4PVUKAtXqw>
    <xmx:VpYAZgqJOpvh6C2bTlh5dsQAaUBJ2T-caRFsxKo8FlhNCXqNRv1oEA>
    <xmx:VpYAZpTxKTEoib53ruJt2LAbMplbAdROY3vZG7ktwZe1B3_pN8P09A>
    <xmx:VpYAZopl9BymDMN-gfMwVGK9fBvcoE40s5GA5CIyBWYHDqMA1EjZRQ>
    <xmx:VpYAZt7DwJk1CvYdvdR6W6MglubzjwpDZj2GufwH1wKvOYwJY7eFPw>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Mar 2024 17:08:37 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	hmh@hmh.eng.br,
	dmitry.torokhov@gmail.com,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	njoshi1@lenovo.com,
	vsankar@lenovo.com,
	peter.hutterer@redhat.com
Subject: [PATCH 4/4] platform/x86: thinkpad_acpi: Support hotkey to disable trackpoint doubletap
Date: Sun, 24 Mar 2024 17:08:01 -0400
Message-ID: <20240324210817.192033-5-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
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
Signed-off-by: Vishnu Sankar <vsankar@lenovo.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 854ce971bde2..21756aa3d28d 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -167,6 +167,7 @@ enum tpacpi_hkey_event_t {
 	TP_HKEY_EV_VOL_MUTE		= 0x1017, /* Mixer output mute */
 	TP_HKEY_EV_PRIVACYGUARD_TOGGLE	= 0x130f, /* Toggle priv.guard on/off */
 	TP_HKEY_EV_AMT_TOGGLE		= 0x131a, /* Toggle AMT on/off */
+	TP_HKEY_EV_DOUBLETAP_TOGGLE	= 0x131c, /* Toggle trackpoint doubletap on/off */
 	TP_HKEY_EV_PROFILE_TOGGLE	= 0x131f, /* Toggle platform profile */
 
 	/* Reasons for waking up from S3/S4 */
@@ -354,6 +355,7 @@ static struct {
 	u32 hotkey_poll_active:1;
 	u32 has_adaptive_kbd:1;
 	u32 kbd_lang:1;
+	u32 trackpoint_doubletap:1;
 	struct quirk_entry *quirks;
 } tp_features;
 
@@ -3598,6 +3600,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 	hotkey_poll_setup_safe(true);
 
+	/* Enable doubletap by default */
+	tp_features.trackpoint_doubletap = 1;
+
 	return 0;
 }
 
@@ -3739,6 +3744,7 @@ static bool hotkey_notify_extended_hotkey(const u32 hkey)
 	case TP_HKEY_EV_PRIVACYGUARD_TOGGLE:
 	case TP_HKEY_EV_AMT_TOGGLE:
 	case TP_HKEY_EV_PROFILE_TOGGLE:
+	case TP_HKEY_EV_DOUBLETAP_TOGGLE:
 		tpacpi_driver_event(hkey);
 		return true;
 	}
@@ -4092,13 +4098,15 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				send_acpi_ev = true;
 				ignore_acpi_ev = false;
 				known_ev = true;
-				/* Send to user space */
-				mutex_lock(&tpacpi_inputdev_send_mutex);
-				input_report_key(tpacpi_inputdev, KEY_DOUBLECLICK, 1);
-				input_sync(tpacpi_inputdev);
-				input_report_key(tpacpi_inputdev, KEY_DOUBLECLICK, 0);
-				input_sync(tpacpi_inputdev);
-				mutex_unlock(&tpacpi_inputdev_send_mutex);
+				if (tp_features.trackpoint_doubletap) {
+					/* Send to user space */
+					mutex_lock(&tpacpi_inputdev_send_mutex);
+					input_report_key(tpacpi_inputdev, KEY_DOUBLECLICK, 1);
+					input_sync(tpacpi_inputdev);
+					input_report_key(tpacpi_inputdev, KEY_DOUBLECLICK, 0);
+					input_sync(tpacpi_inputdev);
+					mutex_unlock(&tpacpi_inputdev_send_mutex);
+				}
 				break;
 			}
 			fallthrough;	/* to default */
@@ -11228,6 +11236,8 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
 		/* Notify user space the profile changed */
 		platform_profile_notify();
 	}
+	if (hkey_event == TP_HKEY_EV_DOUBLETAP_TOGGLE)
+		tp_features.trackpoint_doubletap = !tp_features.trackpoint_doubletap;
 }
 
 static void hotkey_driver_event(const unsigned int scancode)
-- 
2.44.0


