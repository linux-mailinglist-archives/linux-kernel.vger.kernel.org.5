Return-Path: <linux-kernel+bounces-28160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5606F82FAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683A0B25AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB7515E285;
	Tue, 16 Jan 2024 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9oGuL5I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D027415E272;
	Tue, 16 Jan 2024 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435300; cv=none; b=sXkQum1FGypKCshguK1QE7OQNcWHHMr1TV67ilRftR71NSgjZ0wxPnsWC7AAXSIZe2HHPhRhGb+CeCO0QJUCCagXxHbM/auHqwCloiwRlQjvZ0Sz8IkWqGHHR9vYYoJ5fltgrTgMlzplaGvY54FTTy8KI48MhgRTAEwJ9/kGr2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435300; c=relaxed/simple;
	bh=uwVLloBRdccwgje9BLUjzSaV/tJxTpF1y6Cch1AdSj4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=MvvoUIXtx1rqYizaT8KZ/IRZiikJt30ORNNEfHBr6DYNgGNIQ+8t/EiEZQtgCdJkaWEP4gwmyZ/hEsqz9W5rGJ2/7szUmImBAIUTBqvHKHcEgBO1xuxpss5GTasa+Fg05XQyturvkPZwospQJIgOxBhqWI6PJa8Wk0Qzf6awqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9oGuL5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9AFC43601;
	Tue, 16 Jan 2024 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435300;
	bh=uwVLloBRdccwgje9BLUjzSaV/tJxTpF1y6Cch1AdSj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9oGuL5IBIDjMv17oK045xRq/Yxkq9oeDBr6xsoB/WVEmFJkTEGawNqssXA+lePDW
	 Y+YN6YkcmXhKGgSpfRE8KsIUbWY6j9Qua7ENGRiajNy7shiA/+2+dsERK0MF/rFFUh
	 f7JxeDB10Wh1Q1HrBUF4qHAKtvDDfVctbuqo3ExskLzEvDibI1iUGQkuFtzv25ts04
	 gRabWnT6SVJ8to8kax9TbY4DVSxYJxUhdLbdugtFC1YqZAMsr9ruwDCsY2NZ44OYZa
	 wiZyIAJ72n5ZT8cnvjUwCBzW96dBKGtg4OlU03c+aoykvbtNzs/RwJslRhfPIOhMUK
	 p9wtJ0StFt4EA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 24/44] ARM: dts: imx1: Fix sram node
Date: Tue, 16 Jan 2024 14:59:53 -0500
Message-ID: <20240116200044.258335-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit c248e535973088ba7071ff6f26ab7951143450af ]

Per sram.yaml, address-cells, size-cells and ranges are mandatory.

The node name should be sram.

Change the node name and pass the required properties to fix the
following dt-schema warnings:

imx1-apf9328.dtb: esram@300000: $nodename:0: 'esram@300000' does not match '^sram(@.*)?'
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
imx1-apf9328.dtb: esram@300000: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
imx1-apf9328.dtb: esram@300000: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
imx1-apf9328.dtb: esram@300000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx1.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index 9b940987864c..8d6e900a9081 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -268,9 +268,12 @@ weim: weim@220000 {
 			status = "disabled";
 		};
 
-		esram: esram@300000 {
+		esram: sram@300000 {
 			compatible = "mmio-sram";
 			reg = <0x00300000 0x20000>;
+			ranges = <0 0x00300000 0x20000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
-- 
2.43.0


