Return-Path: <linux-kernel+bounces-144244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221A28A438A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5361B1C2100B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D71350DA;
	Sun, 14 Apr 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBJqrmB5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4231946B;
	Sun, 14 Apr 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713109733; cv=none; b=pnU0wNndGnwKb+t5tqT7VVemhF5gnALabMMluEAkGAaFNuNxa5+9RWBlJDjUqcQmhTK/8TUGMwaJGnUOxFsLLcAXWJ/zaOa0ouMIjngBkbA4bT6gAWJ9jXeasp8zSR/QsdLsVetAUv3bXlh9db9u0sH894RyLQnLY/2KN5IuWdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713109733; c=relaxed/simple;
	bh=eB8z2bgQUHChzHBgcHVV6ROB9s4VpTn1NLhlNm4cuwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rfOLiLsvIa8lrm1ZN9X6jr9D/wVA7iSoe+iVLttuTjYi1/00f9CIM+cv5yHE87SQcgwAxcN14UQflT2o/3DcZkIzCy0eC1jN+/utjmRUiw5gvwU+y5l9sRtQqPmB/pv94FsecNRRczY7GjcxfvcBtIQwYFYwvP+Ys90JKRjQQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBJqrmB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2BAC072AA;
	Sun, 14 Apr 2024 15:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713109732;
	bh=eB8z2bgQUHChzHBgcHVV6ROB9s4VpTn1NLhlNm4cuwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBJqrmB5dGqTw05pedFo0QS/y0t4URz57mSUiq8DHiu3cnl0WDIrAQSHoIXpd4bRh
	 XOLKR2E5nkwOOMIw8ftmhBX+TAcQhxe1ONGzsLfvcZvVnxBgC/FLALFk2PoXUYOIYz
	 LKTwj+9SUXkcICpVuU2v2VRnzXKfVqpFAPUy5rae5mHX8UVS1PdQe2Jakj0WdYK+Bf
	 F/7mKZGs5Ecf5icJ5v4udqen9Iz4U49vafVGQdrfC7GbA9SJShMZCkyJtEsuwf0eDj
	 qvnZcom4baTqJWB+wDhy1ri5D9TJPtdMyme+y+gyskPPGGdMwTr7SNYVxTL/bvPpDY
	 x2egQpw960/FQ==
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
Subject: [PATCH 2/2] ASoC: samsung: i2s: Drop unneeded MODULE_ALIAS
Date: Sun, 14 Apr 2024 17:48:39 +0200
Message-Id: <20240414154839.126852-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240414154839.126852-1-krzk@kernel.org>
References: <20240414154839.126852-1-krzk@kernel.org>
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
 sound/soc/samsung/i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 9552748aea2e..1bcabb114e29 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1755,5 +1755,4 @@ module_platform_driver(samsung_i2s_driver);
 /* Module information */
 MODULE_AUTHOR("Jaswinder Singh, <jassisinghbrar@gmail.com>");
 MODULE_DESCRIPTION("Samsung I2S Interface");
-MODULE_ALIAS("platform:samsung-i2s");
 MODULE_LICENSE("GPL");
-- 
2.34.1


