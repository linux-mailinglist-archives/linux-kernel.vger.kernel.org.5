Return-Path: <linux-kernel+bounces-57206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 813EA84D51F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0AB28D8CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F7F6F517;
	Wed,  7 Feb 2024 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScPlpuNv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B86136643;
	Wed,  7 Feb 2024 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341228; cv=none; b=SwG7Qk2ogHuIAS9ZnjBtPaKJ5IM6bVuuVk3y7YRToPuOytbxM1YVR6cjvuuQA8IGVPctubTYjfLxfaA+k1GdegVcwlDO67sOaY5T88gQkqRhfvAJCdMwk5JgV74nd7lNB1vMjxILmlXWoORlqzu11eGpfGfa13yeh4FveRsajCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341228; c=relaxed/simple;
	bh=wG0sK8XFHjHc0nOKGs+2WnDbeM8qvPvmjUhVq3j+FIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m74TI+Mk+8mUZ5tn134t0ezRgIipmDcAuDwz7oPsmAlyfX4IB4xe07RYANBjbHEX2r3Rhq0v8ziUqSJkyNTJvw71EGakkSI77Y5tI+BETnyFHTqBRWnKQSmKK3/wn2JnvyYS9bZJZ8h0JdIKLo36gGWYMvevSOJYj/exvJrypto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScPlpuNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D03C433B1;
	Wed,  7 Feb 2024 21:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341228;
	bh=wG0sK8XFHjHc0nOKGs+2WnDbeM8qvPvmjUhVq3j+FIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScPlpuNv9llbNWTZLlGQ8xbcuT2zUp9pafczcB1nhFXM0MwwbHZfPoD0f/sqPy4nM
	 Yb8CJZyLGPuOZcsXasrFbCNRkYcQ22ZxGUhKu8IPw/Fc8udewlPRnR7UCv1UjuDCTh
	 4I+ax0RKi66GCsypHLA2yR1hDqktMzipsBlGhg95btCuTQW3SqBAzGWmpErEzYK1ut
	 v1a2JUaECC9jsmDSm4bFyyxbrnnaPhjAhqY1P7mwVPUQfKUANprUqYfQuFFyZCfvd+
	 8V2I3qRFQXnyMS3zdx98HYdL0GlArqLOis0eMSjWTlhLAECRST9VtuwSpZ86qa3LOv
	 7qWSQZFiPnzuQ==
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
Subject: [PATCH AUTOSEL 5.10 04/16] ASoC: codecs: wcd934x: drop unneeded regulator include
Date: Wed,  7 Feb 2024 16:26:44 -0500
Message-ID: <20240207212700.4287-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index 104751ac6cd1..dbed3a646524 100644
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


