Return-Path: <linux-kernel+bounces-28221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE4382FBC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE4528CFF8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694E416AFB6;
	Tue, 16 Jan 2024 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjAJaa/y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4416AFA0;
	Tue, 16 Jan 2024 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435491; cv=none; b=GSYO6DRBKlnu7Sc1e1wv3FbJU1xGm6EruxTgqS7pZ3aFLqz/4aEvzO/FkWB3kscjN54fGGVnuTwiVkORhR9N52hPy5uDFcR8WZi65nrfzRmJ0I6iSpBmj2SQLmgo/KpltREDLMVdsQM1RQUEYP+xOn4A/axlf23tEsQcuHdWxRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435491; c=relaxed/simple;
	bh=YzyRqvbY41j8DBxTfmp8NbzikVnpkHjD8uBwXtztwko=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=mz7+Ud/9egSttqJ8kk+ADMtO6wRw5lhE64ZOVhX3MaLxI7zdnkvo7/Qh+13YUkBiPQW4EtJpodZ7B/qpTI4kRfBM8cVADZRDl85tw7Z3Uc/AzbR0VULwmXG61z6nQ29vBdmHQ/cyKF8XwkdzKlZ4ukMg3nGK0/S9GzvaPO7DfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjAJaa/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A01C43390;
	Tue, 16 Jan 2024 20:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435491;
	bh=YzyRqvbY41j8DBxTfmp8NbzikVnpkHjD8uBwXtztwko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjAJaa/yCCvRTTYZDneXz51VMF4z2MzXrPeAAhO5bpNjefsP9efm8kI1w8co7SIem
	 y9iwFVe4AKxNTR1HPn7Dv3H7XxUEnUr6cp/SrvKqa8ffC+KLfjIobKZvZWh78gvx0l
	 aBGYbY2G6TlV3weQDJ4yE4OzyeeVbVDHDBeSFc+xIIkpUulF4EUliFS2+i/vVRxOkd
	 Sb+iKuouslYkfafDudAOq+2ujd3YxKOQmRqqjUOpQNlNzQQZyiatUC/oiCQtQ26iEU
	 r6VbItwZT7WKvaghrFInEYxmt7kuDB7GP7Aktqsrva+3VqmqYdgst57cK8gYRj+dmo
	 qrMLFiKloG0Pg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Jonker <jbx6244@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/22] ARM: dts: rockchip: fix rk3036 hdmi ports node
Date: Tue, 16 Jan 2024 15:04:04 -0500
Message-ID: <20240116200432.260016-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200432.260016-1-sashal@kernel.org>
References: <20240116200432.260016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 27ded76ef0fcfcf939914532aae575cf23c221b4 ]

Fix hdmi ports node so that it matches the
rockchip,inno-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/9a2afac1-ed5c-382d-02b0-b2f5f1af3abb@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rk3036.dtsi | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index db612271371b..c5144f06c3e7 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -336,12 +336,20 @@ hdmi: hdmi@20034000 {
 		pinctrl-0 = <&hdmi_ctl>;
 		status = "disabled";
 
-		hdmi_in: port {
+		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			hdmi_in_vop: endpoint@0 {
+
+			hdmi_in: port@0 {
 				reg = <0>;
-				remote-endpoint = <&vop_out_hdmi>;
+
+				hdmi_in_vop: endpoint {
+					remote-endpoint = <&vop_out_hdmi>;
+				};
+			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
 			};
 		};
 	};
-- 
2.43.0


