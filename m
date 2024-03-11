Return-Path: <linux-kernel+bounces-99409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834238787FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394831F22BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20B558AAB;
	Mon, 11 Mar 2024 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5XIJL75"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033E6215F;
	Mon, 11 Mar 2024 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182350; cv=none; b=n5bdpnLkAB44asj+vABA/8Uxmn0MKx3SC1GpMpSSWafukct0yqWGYC5nRkPZZ7VjpbqQ8TTGNm+FYCiCB2vvnhEonGwp6KtWz+27/HWFh19GAGNiEFGXXSHh/FDubbc7RsZrgBeHX5YN/5tNgNzyX5ll3H5wBtHLI33AhS2HZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182350; c=relaxed/simple;
	bh=YChU0O4tGvLJPSPKaKY3ehmHRybr4RB0vp5VJLcOpIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KjDcYUYYF7uUhdn2WWKSYALAkkU2c1adaSHmqxNBSpYSfZ1zRtn+GubTcGf2l0z0acAXL4LYh22t6V30Xd9Xo2YMlaGZY0GjXOI3oNTXpaeJaVkLwuWsCtngl4dIcp/jtYi3UZrXupvtfeAuVabPegmT034HVQEIBOXFPxx+DFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5XIJL75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5987AC43390;
	Mon, 11 Mar 2024 18:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182349;
	bh=YChU0O4tGvLJPSPKaKY3ehmHRybr4RB0vp5VJLcOpIE=;
	h=From:To:Cc:Subject:Date:From;
	b=O5XIJL758u0SnbWBqzXQygnveCAs/3hqtuoZA9E/XvbOXkDksoey62akiDkXSB/6J
	 U1sOnt3Q2F7anIzfhdYzTFtsHx87ti/NK3jA1sdL/+iUhva0rJJjB0Vm9vAyZGV8HQ
	 3UsJXRtraogYqb6bUfH0t51pj7m2fZxwZDItvX7SXeA69Thj5oigLVsLaXkWpgGHLU
	 v8CJ6S1Wu2YArarOG5OBY99+yF9M5tZA77KF4ufKSE3+KBwYN/iCGNXLdBbi1om5xg
	 RVl0HrgeXbr5OfBaypgQkh61z814PJlNZkx8Wg3QEEoGsZS/dz6zg1YtyhFGEbuOZ2
	 PBsJHMWCDjBmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alban=20Boy=C3=A9?= <alban.boye@protonmail.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	liam.r.girdwood@linux.intel.com,
	yang.jie@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	hdegoede@redhat.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.15 1/5] ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 tablet
Date: Mon, 11 Mar 2024 14:38:57 -0400
Message-ID: <20240311183901.328749-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.151
Content-Transfer-Encoding: 8bit

From: Alban Boyé <alban.boye@protonmail.com>

[ Upstream commit f8b0127aca8c60826e7354e504a12d4a46b1c3bb ]

The bios version can differ depending if it is a dual-boot variant of the tablet.
Therefore another DMI match is required.

Signed-off-by: Alban Boyé <alban.boye@protonmail.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20240228192807.15130-1-alban.boye@protonmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 49dfbd29c5451..434679afa7e1a 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -668,6 +668,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* Chuwi Vi8 dual-boot (CWI506) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "i86"),
+			/* The above are too generic, also match BIOS info */
+			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI2.D86JHBNR02"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		/* Chuwi Vi10 (CWI505) */
 		.matches = {
-- 
2.43.0


