Return-Path: <linux-kernel+bounces-126716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A0893BEA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF67E1F22219
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCAD46521;
	Mon,  1 Apr 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoFd1Q0x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E5646449;
	Mon,  1 Apr 2024 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980603; cv=none; b=N8vDBWWmyo34q5ckOjy2XLWQX0WbCZTOPKgPc4wRMIgbNL3SV7ZvaL4rneiv0J3zdPWiobbHeUFsm/bhPCmTih/Cmrtb9iTJAHY9m3XMHthyIssyjSQUYlVpvpq7tkPNim6OWFwcpPgGGdHI51XJAXlH6ehAy7xVCtaUNA75w6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980603; c=relaxed/simple;
	bh=+YrzJseVQ3AYYuXDh6qx3fE7+Vnz8W59V1Qp4qWxayA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MpTeVteOErBILtQ7Sd35OTuEXGN09307GXY4dENvbcNYi7M6mXFNVRNxLnQfclJAIEdBQFneMHK2HkFyF396MEP39Mahx+sJi9/B0Q0UAR+HsDHgN6saE8tvgzQRmu4JzeFrevMjeild72HMa3YRze5Os/nh2HpjnhlRTQTYYEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoFd1Q0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85058C433C7;
	Mon,  1 Apr 2024 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980603;
	bh=+YrzJseVQ3AYYuXDh6qx3fE7+Vnz8W59V1Qp4qWxayA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PoFd1Q0xUQtUpzqHSQXQ8wcnMQpcIYex2LndB9donLtq9KTtdItTwtpGczSXkHHcQ
	 wbpKdogvBVvUVhnucrnmR2pQiebI6w6XCvZxgJti9h72h+PHWDhjubaKyIB8ypPdud
	 zAUa+0tdny6uoJ/JMXPyrROP6m77vAaUmvLYEeRVnuvnUjHohTfbCaf0NoXsVm0Tc3
	 A5rs0Vd1HAdM61SSZ+j/0gfv/k2us+tALy7xOZ4ma+gnJzMVO1qwyWqvQS1iMLhqNu
	 iHwvv5oMbd3DlHxFiQaxgosIIZkeURaKwEL/2FSmLPZ28fqmL9ClytDRLnibI0x2nk
	 7d2O+FcLA4Psg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/4] arm64: dts: uniphier: ld20-global: use generic node name for audio-codec
Date: Mon,  1 Apr 2024 16:09:51 +0200
Message-Id: <20240401140952.97923-3-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401140952.97923-1-krzk@kernel.org>
References: <20240401140952.97923-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devicetree specification expects node names to be generic, representing
the class of devices.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index a01579cb3b79..a4c86137f424 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -111,7 +111,7 @@ &comp_spdif_hiecout1 {
 &i2c0 {
 	status = "okay";
 
-	tas5707@1b {
+	audio-codec@1b {
 		compatible = "ti,tas5711";
 		reg = <0x1b>;
 		reset-gpios = <&gpio UNIPHIER_GPIO_PORT(0, 0) GPIO_ACTIVE_LOW>;
-- 
2.34.1


