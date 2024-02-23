Return-Path: <linux-kernel+bounces-77947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDB5860D33
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2DE1C229BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9885C1AAD0;
	Fri, 23 Feb 2024 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+XNT1MS"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8C1864C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678336; cv=none; b=jAPOMFQmd9Dz7AqtlCFxV2KLCYNZwdDaMDnzKRIswOA5iNbPr5KutkpM7Ud+uUB/zp6yvEvWW3mneuyOd0jJmHVOv5TYItJeGx3xWZTFrTRvjlqHmJExAQaN6ANqTBQYEXDDPRgNV/3DkIJftOinynyA8aXDn6KrEanLc0W0uQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678336; c=relaxed/simple;
	bh=DWkCipvRFWu3psjdXZAyY5mGJqyNzS6F2w82w26eF+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rqbwwnegjFEOH4Kzm5qkSNFSjzJ5tkrQOuiLmsTE8VWwShSsf3TIv7LXOTPownuROrLAj+vPADGeHEEJCJMuiF0YZB7H2Z3uQjPvVytwSWgdjU2W5tr8k0cbA39z49O0aEAX7hu0hoEpFvT4/iy8sQM+Z9lrhdYcRyu5pxzdkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G+XNT1MS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d7b8f563eso440271f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708678333; x=1709283133; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UaVc+dzBydfVt7yh5YHQ4oHvKCMPSvwvEAP/BiMg8To=;
        b=G+XNT1MSzCsB3tmsaICg5aS7zkH5u9vWj9ilxtbwaKOK5iG8zhwRm4T4K9q6Esqgg0
         +WgpAOAop42OeyHuqO7Rh9EPm8D6suwv/QYC1CMDS5xodwDhBapDQjokkQDFZkopk4A8
         Ej42kGmfY77R/Er/JHEwz0y7mbplYH45Pz4TTxlFbyw3o3OMa72KuK9J9kLkG8T9i8Qd
         wO6z0QyQ5IaNI0nkoGZnHFPV5Lqisfm4BOpFCoVX+zQOPAVbpc73DKyhrXzhuhBNLf3s
         zdn1cmOdkE2YzmaDmIWpR3hLBcbKos90hQHSC6AoUEZNzbAruLaBPaeVqnplZAMXV2P0
         qyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708678333; x=1709283133;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaVc+dzBydfVt7yh5YHQ4oHvKCMPSvwvEAP/BiMg8To=;
        b=tsVfElwFz5nWBGUiNA6heHbPxIxgm69HD3vrhpqrE6BrcFV+fz1Tq5gwh4OmA4y1uq
         rrbhmNroB2X5+6HerfohFbpf3lhYLRRjFVfhaUnnOJ1o2MpmDg0Q6gwQo1P1YdRBH7ba
         WQ1QcXpmX80kFXCjmXC0MhgMqm8ZePJ6Qln5HKRcTXMH5s8aJ2OYWK+AvZ5LEzMQxtRF
         X4ZcR2/MMJTk3rJNQvLBW8hS8oM2jnMUHrUxzjUR4UiZ3J25UpqLX1/lny6jyX48UrBY
         bdR8A9PzRRgOvMw0qHufk4hCVRIbyIxcXNP4IOQDX/VeGk2JpH+dQnMhW0jrbLKkBDju
         9gxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMeMy5TiP1wA6yS+HxTEyjUVuHvaOHzcJ7I6IJsCaqa+eCTAk+OjpXrh9FW6+XOlwHXXM1tFmhftDnAdmyDxVlIVkZA9ECVkSU6RcV
X-Gm-Message-State: AOJu0YxeygZubdC9X5haSpHU+lbm+UKHndaCysO7lnNiFppBFRxUE1si
	X8HaFqdZhRiS8gi7SC0QpyodrajxgkPqgUSKgn/903ilP+QVFV5DBvO0dwxhdeuwlKgS/7l7YWV
	afJ3LOQ==
X-Google-Smtp-Source: AGHT+IEbJPaGeqaOG8efPQ8eSWtnXrMC+YarTVBD6lfPcecEE41i+xrriU97yiT+tX15JYLiiyPVCQ==
X-Received: by 2002:adf:cc88:0:b0:33d:23c8:67c1 with SMTP id p8-20020adfcc88000000b0033d23c867c1mr975219wrj.41.1708678333256;
        Fri, 23 Feb 2024 00:52:13 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 11-20020a056000156b00b0033d1b760125sm2028168wrz.92.2024.02.23.00.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:52:12 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] arm64: qcom: sm8650: add support for the SM8650-HDK
 board
Date: Fri, 23 Feb 2024 09:52:06 +0100
Message-Id: <20240223-topic-sm8650-upstream-hdk-v1-0-ccca645cd901@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZc2GUC/x3MQQqEMAxA0atI1gbajFPEq4gLaVMbBrU0zjAg3
 t3i8i3+P0G5CCsMzQmFf6KybxW2bcCneVsYJVQDGeoM0QuPPYtHXXv3NvjNehSeV0zhg0zWx+C
 iDdxD7XPhKP/nPU7XdQOUySnpawAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=DWkCipvRFWu3psjdXZAyY5mGJqyNzS6F2w82w26eF+A=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl2Fy6j5n1kLkeE3oKBVsDOT4FTM2JeEnXE31ChXJo
 kULwXviJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZdhcugAKCRB33NvayMhJ0RnED/
 4+IJqVqYVY25GqQJGJrMQQfuAaD8L872Kf8h0/JSK6RDal6kAQGi4i8ysEmsi+I4RdPljzk+ycKT5I
 iVILy/OtnO1Qe5ToBsnnHofLN1HNifKJ9rHCgZjuuAUcbLFAWq5xQWumoIUD0Q3irl3//P3Tn9Vn3A
 PfsAZfyt3PaW4sbXhv4ErzqTLfGtTvFE9RUBjQ44oBkO4wwkYSfMwKA6LIqsJee3bhXQ+GSKNAdqC5
 z94MJaT21unnaF8YlItZbEvGnt89zsbNXlJuJ7g3BgpLDoPGFAlzD9uqmzD3JNn9mxlfErfnkCr/p1
 az2CYhOsrh9PvavuhFZExbLR2GKFlgNUghGK+3KMRm6nniHngWSpYhuPEmH+3nCtEjQ1qL2C0/iOkc
 KT1HRz7406XxuBjFwE61oCHQ2+wcv4cdDtZLDebxsOzSWILA7mjJ1p8M6XxOx4A2fsCL/PimMUJHhB
 xt71LDwU0/2jEMmwris7HgIw6pkidFQPg+UTaUJd5xpOpk0Qgk0pGX2TG6Ic4fhN+eMaWJIxf3J1DC
 bjW1+oPa8SYxvOvaqWcHhER/617FWIW+Y3tUwr8AvMpuXM3rXmFuEA1XBZ/DkSaSfAmZFt9mWyR8k2
 261k1nOzwd6GfAR0/HlbngmQjD6vuVza8Myc5Liu1JcDN41nEvy5KlVcRDGw==
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

Dependencies: None

[1] https://www.96boards.org/specifications/
[2] https://git.codelinaro.org/linaro/qcomlt/debugboard

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      dt-bindings: arm: qcom: Document the HDK8650 board
      arm64: dts: qcom: sm8650: add support for the SM8650-HDK board
      arch: arm64: dts: sm8650-hdk: add support for the Display Card overlay

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    5 +
 .../boot/dts/qcom/sm8650-hdk-display-card.dtso     |  151 +++
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts            | 1259 ++++++++++++++++++++
 4 files changed, 1416 insertions(+)
---
base-commit: 33e1d31873f87d119e5120b88cd350efa68ef276
change-id: 20240223-topic-sm8650-upstream-hdk-e21cfd6f1de8

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


