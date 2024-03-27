Return-Path: <linux-kernel+bounces-121727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60CE88ED07
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75ED51F314E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D7152191;
	Wed, 27 Mar 2024 17:45:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4614D281;
	Wed, 27 Mar 2024 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561552; cv=none; b=esXff+imzNFeljC98RFCuyg9lAnSon8roOSmGEdF9kDm6qcgS7hD7paAhOpTlqA8INDxAguFdF6HlaD0gKgjGEFi9mmV6jS0GJoHR0/5W+YbnaYCa7h5UB8tyndG65Bgmyw4x8xejgqbAhdPcn2r1SZF01GlPwmhnsysz5s6JxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561552; c=relaxed/simple;
	bh=HJ+pITzNOF/Nh/aDDL4TK+BjymVwOnnMENKw9E4/elg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bmw5kZLNaieDR89rNDGA8EIXL00YdS9STNUjPLVleaKvZlmt/xRd/4mmeivq8RnLd91ViZtaUxmU4rVs47g80Oz3MK9lTHAU9/hf03xZZP8h1PKmC0kP2YFmV7g0NFPJK2gJRWmivmOMWtING7pDmmt8Kjw0ETzjc3BwqpnAYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93397C433F1;
	Wed, 27 Mar 2024 17:45:48 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:47 +0100
Subject: [PATCH 12/18] ASoC: rt711-sdw: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-12-86d5002ba6dc@linaro.org>
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
 bh=HJ+pITzNOF/Nh/aDDL4TK+BjymVwOnnMENKw9E4/elg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsWhGvL8CxXm/7lx+WjlN5d+1T09rhdZMxrV
 +xamzvzOISJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbFgAKCRDBN2bmhouD
 1zN0D/9zcomOiqDpDCPOH1K1FvLS6W2WF8kLU6e9azsWAKxS3VOKDvUGot5uX9MDzMjGyBAnJOv
 +vpdhxfUw/xUSDWJN33nql3IgRPeK+ID3uUBI4NNzSxTmGwbdHfyBGUAo5Wk0KBWsiaEpTObQUf
 L6OAVstSK0viddJO54llBUHFzWaCyziiNuUoqHJwvB8LEF73Kip3uf2oL7tbXga+ptgIicVh1OT
 dDYBG4RkJN1V5yru9UzN9TC2Tqz7JxQjUTZgKI6Xhp2DGbB99Df0WNMIkStPdWBT6jdnMv5+hP1
 frcdF2KiQVA//JwSW/MT8/pekuwWUejefh7HF010s+bxij1oUcQdL4Xh7VrZ6SZdjbU45jSFHpj
 I/wpgAyoGLGFwMwmgNANJQ/2RhSXb4Hu7BAeUJbylrAt0OF5PAz2M5Z8A+05W6MHO4AuBIacQ+2
 VzdUgV0gsz/b3QG482lKkqbTvca74PRyZmJ3afJMM0zN13qHJMpO8BV6zF7AKssmHjSR9Z9V3DY
 qCNDRxzTW6Pjps/5a+8QgnfMMHYLEoFlEG8Qf0Uho9RfLuSz31HV2LwJUTZbAypA59pU1MTaOKn
 gcQJ/S0hYDAyN1xm2L7snykiq7LpPF8hxnWE9qGSEQC6ASaSNkRxQb6VYeyylbXVRxvB35pLiAw
 CTSrfBb4ehwgXrA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt711-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index 3f5773310ae8..0d587f48439a 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -569,7 +569,6 @@ static const struct dev_pm_ops rt711_pm = {
 static struct sdw_driver rt711_sdw_driver = {
 	.driver = {
 		.name = "rt711",
-		.owner = THIS_MODULE,
 		.pm = &rt711_pm,
 	},
 	.probe = rt711_sdw_probe,

-- 
2.34.1


