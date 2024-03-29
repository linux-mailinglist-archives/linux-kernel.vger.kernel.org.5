Return-Path: <linux-kernel+bounces-124899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8169F891D99
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDEC1C2799A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B67114B098;
	Fri, 29 Mar 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5xzePVx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B88238193;
	Fri, 29 Mar 2024 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716393; cv=none; b=BwElqX3fyBLMGy9OeOtvvPhfHMg+we0JOKL42JFONvLFdhwb+lYjMhAl8kvMCYKYEVLecXb1P00O9sdh+8C2Drq7hOiakW88xZBJXmxkLwYYJUbVJtbVqGNgFTEt5KndJTKzdE4O3sXP36iYQ0W27dNcAoAEGo331t5JFKmY4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716393; c=relaxed/simple;
	bh=XHHcbiSrNTwKbYxM5W9y+dP0VAGaaEp7rtcy3Rj1pQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJOdjlaZoebD54zAattGdVHxJWpKP22K0gTyf2x0BrzzUN+RUR1k0F64g9vnWFJildUGKnveJYynUK5Ho7i8DLzPeigqdCsdkbZ/9LeFioXtJyY+5NweJh82tId5EcmwpGI2Nk9RGPyfZEBS75O3GaGnmygBfDd2XZxZFutglek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5xzePVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5898C433F1;
	Fri, 29 Mar 2024 12:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716393;
	bh=XHHcbiSrNTwKbYxM5W9y+dP0VAGaaEp7rtcy3Rj1pQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5xzePVxME4Ug0uo/crHjc7GVnLy89sH+cttu3O1wYaRnF5Wp2Wmk8JB6Qf4xiVhd
	 JCpnuBdmP2laCrcgZanHv8lG3sMAcnT1dS7iYxlsNXejDmcfUlo25g/L+iAtn75UJ9
	 P8SV87fZXPutMyO9xh4oBP36Uujk9eXvvgPr+kNc9sE96UCKRROEeknLQiCVtfZ+CU
	 ohmgSORVEechVn7m/T1tpnEiOmTdi/XUbOQrSGw4PWReanF6d055PJ/SDhoo3OY0q0
	 H4+65xUZpYX2KKaAumdgkY/ZH48Vxqw67z87Oc+ZLAHXOH4eZ6Sn9qWWESkIDSRh/2
	 QflrWEOIRztQA==
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
	shironeko@tesaguri.club,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 15/52] arm64: dts: rockchip: fix rk3328 hdmi ports node
Date: Fri, 29 Mar 2024 08:45:09 -0400
Message-ID: <20240329124605.3091273-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 905a50aa5dc38..d42846efff2fe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -741,11 +741,20 @@ hdmi: hdmi@ff3c0000 {
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


