Return-Path: <linux-kernel+bounces-57184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE5784D4D9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7033EB28C59
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345D16D532;
	Wed,  7 Feb 2024 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MepEqA+r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8006816D520;
	Wed,  7 Feb 2024 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341180; cv=none; b=ArALwDypWUA8KYbHNjTz7UgJ5E2hxUjxlaOulaQNxzJU39yx7kIagVLKHJoeztM9CFwuOVLjAssgfjtY0FIYalmASg0U6eZ6zdriMTHsrXbvF82SqsTxMeM1pg96kRpfls2YPgq3hNDR5GO3l/JaDnB8b8OPh9TAhwXRik5yDdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341180; c=relaxed/simple;
	bh=R1xtliolWFT+KnH5zrGkBUszATLP+e7OWupb2hxYyNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC0a1tNvkTXI6wtiZdTwul8+5r+lBj5jURyhixCL4zH/34xTF4TJCb27+1jrhyW9PX2rCwjCscqus8+ex1Y00N30ZyLpGVAfdJ61LQvPmhn07zZ+VWRzVhMlWc73zF/cBO0/KYZy9dInw4an0yzlSalBmdYdEpSBMB8gX3gm0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MepEqA+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7C6C43390;
	Wed,  7 Feb 2024 21:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341180;
	bh=R1xtliolWFT+KnH5zrGkBUszATLP+e7OWupb2hxYyNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MepEqA+r6ClItkvdCy8wbZtQQpKCFJHRwkiPoj1vHhxdMum/qShGF8xQmkoUBe1BP
	 9VRWhHWxDSeXfqE7iCGz6EggO3ZhoHX1sGQiWnDJ4aXLVJMmjYAnvoPSPMpw+TOEM+
	 qtWu3I8q1n0z70L3YrBL9VufiTk9Czv9axAVEYGF3wRku1x+89mGo/PB+dy7SlsfJC
	 7wJFSzynQB98Ba1ikOwTJtIZdUaaPE4I1EYbwx02M3YqZaEnBTCM7F7IfdvekIhL5v
	 AA9eiNWNuuFoz8S5kBCvjN7im0KBSzkqozoWawSFpAScqriBoY1NOUgxAmaLBEz9jp
	 JyGnM2gCsN8Ug==
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
Subject: [PATCH AUTOSEL 5.15 05/23] ASoC: codecs: wcd934x: drop unneeded regulator include
Date: Wed,  7 Feb 2024 16:25:46 -0500
Message-ID: <20240207212611.3793-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 94ffd2ba29ae..a12bc454e085 100644
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


