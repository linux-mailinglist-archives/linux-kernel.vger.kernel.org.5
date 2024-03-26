Return-Path: <linux-kernel+bounces-119901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F688CEC0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFAA1C61BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956921411D4;
	Tue, 26 Mar 2024 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwI4caBg"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECC41419B1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484676; cv=none; b=L+FVFovRyIGJ5vhPiC90ARGRserHGtns6JZ15WLhxUtSz1nnx6RaIYdsiEd9BUyyOk/VfnwHFc+E9cb3ZPHD+Mu/W0qTJYh9kbyD8Rm3obg5hTYe5tHPD4tgZdbKzQNZiX7+LuYf/ww4XaXWQ/pf/dM7TuEKRP45wQb8vWmDhD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484676; c=relaxed/simple;
	bh=Am9mgtoHcGnWtdCizLM/7gnev7AKEoFyTXCt0w8OihU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FKgbTOjLIz1nUj4BKsSC0yfxnGnCH8TJqzEOiLe8CUk17kH5X941uE6RplwvQUwh2MedDYD8cTkY/6fr/b/ezRJ0u7Cok6cN/LFtExK7jJxdfww5uOGHQEnoc0XYkNFugngRsy688Hk34Y4oKiSnmDt2t8NptWo7l8mFgyLbDHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwI4caBg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4644bde1d4so771291366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711484673; x=1712089473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPX/MFF6KoADKZHHbndNcATsgZ0auA5V8bT6Dm1+lpQ=;
        b=ZwI4caBgse+mqgC667cXqOhTVuVP5uEQejse4B6ejWSAelS6CNWgkq5jbsCXY6gklO
         kvd/vR+aUcRvhh8HSq85GthAFxn6L8QliPcuuvPJzl5TVz4AsdmLXiQcwtNas4AECKeG
         62RsjOJWgP9+nfbiwlgDDdh3gOb0IKNIdv1iC7/5wtHObtyaAcc1IGuRzTrT1pod04hu
         CwiTaErX0ojrgGWEgAUap1lfQZ6lwEhOKyYwpRRz4Q6P0RcBDuKa42MCA84GKUjyeWpR
         O1AGH2QrKtwW/AHwnfPBiRxSjpPBI2X12tiQ7O/YMTqaXvII0kmC4nx2Di8q2pZWilmD
         ID/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484673; x=1712089473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPX/MFF6KoADKZHHbndNcATsgZ0auA5V8bT6Dm1+lpQ=;
        b=ahMTcbtKJpbEor1UQXL7JpLmkT5CxPKdYVCnAPJqNTrympYp9CTMHp0DnEkJO9usUg
         Nq5XF4HvQPVCKK7CoOhveQ6K5xuQ0ZWSZL1UdJU+nwj/HhMSDpmK8WOgEnBdbQaI7qTG
         18FIf7S+hM6eyxctqZKpLmpluj67gz3qQS14bCFFdVkKdtb0wz/l6mxsVVTTNxRpBw2z
         8yfmJ61GADK1ZB4IeP3r96P2rsncqFoDruxjDXgab9hnJO8y/SamNFRvar764T67LKy7
         J2hR+tlYc4JqwAk78mWsAh4jjetvGJ6SwO9cq6Oi4y/uAVsmACyiQVnr/gP/qZLBGcmZ
         FMgw==
X-Gm-Message-State: AOJu0YwEyCP9ywxD3Pm+RW/rdh+TfX7tSDlVYkrojfXhlSzL3HdX/2Zx
	TJRmIt47URMP4mhyDZ5bvQ5BJNmg99Qyv851Qt3p1jQRdAcBb1X5qw3iQNU6Z+k=
X-Google-Smtp-Source: AGHT+IE5r/pwonCznGAPpl36QYFlcuHgl9B4GNv8DI8Hb4mkk/gPdMTw9O4OZrQ7z290iSGo3ctFmA==
X-Received: by 2002:a17:906:2c5b:b0:a47:5209:3781 with SMTP id f27-20020a1709062c5b00b00a4752093781mr484700ejh.55.1711484672833;
        Tue, 26 Mar 2024 13:24:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709062b4200b00a4725e4f53asm4584492ejg.40.2024.03.26.13.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:24:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 26 Mar 2024 21:23:46 +0100
Subject: [PATCH 16/19] dmaengine: pl330: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-module-owner-amba-v1-16-4517b091385b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=605;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Am9mgtoHcGnWtdCizLM/7gnev7AKEoFyTXCt0w8OihU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmAy7ZiLh5VPnk/RMDsZGr8iCFWx+7m0xqeCSmY
 z3/P04bZaaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgMu2QAKCRDBN2bmhouD
 1/r9D/9kvfKgDYg5nRKfG2JkKlSjbG1QwJvI9/ipoDbprS6mvTmLcoHaj1CviRt2lrY5IjFgSdP
 j61qJkOZk8Qbyt0xkrp8xZk9c/aVOr+a5y7S+7C55YHI1kuOZ5HvPTp2kaWlqrlbFzNLF+FagYG
 DvzvnjYjJAZH6gqGAN1mLP+M+7peyjv6bd7GqoTzz0QD3ca4oIGx1BsyWzV36RzCmDhwcL7eQG6
 kfTIPmG+yv+YUKWfOTBpQqnwXFtdPgIWZ+uOdw5xkCjIp9MSy39ixpzY6zvKzZree+jUeD/DmmF
 fm/XVF6ygl7GSDyxs0jtn/jWFoGxs9vtDtbZTwuHsr1+JYnNYVmetHZvXsytFRLkyEURM06N3cp
 7l7fHIdCfrb9l9uL1EoJvj3yAXS4y6iHKiFytXIiBNBmfGtkg4ksAw4q/30xAxvMtjm2RiZ3n0E
 9AaRRoDPmnvAhVG2AtIySJ5N37V/AiyVKR4l9Oa2Tqhqi1HEZmYU5WJuubfVte6YBbsAOg9WRMG
 Zyb6OY7oG7luImjoAjB1vYRNQ4WXFiD6W1alucifK0FpWURvpO+UTp9hTD1rKqet9sDkdcIsq+y
 q2B3AW0ewfLgxmbl6rqDCbDx5+dyTTUoacS+fe945Gv37sUmf2uFIecZt+HNxwGdobYHzS8Nz1Z
 4APs574QJUP7Oyw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Amba bus core already sets owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on first amba patch.
---
 drivers/dma/pl330.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 5f6d7f1e095f..b37ef28bb417 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -3265,7 +3265,6 @@ MODULE_DEVICE_TABLE(amba, pl330_ids);
 
 static struct amba_driver pl330_driver = {
 	.drv = {
-		.owner = THIS_MODULE,
 		.name = "dma-pl330",
 		.pm = &pl330_pm,
 	},

-- 
2.34.1


