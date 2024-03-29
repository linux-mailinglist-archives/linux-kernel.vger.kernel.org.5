Return-Path: <linux-kernel+bounces-124663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C96891B25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3332828B31D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425EE16F0D0;
	Fri, 29 Mar 2024 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn4EqPLv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCD16E895;
	Fri, 29 Mar 2024 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715656; cv=none; b=ARO/rMsBCCv9rE5rxl8bU/YLzQ8DFcMnvrxD3hf7yawjoHBdMic1cSKnVDAuwEx7FKTthw6QLOs1Nw2PGfyeyPcRTIGFW8fhSCErbkhWZOrKeYoGQBlC+4GocUGPOrfSAprNTrkqukaRxrd5flqJDdvYwG3F7S7268J+KiCr6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715656; c=relaxed/simple;
	bh=jwu9FsJbtbfHk1QsMJaENO9ehk3wZUqqexLs6ekxb6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QG5KoIf7IFF6O0jwJCAAwVPt6u5sJoAaZSflPPXCYt3z1f4/nkcILyt3xds76o62NirXoY47SgxDhXdqnIcEkID+jal97IrCJzbjWUZ4NKHUPfi46NrZaYDyoksEDMkJ95stlib2kTLOMzliJ2JhefzCYV8lpc+O2FufdgOfiWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn4EqPLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C01C433F1;
	Fri, 29 Mar 2024 12:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715656;
	bh=jwu9FsJbtbfHk1QsMJaENO9ehk3wZUqqexLs6ekxb6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dn4EqPLvz6EzccRqrRAOSe7983Ai4iux96beVsXb5tLXgv24nN8G/MKdpgOWFPPho
	 yfgrKbk7M6EU+mLM8MddVOC4gEqCdxD4tGJA2udTGpVLvZuqzywLipWU5TH1Fw8bRT
	 y6/c/UvkF3dcB9avPi+MTGwzXRuexOuzGXe1nT2GNdAhPv/jFBNqzcqI5iceMZa/hx
	 pokF4TgDpvpMVirn/lo/f0n6aMMzVHeqwDpSKagiytE7fv6Lnv2DtJ8MXo87WU+DVe
	 TIf9scCyRvb1qX185KUJZkJZNSYgNqN5NrpvVq6KtElbivNlwpVvrs6iUe8VUDaWe9
	 ZVjgtz3/1w6BQ==
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
Subject: [PATCH AUTOSEL 5.10 06/17] arm64: dts: rockchip: fix rk3328 hdmi ports node
Date: Fri, 29 Mar 2024 08:33:45 -0400
Message-ID: <20240329123405.3086155-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
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


