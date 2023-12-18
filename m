Return-Path: <linux-kernel+bounces-3537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1546A816D89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9931B23419
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090694F881;
	Mon, 18 Dec 2023 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m580hI4n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B304F61E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ab37d0d1so3474085ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702901299; x=1703506099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/R/hqTzd/o8JpkxBFS0sj0AJtadDOIWSQt92Ki/rlFQ=;
        b=m580hI4nJDprU9seRrVt4pBr3Rd0aVsShDZ0cEwoQ37lx3wAYyria1eFa9lK2XIASo
         2vRbJYCYrQdjNjKPxzqdOFjMh4146wyTfRnDD81d9pqE+G9DnUZMHmeJqnXV881llne5
         YZp3FLV1cxo1iKjPO7GaXlmF/8up8ufkhzUHJsVcmqplvTBQcLVqD7sp3EEcs7T/gdsx
         aBn7fPn4vba6tuP3LN2paqnwqzd/f7Fk6SZN8eCH4Mpn10E/145O0J/Rgf0L0zKsXxqm
         qPs2cuEq+8rAoHRGu6UuHE+OOIoKQIHzawOyaNapLJRC6eRuAFiCh5t9FVZBaunWrY1/
         ymyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702901299; x=1703506099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/R/hqTzd/o8JpkxBFS0sj0AJtadDOIWSQt92Ki/rlFQ=;
        b=L4uKRFpxIaSmxWXtmUYBvEnABGBxigcquHuVPezqMWwTD7I0OH6tV3lCUncBS55/kX
         kKshv+IbAIfUYd4UNzgeGKA8w7qyFNiub8/BzmtAsQ0HqaX/FmvOp5rcXSygT0J0M+r/
         YGEveUYAJsHanesCw4tqaDNnpx6ohzHE1XpPFZyYFZeOJU9VUY67ys3s5uJqGZ37eIh7
         WkEuKgcBVnUZAAs7EYdfFeA9Xhk4lp0mgeHNAQZUt94/ttgaOEhlWSXn20pTJcTciZ6V
         iEZUuWgAP8HfygRfU9DESgstyeEqpGnqgGymCQxJCrwmWU+AY4B6tVxrTsEJbe2vcDxL
         0skg==
X-Gm-Message-State: AOJu0YxtYWmckSbc8DrgnfZ1vlZhtlBffKFF+m4B5gSsP4bCF9AM0eWH
	Kb30AYqZPeYoOGMJ4/w3GjZ7
X-Google-Smtp-Source: AGHT+IGkvDJKUZhvMT1zocpm838dWNiBdAdJ7LY+l+3dLPhpispjyloWmDVXqZesfg+UeMzUtuQUDQ==
X-Received: by 2002:a17:902:f690:b0:1d3:c3b7:50f5 with SMTP id l16-20020a170902f69000b001d3c3b750f5mr470070plg.87.1702901299155;
        Mon, 18 Dec 2023 04:08:19 -0800 (PST)
Received: from localhost.localdomain ([117.207.27.21])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902c3d200b001d368c778dasm1285709plj.235.2023.12.18.04.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 04:08:18 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	vkoul@kernel.org,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	quic_cang@quicinc.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 09/16] arm64: dts: qcom: sm6125: Fix UFS PHY clocks
Date: Mon, 18 Dec 2023 17:37:05 +0530
Message-Id: <20231218120712.16438-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218120712.16438-1-manivannan.sadhasivam@linaro.org>
References: <20231218120712.16438-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QMP PHY used in SM6125 requires 3 clocks:

* ref - 19.2MHz reference clock from RPM
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

Fixes: f8399e8a2f80 ("arm64: dts: qcom: sm6125: Add UFS nodes")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index eb07eca3a48d..b46d3c1fa47a 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -812,10 +812,12 @@ ufs_mem_phy: phy@4807000 {
 			compatible = "qcom,sm6125-qmp-ufs-phy";
 			reg = <0x04807000 0xdb8>;
 
-			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_MEM_CLKREF_CLK>;
 			clock-names = "ref",
-				      "ref_aux";
+				      "ref_aux",
+				      "qref";
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-- 
2.25.1


