Return-Path: <linux-kernel+bounces-120456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 739C888D7C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152ED1F24002
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF654EB4D;
	Wed, 27 Mar 2024 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="voNzA4ds"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB07C4E1C3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525525; cv=none; b=a+nViXiPn3BNGcZXXB+nTRKordeMan8g1igsWBbHzgfkBQA0GzoMLy48An4EjRp+uuADhHgfuvytddtUdV+TlIEtvkri0rrgS6FCcoDPSgrlMoSxXn3mUSiMbwKh4uL5pBbT2xnHswpRF8ddMAFi/nfXUwXXDmNGJdbbFHgmeGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525525; c=relaxed/simple;
	bh=Wg1X5HwAVxYfEIH1apqeIWmVG1BVbsqvEezzP9EP460=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kg7nUiveMadJ49lHwX2sTimJuzVJ+P/pwL13A2gOPFfwTKu8S5OtgS7SUaDvEjV71HOiGPel9+h8KKTdPWxPaT+imqlWZWM2VZBdc7tcrfAZfwX/hf8wuSyv3b9MT0wc4Z6K92DsqFZNbvsSLWyzYYTmuFQaLAIV+mae+qg8M7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=voNzA4ds; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a45f257b81fso738401966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525522; x=1712130322; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1eTVFmntz4ovjXpzKJKQby+6jO517KFxKyKAghdTvI=;
        b=voNzA4dsVxwnLbuvLt2qa1X4Ku/V3dchlIqD4xYG3fmeDCiP1b3hLjEdsFTua9rFoE
         nJ7Q2R203b/awmDU+U3vLujZ8YybtUNpUD+qq+K1wSKYfU6qUpmAoS0S0eHwcApjG9zF
         RAmckGQBvcrt3eyfXvnQ1EFCVSm4Up6MGHPAtKuk/tfb6F2K9MEOG+fSZkIGeQxyhevv
         Zxf0PcQzQYSiMYR3iDvibCXkN2q42gcu4ul9+ZFUfLSJN8dUnfQhBxf2bIePVe1vhw2P
         u8/NN+0YE2tJ/Qp4spyyhulydCXo3XnSFT8r02GD4qdkh/Ce+qrn+y6kKmXvP4+jTqss
         jjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525522; x=1712130322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1eTVFmntz4ovjXpzKJKQby+6jO517KFxKyKAghdTvI=;
        b=afPz5Tj6FjxH384Vy9AZtAjLPgIEP55rjpbQ3FARSpah+jGGrX/RYrY/4iSOdzYY1r
         5j6ErB3mXk8/3JWu7UI1K2tyvj0Bz3l1kGVr5apE+fyQPVWgCPS1Ko66H0gfqj3Ilzxi
         xfIUOFJyNHEb8r4NYk1T7zm13TxPcuVGnt5o2U2h+EpsGjnrZmYBtt9gTKizZnUaXFao
         UGM47G3uN5bHSlBP09okySTanzzBdKe+4YXX56XISgrykwbaFOiY/81tgkOdAqXF9LzZ
         Uhig4EraAwwpDmtV3Q4iuQcMJUzyTFtoa9X/W2+N/lETjCG+qyoBlmcmrhd60971A1LX
         m0uw==
X-Forwarded-Encrypted: i=1; AJvYcCWb+HImX+41Gw/+7M7IymRvwzBQTkRtRkYYCmIOUrm6ag0nlA0VAxv/RouefoQNcDOwhF7JIArjTb7kEdfjFR8whVFSM2KYRmqnkimM
X-Gm-Message-State: AOJu0YxNGwGUFLRBjf+4sTSNiEjmX7FRI59FEX+1SmqXmN8p2MRm/M5A
	TfYG/+LtXo5T8iZ3hKz9PJdB+RyJQM/iv99WAIMAScQw561Wgzv3KEMIZlMFI6Q=
X-Google-Smtp-Source: AGHT+IHx84qbmViqvNBHIzePmxhHICLH2x1RGmMtZ7MpTJn4t+7Y+v4TlMxksaWH0I8un2QmTkwyJA==
X-Received: by 2002:a17:906:5acc:b0:a49:fa33:a413 with SMTP id x12-20020a1709065acc00b00a49fa33a413mr310739ejs.69.1711525522151;
        Wed, 27 Mar 2024 00:45:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:43:57 +0100
Subject: [PATCH 10/19] platform/x86/intel/smartconnect: drop owner
 assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-10-725241a2d224@linaro.org>
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
In-Reply-To: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 Daniel Oliveira Nascimento <don@syst.com.br>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Jeff Sipek <jsipek@vmware.com>, 
 Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=783;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Wg1X5HwAVxYfEIH1apqeIWmVG1BVbsqvEezzP9EP460=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85TVv31sDf8bPuTon5Zx+mnZ6bUQuZeo5/Xt
 fBjclRCwtuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOUwAKCRDBN2bmhouD
 16DBEACTOBj2DSuJdBB70h5TLGwqWaJu432sTe6aLkW1LieQihUopEctQF2fLYrgCLQKHaUUXJ8
 QAUreyqfaWhwNtQXOOY+bdZnkfk4gyaWSJZs5Fk/bpVsEc43nl80YuNCc8ItykAFg5+TheZqy+k
 JjgDHEHzI5CQWz/5zmkBn4A+WeJznAPBsegXHsEhQQX/ho7zKiDYjHLwBTQw7bk0TmO+EN6Eygg
 YgBztSTRMiAce5/Giga5i7QfhCs+wDJw8zSCUfx2VzXaAe/DhnnyunqmXj9lV6abeYjHGCvbgIn
 3aEGmAFqT3Pn30r27ykHhk4uHGeIXh+Zic2zH8HedGT6bVsjIH5fTufZn3/Tw8sre2+d8BHl9qj
 WzTJxdG3iA1od5CzC3jQvCkCJNBvCicgWMu7pibxMcFJfgGkLedXpWMXVczrANbeSm3aWMB8sBx
 Kzxl7bUppGNDMeY1XXccf1efJygJn2IYpAzA2vk11MGYMZB6ljwiPow74m63ENnh4LSnqAbZCm0
 EwHfbJqYPPJ68WW53jZHdg6tXCeX5ykaqKn+hrOgEmv+3gV+X9l2bXF0XHKqSwOO4d8wLxe7GmZ
 22o1xa/V3ru4AMjypuWtnanLYv/MSbb9UnHCVjIDCmrhRTdICto3f9zYrm2056Mpbp0OCpxZCai
 9rUII1fUB+NLzzA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/intel/smartconnect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/intel/smartconnect.c b/drivers/platform/x86/intel/smartconnect.c
index 64c2dc93472f..cd25d0585324 100644
--- a/drivers/platform/x86/intel/smartconnect.c
+++ b/drivers/platform/x86/intel/smartconnect.c
@@ -32,7 +32,6 @@ static const struct acpi_device_id smartconnect_ids[] = {
 MODULE_DEVICE_TABLE(acpi, smartconnect_ids);
 
 static struct acpi_driver smartconnect_driver = {
-	.owner = THIS_MODULE,
 	.name = "intel_smart_connect",
 	.class = "intel_smart_connect",
 	.ids = smartconnect_ids,

-- 
2.34.1


