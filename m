Return-Path: <linux-kernel+bounces-3863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CDF817430
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D731C21D50
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673137888;
	Mon, 18 Dec 2023 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWWLYhXv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD930FBA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2343c31c4bso182723166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702911053; x=1703515853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PwZoYkBYNDGbxdHHhhA9ml9eCEXVo/RzvZajHy3nCT4=;
        b=RWWLYhXvOnlitXarVbHz88iJHhdEoHrBW23sn7AJSjc0pcfGJz+LVGsI+gGqa/gxhc
         hvgWDKwaV0r3LRV3nY6g568HWxxuC4zfFJGzqrBs/58HU8J8vA/4H4sG36lTopkIDnS3
         A6wAR42hhuFeJXGYViQgYtBEqq5IbUO528C48WSeYF21hV6Y4Bj9cVObIWzCkswE5S7H
         dgtiVgeFMKRkmTFd/mTYD0DR8J6Sg1HuElXJex4pVy9TfVwsfDqiYg3Q7LIuo6s1rbcM
         WG32oVGyU7yBSfzwq2NN66mfmSHGF3FWmWuJhy1wIDBtmHY8dOyXoAe6FxNLOCRIelH7
         6cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911053; x=1703515853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwZoYkBYNDGbxdHHhhA9ml9eCEXVo/RzvZajHy3nCT4=;
        b=dGhxfwER6/qL+uIzASkT2GBhRJIVwyLkclOwKnJZlVXR1AUqxT1s1eei6JDmME6gZx
         Fu/KRFkumfrjoZU6x9Ljd+jEKZP806g5OnX8Cg+7+7vNYhCLtb1rCsCwB9ULZT43D9wS
         Mry/9MK4oozU3DN0Pcmb5dpdDOEdWx2anCuPkfJ6rFSAe44UuwK6ZR8BhUZjib3xs7ci
         tpDfICx7zEyPg/j8/JCTMcgC5JOq6W/uGBseVce3qi/cEn0OYkpGOv37Y7uD6tPtLwmH
         FMg4FxBb3q9gv/JOvShklg99OSTqCet64pLb2wX6YXFK8hD/s5wAK1SnY0Zp8syCjpAx
         sOqw==
X-Gm-Message-State: AOJu0Yx+lhqrOFe9/C2SBpLkxt9Qx9aWG1jb4sL8mL1duAtqk4jVBZ+w
	ekE0RX46WIqCb+YtyMTdNrINJw==
X-Google-Smtp-Source: AGHT+IH6uAXX78npFARzX6yqnSfm4d3d9f+sCviIOufO/KnbKhoCDiQAgMkHMfuZrDpRS3IRffHlcw==
X-Received: by 2002:a17:906:2242:b0:a1f:ad99:a8d8 with SMTP id 2-20020a170906224200b00a1fad99a8d8mr4286249ejr.113.1702911053454;
        Mon, 18 Dec 2023 06:50:53 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id sf21-20020a1709078a9500b00a1f7cbf28a5sm12969440ejc.106.2023.12.18.06.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:50:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: x1e80100: drop qcom,drv-count
Date: Mon, 18 Dec 2023 15:50:50 +0100
Message-Id: <20231218145050.66394-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Property qcom,drv-count in the RSC node is not allowed and not used:

  x1e80100-crd.dtb: rsc@17500000: 'qcom,drv-count' does not match any of the regexes: '^regulators(-[0-9])?$', 'pinctrl-[0-9]+'

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index da691e2f3209..fd09fbc7d8e7 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3315,7 +3315,6 @@ apps_rsc: rsc@17500000 {
 			      <0 0x17510000 0 0x10000>,
 			      <0 0x17520000 0 0x10000>;
 			reg-names = "drv-0", "drv-1", "drv-2";
-			qcom,drv-count = <3>;
 
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1


