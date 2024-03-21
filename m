Return-Path: <linux-kernel+bounces-109958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BAE88583D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B4A1C225F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FECF58228;
	Thu, 21 Mar 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YajVz8m6"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD15821C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020264; cv=none; b=GzBoNikLdF9cNnYcyPJKMFq47lpkcjAj0/vqk6jgMXSCRaOfz4+7EiZvBFEd+OPEFnnraXdLErYvwUXVvnucFbHkeHQN5EzhE8Y7jwY5CxMiIqOJdMqdDBDY2VkKaszzesXU6K0HaudUfLbyfXYaR+Du6+1fIWr+JjUcph4wowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020264; c=relaxed/simple;
	bh=zv9KKqUc9fAa+niST3PvZen5PrPnTLP0uZp7en464NE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GOmhVNeUwPMc0cEhNpjrHL6DnQxEq1D3lo+UQw7P4uuq8JAeP0PDTTfKVfiZusPw4jxQUhqEJVsHEErJz5IDgfuygXTDrJIKG7fR4p0VmDqZro9DiYjVqmZNqRulLo3BNiF571cqyJ+IhA1U/qxMYnhGatxNAp+t+7WdG65r9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YajVz8m6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e00d1e13acso5090665ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711020262; x=1711625062; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AoHRZqUApoexBQclJ0SEIArATxYn4nvqO1XMi4tAf/I=;
        b=YajVz8m6scWj5E7qeB0VO9himA1qNCZSejsszeSlbdpJ7yqYEEPnRoVnYjuSTwbs9w
         R99mjCDF1HuNE00n6c8r/9PRusDV844h8IiK2j+9eNTxm0XONnHX8RPE3SmDWBafvZhm
         XDkqoa2h7n/tKd8E7znDGC/jozmj4CzNwSktctZfhlwWeFm/iW7KD5S5oSYAhUrHrhPB
         0U5iTrFxNo7gmp9i1jXOwArOfwJ0YVVQLYsiFJJKv+bOgq4NOSyrOmbwbC0RbBHNaNdm
         2TRlGOSYzUGBPIBx/VV2lFNN3uiMvUCQJ2kajH6w0rPIIQx9yTZmQl+iclNgBYe0yp7Y
         nJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711020262; x=1711625062;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AoHRZqUApoexBQclJ0SEIArATxYn4nvqO1XMi4tAf/I=;
        b=DdDxIZ27Q4EvbquOx788DOe8u9Fq1Gk3HjJ2VrCmjpbOljCLy5iXmojcMB8sAXwqD3
         4SJ1shYprxMcNG8CEruhfrqlVM8NJG9QGwKEh1PpRFV+/7JtFjPPfAcS3wu/N7sOHqFc
         iDFXJrrxPUqjvbyV+26NrzvjVKKTpjyXbJCzUPMpC5jjyEe8ZTlN7ja3oOzgv86rLs24
         QRyTA+UK19EQuB/O9NFn0KEtgXbOaUsBcjlZhrVYPRf8hB6UTW8J4ncWAdcP5h03WfEE
         4gYUHHap14rBINjukwZ7+yAgPyt4DR0RCYAtcbh6yMo6+j4hX+gA7I68Qd0hBbk0dJrU
         z0sg==
X-Forwarded-Encrypted: i=1; AJvYcCUMRzpqVQcXgHhXJqJiAOAaZxLs6wsBjiWyQHukYQMW6k6Hk2EY4K1/K/wxfZUewwjkFXbw8EWjUyC8gyaX4z5TBdujHLJPd7KVt+P+
X-Gm-Message-State: AOJu0YyXrhoZtIH1DLNhD4R+W8ev/6g3iALac7GiuOogbCJ9zhJEH1ur
	zGfgP0bNoB3ConkTJrwTWaAqqys8l+9cG2CP5ZfsW7NGKJpeH0Hs/i2LX/yKSD+0RSsY36lOFow
	=
X-Google-Smtp-Source: AGHT+IFJsLv0LKyhdDZ4hWi1GEWRRF4DiaqFe0j7aUXHYQSeixrjn3jVZLnWa1Vb9aLvT3uBlbwP/Q==
X-Received: by 2002:a05:6a21:3a84:b0:1a3:5d70:1828 with SMTP id zv4-20020a056a213a8400b001a35d701828mr4489419pzb.48.1711019795777;
        Thu, 21 Mar 2024 04:16:35 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:16:35 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 00/21] Add PCIe bridge node in DT for Qcom SoCs
Date: Thu, 21 Mar 2024 16:46:20 +0530
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAUX/GUC/4WNTQ6CMBCFr0Jm7Zh2rERdeQ/Dgv4AkyiFKSEa0
 rtbuYDL7728722QgnBIcKs2kLBy4jgWoEMFbmjHPiD7wkCKjCLSODkOOLv4QivsS++XhPZycsp
 rWxuyUKaThI7fu/bRFB44LVE++8uqf+kf4apRYe1q36nuas7K3588thKPUXpocs5fLDKHybkAA
 AA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3620;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=zv9KKqUc9fAa+niST3PvZen5PrPnTLP0uZp7en464NE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcI0ubzqSFwVpxkGZjd+njegKvBWv5lTO3O4
 FkM6u/CmWaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXCAAKCRBVnxHm/pHO
 9aYkCACWDEgfPJUitECHdt0chIpNj4kwVLqbDXVmOr8c8MxzTZESFZKLUCfNyPhr3jqiWN23u1V
 sC+vVz0hVomQUcsf1ZsuTk7422nRScDN+DTf0GxIcmP3Z3ZDd1b47Ybe7KyxempGzW/GmHWLp1+
 qZGi3nODxg/B4/Fk/+JplaqckHupMvIFuyAb4SgYf+AYBhuGCEJwhQBUhEhEEoAASIU1/0/4fRr
 cbHqnOCu3bLxtQrknVHa8Y6nEWFwNSVE9EvXlPJ+guuQp6mGECJdRqYNTvE5js81RzxVP88ciLD
 aViBc1H73jdbgEBnEB377dkzsv5PXV9cHKjsjNIj6an4kIT3
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
Changes in v2:
- Added label for bridges in sc8280xp
- Collected reviews
- Link to v1: https://lore.kernel.org/r/20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org

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

 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi           | 10 +++++
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi           | 10 +++++
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi           | 30 +++++++++++++
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi             | 10 +++++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              | 10 +++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 20 +++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 30 +++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi              | 10 +++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi               | 10 +++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 20 +++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 10 +++++
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 40 +++++++++++++++++
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 20 +++------
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 50 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 20 +++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi               | 20 +++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 30 +++++++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi               | 20 +++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 20 +++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 20 +++++++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi               | 24 ++++++++++-
 21 files changed, 418 insertions(+), 16 deletions(-)
---
base-commit: 10569bb9fb9732cec670faa38cf1460cabeffa09
change-id: 20240221-pcie-qcom-bridge-dts-b83c0d1b642b

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


