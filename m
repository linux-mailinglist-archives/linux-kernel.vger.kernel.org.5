Return-Path: <linux-kernel+bounces-74008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3130985CEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FAB282195
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1375939AEA;
	Wed, 21 Feb 2024 03:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oFsJkRlm"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8798D38FBE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486929; cv=none; b=PFZd1qh9Q8qQTIkp5WSYDZP4MeR/msRhkKd2joYS7v9Z9d73GbnN57/75TrHFzS/4XHjvCfLCbigfb4KVlPy7CE4QoqGGbXdqv80NQzeDRrayA0q0gV1TtsIPjOh/7lS+rMw2kj3hmSULlPcwA9Qt3KK3dK98NRuj/M8bRQFJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486929; c=relaxed/simple;
	bh=7t1TKV9oHfbtypKrfVlUmm8Y14s1NVoXY+RaFYePMs8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EixgnfMW5AD9mQVixSiBKujAxDhZwv+JdFBnrPKrKSdljTi8GUVo6E3khZyQg2e8Di7fMrebSNoUbTUrxESn4wIcQpZZCZb3FtHv7o2hwQ2Rs+l2gpGFBLBNqcsNyQ2A3SeOL2QUpOUU60S77ORRbfwqE/2psQp8ofC6wzxGt/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oFsJkRlm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso5290330b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708486926; x=1709091726; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DVVF7vEIGZjBCotuFgH2PrLCENJOK4nkNStjqD2FIg8=;
        b=oFsJkRlm4DtRD/lkxWKKZB648qnCplDFqKRpBRwgl9PndzD8AbfL8zD7hbZZFY36Yr
         CWGVPOEjgW4b5H+UhAsGxjyJ9yFNmDJN+o1w1a/+cMPfzN5m3nJpa0rR3gLbx4ZAVgCA
         uJOYaILtc57VvbXtbDf5piWWngIdnkpR6FWXO74joXrvU0mfeQ+AzaWwRMBYlydvsU68
         wnD+OrBhxExvD1iB09B9OulF4BqMtRrPyie17Uax8HRDzdFFz66B2+VCW8BpfwOqf4z3
         lV2y/BUoPBQBUvfdkDUCMSkl3OoPkfMf6GWll9eiYNZvHfZJJjUun3cXPmxGVrqKfJ8+
         Ar+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486927; x=1709091727;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVVF7vEIGZjBCotuFgH2PrLCENJOK4nkNStjqD2FIg8=;
        b=MvlkEDnyuXX+PT8TUKKiPx1XjvOXBt34PnzabzyxA6Eiq6Aig2y3E8DVDRiK8DTRMi
         KWlGY4VuD32Zw01UtKfyRq2vOAxZ4RaSJCAjMZIQgV4eh/NrfTkGozNBrStJZtB8QV6L
         QEnCLgc6m1Mjk73Dy7uKzVt3L3o+ye7w6I0/QC0eRczi83K7nHZCeurhK3opUnktqjt2
         Po/A8Qr1AR0kVX11zB2wUl7hPpeb4/P4yck3gxco/E83zDpaBQdbT5epGsAtTNcbuByQ
         r7N+v3PzQ/AUHmdUFA7ZUTP33MvujPa7+ejcD+c64MR8PRi7xwwnFb0237k2Q+kcpZcJ
         hnjg==
X-Forwarded-Encrypted: i=1; AJvYcCXOfoY4vk1bPkPUd652+jIfeMXtIFtd+hROkFOToQ2Iv9zJ7tbvhuny2YplxwDFRorq8fSGFuEM3EEA6D/A1QadR1rjnQ1+73G00Agq
X-Gm-Message-State: AOJu0YzTq4kBfmIbVw9uh2aPmycSFOfh1pL7yKzIuHD48y8oz15/sZGz
	8e3EPX/0p98GKMPinntRQ8yxEzNtGcPB0cENk6Xi1UHWfVcalHn6zlq9ir84jSeKqeAjoe0g9QQ
	=
X-Google-Smtp-Source: AGHT+IGUeZg4H3ajQRtyeguNhF3HLUxBqN21FPYXX7Rb32pX7UsBIXBun8gTAU5CAAuwES+jOws8Qw==
X-Received: by 2002:a05:6a00:180d:b0:6e4:68fa:f1f9 with SMTP id y13-20020a056a00180d00b006e468faf1f9mr8625869pfa.2.1708486926609;
        Tue, 20 Feb 2024 19:42:06 -0800 (PST)
Received: from [127.0.1.1] ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm4436231pfv.132.2024.02.20.19.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 19:42:05 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/21] Add PCIe bridge node in DT for Qcom SoCs
Date: Wed, 21 Feb 2024 09:11:46 +0530
Message-Id: <20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPpw1WUC/x2MQQqAIBAAvxJ7bkG3iOgr0SF1qz2kpRFB+Pek4
 zDMvJA4CicYqhci35Ik+AK6rsBus18ZxRUGUtQqIo2HFcbThh1NFFe8uxKavrHKadO1ZKCkR+R
 Fnn87Tjl/cL0lwGYAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3470;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=7t1TKV9oHfbtypKrfVlUmm8Y14s1NVoXY+RaFYePMs8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl1XEEYatcc8RMyWl8SiVwWPQdvD40KPKZCCb++
 +YlZMuarcSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdVxBAAKCRBVnxHm/pHO
 9Wa1B/4t8wor+IpWnGsAKtfPraFtKhtykFbOPAduWKydRWAIHMDbFk/F2ZO80V3f6UHLNziP+Nx
 Mti7xN+w6n524Z8wv8YQc2W+u85wGRfWeyaDVrn0BCLWNvpOHycleiwE/H4ZEOqI9bHrXawwJe3
 F/7cMJ/sxHPMY25An+6rXejMeHXqssR3lfkhWaSI1dMCADypgCct+ijD6ABy1ZtOj/vvrUxM52N
 ZwDucCBS1vJcYmDWCvdftMCD8zRp5dsHXBg7bxeBfBAMKOVXD/9gwr6Q1krNQns2Wh76NUdSJZT
 Js8Exxh2EIv2N5apNdCalkG9I0bDnL7x2zNWnUk51+7GgJaP
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, this series adds a DT node for the
PCIe bridges across all SoCs.

There is no functionality change with this series, but the PCIe bridge
representation in DT will be necessary to add the DT node for the client
devices like the one proposed in power sequencing series [1].

- Mani

[1] https://lore.kernel.org/linux-arm-msm/20240216203215.40870-8-brgl@bgdev.pl/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (21):
      arm64: dts: qcom: sm8250: Add PCIe bridge node
      arm64: dts: qcom: sdm845: Add PCIe bridge node
      arm64: dts: qcom: sm8150: Add PCIe bridge node
      arm64: dts: qcom: sm8350: Add PCIe bridge node
      arm64: dts: qcom: sm8450: Add PCIe bridge node
      arm64: dts: qcom: sm8550: Add PCIe bridge node
      arm64: dts: qcom: sm8650: Add PCIe bridge node
      arm64: dts: qcom: sa8775p: Add PCIe bridge node
      arm64: dts: qcom: sc8280xp: Add PCIe bridge node
      arm64: dts: qcom: msm8998: Add PCIe bridge node
      arm64: dts: qcom: sc7280: Add PCIe bridge node
      arm64: dts: qcom: qcs404: Add PCIe bridge node
      arm64: dts: qcom: sc8180x: Add PCIe bridge node
      arm64: dts: qcom: msm8996: Add PCIe bridge node
      arm64: dts: qcom: ipq8074: Add PCIe bridge node
      arm64: dts: qcom: ipq6018: Add PCIe bridge node
      ARM: dts: qcom: ipq8064: Add PCIe bridge node
      ARM: dts: qcom: ipq4019: Add PCIe bridge node
      ARM: dts: qcom: apq8064: Add PCIe bridge node
      ARM: dts: qcom: sdx55: Add PCIe bridge node
      arm64: dts: qcom: sm8650: Use "pcie" as the node name instead of "pci"

 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi           | 10 ++++++
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi           | 10 ++++++
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi           | 30 ++++++++++++++++
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi             | 10 ++++++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              | 10 ++++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 20 +++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 30 ++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi              | 10 ++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi               | 10 ++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 20 +++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 10 ++++++
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 40 ++++++++++++++++++++++
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  8 -----
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 40 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 20 +++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi               | 20 +++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 30 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi               | 20 +++++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 20 +++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 20 +++++++++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi               | 24 +++++++++++--
 21 files changed, 402 insertions(+), 10 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240221-pcie-qcom-bridge-dts-b83c0d1b642b

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


