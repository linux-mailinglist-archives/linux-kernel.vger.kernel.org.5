Return-Path: <linux-kernel+bounces-36568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F277B83A32C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5411F25B87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE8318659;
	Wed, 24 Jan 2024 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BefsVD9Q"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A41865A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081873; cv=none; b=EHBibgwkQjhJ/d9Fo56Zn8ALSp4XS6uRnbFSb4Om7+0z7/AFVr0lZSnFq/4kXzts+70rA8khpYH3/uCt/yKhNzMh0XoOFXnhfnCDkEjmi+hioDBRASXhgrhVmK8kSRpkLLkldnQSPVJZC6su76ep49a+DoBaEhDQSkbJ/triGHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081873; c=relaxed/simple;
	bh=xR8wvtP+QITH8T8kLA9WFdRX9QC0BEnzA8VfMLDLOeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ji4ftv7uT6IP/rqvqxD3x6QvRfg5wtVVMvF43K8c7xcUkydP9wh3Y88YLilV556E4Oo+aKMbF+8GwABbq3HIIfWC3oW0tqCHlgZfK0mTvnQuD7C0luUrUQcENk8Pbxfj3T7jT7vpXzwYDlD4c0K5/aWGSYobmyKRt/YAMLFaNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BefsVD9Q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d750660a0aso15089365ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706081871; x=1706686671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/+eeHXYW9j18ErdmeKAUblHZYPts3oUBFN9HRjn0+o=;
        b=BefsVD9Q9hn5K6N0kUYSsaH/Hpn3BTvQNweDIw3Jw4n5P5HrAS8bXD1CUZT19iO4BN
         DdqiA5aC2/G3nxGSP0y5co17/rByAgFPyD6GErKuVybPTQYh/FzaPJ2zh4/jBQZCvxD8
         Y/NGIEO47X5oQkY/kxplWxJbMgIWpwh6KPwrSA5Da2qSKv8ncEt+2YhEJEeBzMOmWd+6
         v3DjIZoXkdlWEvghUM7q8tH0IWC9bY9zvjJZH4Kf8B1Fj35yZTkMDVPVmfOLE2jsRSwM
         yd8TRhnVIx7L1ZOcnJSnkkbmaSVAiScRArbxtPlr21NgWUS7XRiVah/mQwLyhUNBqlTu
         zQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081871; x=1706686671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/+eeHXYW9j18ErdmeKAUblHZYPts3oUBFN9HRjn0+o=;
        b=MsRFYyLnfanVYg3auJxjwVXg1o0fB10rUexba0upWhGclLMuO/71x5lJKFriqEOwTi
         54ZeQ0iYw/1tfxOg8lPINON9553CvsogpFaNAAiz4z1BPYgeCwj5clHkJzXLC2IQ6XOF
         +rAmhQDCCYPVed7YpNUusxtXAKEVXO9v2gyb66He6Azy8wjGYXG82CdhwhchMeMChMDz
         AhvT6oLQThxLvvmtfJk2p8ueCM5DgHZmTPNbgGv96nIk6Zm61M6uoJL5ZCrv/FwFOw4D
         /y5xyKrjAQuO3yKPp4VwfHlzXLDA87KMio80i8DXUBhdw7JUQUW+lkZhhXHZbjkxDUfI
         jyeA==
X-Gm-Message-State: AOJu0Yww0AguQH/1xA5D35IE239fuVuUTbofpdts0k4V3nTZ4tSEX6G0
	f9U3e6WUV29Od1qoz1VDotEYnyPDbR5L3g6uulwvsHTcY3UhvqDbznQmgvVi8g==
X-Google-Smtp-Source: AGHT+IGj8U0OzY/bykwYZTLT4LfvcdMXaEwp0Y2P7Vpl0XFVBweFCBMR4mKw+7UkPyjrZCQ91xNUoA==
X-Received: by 2002:a17:902:f687:b0:1d7:4c1a:2058 with SMTP id l7-20020a170902f68700b001d74c1a2058mr253915plg.105.1706081871600;
        Tue, 23 Jan 2024 23:37:51 -0800 (PST)
Received: from [127.0.1.1] ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001d726d9f591sm7386982plr.196.2024.01.23.23.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:37:51 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 24 Jan 2024 13:06:41 +0530
Subject: [PATCH 13/14] arm64: dts: qcom: sm8650: Drop PCIE_AUX_CLK from
 pcie_phy node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-pcie-aux-clk-fix-v1-13-d8a4852b6ba6@linaro.org>
References: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
In-Reply-To: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=xR8wvtP+QITH8T8kLA9WFdRX9QC0BEnzA8VfMLDLOeM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlsL4F9I2jnHfAODN1h6LhID1P5M4ffX5SDTNOK
 tmbdlVDGn2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbC+BQAKCRBVnxHm/pHO
 9e9HB/9IOUcSo3ViZRQJMCk/7G0FlXlhNFCiC5rUFKMDKuWujGHro13gDGJjTczje/BKnWxULGQ
 xvxbYT108gLh5mEcp90g5HVfToMp1AArsS3Fqnai8z0TkKnd+2dfxOFFow35x16YJnZmlE502Ae
 gw/DKa8Yi3+H7Pogj6id8NcfMHlRwkwwzBE6psr1YYv4uIIdIlKAqJvtav8irLGgRCHnD+IfL2L
 wYgrv/PZB13YCBXxVS2lSTYEgTY9HHM2SpVutjUixxncsHPi+v+Ic0I6Wu5T8Y+f2yaBax3w9Ll
 E80RfnrBnVFBA/a+DyEiXU1+AXBZ1W0D07uUrZBUR2iYa8GH
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

PCIe PHY hw doesn't require PCIE_AUX_CLK for functioning. This clock is
only required by the PCIe controller. Hence drop it from pcie_phy node.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 2df77123a8c7..b31e60599891 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2276,13 +2276,11 @@ pcie0_phy: phy@1c06000 {
 			compatible = "qcom,sm8650-qmp-gen3x2-pcie-phy";
 			reg = <0 0x01c06000 0 0x2000>;
 
-			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
-				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+			clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
 				 <&tcsr TCSR_PCIE_0_CLKREF_EN>,
 				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>,
 				 <&gcc GCC_PCIE_0_PIPE_CLK>;
-			clock-names = "aux",
-				      "cfg_ahb",
+			clock-names = "cfg_ahb",
 				      "ref",
 				      "rchng",
 				      "pipe";

-- 
2.25.1


