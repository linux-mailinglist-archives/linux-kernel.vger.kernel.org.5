Return-Path: <linux-kernel+bounces-144243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B7A8A4389
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13F31C21052
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B0134CC7;
	Sun, 14 Apr 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy+cps+Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02D1946B;
	Sun, 14 Apr 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713109728; cv=none; b=RDf0JPMKwW6ayjMRZebQBkKg2SSSL/UtzxTXDXyiAqXwc8n8y0yWe7GD58op9K9W1XA4v9tM0PejnUDoHm88TI2dKLFxLW3oJbUeuGb0qJ60nTpqX7juePZnbHjdJdn6ojWsnnhDjz+kDd/Ho+dQIRQbOz36nJXltO0jOMlqGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713109728; c=relaxed/simple;
	bh=foLleOL040k6enfEJM3Q4Puao+TFmpCu2z5tF3irpuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N/w98W43xCWUmYJ5HDcVhscACaFdFImGLxHw99QhaZLlVQ99uTFPc/dyHvwrkhHobT2n7syUHkOnQGMcgOgkt7rFtvBLQK5zIfzMpJq+rX2s8je5tO//NkBUdQKEY9UYtYrQ9a4/qWhnwEvQ4N96GiiQfswcj5PiURi5nxVEw5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy+cps+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E80C072AA;
	Sun, 14 Apr 2024 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713109728;
	bh=foLleOL040k6enfEJM3Q4Puao+TFmpCu2z5tF3irpuo=;
	h=From:To:Cc:Subject:Date:From;
	b=Jy+cps+Qrr4jzYlVgqbIWgdQC6LXhJFAacAIBjeM44mjyJnu7Rtm6ZyWoBq8Xspz8
	 TJxrIE11/MGSufi1nLRtewMfuSgv5K2E/F+UO+vzosQNHBBYDl+cw/dsx483IucQnA
	 1jqNBeTj4yhE/HhKbMLV4CTKLq57KCvWAqgTzHjO3Li6npPGLL5Jq1oRMvxajC6pm0
	 7v/aEgTOrJcFq+HUw0Uqicy6U7l2EBHEJD+KnOQXZIA1CgdPyIVZxmWWjZ5I2J2t3Q
	 CHaC1Rqf/U5EzV+dKFh5+lbLixVsdnpfTJx9cghgQjWfaIp8ED9VDI4c27Nyof1o82
	 uGhe7O2Ee1zSg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] ASoC: wcd934x: Drop unneeded MODULE_ALIAS
Date: Sun, 14 Apr 2024 17:48:38 +0200
Message-Id: <20240414154839.126852-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ID table already has respective entry and MODULE_DEVICE_TABLE and
creates proper alias for platform driver.  Having another MODULE_ALIAS
causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/wcd934x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 6813268e6a19..de870c7819ca 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5967,7 +5967,6 @@ static struct platform_driver wcd934x_codec_driver = {
 	}
 };
 
-MODULE_ALIAS("platform:wcd934x-codec");
 module_platform_driver(wcd934x_codec_driver);
 MODULE_DESCRIPTION("WCD934x codec driver");
 MODULE_LICENSE("GPL v2");
-- 
2.34.1


