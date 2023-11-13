Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3CA7EA18B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjKMQzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMQzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:55:08 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5945D73;
        Mon, 13 Nov 2023 08:55:04 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 72BF35C020C;
        Mon, 13 Nov 2023 11:55:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 13 Nov 2023 11:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1699894502; x=
        1699980902; bh=4nE4dUxYqdoe8QHwz0M06hubKIFptkAxqfhEejltdOs=; b=e
        pNEY1q9ENltwLtFJDHhFkZb4EYkpnBlfK+dfBc0Ym9N9kj+4mBaTDu9uoZbnIp5+
        XEZwtYKwZC631ioYurMjRPmePcQCY+w8Qu+S5syYcL/XYbUoDbjUjKgwLSiQid4b
        +GbgOEvittuByugR1UOHwxAsNtKhhPt9Pt0kNPPaPYD+q/qHoGCpPoUDNtMvoiXo
        Fnye7a4wbSu9tN7lP1r5T7FAclyKEtKXqCUlDTaQE5PpQkSyLgQeWMJqUy971x6G
        IMA95RBy+W8le87b1/TcObhxW7vo7rWM6uyBbEcBae9Dl3Qz402lTGUR23HDJH53
        zFmFjXercrZA7HEKbyMlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1699894502; x=
        1699980902; bh=4nE4dUxYqdoe8QHwz0M06hubKIFptkAxqfhEejltdOs=; b=B
        VXWqpGHbNJoTofNZEb43l23Hr6kXGkONbMXPM2Zez1d0rQ1lX3CSk5PKv60Xga13
        yvmD8RTSnwhcofSIiexxPh7GoaQmSwlEQMz6yNuBepPHI9bwbzpRvsSx58OwRCLd
        x9o7XzbUlQw6DJqYpGn0xoTA9tUdatnrRpn1qd2OUrPpj99tRHdndYYRRt4aOsdS
        dh+9M/BuX18Nd1hezPhm2RZ93/lv4zx7lDqEY4Ue0aEBKgOy1E7LfbDBWq/JIu+x
        sHA6F2wEQN2zFrvND6bnKOdANi5cCDaULcAsUVJqpuyBQp+x4m7BRmIAFV8lgDwe
        h4KPQpagjj+TQX9qomOgw==
X-ME-Sender: <xms:5lRSZT32p3ftJeLgsAe_U8Bh0loKOzJ_Ukha1tXgGDRoTqOt4-YQUw>
    <xme:5lRSZSHC8AdWL1tVIaBLzC_zdOojp_497VvTPZsPcOIjnBIeSPsb-S8Jq-hqccY-L
    DsvSijDeybIo5DLNRc>
X-ME-Received: <xmr:5lRSZT6muDtKDafYze-K2ZYifb-hTDqZ75i6GzM71Xxk_Ov1JBLn-gjsKOROGUj4fb4NoN-fbtfwPmk2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeftddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueet
    hefgvdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:5lRSZY3oBZ3FaRuboYKU-1iRES4qrqBU9RUq0rPot7hNM9md60owdA>
    <xmx:5lRSZWF2sg6UHHLzeOeSR-fiHGD9pYvI3dJ7o0Uyq8_RgQQAT0C74Q>
    <xmx:5lRSZZ8pqlhuRZwfqcjrqmRn8_rP7BmR0m3BruVuM8bqmBlyj1fJgA>
    <xmx:5lRSZTOEg4vU5UHMzE8JfHnYYh_a4ZXsdZlO-CULJQe0f8VCPaUFeA>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Nov 2023 11:55:01 -0500 (EST)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     platform-driver-x86@vger.kernel.org, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com,
        ibm-acpi-devel@lists.sourceforge.net, mario.limonciello@amd.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] platform/x86: Add support for improved performance mode
Date:   Mon, 13 Nov 2023 11:54:33 -0500
Message-ID: <20231113165453.6335-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some new Thinkpads have a new improved performance mode available.
Add support to make this mode usable.

To avoid having to create a new profile, just use the improved performance
mode in place of the existing performance mode, when available.

Tested on P14s AMD G4 AMD.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2: updated implementation for DYTC_UP_SUPPORT define
Changes in v3: 
 - Add in missing BIT for define, somehow lost in previous commit
 - Cosmetic clean-ups

 drivers/platform/x86/thinkpad_acpi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ad460417f901..3a9d2cc71b6a 100644
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
 
+#define DYTC_UP_SUPPORT    BIT(8)  /* Ultra-performance (TMS) mode support */
+
 #define DYTC_ERR_MASK       0xF  /* Bits 0-3 in cmd result are the error result */
 #define DYTC_ERR_SUCCESS      1  /* CMD completed successful */
 
@@ -10185,6 +10190,7 @@ static enum platform_profile_option dytc_current_profile;
 static atomic_t dytc_ignore_event = ATOMIC_INIT(0);
 static DEFINE_MUTEX(dytc_mutex);
 static int dytc_capabilities;
+static bool dytc_ultraperf_cap;
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
+	dytc_ultraperf_cap = output & DYTC_UP_SUPPORT;
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

