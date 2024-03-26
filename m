Return-Path: <linux-kernel+bounces-119904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4F188CED8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0C71F88638
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CEE142E87;
	Tue, 26 Mar 2024 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUg/Yu/e"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE91422D7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484682; cv=none; b=lFk3bySEf+5KZJpJnWiDAdQoCg+sFHqptxYuFKVZnnSDuOFv00d8blck0iyjnSbZ51YhQCkRoZGsNtXJrOvJQy0M+e5G8uhkQnpTr/Eh7umZMrWExMeNNTOxk/sUACzjUl5rnXxzaqw8T7gTKxPhD2h9ucXezz6GyFD1sNjB63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484682; c=relaxed/simple;
	bh=INljxUCSw+yVREcFpthVyGE5rYMeWITztmBOHKglJhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D71IVXZNR+uARdfUlP6yo+bjA+F1GY3LIhuFA59Ca22S5aGmuMu8+vVUZoId9pXvWoNm7hrA8xwDrZFLYn2s2EVPpES9QIr1pX+qPFu31M4uY2j2DdnfJ0D+IQgEfX/gn+Mzf82ieHyOgpzyQRFZGSbBSpjrYkb2zQfVr8MBMX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fUg/Yu/e; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4dfb8bc3a6so83763566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711484676; x=1712089476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwMQZ0nF23w//xAHnzD/oAWHiNTRM8AzxRIOUkQer54=;
        b=fUg/Yu/eHH3I/7oGLkKhtbosR7eWZgBsatSPu9bILcOnTEM5HCt9LjYO5nc+/LP+qh
         3bIwYqF+aiCr7VZ3/aMBbL9yUYjyC2NfSKb9FhBO/Iu3MO1DALMjZ4MN7RU6KJkjCKFH
         vtfluSTOB+Dcqo8zzUFV6fSu6UWULLgDgMfP+SUDrC8FsTkRizIB0VHjxaoYaF0DJGsu
         EDqIRFvVeoU2Fr7u0BVmsMHoXDwNu5BO8DQSr7t9/Msqk5bGGz2ArAQg6C0Qk5e8Z6z3
         BDg9TmYKoRpKG8sFnjPrTrmTcWPVN0x1CBdKo9RnOnlWCXplL47Mo0hz2R4PoLBM/U4r
         U5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484676; x=1712089476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwMQZ0nF23w//xAHnzD/oAWHiNTRM8AzxRIOUkQer54=;
        b=peAI73w+NLtl4MWaX1i2qC/OHY7mHNwFWZzumBJX6bhmNR6IFKrhVFIuaKFZIYuL/v
         8Jc1fDwKIm9RntxLLcNB7t2kcvY8FIeqx1teVh4DH3fH0kpKQYS/OdjsqZx7ll92i+yw
         q5yWERs43UYJR40LYlaTmn50iGCDHQOw+tzdPd1HXblcekdymvVhPxCavXCGU0rAFK2v
         bR7cZSc7EvyimaZmnCW5XHMMXslJxIuxqfWiTsQDsypiG36BVnCQ3bWiJxv3ysOxQD7K
         NqTSxJMPbHyJGW7hDwztnXRNE538UAwIZY/N8K38Uq+w8LT7eNTlj6ID1jG9aOjqyjwA
         4wfA==
X-Gm-Message-State: AOJu0Yxp7+e7avU4YZZh0rlupu0JPQ09kOLgMIT+Gt0YLjT69/anDF2E
	SgHYMTloWcNHmCfXS3CH1ATxQoBFLh+R05iVAe3dVlEFdrPq0qagyV/kXImq97I=
X-Google-Smtp-Source: AGHT+IFS7eYAhT+0AUpcj5ewpNo7OFKsTCoZ3JxCFeHwDILA0YZF9b4V+IaNGjXTAqigOEH5hMb4FA==
X-Received: by 2002:a17:907:a42:b0:a47:7795:db82 with SMTP id be2-20020a1709070a4200b00a477795db82mr7398894ejc.34.1711484676683;
        Tue, 26 Mar 2024 13:24:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709062b4200b00a4725e4f53asm4584492ejg.40.2024.03.26.13.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:24:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 26 Mar 2024 21:23:48 +0100
Subject: [PATCH 18/19] memory: pl353-smc: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-module-owner-amba-v1-18-4517b091385b@linaro.org>
References: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org>
In-Reply-To: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org>
To: Russell King <linux@armlinux.org.uk>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vkoul@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-i2c@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-input@vger.kernel.org, kvm@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=711;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=INljxUCSw+yVREcFpthVyGE5rYMeWITztmBOHKglJhs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmAy7bfvePYsjxBuLD9vY3zAenH82u7tT/SAlQL
 Z3EnQYXLHCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgMu2wAKCRDBN2bmhouD
 11byD/wPpXiOrbOF/vSfkJBrTVrF0LZH7r75M7Vz/+aPxzvKY8FKsSOw2SmV92MkLf4QuOdFOdd
 IMhZX1fpOObZ/FD21xlOjv+QFmb7DExusNcalkxdRxZKYEpCCvzYR0byulPTkfd/PDoCr4R5RF3
 bWRSvd16bNGp3ourlRN+o1Cki1isMO2ab6YQUCXal2ZYM3uWqp8uFBEAtGq0i4KErceJYGTDk0K
 yU+bGCWdUCDmVBIXQktl1gdxTJJeIshTNLGc0VbYhdQ5/144yeDXYpj9JxZj+kEd0MhBSgeyL+y
 qnx8vkit6hx7qw7DwYQbpqqsjvf89L401ck2ZHokDx5WQF/O6gUuXqJj1lkj95RKuAUY9iMAgEK
 wpayvepNRgr3xnMEhn8g8/BQllMQBHmg04Men8h09jhg5TSmEJzO6lkQpzd4wAIpwYWe4pGd22q
 QUnRxrhNWRj/GsSaPG5T8QJsROjVv+a/6Qt+0+KRsJCWt/uMricJD+r6L/VL2THandxryixg5yg
 qRL2e3R3i8BvYEj+k76Goc5dxAzDMCylHnG0Ksya2oTV74WPS8ZCSvY1wLAhBD/F0pL6M0MRWTg
 hAo/aTuE/uXOEvWCV88JCz9nnTmGnOYhJmVG2P0xSnLg2K7iNg0jYh1qiVA2Scb5rSklBBc3z7Q
 6WZIljKIBnSxNMg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Amba bus core already sets owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

As memory controllers maintainer: this has my Ack. :)

Depends on first amba patch.
---
 drivers/memory/pl353-smc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
index 48540817e046..56e51737c81f 100644
--- a/drivers/memory/pl353-smc.c
+++ b/drivers/memory/pl353-smc.c
@@ -154,7 +154,6 @@ MODULE_DEVICE_TABLE(amba, pl353_ids);
 
 static struct amba_driver pl353_smc_driver = {
 	.drv = {
-		.owner = THIS_MODULE,
 		.name = "pl353-smc",
 		.pm = &pl353_smc_dev_pm_ops,
 	},

-- 
2.34.1


