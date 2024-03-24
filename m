Return-Path: <linux-kernel+bounces-115080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED62888CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9FB1C2A7F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2361C41DE;
	Mon, 25 Mar 2024 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leqe7twV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7928A580;
	Sun, 24 Mar 2024 23:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324060; cv=none; b=ltYoU4xuXwpZXESOiBuf/l6XVC7LRP+HjzQbuZ+DIwDn46+vxWw4W3ZrZTtkS1k1PG8fu2lRpTdIvUbbbfKWqaZ4sg6heHXr3g+TGOdrJ8/j52MFOuSChubnGgls7FVXHkYlhk67gjK+f9FxEzGoxwuKLSsEXjTl9G8pv8Mc1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324060; c=relaxed/simple;
	bh=bUpUYMke4Y5Mfy8Ay4xsoBeWv65PZHQBx/Oe/vhxX68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESvrnnbXf5ngpThb44LP9Hspwx1cCAoD+BI61SIOPfH23EZNdI5djnlrlMDFnzCMfi7F+pQf4enDo+bgpoqc2VzslQpKubLn0sNdCYyEHpPIWVCtdVOtUil6+fWJFsCx5LV6Irz/SCjCDPA9IlPgcywJDLV2wW1LeV1PCLFlMFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leqe7twV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8383C433C7;
	Sun, 24 Mar 2024 23:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324059;
	bh=bUpUYMke4Y5Mfy8Ay4xsoBeWv65PZHQBx/Oe/vhxX68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=leqe7twVGCONIPT7huTNCtdc2EGu59PmSZiJOmtTP4tpSFLzJSxnELja2krUvl5MN
	 Hv31XwX7tnvuBhbbHPzA3N22NBaNufVNmKyTP3fSJGNgvD52JQMgdpXWukiQZN5v6w
	 qSa1Jxf6aFsACC/8LGfhG0M0LvSkdOEce5TD4L9k4i0Qs6Ex3x+AFp6qu5Zs1GNVJZ
	 9++oJ9UD6QYAPeFYXX8TjB6yM2wrWI4r2OwI/OhuDpdx6yjZYOdmwB4ucZSeQVtm68
	 yo8eCiWGRmd1UoMHpxMxq3SKRf7jTb3X64ev6JsD8za0PsgI5lK9XKj7j46Lyi7NsX
	 QL3ltJu+0grLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 060/183] ARM: dts: imx6dl-yapp4: Move phy reset into switch node
Date: Sun, 24 Mar 2024 19:44:33 -0400
Message-ID: <20240324234638.1355609-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michal Vokáč <michal.vokac@ysoft.com>

[ Upstream commit 7da7b84fee58c85a6075022023d31edea40e81a1 ]

Drop the phy-reset-duration and phy-reset-gpios deprecated properties and
move reset-gpios under the switch node.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 023bd910d3ab ("ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index ce4a5a8074422..4d1e65c307f86 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -96,8 +96,6 @@ &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii-id";
-	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <20>;
 	phy-supply = <&sw2_reg>;
 	status = "okay";
 
@@ -121,6 +119,7 @@ phy_port3: phy@2 {
 		switch@10 {
 			compatible = "qca,qca8334";
 			reg = <10>;
+			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 
 			switch_ports: ports {
 				#address-cells = <1>;
-- 
2.43.0


