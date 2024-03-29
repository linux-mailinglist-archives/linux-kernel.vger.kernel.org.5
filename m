Return-Path: <linux-kernel+bounces-125242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D98922AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AC71F23023
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D5613BAC8;
	Fri, 29 Mar 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdwTozD5"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C9C13A86C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733099; cv=none; b=soT5Foym3PEWd800go1z5TQQ9sAu4fSPYZSs2BIysW4xJHVdIHGBTnENsD3rkNrom53Q2vaHlYl3jR+py2cR2FJ+TeeCB2xU27JIqyK+QQojNYMM/QsFfy3moxBXR1zjUPK4O4bgohEEynRKAyCidHy+MuBwYuvZFZK9+Hl4DbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733099; c=relaxed/simple;
	bh=wDiiPdIToMYXQU5+yRee3/V3ANx19Hr4dGWjE2WOnus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FKaO1xG2h3eiPLBoX44yRwcR/sKNYBZjTO9WQinGclptsvPUi5fq2f1BRBOaJ7dIx2xrIJcUO50aS4dvHuSWr+jFLAtdv20xskzuWdm+nENWBCxfcln6PWLHxtlECIT/xqvqgPIcUzkwlFABsqMidsRIvXFKbF+dqd7fquIHd8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdwTozD5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41544aef01aso12601385e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711733096; x=1712337896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8BmwG7Q6jYnzmtteAjttsKel77uSlwfKjjKo/sXHv8=;
        b=hdwTozD5woF9OL4jxripOEhUPdN6zzBv04GjYd2tlIZ/VuBWyu/4gAghQIQ2Rg1Q13
         Uduw49mLBwdJoYiqGpqeDTHG7VK2TEU0pvjiSKXIu1bxBy9WK5S5NUJH8/9RK3PAJRzK
         opjX83w921eU7wm07SYYeQVLu0fnBpbbckeHGS+o+Q3zUE7BaqRYRUQESKQMCVAMlqZD
         D+owh08IIWAkYzzGAqIjaZxM/1M3y9c/EOMX4baSYIDLJYWTPpUhCrAO0Wxt9+Ow8FHz
         VXY+xkMSqxY3sTN3j2B9xFxacgbHif8dsbVK/2tf+KHMbWAeozWoQjrPFaSqfUHRp1HW
         huKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711733096; x=1712337896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8BmwG7Q6jYnzmtteAjttsKel77uSlwfKjjKo/sXHv8=;
        b=E6iSY8BA+Vq6xtXjsPFV6mflmo+h+6CTxLyrVsU8XGwoN/nettcUhUtOJRqxk2W3kI
         ZvHQFNRR2RgRRznnBcMhx/MYqqOo8CBtWZLCQBC8/tPAaaKf6VBzUNG75D+3vZPxcLdw
         ajvVYYhba68eWmFDdyJjlO5NVzNzBF2GXWTh7FiHINLBowi+BvUU0nmqC7PqM45s78hE
         jnesjBhyY/zTzBLGp3ni8Aqpz9+T0MXRs9EYWiyvYA7qiiwsD3cV3FwMuYZRHYWvE/UT
         yMNi+j1YowXZfv2QmJMPq9QaKiJKwjNxYE1zgmQqEBRFm8Smw9RZPb+ab/aRsrmFWaT3
         Oxyw==
X-Forwarded-Encrypted: i=1; AJvYcCVgd5VuHMG3qOIn/69SDzD5OKjF+ghLZPo+b/RlpPZtURh/o2izvVEPew2LO+0kVLTpbU7RDn4HZiEbNg254fylX/0yz+nWfqt8cTxK
X-Gm-Message-State: AOJu0YxnuiX0re05R+4/tbzWUez/WN4VLXByXdUWyADaFuF6u2bpFlKL
	TfkXt95/Pp3i5SEPtLUn83OD7GbjyYH/LbdDYp1yLxZAaJkvHIfDEcOvIbqynHo=
X-Google-Smtp-Source: AGHT+IGkMQKZmBwfysAyXcTOIdEaETGLP8XC6UQptvkkNiT6RrRdfIxr4AefhOFV8q8KgXAsCgTSLA==
X-Received: by 2002:a05:600c:4f44:b0:413:2c4b:35d1 with SMTP id m4-20020a05600c4f4400b004132c4b35d1mr2416556wmq.31.1711733096290;
        Fri, 29 Mar 2024 10:24:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c470800b004149543c82fsm8491069wmo.39.2024.03.29.10.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:24:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 29 Mar 2024 18:24:35 +0100
Subject: [PATCH 5/7] wifi: brcm80211: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-module-owner-sdio-v1-5-e4010b11ccaa@linaro.org>
References: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
In-Reply-To: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Brian Norris <briannorris@chromium.org>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wDiiPdIToMYXQU5+yRee3/V3ANx19Hr4dGWjE2WOnus=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBvlbWI+uz/9YwUaNlefiHsHpsoaQewqU+4KoC
 5vsAyo/lEyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgb5WwAKCRDBN2bmhouD
 17wwD/wJZQBJuomWoovMyFzif8oMaN6Puy7t9a5St5yy/oTFPoU3mqYzYEazstQewmxHvQUC57q
 12gVOI3lkjSN7jECNwwVrruhMnyzAPJX2Mj363zHzxxFAIWv02+1K2uoYMSiT3tboYo13zUUKAf
 bL2FV8El6mxFZoLTjYq+j+BQVkVDUxHH3vDDj5Gb6s5/CDQaSXMbzmJV3JM59LwxwkIRXOkDkp1
 6r4wkWH5vTAefQZbKuKd0GY+kaQ80eHpOhz5R+QbBiAWJ4KJoEKLXHFeXZJErpRRfi9vQgl1E/k
 Nds/H3lTLJ/HIIZv3545bPWIl7uWDabBQpm+o75gegBXRaW7DOP50XRPktxUF3cdtxXqz4IP6/n
 f2Ef/MKjS3MVCOlVsVThZS9RaoNQKbuM3yhDETpqBOv6Xv98szOYEkYtr5EQmMMkqydFE3FS50D
 30FIFa8pX2wUEu45dM3tEsXtoJn/CwiaDctGHRJfVHlBDC2pTeMT8eVp8SeRSEGIMmm4KNX4eHB
 PkQFlm9RMpykklRbyAQenHDshwl1WuDToLRkFW53XltZd8xXR4B5bYqMuV3Wdp8KN50y+1bUUxB
 Z5KPesX3r313jcBNZv7LfYa8aob+hVnPATZeEuObcXJCmEIndjEz5WZGaPdhbniutXm9FOlcdOm
 vozlrq6EJIGUBwA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 00679a990e3d..13391c2d82aa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1238,7 +1238,6 @@ static struct sdio_driver brcmf_sdmmc_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = brcmf_sdmmc_ids,
 	.drv = {
-		.owner = THIS_MODULE,
 		.pm = pm_sleep_ptr(&brcmf_sdio_pm_ops),
 		.coredump = brcmf_dev_coredump,
 	},

-- 
2.34.1


