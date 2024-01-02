Return-Path: <linux-kernel+bounces-14027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B8E82171C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CC81C21128
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37D0110C;
	Tue,  2 Jan 2024 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLzeU8jd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743720F5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e6ee8e911so7390389e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172648; x=1704777448; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKdUrJNCReC9eOhzNwa7lHUNCx2+g7VDaGVelraoPhQ=;
        b=YLzeU8jdrsWivVFLipzgSmp+OICTbp3MH5vsAIiwYXRARuqGZenbxBfAi7KOJV7e2T
         DyorTE6IXLXvOgrUgLpvidIJAby8cwsDnx7UcYYOurBr+yu4w9HPRbfogQUy0S3hxhik
         ohY39IbuLt7pVZzEOS/HnTqRhfYx/0dRBoXQwxE68sVppmd5KlyByIsqpkLXW2sor62j
         JNYqwXNE/Ho3eB8jtnp/z4AN15K/cY6njIXtC7D493JRPSRtXXKs3hXlJyD3YApNv0Os
         v/VF6xiRdAhr5H4tcAibS4oJRWWLnwb80CJ8LpeDv1DQtoyHCF5UEbp2ZSpt4OsATWTn
         gofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172648; x=1704777448;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKdUrJNCReC9eOhzNwa7lHUNCx2+g7VDaGVelraoPhQ=;
        b=el/KnHX7heXi12pGTcPAapOZsfVZOtz59BZUhO2+PHzwcBnEeAsD+CuD9EeXGS36Ad
         xc+Tq23gng+y8GXjWAj3f+b4+Xi5rSOGfgYrxKfQIIJIu3ecZrO4L8cFitEGsxypjdno
         CNUpLu0gOHjlUXJhJ4diP3IwPURrVkg5e43XwFVMr09XXkn5jtjoAyuarR9RuG2ZqONa
         j+hO5QK6I80YOVI/KM8ixL2Xw9kWTM3HOXOMpqif6ay4u4/+gH911BZjjZcxXVoZ3XHr
         7kJWJCONZytVeSETPQjg9VXIS8LcepUFiwEDpiI84glAx6hsgT8pUDWe/yV/iWxQlEtA
         mUXg==
X-Gm-Message-State: AOJu0YzH7eBYc0d/S9sh5CjMjDKNW+iPnUp79hHQC9J6AfmgunJwCv5E
	nBROV7ZyiDHneNA8U2rljIRQw07M6/9PVA==
X-Google-Smtp-Source: AGHT+IH9Ux8fGS3Kjpth3HOJrmmqp91o+F0uRMGNzThcSjvbmBy78jjYmKqmwlAc2rflwCcfe9Z0iQ==
X-Received: by 2002:ac2:5e6a:0:b0:50e:935a:ca83 with SMTP id a10-20020ac25e6a000000b0050e935aca83mr1785675lfr.91.1704172647723;
        Mon, 01 Jan 2024 21:17:27 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:27 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v7 00/22] soc: qcom: spm: add support for SPM regulator
Date: Tue, 02 Jan 2024 07:17:20 +0200
Message-Id: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGGck2UC/zXMTQ6CMBBA4auQrh3SHwzgynsYF2OZQiNQMq0oI
 dzdxsTlt3hvF5HYUxSXYhdMq48+zBn1qRB2wLkn8F220FJXUkkFEd8a4jIBU/8aMQUGdNI1yqq
 z7azI4cLk/Oc3vd2zHYcJ0sCE/5VRWjZSVpWqS2Nao9sWFHSTT7yVD+QtDs+wXkc/I4cycC+O4
 wvl1xotqwAAAA==
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3455;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=jUUzlvlRe6+nOTsn7j/oEccAvSac6S7/LU+ktDHJNQQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlk5xiIQpi6N5Sy/VOojLvbNYdI3w/mOqEiHAIw
 kDGq+AlkEOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZOcYgAKCRCLPIo+Aiko
 1SpjB/0UnyaxoVFryguBxKe6lprIw23jO7C1eesEx9lxYCZqM7Mz7juGdjas2fbCRO2fY9ejfY8
 0VGupbo8WaMsMEX+tQFjWcO91FIE29Pau1fI12HjUyCtfPkxyUZNtbqKSPV3GwqX20goXoBmMtr
 iacLgWAtu1UbcHIQSTb3BnIh98iasGmvm3CoNg2XcID5mwmYbggA2UL8R5oFqka0aarMv/H+i/s
 gqXMy67Z6WuKQhRlqU4OpNjmg5ARO/fFJGXv3ZMCpm8v5vntps3yRNlLoBt1a7mJMXUwOWfZpM5
 o+k7cjmKRQSWn5e7DqITAnCkNScCApjkRrZZ/1qg1Vs7Oyhp
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The apq8064 rework to use cacheinfo takes more than expected, so I've
spanwed this series. It is an excerpt of the APQ8064 cpufreq series
[1], so it it continues the version numbering for those patches.

The Subsystem Power Manager (SPM) / SPM AutoVoltageScaling Wrapper2
(SAW2) are hardware blocks used on some of Qualcomm platforms to handle
the voltage rails. It does this by bypassing RPM and directly
interfacing the PMIC. Extend current SPM driver to export this
regulator.

[1] https://lore.kernel.org/linux-arm-msm/20230827115033.935089-1-dmitry.baryshkov@linaro.org/

Changes since v6:
- Added SoC-specific compat strings on MSM8960, IPQ4019, IPQ8064
  platforms (Luca)
- Fixed saw2 node names on few remaining platforms.

Changes since v5:
- Added patch that moves SPM structs out of the header file
- Removed support for L2 SAW regulator (Stephan Gerhold).
  msm8960/apq8064 do not use this SAW2 to manage this regulator and
  other platforms will need changes anyway.

---
Dmitry Baryshkov (22):
      dt-bindings: soc: qcom: merge qcom,saw2.txt into qcom,spm.yaml
      dt-bindings: soc: qcom: qcom,saw2: add missing compatible strings
      dt-bindings: soc: qcom: qcom,saw2: define optional regulator node
      soc: qcom: spm: remove driver-internal structures from the driver API
      soc: qcom: spm: add support for voltage regulator
      ARM: dts: qcom: apq8084: use new compat string for L2 SAW2 unit
      ARM: dts: qcom: msm8974: use new compat string for L2 SAW2 unit
      ARM: dts: qcom: msm8960: use SoC-specific compatibles for SAW2 devices
      ARM: dts: qcom: ipq4019: use SoC-specific compatibles for SAW2 devices
      ARM: dts: qcom: ipq8064: use SoC-specific compatibles for SAW2 devices
      ARM: dts: qcom: apq8064: rename SAW nodes to power-manager
      ARM: dts: qcom: apq8084: rename SAW nodes to power-manager
      ARM: dts: qcom: msm8960: rename SAW nodes to power-manager
      ARM: dts: qcom: msm8974: rename SAW nodes to power-manager
      ARM: dts: qcom: ipq4019: rename SAW nodes to power-manager
      ARM: dts: qcom: ipq8064: rename SAW nodes to power-manager
      ARM: dts: qcom: apq8064: declare SAW2 regulators
      ARM: dts: qcom: msm8960: declare SAW2 regulators
      ARM: dts: qcom: apq8084: drop 'regulator' property from SAW2 device
      ARM: dts: qcom: msm8974: drop 'regulator' property from SAW2 device
      ARM: dts: qcom: ipq4019: drop 'regulator' property from SAW2 devices
      ARM: dts: qcom: ipq8064: drop 'regulator' property from SAW2 devices

 .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  58 -----
 .../soc/qcom/{qcom,spm.yaml => qcom,saw2.yaml}     |  45 +++-
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi           |  32 ++-
 arch/arm/boot/dts/qcom/qcom-apq8084.dtsi           |  13 +-
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi           |  25 +-
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi           |  10 +-
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi           |  20 +-
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi           |  13 +-
 drivers/soc/qcom/spm.c                             | 254 ++++++++++++++++++++-
 include/soc/qcom/spm.h                             |  23 +-
 10 files changed, 353 insertions(+), 140 deletions(-)
---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20240101-saw2-spm-regulator-af0f81c15cdc

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


