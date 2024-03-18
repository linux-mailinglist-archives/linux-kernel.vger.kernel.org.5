Return-Path: <linux-kernel+bounces-105865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755B87E5B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334BA2814A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AD62C6AF;
	Mon, 18 Mar 2024 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="mNVP9oTM"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743DE2C198;
	Mon, 18 Mar 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753953; cv=none; b=UqJ2H/sMuUz0TSRLz7eAl4TEJ/sSnTpe7+2rM1DjaCgFQMKSoX1C9cgL/EK+2Q8yEGpWBj7kLisRuPEgOqQ6T39lx3klwgR0j4EWKjHCg9/raDyzfQZPkV1urUTRo5DSlRHfnGG/BPf6+r2TPCxSA22ciBqLgOmQ0HGuAm0GKhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753953; c=relaxed/simple;
	bh=v8NmZif2R7NfoK244LBSsq4XH52XXW2UnbBNF5FTHx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJPb6Mk9qJ4kvXHUtJpXDog6fbCyccxxOKM0vT6Kn5jupUrADUFBzcSvlr/paDWqcsGfFJkqGO35rVbas6Fjzr3cFHWThB3GlN8d1kQ4p3FRLT/FeINFWsXntL7NKtCqVX3zvj088baGCcZ08KtqpwoKIIVVU/r1do1Pdh6UX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=mNVP9oTM; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710753943; bh=v8NmZif2R7NfoK244LBSsq4XH52XXW2UnbBNF5FTHx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mNVP9oTMJW0588rpFVwDMwewLQRvgkmCRYf2zhbiMmfOhz/CqgS7vhwKV+R0gIyPs
	 cwhDmTdx9JhBH/8lc71dEGvj1SxhlIVTbWN2RYzh+bzo7jRsRlHmA4b/IRWhL69emF
	 X7tHjrUf/A++FEmvV4DLnkhrcwGnVGQStZ6DzTfM=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Mon, 18 Mar 2024 10:24:42 +0100
Subject: [PATCH 2/2] ARM: dts: qcom: msm8974: Add empty chosen node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-msm8974-misc2-v1-2-f71668a2b8cd@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=724; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=v8NmZif2R7NfoK244LBSsq4XH52XXW2UnbBNF5FTHx8=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl+AiU6Rkw0NUtnd2ygfeKy5xsemyakGvlFHUEN
 /trnj3sjZqJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZfgIlAAKCRBy2EO4nU3X
 VvyTD/4wH3F8w414Kd8a/hJEpcrI6e3HWXExzCXSsE1Cftt1AS/qM4GgxwfY6OBaS0R7NYbEm39
 phJ3vd1ScS6IzdzymPPvLiTkuliqFkfEcDKn/Bslhv+VqK9Z+bRVTTC+jqNnfTKq0sARNFOb8/O
 iXqUDL0FZKZ7OJPhVHmu46XF3D0EL3QsOA46YxVJ4cHsSyUJNFv4CNA7A4hn9uyteTceuaIa1pe
 KmcYlNq7LmjmD0OmUF04+wbiUAHBC3KhMzmZwlB98xU0u5KpsVy0vcY5X23rGc752JVNlVFwdUw
 2uXrltT7Xb5KB1G+HYGZZXnP4IWauvuE9tcYB8Lwuejfqe3jNaB0812jqGTNJ7z4yUidUkKnaTr
 8j4KTfWjbtV2Ln6yZiAsTxCThU70869JqFKryHyq3YBhduwyzToC3RXD/eNO3L05MqIFf6Up5AN
 /d+3s5qWHClwFj1ZJbqZIVgUJrNGSg6y+K2wz0zulFQH6o7zd63l+kplrmuT0CBGVExs/I6J2rm
 A9Ya4zo+keyV3AIJ/du4lGR7I6RS0bx+cQiFua0E4I6NkQpDbZwyQWr2d7HD4TxLUMzc+Su9l17
 LFk/H+/qIEMU/Ktvbfycm5rMPxGuRhSa3JkKxAC8KHQ6/x3ao+ROkgOwUHPaL+4ezNTOE3TbDc2
 mOY/yYY+plZ8Pvw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add an empty /chosen node to the dtsi like is common on most other
Qualcomm SoC files, so that various pieces of software expecting this
node to exist don't complain.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index 00c6526a525d..2ec4ec4e5d2a 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -14,6 +14,8 @@ / {
 	#size-cells = <1>;
 	interrupt-parent = <&intc>;
 
+	chosen { };
+
 	clocks {
 		xo_board: xo_board {
 			compatible = "fixed-clock";

-- 
2.44.0


