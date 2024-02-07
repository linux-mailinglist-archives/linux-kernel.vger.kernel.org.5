Return-Path: <linux-kernel+bounces-57117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22D684D432
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCECD1C21C8D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7897145356;
	Wed,  7 Feb 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HohfD5LN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2EA1468EA;
	Wed,  7 Feb 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341031; cv=none; b=BgdoHOtijuJSPznA9Ne0x8tf+Twty6JJF1mswtNA440AQLqc+1C/w7LLs1cSpwCswPn8C1up/xoHktjmeKd3uyaesbBgQw51jIDcDtSILtAe8j/1KVsg+4RjDqrjK6YKhzF+awDJeug7MGJApUjKBypJ0F3TxhqXZZuCnW8o5AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341031; c=relaxed/simple;
	bh=I6ACf0rheCfaTgMnCYw/5BfgrO0NFpeYQB8WyEw7xzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2GJD9lLuBt71tLMt9oKGYaGAu9HrD0+X6grAC67UFcJjqk0WMJNDwNkNzQXZRrTk/WEgb7qL+M1T4F0coMpd9PaDR4nU9MlCLRnaRQ2jZ/KVOSNZa0/ZegeRfVR1jp8/btD2ApzPhbCzrbWKjMqdb3LXOT3+Wt05Ke4vMymIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HohfD5LN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6851EC433C7;
	Wed,  7 Feb 2024 21:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341031;
	bh=I6ACf0rheCfaTgMnCYw/5BfgrO0NFpeYQB8WyEw7xzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HohfD5LNwV9BjHOYlcYewQ5Bzg7bjubjZxCqBO17bfrUpFsL4kiHZOQSwu3WX5HpX
	 KcE7XaFtTBhal7xd2Owy2ElJHMTnPIhV1lNdf3e1lbczb39+lwUxEB8Ld4gMVdK4ev
	 fiLkGmWK46t9AYrL9A6UttELxrtGJn7ahNAgivxTAqWpCoooUDcVoteERO8mQS2OI0
	 wcbHNfAgGPzgilYba+uXaM5hRWYAkjVYV4BBXjdqeD/kHNjBIXOYt2R2d2gjcvE91B
	 m4U1Q8uX1f/Vh3QAHBdnC20PmnC8A6b0KuPnt8k3inPPwESYOk4cY/VAvppR5ORl7H
	 aWMhvkkmRBB4Q==
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
Subject: [PATCH AUTOSEL 6.6 07/38] ASoC: codecs: wcd934x: drop unneeded regulator include
Date: Wed,  7 Feb 2024 16:22:53 -0500
Message-ID: <20240207212337.2351-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index 1b6e376f3833..6813268e6a19 100644
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


