Return-Path: <linux-kernel+bounces-14036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E77821739
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125411C21209
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59098EAED;
	Tue,  2 Jan 2024 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJG/k5CR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F46AAB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e7e6283bdso5758044e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172653; x=1704777453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jm71Sl4bq/gVK9I4iYE5wJXvP8h1ZXahjWXtpNyyhQE=;
        b=RJG/k5CRyEfanD8odTLDCLv2uNLeA9lLaggCb1YGYKINfUkPiEU9M/g5QVQ4ICfYqx
         EqPXvsw3eGiIF8SOZTvj5wuNlMv/AuZdcaFF7AtvANM6DBi0P2i6lWID5ws+d+R1rg/J
         HtCxJqNAJy9wnGb0tvLHcsaQ23CcdXphKL804yeS9VXudqUU1STyCf5uVEUOjtr8UZaN
         5F8H7fj7Ws1rp2MoyW16jOcoTlthQBsJqWmC/D92JoqbuTotgu6ONMdMtOKVYZSmP7uh
         d6KnxTQ1qbJVK80hTVYgkNYwTn/W+o+yLTaRoD1RMCGz4vOjLVJ1pGe8wcX9qTj7jOyZ
         0iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172653; x=1704777453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm71Sl4bq/gVK9I4iYE5wJXvP8h1ZXahjWXtpNyyhQE=;
        b=OKmSgMMXVMfFmcyhDeKJTyQut+4No+pDTtA3wnYjiq9CmK8OAzH807cNoT2pgL77zA
         DrsCPOO5XtboORyHyhZShjv/CVaiVYfRA5hFeg3rPVZv9QJKUbnpcIinBFLVXNybMu8O
         WG6O9SSI1zb/kqnPk2l0JOARHxbh+ByEqf2ZYSm3zQCAPcaVkLMUhBrn8RMpBl6EwDBz
         IWOfsZfL/GPw3VkjQclOBiTgX1e1YSkAnluD2uRquELz/ynOq4T1ewxVnVluP026G8Jw
         j5W/Mdg8f/B67KnxO10U5UZ3cW5pIStCyERXE01uOC4MEMYz9hYsSdUsPbxV6IN/KYRN
         A4eA==
X-Gm-Message-State: AOJu0YzrJ7oQM6QVT+JMweup3oeLSsq2JPBOMAQFu2SnUaJn4ntXG9H8
	xw3nD/kbQIFbbDHQPoWkG+4SXgTkITS1ug==
X-Google-Smtp-Source: AGHT+IH7jTteFOtAm+4UrlVmvLELUcVm5JvFn99L+SUC0RK5ZVzoSP/5//jVW7iUdhNqduxYGj4rxQ==
X-Received: by 2002:a05:6512:e86:b0:50e:7b00:8c78 with SMTP id bi6-20020a0565120e8600b0050e7b008c78mr2808455lfb.144.1704172653769;
        Mon, 01 Jan 2024 21:17:33 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:33 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jan 2024 07:17:29 +0200
Subject: [PATCH v7 09/22] ARM: dts: qcom: ipq4019: use SoC-specific
 compatibles for SAW2 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-saw2-spm-regulator-v7-9-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=0zO90aeFdkE8V44pIeboxfUKrEZ0QGnGFIHf5D/o3yg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlk5xk5sN46hSvE/lzgH0D6s2dqO9OuyCt4hb2R
 2JgR8xpncuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZOcZAAKCRCLPIo+Aiko
 1W3+B/9QrS5lGfRNIR/A46/9xhKZoFDnsPLRJUN/dnt+LVDHKY9T06DQO3wp6JhZAXCYfkuWFd2
 jor+S/IXAN76wG5fyNVTo/GUTBDW65BrrbTkSOtQCWqiDSUwGb0R1MCB2ZX+1/AcK35Fvg3hWoA
 tKdnDvglsf4gBYK4VhPGjxmBynvCkua3lM36MVU4uR9v6ob3zCLELsHv1qZ/Zs96xclsVyX1ERY
 yQOJB8P+J4aAZDD0u4sD4o+9WbaylTP5RAee4LrLj9fSXFiW8f7FZVP6f9RU9QQc02EQhUXhh/m
 cR8ud2ZMJYnirNn8znSrk3QGrP9xs687mAxFc1TeFot2zQ3f
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There is no such thing as a generic 'SAW2' device. Use device-specific
compatible strings to describe the SAW2 devices.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index f989bd741cd1..948c6fd91f62 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -351,31 +351,31 @@ acc3: power-manager@b0b8000 {
 		};
 
 		saw0: regulator@b089000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,ipq4019-saw2-cpu", "qcom,saw2";
 			reg = <0x0b089000 0x1000>, <0x0b009000 0x1000>;
 			regulator;
 		};
 
 		saw1: regulator@b099000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,ipq4019-saw2-cpu", "qcom,saw2";
 			reg = <0x0b099000 0x1000>, <0x0b009000 0x1000>;
 			regulator;
 		};
 
 		saw2: regulator@b0a9000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,ipq4019-saw2-cpu", "qcom,saw2";
 			reg = <0x0b0a9000 0x1000>, <0x0b009000 0x1000>;
 			regulator;
 		};
 
 		saw3: regulator@b0b9000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,ipq4019-saw2-cpu", "qcom,saw2";
 			reg = <0x0b0b9000 0x1000>, <0x0b009000 0x1000>;
 			regulator;
 		};
 
 		saw_l2: regulator@b012000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,ipq4019-saw2-l2", "qcom,saw2";
 			reg = <0xb012000 0x1000>;
 			regulator;
 		};

-- 
2.39.2


