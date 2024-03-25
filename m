Return-Path: <linux-kernel+bounces-116829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CB888A558
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B2BB3B50F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406E11B250C;
	Mon, 25 Mar 2024 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uzw2MQTe"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4F13FD76
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362407; cv=none; b=BvqiUPnCJkFEhlrDQ+CblyJFs36viPQRGBAdtPZAZcLoxWYUrzrTB2zNYcHKIKb8TIkrK0CVRrwctZDvzYjUD4+ZmSTgHT21cP5q8xKktnah1k+AVdMZ0IpsoqWuWrxtTCBEi40J5ayoSzAnOfI+jS3zrvlB9SXFnEUVzJ65PGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362407; c=relaxed/simple;
	bh=Qj3eQ3a0CaMppgLKBlVjL9xWsX1gom+nOd0MEGTrVLc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AlR8g636N4g6jL6Lb5ONfQPgqN/50Od1CpzT9lPn/Ae4cwjwC8u+YTUaHLX6a1Ob2mjZcwu026A3mmTujynQwJDvkrrXXkcjMoAEL/TA8YtlGqIkyk7+0kltJXozQg39qD2kcbknfxXLMDyRUmtX2IFMb6WgFquggY2CbAufXkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uzw2MQTe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4148bd2ce39so1206285e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711362404; x=1711967204; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sbdWN/HEYCuepKzVQK/huX0MvvetY6lR09ktw8/bDhg=;
        b=Uzw2MQTerVKCvtnDj7284PrT5HX+CK0jSkW+v+yeBP/tCcXCWUoOYHFKiXGJlUNXe8
         Xg8GcIVj1Wem+bevuJmMaR3H7hMOG1Wj3kpWeUaJzHb0geLzCcYInUnAk5JflyKSt91k
         b/ZeZF5f0usFem1KhJml1U5mCnrnr/C/lxWMF1TlXW6WI99tfkmDzoacK5ZPJuct34fK
         lDUkwcpH8h0UtH1onoDasedoZuag0Vh4vn49LpmNmH9RxkdhQx92RRl7iA347tJ9yFPx
         8ceuLIEmDJ1hLbZWnnSvgg4qnq1aa0DayzITvoPZQLky7WI8ELD7r4y8lE9YtsBHKCWM
         cqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362404; x=1711967204;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbdWN/HEYCuepKzVQK/huX0MvvetY6lR09ktw8/bDhg=;
        b=dFerqzMYD9HQbDusaJDC1+Afdr3Bb5R7aDrDpxlR7wnsCx3bQJkKTMBRapv3w8p8GU
         gck0iJv6eS6BCcOLkn1X53jI47maelhfMzuXv4Ink+FiJiXz6u33+KBxY0zkQBVd4CXb
         Hc1X1pIPCY6tv+0epfZElnqOcCWeeqPLQUh+JiLdzArbeV/EBtEZSQSbjJSmE6iO+Px+
         bBxkHn8/al4SNLbxuqXYsA+1+f4M03bMkBo3x+nUpOaKLIBr0xbK2hgDyEDcixbenavG
         ILD6PICSpTI2HYQVfjl/Jrc/ceIJjk3QLitjXoD8pntSi46gdDQDYIib/WG0bla9e/Ia
         PsJg==
X-Forwarded-Encrypted: i=1; AJvYcCWVo0RYkHzl2s9IS4141s25KL2WKagt2iEwzZKvh4gG/W+3GdHCdeJPPECSzwQn1uIz28GngKUYt66+K5qE1Hr2I0vjbPJScAkW9Hgz
X-Gm-Message-State: AOJu0YwinFokaH6IOUhkVwEUKIIAhsLCcA6AWNEBGJ46TIwfuFFwS9Rq
	gKf7EeZVzL/LP/6eZVbMy1XqFkTHwyVzjvdhAn8uOyT80nbiLhG/PrvKdZ5gWJo=
X-Google-Smtp-Source: AGHT+IH9cJ/k99CJnmzTxNvO80jUvgltEKN16vOH/YxbeZsXcc5hmWk4sVmIyxWMtmJ9OVSUQJ9jLg==
X-Received: by 2002:a05:600c:2981:b0:414:69ae:bcfc with SMTP id r1-20020a05600c298100b0041469aebcfcmr4110589wmd.24.1711362404270;
        Mon, 25 Mar 2024 03:26:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id jg24-20020a05600ca01800b0041489884a98sm2899023wmb.6.2024.03.25.03.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:26:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/3] arm64: qcom: sm8650: add support for the SM8650-HDK
 board
Date: Mon, 25 Mar 2024 11:26:36 +0100
Message-Id: <20240325-topic-sm8650-upstream-hdk-v3-0-4f365d7932af@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFxRAWYC/43NTQ7CIBCG4asY1o7hpyC68h7GBcK0JdrSQCWap
 neXdmPcGJfvl8wzE0kYPSZy3EwkYvbJh76E2G6IbU3fIHhXmnDKK8q5gDEM3kLqtJIUHkMaI5o
 OWncD5MzWTtXMoSblfohY++dqny+lW5/GEF/rq8yW9R81M6BgrTWqktYdKDvdfW9i2IXYkIXN/
 EMJpn9RvFBXJYx0lTR7XX1R8zy/AR0D2eIOAQAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Qj3eQ3a0CaMppgLKBlVjL9xWsX1gom+nOd0MEGTrVLc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmAVFhP8ohvKpGh6/aD70sUVLo3Gv3WB8if/RWndXP
 6zTByCiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgFRYQAKCRB33NvayMhJ0cuFEA
 Cih1QbnWHc/jRtHHri6qW2Ai/rcdynreSky4qmpv4gFV8IZYieUDrU7vFcndQVt4ss5KXBlEvAGSVo
 IqR0bV5NbMUx3n3B+9Y8nvla5zVFX380uD8qvE+maDWXrqGJGyjBMP0x8n73sZd8+jJOWZGBGGZ0Af
 UVJy4JrqGKv28XX/6/og1fFx0UybtP9d9t+B+kRy38cQFqC5iFO7KaEJzHMTnWAa8R2Dy+ajAstNLR
 g2MAcqwKlq+4kiqUvpFKZOseOr1JqqmgdXOY5Cyqr3XjKA34WBkrZ1kT8H4zXXb6SNQjz7K3WgtddG
 Pu6cv1bSkfTuIwkGVSjhNeUPV8C0M9qYybntsV3d2xc0WtCT4R1bnqQIqgxc0PN2/g0V0aObSIoaBB
 Rkuf3oDh014BXl0X4RH867pFhiBuNo4x41ie1t/HFb22Pr1VIaXLj21RuFvkOnU4iRECdGcTVAgJmD
 wgp70IcF4DhkXuHUdOkhxlQcuxqMHlcnKrEWhB9RUQ4E5UC2Q7DqUSm2tj/y2ZUHMeIiVHYxJy9oDG
 rKgSe3hNiRzEKZcTMoIVBunAdOtNffHfqVEui6heZwzd+u8+IQ4E4HflZkz0gfkzLNnbIPoh4I/hdW
 V7OwmEuNNXyvwAoDnHVYJkdbDDqzgxkUanvojP/CXH+FFQbdxdKSwbnO0fHA==
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
base-commit: 0cd9d04a3ce7cd228d32adaf99a56708161a6b8a
change-id: 20240223-topic-sm8650-upstream-hdk-e21cfd6f1de8

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


