Return-Path: <linux-kernel+bounces-14041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27821821747
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA2E1C21219
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C23125C7;
	Tue,  2 Jan 2024 05:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EzJ2azcI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C60EEDA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e67e37661so9625352e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172657; x=1704777457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiNV7ILpr0HkRmIOfWMj1cxZJhrO7rdu9/DNUKbMVx4=;
        b=EzJ2azcI6gaK8DWLDEIYaqvVs+cT/KuI5jwflj0aymv4C78CppFTUqEXKjMsBmZPn5
         9TNVxp4W2+QjBU5+HceFtX5sJslZxO1EDOEiEBfQPoRMO9LTQleP9q+yClTdB7reYKII
         P94Y+bXHwjCecIdhPMceqwC33gUyEP/8mF4Sn5MGCCl9Cj28P/PET08T9u1oAqLQGdKP
         4zrfPvjwBa6FLLbu+O4gkWY8jpzt8vOBpGJCduzRPZMRcgEIyyhZeYNn1AlEuPlCRTCG
         W/9fcBpl7x7zwXoCOOSs5Et4aY9FONVP2EXZlWvMtHzBjEppgucsrrQb0NtTFLjjiTfT
         JBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172657; x=1704777457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiNV7ILpr0HkRmIOfWMj1cxZJhrO7rdu9/DNUKbMVx4=;
        b=ClJlE6n3LdmIYJTHHtwLQey9gkOlDiIQhJ1szVipaKO/dUpUbG+3mL6kxSBTE+akrJ
         BzkV62Z1GfgE0FftPNHyUcbs9zSy5s0TCPpBF+VC+JP//4uM6VZ8uKkzSQKnYffNvdZM
         t/KCrHSgHURzfHuQ3S3BdRyXkQ/12m66RE5VMBEAhSkO2qLBIb2G9Lwp9cxWVdM3Q7c+
         WIXYsyo1NKyBKpNIlnqVokHL4Yg24afk03LnIXz3iDN+Xga/q455hCWeVGccBYQw1vr7
         BK7qJqSdJgKsOoekeXx7/IMuw2i0IjZ5NnlugCV/MITtJQxswwrBRgf0f5KhZ0QKUhDR
         +iKw==
X-Gm-Message-State: AOJu0YzNLTvdKF90S8qj1+rZRXfvz4TfrQYuBVGedt7B6beNjMqBkAEY
	48vlQTO6ZFEzOhmrcRZIMW+JwzqCYV1JnQ==
X-Google-Smtp-Source: AGHT+IHDJa9vqiIFCS+SB0WO68pJx8jAUPk7r8u05mgI7q+JlIKEllvdRraHae0w21407VIKOk1Ctg==
X-Received: by 2002:a05:6512:2204:b0:50e:7e15:a935 with SMTP id h4-20020a056512220400b0050e7e15a935mr5538740lfu.47.1704172656850;
        Mon, 01 Jan 2024 21:17:36 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:36 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jan 2024 07:17:34 +0200
Subject: [PATCH v7 14/22] ARM: dts: qcom: msm8974: rename SAW nodes to
 power-manager
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-saw2-spm-regulator-v7-14-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2124;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=SxAwYBf5YO6kJgeVPWUoo4GjR3wOX2jt303FfKTR5hU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlk5xlKQQUYYHteOU/fnAZTyP+7aD4D1cTbLRXU
 c5AUjkuw/6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZOcZQAKCRCLPIo+Aiko
 1XpKB/4p0oGtCMMNgjjuG/xTn5j/cWBZ8VRgnpwwf+951FVLHOz2SrhbCn2TQDl8AzKPzKVcFSx
 xm+PjkpEXA2/wEsivcmSQxd/Ciu6ILF8cwXs8Xhiar22YvtRU+MsoukaRr2GtROFHlRcjFXAVG8
 RYRt8F1Z3RBiTiJyJoluwPLUTJpwieoomh+51ljJKUacXuyMSBYTumRersWqQ1lv9PlyZlKyNAt
 TS15HBmsowWQ/24CrD1NMDx+pOWxEgrREkQlOh2huHspn6K+5+I/zM3gfbG2DVLdmzykVaqrDPv
 sdmvNAt+IUaT2LXmn/JiaM+wUZheNvthYsQEn02Xs97LpqY4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Per the power-domain.yaml, the power-controller node name is reserved
for power-domain providers. Rename SAW2 nodes to 'power-manager', the
name which is suggested by qcom,saw2.yaml

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index 16ee0baac27c..e2008a8b89e1 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -346,7 +346,7 @@ apcs: syscon@f9011000 {
 			reg = <0xf9011000 0x1000>;
 		};
 
-		saw_l2: power-controller@f9012000 {
+		saw_l2: power-manager@f9012000 {
 			compatible = "qcom,msm8974-saw2-v2.1-l2", "qcom,saw2";
 			reg = <0xf9012000 0x1000>;
 			regulator;
@@ -424,7 +424,7 @@ acc0: power-manager@f9088000 {
 			reg = <0xf9088000 0x1000>, <0xf9008000 0x1000>;
 		};
 
-		saw0: power-controller@f9089000 {
+		saw0: power-manager@f9089000 {
 			compatible = "qcom,msm8974-saw2-v2.1-cpu", "qcom,saw2";
 			reg = <0xf9089000 0x1000>, <0xf9009000 0x1000>;
 		};
@@ -434,7 +434,7 @@ acc1: power-manager@f9098000 {
 			reg = <0xf9098000 0x1000>, <0xf9008000 0x1000>;
 		};
 
-		saw1: power-controller@f9099000 {
+		saw1: power-manager@f9099000 {
 			compatible = "qcom,msm8974-saw2-v2.1-cpu", "qcom,saw2";
 			reg = <0xf9099000 0x1000>, <0xf9009000 0x1000>;
 		};
@@ -444,7 +444,7 @@ acc2: power-manager@f90a8000 {
 			reg = <0xf90a8000 0x1000>, <0xf9008000 0x1000>;
 		};
 
-		saw2: power-controller@f90a9000 {
+		saw2: power-manager@f90a9000 {
 			compatible = "qcom,msm8974-saw2-v2.1-cpu", "qcom,saw2";
 			reg = <0xf90a9000 0x1000>, <0xf9009000 0x1000>;
 		};
@@ -454,7 +454,7 @@ acc3: power-manager@f90b8000 {
 			reg = <0xf90b8000 0x1000>, <0xf9008000 0x1000>;
 		};
 
-		saw3: power-controller@f90b9000 {
+		saw3: power-manager@f90b9000 {
 			compatible = "qcom,msm8974-saw2-v2.1-cpu", "qcom,saw2";
 			reg = <0xf90b9000 0x1000>, <0xf9009000 0x1000>;
 		};

-- 
2.39.2


