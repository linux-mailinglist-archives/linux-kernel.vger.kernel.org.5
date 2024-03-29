Return-Path: <linux-kernel+bounces-124567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1C6891A08
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6762857FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A3E13AA41;
	Fri, 29 Mar 2024 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngUloVlB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2430153831;
	Fri, 29 Mar 2024 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715422; cv=none; b=PtmlXP+uAgyaLrrHCkNWnOQF/eHEKmMfAhejh760g0cL9UZQxhjdhB2HIieykE/S7anPBMIEWdC8NTQCHZw5dAf+STtvpBnCwND3hp8k8DY850K71hdS5nVMbImEo3R9UhEv/EkHgDv9m3j908GYQOICBHvljTM+Zx7xjgSwXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715422; c=relaxed/simple;
	bh=oZR3S+5IeA9tysyQbtacehydjMfZh62c3cUc0dDLAYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjCe0NCJ8++mBNFVwHfj4TLK2vSHMq95jq2hV4hjTjIW8NjU1RUdNr6dh34tk3Uq/N7GKXGaiJGBCisq0KDtwvf3nx3gE9iue7CRk+RIkgFDeZVpps44co4L28TgLlL+T/9kwXflNqEMIYYMwUDqyZ2HEDOVeeeCkSnzFqZrTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngUloVlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81452C43394;
	Fri, 29 Mar 2024 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715422;
	bh=oZR3S+5IeA9tysyQbtacehydjMfZh62c3cUc0dDLAYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ngUloVlBi3aUKwy0LOQQSrMR8nLz/HYoQWtiZQzq0iShFbOQ+4ZLyq9nqKLkBl/MA
	 hzdYyt/Xk+2G/RqfHyYIB/E49gsOLFyclUK0Q0lJWki/MrmhcFuk3351ZG4Ht5r+Ax
	 jPppydryEh6DXEZmCeH05aZ3Nj8o6XKmHx5ad3Aq7DcgXZl0e93FXEghMCxj9c/+PF
	 cjkTtdPXI3eCjHfstXL//umw2xUZV2J2iv/MRrYP8S5Osl/n/v4UlP3A2OwyowGX8T
	 WZ4wCi4RsifnJ95M14HA5HoWfUJR4B9LU6RMN8KpAEqq3Tbjs8mFfKNfycotQMXDka
	 ARavgJKd+Unjg==
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
Subject: [PATCH AUTOSEL 6.6 16/52] ARM: dts: rockchip: fix rk322x hdmi ports node
Date: Fri, 29 Mar 2024 08:28:46 -0400
Message-ID: <20240329122956.3083859-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
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


