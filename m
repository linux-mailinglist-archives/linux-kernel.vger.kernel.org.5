Return-Path: <linux-kernel+bounces-42705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372B4840554
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9588EB2226C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AC863501;
	Mon, 29 Jan 2024 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v1jR4bnS"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C023627F9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532369; cv=none; b=hnO92JhZXhukZshsnHFgLkSo+34jFG4hzWCKmI2aHlLOGIZWlsmt4f4MyjFN2s54oTsMpkdECPiQ7zJkRsyRBICrJbJXHdFei7KRUy9ur8xunKzTb4IoMq2n93NvDd2IsoboEvBK9obnThVmIfExH0EnR1j1WOOM7yzZPrdUGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532369; c=relaxed/simple;
	bh=9lrK39yGWz+mMVNX3fo7mSMQqmbiZ6p21a+lgh38MTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JE7jXaFUffPpYLltsuF1c11d+yupNGHnaRCLmaVfK7hHXVnaIbLcChoW2DWyTQtGbWsHq0ipA2xWTRzcdLpnkdu7UGXVZ7Z4tRuJbPf/aEw194pRSnRU7XtIvjYTBqu+sU1XFtOxrvFVV4Oqf3mVjJMdQl3DXSx8V6TXl/VvBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v1jR4bnS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55efbaca48bso1255611a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706532363; x=1707137163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOMNM1cIuCUaGhFmJAiF8twDPA35g39fPAYJ946kJ00=;
        b=v1jR4bnS2Kv0ftRMiwMa6HPnCJRltCZdWq2O1gDuSr2FD3SElRjJD3OWRkfxMTffck
         RX67WbBFwjyfqX5eBARIb61fZO0P+JotPTSXEN28zCoubX/+OXeEaGnr0GkB3kBEyYFc
         BvJvGDbU1lCIf2PD+8q61AEl7xxPudxraMyPPqQgEDbN4mTuUvWDuPs/DDUsF6KoVHna
         b8UtApVGPJKIYHhRW2XdZkwJnyCLYQlQJTF2s4K6iTaq9cRa0P3oY+DxabuimDUOqD9a
         J0+KDOAE8vwO5+Xv/162TwjKhM05v/ejrQCQx68dkqrmK6BqoV6Ac/CzBZfjvX/awW7P
         7Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532363; x=1707137163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOMNM1cIuCUaGhFmJAiF8twDPA35g39fPAYJ946kJ00=;
        b=HeyS7AP/SUsRF1xmm2dzTs/zvV5/5mEcPLMz6GSWuqEpER5lk4nD4yGaJeSKYt8zwZ
         e2d2gj8gDTLHmSuiiNO009eji6/d+rdg/sBU+Z17lFtFKSk6rrYoPkSGLOAnIrC3ta2l
         IzdNBaK//+A4ngLrwDuZ1bVNT3mfJl1qip2GGD/baNPOEotJ/DT/slAUGKllOy5kwU2s
         vl24VLhAfH46PY7vPiOJW6PLL6ZdnrWHZ+ktqjC4dz1Coj3jXcJuq1x2msh6bTAU2gtP
         8HxK8fg/mS9W4f4Hmkl4+hIyBZ2k/feNCjyTrNsKhGp2EM2nt//YY7fQ8p6kGxbApi5t
         xe4Q==
X-Gm-Message-State: AOJu0YyNAV+Tz/CJHhktAOQhTjIFfSLIbkrRAYQl0wXp4r134Gv809Us
	Yr5CfB21xepJS4y7MBBT8LQGA20cjzTTSni8wHhjLFB+0I69IIatPSdboMxq1Bs=
X-Google-Smtp-Source: AGHT+IE/xnMvPe29TkcqFpwPP8bs4ej4VImwX/JJTz51AdHdHMEKH8UzH8CSIj+/FB+AyqO7nY07xQ==
X-Received: by 2002:a17:906:3c0b:b0:a30:b7a5:c34e with SMTP id h11-20020a1709063c0b00b00a30b7a5c34emr4627918ejg.17.1706532363428;
        Mon, 29 Jan 2024 04:46:03 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906329400b00a3527dba974sm3041495ejw.35.2024.01.29.04.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:46:03 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 14:45:36 +0200
Subject: [PATCH v6 04/11] arm64: dts: qcom: x1e80100: Add ADSP/CDSP
 remoteproc nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-dts-missing-nodes-v6-4-2c0e691cfa3b@linaro.org>
References: <20240129-x1e80100-dts-missing-nodes-v6-0-2c0e691cfa3b@linaro.org>
In-Reply-To: <20240129-x1e80100-dts-missing-nodes-v6-0-2c0e691cfa3b@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3499; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=RU2sVakWDTM6FIOT1mP+9fDqahd9wnJzAdPildXmazk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt537i8X4nTI8vcgj+0wmx+56mXLNXwLzgYKw4
 yAoKfQ6NkSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbed+wAKCRAbX0TJAJUV
 VnZMD/kBhJFWFCWUCC3LH18ZhG7DX+xmln+vTWLI/b5Jf15S0JGus0+LW8W5pLE3dNRiEkTFFJZ
 1j3rvRjk38ZbwFRo9pufWjqFu6o1ShsrLY6bR7c9+RWeY6mNql0WHaQYBzDSF7xLgWfokbScVa4
 Rg79i7kWbARKQwBG7gOR5THgpD3yRZ0nfR8szp8qvdno+XwP41vE9wJMmlSAE8eBYZ8R4OLllcq
 L1U5IdO5n1gQRvDyzr8lIX9/k/eYmXEcF+rxtu70b21nwP+EJsvDwBGHg481Nfxo3mmxqjzKUc5
 wZJ7eIGQuAncrXG8/EzR0p+oA8OO8H/RmrI7leyQPz4BLnOcLenhjQQDSbyEEnq8qNEMiHgW/Sq
 PGaBLb+ZKCvIKSYZasWKexhOfTrTdAIDLkpAk5EpQ0w99/tMer2sR51JGOMrPrdgOiDcxUmNOiC
 K/IhhRdaKBh7AC3AhV8+vdnH9MElTXsjS/VU9iq1/UDjI7OQcMpo7JFjpEv+x8C0e4wIa4vwTDz
 gCW4ArvYWUat1Ko3gJF+twE4edrFYxpH0NOXe4QlsPfAPL+qzKbSveVP71jq9yaMNogAK8hNrKS
 /14kwfr39uehNRIAuR3XbMxTQhxM87nY+frQvKK54Ge2Dsk4GxvnUURa7K0ujLtUop+XUWT0dS+
 Fwdhsr4spaFBJqA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Sibi Sankar <quic_sibis@quicinc.com>

Add ADSP and CDSP remoteproc nodes on X1E80100 platforms.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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


