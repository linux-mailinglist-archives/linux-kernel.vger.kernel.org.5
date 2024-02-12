Return-Path: <linux-kernel+bounces-62200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22137851CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB63B2657D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A945018;
	Mon, 12 Feb 2024 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mxt0im9n"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A55B44C8B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763093; cv=none; b=hLLIHTppSPHH041yr0NcEbYtk9Ei0UKSi47nj4A4Xu1dFHYd53mDUkUNUL8BHKyaLK6vvzOMRD6KsmyODcpeWRVc4jpnxksH02vOJNG7s6Giss5mekbdJkD6H2KpBNs24L/kTc+Yiib2yLWnVGvKa919LoPkecqY8jHxrHdyBh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763093; c=relaxed/simple;
	bh=DXZJ8SdU6CyY1sR3YPxqZTR4REG8xqBS+RKXIMzNoAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dt7Y/3W1wXlQOw1aJXrvkTt4xuGQGQ7pqqmKlgE4rWFCs/njCKR3PU9UnAlcQCbDAFUFVI3v1ZZwfcMuui5QICgPrD6P+vcUj/lWziCTG1Gxg6NCWbEc0F1ia+hWGzaZGXxoqHWc2Reb9+Rz86lrmfAcGNhOaMqSKbKS+2WMfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mxt0im9n; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-410cb93185dso10643245e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707763090; x=1708367890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yfY1ZB/UR7wkcYg1UUPlepgpCujw5oq7QYtIrjgAB+Y=;
        b=Mxt0im9nvt59lD83BBYUrPtR36Q2bs+p17osVcrPpCmnIORUA4s8KXzG5ZR53us5JI
         4jJwoaJEzjSmK1ryidsMLO8nqLRbkGXk+lNXdBFHoyz7Uiaco/iPG+9Ykm4erZJLqqnl
         vGisHThGT0rNv385g2SLKiY1b4NsZvjYhx9yDPWPuPf+w5FBjqOKPM7Et3ltsXcdpcbt
         YkdsZNuRLDf2tYw6qUw6Wp4q4f250kosQfXn6oc9tP9mtF4qxsg3Tk8VoZczI8q3lu/y
         qWb7BgGDrjOohkD9N+Ubujs7eYLf2YVlbuL93gDCkEXLWEN2gMtiJUQnLgPZ5MlGY+rx
         iGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763090; x=1708367890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfY1ZB/UR7wkcYg1UUPlepgpCujw5oq7QYtIrjgAB+Y=;
        b=hgtsgagJfgs9mPclzhhW+WHghjkqhGJW/748Tt0UJcnodSJgYd1Tj9xKuPEaILAeHd
         QA/T8vs8eSoxr3ss35RzIPan3SXzSZdvzs4x3xsDh14iiQJHI6w6YWZfhGps6h4a0+Eu
         Oxko9LPXQR2XEwzMm56r2L9Waey/I651dYx21k8WdFURaqP4LstgQukUzypPbilp1bca
         GPtmf8UpUwibESQn2jl/xSOQXOS/80lKPXaVAejTkmhif3h5+2sfbqZf1R7ngvgMONC0
         VTqCoiVhaDzjMVTAImVZcj7FlNLCJ3r7zQ4MS/PRhfK5hqZFy1geyJmkUwh3kRgzI8jo
         d3yA==
X-Gm-Message-State: AOJu0YySupE+aeQv7tzpPH/OAx4FZHRurb8ULJbBpXFgPS7zbOEMwGx8
	/xroTbxkdQpqFzhS6QnGd+di2amYx1cUzF9WuMrVAiz1gHKQI/+eSfBxOtJSGZo=
X-Google-Smtp-Source: AGHT+IF/hwYTN5gLQ3qKoL/DyWJ6yvMswElKu2UQ/C7ATTeBnESdqrjORtlS1g8/T6sopeOxxWDqTA==
X-Received: by 2002:adf:e6c9:0:b0:33b:26be:c5c4 with SMTP id y9-20020adfe6c9000000b0033b26bec5c4mr5070145wrm.58.1707763089714;
        Mon, 12 Feb 2024 10:38:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7FwCqc3uSItW9zR6KcTc+WJpnm2J7Ag+uFwzHbEezPbTiJaygZkxJx+XyzmpzoumVzh/kUWE9s+ujy3btOIRxOBbWcTsl3baVUVjAW+kBNP58Zgh5iyJBuq+OYyr1hm9XfVfZcJOXrn125Gd7Wu5NwnW8n8C8E4+zzpr1eMqYM4HKfr68ddz6O7DChsNT/g9geQCsrKcdzrUsUUk/3XyneUs7a6yOEPxmejAY5avb12SGkt1FXm3xZBJYLvGGSwWg6G6qSeDOZcEJNxZQyNsOnn2bsSvA1UN5G8/lDQQVCzTIqc4iuHTt3iLmYk4EAcjWyfeum7hjE4CIlKxEJstNCZTNs9hGnBGy1NlfwYdRL0m75u2j9Z4+fCAwqgGhxoMD3OPza07sIlgT5Obg1+sIsGIa8O5TSLURBB9AtFC7qdQEZTTCnQM7l81GDdg3J6kDDFvh0stEkP7uxYICEW5K
Received: from krzk-bin.. ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id v8-20020a5d43c8000000b0033b512b2031sm7447163wrr.114.2024.02.12.10.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:38:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: qcom,sm8250: Allow up to 8 codec DAIs
Date: Mon, 12 Feb 2024 19:38:00 +0100
Message-Id: <20240212183800.243017-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sound card on Qualcomm X1E80100 CRD board has eight DAIs in one DAI
link (for WSA speakers).  Boards with older SoCs could technically have
similar setup, even if it was not observed on mainlined devices.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

DTS with X1E80100 sound card using this:
https://lore.kernel.org/linux-devicetree/20240212172335.124845-5-krzysztof.kozlowski@linaro.org/T/#u
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 6f419747273e..2ab6871e89e5 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -107,7 +107,7 @@ patternProperties:
         properties:
           sound-dai:
             minItems: 1
-            maxItems: 4
+            maxItems: 8
 
     required:
       - link-name
-- 
2.34.1


