Return-Path: <linux-kernel+bounces-28097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A59682FA31
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D43CB266E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD9D1509A4;
	Tue, 16 Jan 2024 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vABA2QqL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F8E15098E;
	Tue, 16 Jan 2024 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435139; cv=none; b=Wa48BzZRcZKThyceDpAmH4sMGQJBL3Fehtk4JGy4W7+TOuo1tkCqaVDV1D4gbFg+Iy+7USMir8WE4T4JFe0E7rZZxzz0VWYvdfi3xxkDmMY/AmxXz8z0Zjn4uYHA+NG19BgD7woSA5e3qZnLoCG2jyD5rWwWhYHW9cglhbGLPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435139; c=relaxed/simple;
	bh=8c2rzwNTo9uCHrRVyed9E00YHpKO+Uw733PNR0Kg84w=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Lv6NQWeca7mtJGcF1lTmJ4MOe6fNCWpkBpVKHv61LimZuH5rlpu+KxCcdFTnDOQG9EWWJZef92yvD8XblA9wk/FoXdbT4sNEgIjcgMWPBotpAXlGbBElTwMFW6FYbTVDI09NHfx6eq4Xza786JpFpePgMjXnD2fagJ1xpBE1Q9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vABA2QqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3658CC43390;
	Tue, 16 Jan 2024 19:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435139;
	bh=8c2rzwNTo9uCHrRVyed9E00YHpKO+Uw733PNR0Kg84w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vABA2QqLNSxZg54PhQ7Bqad6qUqIMLfU06+oj9eUNQqSs8mUs3FxBv2Zg5lmKi0Tg
	 E0g7wxj0UIJk+BEtnfX5UwnYJeSQdejXdLNYsDCCgfu0Nj8W12id7dCASyy1j1/HI+
	 3JmpOS9IKchJoU90mKyDPyQya3UaVkO2+EcVnT/XiBBj1l4MfzVkRDBKSiiLdzZlcq
	 RgMl38bSMLcO3Fsa9nxb6u8ip4vUjVuNT93iCRG+KnW8v/miHYYU88G0nOMBkCOyOG
	 0R3ochMvrYPb0ugY7J3sNcxOEgz2eK7qvpoDRh7E2LXi9t+PT68caE2ulIH6XsHzu/
	 GOBfB9A7+lSYA==
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
Subject: [PATCH AUTOSEL 5.15 10/47] ARM: dts: imx7d: Fix coresight funnel ports
Date: Tue, 16 Jan 2024 14:57:13 -0500
Message-ID: <20240116195834.257313-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index b0bcfa9094a3..8ad3e60fd7d1 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -209,9 +209,6 @@ pcie: pcie@33800000 {
 };
 
 &ca_funnel_in_ports {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	port@1 {
 		reg = <1>;
 		ca_funnel_in_port1: endpoint {
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 406e8870c680..6cdaaacd9e36 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -174,7 +174,11 @@ funnel@30041000 {
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


