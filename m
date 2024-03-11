Return-Path: <linux-kernel+bounces-99426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5844A878825
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1322C2832BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D254A65BB6;
	Mon, 11 Mar 2024 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd72KDVR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44A5A4D1;
	Mon, 11 Mar 2024 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182420; cv=none; b=jDDXpPpj5w3UmZUqS3tE+5DV2QHag9OFnAn283lWAj5BIzNExJwaw3G0Pp4HrYODGDvlGajGnQFzppTF5VzVDeHsWbFuz4R6nJiQ/ZsG5KVCRf8OkT1IiOEebHybS229+/E6dnwj+cEn7eejpsM7wZX+ktIcTNaUiO+LP9c64E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182420; c=relaxed/simple;
	bh=uNcha0HaSrS1R7aswxavoG+kOXCMFOfXe9i+/jnZIug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lvdttZvKfeo8Wkz1/RR+wZuUPf6hbNDVzlxnW6PZqFJgqhVIc3UruXyPtDwk8z8Vj9HW6MmXDTmVpiBgpXFY4Guts6gRyjQQwgVWjYcOiG9dRfl7lQi8wC+Cz3qTTm5AlXV4Dtk7BZXf7bsuGOcEs2wTOFzjt4ZzkhybHlXxOWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd72KDVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D1DC433F1;
	Mon, 11 Mar 2024 18:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182420;
	bh=uNcha0HaSrS1R7aswxavoG+kOXCMFOfXe9i+/jnZIug=;
	h=From:To:Cc:Subject:Date:From;
	b=dd72KDVRRlAAOxOV3xHuMjGIQODmtGwDaYNAEmN6b93Vl4u4qC3LKdYPNyys3fpJG
	 BF4IJcrkeFVFrVt41JqyE0gzYH3DEerFUad51ubRXKImp66BVOGE4Vc7zg4zAx6bnn
	 Zl8Ag+cgDlfkNvAHRlugIkiXB2wzq93P0iJEGnyxvhiGR02G8wsYIbH20K9BkrI20K
	 3up6F82Rz+a3ZHueZWcP4P1AEbtiu54iXTZ4BDNJlKiRzU74069p3ht/CxGuf5HzGh
	 mkxcZpHw0n4W82v8AAgr9RxoxDM+kH0ZDadLWONhzpsUqGL/8iajpyEqvGxlTbfYh+
	 5PLCblpY6x0Ng==
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
Subject: [PATCH AUTOSEL 4.19 1/5] ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 tablet
Date: Mon, 11 Mar 2024 14:40:07 -0400
Message-ID: <20240311184011.329314-1-sashal@kernel.org>
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
X-stable-base: Linux 4.19.309
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
index d27dd170bedaf..19f425eb4a40f 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -523,6 +523,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
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


