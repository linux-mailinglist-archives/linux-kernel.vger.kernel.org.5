Return-Path: <linux-kernel+bounces-34265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19D98376BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FE32897A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053D73716C;
	Mon, 22 Jan 2024 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+rueY/u"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3B20B31
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964251; cv=none; b=RdCysxGF0A7AGMei7SCAwJqdLLlTBZAOIlglPwr41KT+iiB8EyERM450I9ohiHLJUeMGYr5nsZcKiUJGLZNxfIoOsruKPWAl+OLO6GgomjVAPy2B+/wkFFm/9j8xZ55fC9bSUuu/RsTqEC7pE1FNyrBIkxneOLNt5Hyrt/eudg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964251; c=relaxed/simple;
	bh=ADcQXaAoCN3feVEUxUAN7RPLnjxcu0Da4xFhPbbzd5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IavL4oTFKI005d/MIG474m7SuhcS5fYVQ+Mgoyqgl81VwyZyUKcy4asdOKq2wa2v3zrBzcT9e2XBnPtEaT2HnLZ6cFc08gAsUNWBBFkhvJJgNx+FmMgBhwZCu9Hupe+rxyugVoWwQPvzRLbNeVdED0WfsLrVPR+pkyMWFjSULac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U+rueY/u; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e80046246so22043975e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705964247; x=1706569047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBly9XkHZ0SVFvJINs6dkm8lumCZ4YgOwJi4aC1YyJM=;
        b=U+rueY/ums3yLa+tPEPHkPAH413XgjgrkNiM90wko/POsOVn897uZzu6UmuieY6ZNH
         moSQzOKLGVx8RFDIj9qzOvIU/GhNCPuhG9ZK6QJd8/SZn6rGl5Nj2/ciyDCZFdcO7e7C
         GHtCWLm66ybuQKe9Cpn/L0NaKRM6q8eWQhJsLR3a52i5Ppm7HzklHHM9sEGPAr42pamZ
         DCSWKBfVT+OGseYwtMR3mh1GYRl+tWUJs2tEIPeX85z3/RUDY/VzeTh/td3LW2tHH1tY
         bw8yTpAhQAOn9KedVyX1fWVYvP+8MR9Fhw6GN0TzJUGAZIzqatAHVK3aNI1XAPZTzjbc
         Zaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705964247; x=1706569047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBly9XkHZ0SVFvJINs6dkm8lumCZ4YgOwJi4aC1YyJM=;
        b=o6xoUOioV486m+UcBzhKhjLgYfXgTEqH6i49yjJKXyOyHxwXjx24zt5pAHdIKZr/PQ
         Aekgs6dFrixsCk5KzntZMbfhhqRCe9YiK/vye0AXRprHNiHyta6ieLL2wyqQg22MlMJr
         iBv4781LTQj/2dsTrz1RwuBQDJ84/7gG0P0o0ekVClGR+sMElbLWKle0ClLjRNt4nN3J
         GVaP2/f7vnyCSTv9hfopHo4SPly48Q4Yf3RzokeRuwaHCqTUl1TfmfKGZYTpyxCDhxD4
         UqdDD9qkmrPnEIXxbAWrJjLQhxa4pcb67+56fzlVGy0/OW970z2LprWyY2h4WBmg4Yp4
         lUXQ==
X-Gm-Message-State: AOJu0YxMinoFjP9yVscAmghWFiYv2PSPa61F/AkKXK4Th0v0mQLl2t7W
	lhlFkg3xryCDSGv+tufsnY+Z4XLe6MdiNXlkSo0uSOmu8rezgQXNv9Ox+fBB//A=
X-Google-Smtp-Source: AGHT+IGsC8TYulGe/aeYf5Jm4N+xn/nAtZGRWcp3Eljm49ls5iykYPcGcShpWbH/uU3Qy1q7Jmq4Bw==
X-Received: by 2002:a05:600c:45cc:b0:40e:a565:3ce2 with SMTP id s12-20020a05600c45cc00b0040ea5653ce2mr2204825wmo.73.1705964247305;
        Mon, 22 Jan 2024 14:57:27 -0800 (PST)
Received: from gpeter-l.lan (host-92-18-76-30.as13285.net. [92.18.76.30])
        by smtp.gmail.com with ESMTPSA id fa26-20020a05600c519a00b0040e89ff10f5sm19776847wmb.1.2024.01.22.14.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:57:26 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: arnd@arndb.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	jaewon02.kim@samsung.com,
	chanho61.park@samsung.com,
	semen.protsenko@linaro.org
Cc: kernel-team@android.com,
	peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	linux-fsd@tesla.com,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/9] dt-bindings: watchdog: samsung-wdt: deprecate samsung,syscon-phandle
Date: Mon, 22 Jan 2024 22:57:02 +0000
Message-ID: <20240122225710.1952066-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240122225710.1952066-1-peter.griffin@linaro.org>
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The watchdog driver no longer requires a phandle to obtain a regmap
to the PMU registers. So mark this as deprecated.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../devicetree/bindings/watchdog/samsung-wdt.yaml | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index 77a5ddd0426e..3970d6bf8576 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -56,6 +56,7 @@ properties:
     description:
       Phandle to the PMU system controller node (in case of Exynos5250,
       Exynos5420, Exynos7, Exynos850 and gs101).
+    deprecated: true
 
 required:
   - compatible
@@ -66,20 +67,6 @@ required:
 
 allOf:
   - $ref: watchdog.yaml#
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - google,gs101-wdt
-              - samsung,exynos5250-wdt
-              - samsung,exynos5420-wdt
-              - samsung,exynos7-wdt
-              - samsung,exynos850-wdt
-              - samsung,exynosautov9-wdt
-    then:
-      required:
-        - samsung,syscon-phandle
   - if:
       properties:
         compatible:
-- 
2.43.0.429.g432eaa2c6b-goog


