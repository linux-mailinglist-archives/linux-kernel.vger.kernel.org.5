Return-Path: <linux-kernel+bounces-124739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779D3891BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CD62836C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9CA17966E;
	Fri, 29 Mar 2024 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6XxjRDX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47285146A9D;
	Fri, 29 Mar 2024 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716054; cv=none; b=Wpu+D1O1nCuPuW9+rP0zExR78YS43j5JsGw9OwSbhYwJNrnz1SM1G2feC4pd5pbZ5qTfCNmQhdjUba5B8T6xYLPyfoXI85r/9bWmBlley05aV4jpJ8V2FbRsbRcioKwAQWA7MWTYIPwvQNxGq5D0KhsiqF52sZCMtyJMTo4TY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716054; c=relaxed/simple;
	bh=h5vXU9ZnXCMzgReS3qgBCF4yclyS3UuPVOjxSyLz5eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPq/yAOgHcQuEnYvgypXGa/yzWSvSFkX4mi4iHSEGg/bLF0SoJGmjTlZbJQIjQoL4ZFhGF9N1SswxxwASk9VX2zh8VIDfPTeJewMytv65Lz/H4WBWvzk40Vfd62cipK/hAClMFd4Gqd7fXD60OWI4LrWuLrsemJwYdft9b18gGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6XxjRDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32D3C433F1;
	Fri, 29 Mar 2024 12:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716054;
	bh=h5vXU9ZnXCMzgReS3qgBCF4yclyS3UuPVOjxSyLz5eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6XxjRDXymGspaC2jtiK9YL53Jb4utJi2W1c1aOaJoqC49ll4NZ1vFi0CnJa2O8Dd
	 lCTCJNWiGAvPPnz4z+MUgDYglxe2Enm0yKEr5pbLFekZpKxAU2vrROQAojv8kyxRWw
	 H2gApS4Xik3bREfeSS/g96c+8b3PLyry4NzyOgvfHBo4St5afAcpfpaC0glDgbMaT9
	 D4zsfqiQjcTm+/j1/s0SXFJaIbqGiNo4tE8WgDbyCZa5fWBdb0ixWEGjf9kDcmhJ6B
	 PfA9c1tBpwGYa43PIaB+l3JZR4FBSK24MBS4SkmWQYZ9sSdUd8V4xXccL63EwYObkh
	 +kujA2vct+0dg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Jonker <jbx6244@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 30/98] ARM: dts: rockchip: fix rk322x hdmi ports node
Date: Fri, 29 Mar 2024 08:37:01 -0400
Message-ID: <20240329123919.3087149-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 15a5ed03000cf61daf87d14628085cb1bc8ae72c ]

Fix rk322x hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/9b84adf0-9312-47fd-becc-cadd06941f70@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rockchip/rk322x.dtsi | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk322x.dtsi b/arch/arm/boot/dts/rockchip/rk322x.dtsi
index 831561fc18146..96421355c2746 100644
--- a/arch/arm/boot/dts/rockchip/rk322x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk322x.dtsi
@@ -736,14 +736,20 @@ hdmi: hdmi@200a0000 {
 		status = "disabled";
 
 		ports {
-			hdmi_in: port {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				hdmi_in_vop: endpoint@0 {
-					reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
+
+				hdmi_in_vop: endpoint {
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


