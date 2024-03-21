Return-Path: <linux-kernel+bounces-109942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10F7885807
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFB128303F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918555FDDB;
	Thu, 21 Mar 2024 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTj+vDnq"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C95FDD5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019851; cv=none; b=IsZ3gr4j7dtfDgFsZt4lG4TuojNPjGJ+0XhzYOfhkTLCUZlyVsHur45XWNXQHKNRs8/u1w2kHdlH+/xhtoy8e97jn/dfIHik8QQYTDMogP9slqKm2Xw3yV8S1w2i8ZOtssvGMu+ZEQFpOmkn4HItsfP8F3F5TYFdcvoFfqNYnN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019851; c=relaxed/simple;
	bh=mSUh4v/RL+IdcdrUbUoaHaEmfRRTCNfxUzTm6/jvZZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lGQXxuLCVp1YhGQc38gy14G3YNi6WxXtMj6ld2luc4Mo+dXvJpisezWf6h3Ep8DkM1W8USL47tuM81AP1ULLh44hi1perfIplCAjcpiTFtR6kWcSF3EfiawvKjnEPGX43htPQCDE+gAqg4+CRhT42l773EPBLvcWugU1NOzkS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eTj+vDnq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6cadfffdbso758184b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711019849; x=1711624649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEOq/9uGaHs+ORFcTWIE8PonAqZ/+6MtiDjpCwOLP68=;
        b=eTj+vDnqcfyxJazD3VvBXOZ4WzeJhszyhGVUdYhKsQoicQuJtbxcUqhCcNq+gFyW9Y
         Azwu9HKtz5GxvMJv7/031xCzGjoTjT0CL7hDX12YqvXYZ/Kiq0ehjz8YKn66CLVpn6hD
         vSdZOCf7JJKkDGTCRwoF7I8jWbU5n4eGcI6rb108cpj33uRil+cun+hdHuVaG3bXNk3Y
         kauccxubZmg+AsVzZOBHFr3zlmJqQwVABHSmPa+VBX57xY/yyXrF+yf4g1H9ksMAUiI+
         862cf65U11hR3BJ0DFpv0Qt6c6qDZKER7YeSVkltva0Ifn8rRwOXFOTVvzk5zzovvSsd
         1SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711019849; x=1711624649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEOq/9uGaHs+ORFcTWIE8PonAqZ/+6MtiDjpCwOLP68=;
        b=k9xU/ZuDaFzJ3/Cv6tTVsFE7pkQ0YM61bRRh3qViFXjdTRaRuwY/VU0M7k2TQiT5DC
         Da7uAEj9Dhi8mvm8ow07FgqoaWQHbswn/ZnkGKCZf3jfIBDQrYGiYTyI422KO5iiW/jl
         vIE3L2R/iHPwIpsgkraxY2HfLQ4Ho0xLl13MSnpyt1iXz/pbd9eX46dm10TtEAqKUEo8
         RV+iunRLQN2kfN5QhC0olCmb4QqsOV87jTT+J4Y4kw4LTtYsdTtTqPCpdbPs32Ok7kYs
         Qgx65j1zmIwN8htWNSWkwRLTgaRIPIryNyjX/3jyr3oeDohXAwVCG3FXGJvZMWqJkpNh
         PfdA==
X-Forwarded-Encrypted: i=1; AJvYcCVPWTN7mj6BLH3sV6FKI6LFoPFIPNnh8sWx8klYHUpG73W8ZiqILdwhPmF/rPdpAoG2C5e5w2Tr3SFhdzDjttZIhbGJFqyPD9hVAgEf
X-Gm-Message-State: AOJu0Yx83veYq0Qc0iLXlpcuXKz6B84GGZ3nNKH7B8N4uUs9dQsxw9eY
	GOhrRPHsmh7H4CuCCrIIdFXBDZ9ygpGdTXNM54hmqvzvq58SnHX3lnLGPaxlMw==
X-Google-Smtp-Source: AGHT+IGhrgPS65VX+UybTahtlEb+U5xWUT3BsBlb8cPBVFosXH0JpTMWNJ7+QB8rs/pAj8LyeDMPfQ==
X-Received: by 2002:a05:6a00:6005:b0:6ea:7b38:a0fb with SMTP id fo5-20020a056a00600500b006ea7b38a0fbmr197330pfb.5.1711019848642;
        Thu, 21 Mar 2024 04:17:28 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:17:28 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:32 +0530
Subject: [PATCH v2 12/21] arm64: dts: qcom: qcs404: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-12-1eb790c53e43@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=860;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=mSUh4v/RL+IdcdrUbUoaHaEmfRRTCNfxUzTm6/jvZZY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcMPwjDgcilCW9SfEEA5N8VeskzXhjNJyVH0
 EpmyskkUUiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXDAAKCRBVnxHm/pHO
 9YSYCACaW6BUhqx6O5wM3sKih7zJxA6F5kgvCYnX1NqLN3ek3PJt+GOBSxhtUk1jTwQIkC2hiL5
 u5ymkY/HKbZkO/MSfGMNyb45QezG1wUInpRrbwreZ2EVPexgaCpXJRV1ZqQetVbdHcCEOuxDvM1
 E9r0FmsufXiCeVDg7h18nuOuftiiK5xms0nbvc5mdfBk36zFgR4sNSmJ+qz2F1QlHB/7xj665Fd
 xZRvXgRZjQ3gdHyb7xlwPMM0JDskZ4xTt1ffw7/Um1LRIvfnSkGRCoHDeuuqh4l1ZLo3ESTqOHI
 PAsMtHtMW6m9Xwa6Wo5Ntss7Gfywv9yGZgHAaOfxLRHbBiYH
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index a05d0234f7fc..ac451f378056 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1516,6 +1516,16 @@ pcie: pcie@10000000 {
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
 	};
 

-- 
2.25.1


