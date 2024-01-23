Return-Path: <linux-kernel+bounces-35143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA52838CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC487B25DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F69B5EE81;
	Tue, 23 Jan 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlJ69giK"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405685C90E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007722; cv=none; b=gs5eB2oSNDUeBrfxstJFIuYmz6vOIw+8+cV0bc0827bpdPssMLxqIhAY5VTLGp4jRAn4P69LFvlHb+8IyPjl8iblRRM7gqSLuSZ9G0OUnOr+/BF/nhsxe16m4P2DTg/la1QmoHDtIZOYgYE0q5xr/+s0+wHm7RkWkFcUIZQlQpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007722; c=relaxed/simple;
	bh=/CkEifXleqORHXziAdmpldWh5oXwSgN+s+9gvFqQvKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qX4IDA4HAiv5l5anSgPVDpmVj/GPUJgm236P/JqSz+jsBJ0XsP6iXyWWmjj6KPN6LUwpVsISHrT0ib5IiXOQ1kqULI/O4Pi8xZ42+vP9cfPHtiDsI60SlECyl7Gj4a5wUE9UqtvzxpzLC3yvWGkt7j5hGdclgU0mPrH5/wzjhh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QlJ69giK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so5311971a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706007717; x=1706612517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdCKpdS0D45OzqZldZIE12nHqIULmFpfvIH2gs8ymq8=;
        b=QlJ69giKfE1IPEIcsLOXLIEJVQxFqpdxiVX7JHpzDmAhHypKoJvKwVLph/X9qiH9Dq
         qeEK1pwwspNiRsSmq5eP3pdH/UTaNUL4JdsSVtR+BdSSACyPwX9GZpd5fKxC85+C92/A
         ErFR/0BA/8pmtXY8im8bflTWqTLvc0ZUo6qjcHPhYxzyfVGZ1AmLCXyVqRLHykTwoSsZ
         DxQ7WhoyzYQXkA1KKMg93y0LNgCW42SybaibmDDvE3Q3QEW/yNp3fpZdQ5V18zU7Yrql
         /Y2C4s3qFs4kK+RFJS/6UEM6q1aMh1bEdXdymja4ygX3G+/5VK4X6ZrNm9YGcXW4eemt
         1nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706007717; x=1706612517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdCKpdS0D45OzqZldZIE12nHqIULmFpfvIH2gs8ymq8=;
        b=K9JRnKnL/hWIjem9dxp06pcKC1jGfAak3fX51idO2NTCQtc9kAPIBgQGeoPAR6v9xQ
         s6JHjHM6qfQO8fovlJTgHkrXwrJEPCcXJ5abw0Fn231Gx02G3AzO335+yKhSdVhem4I3
         p85PBmUY2l0OyTHaienmKo0FgDr9TzXP1IWdoSL38StH/8M0jf4YAJxTS32vX9i08kXX
         isKliVLhEZAmpTozTOTV9gmrwGfRKNl+hjUJoBfcVIHxrznTdJx7TGYgYNjQWqlWVO0D
         UK27xC5E4H0RZ+KkW+xtp/yF5DwngPX+EevzYx+z7rTDHlAbssQ7N+D2YbiSv731hfOX
         RE4Q==
X-Gm-Message-State: AOJu0YysC+lZw4C6PT6cZcMYdgrzeO6Bi81YqHg2AqFQLY6LSBlXiV4M
	AwuE+2+FKnELwhSfs84pEcVbR7HWs064N61mMp6gYV4M4v6UbflSc1dKd4EX/6M=
X-Google-Smtp-Source: AGHT+IEAp5/kpyqF7kdWlEllU+KTpxK6lTHQ7SnK7GBxCftSDufq/AkmtmLLpZYg6Kx+aFccaLY7zA==
X-Received: by 2002:a05:6402:70b:b0:559:fbdf:6d79 with SMTP id w11-20020a056402070b00b00559fbdf6d79mr444881edx.114.1706007717478;
        Tue, 23 Jan 2024 03:01:57 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005593c83bdafsm11430074edb.45.2024.01.23.03.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:01:57 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 23 Jan 2024 13:01:18 +0200
Subject: [PATCH v4 04/11] arm64: dts: qcom: x1e80100: Add ADSP/CDSP
 remoteproc nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-x1e80100-dts-missing-nodes-v4-4-072dc2f5c153@linaro.org>
References: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
In-Reply-To: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3444; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=txP4AHtEswNBnh9k8vWLwY0OKLMEo7V+8Porur91vK8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlr5yUWuEHTfdNDYMO2dpBfEJOrO3GuP5fVnggZ
 fnoSK0wHCWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZa+clAAKCRAbX0TJAJUV
 VtnqEADAWJDlkmbf4IHqZFuxJsnNk14299pK/ufBBs6f8h8hRZsk9XU4lREDOO4Pl3d/3x0lAtY
 NKF3oRUd2w6ZcahYbb5I614nRjHwYpj6Gkq93ZTEOERXyWHQ+9r+yZnq0+fO1zXi1NSPoozNP4j
 BIJVXL9qA5XGryWiQIFyn9Q52X0zo7fFYwSq0ilFZXUfJiLqTPJCrzspOiqI3OTTFxr+5N6KTxJ
 V/vu0Td0agurrd00J2mKScx1+WaX3Hg7I9um4FDiI1FqPiiioi23nCUq8HMlciPUayVI60IoZpW
 X3LQRlTzEmxGTd1+MMA2aRBPvZUFcVM6KAoRXhsZuuTT38ML6WNnblI3Urte3bnpyaqT1qLD0Pm
 8gGqNJdNiHmRaNKzkP7NQjQ/wa0t+efYB2C+nMmJ1rKdvAXWvO3LtqqkSiJI2VmajpsbUc1Qg1q
 n8kpBQXb9pF7fv1pv6VPEzyzrrR1c8ugqDjzNpQHFf7MkX+Fse13tF1X1j9Pqt2PMCUeZ5YHayG
 G9XyyMlXTCvGGWpIJtd63susnOxgZEQtVPGp4SeqIiXBwTVYdE0xYJgv5JlBM0GxvbynWX5OIXf
 J9UZGhlGMFhJAXpWB8z/juscpHAwbXPmOuVeLbZzOqcYd5yNFBszBk5Vn4unGINAwbI+xpEXRZB
 H/3IqjzO5Cq6ZVQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Sibi Sankar <quic_sibis@quicinc.com>

Add ADSP and CDSP remoteproc nodes on X1E80100 platforms.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 98 ++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 3790d99eb298..be69e71b7f53 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3590,6 +3590,104 @@ system-cache-controller@25000000 {
 				    "llcc_broadcast_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		remoteproc_adsp: remoteproc@30000000 {
+			compatible = "qcom,x1e80100-adsp-pas";
+			reg = <0 0x30000000 0 0x100>;
+
+			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
+			power-domain-names = "lcx",
+					     "lmx";
+
+			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+			memory-region = <&adspslpi_mem>,
+					<&q6_adsp_dtb_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_LPASS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "lpass";
+				qcom,remote-pid = <2>;
+			};
+		};
+
+		remoteproc_cdsp: remoteproc@32300000 {
+			compatible = "qcom,x1e80100-cdsp-pas";
+			reg = <0 0x32300000 0 0x1400000>;
+
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_NSP>;
+			power-domain-names = "cx",
+					     "mxc",
+					     "nsp";
+
+			interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+			memory-region = <&cdsp_mem>,
+					<&q6_cdsp_dtb_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_cdsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_CDSP
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "cdsp";
+				qcom,remote-pid = <5>;
+			};
+		};
 	};
 
 	timer {

-- 
2.34.1


