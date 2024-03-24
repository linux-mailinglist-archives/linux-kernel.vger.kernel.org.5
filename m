Return-Path: <linux-kernel+bounces-114942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079718892B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386A01C2E3E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A65D2DAAE9;
	Mon, 25 Mar 2024 00:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okIQzQYK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B517A36C;
	Sun, 24 Mar 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323652; cv=none; b=NX3vIaXQzQPl1+Z/lp48wkNvvYa1BbbbYkjXpMZ22u/dxUujAj3d7m+o0yuq7Y0ThzbJMmz2O5wIzdqKCbLNW56jkFDawY9ZXYra8yd/yfs2hb/44p1skjzs9xdWRRrYuAE78FDxbVZN1wUSI4igCtVSaOe7zZoV1U/u9WxQ0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323652; c=relaxed/simple;
	bh=coEL8lDz0ZfUwW77qKN9jj5CS3Zu6IpXoXG/Xg5cYHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iY8KaHjsIZH0GrN8lo5i/irLYaDpHTIQ2Lhz3Dof0S67b8ku+XAabIqZLMI2lwikOUNUra95RcuX9zzgrlGNkpze/40UVMU9qrRpS42bZ4nkoSsGbbiNjbsx2fWqCgztj8++GBWlsP3wp0954ZC2WXXISQxvzqlArSaLbpLWhYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okIQzQYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18DAC433F1;
	Sun, 24 Mar 2024 23:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323651;
	bh=coEL8lDz0ZfUwW77qKN9jj5CS3Zu6IpXoXG/Xg5cYHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=okIQzQYKpRxkvVhPTLDn9fGeaXSEX7CfXkoXATQOZhSDxLS6YuKqs+43c/ssRRqbq
	 TeyDSW80zsdj8R/yPdm1AwjEB4uyWnwVDk1b0kokMSb9oEe88g8z6vD5XCltpbYWhU
	 sk81pTE9gOXN2SFW5x8ZRtK+1YwdOD5+9wdG7LOsIKJdflfwfFn88Nlhgy+wzv4bRl
	 JcZYc206OflDyMKCfdmXIqWkmITBe3NU0e+/rHdhBs4KOq8UkcER1a2t0FW8o3kqKC
	 3wBvQ3JvDEThfp0bIMZ38hpNjEplreaA05MV8/kh8uFZjhPEbSwVFeZncUHqkZNaaq
	 EUTBfZa8izIFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alban=20Boy=C3=A9?= <alban.boye@protonmail.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 023/238] ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 tablet
Date: Sun, 24 Mar 2024 19:36:51 -0400
Message-ID: <20240324234027.1354210-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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


