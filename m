Return-Path: <linux-kernel+bounces-28145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A09CA82FACA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA62B24856
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E5B15B2E0;
	Tue, 16 Jan 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPvSKwmn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AB3D549;
	Tue, 16 Jan 2024 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435271; cv=none; b=CHTgFINjQKp5VVxoFQjNdNiLuRu/iX2jWkixZE/JhUWayI0/QvK4Dw08WMXmJuP4QzQm2LTQbTPSyAXmp471oA3wWxNPHhAXn23Mo0qp1U9WiNJUk1zSod77aJRDdc4Ye+RfEm3JkgywWKu2P/IzGqojKXwTernUTJREazd+cOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435271; c=relaxed/simple;
	bh=blobv814s8oZkTscCnm9M4NhxxzuGHApQAHu63YKAZA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=kvaC/nZxxK9Cg9Wcx0WkazTRXip5VBAt9QR5TBPA+Drgx0c7uNVYnJIlAeXzE6ikwcb9/AwQjB6lP8hBBnupQaHElPQv30Tp5/dB3u8FZhjpW9aouz1dR2xDyMi2+MHpkFM+pqtATreRWbe15kss7mol87+dX/z2TdCyCFLnI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPvSKwmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CAAC433C7;
	Tue, 16 Jan 2024 20:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435270;
	bh=blobv814s8oZkTscCnm9M4NhxxzuGHApQAHu63YKAZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPvSKwmnvznY1j/15rUVsrSsBrP+14LlF2tjFLNjqBlO2w6pCGsHKuRqvOAMsO9zA
	 DxIS1ylKBKrV69LZ3GYjIXADlhBY+OMTt7qig4C2XbuVDMoX8inX+PS+zbLLuJoESR
	 IiCrulaWSQkrLj5VEedFHlH2huy+0x6wkd+fPWbzRgTHoKEnrJczd1znbua4aDL+tf
	 yFMwxSr5z7lKp2vFFSd3sSAHcKyLmKkwaEXLBU5khBPP9NE1g6+IyjAInQaFj1Naqn
	 CKRpIvMn6kKCdh7jAdpmgOA6W/JIdohCxg4iJT4XHTBu/itI/x+DqI4lT8GyY1Qfd8
	 LcRr6/nYuDGGw==
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
Subject: [PATCH AUTOSEL 5.10 09/44] ARM: dts: imx7d: Fix coresight funnel ports
Date: Tue, 16 Jan 2024 14:59:38 -0500
Message-ID: <20240116200044.258335-9-sashal@kernel.org>
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
index 03bde2fb9bb1..622c60bd8b75 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -173,7 +173,11 @@ funnel@30041000 {
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


