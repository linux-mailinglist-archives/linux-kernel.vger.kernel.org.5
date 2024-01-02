Return-Path: <linux-kernel+bounces-14037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 746F082173B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07662B21A59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C51ED4;
	Tue,  2 Jan 2024 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjixGlLR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0348C10
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e78f1f41fso5924253e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172654; x=1704777454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxaN+74MTHKbW87U3iOEHa9v11H3irm3Sw8OT3o414Q=;
        b=UjixGlLRMtoDXmENv3TkS0XEQR0QngZ/HcCm8hf+d/HU/HgVIZv3nI22slfeNpHhL1
         txrylCUHEELGNOOk0WCQ6yR+UvVyK13ut4N+rYVczxp+g8pfi+4JoOwRnqNTCE+bHT2C
         Q/z/dqYSYLEfLoZDDO/yrQDdX3AIOSNmfpdKYeyvWk/+hEIglfYHufPY3GOLYJYt+NE7
         Vo4PuBcUB8/3aMCySbDqviN5YUsDusL7hRbYQ48Ja4lL7SgzrB0pYbCcRcMLRzkAyGE0
         djzyr9P6WQZTdLJxyuajIQW7c4CA7Nxnw79APZSkZ3QxSDjf5xPhveyhh5+tb/kmNzOb
         D41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172654; x=1704777454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxaN+74MTHKbW87U3iOEHa9v11H3irm3Sw8OT3o414Q=;
        b=PtdDWlIcBtXskfmmfi7HQyPpoPettsgxrB93f1xmhjV+f0MB7n/UrZPZoG1DJDg/y4
         3CzUyY+ofPF/sugz/z9TMmdjhEDzNJFyUaGKQ5QfMuN3yv4TyzudIZDcdJu4lQBat1qB
         OPKk5ANuYkDUsKU2Tp9XxkmRR9BRwn2jE3WGchUS92f+ZxMvluWTxYIDSdRTA7hSon0J
         bjPnmR/o5EM5mfu/pm6NZr7pyfKvoYCXuStn9bqQyZozoDmKnFG1jxI/Yg5GsDq8ym48
         rT1jD1JxvXjvYWUqzkHuIrRkop3qBsxRgf5/X1qjR71lu8F9KRzoPojsiqcAVqyK/r2T
         WSWQ==
X-Gm-Message-State: AOJu0YwkyPV4fn6Jh0kzAIlsb6u6FeLqu4lDYV9wfumEQl+vwOj52mb8
	1Rad+YS8JWsIBn0lHFTGZh3vTTikzTUtXfl38hSPYGCHgX0FQg==
X-Google-Smtp-Source: AGHT+IH8sNsNoOn0UenruAuMIcAMu43EGz8VLnvf1xcEVh9U37KyFW0TcB5vXd5Kr6k+iWZI75S2lA==
X-Received: by 2002:a05:6512:39d6:b0:50e:7fc8:f40c with SMTP id k22-20020a05651239d600b0050e7fc8f40cmr4717912lfu.54.1704172654363;
        Mon, 01 Jan 2024 21:17:34 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:34 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jan 2024 07:17:30 +0200
Subject: [PATCH v7 10/22] ARM: dts: qcom: ipq8064: use SoC-specific
 compatibles for SAW2 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-saw2-spm-regulator-v7-10-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=EgrF1ouyUBfwhdgqqoi+Ov9zEE1VZZvsISi69jo6W4c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlk5xk/kKmNMQp15abahT3pMp/OORIApd5NX4BQ
 HvlpA5qQa6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZOcZAAKCRCLPIo+Aiko
 1W+bB/95XyxFyqVBxx06uIFR+z28eC9BDFgPkBA1XEg6Kd+/FZiOKpeJh5WuapsPBrc+5B5PP+I
 DZa7fXO5qPFD16shTUdC500pK7wUbZUIcFvyS5uBOj/+zV9zHRNe1TjDQx0z+9FnFmxiGKT8U3u
 2nsO/PsePnOqP2FTVZKfGjyK2qX2PWB/oMMAQGOb/IgpRmetdPEsWHFnkmNVxi+M4fbfrwZitKt
 m2jiaU5ZkeGBRtnKdIawcezj9iU+uN8848mcbAAbM7P5FrQjRPrNQqI2v/9u8fKZeztYkZEc/bl
 eJfF9zI/oJ6KWJ3bJFCd4jjQLTBWmAz/uLioeVDZjJOSlaL4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There is no such thing as a generic 'SAW2' device. Use device-specific
compatible strings to describe the SAW2 devices.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
index 6a7f4dd0f775..0621853c24dd 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
@@ -587,7 +587,7 @@ acc0: clock-controller@2088000 {
 		};
 
 		saw0: regulator@2089000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,ipq8064-saw2-cpu", "qcom,saw2";
 			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
@@ -602,7 +602,7 @@ acc1: clock-controller@2098000 {
 		};
 
 		saw1: regulator@2099000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,ipq8064-saw2-cpu", "qcom,saw2";
 			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};

-- 
2.39.2


