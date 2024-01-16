Return-Path: <linux-kernel+bounces-27998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B14F82F8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF20B25101
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CCD13AA52;
	Tue, 16 Jan 2024 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnWLhSZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D61813AA43;
	Tue, 16 Jan 2024 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434808; cv=none; b=tJsxsW9fxI+6aPq7tKx+SaAMtaevd7zpI2kIzSl/VvfFlq1nDf146TTAiZpdHaM4Vch7W2GLQMvD1NC26JwKNa97yU2on0SXif1g6yW7+8HenxJaqPjDLoaV4FanMKPhOPfsS9Xl2KsEkEM0X5pp2tb2AVjjgK9HuVfb0FlX5Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434808; c=relaxed/simple;
	bh=D2ixwIy2DgRLBSaqA87mBG0pCTbp+mlrfu3WdPxsoK0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=dt8kJa2OsXbGMG48Ax8ISJ/Tlfwo9caIvp0XrvwJjeNxGfSKH/Fw9oBP09lhuSpxBfO/6VrwZcTRBio5Y+bnFRRKxYTovE9wKGmbGpk4nRkD+jLsyogTXukCCU3+8H+ED4X+qnmyRnsoBG59N3ss4hruhksr9tvr6TeMwc+XOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnWLhSZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7A7C433A6;
	Tue, 16 Jan 2024 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434807;
	bh=D2ixwIy2DgRLBSaqA87mBG0pCTbp+mlrfu3WdPxsoK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnWLhSZCQj34iKWkhgwrYdEuY0SzsqhUzycWqDwxSM5gHSEeeS8d3c5vrpoIRJHkg
	 ICMYL7BYpCk8dqnTVYRBDsRkYfqXuQNUdK6Wi59Z4R+pqHNccEDV808L7NB26Qd6b0
	 9yNOLLleA6bsaWbaAe9cjqIj0ZYC7Omo9ca4Tv/HjE31p4/IbuzkpybGcnGPt4Tjy3
	 nF809hgju69RtaIiXng88oCef4hka8YEVeNgCFhRqteLFQ///VZ0mIgR4ude+gPlQ3
	 Sy8eEQORRixSv0iVyK7JSASoriTTgWUb9chp58JVaz4NRph3pCxKycupjJXnNFpG3y
	 EapcwemKBPF8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	khilman@baylibre.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 086/104] arm64: dts: amlogic: fix format for s4 uart node
Date: Tue, 16 Jan 2024 14:46:52 -0500
Message-ID: <20240116194908.253437-86-sashal@kernel.org>
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

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

[ Upstream commit eb54ef36282f670c704ed5af8593da62bebba80d ]

Aliases use lowercase letters and place status in end.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20231215-s4-dts-v1-1-7831ab6972be@amlogic.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi             | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
index 8ffbcb2b1ac5..bbd3c05cbd90 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
@@ -15,7 +15,7 @@ / {
 	#size-cells = <2>;
 
 	aliases {
-		serial0 = &uart_B;
+		serial0 = &uart_b;
 	};
 
 	memory@0 {
@@ -25,6 +25,6 @@ memory@0 {
 
 };
 
-&uart_B {
+&uart_b {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index f24460186d3d..55ddea6dc9f8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -118,14 +118,14 @@ gpio_intc: interrupt-controller@4080 {
 					<10 11 12 13 14 15 16 17 18 19 20 21>;
 			};
 
-			uart_B: serial@7a000 {
+			uart_b: serial@7a000 {
 				compatible = "amlogic,meson-s4-uart",
 					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x7a000 0x0 0x18>;
 				interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
-				status = "disabled";
 				clocks = <&xtal>, <&xtal>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
 			};
 
 			reset: reset-controller@2000 {
-- 
2.43.0


