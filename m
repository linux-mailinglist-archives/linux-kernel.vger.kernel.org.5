Return-Path: <linux-kernel+bounces-124830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E444891CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904841C20FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E217C1B5311;
	Fri, 29 Mar 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODHx2Obe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7CA1B5308;
	Fri, 29 Mar 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716249; cv=none; b=Y0HLDtwgHeT0/GyAWfwXhW87ECW3In92xl2+AV+t6vvdVYPMdxvhPGAcDmdh9ukDT/Q9NKhw9AyeKtOP+3EjckrimZseBgLbmUDQDfM5/eY7v8GRGHGvZUloNKJJGxvlRHSXdn9tPdz7pqZjO9L6s0fzKfqeP95iWTlyi3mamOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716249; c=relaxed/simple;
	bh=1O8WeNlxDS48rttxgb2bRu0jWhzK9FcC7muewo1Lu1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sibRAKpaUkCEPsOBUy6kXFS5Zoz0oJmX6qwCrnEN4aN1A9+60u2Luvf8fgajCBLdfLddWWAwYlmoJDJaG0614DLbuAsGaPEZjetZHn4eQWYTbnZFHrrEhHb22MEM4zwLWwZJtWRp17c4IcexUbhda9A7ls8kjFEcjEXrsGZu85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODHx2Obe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995E3C433C7;
	Fri, 29 Mar 2024 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716249;
	bh=1O8WeNlxDS48rttxgb2bRu0jWhzK9FcC7muewo1Lu1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODHx2ObeAJnLYfS+D1kEMuVzb/vAZv8iQXgANffUxzaQv1ejN7EnkA05LdZST3FMg
	 Qc517I757XTwDW4EnqJwL5GTTGLCZrho2EL7NbKtS2p8eP5rogVwId1kFxYZWnAS1r
	 daeuSDpQ0v2+4Rhtqd747WPxuSPs9L3y65clxt6y72M9oKeER6gBe/zQb9cdw9v2XX
	 spZtaFOxZWt5ck4HdzD7JaBD/iceVVRW58z1RLR122CG4Y51Pdu1TfNIYrTAUFdIJq
	 sD0UmFMPByLuO6Ke32xiwXlVV9iQrcjZca4bhLZ/mreb/HWtaWIzCZikZhh48NCI1H
	 m7CvY42Xq3LoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Jonker <jbx6244@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dsimic@manjaro.org,
	shironeko@tesaguri.club,
	jonas@kwiboo.se,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 21/75] arm64: dts: rockchip: fix rk3328 hdmi ports node
Date: Fri, 29 Mar 2024 08:42:02 -0400
Message-ID: <20240329124330.3089520-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 1d00ba4700d1e0f88ae70d028d2e17e39078fa1c ]

Fix rk3328 hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/e5dea3b7-bf84-4474-9530-cc2da3c41104@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index cc8209795c3e5..3778fe5c42a4b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -743,11 +743,20 @@ hdmi: hdmi@ff3c0000 {
 		status = "disabled";
 
 		ports {
-			hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
+
 				hdmi_in_vop: endpoint {
 					remote-endpoint = <&vop_out_hdmi>;
 				};
 			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
-- 
2.43.0


