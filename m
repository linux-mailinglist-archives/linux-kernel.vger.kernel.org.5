Return-Path: <linux-kernel+bounces-109946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C50885813
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0171F22091
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B45FB86;
	Thu, 21 Mar 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbqy8Mva"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943B5823A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019879; cv=none; b=lPXK3k3Iem4sgtrbs6Gt/HqgjM8nwWUOfLULl3HJdgwRLNp5bkN5qcfrDXP1fSOOcS2ik6DX9oxRB49X3+63SGHuZ2djFka1WMeUuGwwt67sX9wKeLE3u0uBLKs7VKV0laA8J05eyAvPYsmXDlDAA98SkLGEEOHfOSZfVimYjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019879; c=relaxed/simple;
	bh=txKBxasirrzr4D0MifccwdFxGLZgzc3driHUspG/zXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtTmpPuJSTAlRSo+TcAnjxluX8VdUoRY16hRiuDOH4xs3L91ql0ipzAgtsdLfRA8f0YUgGSMa/Koqr6E2J3s1iK+EdP7Y8Nfi4GFgG2UtuFZGIEEET4SrkawlNpgYdziZo916TxgzfHMwEoJAaa6Caw9jnJlDsKvGY0b24PumCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sbqy8Mva; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6c0098328so645620b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711019878; x=1711624678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwWQb2wVJ/yqhRj+ZXhsK7LleZ0QdLeCzsPtWZNhY0I=;
        b=sbqy8MvaBAzfXNmkD3Qwab8XHLBDLz2LP8YSHnOfVswlipAQchmlxyrDA9RGKCqrEN
         YpYhlOV1PJTg8rF10PGEec+AAU2T5E8NY/BXA30jL453Qz0oTiure1Vum7kSgJPFOhOu
         abb3o8y+NQ5L+Ia8v4SYrsCgZwu6TEIBtsLpDWwTB3Rg0H4ak46EWIMDWpdyWAhO3gMk
         6SlKiwCtwvKdNz9B4AcSCFPZObpcu428E2Ngs8HwPCqPYD665czwbe1IWnshe78xz93J
         2anT8APkCcrdn2SG4jWflXPgquPd+FTYVk6PxGnslnDw93C0TlBoziCGWlf8riS5a2b5
         a1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711019878; x=1711624678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwWQb2wVJ/yqhRj+ZXhsK7LleZ0QdLeCzsPtWZNhY0I=;
        b=eCushOPKbz6roEYeUV6QfUfBuPoO5F6h5mlVd3JVm9GJV5PF5oCi0g3oTFV1Yc5uof
         LCg/Fq1eemxU6/hahEaRjt0qh7rDuwtWUpoA4aj2TWXNXLw4CS7HE2c4xe/duT6wiR20
         i1D4Zci+4fBQ4ac6pAZfLn6PTJPMTqXdAhA/mXag37/7Jm5yQTgIIOZ0XY8+YWv147HT
         8pw3jTN6irS78kbhl2FruYPPDpirdYfMe35He0RiosOWdlEJ5Bh3Hyv6VLecxW5FbCUm
         Px/U9KeVDO0ptTfvQ0cjVdqVH9TORoX3/rTGQzYm3qLfHqrXBwySFFcqtRnc8K5kv27V
         f35w==
X-Forwarded-Encrypted: i=1; AJvYcCVyevZRI6njIFUzdHoVl3pFQ3JMFDPOYg93yydCutV9Pe6PvnL4XEXQ1zs6hFeJ6qVxJWJniJD2mHKkpiJ6fH06oc3y1h2TXWsJWTcK
X-Gm-Message-State: AOJu0YyzfBIPuOmthFMkJt1Ta+goSmDMd5wm9rmAYsa/3BoR4pRVZfke
	chRMtQqauP89Tm8FPjUZP8lJp5gN2dZrb+fuuCOuO7FgDQB44/qjyF/+GpJciA==
X-Google-Smtp-Source: AGHT+IFkiC8jFoHRqNloR/yzbipGq6Hi2spXDBAHQFM0t54XlfpF6Eenc4b6HhszrxEbJiCZ3my//Q==
X-Received: by 2002:a05:6a00:8685:b0:6e8:5b99:8f64 with SMTP id hh5-20020a056a00868500b006e85b998f64mr3099663pfb.8.1711019877712;
        Thu, 21 Mar 2024 04:17:57 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:17:57 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:39 +0530
Subject: [PATCH v2 19/21] ARM: dts: qcom: apq8064: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-19-1eb790c53e43@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=955;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=txKBxasirrzr4D0MifccwdFxGLZgzc3driHUspG/zXE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcNTKMazMiuUsD2/RfXWQCyqIAQ+vyqHa8/K
 veBvEwYid2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXDQAKCRBVnxHm/pHO
 9by1B/9W0lAn32YKBWoq2n81C3x/sYmpGXZ8X3TkQmijLwLztRg8NR+UcSAyvO4WKmb0hau72is
 UE+YeRoo99JTfgxs/vMohkKTbTzansYr2f0thOSaIcvDUECZnAwN2DA0YTrlRDPdww5mnW4PlyJ
 mSCrO1YmBWxlISUIZo5Nuvq94ianlpatjXxQdkPCMZCnO9Tiyks/SNUhG7kIIf1NoZOrIO1m07n
 LDpiPnW97kIwyTGRX6u1lrufcNnSgRstJJx5a5Y3P1BoJvEF4OxwQYcbxw/We2pqpwTp43Jju0P
 6zm8hmI6UQ27REOlVGVOSW6+DdTTttegMwA6suiLrt0zbTE5
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 9a5ba978775a..dbe0ae2c8770 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -1334,6 +1334,16 @@ pcie: pcie@1b500000 {
 				 <&gcc PCIE_PHY_RESET>;
 			reset-names = "axi", "ahb", "por", "pci", "phy";
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
 
 		hdmi: hdmi-tx@4a00000 {

-- 
2.25.1


