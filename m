Return-Path: <linux-kernel+bounces-27936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA682F808
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96F61C20E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA262420C;
	Tue, 16 Jan 2024 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKtpUH8d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90212BE9A;
	Tue, 16 Jan 2024 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434618; cv=none; b=Ajk5JdnmcgSB0+Dqb1p4v7fT02prunoF4CqcpNH8LNR6N7cjos+uD5S0GJcHk3USpuJuPv0RQbJNn6uztyRNrzbOxlDvYq5sBmOpOL/AVxQVywKmW1d8lm8RLhdObDI5bShtMXtgRN4gV2KO42XY12gkbY9Zs6J4eb10GpWKhVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434618; c=relaxed/simple;
	bh=ccX/4UUczVpuy4l7jnfIDJJzu6NfWsD/XnZwD5e2b0o=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=jkq7QEx92Ezc2DDiUVrJVh8D5GkVjYkFrNR20RmSk7cBrRnIMyxistZ/2ddbMGtJdqnTA8G1Ykzc/sNgo7yeY2ZEYpRllOVTtRWz3BqTOtGRc1zxlNSKYTRozXP8VleVjgee/QouiiCx7VZ7WBBSrUjb2wo3TkYlw8CaEcZYokY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKtpUH8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DE2C43399;
	Tue, 16 Jan 2024 19:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434618;
	bh=ccX/4UUczVpuy4l7jnfIDJJzu6NfWsD/XnZwD5e2b0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKtpUH8dMMAhcFvKXsCPkzrOPNXk1cdszeQXYzCt2S6G4Y4cseuISo7nGhmOFZhBH
	 LGhMn3B4Qkc0UuemV/BtBGsMKo1HOXSCLbrZFP19/hio9/UZrqeNcER1aRhpjQt9dF
	 npAqM69LImxUm4O9zcQpukGoEoHhNHdHYr+zX9ek4mmq6WlYUlEpsHy4gucY/j6ZOx
	 eLrDzyfpJMBObP04pIwujWL+H0qbdR7BeUh5fZZ8uPV85T98q2SmiWo9/sHh7Wr0IB
	 UqslIVjaMEcL2nzDmSraOiM28tCLTamVnK9eMkqv1eiNLVzYBEPL4orxpXMgGP6s8Q
	 gN+4y6dos1AOg==
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
Subject: [PATCH AUTOSEL 6.6 028/104] ARM: dts: imx7d: Fix coresight funnel ports
Date: Tue, 16 Jan 2024 14:45:54 -0500
Message-ID: <20240116194908.253437-28-sashal@kernel.org>
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
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi | 3 ---
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi | 6 +++++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
index 4b94b8afb55d..0484e349e064 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
@@ -217,9 +217,6 @@ fec2: ethernet@30bf0000 {
 };
 
 &ca_funnel_in_ports {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	port@1 {
 		reg = <1>;
 		ca_funnel_in_port1: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index bc79163c49b5..2e3513b7111e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -190,7 +190,11 @@ funnel@30041000 {
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


