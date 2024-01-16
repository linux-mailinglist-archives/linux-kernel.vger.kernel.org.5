Return-Path: <linux-kernel+bounces-27980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C787382F8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6151D28DE60
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAF32510D;
	Tue, 16 Jan 2024 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Biow0Uu2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1915A7AB;
	Tue, 16 Jan 2024 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434744; cv=none; b=coqrz+w/ya8Xo5iOCqUeyjqLuj7UExlLgOhmEl5UO51GuMfLSDGGqImMGqp7TFUXjGJBD0mokEehs7+34SmAaS35MNj2SKL7w6WPboTOAS5tROJXN142PanApfyCpnGEubaQLwbJJWaD5J21b0VfxgibIDvw+OshxQgK4Belza4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434744; c=relaxed/simple;
	bh=q5vP/0Qb6qBjYXsKqokqy1x41hQ1MKaIT7XBq712DHk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=J51uIODwF9CypqCkJomYIRVMigbClCO838wUXJvUs8XNf9eYTuBGgYaUFSMyq42PfasKfNOwVtPotu/5DBIdBXdAYBELVkwV5QD4DlRtZoy42V8dALCCpXGfUQ6ZH3Lln6/fYdk6nUFzcDBOPeu2U2ivE7p/4iD0bF8tJHDXFPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Biow0Uu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF24EC433C7;
	Tue, 16 Jan 2024 19:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434744;
	bh=q5vP/0Qb6qBjYXsKqokqy1x41hQ1MKaIT7XBq712DHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Biow0Uu2pq2CYpQCMJyFEmeXLMIe+FGugyU/CdOJrTOYolEXivq8uCtHrxBkd9l2L
	 d3yhsYtyr8ZRSeh+J+mEie7N+bjq1iIGrCqKQuIm1mJyHAb3mu2C186g7CASxNHzxS
	 RDz9mVq4cDFtE+tBJ0IQslTqfrf6Cevj1pBDbBP9sd3SbuNDDpYT8AABG69M3X/2+E
	 i4o5ZmAIIu+p0vDwP+pDfe3KT8XMkoaYFcobnuBXFQjZ9Jo3RFif8U5ECPKElMr8KE
	 jn1Ne3b7EpKvGldqRI/iq7EHgiM6lqBw4grZSg/jlOWnPfoQUxNs9XNJai6tC+ftgC
	 2Vq4sgQ+AMAHQ==
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
Subject: [PATCH AUTOSEL 6.6 069/104] ARM: dts: imx23-sansa: Use preferred i2c-gpios properties
Date: Tue, 16 Jan 2024 14:46:35 -0500
Message-ID: <20240116194908.253437-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit e3aa1a82fb20ee97597022f6528823a8ab82bde6 ]

The 'gpios' property to describe the SDA and SCL GPIOs is considered
deprecated according to i2c-gpio.yaml.

Switch to the preferred 'sda-gpios' and 'scl-gpios' properties.

This fixes the following schema warnings:

imx23-sansa.dtb: i2c-0: 'sda-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
imx23-sansa.dtb: i2c-0: 'scl-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts b/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
index 46057d9bf555..c2efcc20ae80 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
@@ -175,10 +175,8 @@ i2c-0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio1 24 0		/* SDA */
-			&gpio1 22 0		/* SCL */
-		>;
+		sda-gpios = <&gpio1 24 0>;
+		scl-gpios = <&gpio1 22 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 	};
 
@@ -186,10 +184,8 @@ i2c-1 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio0 31 0		/* SDA */
-			&gpio0 30 0		/* SCL */
-		>;
+		sda-gpios = <&gpio0 31 0>;
+		scl-gpios = <&gpio0 30 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 
 		touch: touch@20 {
-- 
2.43.0


