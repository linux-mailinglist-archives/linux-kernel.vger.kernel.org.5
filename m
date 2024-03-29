Return-Path: <linux-kernel+bounces-124569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCA3891A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75D31F27C80
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04F1CAA6;
	Fri, 29 Mar 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeVxHDTh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822C2154C1A;
	Fri, 29 Mar 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715428; cv=none; b=tqWKMMWTNKBNlPmqaWCss1GIoO1tEmEovoDytv8ttZVUBtHiaOZac8jP67tY7HG6TQuTY6jDGeTx2N4LS/ke6YNPJMwbYLieMPNPLPLvpR9bK9lXN2QwiVbAab9OT/CE2ZM83HPTF2sX0OJO1xv60iuuIu8qpzAKPqH7WcpNgMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715428; c=relaxed/simple;
	bh=7c9SL6HaFtqcj1ILppO2zgC9RFH/L+E/p3c7nIcweV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYLMvSlW3yHlDYqaEBvWxpOuH5ZQMnvUU6NlQtwxd4SB0c0qpkj6l4QIhUvjpWofUzk3uk8uOZRS6eBFcBuKJzrZxBQPsI1c6eHKd6u77OwpsSYbGySteIK3HbUGIjqNvBrKFp0LQv3rq3v+UoeCxJDQoAVZZ5VGTksn2PvQ4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeVxHDTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C099C433C7;
	Fri, 29 Mar 2024 12:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715428;
	bh=7c9SL6HaFtqcj1ILppO2zgC9RFH/L+E/p3c7nIcweV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DeVxHDThPTgMe3cHHVSxNJEVIPnfXcNJVJocjJlBntLLZS9DiaizNhRHkuBMLAXQu
	 QvvR1JKLNuY6a13JErY4mnvtXMZLqsxJwJ840eWNmgOsA57hLXVpbLl1OZb1oLsIGQ
	 Ndo0KNwHsH2NlmYPYhKIxGvajk9ABbFVQ0izb63Lp9QC9hjJ5K8YPDSBYsAYiuvV/h
	 2OcU8uzKtsGycgEmW6qgWaqUq5u4sjXZfx6011uGEBDOd8WUya03TPXEZhBmNTOzgC
	 YB9NAK8mLZX/zS+lA043moIfGLsQAoIe/eTXaN9ox/KAzX+NzQHj28VwY2ZE8RTEz6
	 nFhVk+qxj9zaw==
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
	jonas@kwiboo.se,
	lukasz.luba@arm.com,
	chris.obbard@collabora.com,
	rick.wertenbroek@gmail.com,
	s.hauer@pengutronix.de,
	knaerzche@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 18/52] arm64: dts: rockchip: fix rk3399 hdmi ports node
Date: Fri, 29 Mar 2024 08:28:48 -0400
Message-ID: <20240329122956.3083859-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
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

[ Upstream commit f051b6ace7ffcc48d6d1017191f167c0a85799f6 ]

Fix rk3399 hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/a6ab6f75-3b80-40b1-bd30-3113e14becdd@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 4a3d0af5ecfe2..fb1ea84c2b14f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1953,6 +1953,7 @@ simple-audio-card,codec {
 	hdmi: hdmi@ff940000 {
 		compatible = "rockchip,rk3399-dw-hdmi";
 		reg = <0x0 0xff940000 0x0 0x20000>;
+		reg-io-width = <4>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru PCLK_HDMI_CTRL>,
 			 <&cru SCLK_HDMI_SFR>,
@@ -1961,13 +1962,16 @@ hdmi: hdmi@ff940000 {
 			 <&cru PLL_VPLL>;
 		clock-names = "iahb", "isfr", "cec", "grf", "ref";
 		power-domains = <&power RK3399_PD_HDCP>;
-		reg-io-width = <4>;
 		rockchip,grf = <&grf>;
 		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
-			hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1980,6 +1984,10 @@ hdmi_in_vopl: endpoint@1 {
 					remote-endpoint = <&vopl_out_hdmi>;
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


