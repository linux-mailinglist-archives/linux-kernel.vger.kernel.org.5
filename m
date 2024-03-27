Return-Path: <linux-kernel+bounces-121733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE888ED18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D40129992A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88519153502;
	Wed, 27 Mar 2024 17:46:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C014F13C;
	Wed, 27 Mar 2024 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561572; cv=none; b=M0wQYXodgEBhaWsJ2SQ+tT9Ew4kQIDgUEZb51nrN8fDO5kFVvbkUV9xMbwIQqzwf6Qg09Robd6kNtmHotNjarRhryAjBMZGhV711Yq7Pcovo3cPKeivs/xLl0QGzgHrEnwyZtXWcxyRT7A/CKdbMti0xOnvgEPuvEmUKDS7fhBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561572; c=relaxed/simple;
	bh=uncORd5JNkMto1wvYsp5uFKclG6jNyHzUan8WYXHy4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BF2eGF2z1v53rTG/AG19XZLcvoTNrpRwoHej7ji4QwRTVK7g5As1I6B9VOv5FtvX6KXPpX1jZBQ+hdxxP6KFfskAfy5oDyh6SvL1USFxdb8ElyRH7ouqaHk8heMD4fIrwAXly3A5T07hJjVCpcP0cxTMVKmZ+UjPOehI1yTJILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9653C433C7;
	Wed, 27 Mar 2024 17:46:08 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:52 +0100
Subject: [PATCH 17/18] ASoC: rt722-sdca-sdw: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-17-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=715;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=uncORd5JNkMto1wvYsp5uFKclG6jNyHzUan8WYXHy4I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsadS3wi1WrHbkhJXG2AV3h9JRePr5dAxdsy
 DpzFSNfs7CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbGgAKCRDBN2bmhouD
 1+LzD/9qPTq1yvC9/lin/tofr7th9r+mHk83nsDng8HZFgb4Y4fMddURyNZZDOUUCXuWEVvkxAh
 zuXThKzVXfN1V/JTgJhDRL5MV23YJD0kfgZB8kzw00nQFTVufI3G1XsCYeGxLgktv1Lon7D+iSa
 YAhg76vxGiP2cA49T5RCdZ1vdxgdZlbs6nwO1sPOcWA6Hw7ZrWHw+zU2l66DIqqBCnCJJvxulzl
 S5RIGpFvB/IXmogQRPE/drbvyTYTxmv9qC+kn7G0nJTonNjUkKZwpCNq7jxkbZplONwR70eG+uU
 MXZsRceRzxV7Cujsj74+xgrGylgHupPGheN363NMtoIWjfM33IwOhugmkUD6TNU0YkU7zJW8l2H
 LmDzkjOH5ccRQCzGMlHt7AgRpKpYmKvTvt61nolV2drrBWBxl9IGenljCDrS+XhD2VplfECCjc9
 3GrN3HppMRp6n9a0pshxwgpitiXFfQWPO5b8Y8XnpTsWzS2hRg+4m92qCIyaG8j3jYpnOnWi0eA
 SQfKnrRslaD8wb0TMWz93NGW4FnMjNRd6vtoPKjGKuSOG2CUiEfYvZSRiDQJdMuMsbMUsV3B8h4
 qtOJcCJhFB+AOv9bHlA3chMXRL3PgLohrqheUIPnxQp8hY/Xd9uHMn3n3sKIYXYQd8WhRX8ZR7A
 Wt7bzkgX8Am6hww==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt722-sdca-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index eb76f4c675b6..27af5f883c08 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -503,7 +503,6 @@ static const struct dev_pm_ops rt722_sdca_pm = {
 static struct sdw_driver rt722_sdca_sdw_driver = {
 	.driver = {
 		.name = "rt722-sdca",
-		.owner = THIS_MODULE,
 		.pm = &rt722_sdca_pm,
 	},
 	.probe = rt722_sdca_sdw_probe,

-- 
2.34.1


