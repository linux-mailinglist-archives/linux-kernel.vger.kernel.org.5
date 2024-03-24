Return-Path: <linux-kernel+bounces-115776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8077D8897A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14BF1C30E47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1959261CA6;
	Mon, 25 Mar 2024 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNl/NnCD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B114533D;
	Sun, 24 Mar 2024 23:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321981; cv=none; b=SrFDoMbnHNdCNm4/yXb5tvr8Q/pszRR2ZEyZNue1LmGnZFQVIGvw7y9DTIAsWNNnzmkHJxnSPygnzMZRRxpQj53TCTmUsVrCq3IBwCzqQYA5Osvkt92Dcwtad1V/qXe6Bs3H6HM+49r8I1HHfWM8HtrUgZ5Ock5c9u0KKxE7scE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321981; c=relaxed/simple;
	bh=h13E3I/67aiIVBnOSCOdgSWe9t1VwoTldhgwrMtJGUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzI8szPx6BbDmjG6c1NhFfS0glnLzWoYiiEHp/jmmkqoFsrVzMYkniJSzpjzck6gLPXjfBbCwhWyycGPzu6DSaKwPPJf36vQL8iOprR5PBxf7Rnef55Wo+UZUBr4CYVbLq+d+pdxis+8twSY2tdyODicN4MjYOgSaBoN4AuvQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNl/NnCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84E7C433F1;
	Sun, 24 Mar 2024 23:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321980;
	bh=h13E3I/67aiIVBnOSCOdgSWe9t1VwoTldhgwrMtJGUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNl/NnCDnbHPL/J8ujT5/D/yqZ4ggD5/7pBmF87kEhIquN9tFaio4Va5qLCQZVoWT
	 ebOKsyTOaeBkMfa8AXMGBvhp2SSahpnEuFy8psEMEied8ItAB4dD986FPhzitAPk8v
	 GJQmEqsRDtc02jmCkWvFkmgPCvG1P3ltcNfF8lpyh0JO2s6bYTZbhUGgW8lz66ak21
	 Hn2CG+EdLBuq6X0pp6ESDSd6pfp8M80TqzWyNKGWCEdR2ft1hz5OYEhmTmmrRnF3Uh
	 /1DjQ1VhiGirSs/3N58NPi5P11PB/cbTsKwT/dbOYbgBJnop+ktzy6iOHRF7yP5xNm
	 3nRMiR22JwQeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alban=20Boy=C3=A9?= <alban.boye@protonmail.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 053/451] ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 tablet
Date: Sun, 24 Mar 2024 19:05:29 -0400
Message-ID: <20240324231207.1351418-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 797d0a48d6066..094445036c20f 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -685,6 +685,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
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


