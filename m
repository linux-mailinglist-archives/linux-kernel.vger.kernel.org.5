Return-Path: <linux-kernel+bounces-126583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F898939E8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06E5281DBC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4050E13FEA;
	Mon,  1 Apr 2024 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IECkVOhi"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA6F1113;
	Mon,  1 Apr 2024 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965744; cv=none; b=oFP+0w2v75XPQ+TiqVaQGuo+t/f737cNLMfmT+avuvFc3rCmr3o26bml9n0KyJ/j4Deds/JVjmJPIk6yK9cnk+L4lrQiLjbmHFCldVFsEO6e04/I6E/OscAFcyTQvucNV80MR0Y3OkPdenK7ARXW40rA8g2ZM4rJ0XpIxQyTsys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965744; c=relaxed/simple;
	bh=ImXU1s+ziaP2Z40BfdA5X2xpNVe3p9EN+iG/UF6M7pY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FS8mJnIadqFs3EYSeDRmfvWK3N0dEhIPqo9B7NTA+qLXkzK6afUEmPGi9oIFhwH3xk3Ien8Fcax9sZlsXB+4TCEKZoimL1TVcfUQoFvfj7iV6O0emXnlXmd3EvSJFEt3Lf66PAhTyVvyocsb1b0nHDeFp7CMqReCPAbsdXTLXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IECkVOhi; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4315mEb3029960;
	Mon, 1 Apr 2024 05:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=BsjfU2++YD2KMtQsHziYmhBOdrFvAcXQOjckWGQdiCY=; b=
	IECkVOhisZ8akWVbju5r4GLAZCv6pwUaoSJSzljfnBvXf8EAoJUAbtTVJsJu8i4y
	i30+dk+1MsqgUZsfIyFIke/sE6Vr0yi/B0TWLGuWJFZmCC5xnX62peLzX/1XiqsH
	n85WCD+xxo/j2jFZWxKlKDEQikphYdQFjSMk2fwaq0nYWSbMsjOJlNIdznECePCF
	Fdb7Wt09FiPFT3o9yWdEmPU0fvCjMA4PpIUcjjEW1OLoGbS4738QoISFMDrVSSXC
	E4yKkYeIVQCV6lirvxS5gw/j6CvDPIKQ3NVEKZnxHLjHiwHc9sbHTnkX8JdSNYVj
	zrONt9flIr9+YsJRmNtOBw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x6g4xhtw6-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 05:02:14 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Apr 2024
 11:02:10 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 1 Apr 2024 11:02:10 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 43DD7820271;
	Mon,  1 Apr 2024 10:02:10 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v2 3/3] ASoC: soc-card: Add KUnit test case for snd_soc_card_get_kcontrol
Date: Mon, 1 Apr 2024 10:02:10 +0000
Message-ID: <20240401100210.61277-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240401100210.61277-1-rf@opensource.cirrus.com>
References: <20240401100210.61277-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UmITU5UMEQXXuzPm6VTxcYNBRm-NEamv
X-Proofpoint-GUID: UmITU5UMEQXXuzPm6VTxcYNBRm-NEamv
X-Proofpoint-Spam-Reason: safe

Add a new snd-soc-card KUnit test with a simple test case for
snd_soc_card_get_kcontrol() and snd_soc_card_get_kcontrol_locked().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/Kconfig         |   8 ++
 sound/soc/Makefile        |   4 +
 sound/soc/soc-card-test.c | 184 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 sound/soc/soc-card-test.c

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 439fa631c342..a52afb423b46 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -66,6 +66,14 @@ config SND_SOC_TOPOLOGY_KUNIT_TEST
 	  userspace applications such as pulseaudio, to prevent unnecessary
 	  problems.
 
+config SND_SOC_CARD_KUNIT_TEST
+	tristate "KUnit tests for SoC card"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  If you want to perform tests on ALSA SoC card functions say Y here.
+	  If unsure, say N.
+
 config SND_SOC_UTILS_KUNIT_TEST
 	tristate "KUnit tests for SoC utils"
 	depends on KUNIT
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 8376fdb217ed..f90f5300b36e 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -12,6 +12,10 @@ ifneq ($(CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST),)
 obj-$(CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST) += soc-topology-test.o
 endif
 
+ifneq ($(CONFIG_SND_SOC_CARD_KUNIT_TEST),)
+obj-$(CONFIG_SND_SOC_CARD_KUNIT_TEST) += soc-card-test.o
+endif
+
 ifneq ($(CONFIG_SND_SOC_UTILS_KUNIT_TEST),)
 # snd-soc-test-objs := soc-utils-test.o
 obj-$(CONFIG_SND_SOC_UTILS_KUNIT_TEST) += soc-utils-test.o
diff --git a/sound/soc/soc-card-test.c b/sound/soc/soc-card-test.c
new file mode 100644
index 000000000000..075c52fe82e5
--- /dev/null
+++ b/sound/soc/soc-card-test.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2024 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <kunit/device.h>
+#include <kunit/test.h>
+#include <linux/module.h>
+#include <sound/control.h>
+#include <sound/soc.h>
+#include <sound/soc-card.h>
+
+struct soc_card_test_priv {
+	struct device *card_dev;
+	struct snd_soc_card *card;
+};
+
+static const struct snd_kcontrol_new test_card_controls[] = {
+	SOC_SINGLE("Fee", SND_SOC_NOPM, 0, 1, 0),
+	SOC_SINGLE("Fi", SND_SOC_NOPM, 1, 1, 0),
+	SOC_SINGLE("Fo", SND_SOC_NOPM, 2, 1, 0),
+	SOC_SINGLE("Fum", SND_SOC_NOPM, 3, 1, 0),
+	SOC_SINGLE("Left Fee", SND_SOC_NOPM, 4, 1, 0),
+	SOC_SINGLE("Right Fee", SND_SOC_NOPM, 5, 1, 0),
+	SOC_SINGLE("Left Fi", SND_SOC_NOPM, 6, 1, 0),
+	SOC_SINGLE("Right Fi", SND_SOC_NOPM, 7, 1, 0),
+	SOC_SINGLE("Left Fo", SND_SOC_NOPM, 8, 1, 0),
+	SOC_SINGLE("Right Fo", SND_SOC_NOPM, 9, 1, 0),
+	SOC_SINGLE("Left Fum", SND_SOC_NOPM, 10, 1, 0),
+	SOC_SINGLE("Right Fum", SND_SOC_NOPM, 11, 1, 0),
+};
+
+static void test_snd_soc_card_get_kcontrol(struct kunit *test)
+{
+	struct soc_card_test_priv *priv = test->priv;
+	struct snd_soc_card *card = priv->card;
+	struct snd_kcontrol *kc;
+	struct soc_mixer_control *mc;
+	int i, ret;
+
+	ret = snd_soc_add_card_controls(card, test_card_controls, ARRAY_SIZE(test_card_controls));
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/* Look up every control */
+	for (i = 0; i < ARRAY_SIZE(test_card_controls); ++i) {
+		kc = snd_soc_card_get_kcontrol(card, test_card_controls[i].name);
+		KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, kc, "Failed to find '%s'\n",
+						 test_card_controls[i].name);
+		if (!kc)
+			continue;
+
+		/* Test that it is the correct control */
+		mc = (struct soc_mixer_control *)kc->private_value;
+		KUNIT_EXPECT_EQ_MSG(test, mc->shift, i, "For '%s'\n", test_card_controls[i].name);
+	}
+
+	/* Test some names that should not be found */
+	kc = snd_soc_card_get_kcontrol(card, "None");
+	KUNIT_EXPECT_NULL(test, kc);
+
+	kc = snd_soc_card_get_kcontrol(card, "Left None");
+	KUNIT_EXPECT_NULL(test, kc);
+
+	kc = snd_soc_card_get_kcontrol(card, "Left");
+	KUNIT_EXPECT_NULL(test, kc);
+
+	kc = snd_soc_card_get_kcontrol(card, NULL);
+	KUNIT_EXPECT_NULL(test, kc);
+}
+
+static void test_snd_soc_card_get_kcontrol_locked(struct kunit *test)
+{
+	struct soc_card_test_priv *priv = test->priv;
+	struct snd_soc_card *card = priv->card;
+	struct snd_kcontrol *kc, *kcw;
+	struct soc_mixer_control *mc;
+	int i, ret;
+
+	ret = snd_soc_add_card_controls(card, test_card_controls, ARRAY_SIZE(test_card_controls));
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/* Look up every control */
+	for (i = 0; i < ARRAY_SIZE(test_card_controls); ++i) {
+		down_read(&card->snd_card->controls_rwsem);
+		kc = snd_soc_card_get_kcontrol_locked(card, test_card_controls[i].name);
+		up_read(&card->snd_card->controls_rwsem);
+		KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, kc, "Failed to find '%s'\n",
+						 test_card_controls[i].name);
+		if (!kc)
+			continue;
+
+		/* Test that it is the correct control */
+		mc = (struct soc_mixer_control *)kc->private_value;
+		KUNIT_EXPECT_EQ_MSG(test, mc->shift, i, "For '%s'\n", test_card_controls[i].name);
+
+		down_write(&card->snd_card->controls_rwsem);
+		kcw = snd_soc_card_get_kcontrol_locked(card, test_card_controls[i].name);
+		up_write(&card->snd_card->controls_rwsem);
+		KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, kcw, "Failed to find '%s'\n",
+						 test_card_controls[i].name);
+
+		KUNIT_EXPECT_PTR_EQ(test, kc, kcw);
+	}
+
+	/* Test some names that should not be found */
+	down_read(&card->snd_card->controls_rwsem);
+	kc = snd_soc_card_get_kcontrol_locked(card, "None");
+	up_read(&card->snd_card->controls_rwsem);
+	KUNIT_EXPECT_NULL(test, kc);
+
+	down_read(&card->snd_card->controls_rwsem);
+	kc = snd_soc_card_get_kcontrol_locked(card, "Left None");
+	up_read(&card->snd_card->controls_rwsem);
+	KUNIT_EXPECT_NULL(test, kc);
+
+	down_read(&card->snd_card->controls_rwsem);
+	kc = snd_soc_card_get_kcontrol_locked(card, "Left");
+	up_read(&card->snd_card->controls_rwsem);
+	KUNIT_EXPECT_NULL(test, kc);
+
+	down_read(&card->snd_card->controls_rwsem);
+	kc = snd_soc_card_get_kcontrol_locked(card, NULL);
+	up_read(&card->snd_card->controls_rwsem);
+	KUNIT_EXPECT_NULL(test, kc);
+}
+
+static int soc_card_test_case_init(struct kunit *test)
+{
+	struct soc_card_test_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	test->priv = priv;
+
+	priv->card_dev = kunit_device_register(test, "sound-soc-card-test");
+	priv->card_dev = get_device(priv->card_dev);
+	if (!priv->card_dev)
+		return -ENODEV;
+
+	priv->card = kunit_kzalloc(test, sizeof(*priv->card), GFP_KERNEL);
+	if (!priv->card)
+		return -ENOMEM;
+
+	priv->card->name = "soc-card-test";
+	priv->card->dev = priv->card_dev;
+	priv->card->owner = THIS_MODULE;
+
+	ret = snd_soc_register_card(priv->card);
+	if (!ret)
+		return ret;
+
+	return 0;
+}
+
+static void soc_card_test_case_exit(struct kunit *test)
+{
+	struct soc_card_test_priv *priv = test->priv;
+
+	if (priv->card)
+		snd_soc_unregister_card(priv->card);
+
+	if (priv->card_dev)
+		put_device(priv->card_dev);
+}
+
+static struct kunit_case soc_card_test_cases[] = {
+	KUNIT_CASE(test_snd_soc_card_get_kcontrol),
+	KUNIT_CASE(test_snd_soc_card_get_kcontrol_locked),
+	{}
+};
+
+static struct kunit_suite soc_card_test_suite = {
+	.name = "soc-card",
+	.test_cases = soc_card_test_cases,
+	.init = soc_card_test_case_init,
+	.exit = soc_card_test_case_exit,
+};
+
+kunit_test_suites(&soc_card_test_suite);
+
+MODULE_DESCRIPTION("ASoC soc-card KUnit test");
+MODULE_LICENSE("GPL");
-- 
2.39.2


