Return-Path: <linux-kernel+bounces-153010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B63F8AC789
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403E1281B34
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA425579A;
	Mon, 22 Apr 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNLckge3"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B8354F9D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775699; cv=none; b=sIC0GubyleFXiS9+pR2ImUcaVj1jrNccCggkHdhDtvXOKqHMR3PK5CZy8WqqTk0oBJ9+r5Htg+YwYUrXfb0nsrWvo+I1x05oFEz+9M5o74ag1Mdt9M+6lEzh4CzqxlbrfkvwCWexx0xJLxdS/iVHuqawUousvIUqN6cEMBclskA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775699; c=relaxed/simple;
	bh=+GCSZEYws60Xg6jmbcSfmS7UnpFbPUnHzO/8UMSzfbw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ok1XUSK04sooEJcAI8S25M7nA/GgP5sL8ElARsNV5ZA8RQ1qITtoST+z1PAyzyziBoQjY5O9mCoNiyogBdbU6G07hq4+URIBFK3Hq0pfDwtLXOD+5expecfS2n+ziUxeBgMShq9xYitHqtiV49YLvp+f83/A50EjxN2GEcxrq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QNLckge3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41a4f291f60so5236035e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713775696; x=1714380496; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IE4GGhm3DdiBU0OVOK5nTpZIg7dHtuowB+Eju2c0Th8=;
        b=QNLckge3BEOy0kQIwDLR9x3a9JjzGg2x0CZvcfVmxv/zc6ksYfLBbMZMX3YekoUJrG
         pd8WLLhNFSNZJ9+x4/CY4w1FB1cVMbF04fF+OGU7qHIGe9sbbisTNktMX4iSGVUYBRIv
         HEMVvbLpg8o3UrW2CqpkMcwxGZrYTn1Wde20ZFKqgl2OZeMN9x/Qdpt4NeOgG00JZNZR
         DdRAdrjSr9SO7pkbKvn2GnHR9ahMdCCXJfmFqKiKk6uxIxbc8EtmHYAS5SW1r87g0uKj
         953OMEP0QmRTHJy18j9zY5qnbZwG5xR5+ddc5vIq3sRHep8gDeRQCXhRkA5AieEUT4t/
         8tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775696; x=1714380496;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IE4GGhm3DdiBU0OVOK5nTpZIg7dHtuowB+Eju2c0Th8=;
        b=Gfx08r7Bv5FJmZTZiZs+4cL65CLvHGmnb+T4Ic8KlHaDdoqzg7Wc8/LGAlXyOzl5kC
         povbY6TGWM9dNs/Neg4FHI234gxEmsPGDHbQy3N9baGIOzfCAhcfIu5SVajDzlR4kxUw
         qkCmbAVvguP+P956dYtt06UkvmLsg8pIP7SlFEUP5fK/+cfxRCG034HsEtW90rcqie6H
         I8zgfdh1Jschcn8uh2ieG2cjp1cX+N/hQqZKOUc6JfrSsnXnh91VDrudxHj+c5DWrRXA
         e+HD9Xoy7XV/R0jxa/5xkWkyhwNZJ9n4vneo4Ukd3jp52hctQvesxAkChSY5Ob9wNuro
         X0sg==
X-Forwarded-Encrypted: i=1; AJvYcCUW0XZdDjxpYA6llHuFJoP0XHbd4oCg1J9s1lGyxnrVRnoYzXqNq0hRVrXD74ukcsDuyqiyWn+ijQUX3ohRy/ypHA1ZMo98rKEnkAKm
X-Gm-Message-State: AOJu0Ywmk1e4bvafWzVOyRTUU+UVO6HXwhqRxn2f7e1YjqrCqv2sLKnr
	WI/2eS7kpoJMzryEjBVuF4G9zFxsf17H+LJq4n1QEdCQRCtEVgqf90YG+St5wi8=
X-Google-Smtp-Source: AGHT+IFmh1tFvCXRjZorQmarkr/UaXAbDussIdxP5vN4Sj+h4qHKErwiznF0mE4GblLaQipsK5a0CA==
X-Received: by 2002:a05:600c:154f:b0:417:fbc2:caf8 with SMTP id f15-20020a05600c154f00b00417fbc2caf8mr6296840wmg.23.1713775695638;
        Mon, 22 Apr 2024 01:48:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b00418244d459esm15962650wmo.4.2024.04.22.01.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:48:15 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/3] arm64: qcom: sm8650: add support for the SM8650-HDK
 board
Date: Mon, 22 Apr 2024 10:48:11 +0200
Message-Id: <20240422-topic-sm8650-upstream-hdk-v4-0-b33993eaa2e8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEskJmYC/43NSwrCMBSF4a1IxkaSm4etI/chDmIebdA2JalFK
 d27aScqQnH4H7jfHVGy0duEDpsRRTv45EObg283SNeqrSz2JjcCApwAMNyHzmucmkIKgu9d6qN
 VDa7NFVug2hnpqLEFyvddtM4/Fvt0zl371If4XF4NdF7/UQeKCdZaK8mFNiWhx5tvVQy7ECs0s
 wO8KUaLNQoydZFMCcOF2hf8h2IfFIg1imWKOyaF2ZcMlPuipml6AbpMFcNZAQAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3120;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+GCSZEYws60Xg6jmbcSfmS7UnpFbPUnHzO/8UMSzfbw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmJiRNu2DElSmAQj29EEcPOuxyP5PlD/CAxlFP/8ZE
 mfYe+4CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZiYkTQAKCRB33NvayMhJ0ZG5EA
 CH3JY+PgVTzkWfL7afQJcofHBVFdgT9I281ySzaA/C5ZFesLHcX7ewQwMdYgIrhK9UfaH7eYoaontv
 W16u975P2iHzG0haVly3er6Jw5YQg5Fw2z/WzhR8DQGXNm57yW/q/UfH8UCdF83WxgyVslFUKQPrgm
 2zgk5+axicbMApEA22BTQqPNtHwfWERozqskoKhEuuy9lXrFT7KQZLtPjkWea43X6bplGZ0NhE/AJi
 lemeVzEKSPskctWB0m+/fuhyfpy6xNhNdIerfWeLdmR8aQsQ+CKVmgvfi6ud0FNt0an5LMpeq5l27p
 n12hJGov+oZhA5EKWIw1K70W2bOpAIStMJU/ULvJhttO+01UrSXcYsV2HU8GeupZOA6dIQyrzeZLiB
 czIQIwpl3gMEmkWhP6VnWcUnxqy1yYqLlXMDutBqYoSTf2BGsAofm/YuXCdwHDMMprzVzsJ4tLUKH4
 9eeJLYTMkI7CYQb4yPoQNyqJRFlZxNsX5T3lX8i2ToQsXWNvj6AA4f3g8GNuoJs0eRpVDDlZBZddux
 v85fmbKseLXNz/EeCN+B+AeDHxa52ZNE3ueJ2bTdqr3X0tIEkB8tsHm+EPbzRzV4d8LlEbA2MV0GUh
 kby1oss11fm68ujfrNKzqKxUH9DvvjAUkki3+KsCr5HoROyk6V2LDmIFM2wQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The SM8650-HDK is an embedded development platforms for the
Snapdragon 8 Gen 3 SoC aka SM8650, with the following features:
- Qualcomm SM8650 SoC
- 16GiB On-board LPDDR5
- On-board WiFi 7 + Bluetooth 5.3/BLE
- On-board UFS4.0
- M.2 Key B+M Gen3x2 PCIe Slot
- HDMI Output
- USB-C Connector with DP Almode & Audio Accessory mode
- Micro-SDCard Slot
- Audio Jack with Playback and Microphone
- 2 On-board Analog microphones
- 2 On-board Speakers
- 96Boards Compatible Low-Speed and High-Speed connectors [1]
- For Camera, Sensors and external Display cards
- Compatible with the Linaro Debug board [2]
- SIM Slot for Modem
- Debug connectors
- 6x On-Board LEDs

An optional Display Card kit can be connected on top,
an overlay is handled to add support for the DSI Display
and Touch Controller.

Product Page: [3]

Build Dependencies: None

Functional Dependencies:
- PCIe 1 PHY AUX Clock: https://lore.kernel.org/all/20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org/
- PCI-MSI Fix: https://lore.kernel.org/all/20240318-pci-bdf-sid-fix-v1-3-acca6c5d9cf1@linaro.org/
- UCSI Fix: https://lore.kernel.org/all/20240315171836.343830-1-jthies@google.com/
- USB IRQs DT check fix: https://lore.kernel.org/all/20240314-topic-sm8650-upstream-usb-dt-irq-fix-v1-1-ea8ab2051869@linaro.org/

[1] https://www.96boards.org/specifications/
[2] https://git.codelinaro.org/linaro/qcomlt/debugboard
[3] https://www.lantronix.com/products/snapdragon-8-gen-3-mobile-hardware-development-kit/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- Rebased on next and fixed the apply failures
- Link to v3: https://lore.kernel.org/r/20240325-topic-sm8650-upstream-hdk-v3-0-4f365d7932af@linaro.org

Changes in v3:
- fixed regulator node name to fix ordering
- deleted pcie_1_phy_aux clock
- removed undeeded mdss_mdp status okay
- collected revied & tested tags
- Link to v2: https://lore.kernel.org/r/20240318-topic-sm8650-upstream-hdk-v2-0-b63a5d45a784@linaro.org

Changes in v2:
- Fixed commit messages with links, and recently added product page URL
- Swapped i2c3/i2c6 nodes
- Moved pcie_1_phy_aux_clk under pcie1_phy
- Removed duplicate mdp_vsync pinctrl state
- Collected review & tested tags
- Link to v1: https://lore.kernel.org/r/20240223-topic-sm8650-upstream-hdk-v1-0-ccca645cd901@linaro.org

---
Neil Armstrong (3):
      dt-bindings: arm: qcom: Document the HDK8650 board
      arm64: dts: qcom: sm8650: add support for the SM8650-HDK board
      arch: arm64: dts: sm8650-hdk: add support for the Display Card overlay

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    5 +
 .../boot/dts/qcom/sm8650-hdk-display-card.dtso     |  144 +++
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts            | 1251 ++++++++++++++++++++
 4 files changed, 1401 insertions(+)
---
base-commit: a8e1147ee205e7b8dfe18094ed39552a982857f1
change-id: 20240223-topic-sm8650-upstream-hdk-e21cfd6f1de8

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


