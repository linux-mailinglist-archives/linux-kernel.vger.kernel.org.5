Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42792784E07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 03:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjHWBKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 21:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjHWBKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 21:10:24 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FD6CFE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:10:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9AF075C0265;
        Tue, 22 Aug 2023 21:10:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 22 Aug 2023 21:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1692753018; x=1692839418; bh=gZdy86/SvE
        E6bL2/16ZsEgT/hirdSxgq9NqLb3XSgvo=; b=Xwe7sKbA0/wp/3LeYLV57Gr9Dk
        ukQuTcCFcalaErE9hLyDx3/sIXMovRxkq502NfBSq4W3y2NOT02Cf1p3N8D0Tl7l
        h/6Pvg3HJMF2cbfOprk+Z+pRTlL2IiTNx+/LXBMMHqLbin6DJvssG/q6nC+rX9Ch
        PgOLszILm1p7hwNStHfJa++w2gRgsOXr6QlFnf1trxFZV0cF+uz1PZhemSKpY4aP
        +P66TJ4oHgUhSKix8ShPvECbd2YVhpGjZucMKiPIpaqeuQV2SIMgbMHldjK7UYRt
        5S7caJlzL8rfzhwtynmL2hIEjl0Ry2ha49uRttGpcGqPd+PhOoSYvrtGy+NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692753018; x=1692839418; bh=gZdy86/SvEE6b
        L2/16ZsEgT/hirdSxgq9NqLb3XSgvo=; b=DYOgQ90uVCBRFkCx5ZE54qo079mM/
        Pfkjm8WLMxLc6xIeDyRQpsqh+mS1yCYcNkN32CUkXoBAvjLKome8RyeVg/9iVROH
        XehBDL08IjHMh7/Ar5PGbchHYD71SrvkTVhTOismEi/g504LX1eDyNd5aP64/0EY
        4K86/2yfSdnfF6+KXgZYclwbNP8Z0HmUzM0DfnWD77YJrdprTdFJZbc/TfBZ7LK0
        jzQNn61KYt9m6M/Xvs6pSu8NgsRg6YC/WlEwa7U1xSwPT66wEnO4xYatWnGYA5eH
        OSq+5hlbrMi+E2o6KSjNdg+KCgYta/gqVCdRoQWKbdAByR2dlnhBuB04w==
X-ME-Sender: <xms:elzlZPfcb3oW7z9Y6M0ZmGrkf0S5G5tPxY1veRKzpQau9QxunKnZzg>
    <xme:elzlZFMb0c-_dUq-1FsY9WKCYHqVN3Bq6iSfB09psN3h774iI6zMkllctbq0a6Q6-
    6v5QC0kfUnbzf5Bgxc>
X-ME-Received: <xmr:elzlZIiMeXzvq5bNhPcy56jJ1uMItdksP1dBasBdLOemNOb6RJtsgX0KFkqS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepfdfnuhhkvgcu
    ffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpefgudejtdfhuddukefffeekiefftddtvdfhgeduudeuffeuhfefgfegfeetvedv
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:elzlZA9yRvZeM1GTaQMAt-aTM0oMZVTBG1AozbTLm_P2qZL3ql2e0g>
    <xmx:elzlZLvOj4obUwh1uA3Ro7qoQmb3UcwkQuPc0FxtJer213tkcuXoGA>
    <xmx:elzlZPGjQXKUXcl_XDuvA7_J-t-mc-n19wiXQU9zmHKVeLBjpTAm5A>
    <xmx:elzlZBV2B5XFb3N23U1RjXZQSWVucNuyEXupmSxWdsAHI1BIjM7D7A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 21:10:15 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        sbinding@opensource.cirrus.com, "Luke D. Jones" <luke@ljones.dev>,
        Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH] ALSA: hda: cs35l41: Support ASUS 2023 laptops with missing DSD
Date:   Wed, 23 Aug 2023 13:10:08 +1200
Message-ID: <20230823011008.13146-1-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support adding the missing DSD properties required  for ASUS ROG 2023
laptops and other ASUS laptops to properly utilise the cs35l41.

This support includes both I2C and SPI connected amps.

The SPI connected amps may be required to use an external DSD patch
to fix or add the "cs-gpios" property.

Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/cs35l41_hda_property.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 673f23257a09..69879ab57918 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -43,6 +43,31 @@ static int lenovo_legion_no_acpi(struct cs35l41_hda *cs35l41, struct device *phy
 	return 0;
 }
 
+/*
+ * The CSC3551 is used in almost the entire ASUS ROG laptop range in 2023, this is likely to
+ * also include many non ROG labelled laptops. It is also used with either I2C connection or
+ * SPI connection. The SPI connected versions may be missing a chip select GPIO and require
+ * an DSD table patch.
+ */
+static int asus_rog_2023_no_acpi(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
+				const char *hid)
+{
+	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
+
+	/* check SPI or I2C address to assign the index */
+	cs35l41->index = (id == 0 || id == 0x40) ? 0 : 1;
+	cs35l41->channel_index = 0;
+	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
+	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 2);
+	hw_cfg->spk_pos = cs35l41->index;
+	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
+	hw_cfg->gpio2.valid = true;
+	hw_cfg->bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
+	hw_cfg->valid = true;
+
+	return 0;
+}
+
 struct cs35l41_prop_model {
 	const char *hid;
 	const char *ssid;
@@ -53,6 +78,7 @@ struct cs35l41_prop_model {
 const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
+	{ "CSC3551", NULL, asus_rog_2023_no_acpi },
 	{}
 };
 
-- 
2.41.0

