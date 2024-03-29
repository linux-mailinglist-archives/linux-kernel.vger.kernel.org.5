Return-Path: <linux-kernel+bounces-124979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DCF891E75
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C47F1F27980
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A4D16D4FC;
	Fri, 29 Mar 2024 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB4uAECR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640A16D4E9;
	Fri, 29 Mar 2024 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716558; cv=none; b=Z+d2V90t8iOlabIiGj4cyWlMmAwbUYSMJuPoY2/lT6cEbjMf4WY7VtEvbM9tfGOiaa0kExbQgjCF6tVY7GRA3ALoVMdPzLYhMwx0huuJoTaxYVRopgUuykw0l5iYjnCBD8Xs5xPltq+aOC5h38qM7rfVGw/5yzG9km9jgfBEDZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716558; c=relaxed/simple;
	bh=jwu9FsJbtbfHk1QsMJaENO9ehk3wZUqqexLs6ekxb6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvgEaNz9VReamda1SS8NIISpQI44ujsRP93x5EBJdNhQrMT6up+F5pN+6Ujtp+qIgvc2BqNjZehY0hkyPCJt+af/8TpbgUDKx2+rorgLHTy6ZlQ1uniV5i4oz7LgXRB1ErJpnBfa/Y9cT6M0TmWA+bCeH0dfuhl6Chz2HsVjVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB4uAECR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7F9C43390;
	Fri, 29 Mar 2024 12:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716558;
	bh=jwu9FsJbtbfHk1QsMJaENO9ehk3wZUqqexLs6ekxb6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bB4uAECRpcpDkkHlTJff1ihSgLed7ihN2Odgk88gcrhPlEHNCkYXLIBdOhsoWGYcZ
	 0HUp8I0SUmSqD/ecoRHXvDTuTx6d/jkISK9PPQDNWx4M+CurXESbwftCbowkySxG1X
	 twtfjLKsen2m5S+8dyhtZEo+BJoRuws5gNUa9F+vy/Aa6IyEF2C8ythSDIVd4AV+MJ
	 6slDVkRNMYeYFM/W9+ZqlYxvaEDvcH76C6Nqdzcx8BVQZJoOn00loj+Ms1pMqK9oJM
	 /1gsRuzvSBZvFOhB539muSFQ7juM5+oecVj6v2OSuNaoAI6BEiJigTZPCBtIIe6Bd+
	 HQUonkp1I2Udw==
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
Subject: [PATCH AUTOSEL 5.10 09/31] arm64: dts: rockchip: fix rk3328 hdmi ports node
Date: Fri, 29 Mar 2024 08:48:26 -0400
Message-ID: <20240329124903.3093161-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index 72112fe05a5c4..10df6636a6b6c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -732,11 +732,20 @@ hdmi: hdmi@ff3c0000 {
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


