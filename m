Return-Path: <linux-kernel+bounces-124897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1200C891E00
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87380B2CCEE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96931238168;
	Fri, 29 Mar 2024 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL//vnsn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D649123658B;
	Fri, 29 Mar 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716388; cv=none; b=o7SH26qL+sMrAG8IbOzHx9RhH9M0ccbivXdjcAPaEthKkenZL25OMTw12RQXs+TUxiYlTaAqBZ4Acw36gRB0g6qHef8elLfiNND+LDzXM1cESFLYFpelfVIX8yEDZXRpRXKod7/Fx36WGbY5cLRa4DfgRh8zEUpLkJh7mc29FcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716388; c=relaxed/simple;
	bh=oC2Wv1oSxUrAS8eJuP0RItudpO00CkGVe6OsWXeu2A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAhRJ2hpqGjHdzjlAOIdgxrPGTfw5mjfH+O3VFI55rpCL4Nn0991LqfORT1Az+qolgdP2+GcS8IbRaHCw+s32mLYk7CCNXRH3VOJG6T/9ZXPWVUsdM+5J3uDJ28ei2xipNvll3QYbs5JCOCJNaiDl+M5qiSduWR8RkciNcmoEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL//vnsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF60AC433F1;
	Fri, 29 Mar 2024 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716388;
	bh=oC2Wv1oSxUrAS8eJuP0RItudpO00CkGVe6OsWXeu2A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eL//vnsngcTBpXFOJJaIPDgfDvC2LIJBvnCRtMc01/GypTlUi1VQBfNsOrt792ots
	 p8fz5Zbo1HKlQSz+cC0yVMrhqsae83zzupcHr69LNIwGflB3mJwehNCvnzFJRcBoC3
	 d4heAi6ENpQB9Z+yw55rovhka3IV2//Y5ZHZ6VBqsMa1qnG8Lf8PXkp9CbEgCs7GB4
	 4/a6pU6r7P9OOI1Oso0Y2YvvDnGW5liUnElmXgwmtoQm4mv1srqmwYYrguMBXVEE1a
	 IUppE97jFDUzT1eMDrjI8ESlYn3A+p8zaYF10QEbXBxi6ho7w6xlh9W1qfv6XrAxKD
	 h4xGTsOZLYpNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: mosomate <mosomate@gmail.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	vkoul@kernel.org,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	ckeepax@opensource.cirrus.com,
	uday.m.bhat@intel.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 13/52] ASoC: Intel: common: DMI remap for rebranded Intel NUC M15 (LAPRC710) laptops
Date: Fri, 29 Mar 2024 08:45:07 -0400
Message-ID: <20240329124605.3091273-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: mosomate <mosomate@gmail.com>

[ Upstream commit c13e03126a5be90781084437689724254c8226e1 ]

Added DMI quirk to handle the rebranded variants of Intel NUC M15
(LAPRC710) laptops. The DMI matching is based on motherboard
attributes.

Link: https://github.com/thesofproject/linux/issues/4218
Signed-off-by: Máté Mosonyi <mosomate@gmail.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20240208165545.93811-20-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/dmi-quirks.c   |  8 ++++++++
 sound/soc/intel/boards/sof_sdw.c | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 9ebdd0cd0b1cf..91ab97a456fa9 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -130,6 +130,14 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 		},
 		.driver_data = (void *)intel_rooks_county,
 	},
+	{
+		/* quirk used for NUC15 LAPRC710 skew */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "LAPRC710"),
+		},
+		.driver_data = (void *)intel_rooks_county,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 985012f2003e2..d1e6e4208c376 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -224,6 +224,17 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					SOF_SDW_PCH_DMIC |
 					RT711_JD2_100K),
 	},
+	{
+		/* NUC15 LAPRC710 skews */
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "LAPRC710"),
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					SOF_SDW_PCH_DMIC |
+					RT711_JD2_100K),
+	},
 	/* TigerLake-SDCA devices */
 	{
 		.callback = sof_sdw_quirk_cb,
-- 
2.43.0


