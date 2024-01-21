Return-Path: <linux-kernel+bounces-32127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409238356D1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66AFD1C2176F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A420381B9;
	Sun, 21 Jan 2024 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViVlhbSs"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848E376F2;
	Sun, 21 Jan 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856359; cv=none; b=Kkb0WRqYR++z4vLEhRAc2kIKJZKpYfzCQnxDI6xnszBzqHKN9H10ej69khWt4G3D0O1OyyEGrGdRJWPpbt0wcbuMLutCgT6rnoBednrt/i2VftdP1N0127GWxdorMxZvdm2fqXGuhH8zKrLqf1UeKY4/n0iGV0mNZO6V08AwJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856359; c=relaxed/simple;
	bh=V4XRfyu2VuNHj6+ng148/c2sivbOY9FCOFxmgKRmcyg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=beKOzAcjx/LOewUJ9dYzhQFlIIhYNxZBLqdlu8Yv47v1+MWK89LCULd2yE0DlbxTVI0d9e1h3ul4dNGAg0DVylsZJcCibtRbaJYEJMW9YGdAPHTDY1Id2STAWNkr4iKqYM9o3FyKVdXulNbqJ02C2OHgmExbPqFhyWayyUKoFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViVlhbSs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33934567777so410528f8f.1;
        Sun, 21 Jan 2024 08:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705856356; x=1706461156; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iw0lURdtpNdGU/9fKSnj2h+p7EalE0kEm389szngll4=;
        b=ViVlhbSshFim33epngad8vKNiv8fNnfltH/5R0mN/MsGtlmFd4EctnsA10CrEnGkbL
         ddTNgRAGuXEpyzJ9oNQdUHoQrkv6hsqVBHpdc0vfUNxg01dWXNicIpMnCi9fK5k+/iLw
         SidGElEV/fNS35RLFLnh4viaQi7Vq5f7/EaQcxQc/cSddCRiHMmK0YdmEr46Wx25rJ/N
         1P445qBmQ7cKCTqhXxJrBsvCT6A6RDhI0+BfnMPkmZNhUGz6w+ZX3z+sDyvx80SY3XYl
         jnPPNjKQSVXHw2UXNaISqznTJBvqkNIXD0ODoisaODaZxQaN7fhPXYjbuSO6dYJzNbJh
         ei7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705856356; x=1706461156;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iw0lURdtpNdGU/9fKSnj2h+p7EalE0kEm389szngll4=;
        b=gEoZdFbqVsChxSyDONas0xMmK5qOP/ugiOefug3pdofhaGiIiTbiTtmc/Ky+bqdSfS
         0L/0VBxxDEEgJN81IQSLJqCbPtMK6PyoHtR6z3UA2axG930qdYQkWhE2XWv/ZVrB5p8/
         294ifFIZwqDvtIQecev1AtrHYg6SVnqTSwGXkuycZdrnoXmuT84MaGf/qABrz4Z0b5zu
         Erg/hdqQzNBrEnwzJ3lAJA3GmLycRfiupkjjwqfUQiCxQTXj3sofCxrX4DcUh4GnAfzC
         bYnJi/WnHl0jQ52M+rlifQU/OP+lyhc72KMg275W4vh75RQR5ZI3wGssIhrUoa6lxDRO
         fMTA==
X-Gm-Message-State: AOJu0YzvLWpMmFWYuX2+UBgry1opKPBcHfxB+TvrG8IcQbOxKZEmlsBf
	+xPDAN8MyYpLw1nw6YHNqJeAg0x5DC9Rf17rCViOnJCvI7/55ogl
X-Google-Smtp-Source: AGHT+IERvsYoNAV2dkYnGva5iE/kqnhp/zG/OmHsOop7nVzlgHfM9/vVAwuyxKjyDDvGBKAZBnPP6A==
X-Received: by 2002:adf:a15d:0:b0:337:6322:de93 with SMTP id r29-20020adfa15d000000b003376322de93mr1486268wrr.103.1705856355783;
        Sun, 21 Jan 2024 08:59:15 -0800 (PST)
Received: from david-ryuzu.localdomain ([178.26.111.181])
        by smtp.googlemail.com with ESMTPSA id q5-20020adff505000000b00339214d70b5sm6541115wro.85.2024.01.21.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 08:59:15 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
Subject: [PATCH v4 0/8] Add UFS support for SC7180/SM7125
Date: Sun, 21 Jan 2024 17:57:40 +0100
Message-Id: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAARNrWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIxMDQyND3eJcc0MjU93SguKSotTEXF0zCwNzo1RTc0uTpCQloK6CotS0zAq
 widGxtbUAnGr5zmEAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, David Wronek <davidwronek@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Joe Mason <buddyjojo06@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705856354; l=2765;
 i=davidwronek@gmail.com; s=20240121; h=from:subject:message-id;
 bh=V4XRfyu2VuNHj6+ng148/c2sivbOY9FCOFxmgKRmcyg=;
 b=f0h0X6jbWTIkh/If9Oab7dFen/KOOcROnZAshl6defaOa9stAXyNF18PQKrnsmJk7KQVz6Ufr
 wLbyCjnnsXCDDuGB4kZz2G7yvKMgp7CN1jv1dQkPNX35yj2DplKu0By
X-Developer-Key: i=davidwronek@gmail.com; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

This patchset introduces UFS support for SC7180 and SM7125, as well as
support for the Xiaomi Redmi Note 9S.

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
To: David S. Miller <davem@davemloft.net>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>
To: Avri Altman <avri.altman@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
To: Andy Gross <agross@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To:  <cros-qcom-dts-watchers@chromium.org>
Cc:  <linux-arm-msm@vger.kernel.org>
Cc:  <linux-crypto@vger.kernel.org>
Cc:  <devicetree@vger.kernel.org>
Cc:  <linux-kernel@vger.kernel.org>
Cc:  <linux-scsi@vger.kernel.org>
Cc:  <linux-phy@lists.infradead.org>
CC:  <~postmarketos/upstreaming@lists.sr.ht>

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
Changes in v4:
 - Add Reviewed-by tag from Dmitry Baryshkov to fifth patch

Changes in v3:
 - Use SM7150 UFS PHY compatible as a fallback
 - Fix dts style issues
 - Add regulator-allow-set-load and allowed-modes to UFS regulators

Changes in v2:
 - Fix device tree binding for QMP PHY
 - Separate ICE into its own node
 - Fix style problems in sc7180.dtsi

---
David Wronek (7):
      dt-bindings: crypto: ice: Document SC7180 inline crypto engine
      dt-bindings: ufs: qcom: Add SC7180 compatible string
      dt-bindings: phy: Add QMP UFS PHY compatible for SC7180
      dt-bindings: arm: qcom: Add Xiaomi Redmi Note 9S
      phy: qcom: qmp-ufs: Add SC7180 support
      arm64: dts: qcom: sc7180: Add UFS nodes
      arm64: dts: qcom: sm7125-xiaomi-common: Add UFS nodes

Joe Mason (1):
      arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S

 Documentation/devicetree/bindings/arm/qcom.yaml    |  1 +
 .../bindings/crypto/qcom,inline-crypto-engine.yaml |  1 +
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |  2 +
 .../devicetree/bindings/ufs/qcom,ufs.yaml          |  2 +
 arch/arm64/boot/dts/qcom/Makefile                  |  1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 70 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi | 28 +++++++++
 arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts | 16 +++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            |  3 +
 9 files changed, 124 insertions(+)
---
base-commit: ad5c60d66016e544c51ed98635a74073f761f45d
change-id: 20240121-sm7125-upstream-68072e5794bb

Best regards,
-- 
David Wronek <davidwronek@gmail.com>


