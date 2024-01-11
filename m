Return-Path: <linux-kernel+bounces-23914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297F482B3C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6ACD1F24F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE3251036;
	Thu, 11 Jan 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCvXiw81"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42701524D2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d5336986cso71632185e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704993357; x=1705598157; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=akghNAx5zO8q20jwNqMX/JqWUlUpy5+0Dw/bZ3TCarc=;
        b=VCvXiw81E5k5Q6zVtxCyOhWjRLd2efVdhNXF0TlWnaWolVLhi2ztXc87FZ322lTTDB
         wLd1V1jygOocfNQSnIJmM7yqgunQ4P53pNpedN0aCGzNdkW+evy7LiOxedV/UGMQicTV
         dk9NoBgN86l5zusOkzCE5GA6QK+BxisYMu344fqm9L7KYjghECHiccfaWV/eTO+MIaCl
         ttzl3Sm8Sb+ZzPuDueaa8h8KKri5YBMZXHwCxQYK/4BOSue1eqeWnzc8soEE2t4eFe0o
         3asD8ZSorNTiEJ7fmkHj83oPwC02dl59vFAiGHqda/LuJ10Bt55lU9oLfajiCC4wjAVG
         FyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704993357; x=1705598157;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akghNAx5zO8q20jwNqMX/JqWUlUpy5+0Dw/bZ3TCarc=;
        b=vsBhEcSaAmtA/Bd2Wdu5O1M98+i2GM1sFRuO9AOPtXmEkJX7lzxApnYfqc+VduWk6U
         vHFcjD7coivPU1JN4+1MBTiNtrZylU8wWx0UFSIok0DNG+cO9BQII3YmH/0BoVF7Sj/p
         1kJNt8KTHZ1348f9RVx0iKjTb/QXAgx4pNpLdSMForRRtOf0WueOE/8vnjJX1KNOJ0X2
         sD/yefmKNR6/7lduxuV053X7xvlehIkuCvZem4nQtqAi5zZzW+oNTsm0LsPstzlMdQyR
         BcjPDkV08OlCcFxyAtSDynrxRSNZQcoe8hHBvagPgub0NJ0vOVhZQgb7ZVnLVMnahV1E
         XLYQ==
X-Gm-Message-State: AOJu0YxqMynhNBYgu0l5Tf3Ne15erxE6Gs7ZfcvPY8SpLxeRDUWEDi8a
	MnvaW8hCmKEyPlbwWNDCrPidHoWv/AL+Ag==
X-Google-Smtp-Source: AGHT+IGoND+UJOh23+LKbFszikkhRBg8DYoBHaZaVw5Op56unEB7OV7Z/lToQn5+W3MkYYACti9X9w==
X-Received: by 2002:a05:600c:4e41:b0:40e:6164:8ca9 with SMTP id e1-20020a05600c4e4100b0040e61648ca9mr81905wmq.44.1704993357454;
        Thu, 11 Jan 2024 09:15:57 -0800 (PST)
Received: from [127.0.1.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b0040d839e7bb3sm6610653wmb.19.2024.01.11.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 09:15:56 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v4 0/4] arm64: dts: qcom: sc8280xp: Add CAMSS core dtsi
 support
Date: Thu, 11 Jan 2024 17:15:53 +0000
Message-Id: <20240111-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v4-0-cdd5c57ff1dc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEkioGUC/5XNQQ6CMBCF4auYrh1TWqDFlfcwLoYyaBOlpEWCM
 dzdkcRE44rlm6bf/xSJoqck9puniDT65EPHI99uhLtgdybwDW+hpMplJhVcfXefoKNpAJWDzIB
 vyVll5dSDw1tK4EIkaIbkQRktsWgNtZUVTPaRWj8tueOJ98WnIcTHUh+z9/UT0utCIz8D1ugQS
 41VmR34O8awC/Es3qVRfevFSl2xbrAwta2l0ZX90/W3Xq3UNeu1JY0mx5JK/NHneX4B40vF8aU
 BAAA=
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-4e032

This series adds the yaml, CAMSS and CCI dts definitions for the sc8280xp.

4 x CCI master busses
4 x VFE
4 x VFE Lite
4 x CSID
4 x CSIPHY

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-24-01-02-sc8280xp-camss-core-dtsi

To: Robert Foss <rfoss@kernel.org>
To: Todor Tomov <todor.too@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc:  <linux-media@vger.kernel.org>
Cc:  <linux-arm-msm@vger.kernel.org>
Cc:  <devicetree@vger.kernel.org>
Cc:  <linux-kernel@vger.kernel.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Changes in v2:
- This series depends on "clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC"
  in linux-next. - Rob, Krzysztof, dts Robot
- Drops cci_src clock - Konrad
- Adds sc8280xp-cci - Konrad

Link: https://lore.kernel.org/r/20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-0-abacaa63a961@linaro.org
Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-24-01-02-sc8280xp-camss-core-dtsi-v2

Changes in v3:
- This series depends on "clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC"
  in linux-next. - Rob, Krzysztof, dts Robot
- Fixes spurious "media: dt-bindings: media" in patch title - bod
- Reorders pinctrl declarations per dts-coding-style.rts - Konrad
- Adds Krzysztofs RB where indicated
Link: https://lore.kernel.org/r/20240105-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v2-0-7a57b8b07398@linaro.org
Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3

Changes in v4:
- Drops "|" symbol postfixed to description: in patch #2 - Rob
- Manually adds dependency below "---" in patch #2 - Rob
- Reverts pinctrl-names as I misinterpreted Konrad's ask - bod
- Removes newlines between reg/reg-names etc - Konrad

Link: https://lore.kernel.org/r/20240109-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v3-0-b8e3a74a6e6a@linaro.org
Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-24-01-02-sc8280xp-camss-core-dtsi-v4
---
Bryan O'Donoghue (4):
      dt-bindings: i2c: qcom-cci: Document sc8280xp compatible
      dt-bindings: media: camss: Add qcom,sc8280xp-camss binding
      arm64: dts: qcom: sc8280xp: camss: Add CCI definitions
      arm64: dts: qcom: sc8280xp: camss: Add CAMSS block definition

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |  19 +
 .../bindings/media/qcom,sc8280xp-camss.yaml        | 512 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 542 +++++++++++++++++++++
 3 files changed, 1073 insertions(+)
---
base-commit: ab0b3e6ef50d305278b1971891cf1d82ab050b35
change-id: 20240102-linux-next-24-01-02-sc8280xp-camss-core-dtsi-2730a5f7ef98

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


