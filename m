Return-Path: <linux-kernel+bounces-124757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE9E891C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37BA287171
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD6F17F385;
	Fri, 29 Mar 2024 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAkP+kfm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D7A17F370;
	Fri, 29 Mar 2024 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716088; cv=none; b=lvkkt+KaQO/3fnGuPx4I6hhqJOk4IOy5OoWzwOh7UhTOtyVE/tPqzzFjoMJP6cJKdi1cRYLOj/HdSs71GrRuGl67DbObqpZ3GH9xfe0RvQAacVDGSP3Y1CTSbpMkCPql/Ex1Phb3vtL4q8FhEgFX1XSNsiKTbjEX4ti/NvQli3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716088; c=relaxed/simple;
	bh=iIcxczB/HEamIsN/WkU19qfRCxeAna4hfLiPpgqiWso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6tu3JrX3+mQKViLErBOKPihN91hj3QaUCdHXxD6e6H2JpuueMwB5kxoIjYo6du4pzDzwijteJv0TQFEZ2ZJQne0f/OdxYu72MsbPhSnvD1Yv9sGvpXIupC3N2oaQV0BMwI2//Xn33pnb6T9DmAvCKiiob0Q2E8NfAokds2qSNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAkP+kfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875D3C43390;
	Fri, 29 Mar 2024 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716088;
	bh=iIcxczB/HEamIsN/WkU19qfRCxeAna4hfLiPpgqiWso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uAkP+kfmz1Dpcn+2PzTaiAY8Z80v6+hAdvKntZJim+THTeUyZgknUUgH7eMXoqkUW
	 iywWdWMpkJ89s8PIrxuURRG2lAzt1/scSmedj9X9CClisZHQY2IRV0u9Jd1Fxtvuoj
	 PAaRyVt2rfJvdG+WYSc372wyL1zux5Wb1TPf1wkz70VDEgCCqaCe53mRSyPkngo1cj
	 QKH5/u3Pm5Bj2HCvd1Cj177mJQzn3Tux5l7B5E5Us3+0k8FdNltpy34Jq+UiodYzUJ
	 42NIF3gldCt31hflQHg3KRZ7nt3d90zYmswekpdALlu7JL0cQcQJmKIxe/lMPlKaVA
	 AEgX9cI7Tzs7w==
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
Subject: [PATCH AUTOSEL 6.8 48/98] ASoC: Intel: avs: Populate board selection with new I2S entries
Date: Fri, 29 Mar 2024 08:37:19 -0400
Message-ID: <20240329123919.3087149-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 8e91eece992db..8360ce557401c 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -236,6 +236,82 @@ static struct snd_soc_acpi_mach avs_gml_i2s_machines[] = {
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
@@ -296,6 +372,15 @@ static const struct avs_acpi_boards i2s_boards[] = {
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


