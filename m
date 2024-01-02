Return-Path: <linux-kernel+bounces-14048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416FA82175B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DE21C21130
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EFC15A1;
	Tue,  2 Jan 2024 05:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qko2bSeI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003BD14AA4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e77a2805fso6086078e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172661; x=1704777461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0cXc9ul7qM16ri4DoMEC4EfuAFcvKad2MY72NsJo6I=;
        b=qko2bSeIXRvfo5VBPrQbFDxT5XDSgWJESm9PsYjNW6Xngv+qvMsheTXDH6ox873tex
         ryb8HnHdPPFUFCLb00DbDFfUuJF0HYxc2CW7DjY2bYsjtPo34eAFTsN6qt0Ufz0Md1uL
         K6RdWdFYgFsM8ozBor0bN3NQvD2aBkovbwyFKwhSSei4mCKxzzJGPbPH1z/Vw1FJuE2Z
         hxNLmqIKTpfnWxWd1sDa4Bads+oHPqvV8RJcr4gM5Fx/M69eVeuhSg9XbRpXPNfaa52S
         DJiieMjmOELNwml5ESNDhYrA+pHnxIz2CtDVfVZaysZvzlDJGsuAzlsrnJDPKQYEb1rb
         LuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172661; x=1704777461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0cXc9ul7qM16ri4DoMEC4EfuAFcvKad2MY72NsJo6I=;
        b=n+UPTf391qaIOro45kFwVmDDLr/fHNszzlWnBNYTNrk0ALXz5py7Lu25x0Q6MAebe5
         ImA3yXJTSNeLBTq7y5jsYT44wOqCuGDzXhsR5QKqG+gmVRaUibpxOYt1crNW6BABOy5t
         tKavJScVEtdATncfRf2YsrwApcWh9Moyn0ZqxTtPgIB4DKmlKRbzBvNVK/J/7wNFa1Sz
         GBozdcmIpxercd+TdOmND1f2TOzc2XTkvHq3vqKM7gZ7GEdW8sNNk4ipSb7wjsoxo6tR
         Nzuy0KzbchHiCp3E0LqbuLylQ6LXu9rN7vy5IFluzhYgpgZzTsZCnp4RYCTrB3v+aOie
         LHcQ==
X-Gm-Message-State: AOJu0YzJeyYV9fAyFbnJgNtkClDfBKR2n6g48KoK3JZVc5Dr3IOX3PWf
	W58tQtJaNkTI1km6+8ZTKErTkxK6RBdW8g==
X-Google-Smtp-Source: AGHT+IGsXvS1WI41DDqAIIm5HRWcThMPZ7dIpbx3v3AmbMgPhplBNbWH/uVGTDBhL5fkV50pYLL+zg==
X-Received: by 2002:ac2:4882:0:b0:50e:4448:75aa with SMTP id x2-20020ac24882000000b0050e444875aamr4501123lfc.104.1704172661233;
        Mon, 01 Jan 2024 21:17:41 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:40 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jan 2024 07:17:41 +0200
Subject: [PATCH v7 21/22] ARM: dts: qcom: ipq4019: drop 'regulator'
 property from SAW2 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-saw2-spm-regulator-v7-21-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=NHhNf/ks6Y5CfOcj/nzqbisPorNP1bm9u5EEDmQhloM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlk5xmk2Ip6BztQ7L7+lgG1xICkrxo2Dxk9xn7r
 yGMgMYcppqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZOcZgAKCRCLPIo+Aiko
 1RHCB/4iosCin7n5la+ISCOixVQ14KFOEkZujUbw7iqXglROBsfa46X6bOnFkOp99zQ1SPXk+yW
 UvQ9CsmEidY9DElDWvxBhMkHJ2LGQ7/sjGa3MXMh+BVIkARSkI7zHmd3+S5mpxuLQ/oiP6ev+OJ
 SWEdefGCs4j9N0e2Ur8Kt35nvhH9f6fMW1sd9YzC2QHs3MHdv3Aifr5w6Npj0aKQPkqJzPhiw6n
 9hr83rtuxp8w6Tx2WqQDki3mv3Rl230HFkHGKOMmGsFNJ5DjCPpaFosykUN1I+gHP9lzhYxO4x+
 8c+fXlv3B8OHMH9Q1+stQVnkZwXEbB0aQAtLG9bqiQUS+Ec2
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SAW2 device should describe the regulator constraints rather than
just declaring that it has the regulator.

Drop the 'regulator' property. If/when CPU voltage scaling is
implemented for this platform, proper regulator nodes show be added
instead.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index cc94942db468..bcc7ceb648ff 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -353,31 +353,26 @@ acc3: power-manager@b0b8000 {
 		saw0: power-manager@b089000 {
 			compatible = "qcom,ipq4019-saw2-cpu", "qcom,saw2";
 			reg = <0x0b089000 0x1000>, <0x0b009000 0x1000>;
-			regulator;
 		};
 
 		saw1: power-manager@b099000 {
 			compatible = "qcom,ipq4019-saw2-cpu", "qcom,saw2";
 			reg = <0x0b099000 0x1000>, <0x0b009000 0x1000>;
-			regulator;
 		};
 
 		saw2: power-manager@b0a9000 {
 			compatible = "qcom,ipq4019-saw2-cpu", "qcom,saw2";
 			reg = <0x0b0a9000 0x1000>, <0x0b009000 0x1000>;
-			regulator;
 		};
 
 		saw3: power-manager@b0b9000 {
 			compatible = "qcom,ipq4019-saw2-cpu", "qcom,saw2";
 			reg = <0x0b0b9000 0x1000>, <0x0b009000 0x1000>;
-			regulator;
 		};
 
 		saw_l2: power-manager@b012000 {
 			compatible = "qcom,ipq4019-saw2-l2", "qcom,saw2";
 			reg = <0xb012000 0x1000>;
-			regulator;
 		};
 
 		blsp1_uart1: serial@78af000 {

-- 
2.39.2


