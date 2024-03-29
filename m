Return-Path: <linux-kernel+bounces-124829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94381891CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D28328778E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207931B52FE;
	Fri, 29 Mar 2024 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY9/vZNT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F117E3DB;
	Fri, 29 Mar 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716246; cv=none; b=A5joND0PlxJGZpNQAhBBqxTq50NdXDbzzFnJHcNsknSMshXZGnaAx5mM5bGqzfTgK+mNAAEfBux3oe78suKD+lpb8QRq7JrZQDHcnNX4m44Whebl+KfPAIFmEvJ0hITVuTwX3H7UD+S5xKvyh/uERp940xdIVzsbGYdAKdda/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716246; c=relaxed/simple;
	bh=oZR3S+5IeA9tysyQbtacehydjMfZh62c3cUc0dDLAYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPaT9gff3vd+/vVzbJP9EE1YoCpQVxUDEG5lqNJn/2LPjWcTj3mmLq2Arp9LKbaB7jSqMAV4BQ6/IJwZo1CfvHBlaGcCwhsJWoh1vyLI/MjlJ2sIvwWoXpkMAGqmRBSmyvFsMbqVVTWxMyI2+J4BJgIISI/LrkJNYJw8duSLfgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY9/vZNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CF4C43394;
	Fri, 29 Mar 2024 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716246;
	bh=oZR3S+5IeA9tysyQbtacehydjMfZh62c3cUc0dDLAYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KY9/vZNTnpetcTdcy/DmXnEIG+JDu96UaDe39ES1f2XrMyeVK+zARNzKKFri4F8lu
	 gBNZVS86kwdNR7jMFNOCEWCPbQnF5Mzn4S3H6BPiqyLUeofnHaV101+p0+TiybOEY7
	 ig6b7hsZ4wLtl/SUlDo/HoCQxuKXM4Joo8fQYb7aFv4E1vznLlOHluzjYbhrFpCdpT
	 2AJ7Vl7xipblutWTj9ZWwE3phZpFMNAC6f0OBAYZEbeeGY0SuLca6LKUQia8hQaVqV
	 sYOJ2I+zqwTh0eI5g9QMBGWFHCXea6CLuSKVrJ0y/VUPyajYyBSGtXXyB6JpfQrmA4
	 NA7znV3bq+dIQ==
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
Subject: [PATCH AUTOSEL 6.6 20/75] ARM: dts: rockchip: fix rk322x hdmi ports node
Date: Fri, 29 Mar 2024 08:42:01 -0400
Message-ID: <20240329124330.3089520-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
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
index ffc16d6b97e1b..03d9baddcbaba 100644
--- a/arch/arm/boot/dts/rockchip/rk322x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk322x.dtsi
@@ -732,14 +732,20 @@ hdmi: hdmi@200a0000 {
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


