Return-Path: <linux-kernel+bounces-14047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6109E82175A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095C61F239CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9AC154BB;
	Tue,  2 Jan 2024 05:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kwkALe4G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7242414010
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e7af5f618so6254800e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172660; x=1704777460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIOZ/y8JUbfWvbpm85HLvnEHXM/G58Bya+E3PH2lYUo=;
        b=kwkALe4GdfrF8JZGHvqBtXoU5GoKgSj1bITFQx3oYaQU1l27GmDBA/Y2m+IkNuskmT
         Xlrut7ayFeSzVYp1vg1VhQT0uVPNiZ+S68hhYv/B5A/zW5CEBTRCe135p3zVyR4h1Xqs
         WjY1/msC0OTLk9Xk5OoFLGb21jQ43V+YjebF5PLdFev4TQXuej+cYd425A5nt30uvkzq
         MX3YyRziq5WoOJTAfCqvH724lX7cA6l8cAIavJkjGOCQsoDMJQtt27ubMxvqml9xpvjl
         JC4d0JsPxCfY2Mmbx0w5/cKEZoATAUOK76RC62hA7UzpWr2ZefDVTee+Ep1q1Zg8mCRr
         Uu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172660; x=1704777460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIOZ/y8JUbfWvbpm85HLvnEHXM/G58Bya+E3PH2lYUo=;
        b=RHlu2P3ZvUwxOnOVx4wvFva/ZNtSJNtnD8zEniMmDixZq67HUTKA+NsG9Paonqd3Ei
         7E2uHwqVs35v2C+iXWh9JzMA8wOH57CQkYY7FxzhaiDbCvoJcG0lYjbEPpy3wZwyeXvO
         6mbB2JBhEHpoZuuwcE1cJF49a6XBIgLgWkWSB0H169UUAjOIGKfmdyHsFLg2kq2HX0EF
         P1p9kvgi6nqP2tws32vLDExdDRV8ihGrzLyCDLpeOeJ+CNRmcbtv+S/b41hmEv973TJF
         RBbOGSyQlP3zKcOEtcAOZgA173R7P/JKyrXPTO8izypTTKnej4tvqNvItr4D7c3txYSq
         oq1A==
X-Gm-Message-State: AOJu0YwHiezOW7jIVfKUJhptDIWMTsz1AT7jIHqwidjEEdCIuFEkAJ5z
	dtJnbZPyzgXebzXDZE/2z1YKIHk5biNzDw==
X-Google-Smtp-Source: AGHT+IGhNrpyBW6iGpTPnfyhjRokEBJcSuiq9Rt0FLn7anA8NKo39ezhp5QEmBrbn8lKOOd3kbP4Fw==
X-Received: by 2002:a05:6512:3d07:b0:50e:73ac:a179 with SMTP id d7-20020a0565123d0700b0050e73aca179mr6670333lfv.91.1704172660618;
        Mon, 01 Jan 2024 21:17:40 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:40 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jan 2024 07:17:40 +0200
Subject: [PATCH v7 20/22] ARM: dts: qcom: msm8974: drop 'regulator'
 property from SAW2 device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-saw2-spm-regulator-v7-20-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=939;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=kR0lMZX2xwzVAKg0rhKEcc0wH+BrPTZbmecKX8k5+A8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlk5xmjkNDhCkiNSoJxOw250U5lLiXdhhVcMzBW
 HYlX67spEqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZOcZgAKCRCLPIo+Aiko
 1VWuCACYS1N4SQfa35xxnulXx+BQeMwHGQKGkZr02IDWmt/oFcJiPmPsFklbD7mFJO9oS5neqDp
 r7/EMaXgAdpm0s+VrXHMv8KWOhoORl7n+RCKer8cdmz0oOoz+RXqTygB9g+vaNAnfdhlcUmlWPm
 YHe0S5EjQ2sq2swnpwDa8KE0IhmGkQHrc6cjrwbOFFqg9HVU91NMYlR7rBYgB2vgbeoxUgYOVjg
 EG3dvsitMmiY9cqjw3ZqzAkiiXdMmk6CSh7Ag9QayNoLcE9ufyolZ5rcYr4XpCfQtmGEJ8N1cfk
 lGsEPdG5lEpF3mh/s2lSu+dk4tqupd5+08kZRm0EoZAO7gSr
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SAW2 device should describe the regulator constraints rather than
just declaring that it has the regulator.

Drop the 'regulator' property. If/when CPU voltage scaling is
implemented for this platform, proper regulator node show be added
instead.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index e2008a8b89e1..ec27260fe3d4 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -349,7 +349,6 @@ apcs: syscon@f9011000 {
 		saw_l2: power-manager@f9012000 {
 			compatible = "qcom,msm8974-saw2-v2.1-l2", "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
-			regulator;
 		};
 
 		watchdog@f9017000 {

-- 
2.39.2


