Return-Path: <linux-kernel+bounces-75129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A778885E3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5034A1F22E89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A185C85628;
	Wed, 21 Feb 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+MiuG1/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106882D6B;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533681; cv=none; b=CyEnBq+8HvFOay7a/tH5oCJSdPFGu8b0B4+4KGnwxfFRDXID/icXnE+HP6Cc5sNulDshWbEwISuJC6UwZTgp3/gBlu/XD0NFHXCzsQJrvRnK1+XI/sAtnyDGSxaFWukj5vme1axmg7OHOaRhXsul9voM770TFw3uIYt1VApqpXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533681; c=relaxed/simple;
	bh=jQ0Gp3tRoAYTrssZo+hDxMLFbJdD/KIwBxV4lOrp4wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ub0i4Wqy1GDYARWJw8LL4szdbdMu3g8x5K/Z9/DBGOXfme6PzMQY13JykkYFXBLfGDA7sztuBBaLS76fULpUt9se/NGvjRBazJxA+ETBet3DwY9/03q8A69GAu8JsUoBHhbJeRDZ6nsaLcu0kUA8+L2viCeFx3tt/nATPx0u4Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+MiuG1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71D2AC4166C;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708533681;
	bh=jQ0Gp3tRoAYTrssZo+hDxMLFbJdD/KIwBxV4lOrp4wE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H+MiuG1/crM/qEcyJUG0GVNTqqbZqSni17q9DyxfSFaP2SghSvAp9W/Zr3OzWWbuv
	 CtHWcRfLPU6RgS7bnXytwE+ycRsUltirOHxCJ8cRIQbrp643uzrXhNPzcHDJmIKh1H
	 CyWTYm26A1Jc5PHySv/UdGoQanxlDsHmP7BbPS5X3nqutW9AI5N6ZXcWja1vVaD71V
	 z6UZ5J2K71wcoNh/P7ETX5ilKtlklwe4/l14eoi8SMtylLNHCXI34R1leeWMnIAMEq
	 t/ljiMGlIybU6SzDoSZna2tFsfBCoZIqZcScO3E+mNzQJ6U66+8ebdzYZis1GL79f2
	 4tkVTEnx8I6UQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BAAC5478A;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 22 Feb 2024 00:41:09 +0800
Subject: [PATCH v3 6/8] dt-bindings: clock:
 hisilicon,clock-reset-controller: add Hi3798MV200 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-clk-mv200-v3-6-f30795b50318@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708533664; l=838;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=loFK3Ng4KJm9y+N05vI2yM21cRI/NAqIUEkGNGWtP4Y=;
 b=RE3IgR4NkTHq8jI65Vbtpjsp+Mb81PnG6e02E5loAnlQCbCQ+3BGgQxeJejJjpWTgvhLIPGKJ
 XT30dX1tsfdDvnjuZJTOEarmYcyO8wDtkAGq9qZZwYC44VFMBP8JnMG
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This SoC is similar to Hi3798CV200.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml b/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml
index 2cf21cb5ff27..41d35de47252 100644
--- a/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml
+++ b/Documentation/devicetree/bindings/clock/hisilicon,hisi-crg.yaml
@@ -22,6 +22,8 @@ properties:
           - hisilicon,hi3519-crg
           - hisilicon,hi3798cv200-crg
           - hisilicon,hi3798cv200-sysctrl
+          - hisilicon,hi3798mv200-crg
+          - hisilicon,hi3798mv200-sysctrl
       - const: syscon
       - const: simple-mfd
 

-- 
2.43.0


