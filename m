Return-Path: <linux-kernel+bounces-165558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114A18B8DF8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348001C216EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08984130AF1;
	Wed,  1 May 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIh9FLLa"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0D61304AD
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580387; cv=none; b=XG+UTmlTnlWkFnGvb60inOa0ln3FyNYJyMwV/RndCAYatkZtfvRU8Foido/8vqIl5ISobQrdfht5hvNp0t9CE32j0E68S+JrfRuDwxNI8ZlcG6LGVF6gk9akN67Yaji6BjzWexEMioPadTqqcgrwg1OcXoTiZcyT8W4qcGcSOB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580387; c=relaxed/simple;
	bh=JQDseGGUo/RET8ft8mbdYXUrgDFowOEq0U/TppfOJXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbLjtkooLs5TTrRl6J2P5fHSRno/ygMeXg8R7IUc4o3rbw0tyq/nn6r4SfqIsLMBZT1Cn4CgN3sXDInrHomQDXr2MiQyGE5izDJFald8CR+AQ1taxyYkedPdS8ZfS9kl6IPI7yIRTEOiPAJa9QzkryKKQSPP2ZOT/3ewKO4PGKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TIh9FLLa; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso91433681fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714580384; x=1715185184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQcyH0CQGIecT+zWVTvaDhk752lltvZDOvyRppo6X0s=;
        b=TIh9FLLa4FHjPgXVn6d/3NmeMm3/COHjbutQIb2jIO3kR02rgBU3OUErfsubHzriRs
         e9ViEN16TbGiOAQdmH0PneRoHG/lHbqY14vraLxwLd7G/pzW8sp5AkqI2Y/U2n4sEWAI
         gCMfbgZaoIaUgXYlAQXpPsupyPsb0bFYAquVXGFOrr70JlRSRI2w+78w54GPc4m5CFiK
         5v6zkrHNmqko6WEabgDsfVScJwIdcjE0lnEIbhCpVhRskgdP6XeHp/gctxhTYuhcO8z6
         zU4zohkq46HZvPQW7rQI3gd+3FzafYP8SRpJ96ANZf1yGK8HvqakcvojsOk6Mzgcbgbv
         33+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580384; x=1715185184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQcyH0CQGIecT+zWVTvaDhk752lltvZDOvyRppo6X0s=;
        b=aADn2oHTj5GDs3wtFuxTOqaV+7Ac99FaIlYM5jLdCIjZXMRQwNIeV9OTvA7sjDnKNZ
         3T8GGEFtDrmx/4ORohjgWwLNM876aMq/MMBka2Rkjed5GWmWYiQ2QElTdBq/JA62cRjA
         U2VryhpNaz6PF3F6p3PA7znCGtvmVrOW9B1kZJ7T4JtWYAQjfk8fVXwYEtNCjUsgiEex
         OZ2Wa5weQ/H1wg6z0yc4BWyQR+NQD/Li5rargmX8udklUaHvCKrogzsXKWzIoC3bjNNO
         siHGq3H54mIO/JBLXBv0pMZ+vZBWdXafMoeDd9S32ElJMYpiC03qHlG28kwB5NQ+IxmZ
         rc8g==
X-Forwarded-Encrypted: i=1; AJvYcCV0H4WAj9Z9X+kKXHHz07E4sUM0zC5dggPmjsknNfBYCys5l1r4GtQrnD8j6QdnxhoAWHLj7VAZD9YW71Ri6JFsQ55h/02d/jdSSEYT
X-Gm-Message-State: AOJu0YwgK2s/htlgXRl/Rn4LJR0n+wtZvKW5h5EmkoPE9g1u+ipRqQ8q
	MZLNh8LlMybA/1fRnGIE4c5FHuhk1cl71nccQFKKOu/KKrz0OtnV+e5O4URqTGg=
X-Google-Smtp-Source: AGHT+IFqPEJW/HC+cf6evSpiBnKTVoC9MgPssLpDGsdbNVGqZt/6nuex9rtE4/hP5MziFwRhJQoSmA==
X-Received: by 2002:ac2:44cb:0:b0:51a:a65b:ae14 with SMTP id d11-20020ac244cb000000b0051aa65bae14mr2093217lfm.25.1714580383592;
        Wed, 01 May 2024 09:19:43 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id d30-20020a0565123d1e00b00516d0029383sm4909306lfv.28.2024.05.01.09.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:19:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 01 May 2024 19:19:29 +0300
Subject: [PATCH 03/13] dt-bindings: phy: qcom,usb-snps-femto-v2: use
 correct fallback for sc8180x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-qcom-phy-fixes-v1-3-f1fd15c33fb3@linaro.org>
References: <20240501-qcom-phy-fixes-v1-0-f1fd15c33fb3@linaro.org>
In-Reply-To: <20240501-qcom-phy-fixes-v1-0-f1fd15c33fb3@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>, cros-qcom-dts-watchers@chromium.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 David Wronek <davidwronek@gmail.com>, Andy Gross <andy.gross@linaro.org>, 
 Evan Green <evgreen@chromium.org>, Douglas Anderson <dianders@chromium.org>, 
 Iskren Chernev <me@iskren.info>, Luca Weiss <luca.weiss@fairphone.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=JQDseGGUo/RET8ft8mbdYXUrgDFowOEq0U/TppfOJXk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmMmuYaDLIID2+x59b4mWDd+RmoVTASGHhyuc7G
 RHxTtIS+AeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZjJrmAAKCRCLPIo+Aiko
 1Z02B/9/GWAgJ0b7DMYVB8P67bPfKoKItErG5spn/rWjRmV5/Q1iYL0jH7Pv4RrH2J/P3ieopqc
 RA4E5ARBBUXTnonFisMu9Gd0p9QLmPj0+KhwqI6zC6WXrt/mrviaPzph08sk2LUMI4r3wiAFW/z
 bflQdHtgnX1HTXj9/5aYNeW5TDMs5X4Gvu2zj+eZc4L3lmKOgueMeP+kV+7VXFsDZuvh1E0Mu9A
 Jc4Xoe8PEY1NQCrRKi/FR8sFQNbN+vkivZ79ZegZtSfLwaJ/Ktq8KYOC3/sbxRJ97yUNuF9ef+K
 NdlDZXKxBQJ2SKjDbURX+7mNupnZlM/HW62JUQEKSJE5GFHs
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The qcom,sc8180x-usb-hs-phy device uses qcom,usb-snps-hs-7nm-phy
fallback. Correct the schema for this platform.

Fixes: 9160fb7c39a1 ("dt-bindings: phy: qcom,usb-snps-femto-v2: use fallback compatibles")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 0f200e3f97a9..fce7f8a19e9c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -15,9 +15,6 @@ description: |
 properties:
   compatible:
     oneOf:
-      - enum:
-          - qcom,sc8180x-usb-hs-phy
-          - qcom,usb-snps-femto-v2-phy
       - items:
           - enum:
               - qcom,sa8775p-usb-hs-phy
@@ -26,6 +23,7 @@ properties:
       - items:
           - enum:
               - qcom,sc7280-usb-hs-phy
+              - qcom,sc8180x-usb-hs-phy
               - qcom,sdx55-usb-hs-phy
               - qcom,sdx65-usb-hs-phy
               - qcom,sm6375-usb-hs-phy

-- 
2.39.2


