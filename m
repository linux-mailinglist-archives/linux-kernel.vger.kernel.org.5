Return-Path: <linux-kernel+bounces-28187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4980782FB53
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2AD1B24052
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55881163AA8;
	Tue, 16 Jan 2024 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1e8Q/z8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A1664AB;
	Tue, 16 Jan 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435407; cv=none; b=EwSLhJB+bGFk0ymZEn3UAjoLNCRIK8eMqw6iQPoG87Hf9FvKIjGgTPDvfJFML7SaPF9UoyMqsXtC9vmoNifcPFoMmHBj0spg7j/XTFUoxIaiFq32jxrNMe8GuSX3dz6cC3ERkwQZrWIqbv1FfOhr4YbwDLLAoxSLAtlsq0NkMoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435407; c=relaxed/simple;
	bh=nzsN26+vLu+X6BikyvoklfvggpDqx0n5Eto+x0OdDTk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=kafZxKQPfM80oZpI8PwrUW0Ataaw03y6nsom2huR39W/EQYKUZvKOlOk6XIBDNNcrjVylPSEC8ro4XZmUCoJJp4dTxl9jhSei4ZVA4y/hvS1KRTUt32Sb7Zi1uaR5XiDwFnB0HGotOFjGV5ci4KYZ2gxWEAuYqes91/vmwm97ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1e8Q/z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A7CC43394;
	Tue, 16 Jan 2024 20:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435407;
	bh=nzsN26+vLu+X6BikyvoklfvggpDqx0n5Eto+x0OdDTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1e8Q/z8Bi4PcJ5qmS0KdZlkLKsj/8fqoE4HwLdkCzAZy6H0LukhaUcW4xX99+e1/
	 IuOE2aHgnjUmQA6JWK2k8NTFxC9zsP9cisvq+pdmQdVhKue3aPR8hY27s5oSYUzD2m
	 734+7uR60acQiFGAR7BQ5yE1PjJmXyEiy2hscitWjIjndvio4QkniAp0zvOu7uVF4b
	 lYu9WKfKyto6DJ3QZxrE+0qVaG2g3OcKWHGqftHdjEDWQ+bZ4Zc8i24kHSyvBgzQZE
	 GtCGSFA8T8p5gGXIRje/ufWJSsFFja/V25/9FaVkLV+8eoAjRJ180pvSp4OEX3jOUZ
	 cxqq7TrPWzMuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 07/31] ARM: dts: imx7d: Fix coresight funnel ports
Date: Tue, 16 Jan 2024 15:02:16 -0500
Message-ID: <20240116200310.259340-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 0d4ac04fa7c3f6dc263dba6f575a2ec7a2d4eca8 ]

imx7d uses two ports for 'in-ports', so the syntax port@<num> has to
be used. imx7d has both port and port@1 nodes present, raising these
error:
funnel@30041000: in-ports: More than one condition true in oneOf schema
funnel@30041000: Unevaluated properties are not allowed
('in-ports' was unexpected)

Fix this by also using port@0 for imx7s as well.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7d.dtsi | 3 ---
 arch/arm/boot/dts/imx7s.dtsi | 6 +++++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 8b65ca8b5f30..2b9d0b1bd982 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -204,9 +204,6 @@ pcie: pcie@33800000 {
 };
 
 &ca_funnel_in_ports {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	port@1 {
 		reg = <1>;
 		ca_funnel_in_port1: endpoint {
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 7ce541fcac76..33e9c210fd2f 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -183,7 +183,11 @@ funnel@30041000 {
 			clock-names = "apb_pclk";
 
 			ca_funnel_in_ports: in-ports {
-				port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
 					ca_funnel_in_port0: endpoint {
 						remote-endpoint = <&etm0_out_port>;
 					};
-- 
2.43.0


