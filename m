Return-Path: <linux-kernel+bounces-121731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A67788ED15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF158B268B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFEA14D6EF;
	Wed, 27 Mar 2024 17:46:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4F14F123;
	Wed, 27 Mar 2024 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561564; cv=none; b=W14akKeIlYtRdV/zNIxXJXlw16186XD8FR6QLST64fxL9Hm0s4ggdzbXEtAU/mpvNnavfOSN9x5jKz6jvF+irg+QxvBPWGnl67Y+wU+8I2eK8p7or3sDrH0ck5oEsL9yZft+1cG47g5Z/QfM+Ybr5rGhxq/hAmfzfC8eQ+yUZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561564; c=relaxed/simple;
	bh=ETLhuYz5m4xr/+VXdfDxxoQupSFR0FsUoJ0Ir6SnQ7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8bf7cpm1LzmV/8bP0crR5P0l24TqOWjwtxd8lWbAJ50kRd70jp8lJFGEhjf8Bv7T+FwqHQBAIBrOYsTsq36RUunLsguJ7hvV+KToClreWY0ub1pwD9xHiwsCGrdXJf90lhyag2DsJOGNfF+uA7ZCmeIKRCnGnG1+1MgFWFcWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1719C433B1;
	Wed, 27 Mar 2024 17:46:00 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:50 +0100
Subject: [PATCH 15/18] ASoC: rt715-sdca-sdw: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-15-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=700;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ETLhuYz5m4xr/+VXdfDxxoQupSFR0FsUoJ0Ir6SnQ7g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsY9979sPiwsmR/TV4spfSFI9EiZyBQ6YBXo
 0TPY0CGbCGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbGAAKCRDBN2bmhouD
 1/g/D/4y45Jb7bmhvso5WWL8uHeD2EU72tYoCZKa16sNueBPDy+tyUygkXwLpF+GKvEG5NjLqn8
 RC5mPY5AEiBxsmBQ6n8h9P2B/Cy2Ads/W21EungdawKfozfofByAWn3ham+qqlipqdFnpHL4QY5
 /NQ8w2Z1V4fHuWzJxycd5Au/zbGdBrsxtLtFGUzkphOBouRR9Bq51ljpAvxLQPGlYCPhzHbnjTp
 03jPjBZwdnUMKBiKKRLlEbYX1W3ItNYfFfrOgHvzrZQRxVbZwn1fRVdxyZhzkS19YOskKSJeHoO
 4Es2I8WMnT3cqXh/mXJrZiU8nJNmGAD70oSHVoSWU3t9y1swUOGaJ6MdzfEceQj7dnyVn1+9Wf5
 jdERwTCIf4Fs177th0Bl0CjOclIY+SaWZ3eLMS2A4KxJF/9VYN1NA4ix+/qqOVgRQf+IaCj9IIR
 dmLrqfZMFPgM+3BzKEzChUYHKlf0NcG8eow14/tpbGGbneJScFrBUlz7ypeM7mWL/D0qAIbZFVB
 +3cIq/yE8/JHzhIEmcFHNMp72nSsy/0kRv4QoJSyLxvPmcWkZeyF9hjz3veRbMLycsKGTj7SQyN
 0d9towFns/JgzNjUrejDJSZhRXsctfwwdqZ38h1CYWJPJddncnHq2YhwkCV6gOVrfygSOI6hKN9
 acCizvvJdbiWs5A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt715-sdca-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt715-sdca-sdw.c b/sound/soc/codecs/rt715-sdca-sdw.c
index ab54a67a27eb..08db815d3c8e 100644
--- a/sound/soc/codecs/rt715-sdca-sdw.c
+++ b/sound/soc/codecs/rt715-sdca-sdw.c
@@ -270,7 +270,6 @@ static const struct dev_pm_ops rt715_pm = {
 static struct sdw_driver rt715_sdw_driver = {
 	.driver = {
 		.name = "rt715-sdca",
-		.owner = THIS_MODULE,
 		.pm = &rt715_pm,
 	},
 	.probe = rt715_sdca_sdw_probe,

-- 
2.34.1


