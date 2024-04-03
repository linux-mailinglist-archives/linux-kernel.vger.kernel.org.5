Return-Path: <linux-kernel+bounces-129942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 035FA897251
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E961F23192
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F014A4D2;
	Wed,  3 Apr 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vkTptoUC"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F4D14A63A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153842; cv=none; b=sT0gg36GpqE9TrMHuNeoY1ErqnxNlF77h3XPMCxibTC4PEX3H2TZj4Jt7SCcQIKb5+hcxFA804KuZqCEgNHSH3fLkjB9gE5EIlrDdVgBbNIxeo4sCuvOQKrZWjWPmMtw+xQfREx9h59JqJ5Zm+FoPszKCtjHayKRuvuyI0jxwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153842; c=relaxed/simple;
	bh=uGEZExd5go3TxQ++ox1VKkM6W5qVi0yKE/c7ScITjdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L0o9n9TITWmOGkSYhe92kvqCPc1gCvW4GDJcUpKJGJGEuapFXlcw6Eh/ifbmHgTEBHVsLQhj95NWkBRkbD35e9DKj4lFdzMfUbPj0nqRNLzY1nHMJ01m40yjIHb0D4zIBF144DvOeYgii/jHAppvyWQOppB1IHd0y19BdXBuXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vkTptoUC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e0c29ad5dso674634a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712153838; x=1712758638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnRU4IuiiR+L4DbUNFcvoGVCrcztEel/ynJcAah208g=;
        b=vkTptoUCpt6FvKoV2L2qgwTql70i+TVG8+yo70uNbbvW7PYdgHF6EPjrGDzyJs/CpW
         52ojBLoXUZPjk7yfNMOL9gx2aN0I9NmwbzFQO/mpAFJ7t5+HYOmhXVTwUYPb4ltaXhm+
         g86loovsGxjTmyckJRaPTsLsBfvLic8Eb2B0SXBL0uYhiiClr4gArrvEukbI0wvYwZqD
         47ryNg/A9cX2ucuxQu3A+/LSc0eP7tEnZJ/caGA7AqRdkzhWAz6hxmZeyWTMWmzS4MSH
         F2zeI5VwrJSKR/EwFsOkey1XowGHBpvxTNJ4ExyLroLbUfJLTIwrVFUpqw60/WbLCIgQ
         hpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153838; x=1712758638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnRU4IuiiR+L4DbUNFcvoGVCrcztEel/ynJcAah208g=;
        b=KVDubaN35DHdJABvzxwBydG3iYXW4gyqhy7t4Ip77910r6t4SG4DadWq1rqMC3dLLX
         3yde+gFFxoHpMSgTUeJFzwZXM4npOpbP/rA3w5eCm7Um5ilo8SySBkw50z6d3Zw5BO8l
         uLXLZ4RWfCh8Fho5/lH3Z3zZ5cO/mDcBzaG13wtH4gW5AERt4q484IXUmrmmtIjZEtpF
         n8jyvftdW4OZQtHsiZGVmaa4Fa5PW8mKuYq8kIWUfossCx+jBXeRLyXtaxb9PNSXMCe1
         0pGZS7IlBweqjfpVRoM6crXXoLG3kpmzCoJBxXQ0xdkXAsezrXgZgTIFtpMfj0T6FrI5
         niZA==
X-Forwarded-Encrypted: i=1; AJvYcCUg7PtrKCFH1gDLI3Rup1yDghxoc5O7/zH3wY1wVJP+6r88DZnRSu4+jd6nxoumIe6cF7YLFYGqnxQqDmhcuhgeMRpqG5iUzJYwQC26
X-Gm-Message-State: AOJu0YxvjCRvSeG5hBmJkJyoXZVGctlqB1b6nAFvu+zULCqNVT7JmZ+I
	iWiMUTXd62aY7BO2TI2Xw9MkNMgKJ5QmIYdSsyg8WeRYobUVAeNE1Erg2YaA+iU=
X-Google-Smtp-Source: AGHT+IFTX0zGPUE9Ns6+NdhULu8lAEjCjxyg2b/cKN8bqqMv3ElMG+Gylzpf3w9rj3hUtOEzVIzlxQ==
X-Received: by 2002:a17:906:da81:b0:a4e:a114:1afe with SMTP id xh1-20020a170906da8100b00a4ea1141afemr1688370ejb.2.1712153838464;
        Wed, 03 Apr 2024 07:17:18 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id he18-20020a1709073d9200b00a4729f093ecsm7737819ejc.53.2024.04.03.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:17:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Apr 2024 16:16:56 +0200
Subject: [PATCH v2 7/7] wifi: wfx: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-module-owner-sdio-v2-7-ae46d6b955eb@linaro.org>
References: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
In-Reply-To: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>
Cc: linux-mmc@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=795;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=uGEZExd5go3TxQ++ox1VKkM6W5qVi0yKE/c7ScITjdg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmDWTeqS7abKdxjbX/ezfyCtRmlw7qW/HCPv7mT
 6zlnQ7KYKeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZg1k3gAKCRDBN2bmhouD
 13ktD/9YFZuqZloQPg2ULSo6Tu1Ci1ahN/R5OjRUhoWDGVX8+2s91o6KVG79Tj8eEzmgBAY7y6m
 CSnfgaDDoklC/CohY+LXdWsdFugKHpTRCrUo/hHOWOMWn+IZqbt+KAuI4BKWIZVDLkRvUJtAtJP
 scnKqM6sovge8LFoZ+Gcr+OlBPWOH0gr47r9Um12eXr7Api+Hi8Wk5mW875paXmjwXNu/UNGO8g
 WcMCyioIhn11Mmj25rSCrra/W/K7tddspeBv3x02+CWFAVxsmmvtCG1A0Tfz+2mWyYKWtJMicb8
 QI2diPO/Ivim8J/8yfaNkGhY6VrR9VfpfCoiRasYy61aKO7ZQoyAgMMLtvTSdxZ5KrEy5Za7Gy1
 3nnUzpDzvs9IWT/BRvgo5CKHAlEta+bT3rSXez2TQkSpfzyfMxk54h8GOsZdYY4oYqC5wPTyxWn
 4W2xkTLU597C1pauM1MwC1WRcWyXcdb1Ui8WsX7zsQd11xzKm4k1d2NgQh+9xeMaK84oqkZLZ+k
 Z5/HzM3ZS81FPFCjTkG1YbwCbmlZuYBvMSmqA1tSrVXeLOGv9kfTilKwKvYx9rc0hiEjpeZdiiP
 GSaQrf+giEjdwugOrcuItP/4hDJxVB/zOqpAczlXm6+JfSrMUA0J1rvXxNedEN5j2Vg2yhdHFcG
 Iuh94f8K9gmgdxA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Kalle Valo <kvalo@kernel.org>
---

Depends on the patch in mmc tree.
---
 drivers/net/wireless/silabs/wfx/bus_sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/silabs/wfx/bus_sdio.c b/drivers/net/wireless/silabs/wfx/bus_sdio.c
index 909d5f346a01..f290eecde773 100644
--- a/drivers/net/wireless/silabs/wfx/bus_sdio.c
+++ b/drivers/net/wireless/silabs/wfx/bus_sdio.c
@@ -267,7 +267,6 @@ struct sdio_driver wfx_sdio_driver = {
 	.probe = wfx_sdio_probe,
 	.remove = wfx_sdio_remove,
 	.drv = {
-		.owner = THIS_MODULE,
 		.of_match_table = wfx_sdio_of_match,
 	}
 };

-- 
2.34.1


