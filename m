Return-Path: <linux-kernel+bounces-126712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DED893BE2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB5828231A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320C40872;
	Mon,  1 Apr 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lT0uyulC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C83405EB;
	Mon,  1 Apr 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980586; cv=none; b=Ovy14JqsJ4jCdd5u/copsBnGp1HCeO5oMjJtHNpBGe10Umaa7QcMRGjPrIu0u4qthGf6CM6DvnOoLvYZL2c5H4tBGbzzuSBLLS3p/z5sG1bH2TJQiyX71329TvwW4vgIwhjbnKwolq11Y/HXtC25hx8Lfg0q10t/Mkhj8vp/qiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980586; c=relaxed/simple;
	bh=5MUF/ceJ0V6f/molmHs7FVQ1bFJrXBJgOD+wniJKJX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ad40Jc/V7/+6JIHVS30h0iZws60hrUzLwryZN4dE7OzN8i/HKFZwlDRtSI3b05OFKs5EDeKli/MPk3gAqh6YuhkrBShJQLcU/FjmNC+UEwhVz7fVU3k8o0Zs3gknKTpu8an6Mywy7dnS7u7otJ7t/vFU5v53u8JN9umReASZ/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lT0uyulC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03301C43390;
	Mon,  1 Apr 2024 14:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980585;
	bh=5MUF/ceJ0V6f/molmHs7FVQ1bFJrXBJgOD+wniJKJX4=;
	h=From:To:Cc:Subject:Date:From;
	b=lT0uyulChySnL2/gHmtGp4uVbkYLYeSjEzqotmZEoeQB89X2oq0Udq3DaXUmOSbab
	 /u/CGxmAeI2SbTMHBIMiVCs5lLvuVbBbS52pJ9WT8+y+Ei2I0ZcPID6CbGwVB+Zjuv
	 nVERmvXZpOVMtSjFHL89JPovdD4bx+NJAWar8uoQnR29H+daA6a9lJ2DsFCXGTMaBe
	 8Jdn3OAVl6qtkQ0Djtievuk8cuNR6jdHWfhHXkWZHJxcXaXCOJfK/MeZvGD4MFQfzt
	 b6ngLjEePq3NHe0PL0n9gwv6n59nkjsWaaBJFmzVuvu/y+q+DEkhbmsDdiNExPuwQg
	 t0F0d4sDvK1QA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] arm64: dts: rockchip: drop panel port unit address in GRU Scarlet
Date: Mon,  1 Apr 2024 16:09:39 +0200
Message-Id: <20240401140939.97808-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Panel port does not have "reg", thus it should not have unit address, as
reported by dtc W=1 warning:

  rk3399-gru-scarlet.dtsi:666.32-668.7: Warning (unit_address_vs_reg): /dsi@ff960000/panel@0/ports/port@1/endpoint@1: node has a unit name, but no reg or ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index 5846a11f0e84..6d1e3ca86392 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -663,7 +663,7 @@ mipi_in_panel: endpoint {
 			port@1 {
 				reg = <1>;
 
-				mipi1_in_panel: endpoint@1 {
+				mipi1_in_panel: endpoint {
 					remote-endpoint = <&mipi1_out_panel>;
 				};
 			};
-- 
2.34.1


