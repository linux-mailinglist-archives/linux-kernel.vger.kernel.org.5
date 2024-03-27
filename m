Return-Path: <linux-kernel+bounces-121717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D65E88ECE6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE22C1C2F3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1202214D6EF;
	Wed, 27 Mar 2024 17:45:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07114F122;
	Wed, 27 Mar 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561513; cv=none; b=X9hyvUsCHzuk89KEH9jM9lxH6+tW6gShfrNKisuIojBjziAvpt3Kn67PIWTf7di2wcsZIX9vMiizRje/h0sN2WF+0OwYKVdlfuzY8QR5TNPdyAa9h2tjC96JePECYbNx9ryYSKcHq+w8Wkc460o5aBUsWNfyhPfG83q6WVf7t+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561513; c=relaxed/simple;
	bh=YsWuS/bN+ordVLNDDyUzgcWCwI9QLJJQ0tzgJwDTOpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ya8iK0ZdEw6gP00PpAShX/lqm5KMcfiNlnyAv25ik66W6Mmum11lpiPRGZMLsFLmRwvVtykj9wKAouKl0tqlwjGhBJsLyatZTCeaE6AKfi9ycUVExJe+Ffoqj6BYXm4icvLpAzGFkDwrVhTiBPRTwVvo5BRgVa5KwEAp57kF2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F643C433C7;
	Wed, 27 Mar 2024 17:45:09 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:37 +0100
Subject: [PATCH 02/18] ASoC: tlv320aic32x4-spi: drop driver owner
 assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-2-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=730;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YsWuS/bN+ordVLNDDyUzgcWCwI9QLJJQ0tzgJwDTOpA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsN6qyk31Kq51SDkb1+nr67wbSc1UZfPgCFC
 UQZKmSc+ZWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbDQAKCRDBN2bmhouD
 11ozEACRwJ27ei9Jb74W2gi2HWdW7qpjp6WxnRj8fNEeSYTu/bMA0ZZBIVNBmJKYeF/CU12J+sp
 p/umQxlWpZf6QO8cN8reIFlHEkxfKdkJsfOioBIB6SUUcQ6kMqd/B/cIZXnbT7Lt8sa5Vxx1kiK
 tRphy9ogSVX/lY3ckO7lcDtz2/V9YVJnLaKdvFCNme322Co+jmLC8n0R/EDWUJ/kwyE724fEbjc
 VctQ0CXYdaPlsLGAFtAooG2DDM/qY6wDVpXpPc46lsSzT91+T4hQxBaUqtNieGGn5KOEx32V7HX
 +f/vgmxkBY6m4aovqN5NCJQRU9CORKxGaiilmLzrUN5XhLznMMA+J9MVG9tTlEKZ4sHTmVfvYf8
 NgG23OcL/7I+Q631p/qz2DD04+fqAGcFElqSeRN0nQdYcE937KW55xqNnedhhXrqCc1Ul/yUBNn
 6XO2sV2EjbVzidK2wPblYVFXaB2wyv37RxpwJZ8raOaBenhAf1TCPdCrIUHCU9TlJC+S/AiAUpq
 i6kxuG2OsW0hzDD/v4Qvg+EwDuibmwOzAinAz7pbbJA5Dmgg9NdoCvEbKaUh2mqoO/F/SpXVQ9h
 HrygfNaaHfPZkZWvb2YQQ2t4CkTCqgcyTAtlSVYtVi1aSKxKLe+JIG0EPbqT11M9gsU3u2efOGQ
 0F2CMiFpPUtXQUg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/tlv320aic32x4-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-spi.c b/sound/soc/codecs/tlv320aic32x4-spi.c
index d5976c91766e..92246243ff94 100644
--- a/sound/soc/codecs/tlv320aic32x4-spi.c
+++ b/sound/soc/codecs/tlv320aic32x4-spi.c
@@ -56,7 +56,6 @@ MODULE_DEVICE_TABLE(of, aic32x4_of_id);
 static struct spi_driver aic32x4_spi_driver = {
 	.driver = {
 		.name = "tlv320aic32x4",
-		.owner = THIS_MODULE,
 		.of_match_table = aic32x4_of_id,
 	},
 	.probe =    aic32x4_spi_probe,

-- 
2.34.1


