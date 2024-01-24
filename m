Return-Path: <linux-kernel+bounces-36559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C975583A311
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D241C234A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BD917752;
	Wed, 24 Jan 2024 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0vSR7s9"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536501775E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081831; cv=none; b=eAYR8d3oqDkHTf8ZnP2jnpemgCl05mkutwkH3Ohm1EsSqyqVx92/WoE4DJFie2ofZIbmwuy6yIovX3mQk840ZThNEeQ11BfbpwB7s8Yy4WltIlc3HXc8S7ZYygXp70V22w8xnN5GNNqzIuz624seOXojo7vWlyNEhKcJulR0O6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081831; c=relaxed/simple;
	bh=w51HxUcd7PIFxEJ6OgE0FVVFmZ15T0vvM8776BQDfiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCAHbBvkIR9D7vHDm0mmRNg5r6MB3yTDnv/BsaAlkVIIM1t5yyncxKJMIv2pnSoNVcsCe9q/A/pbR/TiE+gEt4TLKc4UyOQs36d9/Xnpg05PMwQtO++ulo7vTfnL3hNJxz30PBWAQWSLHH4F6MxfMmUhaa+2q5K1NBiC4gt3EGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P0vSR7s9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d750660a0aso15087125ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706081830; x=1706686630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZuZcdUnAaZplEI/q0+jQccDNm87eHwhpTq9IdQtppg=;
        b=P0vSR7s9hNe/6eS8BWQLHtN+Ewjd5AjE0ComrDZYbeeROhPnOtuO01ki0oDu7q+X1T
         crBqjXJfsBsHqTx4Uww0PWdTxtIBGiH8nHqvL8uisvkPqdztYtTlLkRMqdSYuC5IO/b4
         thpSSvSsVgfnsmZm2ncu6U8x6MXIDYTrgI/fU/iMmsVvnyogmTepWnkmEi/V6PHa3mQF
         0Oyur5YxEz/PUFpYkyqGNNNxUni/F/mNv0y8uqByQyRHjDttpznSQY43X17Dyk/ZxX3D
         GFa7dH8V4LG4b8y0iCAYzWLVlcJ9R5bWEeRAqJTzySCSW4CfbIOrGKTf7izRAEzpPclu
         Y+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081830; x=1706686630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZuZcdUnAaZplEI/q0+jQccDNm87eHwhpTq9IdQtppg=;
        b=KFDI7crTEOyhoI9a8ztGHyTpZXTS/uFYf/lXXssSryBcIRnauZ+MqzYdjxE8+apKdD
         QVhJ/NAN/Dk5cvOLwV8Uv/V7NlGXSVpo8fy+FgjGSLZeZMVHtRC9j/4/kKehe/yic3XJ
         OdK0UI+WttHXczLkW1TSiqydy5IuezM+HBjwV94hXmCp66JzWSlcqAqplFu5RN/OKshx
         p67b3wpVPFRqoBx0TXnFMtg2kdsyOTItnpko48KQ9fg1rZzvfalyYynlKcjS9Uwu+IVn
         u9ChKBhUqK/PD46+fER3tIRcsuUcleQ3MYJkgrZZLla6IqtBrkfM2LLMRZQJUPlz4BX8
         CPpA==
X-Gm-Message-State: AOJu0YzR0UiC6HDt7xUFTN/ORbz5uiPUFyWyHNmG0RFMA12b4xyq34Cb
	08M4BjRIAtVSm4KQBE6LJp2OQK99OlKQaEJmPDRnQsvX1Z0fq8YWXPCqOLABCQ==
X-Google-Smtp-Source: AGHT+IG/mhM1tXpIYDJ+QgSt5kfSy06HMtXU3+wdXvqf7yd/1q4iuQ8Li1G5PSzHd1qUO9SSeGiszQ==
X-Received: by 2002:a17:902:a9ca:b0:1d7:599d:ed25 with SMTP id b10-20020a170902a9ca00b001d7599ded25mr293175plr.39.1706081829738;
        Tue, 23 Jan 2024 23:37:09 -0800 (PST)
Received: from [127.0.1.1] ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001d726d9f591sm7386982plr.196.2024.01.23.23.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:37:09 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 24 Jan 2024 13:06:33 +0530
Subject: [PATCH 05/14] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document missing compatible for SM8350 3x2 PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-pcie-aux-clk-fix-v1-5-d8a4852b6ba6@linaro.org>
References: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
In-Reply-To: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=w51HxUcd7PIFxEJ6OgE0FVVFmZ15T0vvM8776BQDfiI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlsL4Do/rhrRxBBcGh4nzbe8uTfLLa/A6k1e8Nm
 cQmYLYOUzuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbC+AwAKCRBVnxHm/pHO
 9WSnB/wMBNvlf+Eb1MLAZ8tHAt7hDQbZWgUDPDi2vLIc8inCjo3y79EjNMOBDVB8rvgiO6TDEkF
 TvJIRY+rMb+1aAPNL/PGpk9TQHAOUHj9jIbQEHkZf3Ff+x0HThfGIQjSEiqTqWSwFZE8p1o/Z7u
 DVsMJL4cpCICemBXdHgOZW354scZhFwG4lJevvjElux9zZ1ZP6yeme47movn5L0e8oI8FMhHg6L
 gHZCqGC+Z3AeNALkvgGj89QPtz1x69XxWUmRzRn6mvdyXsyzC6fxRhikZ5fttFyaLW3sRKrHqXb
 8fHNzR6BVRYNQcBT9Qs3tlIUuRWNVfn4Dce4+rcsM568XqXA
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Document the compatible for SM8350 PCIe Gen3 x2 lane PHY.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 2396a457f9c8..77338184cdb4 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -33,6 +33,7 @@ properties:
       - qcom,sm8250-qmp-gen3x2-pcie-phy
       - qcom,sm8250-qmp-modem-pcie-phy
       - qcom,sm8350-qmp-gen3x1-pcie-phy
+      - qcom,sm8350-qmp-gen3x2-pcie-phy
       - qcom,sm8450-qmp-gen3x1-pcie-phy
       - qcom,sm8450-qmp-gen4x2-pcie-phy
       - qcom,sm8550-qmp-gen3x2-pcie-phy
@@ -131,6 +132,7 @@ allOf:
             enum:
               - qcom,sc7280-qmp-pcie-phy
               - qcom,sm8350-qmp-gen3x1-pcie-phy
+              - qcom,sm8350-qmp-gen3x2-pcie-phy
               - qcom,sm8450-qmp-gen3x1-pcie-phy
               - qcom,sm8450-qmp-gen3x2-pcie-phy
               - qcom,sm8550-qmp-gen3x2-pcie-phy

-- 
2.25.1


