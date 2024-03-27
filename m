Return-Path: <linux-kernel+bounces-121732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FCA88ED16
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFDE1F31DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAF414F135;
	Wed, 27 Mar 2024 17:46:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031E14F12A;
	Wed, 27 Mar 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561568; cv=none; b=I+YgaTUjiH13ijLXu0bcc/3YKHIOjbf2Rb98wC0WYy9CsFaL+HsqokGPDMyLLVym/HI+GHYxSpmkOUWf/KuR0xex5mLkB0dl42vXV6J4FqSNhbM9BTcrfcdR8VAAJOjd8MN7bPSQRnXEEyDbAq/qYCWyGHEh66HooU1mmOpJjRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561568; c=relaxed/simple;
	bh=Yakrd5S2lf1o46TVsfQLkasDh3pHYzGB68JUzvrqnvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ryg1ZA0Rsr/P4erg7qJo8F1uagOC50LayQPmmNCsGS3nQxj6Ryd/e2AdzbeBEK+gi7KTFFp9QFjsMtPcD1tiCfB0xH670zeIzwF32CZTygbLJ44awT/t2wLFoNxU4wIc2rhPs9f+JZB2dGWM4qNbcT+9dEhZprLHCK5EKL6cxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF349C43390;
	Wed, 27 Mar 2024 17:46:04 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:51 +0100
Subject: [PATCH 16/18] ASoC: rt715-sdw: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-16-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=678;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Yakrd5S2lf1o46TVsfQLkasDh3pHYzGB68JUzvrqnvo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsZ3YEEosti2IhBTR+tDpePklZR0FQLu6qwb
 xAvKias0pyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbGQAKCRDBN2bmhouD
 1/nXD/9w1o7uhMK1d2Ow4R8jLgPvGgfRNRsRy8Tvw5ruP81rc3FHUFsvp/NRmDjq9nr05FWLL0M
 M5+Qw7drzTIvux35+sls1XWBiNgQLXPlhoS+C7IGNh6a3QN4okfJP1gK/jeQEQakw5tVpiuFg4d
 qdCpbiR3sqEMHfFisaAmKJkLoKm+6chCqLNfsNIGq2h53Ms0X7fWdVYZY5As0SqTMb2yq75+g6w
 FiYlFAu2E93eXpnrSocmm0DKt1qshoO0GuPuKi5VuRbSiK1tKYkVMlyRRMeKU31ds6MHlJ+pi7C
 HBXGRElx+XJZMzgphRYd5bdrXQZEsljDjFq51zNr4hu6n648aURWAUh3J3Kre5aoTRCSE6p0oQn
 P6ISvHdVFsQSic9vE/6DuvgReP0HHhpXoHgzrbydr3uFiGwJsSCrtHWHak2/Q537pHDLt9hmIcg
 ju4Vy5MF73QGQr6LlNv25C2jYuPrVqkUh/DJUrXoiQ7NGdpITQ19xEd0uQFqI+FESZ6Y2jlyTZe
 yGfamsRC8yt5+3SGnVmQerlyRtG9le0n/BGC3LpqdhduCIVgubwDLde27ZCo5OI+afDzu6g3iIx
 TAcVE6vAiQOPimMU+0ddi+Y/IOOcoTgji2uS0yHbNXU08NPySxt89S/Qm1MYi5fTpc3vn1d2oTJ
 yVNL3fSNhheQt2w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt715-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index 21f37babd148..823b9cacc3e2 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -577,7 +577,6 @@ static const struct dev_pm_ops rt715_pm = {
 static struct sdw_driver rt715_sdw_driver = {
 	.driver = {
 		   .name = "rt715",
-		   .owner = THIS_MODULE,
 		   .pm = &rt715_pm,
 		   },
 	.probe = rt715_sdw_probe,

-- 
2.34.1


