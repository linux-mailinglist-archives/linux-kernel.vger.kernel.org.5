Return-Path: <linux-kernel+bounces-74030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B885CF11
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A591F2312E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0BB3F9C4;
	Wed, 21 Feb 2024 03:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dF8YUX3F"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834CA3F8E4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486982; cv=none; b=rfqBJ6kcyXYItQSz5xTWuS8MyFL9rBuxMVUPk7oH7i9D6VXxRyL5tB+aA3XwceXObjnHnWPB+sP09xLy18gWHZD39BUF7XxiQkbCWp9D2WCiVAySQtAcJmq7D6ApJUQ63qwLazI/wSMP036t1+ZS2nYqUpiggUFsz3pC/1SSUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486982; c=relaxed/simple;
	bh=ypuCPT3MTqkhsDjqnsU05TKdPs3cZKAeidyYAq0PCTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YaK6R4vQKJj3JOxrFg0tUQgoc111i4lglv9TFZ3hUxXPQ+q7Pkt4hZkb94uDNO4lNTRZeFVlo4hni7wc2e4v1ZGzFsMm4XyJWlyjDpTd4fEvAGjuHQ74dVJZYD2iz0p2vN7eV0lie44sq1khNCsuusOU71NKLSJ4uM5w9ItUWsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dF8YUX3F; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-599f5e71d85so3948267eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708486980; x=1709091780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQ6mpuAJjT9QWTRjwdHfhfRYk3bhWpEqcJ/zVmLAKcU=;
        b=dF8YUX3FSlJiVTuU58cRGajtF8xowfZpAhqpiPM0H3Lg6CIlsdW0FTVpQcqsiXctqo
         z9yTfCrEnOIXT0e7HuxJmr+JwLT30ObUDWPV1oLXv4loEw8HtNOr631G39Dtk+GyFB6g
         Gpve3FkAsyDhfLgJcY2Yd+lzAX4WWiiUj52cPY3InyaU7PsgmIJeYwLoxXg3Eb2nctB+
         gINlcFs+t/2YjThYu15Ik8cHL705D6snW89l4E56czqa6NY432x0Re5fP3tiHqUQk/zk
         Kc3I/9xCKZVfyLLSkiCn2OB8O9cJhtdxFBpMfXwsou6BOUAOd173zmb11Zxr5X1A2aNA
         aIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486980; x=1709091780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQ6mpuAJjT9QWTRjwdHfhfRYk3bhWpEqcJ/zVmLAKcU=;
        b=DbwoBymnYDi4NGUyn6aqGQdc/anIqLwnpPZo1aX98H8A49SvgCAITXdx57ZWui0383
         rtX908SMsP7tuIOdWzxPRCnel1YQjhCG0hNTGGqhL9rdroLoWkC7WKz0sDUlhF4LoMK4
         /3bXtsR1WTnVPJyj0CngS4DTvR0vCjEmuHX+o5ccAAO17bDIiX2HE2peCnsHbtJ3n9gA
         tgqF3xz10Tg3ZcAiB9RQ1/AJyfpM9EIJW13TwFRAjpwFfwgf3iWPGSil5H7uH5msUrws
         lrFuQL64XoZfoDiEZxnhl94DOD8lFkcAY1rKktFnpHycUguKBQwwaZQfNUqwKCtkhbsT
         Z7Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVPpOSWNhunDDjylo95VB5cHJwah+3Y0CW39tEoTc8h/9cCUOvxdzCS0jUT2rz8Zvrm3sCZLbybJ2GGQn5VbJ1GGshwVbu9kGAj/MHu
X-Gm-Message-State: AOJu0YxBTfFwBoAnPNyq633piW6oJk4X4J6Fzl4xTSCFl8O0OCP1RWc9
	3oC7TZwOb3Ve4MJqUUnFBXf23sScv4k1KlDwhtjgW2lf7XuPPO73c9EvkFxArenMcuyEEVDzTtI
	=
X-Google-Smtp-Source: AGHT+IG8+w/AFQLlh4uWof1rwfIQSH2G6Fb6A3tMrx9rSrH7/Q2FyfbFXQQHAz7uITirEFGHh/H+FA==
X-Received: by 2002:a05:6358:5712:b0:17b:5e34:7186 with SMTP id a18-20020a056358571200b0017b5e347186mr377548rwf.11.1708486980518;
        Tue, 20 Feb 2024 19:43:00 -0800 (PST)
Received: from [127.0.1.1] ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm4436231pfv.132.2024.02.20.19.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 19:43:00 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 21 Feb 2024 09:12:01 +0530
Subject: [PATCH 15/21] arm64: dts: qcom: ipq8074: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-pcie-qcom-bridge-dts-v1-15-6c6df0f9450d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=ypuCPT3MTqkhsDjqnsU05TKdPs3cZKAeidyYAq0PCTw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl1XEISjrqKUr/A17dlCnr0wtHL3kzwFLHJxs0I
 h7yKs/btCSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdVxCAAKCRBVnxHm/pHO
 9TJzB/9LSmJekSDCNJA2lNACK3m1WIBhM8ZRL0dDXTEQjypvYOU0QKt79bXyOz19qUaBQBnWLvx
 iKIRV7DQRb+NLJvCV3+zzGhNEooWtez/aOMjglodpxxkbVIlBkZPnVqls9i7YJYCH+WVMwKG9GK
 ymZhP34eiSgr5q1ALrA6ct3NDVa/ypfK5Xv2vSAZ+TwPyupzBB6aUSMZ2xQzt1hd771mKEASese
 WzDNHsTscZL53gc22rlc7wey7FWBpevZ6BiZ7NQaBDhE/9GLCfOU5OOxtNukKtIk2SMPtNf8f15
 K1o1zYgHC2c4/ixlXRAW5+5JR0uRTflJf436vPORmYM6zPYW
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index cf295bed3299..ae1677362421 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -848,6 +848,16 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
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
@@ -913,6 +923,16 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
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


