Return-Path: <linux-kernel+bounces-121723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D9E88ECFF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70EFC1F274B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B961514C8;
	Wed, 27 Mar 2024 17:45:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2AE14EC63;
	Wed, 27 Mar 2024 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561536; cv=none; b=CzoLeuL2CtI6xnzB8TI9fNU+eEx1muxcvvY4smNZoWSek53ovsISW7DRYLvhutgA31RfK25aEVQ8qi2tdFUeCUtJHmOrDVz189qkJYFNyS93pYUlURaqdXOGJXavVSicy+BHWtG1Qh7zKzeKUNPHyJOI9hM8pbp0uN9+c7F42M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561536; c=relaxed/simple;
	bh=xqM9vP1VJHR2BFUAj6MK07/WTjMfbro87cfmmhnNNBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IUiF8lHEfsDmxEA2UOt6dJLQjfIwu2F02O0KcV8Z1TrWRrV4MY+kDaSyuLqj26mnvt5wbW6DvyXNB0Xt9WbntYl37QDoRacRu4PeHkohDgJZJTIEOWwGbYu5991VX1Eox12ZRZH8zvnFPmcx31deKGTMWDT4BCYQ3OAWzecGWII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDDAC433F1;
	Wed, 27 Mar 2024 17:45:32 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:43 +0100
Subject: [PATCH 08/18] ASoC: rt1318-sdw: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-8-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=680;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=xqM9vP1VJHR2BFUAj6MK07/WTjMfbro87cfmmhnNNBk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsSYkrTHKw2fBYlI0MInx0eJovTwEM7qBMMi
 hOXKl30YaSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbEgAKCRDBN2bmhouD
 12WhD/4hmAR7bXtQiW7Hybn+lzjpebsx+efT5znGNAWlpYHdAYDV8laHm5xpB0XwQcRTlWcD16+
 gHWk8oBTivl/W1ABNvAc0pFeId/CKmywAm5hoUAyrkQLTcAoaSU9zm0e/N2hQxhshsrgv3RELWJ
 BeuftVagQ+8gKeAI6YRlbvhVGgwwgoZuSK8Kdfo6cthwBRc/Tq8G8gyj6coVnOQOW8Q+w9pyPw7
 zhB4c4nzbymPKwgMb6o95VyLZEvUIayS6gcZfSCZcEGqXbqXq+pYwo/fJ7pWjb1vHNsbAUUjaY8
 +2bqZqf/khMlhIXgJ8VAm0kLHzCNp9Jc9HWnCngbH0lS/NfaJFWceLV+GXZ4OQTUQhvguVt8aEo
 U0xkkKXBdAqNvDUDWEuK+DJcZhzWhShkcdjVBEJEeYNMoOgUI/pGmy765+naSCTSaDwPJwyccIg
 V0nQLbr0LvGjrysaRQEJHMBXMqFcjgcAUrS7vgNtgRlV1L8K34Qq1VCu52+emzp29rJbr17jgYw
 Su+9Cv3/bUawNKA5etpjoWFoC98KEtba3Ay7zg1tTm3Cu+QR6u95NX3FpXNofPAaBz9znXF6eZV
 p+DuQpFA8EcVyoxHXDSo4sCqWfdhTuasKsMj8QDFN9u6szxSjm0+540oZieVqCNPxVC6EPvIMXd
 cDpOtWhNq8Ooncw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt1318-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt1318-sdw.c b/sound/soc/codecs/rt1318-sdw.c
index ff364bde4a08..3f6c7c25967f 100644
--- a/sound/soc/codecs/rt1318-sdw.c
+++ b/sound/soc/codecs/rt1318-sdw.c
@@ -855,7 +855,6 @@ static const struct dev_pm_ops rt1318_pm = {
 static struct sdw_driver rt1318_sdw_driver = {
 	.driver = {
 		.name = "rt1318-sdca",
-		.owner = THIS_MODULE,
 		.pm = &rt1318_pm,
 	},
 	.probe = rt1318_sdw_probe,

-- 
2.34.1


