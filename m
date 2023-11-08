Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6367E5B0B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjKHQVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjKHQVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:21:07 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A4D1FFB;
        Wed,  8 Nov 2023 08:21:05 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5CAF75C00F9;
        Wed,  8 Nov 2023 11:21:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Nov 2023 11:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1699460464; x=
        1699546864; bh=MHBKZb/Eb46RKR9/QfWhwBcQvG49YjnUa+IvbejXnzo=; b=G
        yKlRsubJZaomH/up5+5/ObUmHa6LlwILPlaK0e4KqAJQgHU5jeIM8m3VDth28PHf
        t+lyhLbAC3i3SLowA5tkJEKdyTbEY1eL1k33TCceLProoi2hIvT0hPBq7Jgc8mi7
        eC+HfSTT2HP/ShYGqmrOJzAiGtDfqASbw6zMgzgiLW1tbt+KSpMdyZYcysesBU/m
        XKRUAFkIrNQI2jtzGYa4FnEaawjJZ4wNE4yqvfqvxYo46qy9CdSQjus4FaUjG/Ea
        3PRiN6V9+jOA6kdI4ZPAXNb+mSLysrYkvNPW8CMTn6TDZA+UxFVuGfyZo+QkBHKQ
        uNcjurRMVu0a6uUKdFBqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1699460464; x=
        1699546864; bh=MHBKZb/Eb46RKR9/QfWhwBcQvG49YjnUa+IvbejXnzo=; b=X
        ONCtQ4u0FyaXbXScunTSJsFbvexF3Wl8N+/UB/SsD3lsbG3Bp+lPj0oeWWZqESny
        C9UCDIyTZVnYS5JG32WZgcS2oeKvGFnGA9Q1Y7AoRHC1I1LC5f7GVReLrsQnrAD5
        y/IOWJBI1uBBKbMrwt0Rke13kU3nTTOs3wYk5zPHwqHFJGP5xGBZpepJZoWgnv+G
        M/LmaUFouSxOs2NC1NqiihXYxirv7XqDrJGSdq5YpUEkHXuCq/0gVZiyIr4S6A+J
        J0+lnhfTHMhvXzUpFQYSo96XntrLuwBC853ar+WsKd7aYGV26uX6mMFP4rMtwkSK
        uHBthKMTZbQOv9NuRL4+w==
X-ME-Sender: <xms:cLVLZSRptmhRY_c5H1gmcwV5nYCwDTR1oPuR4LE9l7UqGbXq8zpuvg>
    <xme:cLVLZXw4R-VB9HmsToZPZjr8snq8C_o8oRC16-BJlR0YVcpEDxz_erdpGhxAu48P3
    lh3fxAPBJEPWohtDhE>
X-ME-Received: <xmr:cLVLZf3Mwi0liN9c4ClyZGIV3ZZ_FGrW1nETrzewyXyoxlZTYR2YylYJSKPqPQwpHWYaKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduledgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueet
    hefgvdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:cLVLZeABPCR9pvbqc5S_sHhu6vbmiCXCPf00pujBIgiPkaaXazg1xQ>
    <xmx:cLVLZbjQ_43no8nHAn5_vesDNfZS3x8PQLJz-39_pR6hyG5rX6RuBQ>
    <xmx:cLVLZarK98VN0CVKMb5wMqI7ZMFRLUHmCzoTmcAQuX9yXvWATtiC-A>
    <xmx:cLVLZbc7MRDha1567CNDgdmirPrwXJK3Q30-k7YvH6ZVbo1nOLlTsg>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Nov 2023 11:21:03 -0500 (EST)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     platform-driver-x86@vger.kernel.org, hdegoede@redhat.com,
        ibm-acpi-devel@lists.sourceforge.net, mario.limonciello@amd.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: Add support for improved performance mode
Date:   Wed,  8 Nov 2023 11:20:26 -0500
Message-ID: <20231108162039.13737-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some new Thinkpads have a new improved performance mode available.
Add support to make this mode usable.

To avoid having to create a new profile, just use the improved performance
mode in place of the existing performance mode, when available.

Tested on T14 AMD G4 AMD.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/platform/x86/thinkpad_acpi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ad460417f901..eba701ab340e 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10136,6 +10136,7 @@ static struct ibm_struct proxsensor_driver_data = {
 
 #define DYTC_CMD_SET          1 /* To enable/disable IC function mode */
 #define DYTC_CMD_MMC_GET      8 /* To get current MMC function and mode */
+#define DYTC_CMD_UP_CAP     0xA /* To get Ultra-performance capability */
 #define DYTC_CMD_RESET    0x1ff /* To reset back to default */
 
 #define DYTC_CMD_FUNC_CAP     3 /* To get DYTC capabilities */
@@ -10152,6 +10153,7 @@ static struct ibm_struct proxsensor_driver_data = {
 
 #define DYTC_FUNCTION_STD     0  /* Function = 0, standard mode */
 #define DYTC_FUNCTION_CQL     1  /* Function = 1, lap mode */
+#define DYTC_FUNCTION_TMS     9  /* Function = 9, TMS mode */
 #define DYTC_FUNCTION_MMC     11 /* Function = 11, MMC mode */
 #define DYTC_FUNCTION_PSC     13 /* Function = 13, PSC mode */
 #define DYTC_FUNCTION_AMT     15 /* Function = 15, AMT mode */
@@ -10163,11 +10165,14 @@ static struct ibm_struct proxsensor_driver_data = {
 #define DYTC_MODE_MMC_LOWPOWER 3  /* Low power mode */
 #define DYTC_MODE_MMC_BALANCE  0xF  /* Default mode aka balanced */
 #define DYTC_MODE_MMC_DEFAULT  0  /* Default mode from MMC_GET, aka balanced */
+#define DYTC_NOMODE            0xF  /* When Function does not have a mode */
 
 #define DYTC_MODE_PSC_LOWPOWER 3  /* Low power mode */
 #define DYTC_MODE_PSC_BALANCE  5  /* Default mode aka balanced */
 #define DYTC_MODE_PSC_PERFORM  7  /* High power mode aka performance */
 
+#define DYTC_UP_SUPPORT_BIT    8  /* Bit 8 - 1 = supported, 0 = not */
+
 #define DYTC_ERR_MASK       0xF  /* Bits 0-3 in cmd result are the error result */
 #define DYTC_ERR_SUCCESS      1  /* CMD completed successful */
 
@@ -10185,6 +10190,7 @@ static enum platform_profile_option dytc_current_profile;
 static atomic_t dytc_ignore_event = ATOMIC_INIT(0);
 static DEFINE_MUTEX(dytc_mutex);
 static int dytc_capabilities;
+static bool dytc_ultraperf_cap; /* ultra performance capable */
 static bool dytc_mmc_get_available;
 static int profile_force;
 
@@ -10355,6 +10361,17 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
 	if (err)
 		goto unlock;
 
+	/* Set TMS mode appropriately (enable for performance), if available */
+	if (dytc_ultraperf_cap) {
+		int cmd;
+
+		cmd = DYTC_SET_COMMAND(DYTC_FUNCTION_TMS, DYTC_NOMODE,
+				       profile == PLATFORM_PROFILE_PERFORMANCE);
+		err = dytc_command(cmd, &output);
+		if (err)
+			return err;
+	}
+
 	if (dytc_capabilities & BIT(DYTC_FC_MMC)) {
 		if (profile == PLATFORM_PROFILE_BALANCED) {
 			/*
@@ -10429,6 +10446,7 @@ static struct platform_profile_handler dytc_profile = {
 static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 {
 	int err, output;
+	int cmd;
 
 	/* Setup supported modes */
 	set_bit(PLATFORM_PROFILE_LOW_POWER, dytc_profile.choices);
@@ -10484,6 +10502,16 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");
 		return -ENODEV;
 	}
+	err = dytc_command(DYTC_CMD_UP_CAP, &output);
+	dytc_ultraperf_cap = output & BIT(DYTC_UP_SUPPORT_BIT) ? true : false;
+	if (dytc_ultraperf_cap) {
+		pr_debug("TMS is supported\n");
+		/* Disable TMS by default - only use with performance mode */
+		cmd = DYTC_SET_COMMAND(DYTC_FUNCTION_TMS, DYTC_NOMODE, 0);
+		err = dytc_command(cmd, &output);
+		if (err)
+			return err;
+	}
 
 	dbg_printk(TPACPI_DBG_INIT,
 			"DYTC version %d: thermal mode available\n", dytc_version);
-- 
2.41.0

