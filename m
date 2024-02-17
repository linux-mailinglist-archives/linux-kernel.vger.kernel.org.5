Return-Path: <linux-kernel+bounces-69849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DE6858F73
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1651F22C2C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DC87C09F;
	Sat, 17 Feb 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHsVHxvc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7097AE57;
	Sat, 17 Feb 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708174337; cv=none; b=Ec951hLrDV66uQRyp4iRCf93Kvs+HALIONmiT4Oy78AXXOaweSx7F4m9WroeIWDB+3HiEqNntodJ+f1oFE+qALLg1IORRiX3OuIdpRtNILLXuKFUQOnGHGV4k9L8cvnloKi6BBhxxKklyrjOIgn01RO8+VwmoMcAa/2vA7LZVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708174337; c=relaxed/simple;
	bh=FkHfs215i/8Z+eaYHNR3iHYK2NPUkkxq76nnfgbpp0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9UBEzEV+2+n9rMG4Nj3hkpvi/D0FgpHkVIpW7VPd1GMRZ5txObdyDN0zUr56I+BJlPSwP29nvZGcrVUA/KKTFkOS60R/J+6G1klTfT4RZbhwEWgTycTJ2cnLoNzL9TUyhMEhGOhCSzvKSLhZzQ7L/9+0TN9HJfLmYJzVtDBEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHsVHxvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B993DC43330;
	Sat, 17 Feb 2024 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708174336;
	bh=FkHfs215i/8Z+eaYHNR3iHYK2NPUkkxq76nnfgbpp0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AHsVHxvcNWcWhTsxnyRo3rxdG/ab9GMn1Jh+uIgU0w3S0erYLBaQ8NH1uXxXbQntB
	 Jt13a3H2VLsTo/kTaya+DXpRHSRdOK+yYzbhO/XhnRXiQGlmQ+1MdHEG66nkizYl5E
	 giJSq4JBPFJED9HATAPKdQpe7qg6LFbwXOizBLtCsb6MFwtBs2OK1EY+ecJYkUgCfU
	 Kj/IytmdeOQpAWLdouXqjzkbMuzbacvU2N9wmgTDoWU8FwvwsWmVyMycRo08uACC2n
	 DSsLzUj+F0yWLGW6eiIBOSeFy0lhl07ew2RFftbcU8bWOGKqeipihRvi5BZvXgl46f
	 Fg3HoNsjs29Xw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B4AC5475B;
	Sat, 17 Feb 2024 12:52:16 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 17 Feb 2024 20:52:09 +0800
Subject: [PATCH RFC v2 4/5] dt-bindings: mfd: syscon: Add
 hisilicon,sdmmc-sap-dll compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-clk-mv200-v2-4-b782e4eb66f7@outlook.com>
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
In-Reply-To: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708174332; l=904;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=hib8+Rqu7vbvM/wf1lKjdv6MYEK2HbXcsYxRmMDXhQ8=;
 b=TbKhd4smlf4/y17TROgnbw6vhFb4reum+h1UK3DTNNalQKvaZIeuQOlGKC8YwkciwyqNv68OV
 C7ldoY7k6UaBsftg8OQkEKyg4sn69Vygm+RdKlNM9gg6j6eSlSN5HGM
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Add hisilicon,sdmmc-sap-dll compatible. This is a 8 bytes range with two
registers. Mainly used for precise sample phase selection during eMMC
tuning.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 084b5c2a2a3c..c685d4b36ea4 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -47,6 +47,7 @@ properties:
               - hisilicon,hi6220-sramctrl
               - hisilicon,pcie-sas-subctrl
               - hisilicon,peri-subctrl
+              - hisilicon,sdmmc-sap-dll
               - hpe,gxp-sysreg
               - intel,lgm-syscon
               - loongson,ls1b-syscon

-- 
2.43.0


