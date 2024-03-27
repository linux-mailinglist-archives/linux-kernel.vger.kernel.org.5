Return-Path: <linux-kernel+bounces-121734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91E088ED1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7AE1F31ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F823153506;
	Wed, 27 Mar 2024 17:46:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DBF14F139;
	Wed, 27 Mar 2024 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561575; cv=none; b=fC+mdZ+d76dvLeTMZUPTWJec/URaN+1ZZuN9vbNf7nG1RmlHrWSDsn6LXFffWOlOm6pZSgLRG14flo4G420QW+uL9v0x99ZcgYr89bVAYhr0fMOP8m0m08Akm5XuTWfUW9LjXWZaNCpq355TOyNKuyyNRf1K9pLQFj2wzMAb52k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561575; c=relaxed/simple;
	bh=TPIwJyHJ+747cO/ACTo9CUsEqoc7Fc18IjkZxXaUALs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jasv1MQ5ofnY7qasDEWsQBw4M5SkcEVD9fy38t+lRibHnrdrupERkxaIzQdk4sTkuEyY51r8B+NDF+ZoPqYe//cUJltJ5SRuXaltU6M86bafJPRYvljvZvZvdc5cK+itOKqzMNOyvOPd2uFp5D4/O0Oh4thMynzmuJ/4YDCVlC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D6BC43390;
	Wed, 27 Mar 2024 17:46:11 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:53 +0100
Subject: [PATCH 18/18] ASoC: sdw-mockup: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-18-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=697;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=TPIwJyHJ+747cO/ACTo9CUsEqoc7Fc18IjkZxXaUALs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsbPRhLLRW6aIenPvFaDhNNkrhsJU/87RgSq
 1indSOHKTWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbGwAKCRDBN2bmhouD
 1+urD/9nYozdlVyHTbH1gmrxRj+UdO9xzVICmYBU4OUt5C86nmFnA8tt2lh37b3gLRcms/eK5zY
 uDclO/E0Vm6fMwDz+bL7WcV1TNPvgHXVkym+8ilScw84szrTux9xNOF7ko0PTq4nZrgKov9831P
 9awI7+Ug5/mT7LlSt7QUZfK6SnIa/8LKULNpfUb/p0dldEVzMFHQWU5MwuYIZTTa1/WNu0huJCS
 /Tfzd68AhMie5D9u9+WdYkFbkhTuAgWQY8mNoaDxwwCwQAYxGzcosz1VP3SCXzYrzV4REMwGZfa
 VrsYaLKv8VNRco7WOpKhkzGjGLMztrKa/E3sAJ4AszhXajxQ5YobwCQdsfCDDsleJffP8aWS4Nj
 dSqzB46rnSA1Da+m8DVbQMltM2ihMS5uB/Ot2AQAFPvUeH5tAK4BXksHs8HWY00cAN0U6TfUgdC
 l1cfqq+bMFVqtZRqUuw8U9jjkiffcH/ztorX/CDXl4N4uSCCkudP7+0G+ZRdz9kvqxQCRxuoYLg
 ZDJX1oZxEqMe68+gHx6VKESYNUQOUpwvp4vAigBpUoa98U35Uujrx0LTi27tfoa24QQEyugx70c
 exIZOdxjULDaAzPN2O+Xh6btXgJAMjtzIboUdQaUsOFkAz8Fic2htJfMNxis9mmvc77dPvnzd80
 C+xIPhW09WpOvJQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/sdw-mockup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/sdw-mockup.c b/sound/soc/codecs/sdw-mockup.c
index 5498ff027c58..574c08b14f0c 100644
--- a/sound/soc/codecs/sdw-mockup.c
+++ b/sound/soc/codecs/sdw-mockup.c
@@ -262,7 +262,6 @@ MODULE_DEVICE_TABLE(sdw, sdw_mockup_id);
 static struct sdw_driver sdw_mockup_sdw_driver = {
 	.driver = {
 		.name = "sdw-mockup",
-		.owner = THIS_MODULE,
 	},
 	.probe = sdw_mockup_sdw_probe,
 	.remove = sdw_mockup_sdw_remove,

-- 
2.34.1


