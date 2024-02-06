Return-Path: <linux-kernel+bounces-55561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E86584BE25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6601F24495
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB89175BE;
	Tue,  6 Feb 2024 19:33:52 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EDC17588;
	Tue,  6 Feb 2024 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707248031; cv=none; b=devFnr7DNUCofOG9W1jXVJ4H2FGwHZXpHd6T1u3w1DLuuATOr64EQrzHluRKB/SYDwpoPckHh2/qN4DmtPb8d40aeB+0eHeio+bkeJwoouyuqy2fn+DCRveIZhe+I5A/+VHyuiSF9o7MIJkRxZYoxlOCRpDi0iv9Q/NQBhW913I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707248031; c=relaxed/simple;
	bh=hPCr97Z9WyFkP6rn0WJSREQ0TMUx4xLjks+aVxQlXd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e36PzRZCZL+1JxqSIJr7lCHtpUCtyv9IGXrdCtd/BW+HZAqlm7M46hw57W2BWyt7+lmzi5ZAcveyt6rISFt1l6JRnR+khXh2tKFzrSBXvtY2Lx6TCawtZCCp1KWgmwk3FiYv0c3sv3S3vjmsyXq93a0YwmhP6tHKrbmDcf0u1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 2129a190197e812a; Tue, 6 Feb 2024 20:33:46 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C2DB7669A9F;
	Tue,  6 Feb 2024 20:33:45 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 David Box <david.e.box@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1] ACPI: PM: s2idle: Enable Low-Power S0 Idle MSFT UUID for non-AMD
 systems
Date: Tue, 06 Feb 2024 20:33:45 +0100
Message-ID: <12388452.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgr
 shdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepshhtrghnihhslhgrfidrghhruhhsiihkrgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Systems based on Intel platforms that use the MSFT UUID for Low-Power S0
Idle (LPS0) have started to ship, so allow the kernel to use the MSFT
UUID in the non-AMD case too, but in that case make it avoid evaluating
the same _DSM function for two different UUIDs and prioritize the MSFT
one.

While at it, combine two MSFT _DSM function mask checks in
acpi_s2idle_restore_early() so as to make it reflect the
acpi_s2idle_prepare_late() flow more closely and adjust the
Modern Standby entry and exit comments slightly.

Non-AMD systems that do not support MSFT UUID for Low-power S0 Idle are
not expected to be affected by this change in any way.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/s2idle.c |   37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/x86/s2idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/x86/s2idle.c
+++ linux-pm/drivers/acpi/x86/s2idle.c
@@ -488,7 +488,21 @@ static int lps0_device_attach(struct acp
 		rev_id = 1;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID, rev_id, &lps0_dsm_guid);
-		lps0_dsm_func_mask_microsoft = -EINVAL;
+		if (lps0_dsm_func_mask > 0 && lps0_dsm_func_mask_microsoft > 0) {
+			unsigned int func_mask;
+
+			/*
+			 * Avoid evaluating the same _DSM function for two
+			 * different UUIDs and prioritize the MSFT one.
+			 */
+			func_mask = lps0_dsm_func_mask & lps0_dsm_func_mask_microsoft;
+			if (func_mask) {
+				acpi_handle_info(adev->handle,
+						 "Duplicate LPS0 _DSM functions (mask: 0x%x)\n",
+						 func_mask);
+				lps0_dsm_func_mask &= ~func_mask;
+			}
+		}
 	}
 
 	if (lps0_dsm_func_mask < 0 && lps0_dsm_func_mask_microsoft < 0)
@@ -549,19 +563,22 @@ int acpi_s2idle_prepare_late(void)
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 
 	/* LPS0 entry */
-	if (lps0_dsm_func_mask > 0)
-		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
-					ACPI_LPS0_ENTRY_AMD :
-					ACPI_LPS0_ENTRY,
+	if (lps0_dsm_func_mask > 0 && acpi_s2idle_vendor_amd())
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
 					lps0_dsm_func_mask, lps0_dsm_guid);
+
 	if (lps0_dsm_func_mask_microsoft > 0) {
-		/* modern standby entry */
+		/* Modern Standby entry */
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 	}
 
+	if (lps0_dsm_func_mask > 0 && !acpi_s2idle_vendor_amd())
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
+					lps0_dsm_func_mask, lps0_dsm_guid);
+
 	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
 		if (handler->prepare)
 			handler->prepare();
@@ -600,14 +617,14 @@ void acpi_s2idle_restore_early(void)
 					ACPI_LPS0_EXIT_AMD :
 					ACPI_LPS0_EXIT,
 					lps0_dsm_func_mask, lps0_dsm_guid);
-	if (lps0_dsm_func_mask_microsoft > 0)
+
+	if (lps0_dsm_func_mask_microsoft > 0) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-
-	/* Modern standby exit */
-	if (lps0_dsm_func_mask_microsoft > 0)
+		/* Modern Standby exit */
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+	}
 
 	/* Screen on */
 	if (lps0_dsm_func_mask_microsoft > 0)




