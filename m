Return-Path: <linux-kernel+bounces-97621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD4876CAF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EFA282DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7B0604A7;
	Fri,  8 Mar 2024 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Og1sRUtb"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F535FDA6
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935715; cv=none; b=US8tIF0HjFu41LWA4YoMdQudeRs1xX3VbP4QXl+OUBituE11kJ8AGMswk4+pcdcgaxLp2KrV3f6ZU0lekTuGDeP9BfIBwkLwLezoEknhvDmC2WCQ05VqMqxL0p5J3ac4gSgNArBWSDV/xjGemfWAUt84zmqYOMoPrDb5sBlaPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935715; c=relaxed/simple;
	bh=Xh62d3byksWPc2df0T3ZNqEz0dwEInqwU4U7UsjCTrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+lrrbmhqdxjyIblVbfcfQjyEuB02DKGFOWGYg2zaLKSmIwTEICB36Wp0+tLnlSFQ1JNxuzrNn64Tn85G9Ke7dCV7emk1MzcCMQ9XE56yYYGGmEslu6fGZPPhVifCXkhOHJFc+z709xvcYfgZXMYpTCVGAcLPRX3DvYx/NkFOFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Og1sRUtb; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51344bebe2fso1441916e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 14:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709935712; x=1710540512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKdWQKffvL9ogBoto8xjFAnEMcASLQo+XFvTjrJ0feA=;
        b=Og1sRUtbqubEZMXJp0BA6xL7W+/pe4RBYBu3vuk2Zrcv300k6NSN0oPGxsLE9YIzfZ
         +K8xAr4VHIFZS80N1kmZnt1K+o1GV/c8SoFqHHzFzkNOSST4uX8olyga2zyfWHFUJx2E
         iZE91OLI/ItavcdJQP2hMOScESYVEGtWudAxc5HQzyaiaD0rJpupmDiJzXiYz0pagU0W
         Zf95QCSDIVAT/+WoUksIt51TRa1pn3ahek3saR1AQWTz8KbMyunnGiiEeXHLXbSxNypc
         q5G1loVYbmc2hV+HLB0fr9W5aeFom2Zi6jz50yyFA4u+x9nUpUuc2/0GM9dTZl9pLF/T
         s7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709935712; x=1710540512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKdWQKffvL9ogBoto8xjFAnEMcASLQo+XFvTjrJ0feA=;
        b=qGKzhku8COuOdP0Cu3FxNjV1W6DykH52/GciQpana7KUR5zNz8j9Y2gSz5SVd+6Sbz
         Hy6b64C7muLWQkiVSOSXh9vHMENSLcyTndDJ2zBlCct+gTGi+wZ+Hs7PPj8lgJC7WG+m
         oXD8Y1POG91h8tu+S06YB5szMs3znv7/DOjQRL9g6TvI7MgaAJeVxEbBluCvYPKsutBM
         pVgYFCaScpUMwjAkzlpTr6oFvfIB30hhDmqKXF9oV92dItk2h2kbbTlYIf5cmyWgbewa
         kyA8hZKGkXAp/NatGNp0hpc+o7DwCTcEAV5oQ02ENtTUaQKrXxKahfhhNSWQiI/D+ht+
         qJrg==
X-Forwarded-Encrypted: i=1; AJvYcCVgnFaoPu+2IsIsNvzcutdvFA7hogyAf4y5gjE+fZdNB9iYaNYSNU3bh+nJ1fwcMYaj3qQvXZPMM9MGUf1HNlBeokguXhjJvuMUcTRQ
X-Gm-Message-State: AOJu0YzzBX+417WquDPJUuJaZZJ735Q+uznJyF2eXDZ3RgJoEHJw2fkI
	XdPmup86m+PN2oE8QBGvMFxguo4HwT55AKqITq66jfQ/HS808hz3mRKabA73fXE=
X-Google-Smtp-Source: AGHT+IHyOWzOdU/BOxygotGUcPU3PGmZP/n8bQUUg76ajk1bHXE8sWsDIEq9hzck+GKyOHKJE9LSqA==
X-Received: by 2002:a05:6512:551:b0:513:588a:2614 with SMTP id h17-20020a056512055100b00513588a2614mr193982lfl.49.1709935711907;
        Fri, 08 Mar 2024 14:08:31 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512020e00b005130ff68b87sm78241lfo.109.2024.03.08.14.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:08:31 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 08 Mar 2024 23:08:20 +0100
Subject: [PATCH 1/3] dt-bindings: thermal: lmh: Add QCM2290 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-topic-rb1_lmh-v1-1-50c60ffe1130@linaro.org>
References: <20240308-topic-rb1_lmh-v1-0-50c60ffe1130@linaro.org>
In-Reply-To: <20240308-topic-rb1_lmh-v1-0-50c60ffe1130@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709935708; l=956;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Xh62d3byksWPc2df0T3ZNqEz0dwEInqwU4U7UsjCTrc=;
 b=byZXpm6wd+fbTpb+oGjeh0DovnEkW1bDomSmAaJJ4fk1Xh9XQQZYnLllxRTPWwJQaKfFYHS8Q
 dEjUf0cFVSaAlPESaOzUBwOU56Cja/kDYxXSrdTieha24IjB8SshJOg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Document the QCM2290 LMH.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index 5ff72ce5c887..b815d8c5da51 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -17,10 +17,15 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,sc8180x-lmh
-      - qcom,sdm845-lmh
-      - qcom,sm8150-lmh
+    oneOf:
+      - enum:
+          - qcom,msm8998-lmh
+          - qcom,sc8180x-lmh
+          - qcom,sdm845-lmh
+          - qcom,sm8150-lmh
+      - items:
+          - const: qcom,qcm2290-lmh
+          - const: qcom,sm8150-lmh
 
   reg:
     items:

-- 
2.44.0


