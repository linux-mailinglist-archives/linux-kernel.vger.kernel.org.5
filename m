Return-Path: <linux-kernel+bounces-108710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF2B880EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0931C21F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0300405C6;
	Wed, 20 Mar 2024 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgxinzTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6707C3C068;
	Wed, 20 Mar 2024 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927869; cv=none; b=JH9rzwY0N9Mu1k87R2E/lt+oSXH41mhiMFsES4WpG6SglqMCADv/KMR5W/5YULcw7pvCY5fCIoMnL5cVOilTxYCqba2u8rks4hRAJlcr0wuq5T3YDaEyMGZO18kNNAaeLpK3p0fctxTgzcwxGfvO2P2irk1oyJLEEXfMbznHHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927869; c=relaxed/simple;
	bh=QO0LZCtSW8apYYXm/bnhc9+79zlXJs+onlGEOcYTAEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NaSOIRLPYZxYm69/5lf3gfxwXxfxjLucJB0u5n9IcuSmFXjPLpq6dS1uO/KxuCvf7umWObH75/Il7ykmKTb9Q2N4M9S3vJ/N8TXc5sLZ7adIX9gvo6xYCHz6Hgxt4yq87UXQYnwzVNLCrvzNMX+UzMsHEiMxMEE9Pfl8NXaCWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgxinzTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A62AFC433B2;
	Wed, 20 Mar 2024 09:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710927868;
	bh=QO0LZCtSW8apYYXm/bnhc9+79zlXJs+onlGEOcYTAEA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YgxinzTyd6ZofH2Y0OdXgs27eeV26pdVZCt+CwZon4Z+lvTQRL5MLAJDPS9xPsh4d
	 XVQQbDg5cEhP+LLtsNxo5AjnkU1hkjB7eOuz2KbICB4Uhsi3dn2qVoMzSkkTNAMxKp
	 h3KrX2Dv0rfZTxSrH79W+2aHscqYtPJlTzTVp8Dotn8jC10sDAF55CNH3gJtgxQjf6
	 L9lfxDnseIfmnM9S69UFdjhbRbZM2vOkYWqhoJSkXngvrP26ab61bc8YJZNWUn79AB
	 d52hASYr55Ow9QH3cWWWhf1+406m3IULw3xiFwSF9PmUCsCtqCu94XF+M4VFknwTRA
	 Q2IHOPahi811w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1C3C54E58;
	Wed, 20 Mar 2024 09:44:28 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 20 Mar 2024 17:44:15 +0800
Subject: [PATCH v2 3/5] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for A4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-basic_dt-v2-3-681ecfb23baf@amlogic.com>
References: <20240320-basic_dt-v2-0-681ecfb23baf@amlogic.com>
In-Reply-To: <20240320-basic_dt-v2-0-681ecfb23baf@amlogic.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-serial@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710927866; l=1045;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=UJBOI4szfDVcoXnl7lw01lakzjuj2KmlihYXzmVHsfw=;
 b=8pu+V1R6pp5VQ+slxCMO6g68EDljBjihstf8hEg2+4Whq2atJPLqkR9bOPCaPMXyQFShC+vkD
 gtm1ft8HeXyA9/EvkLIi+Rxh5hsRPh2jF9/IO0jA4BLReHJtoAbIhRh
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Amlogic A4 SoCs uses the same UART controller as S4 SoCs and G12A.
There is no need for an extra compatible line in the driver, but
add A4 compatible line for documentation.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 2e189e548327..d05c45815dc2 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -54,7 +54,9 @@ properties:
           - const: amlogic,meson-gx-uart
       - description: UART controller on S4 compatible SoCs
         items:
-          - const: amlogic,t7-uart
+          - enum:
+              - amlogic,t7-uart
+              - amlogic,a4-uart
           - const: amlogic,meson-s4-uart
 
   reg:

-- 
2.37.1



