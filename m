Return-Path: <linux-kernel+bounces-109944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A5788580C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58ADF1C216E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1E05F84F;
	Thu, 21 Mar 2024 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tw4kNxjj"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5C960275
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019867; cv=none; b=ewO5KyIGngBfSn78MgIe9nI3tvd9xM3214u7EIy68uQETT7IRreb8t9VHVQEJOn5wzJSBjRLdg+OjNPOZaCCLZBWVZTuCBRf7+9JXys4gor17SQCrwFBSRmhAJu6B3uNOCdtjoWsekqRHy4qmShBUZlZfN3p2+3Gi/xAKdYztMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019867; c=relaxed/simple;
	bh=tlr2lasCyCa/zgi8oI+AluN7Tqvxvjw2NcUxkA1441s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UL+SwrBvJG3Ez+njWr9MXxNHULnQhwVjrh23azvx/Wivx55BhNO4us118RSWcLnBEpew3iWG+0pkKe8AOdBM+Y1Pb8rh5v2A08+/XN+uzSLgcMouqrM0yRfSXNr7CAvy13PYgiiYnZi+9T2u/SP2GusOhLiwf5nd4QBWNBFTRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tw4kNxjj; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a4789684abso450554eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711019865; x=1711624665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOe6HqmwKhX/Vwx55bDROJwE9RkNEvw7W3i71rmfs1g=;
        b=Tw4kNxjjl8gBFIsboJX763cNRe003488TOIA93RB9UTWWtUVet2VpsKC1qpcsUu5KM
         IDVgh0VeFYXmKVPvP20ePirJNHg7kWJtiIW9/cc6O6a8FNKulwPhUaa8kcNgeZP7kLvn
         0mbbD55GRdL2Kosca7ctII8CljgEFgiUw2SOKHK6xEdDlPBFjGsk+/42BBV3xfgt0oxX
         szDtWshIVWepuwYqEvDhaC10zfhtdx0smKgoEHFHtaBqaQ1QXUL3eb2dF47xh2PkXDrx
         wDs/Evut5VuAhDD6FWtc3sg4EA4S4FNpkGKFLt3VjjjlGpzPumtHc4FYR2/21RlrxCT6
         cblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711019865; x=1711624665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOe6HqmwKhX/Vwx55bDROJwE9RkNEvw7W3i71rmfs1g=;
        b=Ms6mdPy4UkGuEYWZZNRQufXuH47WQYcqEsIuktX4VFsmya1JeCIFy3oWyuYxaHYHEi
         KaUvsGRDnen+87OBxDCjZ7DI6lqKrn7LrvUfQ0Ry9wgGkLFUEOf/Xl8MbCQIORr1EfS6
         HJNZIteFC6P9PBCHAW78Dwd26KvjI2uQaObRlJvhH3nvd5nde5swASR4eVvz7ItDQqSE
         mGC9JHoCLV81YwqZgTqeS+NlGlu/BKmWZRVrIIMUNHbq++q0WzwMvtC4SbD09BIo7Y1P
         cKkVaJtEjnaMNEy3Zm1o2u+/GTAb8uvvz0FEJCq4ehBlnSvFOa2NsNrbVY5yrfORqoFn
         TqHg==
X-Forwarded-Encrypted: i=1; AJvYcCXJjVEApbi6lGhWoY3abg2yVbT7t4OU6I86sXo0G9cFiJooIkHjg6okPrsEpTQgn/oX0tkMMDGoJZOnX41sbmrgmx+tMCDzwLdvh1U0
X-Gm-Message-State: AOJu0Yyww6sAkvxlRIbRh0ACWBCkO5NcLaju0SdSbUuhmptLA2b7TEMF
	5shZBtfJ65cFMLr8/gy3eJWUzyRuEQRNifYtvuBasSEZSY5n/AqSiO9nZKCNxT0vSBGK5EwL2iA
	=
X-Google-Smtp-Source: AGHT+IGZRt3kuPCx1GFAQjbI+h6HVrlB16/h61EedVNecFTZDgQlCk7HjuITQyuYNMv1hHyWosn+xQ==
X-Received: by 2002:a05:6871:d107:b0:229:929a:b127 with SMTP id pi7-20020a056871d10700b00229929ab127mr5284145oac.37.1711019865339;
        Thu, 21 Mar 2024 04:17:45 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:17:45 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:36 +0530
Subject: [PATCH v2 16/21] arm64: dts: qcom: ipq6018: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-16-1eb790c53e43@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=864;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=tlr2lasCyCa/zgi8oI+AluN7Tqvxvjw2NcUxkA1441s=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcNhJc1Bn8KeL49KiM2lfnVfLHkQjH4OTaM3
 qMaeoeCuMGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXDQAKCRBVnxHm/pHO
 9a+4B/0cTPSBfqxceWlGyh67ruYuBrsLJPCj+ulDGCwQsWbAIQp+2OkA60/eCIy7fcaQT0QXwwV
 t7jXRsYHvJsac/43YiWJI2+egjtjSv/L1RES+ccosM37FMbSz09Wv+F06ak+d0K/5c+Ybt5/dge
 2VvmDudjcJQhcllmEL5orREejaUuafroOyrk9ZYhbllgtX2duoA2cTH5iNpZFbWbogDfNLkmmnm
 B8UEKDeozQRMoPLbg9pPVjUdHfhe9SJL5d+OSwjJklPX/BlhR//H+3Odc85X/cbWWb7j5rdQ1IG
 L6CbZDfEGhSrSODEGNepktsTGATGcD27hxKzliMRDAaXACWQ
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 4e29adea570a..17ab6c475958 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -907,6 +907,16 @@ pcie0: pcie@20000000 {
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


