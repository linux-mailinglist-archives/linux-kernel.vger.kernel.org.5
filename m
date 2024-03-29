Return-Path: <linux-kernel+bounces-124946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87280891F27
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD63B235A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C38A14D289;
	Fri, 29 Mar 2024 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOnbODui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F371A7F95;
	Fri, 29 Mar 2024 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716487; cv=none; b=Ug8vBjW7kw9YGkvFjEyOjmeadegG9RHtJwKtPa1kG0zUD2BjhWkWZENTyOcYNELhE6Xz9tPbcPuNyCMXImqpSMkk2eXL49WXTd6Shj4z+R1LzVD9lqfAZg94qxq1VGixcVPlZLVxwo2v9hf6aV6v865ZcGXGjSVPNPrGxxK1Fqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716487; c=relaxed/simple;
	bh=7N3CJhPsRMlpeKmyoDFHiXmED3LwVA7upRbobm8TQj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0FpUfK1WQlI/rwJz69yAPAU7gbq7tAZTFsr/yPGxM7XAiC9WTwINCoica6Qj1JJL8e7jUQJN6vP1TwD4suWhLfixsbjegubr5qpmfUlugrZ8BZgO28ySAA8avlBcArmXCr7ZQyrSiZDJPBjYfHerPWTkgweuTkhz7CeVeDzI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOnbODui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C96C43394;
	Fri, 29 Mar 2024 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716487;
	bh=7N3CJhPsRMlpeKmyoDFHiXmED3LwVA7upRbobm8TQj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOnbODui8eFCwkXjrn+XC4bGZA00Q8GbgYr1NBGiNqFTZLIUDMNjJCKtEn20Kf3rw
	 ECIZVxL/T/SYWucEdYT/zp3qJkHXEQDJxyXF/Gj6XQ0m/zK0Om8gQ3g1/sG9FUPpvW
	 GBdRA0iOoSsVKTkYLCPcJF43RepEe6QXI/ZvfEdzhSLPvx5Qr8k63LhCBCKRsJkccY
	 K6zHsRitUkeo4RgFeIIllOwt7Mka0iovRvnTYCBFQH7gIY4J1xnp9aYrq6Z5+yiofN
	 GLJXAPhHQ5jNjY3B2Gu23DaqJjOElQW+Cwk2UfRT7ZIhDW+bpFOjDKAPYi46CrgLPU
	 qlVdtpVdNN+Sg==
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
	jay.xu@rock-chips.com,
	shironeko@tesaguri.club,
	jonas@kwiboo.se,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 10/34] arm64: dts: rockchip: fix rk3328 hdmi ports node
Date: Fri, 29 Mar 2024 08:47:11 -0400
Message-ID: <20240329124750.3092394-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index 3cbe83e6fb9a4..26f02cc70dc5d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -728,11 +728,20 @@ hdmi: hdmi@ff3c0000 {
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


