Return-Path: <linux-kernel+bounces-105866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE77287E5B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23F8B20FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AB62D03D;
	Mon, 18 Mar 2024 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="F5R/vzhE"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744122C19E;
	Mon, 18 Mar 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753954; cv=none; b=sMg982V56rpVKEgXoOxIS9uVdZDo2RGygmy5gxd3BUYbII/bDmKCFwQl52wEtoNwDHrBOZl+JrIHHjnL1I5GEkq/NfBfGEvZCR+YML6QjVHHpDEDS9fi9wpkHvU4381GBSTVqvpHC3PrJKGluNJWgfsCZzPPXaiiTBMwVZJTSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753954; c=relaxed/simple;
	bh=L1UpTSN7UXeC2nV0xnPO/HYkkugB3NgHeKuHDXy2qTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mYboqvOD9cFA006eMcTsk5ZRUwCSFxoyhfrLuM+Ws5QA9s0di8MY8cChWUYUtOch/XuJFmRgGIa8XbV+scexO0GSasZCBnrPZFTaOUpf0NYS2E10ADz3RRpTEV8lIS011FE12itw5CzDOIHd/gMyeRpIJhmxAjcTsyTEuu9Su1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=F5R/vzhE; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710753943; bh=L1UpTSN7UXeC2nV0xnPO/HYkkugB3NgHeKuHDXy2qTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=F5R/vzhEu7Gp6WsBWPWDLJRagnVPpcd1ud3t/hz3CzR9sSSIrZpcLaIhIfl8c2c1J
	 WNqlu90/dQ2iaxSA3IR6nKEWLI8zx7iCpf9c05zcPsQQ/bAt6aGq0vuroJLuvIFZNC
	 zmVZKsFKylakyF3RpQ2+g6y/oBZIdo3FDxRK0T9A=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Mon, 18 Mar 2024 10:24:41 +0100
Subject: [PATCH 1/2] ARM: dts: qcom: msm8974: Add @0 to memory node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-msm8974-misc2-v1-1-f71668a2b8cd@z3ntu.xyz>
References: <20240318-msm8974-misc2-v1-0-f71668a2b8cd@z3ntu.xyz>
In-Reply-To: <20240318-msm8974-misc2-v1-0-f71668a2b8cd@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=L1UpTSN7UXeC2nV0xnPO/HYkkugB3NgHeKuHDXy2qTY=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl+AiTj8QN5MFTgHjuwUeQxDim5gVwoAn0Em6sH
 jNQPSdBRfaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZfgIkwAKCRBy2EO4nU3X
 VlaYD/wNa6uxkbCok+eZOEKA3UFTsmdHqKiDR3jSgtXT8zZBuhKVRDMUAqEgEpKQlk9R5HfKJMl
 gKbOm+Fsx4GUzL4+aCPe7/P8OPVJpYosLRGD6pN3H0mtbyKgZo2HGBvhzWhV5NFFnkKhKp8pYPW
 zqkIkJXw/WTB865ldOzBH8JX7izDhjzUj7CjqcA0wNTHy1zA+2Qgm/rkDkYxBMQA8Lpyca8u3Xb
 mO7qlEBuHvzOWFHaOkaIyV2/AuBmPrgYYTwyUBcH4yJkANpqURn70uYbgtakX3mKntrB7vgbpZF
 rqfcEeh5/9tD5i7kolgvjkwfZPgU7rqvUlNwDfY6mnTRamxM3A0ww2nBqu2q1YIQUacmTK06Nwf
 jQ9v+AxJld8piVs8VWxNO71K+oYOGqOK1Yr0p73+PFAOqLaAbZlVSVv2mw4AP/Nz9+i8M3w4sXU
 cfr8O/wE4CWbW8Edg9+vyzrHb/UhqB5EbQOPgCdT++4rGmSzSfk1Vhn3fwfh7f+pRmbQIEM9ra+
 lJnHqMmAr14hByZHkk50lzQImGj1dsns8cfzUl4/DSUkX+CG6vK/0eBDsSbdIDPDtnTxqFNJkXK
 Vp4BIg41DBivbDIDerlgjLgO4UyKGaQtlxZtVohhPgR6aherx7KerYw8ICFsSoqBt/JxcKZKg56
 VLgzP9gtfWZ4uEg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the @0 from reg to the node name, so that both dtc warning and dt
validation failure get resolved.

  arch/arm/boot/dts/qcom/qcom-msm8974.dtsi:106.9-109.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name

  [..]/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dtb: /: memory: False schema does not allow {'device_type': ['memory'], 'reg': [[0, 0]]}
          from schema $id: http://devicetree.org/schemas/root-node.yaml#

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index 5efc38d712cc..00c6526a525d 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -103,7 +103,7 @@ scm {
 		};
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0>;
 	};

-- 
2.44.0


