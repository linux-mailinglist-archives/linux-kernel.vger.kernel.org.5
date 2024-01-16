Return-Path: <linux-kernel+bounces-28032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAEE82F959
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F64288F57
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706132D05E;
	Tue, 16 Jan 2024 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe2QlN6b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED802CCAD;
	Tue, 16 Jan 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434948; cv=none; b=XJ8TDPE/zG/yQPftmu9fz0UJA2jc6jkH9ms2occL6O34w6bxofzof3dAmr1U0SWzspnn7BvSohWE51GuTkLNragp7rZQWTYR9+FpUHgwqlCpgdRP0KZVZmtqlF1sDkGGIqH+pSGyzuhvk0ebisTEltral9uZ+dWyvN1exJSwmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434948; c=relaxed/simple;
	bh=qn6TGNJT+7OymXv/faGsy9WbP+sJUnpw8pPkEeDchL8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=E5C6Xf/W4E3Hqq9yqct/Sd7Nm5T196p5YuquDsFrx+8ThQHeypdMYp545y+fd8yvQblPD0FZ+ZiRXIIxn1Lqmp/kOY1BnU6y0RihGfFUX32feXc8BJ5x/3fI+w8hyAcjMpIRssrzQfsx4ehlVWzsT9Smc3TyK1vfLwlh9rKChsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe2QlN6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C917C43394;
	Tue, 16 Jan 2024 19:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434948;
	bh=qn6TGNJT+7OymXv/faGsy9WbP+sJUnpw8pPkEeDchL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oe2QlN6bxnM33NFmmMMPUCbID+r2g1DqXR797SldUaASGrzdHL9KFLVsUh+QvM3YO
	 1N+BJk98i0ABxM2FTHhPnOY2idZPsRnt3m/MdvHRKnf+yaSV4NBH2c1/vYQKsLXBRy
	 WQYnl7eltpYPXMNKoJY76L/cRoCQR2/Z6m6JIZDSk5y375MqTP0zvUzer2zB0SKVn6
	 xR6O1KIEudLpyNUL+37zGIW6hjeZcIj0FqHD/D5IwPkzg+Rb+kKxbhJCBd9ZWxAqDS
	 8/Xas2C4YCdzfhTkhf9NHyQ+ItJL9RmrYAnWaEbA8SKn/fJDIQGVAiQVEHnj9yIGea
	 eFnIid98Z1NJA==
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
Subject: [PATCH AUTOSEL 6.1 15/68] ARM: dts: imx7d: Fix coresight funnel ports
Date: Tue, 16 Jan 2024 14:53:14 -0500
Message-ID: <20240116195511.255854-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index 7ceb7c09f7ad..7ef685fdda55 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -208,9 +208,6 @@ fec2: ethernet@30bf0000 {
 };
 
 &ca_funnel_in_ports {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	port@1 {
 		reg = <1>;
 		ca_funnel_in_port1: endpoint {
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 45947707134b..7c153c3e8238 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
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


