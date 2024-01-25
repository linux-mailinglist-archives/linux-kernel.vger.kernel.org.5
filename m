Return-Path: <linux-kernel+bounces-38371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F137C83BE71
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E67295E36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9233F1CAA1;
	Thu, 25 Jan 2024 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="05fsB2KL"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB691CA80;
	Thu, 25 Jan 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177722; cv=none; b=g97sWefzx/9VNNNKqXb02mltU/rafu5XMDTw6pNAR5Edcq6X31NFdJm2ZkKrcrzfBDrKUHYKzuU7TX/r2b/wUp6JrmUnhK1z/OKR9bkBmaTx+cXd93gHZJ9jJCNpf4oT2sBQwdgbUxGdQpktyLaQEOaNxfrKbLS/FSzmanPy4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177722; c=relaxed/simple;
	bh=VBnrfI7vD3DI2FPA/X28QU+hF15qOM5Zfh24FfPbL28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FSmK0PW/OG0yx37dTLGGj8geD8CxklAuWT1lFq6TwohEXaufghvBhI6G0liqQLjjfy6AyZXTFoN0KbTdvKvMtX+86iYkVT1rVOh6ZbLr/DJrVj0wQ8+3S/YyPVbDD9fs39KkLajtOBcllpocZMQh0nOKWGlx6rMqEyHFeY/x8Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=05fsB2KL; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C3F41207BB;
	Thu, 25 Jan 2024 11:15:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1706177711;
	bh=tzCVF+0hTipzC3PlmgcUpfi5ANU6ETXa1A9Lgb8gzWA=; h=From:To:Subject;
	b=05fsB2KLJrsCclca4K+/72xZmc23Qj7pnqHYAhMe+R5HFxJHxFrQiHNZsqtwn8pze
	 dIgMAawkjYctts+SyKgaJyh+QMYawvQirSr2ZysLhLK8VCFDduogfT6WtCcrVkpjmp
	 6NWhLlfxym5sigqddQ0vh7/VMerMFSDorzkgOybY2TwenzV5FT3cgyRA+vClvuCtHL
	 l3gtmTFmloI/4Z/R8vb208KN+P9EZtcYUc8uHBhFA38A7vh1w7l3V6bnUDMFpcI+s0
	 G8MilsMP3MholVjGM+f8iTuKtulIQeMD+olFJCXN8pIrwmBGsF6iQNkww7KgROVWFl
	 sB27IrERn9/Xw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/2] dt-bindings: arm: fsl: add imx8qm apalis eval v1.2 carrier board
Date: Thu, 25 Jan 2024 11:14:56 +0100
Message-Id: <20240125101457.9873-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125101457.9873-1-francesco@dolcini.it>
References: <20240125101457.9873-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Add the toradex,apalis-imx8-eval-v1.2 and
toradex,apalis-imx8-v1.1-eval-v1.2 compatible strings for version 1.2
of the Apalis Evaluation Board.

Version v1.2 includes the following changes compared to v1.1:

- 8-bit MMC connector replaced with a 4-bit uSD connector.
- Audio codec NAU88C22 added.
- M24C02 EEPROM i2c added.
- MIPI-CSI-2 connector directly to the board added.
- PCIe switch PEX8605 removed and PCIe now is routed directly to Mini
PCIe connector.
- Power measurement IC INA219 added.
- Replaced DVI with HDMI connector.
- Single-channel USB to UART converter replaced with four-channel USB
to UART/JTAG.
- Temperature sensor TMP75 added.

Please note that board version v1.0 (which reached EOL) is compatible with
v1.1, therefore toradex,apalis-imx8-eval and toradex,apalis-v1.1-imx8-eval
compatible strings should be used for both v1.0 and v1.1.

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..b877f940490a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1194,7 +1194,8 @@ properties:
       - description: i.MX8QM Boards with Toradex Apalis iMX8 Modules
         items:
           - enum:
-              - toradex,apalis-imx8-eval            # Apalis iMX8 Module on Apalis Evaluation Board
+              - toradex,apalis-imx8-eval            # Apalis iMX8 Module on Apalis Evaluation V1.0/V1.1 Board
+              - toradex,apalis-imx8-eval-v1.2       # Apalis iMX8 Module on Apalis Evaluation V1.2 Board
               - toradex,apalis-imx8-ixora-v1.1      # Apalis iMX8 Module on Ixora V1.1 Carrier Board
           - const: toradex,apalis-imx8
           - const: fsl,imx8qm
@@ -1202,7 +1203,8 @@ properties:
       - description: i.MX8QM Boards with Toradex Apalis iMX8 V1.1 Modules
         items:
           - enum:
-              - toradex,apalis-imx8-v1.1-eval       # Apalis iMX8 V1.1 Module on Apalis Eval. Board
+              - toradex,apalis-imx8-v1.1-eval       # Apalis iMX8 V1.1 Module on Apalis Eval. V1.0/V1.1 Board
+              - toradex,apalis-imx8-v1.1-eval-v1.2  # Apalis iMX8 V1.1 Module on Apalis Eval. V1.2 Board
               - toradex,apalis-imx8-v1.1-ixora-v1.1 # Apalis iMX8 V1.1 Module on Ixora V1.1 C. Board
               - toradex,apalis-imx8-v1.1-ixora-v1.2 # Apalis iMX8 V1.1 Module on Ixora V1.2 C. Board
           - const: toradex,apalis-imx8-v1.1
-- 
2.39.2


