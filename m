Return-Path: <linux-kernel+bounces-109943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF0788580A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA8D283029
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387A75BAE4;
	Thu, 21 Mar 2024 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cr2asNFZ"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275AA60264
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019860; cv=none; b=tXd4kpYUbvWK/JF8y+zQpu6t5MswL1Mrdgeh+zgk1Pjj1aG3M5vnbUusQ+a5XD4BDfydnp9fjktnM0DiJTQzqod+AMpT8uEgdJ0iw8NE6dJRA6hPscFWP2gUZvLMx07lW/51x8143Pq4B77N2pggudUSCfBk9Ml5B3P6TiHOmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019860; c=relaxed/simple;
	bh=PLQC9/DBN4qas6Swb53wlQfRwUCpiy5/fglK2ZopRSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+9obmh9buRbrGLibd/XQ5FS+u93HdWoQ+16rRQ8FgR9yurzZuIGmy7lcLflcJ7x64N0j70RvYYjo1lhPDkhsjSf1EaTDQwJxt6oomOZ0EE2VO+tTi3i3XzqLx8fagq/VI8MNIrvWxTtUOkeLqFbLPUNH6l7USUuguPmthCqDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cr2asNFZ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e6738f7535so477867a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711019857; x=1711624657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oPADRZPH7VaQaTGd/DniRVx0j2K+OVom6ZShAasHa0=;
        b=Cr2asNFZgyk9knwjugOyLqP1KDpm4dGdnzmd5dReg4nYLnxW6Pn4nGb5t8OVjxzXIG
         izvQYUWA7V7f/uE4x9uzTD6iPlAnVew0/iz2BTuhKp386th+gWcIK7SUhkzVWV82bphh
         A3gRE1xgztVlsXD0Q5iOyVCalfps4RJZ43uPwp2KKMucVgKNE8UsZeaypoggQo1pfruw
         FxzparCgvvbTwT3Ins7POxHQRcvCw4A5jL3nECRJMrxrrAZd8PE/b68gYsCItHz/M9Hx
         UBmQRVEv7kMeiaCdcFuqhUEY3LQl2Luzqvty7NXdrTk/sMvhb1W55JkOWeet+3DRw8of
         lo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711019857; x=1711624657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oPADRZPH7VaQaTGd/DniRVx0j2K+OVom6ZShAasHa0=;
        b=D85mjFmm3dMC/uYoUqOGJIs2z7e6ObKHR5w5htJCTKYItQxjIMKGNhqu5WTxJ3MxhQ
         slkp0J52Xs8/2m6cyi5bsCrN3f9riogoiL56Njqs0Pb660369y9gLAbkYAB7MxhgRQlO
         FXNAdr2AtcwSWPSXpioY9qYao/OMix6gcEqTC9KB1FtgFWTXjOxVweaKpSPayxiR/L5e
         gi9HL73nTEMk72dG0u2vg6obcqVQNW5Ovq3/TtvbnkqKmsC4q8FtCfKxT4PL1wdxxh8+
         1BHIfe2uRa3Civ93MxNSrmE17Bw6bjo/1uLqP8kO3GFVC+ObUrWctwHWAmd792HtPKDc
         F55Q==
X-Forwarded-Encrypted: i=1; AJvYcCVW7oS09Qo3BUJJRQYUSt6LflTjRYZBiHL8PRsv+erybUyF1j1ro6AbVilAXpsrbjXCiluhsDQSlL6TXrZK5+tr/l0pmS41UuJGnyfd
X-Gm-Message-State: AOJu0YxaIO8McGmi2SSpyTSwQuoFdDFfa5EHTD7tR96kJjvDlptqnQR/
	aNuPXfdMn+rAC0QtMW31Hrc7/D3bz46Np0ka2cmX8XunFYMUXi0KBHHXRjsiCQ==
X-Google-Smtp-Source: AGHT+IE07oiu4SO9weHoLK6eKb5EjV9HylwtPhlLRbiuauPEe/6YchifO/LjzBBDH9tUk6cJLTeTrg==
X-Received: by 2002:a05:6870:5251:b0:222:7217:f919 with SMTP id o17-20020a056870525100b002227217f919mr1893421oai.8.1711019857096;
        Thu, 21 Mar 2024 04:17:37 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:17:36 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:34 +0530
Subject: [PATCH v2 14/21] arm64: dts: qcom: msm8996: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-14-1eb790c53e43@linaro.org>
References: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
In-Reply-To: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=PLQC9/DBN4qas6Swb53wlQfRwUCpiy5/fglK2ZopRSk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcMl4yRW3+DajP+FD3q/IIE57Hp2fkCgYRjO
 RdkjVsVkg6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXDAAKCRBVnxHm/pHO
 9SKtCACJ0kAwZbME+l55yyPNEieKF6u05dINI35SrfhuNxgllxbQiKL+pRm3ZB2J2o9MwKHOxw5
 8K9XmQzjkEz29xO9EaeQ5RIKjl/+Tx/Cc1uakEBizJujQ0636cOdE7ihu0bLxC08egvPUObHcwN
 Twef4fPxKMWQGcG1MhdQWXgIGJ2xYVzVPOYr3UVw4f9twFr9OWB8XNSMzKkqJisNeIEm1Dnpn2u
 eUQJ+jy3RqhIcy/QMRnzhocxE3j+4LjYyUTrm2A3CT9UHsuBHQuKM0X+Hlifk8QOcBSSFgRugUo
 LNtxtJPamoCFIUqoTuzCf1aMkvpDwOx0z4NAPLrYKB+IeuL3
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 1601e46549e7..8d2cb6f41095 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1929,6 +1929,16 @@ pcie0: pcie@600000 {
 						"cfg",
 						"bus_master",
 						"bus_slave";
+
+				pcie@0 {
+					device_type = "pci";
+					reg = <0x0 0x0 0x0 0x0 0x0>;
+					bus-range = <0x01 0xff>;
+
+					#address-cells = <3>;
+					#size-cells = <2>;
+					ranges;
+				};
 			};
 
 			pcie1: pcie@608000 {
@@ -1982,6 +1992,16 @@ pcie1: pcie@608000 {
 						"cfg",
 						"bus_master",
 						"bus_slave";
+
+				pcie@0 {
+					device_type = "pci";
+					reg = <0x0 0x0 0x0 0x0 0x0>;
+					bus-range = <0x01 0xff>;
+
+					#address-cells = <3>;
+					#size-cells = <2>;
+					ranges;
+				};
 			};
 
 			pcie2: pcie@610000 {
@@ -2032,6 +2052,16 @@ pcie2: pcie@610000 {
 						"cfg",
 						"bus_master",
 						"bus_slave";
+
+				pcie@0 {
+					device_type = "pci";
+					reg = <0x0 0x0 0x0 0x0 0x0>;
+					bus-range = <0x01 0xff>;
+
+					#address-cells = <3>;
+					#size-cells = <2>;
+					ranges;
+				};
 			};
 		};
 

-- 
2.25.1


