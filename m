Return-Path: <linux-kernel+bounces-113742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ACE888655
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4154B28C9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC451ED73C;
	Sun, 24 Mar 2024 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjVEc47v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316D1DF799;
	Sun, 24 Mar 2024 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320749; cv=none; b=mMo76ocYWQW8Hy3VEBOEeNy7y6DjbQK1yO/rqlsLf0LCE2zEGlXfgqha76gJrKg37Tw2JAB0XmkqhAP1+kpamJ2vbCpJq5VcnN2zJjb0wHYQJQPrnOO7UAXKS2QAIyyItGFQCfOxpFsT7ZxD6nig4XrgZM26qpHTNPLmdAr4prI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320749; c=relaxed/simple;
	bh=ND4MKUcYcMyYShL2dADwCd1T3/24PLG/95Zp8DoRkb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZN4H6IuA2bLpU23t9OqB3smoamt/MMsEV9tfzgDR6wH7r3l7M7C/NqAqSf97h4dn27jSXQ1NAhVeF1Q6fX0+FQta3a59ng9bfF++/h3C//5p1hYQkcW2GtquKDr56nwtCriSvvunQ0BBX6JGqdBjIDoG2bOof6apsRMUaMztDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjVEc47v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6916C43394;
	Sun, 24 Mar 2024 22:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320748;
	bh=ND4MKUcYcMyYShL2dADwCd1T3/24PLG/95Zp8DoRkb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjVEc47v+4R5zufa4WGNNU1csMRdYrvhDrz9BPJxzAgj4VNx3j2dWKEq4xm3t452b
	 UV9inHZQx31Zw5KXPISQo/6bYGRUqLRgRoieNdOABvg2M0v5z2OKehql+qaP+xvJ43
	 XgpebxAQXcrcU39GCT+zsDVcEwqeB7UcHwke1jSfU6/K1phuaO123UOwJ2/Of7imlV
	 lr3oWj9esv0fXna/dfksIb6qm5mXgqVmaTrd5puPTDe7SXny0gsKtCM6d4Wee39GTW
	 RytJIsdMtm/VNp7L6HwgM7Eup3PYatNwqyyQC7oJDkuhLDHqokI09LXn+/lCNZfUOu
	 4lNkgSusI72mQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 312/713] ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address
Date: Sun, 24 Mar 2024 18:40:38 -0400
Message-ID: <20240324224720.1345309-313-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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

[ Upstream commit 023bd910d3ab735459f84b22bb99fb9e00bd9d76 ]

This change does not have any functional effect. The switch works just
fine without this patch as it has full access to all the addresses
on the bus. This is simply a clean-up to set the node name address
and reg address to the same value.

Fixes: 15b43e497ffd ("ARM: dts: imx6dl-yapp4: Use correct pseudo PHY address for the switch")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
index 3be38a3c4bb11..d2b3e09eb7df8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
@@ -127,7 +127,7 @@ phy_port3: phy@2 {
 
 		switch@10 {
 			compatible = "qca,qca8334";
-			reg = <10>;
+			reg = <0x10>;
 			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 
 			switch_ports: ports {
-- 
2.43.0


