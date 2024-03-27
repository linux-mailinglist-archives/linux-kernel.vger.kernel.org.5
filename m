Return-Path: <linux-kernel+bounces-121725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BD188ED03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225571F2F32C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C092152160;
	Wed, 27 Mar 2024 17:45:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4514F100;
	Wed, 27 Mar 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561543; cv=none; b=dybKcDmXIXI9+3WfnzfFlWW1OwUSVCePV1ytCVAd/u31MrfwFh6nSNlp9aTLsuNoxCrB5DOE6JwE1lf+TM5904TFdWQGxwt4QbtGaHye/Lyvy74DgDAQnez6fat13+AEzsS5xxcoSgNN262l7AoiS10lvBRCBXECQuWV0ycUvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561543; c=relaxed/simple;
	bh=KL4jt68dyLoz5Jj2lJbz+/X5KvIPUwwpNhz1K0iZi1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cus7egBfC6OADNE9hW59RXH28X52APW/uVJ2PdfdhxTDW1XJHwuK9fY0Bus9qcaaxFenyjhpPoeK7zB07jTWQAVKc4S9txnJLoK+ScBe93rCgFceJYxOcZSJxqBNNNCJGqw3A41DaPIWGA/JXYSTMWi5udpFhYxMZMJNUbyQHsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AB4C433F1;
	Wed, 27 Mar 2024 17:45:40 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:45 +0100
Subject: [PATCH 10/18] ASoC: rt700-sdw: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-10-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=665;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=KL4jt68dyLoz5Jj2lJbz+/X5KvIPUwwpNhz1K0iZi1I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsUNjYC5MuUVHhQ/+ANue0jk3x+i4CaxVwsI
 pOJhe1W3Z6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbFAAKCRDBN2bmhouD
 1ygyD/9nngr87hzxXL+Ps9b2ZzJR+TXj/YoGldLxc+zzI40VIXOq/CMkZQSkOy+sGlvlDaMbC6G
 OUxOZSgGVyJSYrQPPoOkZvdRZQlA2pGVRlmZmen85mvsnNXa02J3ia3Klj4R9st1aTP0MGDW1lx
 9CcEEW3TSqnV/k8+3049Q1QTi7j8w7NRzcz5ZWPNQALST/uIREYVg58HLPorDZB4NpdTvr3PNGu
 AxjgkLhqFKTEwtZwEkeyoAU2gulMVPDtYmhFcAj/XvdVV8AlOcDK/JiU2dNgtTmtDQeAH/E4O/E
 RunnOltI2NeNhYQuUQowcskuBrM3nFna57XN6QldWpiZ9U8NNyO1LWHLplrjvWdzr7r5qJO0Xwv
 lZz4s/FAAQ0XP7oSi2CSN+C400Xrx/9worZYiop6HEnoAFSMmmQXYq2L891hVliC/Hdr9abq/O7
 x+9wDTaaNl4MSFiYRF8RcDM66RzKwPHrrq8NVpRQxUy6KVxvxJygvMsYmKjABRSfp2oWxs/msQp
 Qj6wC5ftBnUeDUWc2EhFOF0FQ4N0LYLgkHlYfy16j/rWBBXtSGb/RpPh2v26gK2+ivlct89+f+Z
 mZ2XIRFghFGsojn1n7ThUxn7/DMTnaWIfk4VeteE5JMk3COSDqpRmSFB1j6xrlwU+je7T6TZgnB
 B2q9qvtV2XZQVuQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt700-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt700-sdw.c b/sound/soc/codecs/rt700-sdw.c
index 52c33d56b143..24cb895b759f 100644
--- a/sound/soc/codecs/rt700-sdw.c
+++ b/sound/soc/codecs/rt700-sdw.c
@@ -558,7 +558,6 @@ static const struct dev_pm_ops rt700_pm = {
 static struct sdw_driver rt700_sdw_driver = {
 	.driver = {
 		.name = "rt700",
-		.owner = THIS_MODULE,
 		.pm = &rt700_pm,
 	},
 	.probe = rt700_sdw_probe,

-- 
2.34.1


