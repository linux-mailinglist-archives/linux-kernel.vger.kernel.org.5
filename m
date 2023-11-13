Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9D7E9DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjKMN6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjKMN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:58:02 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F0D54;
        Mon, 13 Nov 2023 05:57:58 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 203125C017F;
        Mon, 13 Nov 2023 08:57:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 Nov 2023 08:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1699883878; x=
        1699970278; bh=ha0eA38T6ZoNAC1OyeuaR9EpucxVvCf1ZGeaLoyGkTU=; b=O
        zXgJe88B6D+hVxNMZoo3SGTRGECVz9IgMU9rTGb03sBkYdR2boZNPeRpizB3QLV+
        sWjU60AP6WQpLeVYadmC8MjVVGPz8GcsTekqRJsFm5MnrAiQbHKsYgHu8N9kvZwk
        MPCKkY3VuzEXvMnwOio7s5PE4PYCUt2D3KwrG5TInEq5muRE4ybtC64QjXxRkdvT
        EIK1DWORyQeFXZz+ETtAtgSGrArpa/vPsiAyWxzxWRz7i+v+U64cC5/hm+6+7u4K
        hyAdrU/qtR+NdrkLFIAl5VKM2R/YP+xq9QeH7bkWJstVkTSKRaKYdTvwh2HErf7I
        L8J6EGErQpKgs4YmpICuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1699883878; x=
        1699970278; bh=ha0eA38T6ZoNAC1OyeuaR9EpucxVvCf1ZGeaLoyGkTU=; b=M
        dJr8VDypmZq8eDdYZRg0javeGRZsjFK5YV9D0lqxuqKdWuahcsAMMqlMTvpzYuaH
        WSr9XsRqAYnQFLu/ruCBBSCVdAAxdNW5absBis2j+X1KiOTIYN+SfGe5vd8NtkKz
        KYEYxrZozZzxUcmOocMsunGbJt/AvaO7Bi0FCF6xUHThY7nJVIswrTSM+B9MSLQQ
        6fg1JvQGTOtIVqDtkIPeMFEt2GlQnDMzI1TymQenkXi8dC9WwxtpZKZCm+SsDKd8
        qTW+yUEtODWMgNUBejkkQgvRbH8L4lwprfNMvylBPpADOvzEvoaaph6Tur5XdF++
        DS3sYm5VpMN16lVlDNcIA==
X-ME-Sender: <xms:ZStSZcLebaf3OgIP9Z2_EJT0a9M37LZGvz8cw8hiLLHYHiU4PUiyMw>
    <xme:ZStSZcJAuN7OQh75NDdcQCWJBmkXai3Pb1I_LRnreZDMyywpLsXgF97Sj2U4gm1dp
    k7zP_xAwHPrdElVgOg>
X-ME-Received: <xmr:ZStSZcs22kT9hiHmsEuAs-hJtvEX-AjIvQ3sjQ3fKiKdvZ2Pj-JjT9rVlgOS2HMWzNEW4ogpxMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeftddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueet
    hefgvdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:ZStSZZYiKzDjqqeI1BfXJgfAW1EaZlOBzrAKS0GO_8mVuPxUTs1UOA>
    <xmx:ZStSZTZC_HV5beWTla6eytTFR4a8qzbsDn8ngOfgcrCJBSOM27S64g>
    <xmx:ZStSZVBRkz6m1O5JjMs3oZfhg8zJPAipwNdk3JTdXBBu6KuZ4AWN-Q>
    <xmx:ZitSZezvwp7zXak-YU5q3NDzDn01oY_qEFdCMsEjtpM3ow4jGLbBtw>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Nov 2023 08:57:57 -0500 (EST)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     platform-driver-x86@vger.kernel.org, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com,
        ibm-acpi-devel@lists.sourceforge.net, mario.limonciello@amd.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: Add support for improved performance mode
Date:   Mon, 13 Nov 2023 08:57:29 -0500
Message-ID: <20231113135741.4787-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

 drivers/platform/x86/thinkpad_acpi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ad460417f901..ed8860caa9c1 100644
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
 
+#define DYTC_UP_SUPPORT        8  /* Ultra-performance (TMS) mode support */
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
+	dytc_ultraperf_cap = output & DYTC_UP_SUPPORT ? true : false;
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

