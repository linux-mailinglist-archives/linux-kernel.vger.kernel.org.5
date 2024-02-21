Return-Path: <linux-kernel+bounces-74018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D548285CEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E5E1F22149
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A8C3C087;
	Wed, 21 Feb 2024 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gif9eeOe"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC933BB22
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486945; cv=none; b=TQqibfh/TYBqG6FOIILl+7ogMFbB3hP2wfUv2EnVYgp1SwLWlCAadlqDQ3wOBIZyo8Plx4hMhtHv2YXPK3BOp4ePmpF1Y5JmT43aqIjmuvQ9ylTwjijbQgfbKkrVslsfWwQoDoVwyw1WIQaeRuHyP36+kKysQHW5t8jXaGxieo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486945; c=relaxed/simple;
	bh=KbA9G9eXOsWwtGSkFU+soq1QMhVPjhBtiPB+o5awvqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3BpB16RO+ttDyBdVf+kz+Ge3ZuldnGHgfYaSb0Iszc6DGZndfzvDjxw5Yz1bXXFw0b1ufyenWBN5k8mQCWst2j+QPvb6xnl4A+NyuMIppH3S1JaVUeqe9XWc9GXQn3Tzg3YlEf9ehrKSAD4z3adryrfbc43OrO6UViPwrJgzpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gif9eeOe; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c0a36077a5so3807438b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708486942; x=1709091742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlnBSSjOzn7sFPoNZS7Y/ly3BdTtFkH+6wgg++BCcqU=;
        b=gif9eeOe4yOxhlkczG+OXyNKDbC65ZkR2aZXbQjyTn43VzkaIUilBPJHCr8yXSK/jd
         aKRMu1LdYz4c12v52tdkVIecjyYnYDZxGxOs5FNiB3IUD3n+zD2jPDJT4q5vZrPB9tem
         46vkgs+tBkCxo7WYaiWac+3KQ0Jw8M/I0tJzSUe7aCM1eYWJTLke1HsHp0bI7TuAFLS4
         Tv6OlWruDTnGImmUkLY2G8R+o9EB55sGcLv0M+9WUKX5uMt4g0vIM7+pl6uqc6ayO1ax
         2/NEUZtGBd7NMmpBCEG7M31GmTzCZs7MxpCxVHznNEnvWtHTUY1ArMwb+wHciJu33PIt
         0XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486942; x=1709091742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlnBSSjOzn7sFPoNZS7Y/ly3BdTtFkH+6wgg++BCcqU=;
        b=BkkUzdztGFGG8TXXJrMr0C76ImNII9jWn1Qd8Z7Mb+5GXWVHZm4nA10EIt28DyFhr3
         5un0PvDF8UaofvHCNosYJ55yPEWDjtEdB1eBXAPjn0zjgxRsYiDco+kGrt+vodY1kc/7
         aplUOE2KOe9X/Jzge87e2lR5F1lKsn9XreFV/GLDNifFTBVVA4LABnFcVjm6x4VxbRsB
         byvDojWRVhkeSJv/btmkeo9EU2BGPCsVJtEzQRKPIMZxQZjNniwVOGNzF+jclamcUmXI
         +BNcwiU93mMps68KKd6DqjtjX1FMbzNJzvNNBcmmu6y/4Y4Ax0wmBIazO/n8pkomLWLC
         WJpg==
X-Forwarded-Encrypted: i=1; AJvYcCXSLufMOxtX0rsFjajDPxvLo2hX3FM1gAORMM88RqdePTMLO1weI5AczRTgXCubKwlRtZminTA0osCp4jUJFVKLk9ZLguhX3w8h9V2m
X-Gm-Message-State: AOJu0YxgQBkVqeLHJojaedkhR/c2fi3k/Y0nzakdjRSAeGjZPwaTeh5C
	0XUigEczZXe8w1/OUIf9jvfunFdXqQk8682qziRcacA3oEcwGpQ0AZHaY2M/E3Wc+IVxMHUIVss
	=
X-Google-Smtp-Source: AGHT+IFGy9uyH0UHM8kmzNOVRUAoTGR03tuxjmovgcToFVCyJ56SiFsbVXtCTGQCx6upDQ8QhNNbFQ==
X-Received: by 2002:a05:6808:1891:b0:3c1:4b14:f684 with SMTP id bi17-20020a056808189100b003c14b14f684mr14258400oib.1.1708486942506;
        Tue, 20 Feb 2024 19:42:22 -0800 (PST)
Received: from [127.0.1.1] ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm4436231pfv.132.2024.02.20.19.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 19:42:21 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 21 Feb 2024 09:11:50 +0530
Subject: [PATCH 04/21] arm64: dts: qcom: sm8350: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-pcie-qcom-bridge-dts-v1-4-6c6df0f9450d@linaro.org>
References: <20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org>
In-Reply-To: <20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=KbA9G9eXOsWwtGSkFU+soq1QMhVPjhBtiPB+o5awvqI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl1XEFe9IDQrVK9X1nik2kdFoOPmU5NjchVPFBr
 aeJu7rRqcuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdVxBQAKCRBVnxHm/pHO
 9RFaB/985Jm35diurGxgH7nuWLG+eGn2TdW2OQDfzyO6sSyhkBmcRccIr48Gl45KSYHmZbFHPOy
 swcOm2rfA847VUmeKY6JsvLMSpfuJAumvDBS/jru/hqcav1i/XRzKTGibkVdIW1LNPZY7Ra7XDK
 /im/EpFhPLLobtvQHWrFh/yLP3z90yUrmcgTMg3V1KDdDawJKaEOrNMoFIQR9dXdPGyFRPjxCQ3
 G5fDS2N8QR/6aWAS+Duq+PEV+DzI7Aee2151CztOUERCAqgMpUEHPeoPA+Pt+SCSJbAM69Rh/57
 KcpbcYOkvy17dpxbi1xQmJ7TbgqG7hvx8WwwJnIxYIeg07CN
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index e78c83a897c2..a2779c1bb4c1 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1566,6 +1566,16 @@ pcie0: pcie@1c00000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie0_phy: phy@1c06000 {
@@ -1649,6 +1659,16 @@ pcie1: pcie@1c08000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie1_phy: phy@1c0e000 {

-- 
2.25.1


