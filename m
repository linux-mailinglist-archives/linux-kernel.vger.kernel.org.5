Return-Path: <linux-kernel+bounces-124506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653AB891908
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968AE1C21DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089991422A3;
	Fri, 29 Mar 2024 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukFZA36P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424E51420CA;
	Fri, 29 Mar 2024 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715259; cv=none; b=kQ3NTlONoGtyqs0S6K+kX30psPW6ZCCG5q6B9+OjNHO6ARLpw62bLTkX0g+WIKpF53ZZ2x0Ja2wJwR3/k0xfUW9l3sYTzW9Jy1MgFm8IlbSv/fDNNRx5+SzLjdrG6bjttjcdbSA0W7qV6/zOCNo8P++BOkqvIDv/yNho0SouLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715259; c=relaxed/simple;
	bh=h5vXU9ZnXCMzgReS3qgBCF4yclyS3UuPVOjxSyLz5eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOKveExlZU+zWsOdKg7dLhb+6XZwwwAzM3u4l85xhyIQnL41YTE6aXf3S9NGqcgvdOC5N02Jpm5uJQCXIGlDz7yYgxQAPJ5EYWKSVZ6g2i0TO89t0xGba5s07hQbD1jZ1QtQFsgoTSiI8MwRAhQXKNhm6SLBdgL+OuMZUDV5A74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukFZA36P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52DDC433F1;
	Fri, 29 Mar 2024 12:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715259;
	bh=h5vXU9ZnXCMzgReS3qgBCF4yclyS3UuPVOjxSyLz5eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ukFZA36PNfbI4eDC6kFCqWLJuyT/rSvRWcqCDZmjQHJK+hFYwzl6fETL7Vtf+7nCf
	 Z3OiSDua5O/7+U7WkSOknFauUXTZFVji1t7iUJq9TbK4nwH7Y0AyKbvv/Y2xCY6rRI
	 qdomrSGk9p0VT0K2xmgq/j/kvTjPBgZhOJuS2LupWejjwKedq++HQsEXWMCeULn7fz
	 aMT0oxgWrUFXr4GgKNsGE6qgfKHxewTC8IV7A9J0NmQ+SA5OjjWrqChOhojIDx/6ye
	 FdBDy8JBtynJYBpvYRbut0yp4I8X2tSy40cchqo1pcq1qr+UG65e8WvpDOGTXXJCPb
	 zRYSw/Z/MBh3w==
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
Subject: [PATCH AUTOSEL 6.8 25/68] ARM: dts: rockchip: fix rk322x hdmi ports node
Date: Fri, 29 Mar 2024 08:25:21 -0400
Message-ID: <20240329122652.3082296-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
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


