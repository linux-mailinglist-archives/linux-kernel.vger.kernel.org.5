Return-Path: <linux-kernel+bounces-27798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13FC82F610
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710E91F22B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263FE24A1F;
	Tue, 16 Jan 2024 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR2z+fyx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6677E24A0A;
	Tue, 16 Jan 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434222; cv=none; b=R8LyMkrr6S7o2vtbWfeafqAe5PSPpWAEqUSHGH16nMxWskn/LHQmidYwkCpyQteHsPrevTSaCUfOQa+Dj7AAYk/5s2ucjnn8lxneLChAb2uJtfJvoIw+vKUzj6RTgjniErp+QaaxCns92kExwFChHIuQMrF3rOUyW+SCHU77zsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434222; c=relaxed/simple;
	bh=nEyyAn0Ezb8gPN2lMWSjSx6DFjbmdn0O36gA3PSaols=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=JDeALm/PXj3+PiRjaMYUbmx/83MWbmmTxyGpd0oAyoTHaonn63VqR21gAvfM914bDcPi+5mFT3cnl2XLvJa+31vP3vw1aeyHGjV9MRwq0VQ+sdIPQgPuWgqRsPIvAaWKvlZD1MfCJUBn+B2yGzRW4XORRFSuDA8JqTQLL3zgry0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR2z+fyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2015EC433C7;
	Tue, 16 Jan 2024 19:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434222;
	bh=nEyyAn0Ezb8gPN2lMWSjSx6DFjbmdn0O36gA3PSaols=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SR2z+fyxjM8PM/X2llK0dzhpOdoSqRp6PACDk92hPbRiCxE8cFFoK46doBA4vD3sH
	 d3v3dem/G5Lv5S/R4CN17l3T/vyUT9ojH/t633fd49jrYxt0XcVgkDWYK/j+ZiXd6R
	 35TFidcJuPGbVn8SUoyvJXgSZoEqZe+bVNwetpUT4jk8XQqqn2IRXghOv/+j076QGL
	 asstEET0MZBF4HYp7DGS+1junT1OVyKSuqK3GeZbhbh2Xlrsyv4zPXcTT5i4vwT17s
	 b5qHnBmDMrewOFUITRI/gBYtyLEqhHFwNTGV5bM2zKhmFDJLr/lnkpipmYAa0rn4ab
	 cqfYI+DpseZbQ==
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
Subject: [PATCH AUTOSEL 6.7 028/108] ARM: dts: imx7d: Fix coresight funnel ports
Date: Tue, 16 Jan 2024 14:38:54 -0500
Message-ID: <20240116194225.250921-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index 5387da8a2a0a..9f216d11a396 100644
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


