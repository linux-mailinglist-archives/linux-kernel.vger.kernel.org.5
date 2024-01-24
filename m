Return-Path: <linux-kernel+bounces-36560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA1F83A314
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A0028A4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C1B171AB;
	Wed, 24 Jan 2024 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bOiVoWCP"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990FB1799B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081836; cv=none; b=H+ZprUV1/wAqQzP2FySZTlP/x26bhl71su0Ye2APcZCY1tMv38exlXl87xgDYVHnpZDNau8lvTlTAqD5To0Zr+hDXUwbp++eKRs6jJOM9AyA7TrWAqac4duFgtXvJAudzLWsjsEs7airefXHCnTSdPceWODqQ9uf11So/gUodBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081836; c=relaxed/simple;
	bh=zeX+jh65HInrDo/RwQDt8aTaE8xiSCz2Utb21fD2lmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGNpfyXgIVAcZGra08al4cJvjFVpjOJI+ph5qOzx2U3H+LbgMUJ+0ydWdMeBldyeX7LoscX7WN9WhCnq15+f1zS0DwNS3aRXPD/fDSKqfp2qWQL6KE8XkMk1BocPhPw2Vsdyn/bhR/0v7g3OwsDI2zEpsLWHdrmW9WdLMu7HOXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bOiVoWCP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7431e702dso21746165ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706081835; x=1706686635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNpTFIF16BG7YGRQCCrKfm7GwY9WoZx+GmuixbAdH6M=;
        b=bOiVoWCP5ubGhCirCyhK2VBjJs1q9w/iFJmT16KGM4cc3NRRs5ADyBj8MgErfV8Qo+
         fwu6A0je3kLLYvhXrMnwT0xxSoIF45G3iFZb8WrBB9InAZL2yfTPUHf0MUwc9Q95DO40
         Ieat7EVDu655j+DbRykBg796e6u2ADr+IhGD2BcnMZVMVGSn/GwNN96+xsFBW/nvw2MX
         PAPHUtEkd7XR93qwsKfv6fmD77GA6MfGKFoBxfNtIxt8UVVVV6FOzLJRbNHZUuNvs2/t
         cC2zQlUNnllMGCLJgnLFdQbPqTDNyS5cInjiz5r8SuBEypHzbmJp8YTbqkhycqb5iR/i
         84ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081835; x=1706686635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNpTFIF16BG7YGRQCCrKfm7GwY9WoZx+GmuixbAdH6M=;
        b=RYl1VDktowgj9RDPk4O9j3dSOqSRNBzx+cwUDFvlboMoE8ERCajeb5h3OX6VtZWuir
         qQA54CaqXA8gRnGGhRAymfJrGnFKcWKHukGUk64JE0ekE00s/Jc1aKHlrClUOp3dotXY
         IIhP6nksA4JtF8Sv/P3WS5u6UC6CiJFV3YrLFTWF1n8LrtrnAs2ZKB9xzzGDXgiWeRe3
         iGZmxJPfQHxq3K1+70LLoO8a8cp64OQ4Y4hfjrTNogqGVmsjCIk2sP+KzV/RCnw6iwPx
         YzSDnpxvbLSQP89Ak7yWa0WtwFQl5q9CiB0TgGnqmE8kgxw+nxyyusB8mJL/KuPRXsJG
         /ybA==
X-Gm-Message-State: AOJu0YyrF5CG2Dnrkl3Q9n3L1TT/1oi8/rUN0dhtiJJqaTnBsoLQAmL4
	2C/RhpNlMyt/zISHG0YYCuszCHpK9dLcHmWqZpE1QaR4fQj0oy4YNUcvY9yQqg==
X-Google-Smtp-Source: AGHT+IE3jPeSwyuGuMyRlRHopR8kJWwDY/R6l4wnlHb2ZcILwydWkelUDnM75QY0zsO1jxoWEPgN7g==
X-Received: by 2002:a17:902:e802:b0:1d7:6f5a:d390 with SMTP id u2-20020a170902e80200b001d76f5ad390mr360391plg.55.1706081835084;
        Tue, 23 Jan 2024 23:37:15 -0800 (PST)
Received: from [127.0.1.1] ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001d726d9f591sm7386982plr.196.2024.01.23.23.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:37:14 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 24 Jan 2024 13:06:34 +0530
Subject: [PATCH 06/14] phy: qcom: qmp-pcie: Add a new compatible for SC7280
 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-pcie-aux-clk-fix-v1-6-d8a4852b6ba6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=941;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=zeX+jh65HInrDo/RwQDt8aTaE8xiSCz2Utb21fD2lmY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlsL4DPIrhoZpasm0P2lW3phBrp9L8uQenezf2i
 GE6tEIxzAGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbC+AwAKCRBVnxHm/pHO
 9ei7B/9RToHX5l2RmHvp4lJTQYUyyAWAKvGhetr7g8UkSowxxLzt9SI0p28kQVEWSeR5q2TlaOE
 fAwneBwub3bWVMESD+kmppRH5QblNn09PQHyw0yHQat1Zd73WI+qADs5cH6epiSkGxXnbOleJKN
 lD7oo9jgQ2AXnpVt7PU+dKYjgWakTEGwoXwX+Uv3FgbQnU8UonNs/7al7khJ2BPIXIuqUUw8iz5
 vBX8JYDX6nDOW7ER8lYt7R9Ku47EUof15a3zXe1K5et4wHusFYsAt5jKx6XgSzZg7Bx4fjR3YSn
 bUmZ7IF5jCwOuX+6J21ks3UoA4mLdVR8pqbmT5zUMCSxYKfb
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Since this platform requires different clocks compared to SM8250, use a
different compatible. But the drvdata of SM8250 can be reused safely.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 2af7115ef968..9a220cbd9615 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -3822,6 +3822,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sa8775p-qmp-gen4x4-pcie-phy",
 		.data = &sa8775p_qmp_gen4x4_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sc7280-qmp-pcie-phy",
+		.data = &sm8250_qmp_gen3x2_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sc8180x-qmp-pcie-phy",
 		.data = &sc8180x_pciephy_cfg,

-- 
2.25.1


