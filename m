Return-Path: <linux-kernel+bounces-9926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9018081CD51
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D621C2266B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF6928DAE;
	Fri, 22 Dec 2023 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4vglsCI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D324B4F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d4dcc838eso445325e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703264082; x=1703868882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQK2VmtCHYl6yYZDh5S9BZ2JwRKpJFyjaq6UtHRGJsk=;
        b=T4vglsCIaAvQRh2yHcdaByv7aSOUPj0md4uP+JWWW5Qh5kUZ0jC2eUM90EmaSZxNGD
         hFPR0mRNbIBG2CBdcZ1v1Lc2lWf8V+uvVbc6qG3Mkg5WaCaaeAiVbcn3KrZ+NsJ/9Sgn
         TzHZ9rmL3Leub3Ja1gR3QQ3QXOk+BsIpYe0/UsG3fZQOBEpHk+vKdN+fZxStrta/E3VH
         sHQja6CfvmQMLdQztv2ojqNPatBdFu+uaMrRAfxvINdc75WeoWBse5nnS+/48ccWgjji
         mNX9v3G9+jQNggEqnvfWSbTvmFYtWKfBg0dvgpKnbnME3R6q/behd6NjERbfqRmxnN9q
         2GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703264082; x=1703868882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQK2VmtCHYl6yYZDh5S9BZ2JwRKpJFyjaq6UtHRGJsk=;
        b=agc29NkJNUQW2HxV1/PK5DgjWC0a8PBFt9L+ZTpxeJnf0cAg0A1FSbYSPHfecY3fBN
         cfuVXNOvZuYU6jFvz93FFLaEFZVA1EymGY6woLKnU5c9AKGYUd0cZS5lSAH3ARsMa9cA
         RQ8kFI/d6NwRXez259PYrrLSgRo8M5rtF48dhAnzWXcUMtCYKu15/Hn2KsJljhqiNuxa
         kA6aIOmsTGph+8HyQil/b0XbNCUJVJpJ2C1AZVI1JO4F2U3KmPUiUVM4cZBjFdjRKEYl
         e7Q6NH5tE59Aoox2I3BoluKaQaQcHqI6dMSiNwenw+Bws9EDD0qvbOJe7+UYJoFvPsQE
         JgFg==
X-Gm-Message-State: AOJu0Yxw1KKAM1mAT8tZ12fmVPtPQWtAruqk13gimMMNc7P0cVTiyxMN
	G8xsr+5VtWOJ86ZUBGjnh9eraw045rnrew==
X-Google-Smtp-Source: AGHT+IFGi3TkdV0/ZkWoMA0Zj2LD/mEXVScaCaz/LMNhdFpRM0fz7SwOa9CY7MhveuIg3OuXknU8lA==
X-Received: by 2002:a05:600c:34d6:b0:40d:43ea:e56b with SMTP id d22-20020a05600c34d600b0040d43eae56bmr853910wmq.22.1703264082711;
        Fri, 22 Dec 2023 08:54:42 -0800 (PST)
Received: from gpeter-l.lan (host-78-151-55-40.as13285.net. [78.151.55.40])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b0040d378510adsm10138520wmq.1.2023.12.22.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 08:54:41 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	semen.protsenko@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com
Subject: [PATCH 1/3] dt-bindings: timer: exynos4210-mct: Add google,gs101-mct compatible
Date: Fri, 22 Dec 2023 16:53:53 +0000
Message-ID: <20231222165355.1462740-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231222165355.1462740-1-peter.griffin@linaro.org>
References: <20231222165355.1462740-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dedicated google,gs101-mct compatible to the dt-schema for
representing mct timer of the Google Tensor gs101 SoC.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../devicetree/bindings/timer/samsung,exynos4210-mct.yaml       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 829bd2227f7c..774b7992a0ca 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - axis,artpec8-mct
+              - google,gs101-mct
               - samsung,exynos3250-mct
               - samsung,exynos5250-mct
               - samsung,exynos5260-mct
@@ -127,6 +128,7 @@ allOf:
           contains:
             enum:
               - axis,artpec8-mct
+              - google,gs101-mct
               - samsung,exynos5260-mct
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct
-- 
2.43.0.472.g3155946c3a-goog


