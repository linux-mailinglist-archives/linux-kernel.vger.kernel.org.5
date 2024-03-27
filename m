Return-Path: <linux-kernel+bounces-121726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE588ED06
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4939C1F3151D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ED6136E1C;
	Wed, 27 Mar 2024 17:45:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEDD14D281;
	Wed, 27 Mar 2024 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561548; cv=none; b=TeXB+nxY5SAKUv0LbKhfPBVZAIdNJ7RFSQ642aM0+Wqw/VeTXwTwO8/FjOIb5mQ7RdrWOta9TNyArY0/JJipifjy5mMBwA9fGSQNBv0+Lr/WhW2BAZwG4cC7EUYkmNtBaxJpQuvWD6u/eEGXEhdr2qjGzofHEaE9LpPPYR2C0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561548; c=relaxed/simple;
	bh=NDmHxG5b5KxThAPS+rY6aKTae4LKNxv8bQXfWMyo10M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nO1kxR8W9IPfDwQumUFLdurRCFWMK/kuV1cOTqXMd6oKw0XTm9hoYvsxfEF86C+56nMJ+SfY1SvM3muIzbk0SD8ikZfSwENpRH8S4EukDMyoHaHRGS9rG2G889IqcbjcRGZ193MRmrXYSpQ7me01pUoSVy3//nBZZPo3mnGjMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD83C433C7;
	Wed, 27 Mar 2024 17:45:43 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:46 +0100
Subject: [PATCH 11/18] ASoC: rt711-sdca-sdw: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-11-86d5002ba6dc@linaro.org>
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
 bh=NDmHxG5b5KxThAPS+rY6aKTae4LKNxv8bQXfWMyo10M=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsVEuaANX7OOE6yNelav1DDbB9Usx5baI4gi
 tuQ3EI2tpOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbFQAKCRDBN2bmhouD
 1zc1D/4hIBVss3C1dAsJMgxBFDXLHbe9ObAYm0ibRJNg/1wGneGH/3L9Y75Yi4hEmqNiDpUDNes
 KmuiJ3ALQtxfk1JdmcjBghhnCyiFYQJvSDMM6TAx/sHxithkUqxMyWQD7SYBfzVPYcJtnGZC3rN
 2thjj5TP6YINQcYnqAnxmTqYMIA6iSKh8g8vUgijQHhSF65IMyxbs1/gfNQUbfCYmQ1aL/Z5fXM
 uzUfRQ2OI8hiOO8CepBPFaze9IukblOMNUc6sEUsDBM0yeDudN5j/Z6af7Z73RqvLp8R9lo37TV
 SPvM0h6tZipsEk9z8me8PTWEGbn71R8BDJUfiw/ssYCmPtJZIopFlpkYXVcNM5KLEoS8impp/M1
 0PIkNAtQmsJjawq/eETUewiiBLJwzEPCg6RRzmeqxI7EFFJ3fTgCqJ2SL8hYlJ+saBCUqvKjd7D
 iUnoDGyo1MCw8/R5y4UgXshqQdfjvnf8IMOf/QT4+RW43YMULF+K2kwm4wia8Zu+KJ7NGMJlN8i
 sryYhKgSuoAs5cJzZd5BoRbOf/cIzTD6dKanj6d9l50ZtuqluDmCMQkUYnMWfSMQ/xjYI3HvlVp
 5lzR8I+N2xLTmHtn6UFu44x37JUbryT/57fv4eiVNodxTFYqmAno1Dpgv2/1hqA6FZaeUOlskao
 4bmZycZ4Fd9TaPg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt711-sdca-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index 935e597022d3..a7aa69495a7b 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -474,7 +474,6 @@ static const struct dev_pm_ops rt711_sdca_pm = {
 static struct sdw_driver rt711_sdca_sdw_driver = {
 	.driver = {
 		.name = "rt711-sdca",
-		.owner = THIS_MODULE,
 		.pm = &rt711_sdca_pm,
 	},
 	.probe = rt711_sdca_sdw_probe,

-- 
2.34.1


