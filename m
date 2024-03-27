Return-Path: <linux-kernel+bounces-121720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F20388ECF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A882E29D9E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D2514F9FB;
	Wed, 27 Mar 2024 17:45:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6814EC55;
	Wed, 27 Mar 2024 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561524; cv=none; b=MFFrGYn4OQLIyyStxu12d5EvikWhKmWUIhJxHgB7bBNExdm3vySDrQNblSehFgwIAjyqFz0OS7x2YIJsdJ7Va7cmPnp0yA5DXwd9vMoZJDtbznnhscoEO8CPzCHVwtW/UmNybG1Wkfhd/lojEFYYJi3eBpE3RnXrmPJx0NEoz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561524; c=relaxed/simple;
	bh=SDz1QUCvzQDhphMNqvtB6qWeO0A9iIEXepkl8QtR86w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxN5kOgdd1naqONzUUYddaxYlr1OZ9a/2o3OY4Uk7HwA3uB7QfdXsw8GHh96VZL5KqvfQUSDl8rfTFL3JFmqxteMl/QZdfTxlDtsf8d1/GgKswTwUOAG0axmf/jDL/d/8n2Iqc5OXNC0bpK34w5MXEJJHpKgY90kI+cmIOCif44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54373C43390;
	Wed, 27 Mar 2024 17:45:21 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:40 +0100
Subject: [PATCH 05/18] ASoC: rt1017-sdca-sdw: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-5-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=725;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=SDz1QUCvzQDhphMNqvtB6qWeO0A9iIEXepkl8QtR86w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsQfYEs1vR9uoJq0CMaFJxg7s5qjy12oo4po
 XdUvH2vTiiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbEAAKCRDBN2bmhouD
 18WID/4vnJcdKm7oQwgNGEr++EBQVhvl7Og5B3qheNc6G1mtmguda1g+5e89AazE7Bv3vRLCEhK
 7SVolcCejUUgJwmyrztmOx7mhOGIUpLwPKql17atv8cEu2aPOjbs679v4tK68fGBTKcGYjZ76JV
 e8h/zjxBO1wfpworohBg9aHouzUTy61gtosLRDuPu7kCTnNNSd4ZSlNNTyvPGhbCHCdEUIUF5Qw
 0akuQeMdrExHGH48OiAoqpGx2DsTm7iQnKzV0wS9TWiRGK7s36uGkL9b03H5Y9hUTEQ/bZoSOED
 F4dm2jWWcwEzm1Ae0d60wd2Qe4h8UT70TIZpxKZMT50dYNQ78cm3FnobUCQogn6KpZ+lQPESjqt
 GssIiH755kyWaId450ATPr7ILnboSMlKPQzQEZlmF76r8R4msr/S1mEIM+nBsEezlxYnB3A7UOa
 5dRhE5e0uOfkZbKKR6e8+2K3O3dtEHz29aCXnuIyGS62gs8SqYJj4sXte/52N1tz6l8lUqypAbl
 e3BXvC1OpCVIJusmr+/TZAVHZ09o8cBiyFFi2LB7GN3SGNbtb3DIqaaCdXCJVfnVa2nRQPVsrVj
 lsjYndDEKh5RyumCWCQS+GyO5cIVK0Q4FdNh4DF0Q8tHVqARL95HIvix3Ih9FKJG1E9Q4UPxAJs
 INuvH5sJ2kl7siw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt1017-sdca-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt1017-sdca-sdw.c b/sound/soc/codecs/rt1017-sdca-sdw.c
index 4dbbd8bdaaac..7c8103a0d562 100644
--- a/sound/soc/codecs/rt1017-sdca-sdw.c
+++ b/sound/soc/codecs/rt1017-sdca-sdw.c
@@ -809,7 +809,6 @@ static const struct dev_pm_ops rt1017_sdca_pm = {
 static struct sdw_driver rt1017_sdca_sdw_driver = {
 	.driver = {
 		.name = "rt1017-sdca",
-		.owner = THIS_MODULE,
 		.pm = &rt1017_sdca_pm,
 	},
 	.probe = rt1017_sdca_sdw_probe,

-- 
2.34.1


