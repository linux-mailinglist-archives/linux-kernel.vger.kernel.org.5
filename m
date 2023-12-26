Return-Path: <linux-kernel+bounces-11245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 029F781E39E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9353A1F21DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC2B57867;
	Tue, 26 Dec 2023 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNdeSH+M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4257864;
	Tue, 26 Dec 2023 00:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82ED1C433C8;
	Tue, 26 Dec 2023 00:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550212;
	bh=9fVoemh4SbH+Aplq3ecCyddSfrbzpMzxsGNtQXo0FoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gNdeSH+MKsvdBjRuOmXm0xh435xB4KAu3FzhTHroqQ7GOB9lKM5crVajgi0RqAEFn
	 GtpPbkw/r8bHTOsqNcLJBunoHo3PsMPparbG9eJDMluUWiPa661m6wWbaVGDjnYgvc
	 vRvQwr4Y4mrHSwqTyJvrFDQjXVx5w1YwRysSgduXiR3EtBZbi+o3+7w/Z5RAoe7zEX
	 PnWJ1iKMOfOGaTiGxC9zn34DqSQ5ACzBTl74oOd8bZT5QjFIzvEI2+PSWVVXbKJQF+
	 0J46K2M1Dip91Wv1zzl65F6MsTCcDAMEPGuRWoB1EQHgKfxM6pRpz74L8PGttawWG7
	 dMJvzZty09LqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	nicolas.ferre@microchip.com,
	andriy.shevchenko@linux.intel.com,
	kuninori.morimoto.gx@renesas.com,
	u.kleine-koenig@pengutronix.de,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 13/24] ASoC: Intel: bytcr_rt5640: Add quirk for the Medion Lifetab S10346
Date: Mon, 25 Dec 2023 19:22:06 -0500
Message-ID: <20231226002255.5730-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002255.5730-1-sashal@kernel.org>
References: <20231226002255.5730-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.69
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 99c7bb44f5749373bc01b73af02b50b69bcbf43d ]

Add a quirk for the Medion Lifetab S10346, this BYTCR tablet has no CHAN
package in its ACPI tables and uses SSP0-AIF1 rather then SSP0-AIF2 which
is the default for BYTCR devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20231217213221.49424-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 783c201259921..b63c16c67898f 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -884,6 +884,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{
+		/* Medion Lifetab S10346 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			/* Above strings are much too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "10/22/2015"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Mele PCG03 Mini PC */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Mini PC"),
-- 
2.43.0


