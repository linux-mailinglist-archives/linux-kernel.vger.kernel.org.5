Return-Path: <linux-kernel+bounces-99414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B9987880B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575011C2196B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F81362A00;
	Mon, 11 Mar 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjvtAyFV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812BB41C89;
	Mon, 11 Mar 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182371; cv=none; b=R1aMDZ2P0Gg7TlYCjsXepLJv1HwSuqdRfbWT64uHHzHKDKmxXb2Fucz26F4/P78IaQulmzFYabE+hTNIXKVgnRdzo4zltDsBcvFrIeyWKkMDO2SAqSpaMGhNsQnArqhpMT0k1QEf+0RsKubcvyEQ6pyryd/ckGE8IkluwJ2ivo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182371; c=relaxed/simple;
	bh=coEL8lDz0ZfUwW77qKN9jj5CS3Zu6IpXoXG/Xg5cYHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X9ydyzPteqpdl8xnvmDipsezpqAXvbNWXf18W4yCgYUsRE2xvTN96G1IE5iMt7i1Cs0zzkDiaatLqhtj+v6CrzBvZuJJh37nCsTMoMon+1mqXxDZ6i0Ps7wVyiCObY2Chq8c4HhrC5eg8bHAB43wS6DfeBrd84NawCV99AzdCIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjvtAyFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77594C433C7;
	Mon, 11 Mar 2024 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182371;
	bh=coEL8lDz0ZfUwW77qKN9jj5CS3Zu6IpXoXG/Xg5cYHM=;
	h=From:To:Cc:Subject:Date:From;
	b=pjvtAyFVSSr4K8Bs4uzh7YpJF561fA3C2/tpxEpfGDkMFpR9p6kQO1mEdd9k6pJ0/
	 pezoIXo5iukNJauU2Fj/wxlu+Z7R8jJrUkTUY6PIH9k3CZYKvoug90pGcDJ/IEiUU3
	 xmu3Vj8BpeYK3L5e2aJnWuqnI1b6CyGf7mSdz0ZnJO7aweuhwTl+hDXlstCA/yIN0E
	 gZL0MK6C+sLfyuRINr9pXeX6LkBrCpwfZVoSRLHDGFMVhFzfPPJFDVF/V9IdPceQ97
	 DDBAvUzEtHFbJNagAl6riJE5WihFs5j2DDIbglgayXk5tpB8M78yzER7Lidf3lUFbS
	 wr6yBq8cw452g==
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
Subject: [PATCH AUTOSEL 5.10 1/5] ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 tablet
Date: Mon, 11 Mar 2024 14:39:18 -0400
Message-ID: <20240311183923.328881-1-sashal@kernel.org>
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
X-stable-base: Linux 5.10.212
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
index f5b1b3b876980..1d049685e7075 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -529,6 +529,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
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


