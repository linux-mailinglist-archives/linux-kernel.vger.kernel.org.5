Return-Path: <linux-kernel+bounces-74034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B35B85CF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A751B242F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E31405F7;
	Wed, 21 Feb 2024 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLgsI6Rc"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2905E3FE52
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486996; cv=none; b=HT38zq5S/o5JLlFG9n+BH9TDmY9Vge8vBxokrjw+sZLUliXEV4AI7sDF7Kbh0bUfzytANXu2hQPFZnQb5pOPmUkX1Nifo7R83ItiAlWj7aheNN39Vj8MtB38RLs8wQE0o9Rx79X+RoH3KMrus/hlGtVWL6v4fv12kcXtG1Z71/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486996; c=relaxed/simple;
	bh=lhVEinjxnZPoqgOpMpaEnfW2yI2K5/5KqOnNHUJ+XEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVMXLZVBGW+4ubK+9RbrCQ2qSdYMQK7LGSIBk0RN/u/RkHVAZLaPxLWJmGBBbBbW/1hBZm1fkNeT4uwT7noMbTkISYA/8U78NTtl2DAEFTQpc0lNgNHnTGQsO30OjLM3x4hmp9p7Y9ERf1ca18y4fRAVv2t2l7xz8BqGjcmin50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eLgsI6Rc; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c15d67b83cso1078968b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708486994; x=1709091794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OwRPjQVKJSdk/uXo3xCapKCkUL4vtjjUZevC0N1dpY=;
        b=eLgsI6Rc71706HXwhtGnwC0m7CGHe0vDB9GdcEIdAytuukLVmJBqH2WHjSZj/4foaC
         V+PK3he/efir/rrHBIX/0qzRuUct6g0em3FX3mZ5J3U7bfDqWSxvzOEGYxI75FIC2Rh4
         ty5scvzTePMjceEJ1NWsKwMuSAqUJIU36b4+NS5y+4e4lkQe/cMeBRcx7kg61HX2+9xB
         K3aHeQFS9G/sp5ST+K4lTBGcD7OQXQ9dQLNovtcOleXH5ovmE7IjWc2WLAMdi/yV7Mnr
         tWxUOA9c4SL0K43pO4OIGDepsFOc1g6ejfEAQlP3C6nxlTC35aII9g38ybUMwqEprYwF
         WBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486994; x=1709091794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OwRPjQVKJSdk/uXo3xCapKCkUL4vtjjUZevC0N1dpY=;
        b=qHQN1ud68ORMBrN7SJB7IgrvuPzu7JiugaMwv/4dwnVXwELOalBfcotolJmbLdaRup
         KmEdWc6LuuPO57Kw1I24dxsrsYp9U/CaO9cq31vPUDNxVgcs8PL3+L5URne9HmkOKQYJ
         aEHCeVORuBj82eAWiFZmZ/B00nVvizV2sSJwkNSfUhin9UGE+0+bjjjtfVAdaNZ0meQ4
         NnHBBhrWWcNXokwWYX591ZNfww5V6RfEXxPTCKTpskUaWCj7TGjwLplbFxEfC0jUyKQ4
         yVd/oQZQ22IR5rteHg82tlUFRkLz7qSCa+dpMW9DeeS9um+hxZzt21Rqlw0JCLKR+M9b
         UXHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4csEGIKx5nf5X+njCeO5NIx1NoWzT/CTXUXKV1glRSLZUhPe4xaYEZCIQWgDLl8dkTrzeL6iZtj2HAcmJOfkvc6lqHs0Zm3H9aVN9
X-Gm-Message-State: AOJu0YwbrWg0zOaPiDNJ2Uhcwx9XXY3+NDtT3AgeFkscbdGHpNMAzFXh
	Ze7h7QOTkzLOibq0fOnZ0gG4ApAoKlCte1kbdnD082uIsPUrMEUGWCWTlkjaC1xkKggD11U+dsU
	=
X-Google-Smtp-Source: AGHT+IEK91VJGk3MkybR/yyJgiM40uXmgGeEsn55PGTY7Pm0E+d53bDnN6iWH0BA7kMiwrTXtEsvUg==
X-Received: by 2002:a05:6808:15a7:b0:3c1:5f35:f6c2 with SMTP id t39-20020a05680815a700b003c15f35f6c2mr6748503oiw.37.1708486993983;
        Tue, 20 Feb 2024 19:43:13 -0800 (PST)
Received: from [127.0.1.1] ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm4436231pfv.132.2024.02.20.19.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 19:43:13 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 21 Feb 2024 09:12:05 +0530
Subject: [PATCH 19/21] ARM: dts: qcom: apq8064: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-pcie-qcom-bridge-dts-v1-19-6c6df0f9450d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=955;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=lhVEinjxnZPoqgOpMpaEnfW2yI2K5/5KqOnNHUJ+XEo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl1XEJoU5ls+mOuiot5Dc6UyJ6q0PxY4bRdNVUC
 Il0Eyvm1KqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdVxCQAKCRBVnxHm/pHO
 9f/gCACcxplPjysZx8WhYbmXZ7o+5LYLja8Sh3sKA7fLwYw+pQlHmMVD1A1nrIR6VmbO+jD3AOz
 Zz0Idi6xpMc4jsS1KMNtlAgbOHZ2hd2GXouxbMIIU1bg1P8I262ZoYmGR2vYc9l/SkbBHAlIBzb
 feZgQNYTSXflAJsw3oS0blOE1/0jhrAosmzlhhBnlNC463eFHQafi0/LulrUQLARyw9WDgznb09
 EiZwXhWFx1A3VyzZrttj1m7kYEC73DkE2hMFjk8rBCCbKmrDq3J8CPkeTHDXvt8lNoEDxEF5GyP
 Am5Fe3shPT7gfTwEqKUGKu5bJXThfuAMcHZL/2W5iIMUni0s
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 3faf57035d54..1ebd6cef4057 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -1318,6 +1318,16 @@ pcie: pcie@1b500000 {
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


