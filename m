Return-Path: <linux-kernel+bounces-129035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B516989638B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E9D1C22C06
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23834AEEF;
	Wed,  3 Apr 2024 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ablhve2N"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08C4B5A6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 04:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712118882; cv=none; b=XfN+F7PLaX6okn6mHzXuSPU3sg6naw4klJRi9go+4iWhmqkNNUs6vqzXIX/ybN27DrYLDuu/ML1Uy8f8DTXAbfiLC8y3uysuHXiDDQIVudRB41lSr/yAc9gu3mFwPvXCWxNeTTJ37ofRs6kiW29lP0GFCd6U4m3+bH8AtRAEnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712118882; c=relaxed/simple;
	bh=QbcBc4JXtP8FNrsiFhXtIJGTYDJA6oPqiQ8+qe0RZWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqcGsnilLJyVTO/PPDfLjYDy7fDOgVqSMnGqUQGXR/+y2bnKiwvqCyRPw2+M4lx5oHhH3F3uyfEmnNPRBaaJC4FBNCr0j6oUfc6x8Tzd9ZNJEFJiDIHRdgnq8+9gXUKjzvaDk12DbZePmIGs5Kl6y0PjhYezh8JTUKCp5RS5+HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ablhve2N; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e24c889618so23907525ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 21:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712118880; x=1712723680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bURk46YiZRFAzwI3iGbvVt2z2P0j12npgAvS2/bABok=;
        b=ablhve2NDOrmT8c3FUC3B5QNQsT5KxqN+QJuu9Fihk7qqtsWr9z6r8uSi9QrZxo0OR
         A26Mc2cAub12fBpW2Q/lajtJitVlDZOChxTywClmNc1vODybSSkVhWkyjW+ZKAtPiTG+
         mL2xpI+o06734wmIEXBcbFAFlBYpYphAmqRYACRqaBNWof9V9tZO/mOwhQC5NzW0c9bg
         zl2YBw65reCz8ptkpkLQcPcrW2hzToIjjQeuhA9EaPIvuaL6HWEvc+9BaL4WCxq8px4J
         1hTDxMxVma/AfF5wTkfBremqpBH7pRDkaI4VRPmObG9HdBW4e2W/uBzEoPuOQjxXzwaU
         NaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712118880; x=1712723680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bURk46YiZRFAzwI3iGbvVt2z2P0j12npgAvS2/bABok=;
        b=AKoqn8ylH/b07Iu00xQXU4bFygkRkCBKwcSV6JdIvWzb+GXIq6/+wwzC5FXrjppQ60
         MWPDQQaEVBJjV4vZTe8K6Djk//35w/b64xlhM937miJz0s7nNfRMF7LTBbuCokRmbu68
         8n35+COMFIBxg45pBYkqu7UKMB7JWQ84JipggfeQpmktBHkapMkRHDflpcD41j0X8DJK
         AHC3vZYVkYFhhvW3OnYaKx95xbefj3PNRnCqAEFX0YDLVyjHrR2MZPDkkUh4FD+CRyRi
         efUlVrLrPBaRcR6GtC3dOOC67zdfltgD/ik2FAWGVpZ2VtOgY2WIO53BhPublafVDupU
         mD3A==
X-Forwarded-Encrypted: i=1; AJvYcCWrVXcoYlUSXQZbRUgQ6T4zFRHV3rbKg5FeEkiGQaTm1K1ZsW2RGuXxu//VHHUbyqnzI4RMHSgW+M4hkjFOfbLjiEuYD1/WXlszCnCQ
X-Gm-Message-State: AOJu0YxE5Fp2zxmC7ix2jj+JymjR3lM/30yzwIoXzu8ovXd+d5oT43Gr
	EvbdQBRZJjiVzdTiLIqN6GXfPx9Jjj3UQ7asi16oi7Iu5fnZnwjvgU7kHvjoDQw=
X-Google-Smtp-Source: AGHT+IEBeePXJRtjCWXOavKsp/3ejQVjp0fl6t9QEsUss6kN7dCsl+4rmbdMgERBrhFJrYfaL/NIfg==
X-Received: by 2002:a17:903:182:b0:1e2:75aa:443c with SMTP id z2-20020a170903018200b001e275aa443cmr3866351plg.24.1712118880159;
        Tue, 02 Apr 2024 21:34:40 -0700 (PDT)
Received: from sumit-X1.. ([223.178.212.199])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b001e2059a6386sm12074634plb.12.2024.04.02.21.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 21:34:39 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	stephan@gerhold.net,
	caleb.connolly@linaro.org,
	neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org,
	laetitia.mariottini@se.com,
	pascal.eberhard@se.com,
	abdou.saker@se.com,
	jimmy.lalande@se.com,
	benjamin.missey@non.se.com,
	daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: arm: qcom: Add Schneider Electric HMIBSC board
Date: Wed,  3 Apr 2024 10:04:15 +0530
Message-Id: <20240403043416.3800259-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403043416.3800259-1-sumit.garg@linaro.org>
References: <20240403043416.3800259-1-sumit.garg@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible for the Schneider Electric HMIBSC IIoT edge box
core board based on the Qualcomm APQ8016E SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..c8c91754fe04 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -137,6 +137,7 @@ properties:
       - items:
           - enum:
               - qcom,apq8016-sbc
+              - schneider,apq8016-hmibsc
           - const: qcom,apq8016
 
       - items:
-- 
2.34.1


