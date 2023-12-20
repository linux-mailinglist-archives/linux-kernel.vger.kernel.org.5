Return-Path: <linux-kernel+bounces-7043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D8881A0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4031F21365
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C4138DDD;
	Wed, 20 Dec 2023 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxhH1mPX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249738DDC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cc63b3ed71so61009771fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703081719; x=1703686519; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVCTTYiJ91+s57jD+K9o4Wr6gXYe09eki8yh7Bk4VS8=;
        b=hxhH1mPXhKkD8ssEnuEm043LP/Dx5qDez70dFJ20pAVVlkNsj/PaR6PCM75k15azYz
         UenP1CiqZ+Dr8CNAwaWaZnSZDxvaFAWV6VQoKOPdJoL6VDdbQUopVcmzitsPez9u77la
         encUCYI472inmz+yov/kvLzS5TT075/xOamgT+tu7vMAg0dldypc5YCXuNghcJqUTojs
         x4vwWLPChNnnlQygspY8QcNSQxF+GkOC0U1JcTzMe3jTvok9PxFwfWZ1Lt/yLUcwgWFa
         fQaDJQvhbjMtL02GNmpizvgGJBlVxsWsINCz+RdqdQN4vJjwXPS2C0jVRUyp0Q3LvwWJ
         hjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703081719; x=1703686519;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVCTTYiJ91+s57jD+K9o4Wr6gXYe09eki8yh7Bk4VS8=;
        b=StgMZ4o5qaAoQjZIYtUCYVu/dKNDATvx4j4f8O33zjqhli8UnI7hcOsTjEQQt4ShDi
         MFN4mH8hNNKrbZzNkj4UWDyl28/RVVCIxvnt6+3cfKSoQWyYmcQe8fk4LRFuT+zeelrv
         /PXZJeVDGoKVKG7/A5oS2fWJpnS1WXw/jpr45quRfjKeCIPMMv88SUzPbzeRFmUqR6JY
         FFPwJ/rv1IKuBnCaQBYHADx3oTL/G83VlwUs/ipV/b6EvAU88TwRQ6eSBnQrB+Tdzv5z
         0Ae7yCS3+V+aj5LW0VQXywaz49Oe1pJSiwU1ma/Qmp+ZAcp2cqRUzGU/hixPuNp+uXYs
         iiYw==
X-Gm-Message-State: AOJu0YzQlxEePeWM5dv5jHDqqbtMaboVjLLYd8Jtqc+T2lmya5k9mK/f
	uNCwFrK/QRmu9Uy+8JtCQWwKmg==
X-Google-Smtp-Source: AGHT+IGF30HrQ7miU3l5r30Dl5+X6anxhcpbToNfS4jgPhB4ri+adcClT+7X4I2Y1Xo31ii9cFO8Yg==
X-Received: by 2002:a2e:92c4:0:b0:2c9:ef49:8f05 with SMTP id k4-20020a2e92c4000000b002c9ef498f05mr9133085ljh.86.1703081718740;
        Wed, 20 Dec 2023 06:15:18 -0800 (PST)
Received: from [10.167.154.1] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id p8-20020a05640210c800b0055399fbe7b3sm1822446edu.20.2023.12.20.06.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 06:15:18 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 20 Dec 2023 15:15:11 +0100
Subject: [PATCH] arm64: dts: qcom: sdm845: Use the Low Power Island CX/MX
 for SLPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-topic-sdm845_slpi_lcxmx-v1-1-db7c72ef99ae@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO72gmUC/x2NQQrDIBAAvxL2XMGohbRfKSWYddMsGCNuG4SQv
 0d6nIFhDhAqTALP7oBCOwtvqUF/6wAXnz6kODQGo43tjdHqu2VGJWEd3H2UmHmMWNeqtEU3Pwb
 vjA3Q6skLqan4hEvr0y/GJnOhmet/93qf5wWoDVNNfgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dylan Van Assche <me@dylanvanassche.be>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Caleb Connolly <caleb.connolly@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703081717; l=1035;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9lF4noAKNDuUswRMaGjgwwfeND5eXR5DTqNtxNwyxDk=;
 b=Ry3GGZd2tXsxP6MikDMv5dQ5H0XB2wHkZpvj/Ga7txc+qeX09FKM5WIrfrm/5kaBKZIPMS2dR
 rBLZfEW3bWhBpM1Kxah77xxx6kdaY56aLsYKTc7l6/v3Hjic5CLc1fT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The SLPI is powered by the Low Power Island power rails. Fix the incorrect
assignment.

Fixes: 74588aada59a ("arm64: dts: qcom: sdm845: add SLPI remoteproc")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c2244824355a..237d40486142 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3366,8 +3366,8 @@ slpi_pas: remoteproc@5c00000 {
 
 			qcom,qmp = <&aoss_qmp>;
 
-			power-domains = <&rpmhpd SDM845_CX>,
-					<&rpmhpd SDM845_MX>;
+			power-domains = <&rpmhpd SDM845_LCX>,
+					<&rpmhpd SDM845_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&slpi_mem>;

---
base-commit: 20d857259d7d10cd0d5e8b60608455986167cfad
change-id: 20231220-topic-sdm845_slpi_lcxmx-03c4f98a423d

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


