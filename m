Return-Path: <linux-kernel+bounces-121722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A993B88ECFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6389829D8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246F21509B2;
	Wed, 27 Mar 2024 17:45:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD90114EC63;
	Wed, 27 Mar 2024 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561532; cv=none; b=BluXQcYucBimHoU2XBcipHN87P3knGoT2KulKgUk3NbvC+UwcUZ9grqe4jbGeIfXxjMM845fIGuK2O0yscEuxLFeGG286Q0iaps1sW9iEfJtik0C7BACPAQMUfF3Uq9J3PgzsC+5YcZva4w2S0ZRZj1F7UCizp1KEBECVcljtcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561532; c=relaxed/simple;
	bh=j+ijhU8mAneZ/JkPOO+eFUwH/BeIq4liy8ltCrh9mjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=chj/cYRhBFMCe0mYQ2Axu1O4fc9tqmitn+Ct7V9faycnRySYkYEQkbvZJiFk4CW/JL6QAVc4Nbt5ZLsAkchKno/HrGug88praznQs1XnbsyOR+egpVmcv22OYDcJ9mDCwbwYUnxaOb1Y52x8S9wgptML6KRKaNCVWOywddaBiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D47C433F1;
	Wed, 27 Mar 2024 17:45:28 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:42 +0100
Subject: [PATCH 07/18] ASoC: rt1316-sdw: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-7-86d5002ba6dc@linaro.org>
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
 bh=j+ijhU8mAneZ/JkPOO+eFUwH/BeIq4liy8ltCrh9mjA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsRMorQIOM3VuwOd4PSabUGLAoXhTw/Hzyap
 n/PNNnJ/PeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbEQAKCRDBN2bmhouD
 1zvcD/0UeblMnBxCl19QpNIuLK7h3Hux8vdKgc81hXo3ms6iW6DX1122BQegkV2r9biGGJuJtp6
 cFx3LwZQM+nCpvEFubRUzoPyRS3jvMkkPaDwx1mJdNVt/5Yo0RnVifVRPnPb4g6qVUUtd4FY9FM
 a2+r5jmxHsUi0+ZShA9bCXsnXCXK8YX2XKGOPmkruNKwUhg/Mb+t6bp/2/U5hs1BDkVjZTLu+ZE
 I8b/7m/cwqazYCox2y8WoG7Rk6N5LCKo+AA7KT0hyJ4KCTfF8zI3k7mJet1UYeVFlkRTJuqoPm5
 fM+PguAtvVAxCa02n6k8tY9iXbrcI45H8e2ER7R3yaVKnP6SKqJ+Qvn9lm2Vbrqos3qQ1X34mto
 SNbV/w9gYWCxy3EnXyw/zoAPUIG3feIgA9zbmeq9C0f81332tDz6S0uVrp74envwPZH2OvOjzuM
 AU87cxk2akwLUA1yOjjNThfHrDq4dI+c7rcu1J5LGRXyfztmEo1vtujlU0UBrt/pokAYI6I/rZW
 UGDbFAE/d4btL/8BuuAQEK5HjUBifSmc0P/51HOKk1BUTRgKfcJNA3PKNKzrcdIsfM6RFmGbMFE
 xEz68MDdsLMVG1dIRILZ2zpuxadqvw2jinSm3mXPPvt7u2iqEBXNGmGeN9JQJeoI2ixjPhXb7dp
 1GJcV2YFOTgT1pg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt1316-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt1316-sdw.c b/sound/soc/codecs/rt1316-sdw.c
index 47511f70119a..aa7c0ca66877 100644
--- a/sound/soc/codecs/rt1316-sdw.c
+++ b/sound/soc/codecs/rt1316-sdw.c
@@ -781,7 +781,6 @@ static const struct dev_pm_ops rt1316_pm = {
 static struct sdw_driver rt1316_sdw_driver = {
 	.driver = {
 		.name = "rt1316-sdca",
-		.owner = THIS_MODULE,
 		.pm = &rt1316_pm,
 	},
 	.probe = rt1316_sdw_probe,

-- 
2.34.1


