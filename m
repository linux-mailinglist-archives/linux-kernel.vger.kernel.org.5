Return-Path: <linux-kernel+bounces-121718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444B588ECED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA08FB218DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEA614F9C5;
	Wed, 27 Mar 2024 17:45:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88614F112;
	Wed, 27 Mar 2024 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561517; cv=none; b=HAboYMbqrtEvrJsjTO3Tt+WrSa8gkshz8abzW75Sepxo74QNF7u2of70b8YHm65nx+Tn966y6OfBtJXjVHHnAdzxXpUEoj61mcwkq6sSRQOoXSOp6WPACoE9D7I5yZMWy8VJK/PfBq+4HAh1baIlZwwaekHVQyqAr10jiqIk8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561517; c=relaxed/simple;
	bh=hnGUSISMWJyKzUzYwhipDPpfcmTFJLBeQqZyefNwj0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VxWFY+uIkI8HC2ziMllC7X2O60KEzVE04fZb4Ru/h9x/zEJmLbMQ0AnJVboRbOPubK6CkIkZba1QCG+AVFAoAQcE5QTN8TsvcIOjCEiHrEw/GrZy2LFo5O7xbf+EzDOZn3hhpziSyIgXvpjjNeloObYmtfx8/0/xcASgY86NB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D915CC433F1;
	Wed, 27 Mar 2024 17:45:13 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:38 +0100
Subject: [PATCH 03/18] ASoC: tlv320aic3x-spi: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-3-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=707;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=hnGUSISMWJyKzUzYwhipDPpfcmTFJLBeQqZyefNwj0Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsOhPk3ZT6rW9aW41+tt1GhJmtZw4eivIzRi
 2ZnIV2XDO+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbDgAKCRDBN2bmhouD
 1yOdEACI2wi4JJYyNZ/aFgOP+1zVwgvyQbAte66nrWJH4bhhKiu7El6ePUWWzvY+S9QcRxefKSB
 WBpC4PxTsjYPg2kKMQJdH8keyl/qtNjGs9SBuLfvjaKr4awvPX65mozDQV4HgowKG5DTllrUIr3
 rdt8W4PVnD0aYKVeao1DDrOl4OgQk5IterLd9d5IgAIEWpUFrf2B9cqcu/byEn4Xzep0JgQZSwT
 rLiCdYzv8Fee/CQZ8oFAYJa+mLbsdAsMOtfbFuh8ILV0LOu57wyzxYz5ovlgG2eHYA2hck1cY6M
 qQNx+2XT8vsTWikmhmARRJajaPYVVG8wkmZ+TE44S0D5PxpDOVDenb3xK1SkG3RuqdEqkpEzqC+
 SBj3Cfk9IdQgrlWtz50U+Bx7PlxfqXZWFoLYANJAPAaCXDAx+5jG3OSKqBWijOMmZh/eAWl0imc
 sjRRT8mv6l6WCHywvVOJ5FVy/XgKkLhNA9rLYgRczPfPZ/inGoub7NxmuwLQFFh3NRRd3akH2C1
 d9pYswKdgIWBrN+Z9CjnmH6Ibn+36qUX3DHbn3XGA41BHU4lRy5sYd+CHbyWdLgopBKQI0RNu//
 ZsC80XbcF5ED41An2v7/Z/Eh6uKwzHK95nm+hZg+Qpp7j9Ih98Qk1bqnmDi+4m3Ye5OvNZr/Utk
 99RKUsUBTvbA3UQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/tlv320aic3x-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic3x-spi.c b/sound/soc/codecs/tlv320aic3x-spi.c
index deed6ec7e081..f8c1c16eaa0e 100644
--- a/sound/soc/codecs/tlv320aic3x-spi.c
+++ b/sound/soc/codecs/tlv320aic3x-spi.c
@@ -63,7 +63,6 @@ MODULE_DEVICE_TABLE(of, aic3x_of_id);
 static struct spi_driver aic3x_spi_driver = {
 	.driver = {
 		.name = "tlv320aic3x",
-		.owner = THIS_MODULE,
 		.of_match_table = aic3x_of_id,
 	},
 	.probe = aic3x_spi_probe,

-- 
2.34.1


