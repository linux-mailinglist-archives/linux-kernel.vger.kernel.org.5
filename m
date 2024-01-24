Return-Path: <linux-kernel+bounces-36554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1E583A301
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A311A1C236F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D416E168BC;
	Wed, 24 Jan 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oAC49Eu0"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF4168BA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081806; cv=none; b=Cc1P5M8C0EqzeQVfFAYFogaAqBeenV4tijmpo6/0k9mSYQ/dGZvxavtE4MLaNRUUh1b0njxifDTtu4oafmLOW7zX8p7Gl1XLI86oyoFOI9EUR9jtcp/HknQN5dXi8Fr7wDt+KojbGf6uEqpL6p6JS+x2XyT4XrXTPm5QgVq9Rq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081806; c=relaxed/simple;
	bh=0bAo+DjmDYAuM+Ex9Q8ZUzStygNJaMDJB87PuoEd+ww=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dZHTmLQ+3SUlhi1F+79JDwNoJ+BV7TKchfTfWxbcMQDPV9ehmHn+hdjARENND/naoOoUM3SztCCkc4qnH1iFOD5h75KJcXPzePj5VQtMCLwRCYK9+ydIe+Gwkgit+4tT2iMqeUECS3NFhYkUs329HKmwedWXYj/IRi4F9E56ZQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oAC49Eu0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d711d7a940so44976475ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706081803; x=1706686603; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L0WO0CYl2/04yEtIdQGCOmoVDUFynJRcTJckMO4oOK8=;
        b=oAC49Eu0U0HX/waEdCv7jP5+L0RGStOnwpkW0Z9/o9elcFvaqxSFKkNd7x15we5VGZ
         zJuqV26LrT3BvR4YdiiB10aqIBMBgbM6hpHV8EMDpHM2SRiqBYCw2GUYcwP+RlvEk2Hv
         N4hBgaHM9xBaKR6t9OfnVBMWasQ5tCIIbmojCkFd1K91tfGd3jyI8WHxb6xMSkxUyAyC
         x/RIMxUcVb5GVTB1O/3TYwTxOfRpdn6fALwKqaE3xXF8g0IUkdR/wzCnxuK5rzHZOxxQ
         YbhVIqkmnM+oeQJ87J0qxHwoi3faERVAPjMZBMmuItkEHdNYbkucTjpnganjh4iJFMBk
         dO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081803; x=1706686603;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0WO0CYl2/04yEtIdQGCOmoVDUFynJRcTJckMO4oOK8=;
        b=IrKO3jUKvUPqn/ykU+YsKNz6b3aPUUtvMuA6LIIwI996Ku+6Ere9Kb1Hgpgmn4z8QF
         sSyUKhrFtnmJIqliGiydCj3idv5/iOcM/wVRRKrLBk8bK6F9TteYlApu/jFdbgZbw6Kx
         dscz2tSJngpr5bbH1bNhEO2VWA3HaUPdmahqXrqLOorLBZ0a1way/1RMSnbNAszo9wqO
         0rAFjON039RBXCjf+6lT78xOtNJRWm7R5rj5lMQ4Zm5VfPffhNxPBCAJZqWqhxGujg3x
         Mu7REOz9N0xsMmGvsyHxIcfSgaCJPu3u+wGglr8g9kbNe93/00x3d09+QtbJFIvD3umo
         e7Pw==
X-Gm-Message-State: AOJu0Ywil6XuaN69ojJAdQXenKDfmcgBRe6kdLNpbNeofeQWjO4C/wrN
	B2Lt9t6Z3KVvJCMEPAGTZ7/kp2evASBvr4dHqh03NLJiDoam9aoJ+8Hey5pvrw==
X-Google-Smtp-Source: AGHT+IE7CH/SGuc+7xjw0qQvVJK175DYMK2mpFDNjyVSXN13WBOxq7vs5X3Pc3k+0o5j0S8TsBRNpQ==
X-Received: by 2002:a17:902:6bcc:b0:1d7:5c2c:ddc with SMTP id m12-20020a1709026bcc00b001d75c2c0ddcmr361944plt.18.1706081802977;
        Tue, 23 Jan 2024 23:36:42 -0800 (PST)
Received: from [127.0.1.1] ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001d726d9f591sm7386982plr.196.2024.01.23.23.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:36:42 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/14] Drop PCIE_AUX_CLK from the PCIe PHY nodes of Qcom
 SoCs
Date: Wed, 24 Jan 2024 13:06:28 +0530
Message-Id: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPy9sGUC/x2MQQqAIBAAvxJ7bkFFkvpKdNhsq6WoUAoh/HvSc
 QZmXogchCN01QuBH4lyHgV0XYFf6VgYZSoMRhmrtDF4eWGkO6HfN5wloWrt6J0j3YwEJbsCF/0
 v+yHnD7T8we5iAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3936;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=0bAo+DjmDYAuM+Ex9Q8ZUzStygNJaMDJB87PuoEd+ww=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlsL4CPWzo4+SR5Na1gb570X2vt2Ge6JWjdpdWW
 tce2HtyVNiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbC+AgAKCRBVnxHm/pHO
 9bawB/0XUQu+lUtdV1rIUEuXFT8P8HpJPXTIJ+lMtA5ObbJqnZbcNl5XR1z2LWsg4tAijmB/svb
 I3SpxZ2wvr1h1LqY1+6vAudNWgCeNI7k5vHMVejmkn21iY9hE3eQAPrZsuvudQW2G5h87RIiw1Z
 /iD5b3ipQE+lgrwOjnijxCsE4vfyzk6R0Klh4bNt9mFQ8oQnlhyQACvkSyN3HUkmg6roBveew0/
 edDLruGdzlnODmh0H8uQ2wjn7w9+YSxGNs7w59JMJ4olsgdjXsJbBj7CKDnj0Ep2O99+2/kfaAT
 oqMgEVCk0Csif2L7leVYwb5FcGiFIZzqHDp7sAt/XaUpN32s
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hello,

This series fixes a longstanding but recently identified issue on Qcom
platforms regarding the use of PCIE_AUX_CLK in PCIe PHY nodes. While trying
to remove the PCIE_GDSC power domain from the PCIe PHY nodes, Johan reported
[1] that he encountered "gcc_pcie_3b_aux_clk status stuck at 'off'" issue on
the X13s while powering up the PCIe PHY without enabling the PCIE_GDSC.

This confirmed that the "gcc_pcie_3b_aux_clk" depends on PCIE_GDSC. But the
name of the clock implies that it is used by the PCIe controller. So I checked
with Qcom internally and confirmed that this clock belongs to the controller,
not PHY.

But on some SoCs, there is a separate PCIE_PHY_AUX_CLK for the PHY to keep the
link stable during the PCIe L1SS state. But due to some reasons, that clock is
powered by PCIE_GDSC.

So to conclude, PCIE_AUX_CLK belongs to the controller and it depends on
PCIE_GDSC, so it should be removed from the PHY nodes. On the other hand,
PCIE_PHY_AUX_CLK belongs to the PHY and it also depends on the PCIE_GDSC. So for
the PHY instances that require this clock, PCIE_GDSC should be added as a
second power domain along with MX domain which is applicable to all PHYs.

This series removes the PCIE_AUX_CLK from PCIe PHY nodes of all SoCs and also
makes the changes to the bindings to reflect the same. I will also submit a
followup series to fix the PHY power domain across all SoCs.

NOTE: I haven't added the Fixes tag on purpose, since the patches are getting
backported by the stable team whenever the tag is present and if both the
binding and dts patches didn't get backported to a release, then it will cause
ABI break.

- Mani

[1] https://lore.kernel.org/lkml/ZY6sh8nlEUyEfL0u@hovoldconsulting.com/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (14):
      dt-bindings: phy: qcom,ipq8074-qmp-pcie: Drop PCIE_AUX_CLK from pcie_phy node
      arm64: dts: qcom: ipq6018: Drop PCIE_AUX_CLK from pcie_phy node
      arm64: dts: qcom: ipq8074: Drop PCIE_AUX_CLK from pcie_phy nodes
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Fix the usage of aux clk
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document missing compatible for SM8350 3x2 PHY
      phy: qcom: qmp-pcie: Add a new compatible for SC7280 SoC
      phy: qcom: qmp-pcie: Add a comment to clarify the use of "aux and "phy_aux" clocks
      arm64: dts: qcom: sc7280: Drop PCIE_AUX_CLK from pcie_phy node
      arm64: dts: qcom: sc8280xp: Drop PCIE_AUX_CLK from pcie_phy nodes
      arm64: dts: qcom: sm8350: Drop PCIE_AUX_CLK from pcie_phy nodes
      arm64: dts: qcom: sm8450: Drop PCIE_AUX_CLK from pcie_phy node
      arm64: dts: qcom: sm8550: Drop PCIE_AUX_CLK from pcie_phy node
      arm64: dts: qcom: sm8650: Drop PCIE_AUX_CLK from pcie_phy node
      arm64: dts: qcom: sa8775p: Drop PCIE_AUX_CLK from pcie_phy nodes

 .../bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml    |  9 +--
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   | 81 ++++++++++++++--------
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  6 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 12 ++--
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 14 ++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  8 +--
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 25 +++----
 arch/arm64/boot/dts/qcom/sm8350.dtsi               | 10 ++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  6 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  6 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |  6 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 13 +++-
 12 files changed, 104 insertions(+), 92 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240122-pcie-aux-clk-fix-094bc77a16ba

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


