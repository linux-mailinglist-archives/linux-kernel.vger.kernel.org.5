Return-Path: <linux-kernel+bounces-28194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB082FB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A8E4B247C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C971657CE;
	Tue, 16 Jan 2024 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiPd5NNY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D49616509F;
	Tue, 16 Jan 2024 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435420; cv=none; b=Y/ClnwwPRjA2SvnyQE2NVSGGGHJOPjSzjKmSC9oYslu4uRFl14hPc4Unko5Q9ZRi9ZNutjmVQf2UYK0kD8OJ19I0Y7Np5X8spEcMUIYbmo0cSlCp3uTxaLqenpzwvKCBYILdEvLlgmNN6rXZmYknFhhvX3xwS0/+2lMQau+bHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435420; c=relaxed/simple;
	bh=s8CcRXu1OVbdAD6cij4FYhsF4waOAKRPp6LW9iK1kOE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=AeI0JHOAo78xouvroT2GKK7EokvgRzqhUuHN/ZlmiLygRoBFfzt5QnPH1d22wC8UGxzA2plg/T8fIfWqxyCfm4F1aaS/3zjMjxTCx9EK1iatFigSBQkP6K+pXYMEcjEm/6wJXZLKqRunfwWu4L4cdQJ9v5zXMQa1JKsCaiS6YdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiPd5NNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B78C43394;
	Tue, 16 Jan 2024 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435420;
	bh=s8CcRXu1OVbdAD6cij4FYhsF4waOAKRPp6LW9iK1kOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DiPd5NNYxOo8YIC868cLoPI+iGisOC2QfxefTFRwW2hhq+i2XvV5H85ATpTh1arB7
	 lssOierhokMidHGFuC5mX3bdlGh/2aLO2p3IqaupIebLt9sEf4asV1CqyVM8NAZPKA
	 wT17ii8caZOHIkSATmYebKUPDJLxQ/qEKDHncaNV/jQZzA0R0dlI0Oo+2CTLvzRxh4
	 xKEookYdP3R75hEYA77t1rUrfY4gVz3EeaXWZ/d8F6gDfsPy4fDkeZKoYZ8bEQ04w3
	 Uf/NQhg86V98E1s4nnzexD4e1TDTJCMzQK0IR/cjObT3M/p8oJ7VsogfaD8Cefi0qV
	 7aTk9fOnqm7fw==
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
Subject: [PATCH AUTOSEL 5.4 14/31] ARM: dts: rockchip: fix rk3036 hdmi ports node
Date: Tue, 16 Jan 2024 15:02:23 -0500
Message-ID: <20240116200310.259340-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index d282a7b638d8..cc2d596da7d4 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -337,12 +337,20 @@ hdmi: hdmi@20034000 {
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


