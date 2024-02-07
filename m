Return-Path: <linux-kernel+bounces-57154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92784D48E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B140E1F260C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EBC155F39;
	Wed,  7 Feb 2024 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9NFWHO6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2831552FC;
	Wed,  7 Feb 2024 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341116; cv=none; b=u9SChr5WZep5i1ApgW+qWhMAKfeP7/DvH3EfpD2TKxwG1wlXjI8TZfhus1ynL28EaWHMQPeJ2x4+af5bv8Y+faL287pG8vDO4BVJf/MIKHpzngj4GbCINDkLMyC6yBRRcQejOHRuAKs1SWn9sLFzZ1+Xs82lrkMWkeszBiP0UDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341116; c=relaxed/simple;
	bh=ZEs2TzHH+d3Wm5jhxzkC1qvnQNqoUe+++fHFK2VxUtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZmtaKBNeyNvyWm/RRWl6KrpGhT/lZpg5iAzE6pUGVeqmjT60isq0dws6V0MpnCgApDSQomIeZhIRFIPXsxxFjoLDobGb2dud7vbm4pgmRcgm1P7ys+XE/QbNPeD2v0wCxGWhe2mu5RlcN9iRPIBCGXx1FjOVhhAqmwpX4Ar9i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9NFWHO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439B2C43399;
	Wed,  7 Feb 2024 21:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341115;
	bh=ZEs2TzHH+d3Wm5jhxzkC1qvnQNqoUe+++fHFK2VxUtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9NFWHO6U0iLZf0Uk/Bawq6HOy+QCafe+ptx1iYVGJLpzJvIWEuo5hy3lE97hSNTG
	 Rp2mSNE4VRkEmEc+xXc+xLo9N/WIplWgWGAVI5S1tue1keWuONXS/T21PYt0QxyIiB
	 fxvUwgM9MXx7c1jeb6OQwu1ZLoRECXysfCY80m/NZll3fKTNxNKh4MkZ68DAfVT74e
	 kTyfognxjvAQZE7gt9EkC/b8swNFg+wIai3ngUCZA7UigGBD8Yolu4doivBAGxIpth
	 22vNyv4FALJUtmdfX7Vbao1GJmKyOfC/9+lCdLxWbcvi95Si3rYOkGKjNmQioeh1Oj
	 W2PtSjtmjNHUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/29] ASoC: codecs: wcd934x: drop unneeded regulator include
Date: Wed,  7 Feb 2024 16:24:31 -0500
Message-ID: <20240207212505.3169-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 35314e39dabcfb256832654ad0e856a9fba744bd ]

Driver does not use any regulator code, so drop redundant include of
regulator/consumer.h header.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://msgid.link/r/20240117151208.1219755-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd934x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 0b5999c819db..86d0907a5f97 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -13,7 +13,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/slimbus.h>
 #include <sound/pcm_params.h>
-- 
2.43.0


