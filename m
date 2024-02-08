Return-Path: <linux-kernel+bounces-57899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5414884DECA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA433B273DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1192E6F506;
	Thu,  8 Feb 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TcBpZ1Vm"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E736EB75
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389536; cv=none; b=pgaEEZrZ1BbGofq8w2/d9cZSqbz80T0gCshp3nhUTccs2wkOHCDKX+3SjNuayN1h0jgJdp6byitCbTH61je401uZbgUkzkv5zF/p3qvrwRKxZkxNRb0RWrbLj6kC0/5OOLh43hANoq7rz6+akUKlLwqrTK0bHtl2LEJWz5BSKEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389536; c=relaxed/simple;
	bh=l2e6xHPnxeolMkynb6+ddYEiVP/DYpZDRIJ0qSggCuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sdpbBt0OatTt54I/5myjDJeK/YjN9V5YhDHR6Xu3MHaD7RS4UPDHJFf4xbMniuzcgEdOsVW1XilETWogp4XZFd8uksO3H4nMB05Rtz0LrVTo12XEaQgm79iSezrourkuIJnziAsIqqQyORdm5LQ8GnKJL0ulw/AlE0RSh3L5uQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TcBpZ1Vm; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eac018059so2226266e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389533; x=1707994333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP3FlHWV5DcIHAA8crgDofJ0wKaD0glJWVtgw/kG33o=;
        b=TcBpZ1VmGtRZtmeBjpht+RILe67UZZyjENyOmH1VzZEI09UJaYSVgetxvAvKGUi9sQ
         w85okYxRkb/9ZM+rV/lYSyoTu7FFZaMYmdCDkBUoSPjo3s6rsnNHldR0cCUjfZIILxNp
         s10HVsyuEMIB0DZJBQeRe0Lk0HxgYpq9HmtoJ+weVqSs13j2UkWoOtK1+q4eFGpEZHE9
         OzZgXxXvioqwM6PkQ6jMQIZaap+95v4V7yolbnhuC8BTkJtZz8CKRin+6TIpk1/jWjpC
         Jz61cFMBGGrNtfEETfyK9Xqh+Lv77KA7G3XUVwJdorQI/3Ome4sNBEXcFkxIST4ZKNBz
         +1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389533; x=1707994333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZP3FlHWV5DcIHAA8crgDofJ0wKaD0glJWVtgw/kG33o=;
        b=DuHf9v80hufErgNEFjtd1ukHWawgvP6LYAEFLLtErm4pAm128H036YIXBxaZhbRRuD
         zS2qzaR08S3IurPR5ZZmysffXY866TPiAyxJvubSYHr2YjstaKLEduEu7aN8CYMbHwmg
         ++gOJXJEZJpNAudB7bHJ/k63Fbzzvp0VEfdzY72XMZCTihjkfT3Mj0aHQDQt23k85DMa
         VNkEyXj3gOzlJgrThR1TrOaa7uxplc2oX57uFuFumAwZTk1NBwHMQwqSP50zQo8KCNC/
         mFq2PN4xltMy2uPyg2yAxnSxlUZDS17xtiF+YJLeAclnb1TJ1mkd7OPT06v7p7UsmbDK
         7Dzw==
X-Forwarded-Encrypted: i=1; AJvYcCVBDiTRMUZ15w3MDOPHBoHNwlKkM+QaVKWNfGIpORZJkwftKlEq+R7Xxib6Dk2+NQPJgnrCU/I49BM53ROFZL6PKYJyYyC9PrL5NMMA
X-Gm-Message-State: AOJu0Yxfc3Fzc1rn0KqBc2PS9ZgI9tmMumupT6vzeuIrU5A0g/gzs3Ms
	og0ydMfTuMYfJ+tLD74ZNQku0qytohtMuk6GYn/n+EY3ZQnjYF84JKbvvy4dt/Q=
X-Google-Smtp-Source: AGHT+IHrm2+zRlDpxNBwxHUWjJm06fjlMdTzzH+qGUL8p8NjuGCwrCgVn/7DadJrJQQHORBTlVHvwg==
X-Received: by 2002:a19:750e:0:b0:511:4d43:aadf with SMTP id y14-20020a19750e000000b005114d43aadfmr5954355lfe.21.1707389532826;
        Thu, 08 Feb 2024 02:52:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuceSPr9uSasIydA3iKZg8t4Cxfz210NO2SsmtZsOKmbu0SjK9gYp+0qZTOg911NmTFlTWPbeoLY4zhytQ6FP2hlEYvLHrm1u3BfNYOFZA1xomdICHtCR/Qd8nyy/oKwwlNYn35XMuQ1IZSHBhS8mo666IIPTG3t9JsVGi+r9/fwxxo7w6VeJkl1MJAW1mWksYBITcUZaYnlPxp7SdWWJJul88sTqzjHF8er+7+Nab3XkB8YPn7G/aVfaPXqifnWoyZZVLFyYe
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b0041047382678sm505762wmq.1.2024.02.08.02.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:52:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: minor whitespace cleanup
Date: Thu,  8 Feb 2024 11:52:08 +0100
Message-Id: <20240208105208.128706-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space before '{' and
around '=' characters.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm4450.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi   | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
index 3e7ae3bebbe0..603c962661cc 100644
--- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
@@ -17,7 +17,7 @@ / {
 
 	chosen { };
 
-	clocks{
+	clocks {
 		xo_board: xo-board {
 			compatible = "fixed-clock";
 			clock-frequency = <76800000>;
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 62e6ae93a9a8..7f0b39a5cc6d 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -1233,7 +1233,7 @@ uart14: serial@898000 {
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
 
-				interconnects =	<&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
 						 &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>;
@@ -1255,7 +1255,7 @@ uart15: serial@89c000 {
 				clocks = <&gcc GCC_QUPV3_WRAP2_S7_CLK>;
 				clock-names = "se";
 
-				interconnects =	<&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
 						 &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 031aac702d3e..a8dc53b9da16 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -1216,7 +1216,7 @@ uart21: serial@894000 {
 				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
 				clock-names = "se";
 
-				interconnects =	<&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
 						 &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>;
@@ -4793,7 +4793,7 @@ qup_uart21_default: qup-uart21-default-state {
 				/* TX, RX */
 				pins = "gpio86", "gpio87";
 				function = "qup2_se5";
-				drive-strength= <2>;
+				drive-strength = <2>;
 				bias-disable;
 			};
 		};
-- 
2.34.1


