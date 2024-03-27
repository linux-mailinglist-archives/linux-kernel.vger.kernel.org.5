Return-Path: <linux-kernel+bounces-121729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991FF88ED0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91201C2FA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9130515251F;
	Wed, 27 Mar 2024 17:45:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7C015250F;
	Wed, 27 Mar 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561556; cv=none; b=Khn9TpOzj/xMN7CzrZnu4JNcZYtakKTdh3IRMMEI0yYrPzLh3JvT+M5PKMEHtHZzvn3MLFsrWfE8iFVyggvgEyYXnLW3uvUpLC55zxVbjtPc3WK7HFGF4Rak8X4tqOHsrAhhslRg1+TcQyQHA39yJadXUHWx0ueFHQNeRmpq0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561556; c=relaxed/simple;
	bh=38DuKqkU9nqb2IfvIxDlQ62FIPAB7Mg2+F+R/IAhNOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OtWtrzYqfVMSAqN7Q6euXqxN7bOzWkNZ0doffDOMSXYgBXP8gbtQ1PLq4dtloXaI4eIlqyJiFhfP4K5TGgLeBsglnlNd/g4hq8s3Y+6PFkObvucRprwO5Geb1+kehMtfhDrlDm78G2AE2BqHkIaOaJkU1AipX9DZjjJ14nSFLT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD10CC433F1;
	Wed, 27 Mar 2024 17:45:52 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:48 +0100
Subject: [PATCH 13/18] ASoC: rt712-sdca-dmic: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-13-86d5002ba6dc@linaro.org>
References: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
In-Reply-To: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=754;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=38DuKqkU9nqb2IfvIxDlQ62FIPAB7Mg2+F+R/IAhNOg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsXCxBFta4gJBMxr74GIAMr9a0NC2TzvDsA7
 BOg3IotuY+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbFwAKCRDBN2bmhouD
 1+bXD/9NlKjrxfXLzHczcbbEhUfmf+yjawqYo86xd07g4rDr5x1C3FktGeUAwpBLslIkZN+DJos
 2Si7OhfNcNugqnuO50POTZGbY4lOLexZW6tTL8F0xrdyu1WVh4+18mSfzfgmbPaTey92ie46ki2
 dI1ixahN3BZ5YD17yl2zPDmSy5yLJyXA74hpIlY6D6JUGP9jrGj7W0atg5nXoMkfCrZYQuqTPPB
 nvAMWMFNIXIFTbZ3dUvNmaY0ZzKNJghJFN0cPy6qmmmcEeUpuEnXDCQkt37QvV2R6EXpISElgrk
 67fCdZB/5llKr8L8cZb1cVOdXWTyga3OGUBnrereBt6sAMSTPonBwmJ6NAK7I7ApJtEO39Rsslh
 eUOQyTQuBoWY0kVA3fg3XPmBIq6I7qwztgRMunEHLC5mZ7ou1AvD0K7L3fdyMACd4siV36CiO5s
 QuSmTwzpuuQaFNbva2+h8uCTJ8ObzOzhU2QrV2ynUCOqTyEoT5QVes+91plxZ9W7GNwqRjiXZwX
 oM8Rzb4XLvUS0T1zLqeRWihBu3vqPdpEh041BHonUF1y1BmPtN6cY1DvPOklAVSL6CuCKJUgJuv
 c/JSJMNzWFvR2Cw4Lk/fq4/XXTezqbM1JzL6F2EGHetzaBwV6MCx+sGmWNLEpw7M4deCoI4vHA7
 YFdNrNbfJazYkZQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt712-sdca-dmic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt712-sdca-dmic.c b/sound/soc/codecs/rt712-sdca-dmic.c
index 0926b26619bd..0e4d7cbdc951 100644
--- a/sound/soc/codecs/rt712-sdca-dmic.c
+++ b/sound/soc/codecs/rt712-sdca-dmic.c
@@ -976,7 +976,6 @@ static int rt712_sdca_dmic_sdw_remove(struct sdw_slave *slave)
 static struct sdw_driver rt712_sdca_dmic_sdw_driver = {
 	.driver = {
 		.name = "rt712-sdca-dmic",
-		.owner = THIS_MODULE,
 		.pm = &rt712_sdca_dmic_pm,
 	},
 	.probe = rt712_sdca_dmic_sdw_probe,

-- 
2.34.1


