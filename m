Return-Path: <linux-kernel+bounces-35140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF4E838CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B691F2603B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222A15D73B;
	Tue, 23 Jan 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWBi7eZv"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0355C91D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007719; cv=none; b=BE1M0ct1kY5qEdoe28T/Je8/84mjTzreO7y8WbSvveDAMl1U48eI227BGnnfadmrvVshFiG6EVZ1XB2Yk7VYPOnw6c5nfsNzsJGmLxZD0+B8x6tF7/YopRSi8vwIMuwvpn8QJdW2qcJ55hIR91ApDal88ueEEVPns+09nWNM+jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007719; c=relaxed/simple;
	bh=xxQ1BtV/tdMWqBJBn0tYEMSQ1MHhLRIy3pD+si528sQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qo9iXmOjdfPE8lKeXVUCZ1Dh1SR0KWLH7B5P1OmkDyLKWoA0VtHY2oak7p+BLaOX+02RkO4/ZU5OSC0WnEgm5+kKd/aW1TCf/PkfTDTOZyi38r68QB0I4wt+XzGWzp1g9Bz1+gXyjevYvIJOyE5U2xN8ceQp5iAcjPn8pvgaTNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EWBi7eZv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-559f92bf7b6so7492513a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706007715; x=1706612515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHn+oRDQImOG9QB8y/SViXWT5V1NSTX2Vf8aAXaRwoA=;
        b=EWBi7eZvqxONXXYmE5YDA/Y3Yj2v2FWQOIOgRFgb4GA0tTNBVNv/haGW2T7cXXx0u7
         y5oSXvsk3k8vOuGgB8AWguBaxvlA5IwTGTrxaMaPWMjnN5R+UmcVkwq/501xTYrBhHRn
         FZUlbOZD0JdhmXDSc3qqTVlCBq11j5IpEidP6DWnPhhHmVd0DaCgV7aEeqzLxKgTSYAr
         NBdw0nVAdJdoByyIkj0EemJDGuEpJ47PwppGUYRnyp8wdBPCyEua58sod5NYveWtnMuT
         SSndtHclVDHHP+hjNB/+pCo69i020YGShPpWTf1sMS4JOCz9LvtHQXRWnC1TxGd4k9we
         Ay9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706007715; x=1706612515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHn+oRDQImOG9QB8y/SViXWT5V1NSTX2Vf8aAXaRwoA=;
        b=fN2aTDVaXrFPn+t745fgtBOGWiCdtvHc+oZZLwwdl1lXm1pG7LV2XAN3d09XgAXVRK
         6M1zn/PKNW9hXiYGdDDOS3y8ihuz4koeOZlTo2zrKYA6SE3+pkMO8OmP7UYGGDUruo3X
         eYvisjkyh582GhAbOs0YJB6safSedn8DDOhfd7+Ut/pm5CxFjpunpkScX8OldUyLKi79
         YlzKNAjztAlTfz9Ih0qCYp8Alq0qqi0Uc4PWOaUMPVr48o92MFP0c+RB6womnX7iSkGX
         57sspnIUSujsLidYDurNznDRWbTKqT2Qf+WOD+q6bQy3edG3j9tQXDtDUJuYgg05Kkqf
         MX1Q==
X-Gm-Message-State: AOJu0Yx6TvJn3JJfcKq2wChmMsKv9isGtZPsW0KxJIMoA3i2nWG5yTS+
	mL2F7O0BvfYdN3Xhkn5iaiJ4wngS5ZAHVh3KyBUVcg0gIPSyRMlZ+JWFi1s+H70=
X-Google-Smtp-Source: AGHT+IFxJwUbnH+Gq/4Wdmal2JI9AGx71psR5/4YyNyuZ69b+hIWqGreZOmuv4tvDcW4kk9KxOoHZQ==
X-Received: by 2002:aa7:da4c:0:b0:55a:64ed:9f76 with SMTP id w12-20020aa7da4c000000b0055a64ed9f76mr1446601eds.32.1706007714983;
        Tue, 23 Jan 2024 03:01:54 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005593c83bdafsm11430074edb.45.2024.01.23.03.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:01:54 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 23 Jan 2024 13:01:16 +0200
Subject: [PATCH v4 02/11] arm64: dts: qcom: x1e80100: Add SMP2P nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-x1e80100-dts-missing-nodes-v4-2-072dc2f5c153@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=wu6VTXb2oGDFIag8KOh4zhYpfxMDa7F4NLFtOR4fOS0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlr5ySTaLN9sUiFO8DZ+zuVbNyK1Y5F+84x2rQN
 9yPMZjsQlyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZa+ckgAKCRAbX0TJAJUV
 VuSgEADLIHYEUDmjiprLFSwD4okGDptHh/4fFWFU8PFyB/q6382qiaBZEwTv/u2O8X9nXkt/uLz
 /qrLcq4/VrceB/vmDow+DHfGujvEAfSn/G3XIJNkFvpEfz3k/6HHyKgT/K9UNMt79OfwM8DRxwH
 MflmWMTlxCN0FcyRal3oHF5Bg3mSC/bDE3eLw55axzSgkS78wsMCTnH/y7Lroxi7ihm62u3MapE
 pAJC4OVUCi9AYOgkAu1qffpmNj+CZbxegB3Gc3z/pwtlu/zSVFAnTuIJyXhz5n5+pZeQdNA7yuE
 98TUKZ9HwDoquw7do7+w6XL4qDdjzrbbhTXbSamV8Vld6/FfEmarNPwb3V9vhWN+NKSDwHJpSs0
 oAxc2KQOiGYXS/Lyn9D1PNFT1uamRlZu3hbZpFSbBuvdCuj4z4MO+w+PrtBLZWQE+ZKYIyT8H8p
 BXEbsB1L9yhgQyrdG8v9EGe9dZ+yv4jmtH7LiP9Yzgr6LmOZpowt0r4v9hCXV+qcT3c9QPDJ0Ja
 sFI06wC6QC4whtkhYB9zTlyuoVv8Qt7cc0Jj8LiLOASwru4Rw8GpCQe7DQN/p48HMJ0ZjkssaP/
 r3X1MpALk9A6gBBjSupVBkWLptvVhnNAtLV5KH8VKFw0SGDmJnEoT//O6G8Pi0XT2z+3A+PgJJu
 UqPOqjOzkSBgGAA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Sibi Sankar <quic_sibis@quicinc.com>

SMP2P is used for interrupting and being interrupted about remoteproc
state changes related to the audio, compute and sensor subsystems.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 954f2bd9b1de..1210351b6538 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,x1e80100-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -662,6 +663,58 @@ smem_mem: smem@ffe00000 {
 		};
 	};
 
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+
+		interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&ipcc IPCC_CLIENT_LPASS
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,smem = <443>, <429>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		smp2p_adsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_adsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+
+		interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&ipcc IPCC_CLIENT_CDSP
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,smem = <94>, <432>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		smp2p_cdsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_cdsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 

-- 
2.34.1


