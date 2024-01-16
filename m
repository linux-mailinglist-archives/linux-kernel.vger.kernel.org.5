Return-Path: <linux-kernel+bounces-28108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 593BE82FA49
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724B31C261E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF421534F7;
	Tue, 16 Jan 2024 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCeTMyy+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB021534E3;
	Tue, 16 Jan 2024 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435158; cv=none; b=GiTNGY4fIgPbhDGigeXWA8YkizFmF4QZohHiPhGiK/OzS/jpzXusObAa3nUYHVcYth3+3PKSjayHPymcXuW5zGLEMfO3trx9hFNYopwRzgOa4rLmgNu/Yz+vMrPLzKM+txlIYjIKlzzE1VNhN0uuxkBShnlh9mj+AFGLuJGSIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435158; c=relaxed/simple;
	bh=Dy167DzckbzgohUo5Afs8TMH6zDgci6/MKikNayEq+Y=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=S6tUGX8CTw8nz4WmBEjdfCVID/vf+IotvMXZWpalntqYAaEHjttd7CyHor4Z0CmyE2qamJlJ1jOXjbzqYb6QQRIyaKlK6FaqkdQDlRzQxqPIL3QhY/8vUWyD8OzhurKDqI4ZhS2SRNvfa9oMBXGPDsN56QT9big2cs0LiDqCYV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCeTMyy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519FAC43390;
	Tue, 16 Jan 2024 19:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435158;
	bh=Dy167DzckbzgohUo5Afs8TMH6zDgci6/MKikNayEq+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCeTMyy+pAVshsoEz/pVmfGonW8biWmaAbBHFg/Vi9SW+5Bcmw8wCkmhIwne5XJFA
	 bAQFcMPd2uv6rItJCBfPIHGId0GfTuttEzLgGhJd9zZKh+5B8eOKQPYoLk+hPb+2el
	 pqCBsENhqD8hJzFCZtPkc1/s174zyNBFAO3j0MyS4JYElKF10uIVNa1u91VQ0XXeU0
	 tMuBNqf08qARMiLBEpajK3v039tz5RmZN9jtSQpGru0SQBFPpen8C+VKJO1H3xmH7+
	 bR/UEBmihbwkJD5Sspfu6jZIt2sAtT7bEXc46KWNlSuQioGcOfHBjsogP0aQ/5fx5G
	 rcowOilsRudMw==
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
Subject: [PATCH AUTOSEL 5.15 21/47] ARM: dts: rockchip: fix rk3036 hdmi ports node
Date: Tue, 16 Jan 2024 14:57:24 -0500
Message-ID: <20240116195834.257313-21-sashal@kernel.org>
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
index ffa9bc7ed3d0..0af1a86f9dc4 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -402,12 +402,20 @@ hdmi: hdmi@20034000 {
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


