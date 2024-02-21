Return-Path: <linux-kernel+bounces-74021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF9A85CEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C50C1C224B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCEC39AC2;
	Wed, 21 Feb 2024 03:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1UBwlw6"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156A3CF55
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486951; cv=none; b=PvylYuCmovTarwBEN9oqvfdfN1UVRPavfnRbBv1kpc7VHkZH8FpeT2JHZtsV8SRNUaf6dvg0TFNmQK/WfWchBy7Z0LtuNGFoay7S1L4wYoXa6TSIGBvb97GX1cU2sxHnTJZFMC9uVVmHVg1Uely8V6EYx6qeSdIfZV9bYTDCGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486951; c=relaxed/simple;
	bh=J3jKul/0PQXElhNJclej25sO29NA0XDyDmSBGcZmLg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKoWITk00ymODYOymql2nuS2C34IJ4FMmJSE0ru+sMfz5uUy+9+i3yoHa6boZD6ghhLvgEzBBxb4b+67sx1WMOtneABj+cC8D8qf3jBNhoLMeThq96PcazSF8+TG7VE/cBYdf0NaF1YOzbf1gCEoQpQlV7C68pg77EZn/9C+pzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S1UBwlw6; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c17098ee8eso19844b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708486949; x=1709091749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jx+fQ/t6ipFNBqSDjoYR27DTN7bGkftha5+FUI6wBY0=;
        b=S1UBwlw6Seh9sPVUZ3UbRWmGyEpJR25PwavkCHGmkWC3uL9IhIizsc50HMJjg0tnlF
         VeMeNJZk0GzPDO/t2w2jTv3y1Io/+J9n6Nvbck4TdL66kGMmVhEqQhBvF9l9egYPW1q6
         efu7GeoFEazALHjxoMHu+dB1utJFG/Uil7oEi0cAiUZkY5jeh2bvWLAPuErxktBtE3J3
         nu/FRKtOuJ3+uXm8R81/8QR7EUs7VUsxtGlTflnWcz44w7pCpSKsTGW3cnD7TZm0Wkpt
         d+HOjZ5pZQyomXfjlqwYQ4hJgZy+k0QiF54VwG5EovH5it5hNfsqbdRJZcSN9tUJmOYd
         5S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486949; x=1709091749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jx+fQ/t6ipFNBqSDjoYR27DTN7bGkftha5+FUI6wBY0=;
        b=ElJ2orpKQn9noqzTySTDlt6bZlU17YRHWGnRPBGapsVABIb4t9lVnQrTVgYcrVY+sb
         DpMIYiiJSyTpbf79TD/PvJgq6pkOCB+fhTC3zVIK1ms+wizbyP84o6WQ3j0M8l1t6h12
         ari5Sr6xYhQdTWvXZAEV+O5Ir8JvAjzs2UQwn5zWuPoZYEQBgMuPjtDSL3IfFurZq+j9
         LjBpWjzsnZG8xFWlrUwaYkPYVYV34vMF9YHd7ZdWRTPJLhBnuebwE/xl78hClgyLPIF/
         rGvUBN7gHcPcRNagS/jdqKOcZeZa+CH5WtpG87zjyPrQlweL+xAofoLTMLw6MUm9pyea
         hzUg==
X-Forwarded-Encrypted: i=1; AJvYcCWpXWm/IkH7Qf7vnJk7Qk7i1gKS0hossF72KohFrQrPngZ6f2LqFzIrWtfr6/h8S7a/U47bh0TVSY6hZ8ePHsVC1EMnXSQFaYXsi28J
X-Gm-Message-State: AOJu0YxQxMdevffCQK5RsM2dJzMdfvaRWBneFHboADXtyVkX7LGGcWpB
	LUZq0ZiiOmzHKs8zeZubVzuGGoW90RZgZ4D66JmvJ/g3U+TP1clqVO70dM0AWDNAXQ0JAio5ya8
	=
X-Google-Smtp-Source: AGHT+IEUmeZhzX6g3Qkt0Q537Sg03gbNBl5J/8cyK0MtzWEGTj2vOVvfhE5ZFSPam6JQy5AY760bqA==
X-Received: by 2002:a05:6808:11c2:b0:3c1:6e60:a332 with SMTP id p2-20020a05680811c200b003c16e60a332mr994218oiv.11.1708486949176;
        Tue, 20 Feb 2024 19:42:29 -0800 (PST)
Received: from [127.0.1.1] ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm4436231pfv.132.2024.02.20.19.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 19:42:28 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 21 Feb 2024 09:11:52 +0530
Subject: [PATCH 06/21] arm64: dts: qcom: sm8550: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-pcie-qcom-bridge-dts-v1-6-6c6df0f9450d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=J3jKul/0PQXElhNJclej25sO29NA0XDyDmSBGcZmLg4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl1XEGLKuGwuIxVfZ2RAl8RPL9QF7taAoLBqgS3
 rAp1TV+/q2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdVxBgAKCRBVnxHm/pHO
 9d9RB/4mKO61dfmraNPj60rQK3e6WYHIT/rny685M0kxYOBK6saH/jo5Y5hDv4vWoBTUrthxCRn
 s4uhfwePoyfGLdaLZcg8vK59hXliyzLmhT9nG5scCP5VfF8+4kOaYpTzFCGG9zjCFuYFEuu6Itn
 MKvgyo8mJjALR7uJVCTFqBCj740N0c1lRxo/0zvngJ3dP5ipJmBvdUDUH5+dtqgtB4ylHqUnTvE
 5iH0CgMUOMk/i6VUqN/VNIy6jtKDDkvlNvfcy0whCx1ZcZvNY2lq62n5JaBpO1tYCu/d9OHFQPl
 ORvFjlLFZtfm0K5GsXjxl+JUMxDDIVdZdXFlsNOafSnv88w7
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index ee1ba5a8c8fc..3ee11311885f 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1754,6 +1754,16 @@ pcie0: pcie@1c00000 {
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
 
 		pcie0_phy: phy@1c06000 {
@@ -1851,6 +1861,16 @@ pcie1: pcie@1c08000 {
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
 
 		pcie1_phy: phy@1c0e000 {

-- 
2.25.1


