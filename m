Return-Path: <linux-kernel+bounces-114808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5866F889164
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F67294586
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239EE269918;
	Mon, 25 Mar 2024 00:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+lp0qPG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F62779D0;
	Sun, 24 Mar 2024 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323412; cv=none; b=Wz0qeJFGWiHlUluLDi6OQE1ACl2pw57x+eY+pjfJhVtNaYWuts8a+II5NOGmtooDvDlep1q45jKCuD9cYyYzRCrbaJQzcj2yQBk0073PObbfqbn3EhtqN+GsOknQ+Gq6AWbZlk4B3UTYLg31DC4kwovImEg7YjLMKryE5mBolqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323412; c=relaxed/simple;
	bh=EWqCXld5+/sFVJsxeZf7kglMBM79UfZd99Nrpl/QVdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYqMkvZLLOXS5ImBYXWMx4wODixzFWnuFrWOvrJGpyuOXO4dJFijGpssaFKbrZnDqio9bCrfWwdrrAS3TKSmZWT8ec3MkR3rDLGktzPV22cJvWoQ/HpjHmruxiaYEVNpopzd7Qbbhi18+mtPld1t06Sf7eWo037eReg49nUulf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+lp0qPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AED7C43390;
	Sun, 24 Mar 2024 23:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323410;
	bh=EWqCXld5+/sFVJsxeZf7kglMBM79UfZd99Nrpl/QVdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+lp0qPG3Hu8EeOFG40OLlVpLH0yjESAiNy7qL/lovWdaVciWdODTU/4Bz76b8Nb4
	 L2m6ohip1mQTWrCzDW9jCuSAIrrsxGVT7WWKnBVhJY1dKQs1/qqgUKuZysB8rsgFm6
	 NM5eD7NcAy33CB+Kzxn2XTg9fDGgABGK2jMUXeWDpNwqIeBO92M0oPf2vFMjmNxZZq
	 fupuLsRamt57cpfBVNcnZ+ibvGbGUmeFZXJ3pDMCy/02Wi3MKOvMi/MWv6iTBKllft
	 ZfMu+ctKbl6+3gQQCTLJ4lhfxcVLKZ1/T0dWluktjoTR0PwaTKoBAQt9Qm3hY72Sd0
	 bkNX3UzsSauWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 112/317] ARM: dts: imx6dl-yapp4: Move phy reset into switch node
Date: Sun, 24 Mar 2024 19:31:32 -0400
Message-ID: <20240324233458.1352854-113-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index e5c4dc65fbabf..844f31f7c4114 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -105,8 +105,6 @@ &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii-id";
-	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <20>;
 	phy-supply = <&sw2_reg>;
 	status = "okay";
 
@@ -130,6 +128,7 @@ phy_port3: phy@2 {
 		switch@10 {
 			compatible = "qca,qca8334";
 			reg = <10>;
+			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 
 			switch_ports: ports {
 				#address-cells = <1>;
-- 
2.43.0


