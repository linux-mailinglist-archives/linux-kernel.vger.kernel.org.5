Return-Path: <linux-kernel+bounces-113155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA68881E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88AE1F2188D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB8172639;
	Sun, 24 Mar 2024 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emm9MP/I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E1170EB3;
	Sun, 24 Mar 2024 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319958; cv=none; b=TsEoOscRs9UslZKRHyyPKPy8OZLJ2fwGIZ3qTfki367I1ptq5Ae7zfVyzkHPyHgSJUfUe3X0Wt5sD7JY1y/G2foQ/e9JOJEHKJhGwgipC+xHHo/hidxtaJPwatHNtt7iT8H5xeIuw4ydzdXNQiNUKrBoBF1LzELiwHkVy9cJ994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319958; c=relaxed/simple;
	bh=ND4MKUcYcMyYShL2dADwCd1T3/24PLG/95Zp8DoRkb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBMmO0MgxKz5u92Qf//ZgMmwzLimkq7ZlFyqC71RuDTw6fYGGLefB1Y5tDvmOcsF6EDSLSTFtFEc+uL5xG5Qjp7J+K4fEculKP+EbwzrRc2sTW+FUebJw9MI7w/MiSn/T930n0NWjY0+oqgworE2QA6Eh1rCxJMS9DPDG+r+cKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emm9MP/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072FFC433F1;
	Sun, 24 Mar 2024 22:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319957;
	bh=ND4MKUcYcMyYShL2dADwCd1T3/24PLG/95Zp8DoRkb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Emm9MP/IVNvCFCvnp0en5qvVST+bgm5J4FT7VTMiuNSqGfdjSe4Zx5iBMLehEvx7W
	 56cWmtTaFiZh1lhYdrscG56TMKwr9j8oBSJTKbPbrjkwEoqQZzOxt7aagCpIu/iqZq
	 2+Ca3uBMk0h02YkYoMNulXauASrwoRbhogP1cY5im/ekEw36d+AGfA4ZkPu1wcdd9U
	 lxkNu2VX54A2Kj0W3NVLGFvjzaFE8GFZOKEE5L/aCVE5Nd/3CXK2IJFB4UzVK1fZLB
	 gE1uKQWyzK75JuBy89HMbeLdSMibcAcNVsqF8/LSXiSaNYaBaBt0TKMgtAjUR9YcFQ
	 7PK6YKyRHTu2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 264/715] ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address
Date: Sun, 24 Mar 2024 18:27:23 -0400
Message-ID: <20240324223455.1342824-265-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


