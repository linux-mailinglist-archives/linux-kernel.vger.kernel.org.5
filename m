Return-Path: <linux-kernel+bounces-10753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A737A81DB4A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA13B20E85
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69DD199D7;
	Sun, 24 Dec 2023 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXUHames"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3C18EA8
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so30354785e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 07:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703432688; x=1704037488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDWXSVz2KCM79MpUKy9CV++h5zIlk2lSIe/fyWdkp3E=;
        b=eXUHamesL1A/d5w794XdZzORxWbmHKraSE6CmDNq/ofpwMLMT74NkXNA/2AJxkCzxT
         zZuZxTNMk9Cmmhu2SsfNSjiyp55LIFQdSmp/hqajhaV2i3eEac1n0cEdM3Og+8drgMBi
         +5loAGNtexCshlV01dinvydcIZKhlHDuAf+aWF+lPJDKADztYHwBlj03RXC/hj9Gm1h7
         QwUDWfjLO9JcolIp/OmM6gQmFEMLOsV3MAszErk89BFvo1KNt0156HDewtxK1LqIonsz
         nqHz+PrOixhBK2pOjBZHcGHg7VUQBB9riHQBc2SGq02M9mLvuJ8Kp6AWBYogib7sTtDH
         5ScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703432688; x=1704037488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDWXSVz2KCM79MpUKy9CV++h5zIlk2lSIe/fyWdkp3E=;
        b=BK1RQLSn1gOEL8aDBlbV9IMP5R4O/3+wbY9sjVN6VdPW2k+6rD1UrZC56cyzRNXVzj
         VkwvGTZvxkrRMINctrD0LShF0PxHauUHSKDy2FF5riOADhZBXLBP8d3fxP3b9AYZr83i
         3/Tw18hvqAcAgsfwcD4a/ZELtyfbdAVUC1r8HtilQDdia3cF0gXqxxpkyCwWZiA5ihfk
         Y05OWa+dTXkW9vYIRGwb81JgHPFhWpivsv4S8+Fte0iZ8ZNXt442AIdVaDY4h3dLOggR
         o0RE3hwoeT0oDC+qoXGfSxn4FxJG8hisKg0Q50xGLQhcGpcAbayXN4RMdPYiLc2UkOUy
         2LPg==
X-Gm-Message-State: AOJu0YwnU933mDOdczjVAa0mA4tT/GQxaiZEboad/5PcGrthmgBqqDPq
	feOVyidiqq38+fOQf46l+EECVfGYTeh3KQ==
X-Google-Smtp-Source: AGHT+IHe2nVWvkUtwXhZsmXI3rB+Z5hHEylqrUulG2W34bGPt954jQWKdciG6OGyzuyoq8uzX5d4Cw==
X-Received: by 2002:a05:600c:6010:b0:40d:4a22:2628 with SMTP id az16-20020a05600c601000b0040d4a222628mr2192791wmb.41.1703432687952;
        Sun, 24 Dec 2023 07:44:47 -0800 (PST)
Received: from [127.0.1.1] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id ge12-20020a170907908c00b00a26ac403032sm3325901ejb.65.2023.12.24.07.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 07:44:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 24 Dec 2023 16:44:13 +0100
Subject: [PATCH 14/15] media: s5p-mfc: drop useless static s5p_mfc_dev in
 s5p_mfc_pm.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231224-n-s5p-mfc-const-v1-14-a3b246470fe4@linaro.org>
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Aakarsh Jain <aakarsh.jain@samsung.com>, linux-fsd@tesla.coma, 
 linux-samsung-soc@vger.kernel.org, 
 Smitha T Murthy <smithatmurthy@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=900;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Fa0Mi6emzcHWlV3HqGPkNIGFTFGr3syiwm86et4G/MQ=;
 b=owEBfgKB/ZANAwAKAcE3ZuaGi4PXAcsmYgBliFHakB4/85S8Dq/xnyUAP9r3ll9Vk3PEZrgw3
 YLe2PK+BaSJAkQEAAEKAC4WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZYhR2hAca3J6a0BrZXJu
 ZWwub3JnAAoJEME3ZuaGi4PX5cMP/2n4Kw5KHfACgSOfmcfQArYZIb+skcaVjpV8F7FNt9M7ME4
 Y8yjpVUVDiWhhq91AfEMMkHVuotmu7QmSvd/O/vqyT/ViG1i5CkKKaNUEEsodVzeyJsnuKliwbM
 KOZV6ENgQhUMON6zfBQzzpnIWH15dfw7Ji3amRhzKokepHfd4AZQVzNwp6hZ0XM+pVCcfQWyr96
 2hrEP7utbe0DKa69xmVM1AgRK8n6npoDn6zT5YSPYCwLaqJGDa1xJRd9ZNJ8rDcm7dK468s87ZB
 t2c29BxhfPLlp3CbEJK+HGZ77fxpMMzbRYoNH429EcbkYr0xEf4YnCynXljt6/6+N5FooRiwThA
 ZN2WGMs/ZCCGs5FiTGDUPwmN3tXmnhM4uxiRK5YLl88QlRXfgh1kABh1HDRjUxr0t0buSl06ru+
 LHfhj3eUygC2p9fFeKrrkxblD7x3VxFamc6M0ycluZGDSlOqwjgjQlGt/7EEE8qgSkgfNNgFKwX
 2bCCvkq/+cG0ecWzegql68O52CRZK6lMcB0e4BFNSr2n0rutChRK/k3+leK1IGUJhRPWVW3G1nj
 090RINJD1iprvTJoDbcMsBoxyJFAdnj95c889/klSMpx91lR+2+Y9yPqp3OXCDsLRF9ZD2IwuVo
 R3dgcW7CoxXVJYJ9jQb8r7Wh0W/dpJe+4x4c8
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Pointer "struct s5p_mfc_dev" is stored in s5p_mfc_pm.c once and never
used again.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
index 29b141d4a7a7..ecb3065c33c9 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
@@ -15,15 +15,12 @@
 #include "s5p_mfc_pm.h"
 
 static struct s5p_mfc_pm *pm;
-static struct s5p_mfc_dev *p_dev;
 
 int s5p_mfc_init_pm(struct s5p_mfc_dev *dev)
 {
 	int i;
 
 	pm = &dev->pm;
-	p_dev = dev;
-
 	pm->num_clocks = dev->variant->num_clocks;
 	pm->clk_names = dev->variant->clk_names;
 	pm->device = &dev->plat_dev->dev;

-- 
2.34.1


