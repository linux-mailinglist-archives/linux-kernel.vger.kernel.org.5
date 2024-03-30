Return-Path: <linux-kernel+bounces-125888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B39A892D72
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A672833E2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E3B4AEDA;
	Sat, 30 Mar 2024 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuK11uYg"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC4833062
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833042; cv=none; b=eWzUgg8AsrOmii/PnsDx5QTK9phkSNbznWaLlXUL9148Rbu+JUEMhgY353KpmV8hwbgYmApakDCSLwKgWPZPLuwuYmsNReJFGqwaKirVisiIyo5s2uFi+HSggrO3M50bsupT2LXVIcBJVGZXqtXlRaGZ+WdQNji9Sx1zVgGMKnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833042; c=relaxed/simple;
	bh=/4yQxoR3DV9yvkLWH5V8H39qrAkzGcPAl4uH956qFcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NaOAmtAu3ncdR9vZrxQkQhjyS2IsAXFUaJeob4num+FnfSS/TkWvYsKtYraDpv/O6N5KK75BCyxdrDviFCvT4v8dWbKcq6KgRqcMYxutFb4/qXYGDQX9E+UCTpp9xkrfiT/RyVR8JTIoPEd2wkyAi+IO8Z21gkVZb9DtQwZZ4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EuK11uYg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-415573263bfso5354515e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711833039; x=1712437839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=61v4scjVgIk2ToFnkXS2oeqx/czO/u3CzUzarujt/iQ=;
        b=EuK11uYg2xMVqXhNGntIbfC9q8LcHUe1FkvyowcuCkBRpYY9fizfrZBPmOHpwpq6JT
         youB6G1Azf4HbWTz6qs/jCr2ERT0dGTfcjq80tgPXt4ZTuRLE0HSLZcYvxkw4pFbpH+F
         iNYEKUhOJIwT5kT4W35vWMn3mSoU2i2su++VHxpjWsyAI2XnbTpvHq0pmtqDMhPQULRE
         IJ725Iok2kpIZ0uRzAs9McDhgnpdO2Aez7eUpsjzdt0KJMVtqhg+7ja47tc9DMd5SmWb
         EtMoEXRCOIUN3KIxGwiokW3Tpyr7yEngB0k/ebCRXAhHzZm7KE8Rh7lD4GAZcEnsHuh8
         PDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711833039; x=1712437839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61v4scjVgIk2ToFnkXS2oeqx/czO/u3CzUzarujt/iQ=;
        b=bA0s8o8fI8ASohhiuOMWSSBOXUkqtWzP0uS89oJok2Un7qhX0P/F0iwWFYKSzrN3J2
         Ie5yny0vAJIoAMV4tWTR1FPTLo7fQ3d72NvdNHbX1kDnnbrWYoMlUAQBCPaLdmHwo+rF
         z1wu3IBMLV68+oFUC4ByereB3szDb2xDV9701P7m8cnHY14EOIlnZ7/rmvyHWHRi11MS
         lbbmyAS2BPS59RGbeET8S2/+vLMFafRLAIplLdd7WgoGt3jMOEm620MzBNm6IZeldgDK
         phKt9/eUGoGd+pKq2g3hjbZ9lmoriPpSqJ6yvDWbpWpEeRYNggPzhXyDZVwbpwv10oPY
         +7+A==
X-Forwarded-Encrypted: i=1; AJvYcCVpoBHzsTzGsnrxiMtAl7ATZQzT7Ei2J3lzDbuYnmY6QWSpXygOk+qeWTcg6M2BhSWlbYCvynOmm4uSw510ezNW61RU4j8DhoYvtD5w
X-Gm-Message-State: AOJu0YxC9hltUka7//zGVChSA/bPVe82QPAR/76GZo13XdJP2MbzkUIo
	XLl6zWIC/dbpHM1Mkx6XfqwooGz/mh7OW6jrmojn20huwbgHCEEr8pkNtV2wzGI=
X-Google-Smtp-Source: AGHT+IGvC5puYahyLfoRxaBZa5kEc2+uWb+/xISXFXurHNo+cizr9pJb/P/tTe/zgahZkVnF1kYg5g==
X-Received: by 2002:a05:600c:4e8b:b0:414:f60:5d6a with SMTP id f11-20020a05600c4e8b00b004140f605d6amr4142782wmq.0.1711833039552;
        Sat, 30 Mar 2024 14:10:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05600c1e0800b0041559c59ee3sm2758210wmb.12.2024.03.30.14.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 14:10:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] pmdomain: mediatek: scpsys: drop driver owner assignment
Date: Sat, 30 Mar 2024 22:10:36 +0100
Message-Id: <20240330211036.100956-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index 59a7a8c261ed..1a80c1537a43 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -1138,7 +1138,6 @@ static struct platform_driver scpsys_drv = {
 	.driver = {
 		.name = "mtk-scpsys",
 		.suppress_bind_attrs = true,
-		.owner = THIS_MODULE,
 		.of_match_table = of_scpsys_match_tbl,
 	},
 };
-- 
2.34.1


