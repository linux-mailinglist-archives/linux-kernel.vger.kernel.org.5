Return-Path: <linux-kernel+bounces-121719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3DD88ECF3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4AA29D988
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9611F14E2F0;
	Wed, 27 Mar 2024 17:45:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870114EC4B;
	Wed, 27 Mar 2024 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561521; cv=none; b=AgUobSVKzAzksbk0V9VHpW9f7It0SddMNpIJUDrASO40mKJiYzeLxLgZQabkvUYAQ8judNN9Awr4B2io4Ooo1BlqJB0akzWNi1U2cI5NehCmamSVuF7fTu3dz2BLiFAH9+jpEBrl4M1Hkjb+mZGjBwTBsXQsrbvcz1uh/SuQ2zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561521; c=relaxed/simple;
	bh=cOQ1Xw92qWWN6FqyBsmZzqC668ZvHV9yoP5QeZFK6WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=alnAzFd7PGBuT9zbKfHvOrGefoaWaFF1xGIWD93qMq5Tml/wBd9t5Rl33uZJnmIRTuFUdjrFE0LefEaPoYZIafJgopQrLh91krXJLsfznoBjKXP4+/K5V+xUL5zm/aAXn0nysIrHzoOb4780EbKbhNjYjtnLn5Xayg5fkvawnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB49CC43394;
	Wed, 27 Mar 2024 17:45:17 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:39 +0100
Subject: [PATCH 04/18] ASoC: max98373-sdw: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-4-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=759;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=cOQ1Xw92qWWN6FqyBsmZzqC668ZvHV9yoP5QeZFK6WI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsPUJsGs4eDiv8n5erNgyO/pwUcrCGgUvmrn
 /dC66kUeK6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbDwAKCRDBN2bmhouD
 1+vJD/9DKOn1WqoFaoyFM+cQ/WCESJFGHHTpy0gGHRagurP7CzisDyFfHxr4eCvXbPBGdjupYdL
 sd9UCd0xA16m2GCwqra4a69NwIubVAtuXEK7wxfqkO68fEGHvnUy8+jzeB0J5NYSeKONPp1Bcd8
 BxEwf4rW9iV/x/Dpz5rESFvrxTB2VVwRdDxUixP2kIiy2r9DTRSxGoPlrwm1HVggUDs/cqXIXSf
 0yjuSBjHup3Keu166pJGQFzDMTTVCh2t0sWJFfhG9MS9mL4axERHbmd7uvMpzk3NFCY2DBJqGdH
 dLzVlL/J7woqZnS54/rThFsRveGoRggDnomZ8c0gwCyq6J96habMOaVtmSYQkTKtLdhE2IFVnaJ
 VIiSXnDAK3IvzHY9g1hgdhzRGK+dLsqleMf6hxUhaqwdluS40MqSX3KVUYbsXf7r19KNw1oPYuQ
 +AnJBUydf8QymNYvysckfJDS6X/h5cSOD8hqIhQn2Eu3GGv7aRb7suPEv964oMg0pEPphkloocF
 8wTpgdimcuymDAfJoKm/cHakbqcbROoBzoelYoih7+SpiIp6hgJ9kTvFiE48RFL0CEbryD6QHhs
 nfaQvWNvs9beFnPx6T8xiSVWEZUUN+mVmOHpwXnFywfAIuWUI02dYUSwg1vUrsBv6sA4uC2ueif
 rPYaeNC14rUJBWw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/max98373-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
index 383e551f3bc7..26860882fd91 100644
--- a/sound/soc/codecs/max98373-sdw.c
+++ b/sound/soc/codecs/max98373-sdw.c
@@ -872,7 +872,6 @@ MODULE_DEVICE_TABLE(sdw, max98373_id);
 static struct sdw_driver max98373_sdw_driver = {
 	.driver = {
 		.name = "max98373",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(max98373_of_match),
 		.acpi_match_table = ACPI_PTR(max98373_acpi_match),
 		.pm = &max98373_pm,

-- 
2.34.1


