Return-Path: <linux-kernel+bounces-124842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C671891D17
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3563B2FC52
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DDA14A08F;
	Fri, 29 Mar 2024 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXekF4Kg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67691BB07B;
	Fri, 29 Mar 2024 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716272; cv=none; b=C2w/+ocWjCMVUjuBr12Re3CX3tdXEIIbP8UBT5E8Ib8j0eX9rIyN6pl3DqMFq7XH3QKGpVnzZ+EYxAL3BNCvWAgmdWEk/77qQeGvwotFf0vn0Qgy2UJtSapkJwI6RIYdvTB7Ibw0cv9LuhK44y27YBUkF8HSxyHeuyXNX1mlkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716272; c=relaxed/simple;
	bh=qLWcvGpBZeQ7lY3R7E7DyEAzB9HEpBbU7NWlU2SvO+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKk4KBnv0OjbWWOSyU9TIXWsLwRHIK85ZdEWF4TwvAz6swLSu5L9vrbNe2yyaP1tLhZ3MEq2rNLPOYgJ3RAEAMzRPRj1Zayz76qksOGdW70KnMeE9O/Hpo09Ji9VdMODqSP9NAInKINsCEhr3w/Xu9iedQKFMXIu6eW3ivCBUt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXekF4Kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11AEC433C7;
	Fri, 29 Mar 2024 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716272;
	bh=qLWcvGpBZeQ7lY3R7E7DyEAzB9HEpBbU7NWlU2SvO+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXekF4KgohKg+1NWX8csZq5Gq5/4A5Gotp4Wf1R2jKoRHHwaQcIgb4MsqC8bDCm6S
	 dTecj6CC/qqKimbhPYHX9Fb098FiPMa+FT/riyZxzSJ8T/llij9LhGsIUpBy/o1OMo
	 l+443DcvWcpwN2XGK8K1CbKuBEHSlh8tpLKDtpn0v5fjiJCe16JVwZMD1VDJLGih/g
	 5rNUvaSJIFAtk9+RipvYMtEcaRITA/mx/5Kf7AZRcGbEo0Kv82r7V/wUa/TicOrLff
	 RZ6IJOMSjsJceUoETs/QhDg2MeVJOxcj2Vj03nxdEh4vBIhi5I6g/vVxa9/Vw4V/Kv
	 fMXlns4pJ7WFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	andriy.shevchenko@linux.intel.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 33/75] ASoC: Intel: avs: Populate board selection with new I2S entries
Date: Fri, 29 Mar 2024 08:42:14 -0400
Message-ID: <20240329124330.3089520-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 5b417fe0cded0b5917683398e6519aae8045cd40 ]

Update board selection with tables specifying supported I2S
configurations. DMIC/HDAudio board selection require no update as
dmic/hdaudio machine boards are generic and not tied to any specific
codec.

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://msgid.link/r/20240220115035.770402-11-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/board_selection.c | 85 +++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index 59a13feec57b2..0db5e530a8de2 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -227,6 +227,82 @@ static struct snd_soc_acpi_mach avs_gml_i2s_machines[] = {
 	{},
 };
 
+static struct snd_soc_acpi_mach avs_cnl_i2s_machines[] = {
+	{
+		.id = "INT34C2",
+		.drv_name = "avs_rt274",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(0),
+		},
+		.tplg_filename = "rt274-tplg.bin",
+	},
+	{
+		.id = "10EC5682",
+		.drv_name = "avs_rt5682",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(1),
+		},
+		.tplg_filename = "rt5682-tplg.bin",
+	},
+	{},
+};
+
+static struct snd_soc_acpi_mach avs_icl_i2s_machines[] = {
+	{
+		.id = "INT343A",
+		.drv_name = "avs_rt298",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(0),
+		},
+		.tplg_filename = "rt298-tplg.bin",
+	},
+	{
+		.id = "INT34C2",
+		.drv_name = "avs_rt274",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(0),
+		},
+		.tplg_filename = "rt274-tplg.bin",
+	},
+	{},
+};
+
+static struct snd_soc_acpi_mach avs_tgl_i2s_machines[] = {
+	{
+		.id = "INT34C2",
+		.drv_name = "avs_rt274",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(0),
+		},
+		.tplg_filename = "rt274-tplg.bin",
+	},
+	{
+		.id = "10EC0298",
+		.drv_name = "avs_rt298",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(0),
+		},
+		.tplg_filename = "rt298-tplg.bin",
+	},
+	{
+		.id = "10EC1308",
+		.drv_name = "avs_rt1308",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(1),
+		},
+		.tplg_filename = "rt1308-tplg.bin",
+	},
+	{
+		.id = "ESSX8336",
+		.drv_name = "avs_es8336",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(0),
+		},
+		.tplg_filename = "es8336-tplg.bin",
+	},
+	{},
+};
+
 static struct snd_soc_acpi_mach avs_test_i2s_machines[] = {
 	{
 		.drv_name = "avs_i2s_test",
@@ -287,6 +363,15 @@ static const struct avs_acpi_boards i2s_boards[] = {
 	AVS_MACH_ENTRY(HDA_KBL_LP, avs_kbl_i2s_machines),
 	AVS_MACH_ENTRY(HDA_APL, avs_apl_i2s_machines),
 	AVS_MACH_ENTRY(HDA_GML, avs_gml_i2s_machines),
+	AVS_MACH_ENTRY(HDA_CNL_LP,	avs_cnl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_CNL_H,	avs_cnl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_CML_LP,	avs_cnl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_ICL_LP,	avs_icl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_TGL_LP,	avs_tgl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_EHL_0,	avs_tgl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_ADL_P,	avs_tgl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_RPL_P_0,	avs_tgl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_RPL_M,	avs_tgl_i2s_machines),
 	{},
 };
 
-- 
2.43.0


