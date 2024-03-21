Return-Path: <linux-kernel+bounces-109980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E18885880
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA735B20B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94CE59141;
	Thu, 21 Mar 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wt4aw0Qx"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1515C2E6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021388; cv=none; b=cnHG55vA9Rr+lj4TYnRLONYeEcjFycgf2O4XR6gqdo73Rlygm4bqCLB6cvsdtqqmkFKMbacPtDd1UjWDnaxd9RF1HY+RIkOtjViVx9cCIWl51UJn9gARJqfyEIMBakTe4mTolqTnM9Z1RqbyAe9cR1LMCWnKEzg32PWL3LIJtDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021388; c=relaxed/simple;
	bh=c14pcQ7llIjx8mdlZCcx/UxdVlyVw3faEieM5GK4g1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZBVXWpCsz8Qv8FaICPQK5ZbMIyYQkFS80gCKaqcKZknpx89YKfJS9fhEejEnzInPaH/Q2KMndhLAPSzAR8zVTD2wZfLyDZdO5OGISdy9+al7XYlD8KCy1G6vAcVlz6mAa3YdQZKSMV6pdEPs9PEEUMbwfRgE7imODnOVZg9qcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wt4aw0Qx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dee5ef2a7bso5690085ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711021386; x=1711626186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fieeCMbDbkwr4TB8UmD9bibJ0Comg/fOeaeZF9hfHUg=;
        b=wt4aw0Qxu/Rn20A/iWM9nhJajok8ctlde175nxXjaJFmCrfPZKzaocUF+HECk752vZ
         W+OJJMnTkhx/ncFG/PZJJmptxSGRnLGFuQxXWyTOZn7K3wbKsRxUTyGXNCbiPVgrLHVt
         eb4OaB37tZZNzyLBsra9m3xi5/bFxfvBywRuE8yqwLyyV34oouM23WsZJ8cnJRD6KVVy
         Rzl6yLOMkMzIPjDaRW8BOStWJ3gn+Ty6HBU/2IC9asLuvM897jh5yXW7l+hprkEdX1fT
         b8dxJ/Ishr4kV2D+27L+oXMR+yViVqbzkvx4SEK7ohBJnEWOl+5tt5iXwMQc7i4zBJqm
         6oVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711021386; x=1711626186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fieeCMbDbkwr4TB8UmD9bibJ0Comg/fOeaeZF9hfHUg=;
        b=Bcz6W/FpJgsTaibgcJWyw40V1DkE9BKWe3HUFwHyE2joZMLpcqF0/DzeOmKpTxcr1R
         siu+7gQhNa94/lHXtbJ+ID7dSbc0o8Wkka9u8jPM0BuRkxMQcN/aQkjHeFmuM3yzDgfB
         brTlKYfKVW/sVgXIEQYu5ytK2wj/SOqY0Llzfylne1zYQkdCvFVr3RkknppZb2MRKVMt
         7/OBWM1lItOjW0PTcfWR+hkduQ9u3NJGbFdRN1HSTqhS+b2bWyfVlxczbd+DvGUgNdPb
         CVEUDpJCDzZcPPOeSkXd7UeB0k75Nnv/dbz9ABYqin7g/l3YwVUCxS2yY2oaa/qaC+y+
         EV2g==
X-Forwarded-Encrypted: i=1; AJvYcCX8M57bWhoNcy61AE3cir6x+Fb50hEq4dcH5cMEoDMvMtcHQEOu2djSm103CeYbKFsOb/FXZGNAMWc6+munm4UcXMCjzIQAeUJipz2A
X-Gm-Message-State: AOJu0Yze/wXAPLxU8ARjISyIMhusZXMmKlVABt1qtXZNanDcGV12kRso
	7f/O1jy7dLRGH4LF6vXUbmgexhfPzrHVthRhZdcM2Z1jUg/jmMhezubZ0iWiIf3yDWtanh3eYyY
	=
X-Google-Smtp-Source: AGHT+IGxTbaq4S1vZ5iHJph2Vg3zsNE+Ti2W0flAfFr7/pds+Tq30rnkmP5QzSsgj0OPYqYEx+gS+A==
X-Received: by 2002:a05:6a20:5481:b0:1a3:6faf:c0cc with SMTP id i1-20020a056a20548100b001a36fafc0ccmr1838079pzk.20.1711019861269;
        Thu, 21 Mar 2024 04:17:41 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:17:40 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:35 +0530
Subject: [PATCH v2 15/21] arm64: dts: qcom: ipq8074: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-15-1eb790c53e43@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=c14pcQ7llIjx8mdlZCcx/UxdVlyVw3faEieM5GK4g1Y=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYkj9I87juUeyJOlTUEpJ2ZUqi9jl6rdWZWyP8V9kE63Px
 Skob3ipk9GYhYGRi0FWTJElfamzVqPH6RtLItSnwwxiZQKZwsDFKQATObeL/TdrT9jLAs9LQkU8
 GruFdRf9+5VT2W386Vrd3XO7XX/Ke8zrvsAdcmZLimi87sS5DGf+eU/bUJ7XwlanurrN+WCahZ2
 eZx6PZdyak2+v/hdav9NSIPj47crN7Bt7eizvp2SE1zYsk5n7r+d08OtXWV+u5SvMMmwU0Vq/Zk
 mcWWmD++2MLPbk37dMZI7O2ioq6vajSDovTZol0U/bIe/m3eRV3yqDXRqD7X6nbcmZ0PlK8ZlQw
 DcL7iKxKZs9js068fMG/8nZbJrBlT80trZnZx2fLrqJO+y90aIVAW7V5+OnNr9Q9sty/Os7R1yB
 reOp7o3IaU5HU72dVXseHP9RUOYYXx76I3/xdY0LHIt6AQ==
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index e5b89753aa5c..12324841d1b0 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -864,6 +864,16 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 				      "ahb",
 				      "axi_m_sticky";
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
 
 		pcie0: pcie@20000000 {
@@ -929,6 +939,16 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 				      "axi_m_sticky",
 				      "axi_s_sticky";
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


