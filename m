Return-Path: <linux-kernel+bounces-121715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F32A88ECDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F161F2F892
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A814E2FA;
	Wed, 27 Mar 2024 17:45:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD314EC47;
	Wed, 27 Mar 2024 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561509; cv=none; b=rl12gVmuS+Zs1idRwPjohIhwA0GyfZ5pAsG+QFbxpvz2lyODTzEHxVavPN52SD2EJB7CvFqJQrH4B/rda/hsNnsveygJqATbfJx+q+6Z8c1ZQ1t859VRtupb409e5le3G+CwDVT4wvBJ5fdykQxEFQa+bkHZEn4sDvbktAKb6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561509; c=relaxed/simple;
	bh=8b3Oy1fGfAEMtFCQt+ck7h5hi5WBMlup1AiHI6uEuQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F4mUs9VO5o7ItqV4SEoblj3ZTD68tkRw8aGQ6MfWEBiPULQb/4/ETLcUHsLivDhtOb1M/r5dl9mX8OpoOhZwzCVDXuBFqYUI04dxHO+fNUh+zke0psciWMs4quBj60EeR2UbOAZivNrfp0k5J8kcY9JEdKYC0UUwnPn+Nm/y2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91458C43390;
	Wed, 27 Mar 2024 17:45:05 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:36 +0100
Subject: [PATCH 01/18] ASoC: loongson: i2s/pci: drop driver owner
 assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-1-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=716;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8b3Oy1fGfAEMtFCQt+ck7h5hi5WBMlup1AiHI6uEuQ4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsMq9waK3sUmApxn+Pgq3ozM4SqdJZCNR3FX
 t3rRSdTYGOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbDAAKCRDBN2bmhouD
 15ekD/9bc/yZSAYOk/0Nmx+0MO0UQCrNTW36lgpNGGKKUf7T3sdicWoMqT8jtzS8prS+C3QQTgG
 ubA+I0/Cq1JxJgIXabJviAq3usM9snUQR9irTHDD3nMsK30gO168uahyl6IdOIGTlRCW+DTlpVP
 c3bibtrQ2oKkJsFZ0KWpbpLO1CTKkk3U5OwOcsjIusOoF0pcPX5Dfdwp2hAWtrRrsFGphjB+mQB
 INQODSP/Lfaa7zdVmvgOO4xEpVuLY6IXoDrSwGAwAVFs5qJl1k8MAhFGteD/dDSr4f/b1CkDNZk
 jTsWoOagqfIh/t9dc3gACFWdCw7/fcC6UnDEo5QY77gz1BgCYDv+iyjyHhcmg0xqbBejzBcDYqa
 NyW3NFj+rsugCL2MTCPVWEHqCoe73VoOmuX/reiQDfcmpz0V5sYAFjjQIVc2mNTUJJZCi+oVsfW
 4OJn2hIk6uGI2qBQG9GP5Z5ci44YWKfIyaX/Fa3//OpUzLOtW0XUD6jDuoeS3swcjUQBL6cj9S+
 4RAAfw3JiRMoVIieXcDFZmzzMIquqPpx0zRx2h+qvmj6ahTeeLDSZEgR6PHA6rOqO9KQtaCL18l
 rX9KFllJr6Lc4lZ+BggQXXhSHNA1nLxGnaIEOa6TajyJrl4kjaHX9eUIV2kWkZLL+QqShRdZWs0
 4IMJIRDjrnVkY1g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

PCI core in pci_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/loongson/loongson_i2s_pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/loongson/loongson_i2s_pci.c b/sound/soc/loongson/loongson_i2s_pci.c
index fa90361865c6..ec18b122cd79 100644
--- a/sound/soc/loongson/loongson_i2s_pci.c
+++ b/sound/soc/loongson/loongson_i2s_pci.c
@@ -160,7 +160,6 @@ static struct pci_driver loongson_i2s_driver = {
 	.id_table = loongson_i2s_ids,
 	.probe = loongson_i2s_pci_probe,
 	.driver = {
-		.owner = THIS_MODULE,
 		.pm = pm_sleep_ptr(&loongson_i2s_pm),
 	},
 };

-- 
2.34.1


