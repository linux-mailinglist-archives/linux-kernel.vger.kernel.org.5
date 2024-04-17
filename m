Return-Path: <linux-kernel+bounces-148994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3F28A8A35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B35D1C23B09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C71172796;
	Wed, 17 Apr 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="as0sdHFX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C83JvOc+"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B21171673;
	Wed, 17 Apr 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375098; cv=none; b=hCaLHyHj5bzzCl49yaTtdAniZ3kEG5kxck1bg/G1NHXxM/Bp7/QsL0VhCJmRfZN6kjcWE2qgkFKvgzME5EpHHYhdnQTOStcS2VM7XcrK/YTlGkWW9NKP8Hq7hN3XO0SLa876mnLGzzHfiQPN4XNyIKl4gAh9xgm317eFmu7fHxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375098; c=relaxed/simple;
	bh=fkvBrNWrW0X1rC3prWUWLNLQnJ8S0QdkFsVL3zsBHH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwkgvI+pUJh9RyyGdd8PQ3uMG3v6OkC79EaWG0ofkwa/zRSMXFnN2agpmgqdpyu4WCHm+cwJbf/v0SJDm3DeKwoNAD1+TIj+9qTSQ/d5S9Ck2WkrTP2qpdJWLWyj0hAFfXMGQ5NTjV7ABHwfvLp8c1tM/YR000Dj9X2euv0AnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=as0sdHFX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C83JvOc+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9FEB21380242;
	Wed, 17 Apr 2024 13:31:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 17 Apr 2024 13:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713375095; x=
	1713461495; bh=2xm38a5d29dZKNzZ2Wg3DwnYmxWKLU185JCV5OG0sgI=; b=a
	s0sdHFXSk1//Xe/ymQcGOG//3qTDCqZq6n7Fn8KPxgl5m7wNCTo47VTfclHzp6S+
	9jBkRPi0LmD4v5Nz9xugxDRmOdZLJBNJyo+RJ+YsQfAp41Ajgr+/1YQ2sTTp7EMh
	nwpbEzuT4nFKYCovAUSdZZFvR65SabEVj6FQjmOLAkGPSVLryIJw3DXK2ajDgPrF
	a2ZFtCqEZUALtI5U1KyrGHKoK/0EzmlfNw+DX73ioxGFaimn4t0saqrUge1IaXjf
	wPqiIDYsu+lUIV9YDahrt6cTkUpsLHomMhagjv85W/K9HvCwMiuYc087yWEZiycs
	cQYBPQdqQTjg1FLzktZcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713375095; x=
	1713461495; bh=2xm38a5d29dZKNzZ2Wg3DwnYmxWKLU185JCV5OG0sgI=; b=C
	83JvOc+ls0LAnt5izS/eqKmJ4xTIpbHtD/woYFoLV4tvdNk8EfFBLWn1+B8UPZEW
	paSgnTKSQsZQwlw4AG6Ts0waBzjYzc88xZOKXgIm1Z3+D0yJIX7fINp2fdsTG6YY
	Lqp5yIwJ3UnS+2mpscjruC1o+h51ZJ9V2I5CcU2DtXFxlY3IoCv8iE7x7GM9GVyh
	erbTNRn8X2RLlPZ8/XJcYg6R/7GeCVlzQ/eY0MOzKWHKJsbhfx2IZYd59cvC1D3Z
	+K3BlYIci4Nat7kXyXOMJwwtO40xjirw7fAQLYyQhDGvAhel1qXKYoqvHrBnqv+E
	A9dl5OoKU+De5P7NEKJyw==
X-ME-Sender: <xms:dwcgZqfyakAXbdjY3F85ppuNNPz03E07RMW0jStxAFPKQ_unTsG7DQ>
    <xme:dwcgZkN3dU-uADjbHbSoblRmP3z04Zh4RUTp8uSvyzJvJcsgPYOQm3-WbObs5vPej
    LA4BaBaw2AS6C7mGog>
X-ME-Received: <xmr:dwcgZrhRTmExVjjZCxeJ8t3j6uY4pddjlXsjUagffws1KLkpA6B13cJEpFQRgphlYr5EkAIlZ4fTU4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejkedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:dwcgZn-HR_ZiQbw3wS4rmCUgYrAgZB-p1UUNFJZ8SIiji9SZx47SZQ>
    <xmx:dwcgZmuPiGexPRquj_fLAQg-OA6-U3ffTsrcgg8O-noT93miSp3ueQ>
    <xmx:dwcgZuHOiUddMMJBoiEb6TDMCERtYjdFRNxeM_2EC5H8XGKXh7Kh4A>
    <xmx:dwcgZlPNlI3cvFtWXkMTC0-9hAP1SsHP2SWuFSmQhX20CZThTQV3FQ>
    <xmx:dwcgZuFbJZqSoD494Tp1od_hGxBWohl5qtwf7TwfCTq-hv13GgLZAJND>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Apr 2024 13:31:34 -0400 (EDT)
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
Subject: [PATCH v2 2/4] platform/x86: thinkpad_acpi: Support for trackpoint doubletap
Date: Wed, 17 Apr 2024 13:31:07 -0400
Message-ID: <20240417173124.9953-2-mpearson-lenovo@squebb.ca>
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

Lenovo trackpoints are adding the ability to generate a doubletap event.
This handles the doubletap event and sends the KEY_PROG1 event to
userspace.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
Changes in v2:
 - Use KEY_PROG1 instead of KEY_DOUBLETAP as input maintainer doesn't
   want new un-specific key codes added.
 - Add doubletap to hotkey scan code table and use existing hotkey
   functionality.
 - Tested using evtest, and then gnome settings to configure a custom shortcut
   to launch an application.

 drivers/platform/x86/thinkpad_acpi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 3b48d893280f..6d04d45e8d45 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -232,6 +232,9 @@ enum tpacpi_hkey_event_t {
 
 	/* Misc */
 	TP_HKEY_EV_RFKILL_CHANGED	= 0x7000, /* rfkill switch changed */
+
+	/* Misc2 */
+	TP_HKEY_EV_TRACK_DOUBLETAP      = 0x8036, /* trackpoint doubletap */
 };
 
 /****************************************************************************
@@ -1786,6 +1789,7 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
 	TP_ACPI_HOTKEYSCAN_NOTIFICATION_CENTER,
 	TP_ACPI_HOTKEYSCAN_PICKUP_PHONE,
 	TP_ACPI_HOTKEYSCAN_HANGUP_PHONE,
+	TP_ACPI_HOTKEYSCAN_DOUBLETAP,
 
 	/* Hotkey keymap size */
 	TPACPI_HOTKEY_MAP_LEN
@@ -3336,6 +3340,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_NOTIFICATION_CENTER,	/* Notification Center */
 		KEY_PICKUP_PHONE,		/* Answer incoming call */
 		KEY_HANGUP_PHONE,		/* Decline incoming call */
+		KEY_PROG1,                      /* Trackpoint doubletap */
 		},
 	};
 
@@ -3996,6 +4001,15 @@ static bool hotkey_notify_6xxx(const u32 hkey,
 	return true;
 }
 
+static bool hotkey_notify_8xxx(const u32 hkey)
+{
+	if (hkey == TP_HKEY_EV_TRACK_DOUBLETAP) {
+		tpacpi_input_send_key(TP_ACPI_HOTKEYSCAN_DOUBLETAP);
+		return true;
+	}
+	return false;
+}
+
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	u32 hkey;
@@ -4079,6 +4093,10 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				known_ev = true;
 			}
 			break;
+		case 8:
+			/* 0x8000-0x8FFF: misc2 */
+			known_ev = hotkey_notify_8xxx(hkey);
+			break;
 		}
 		if (!known_ev) {
 			pr_notice("unhandled HKEY event 0x%04x\n", hkey);
-- 
2.44.0


