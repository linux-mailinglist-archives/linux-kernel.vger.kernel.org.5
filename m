Return-Path: <linux-kernel+bounces-75123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A0B85E39D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E518B23466
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6030283CB0;
	Wed, 21 Feb 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfDJIHCe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DBE8062A;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533681; cv=none; b=f8h0f+bq8GPcZa+jT323L0e4vPaQc235iV5fivnTbT56Vt1GZJfssqEkRZ3C5gp0llUeeS+LU461o2BmsnOT+brqRBuYETdlbuerDHingwLbIfsDQ6Wg05eD17p3AtRTzRV/UCD3cZILAjhXmyk0sYjY/c7ZoMvqCfFKH+EW0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533681; c=relaxed/simple;
	bh=L1+xlxuXwgUWeDmdy7tXdySuBS1Cj2Lrew9vVB8GLAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q/1Gn5UmraGc+z+ZnSq0PoB9bhSRuuTuSZg3QNVYPID2OvoLBtGVvvBF6qSEZHapJZhLpollTuBp0X6C4bpzeDyR44Icy4LmoaFuX1EdmuCbj/6Sn31HZDmXANm/sqZ+CfkiZVqfAED52t7fdyD2TmzOIUJANFv/ENxjeuRIwD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfDJIHCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4687DC43394;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708533681;
	bh=L1+xlxuXwgUWeDmdy7tXdySuBS1Cj2Lrew9vVB8GLAQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VfDJIHCeJSvOQawjAI2kuNtRJQPzl8p3WZaO8kg0iYRDN81Fu1ZcfEqNxGnhDvla9
	 hOeC6YfOYV7NhndG2E3Dpp2RH8JqcXYuw+RSkU5SCmds18df9ZDdW1uLsv5nTCa/8c
	 3Bhs65rvoAsc3RMIE08MZDWWVOhgk1b4AA73BoUR+zP+FgsZkPBsZLDOQ8bsDKJ06N
	 SX5sIkWCDfyzwdB75bG3wXI2Oh+c8iZDrvNTaEfHHZUbRGVWtCwnGWG1+5lzCfYj22
	 1qQhPxOvmzX1WwRLMG3udwxIrH1yNWK/IZ91yE9Xz6SF/MLZPMGDXeJsVkYkevOkMK
	 wgGdSFocHB6Cw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F042C5478B;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 22 Feb 2024 00:41:05 +0800
Subject: [PATCH v3 2/8] ARM: dts: hisilicon: add missing compatibles to CRG
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-clk-mv200-v3-2-f30795b50318@outlook.com>
References: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
In-Reply-To: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708533664; l=766;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=tSrn3Xx19dNkcc4kh+ZnlOdA9N28v4ji6ZA0jvly4RQ=;
 b=5BCNDQfT7CjgnN2jJMO2HjSM6j0VK6bm+CdCgzfdrrknvjWDL3zs2VSGfNMtjj3l0/lNw+ty2
 W9EU7FpZ9GMATHftPFrA4bNKEeHKJq62DDrU2GSkptjMtbKGq9kDWxK
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Add "syscon" and "simple-mfd" compatibles to CRG node due to recent
binding changes.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 arch/arm/boot/dts/hisilicon/hi3519.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/hisilicon/hi3519.dtsi b/arch/arm/boot/dts/hisilicon/hi3519.dtsi
index a42b71cdc5d7..da46e01b8fdc 100644
--- a/arch/arm/boot/dts/hisilicon/hi3519.dtsi
+++ b/arch/arm/boot/dts/hisilicon/hi3519.dtsi
@@ -35,7 +35,7 @@ clk_3m: clk_3m {
 	};
 
 	crg: clock-reset-controller@12010000 {
-		compatible = "hisilicon,hi3519-crg";
+		compatible = "hisilicon,hi3519-crg", "syscon", "simple-mfd";
 		#clock-cells = <1>;
 		#reset-cells = <2>;
 		reg = <0x12010000 0x10000>;

-- 
2.43.0


