Return-Path: <linux-kernel+bounces-121886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE0F88EEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2277A1F33297
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23061152507;
	Wed, 27 Mar 2024 19:11:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8185814D2BC;
	Wed, 27 Mar 2024 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566710; cv=none; b=LpwkU+/YEsL8+y69ks66vWplu7XcvCVjnHi05AQ0sabw0L5AjTU2qS+gbxomuSH+SNBUghWhe7odV0r7qSAV/VvT6EFOtUJK+0vgPZOgUZDz96HjlW2MQLHsnny9KwBNUP2dnjUt7K+et7alWRdjFfeFnnmBlt/2Nxp+vBQXdrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566710; c=relaxed/simple;
	bh=wi3UudNlYPIq+1jzeag//Ji0vym5lrn/VexnhbraNx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XeA0zfaS1lOr2Up9wsgogm2EMPf5gTzPeYfC45+FwI1qO3LGMvLKZTvynDREzKjNu1I8BT8JG4ApDj8I4WHZRHyRU6rrIB/WuNqu3PxCfASJIcT4BOqUx1VgexgZiygXOiIWfMYRXT5zyqam7++kkkzbklbkTqvEynMga671a1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B1DC43390;
	Wed, 27 Mar 2024 19:11:50 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id AF2871060995; Wed, 27 Mar 2024 20:11:47 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 27 Mar 2024 20:11:35 +0100
Subject: [PATCH v2 4/7] ARM: dts: omap4: fix hsi-port node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-hsi-dt-binding-v2-4-110fab4c32ae@collabora.com>
References: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
In-Reply-To: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=wi3UudNlYPIq+1jzeag//Ji0vym5lrn/VexnhbraNx8=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBmBG9yLqF+Q7axsNcb7l9NE0t+tdlJ7+wqWT/j4
 uJW54pYAAaJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZgRvcgAKCRDY7tfzyDv6
 mkYmD/9wFvwBiF6wSSaUM2Wpt/pkZ/K6OQGYfev3HEMXUOHQKCCPgV+A4KaQpk2d3tnF3w5D3ip
 P6rzN87Wczv99BLKdVXLI4irVk8EIlDoQP20PpXyzUqxjj2kUBoCEI6bFGqSYIdjQjozN2CZQ3W
 knvbflPuFuMwJLk+mo+fESP1UkQsItSiq84TmfkDtMATIbacP88lfKyE6pu6nAygURLZR0cVEG1
 5KvCEWgoZwwdgLv1U9Jjd6KlS1DBob71Bz8d9YgVvDblLSHxLWjz/bqeOTmOZY+zc3/bFi1ljqy
 GEpwXW1rLKGINqbdBhcl06TEtUhBdHn9cfkKse6f0qviCJ2RReTBASLmoEV5GMVQ4hAn2Q9jNJN
 +2sFN+yHW5Cit2IZWZjYSYe1f+IP8nvv0zqKawM0HdRTkPGfDPDWrI2IlU5wSzPQLMXZH7Yn4op
 ILrbFuocUO3br4RvjE9u3CyJTYG1obIXmxVYeTmFJV/COZk6wUlulYALPUVmdJ1W/U91UqDC4kQ
 oKWDeNPZHkQBXydDVKgeFszA3CqDn7Xe0QyrK4FvaomamzHnlO5PhguaQtZ8UAo4oid38lErluD
 4JcQmIsE+gSrqID+GDg1T0jtEXlidTMq1/dwpBviUVXVZpropFSHBnrFyVBhxQUCXpSez5DWelA
 rT/Isb6JbkvtRxA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The DT binding specifies, that the node names for the HSI ports should
be just 'port@<address>' instead of 'hsi-port@<address>'.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
index 3fcef3080eae..8963c966cac7 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
@@ -214,7 +214,7 @@ hsi: hsi@0 {
 				#size-cells = <1>;
 				ranges = <0 0 0x4000>;
 
-				hsi_port1: hsi-port@2000 {
+				hsi_port1: port@2000 {
 					compatible = "ti,omap4-hsi-port";
 					reg = <0x2000 0x800>,
 					      <0x2800 0x800>;
@@ -222,7 +222,7 @@ hsi_port1: hsi-port@2000 {
 					interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
-				hsi_port2: hsi-port@3000 {
+				hsi_port2: port@3000 {
 					compatible = "ti,omap4-hsi-port";
 					reg = <0x3000 0x800>,
 					      <0x3800 0x800>;

-- 
2.43.0


