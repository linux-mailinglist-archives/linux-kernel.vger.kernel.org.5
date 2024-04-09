Return-Path: <linux-kernel+bounces-137618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D6F89E4A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDA3282C35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475D615885A;
	Tue,  9 Apr 2024 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k/xVzeX1"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF36370
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695581; cv=none; b=IBSeI5ckbtlD26BgHw9fPFYtdt/zI1g7hj0vC9TQr7ceI5UBJ1lKeIyGYiYpsA4lq+dM0JsSc7HtWhY9Qo2RjcWvmNtxjF/idkKD/iO4UNcHbECgM/jPWJZcsg6DY87VlVS105TtZFs0bB9DyHbz+fPzOTjiqAFd/7fT/TxYbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695581; c=relaxed/simple;
	bh=qN/mBxNt7g9rxa83v8IAquoYvQSJnRdAChcabeHZe+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JsOFR21l6vwgDyOdp55XUe4z94YKHLhbuGHHUlvuhK2DjCAFnYfxrc+s0gC8b9hmd43ZoRxOGV4at+1NroZfHFLF7/6buZ9u0RN4OQfOVIO/SnhdNEcQ7RwLysIUxHf7QCrzjfF/tbIFkUyAvIVgoYdaJFlWYeA4In/qRmtMGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k/xVzeX1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4163de295f9so19091085e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712695578; x=1713300378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i43Qoe3uynySrUsRFuf2GYuYz97ru+fsThJj/fZfzpk=;
        b=k/xVzeX1gfwiaAjwJ6TfxTWfFkS7LslFu62VARB/K7fUzKKKfJ2ZNePfCGFM9zsuSi
         K8tttYBpqVaeOt32KSsCIDw0cr1x+4SzQ4CIOKE7YydjGTv0eTOWYAznuhej9eazcedT
         xZ+SLWPGMbYUn43xjwbyLp5hBfLvQA3TaRpqW+8LIjuKpa8SLmaAVD1R6zXQsj+C3J9n
         OrM4ypweOWJ2imwuWN1U7VHCFbAoryd9h1ytJb423NItmlDIkSZNHjj0zDWnPk4lcEsN
         mj1PXprlnR5xeP/WB9Wqu8jeXdUILJiV7ZxPRrZyhrP1ZMxFOLuca8xCAMMJYkR9eBnD
         0fDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712695578; x=1713300378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i43Qoe3uynySrUsRFuf2GYuYz97ru+fsThJj/fZfzpk=;
        b=suu9mhmM0IY06C+mBXEro8G/v7Zq+BzKXlz97EH5BEfCwjBSn8HYRY/apC4m0SK13P
         AdRzOIdqevg8CQjHwetJEMf3AqppeLmnJ45NeJa/Q6JKPcAtlHeH36Kp7nRIXY7wGK4k
         tuqvfpvN1ZxeoaSHG2JphrUxYP/xsTAPiJpy/WohpASTM0wY4M3DsOImyq/oSKedq7x7
         7wwFXIdwqLAe5S3nTiXkMp9rWNPQ7v9i/2vTv69hORjO3RSgC52x9wM1CesaIU7Xwba4
         ITs9kdZkAZdDDgJWZVf7AB6jqHUkdvM155s2exEaJC94ecoJCDxRhXMEfVGIR3bcq6QD
         Q8hw==
X-Forwarded-Encrypted: i=1; AJvYcCV8jJRymixKiFfeK9t/b1jMFWB5AJdudWc3O3k4jPteEIieeH2M4LwJ8Ju6Ad27EMjwJvHMt3qVrAIMoqat7vZVjQDVYQz2vne2Inis
X-Gm-Message-State: AOJu0YxIjN8U1DfkspejXnYPqKCaRYHpvVgi/FI9CAkFmMlqitzo/5hp
	5YwxOmLA35+UxViXMCZYUAwLJK2rwTBbh9GQWcf+Tc0NZQJR3SvYaEEmR/oiYoo=
X-Google-Smtp-Source: AGHT+IEVjpkHhTrvTCwgAGLWn5pfP5EWuqX0zQ5BVYZj6xofDz5oktA9j+XSpVN8O/GHhTwaZy3q+Q==
X-Received: by 2002:a05:600c:1c8d:b0:414:8e7:cd60 with SMTP id k13-20020a05600c1c8d00b0041408e7cd60mr507040wms.8.1712695578080;
        Tue, 09 Apr 2024 13:46:18 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b004163ee3922csm43467wms.38.2024.04.09.13.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 13:46:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yong Wu <yong.wu@mediatek.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] memory: mtk-smi: fix module autoloading
Date: Tue,  9 Apr 2024 22:46:15 +0200
Message-Id: <20240409204615.83928-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/mtk-smi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 572c7fbdcfd3..fbe52ecc0eca 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -450,6 +450,7 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{.compatible = "mediatek,mt8195-smi-larb", .data = &mtk_smi_larb_mt8195},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_smi_larb_of_ids);
 
 static int mtk_smi_larb_sleep_ctrl_enable(struct mtk_smi_larb *larb)
 {
@@ -735,6 +736,7 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{.compatible = "mediatek,mt8365-smi-common", .data = &mtk_smi_common_mt8365},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_smi_common_of_ids);
 
 static int mtk_smi_common_probe(struct platform_device *pdev)
 {
-- 
2.34.1


