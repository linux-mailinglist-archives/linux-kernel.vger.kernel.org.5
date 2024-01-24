Return-Path: <linux-kernel+bounces-36557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1DA83A30B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80541284438
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CED8175A1;
	Wed, 24 Jan 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQgse18S"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA51759F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081821; cv=none; b=bvD555D920nT7VfOlqSBvmk1HN7hid4fLK40/40xTHcFh4lMqpdYeFnEFghem8yoA9rv0GHTH9DIP6vRMxV43iNtS62cmRrozuqwRTZtgkYX3K4GXgIy/6hfOlattG/Wttz3nfc9Pb51xVnU6lRM6ya/i8HcTUdhjI/7p0b9UvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081821; c=relaxed/simple;
	bh=tYw91gWuWNXo6BYZKlOtQvxOlV3OGyDBw5hpVkCGZg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mpk4Y0Mf9uYV9VW1Tz4ZsKW5TTnkGdRaxCi9+bDCB7tzYMmTbohqVlBNh7M77h56mGI3wTLVDa6QOfrCBYdgg2IBFsDHloQWhDFAwAXBXcTyQZb9SBbZP+BO93BqdpmOLuDJj2kCD8MYT3hUEnwAD5Bg2JBg0/5EgZ7BcDCqpEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YQgse18S; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d746ce7d13so25123655ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706081819; x=1706686619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBFfSaJckS21En/NRtO5B8XnRhjsR2n6FJYjapBTDSs=;
        b=YQgse18S5N6YJm6QLhjb0Kl8+md7loIjWvjN+3ee4MRTn8HJv4+jyTvTe37+jmpJbc
         W/gRdnSUTq/c3iYCx6a9JJ4efuXMf79KrTylvnz6Zax9/1c0fPrctKtFhDBktFyxUxAm
         O815fCvZ8UUP3SYSuAjN2OPxAMrlLDXubfg+TrXIcCKeUYXJ8dGEovl09GkkDCWlYCsN
         syG70Tv0C7jp4V6OpFMZiZLT0rXh81sMyWmUiOnO98gC4bXZ6+QsYyz99V11OpsNjlsb
         y36IaF5ddkDBeQNKSsz8IqnwZe0QJLl7lwvrbFp8G74fPLz1hH+pqS5oJ55Df3MCDaXC
         9YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081819; x=1706686619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBFfSaJckS21En/NRtO5B8XnRhjsR2n6FJYjapBTDSs=;
        b=nWXyH4Vyq6D/ll0ZsWRS9al6YIbEcpf6EX5F5UQsny/uRuMn2uTgCtdhoKMnowxnvN
         mxUEBwotmvkHB2arUoFqjOanrIbCBufI64qT6tAJh8vJNdcdNPsIcGDwDWruXrzN4quR
         Bg+kLCFwWmS50h38Ik6JroNpXIhz1F91Sgvq4OAsC+nWfLHlCuCbFi7FRWmvC9tLaSeQ
         4p2ZhboJqyX8dsjo6WaCnIzUEcODxgv/lUN5br5yrkoj1jn8T4Zc14OFMd7o+Z8ddbKD
         5rKyBvBq4/7FFrOIqOMrB2a5IU2ip+zMDT6LG0AdAEwlCNX7LCeVYC0+AuS5nQeXs0Zb
         kbUw==
X-Gm-Message-State: AOJu0Ywu7trSyk8OSvep/fLxMZJ+g8M8FmxalWjgELz0y9ra8DNMwF9Z
	GhLkZEEgF2opVZoLxqY9U93A8PX6qx5jxTcY7GrKtvfSh3hCVF+J//VH6IbK+w==
X-Google-Smtp-Source: AGHT+IE/wIYSrBooEZbLDcaYsE02CGekV66QkvsrVyx5eIErSHKRtYDq10wSgZoYRynCa5FasB0XrA==
X-Received: by 2002:a17:902:b086:b0:1d7:450c:be68 with SMTP id p6-20020a170902b08600b001d7450cbe68mr420926plr.66.1706081819311;
        Tue, 23 Jan 2024 23:36:59 -0800 (PST)
Received: from [127.0.1.1] ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001d726d9f591sm7386982plr.196.2024.01.23.23.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:36:58 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 24 Jan 2024 13:06:31 +0530
Subject: [PATCH 03/14] arm64: dts: qcom: ipq8074: Drop PCIE_AUX_CLK from
 pcie_phy nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-pcie-aux-clk-fix-v1-3-d8a4852b6ba6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1432;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=tYw91gWuWNXo6BYZKlOtQvxOlV3OGyDBw5hpVkCGZg4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlsL4D9c6rL/7BFeef/cHzRgNKqQG03Iu+2lSju
 AQE1U2qnCKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbC+AwAKCRBVnxHm/pHO
 9VhrB/wP2eETp8NYOX5qto7ovhKQ2P4/3bYol1vt6g4fztAd3bHWpS9MUKd8KRh3dClCjYyXF9a
 apf4vWrS7pBAcxfIuzNWKyMkGJXN2o9LaIUgxayNJh5NpKHQx6ayHxd5fPlfOc/LMgLV8Fxodys
 m4oB3HB5yJZGlIlI3gNFKGVej//Rl1/QlkmKIiTQgQGgQwBLOGPrOssNn5QQ77PKahrqwMmr48C
 iBeoWdT/2cIhJwLBlknzbJzv+SL6LoPOIATBDo8PXmens/WyDVPzR+djCAU2FMsRcwN9sCgo4lR
 jx1HO0hJ4jMe+fAcjZ/XabH6wlUWpH1A37pQNWQpLqZgkDX7
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

PCIe PHY hw doesn't require PCIE_AUX_CLK for functioning. This clock is
only required by the PCIe controller. Hence drop it from pcie_phy nodes.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index cf295bed3299..6ae6833e8969 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -201,11 +201,9 @@ pcie_qmp0: phy@84000 {
 			compatible = "qcom,ipq8074-qmp-gen3-pcie-phy";
 			reg = <0x00084000 0x1000>;
 
-			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
-				 <&gcc GCC_PCIE0_AHB_CLK>,
+			clocks = <&gcc GCC_PCIE0_AHB_CLK>,
 				 <&gcc GCC_PCIE0_PIPE_CLK>;
-			clock-names = "aux",
-				      "cfg_ahb",
+			clock-names = "cfg_ahb",
 				      "pipe";
 
 			clock-output-names = "pcie20_phy0_pipe_clk";
@@ -224,11 +222,9 @@ pcie_qmp1: phy@8e000 {
 			compatible = "qcom,ipq8074-qmp-pcie-phy";
 			reg = <0x0008e000 0x1000>;
 
-			clocks = <&gcc GCC_PCIE1_AUX_CLK>,
-				 <&gcc GCC_PCIE1_AHB_CLK>,
+			clocks = <&gcc GCC_PCIE1_AHB_CLK>,
 				 <&gcc GCC_PCIE1_PIPE_CLK>;
-			clock-names = "aux",
-				      "cfg_ahb",
+			clock-names = "cfg_ahb",
 				      "pipe";
 
 			clock-output-names = "pcie20_phy1_pipe_clk";

-- 
2.25.1


