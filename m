Return-Path: <linux-kernel+bounces-114969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F421888CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A9AB2F778
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622BE2DF96F;
	Mon, 25 Mar 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOgx1VJI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8B1311A3;
	Sun, 24 Mar 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323702; cv=none; b=d1RAlwicFjXttZI/oLCwwj+orKCpIc9UKRJwRGv2ujrmAp/IrcxsZqYLhmSTwWD27623xMH56KzzvVsK13EKEpRlJPd2/tyIQTzFa/INmD2NP2DkpzZzimmJ/m0FHx18fTFn3wURbzy33T1hYl2ySMjMLf7YqZ6nojDN3iZbNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323702; c=relaxed/simple;
	bh=dSI5qBjOnFdBTRPXrxPTEl5Owb7ZLke4MimUaePBXUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYReqU0WPsTXBjV+zlhmkGGpBSgyHRTxUoL4+kGrGd6Q7y7He/v+NTj2zG9ROVihVX6mPj0CCZALTjuH9H4VQs+v/wNI/R7GtemOS9VhGY5d9pfKD070pZBI0GuLtLcJfglrw5WNeDmuGt/gg0HiIc7KgqcBer7CBCapsOuwIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOgx1VJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E9BC433C7;
	Sun, 24 Mar 2024 23:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323701;
	bh=dSI5qBjOnFdBTRPXrxPTEl5Owb7ZLke4MimUaePBXUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOgx1VJIai3Sdkrf1hI05Easi2f+ZXvzjNX3SbC8zdd/3MupIEaGT/jYHFvOMY1L8
	 wHvenyvEp913kemfQPdQkfXpRBkcRmVZOXPN8dJyNjIYv4sJpHjodMqb8oWHqa1wZ7
	 YxzdiKZ4q90m2JkHpta1WnomF7BaM8cJYoPDDuWWMM44ZmGUPf6oVzr59JeWD/WlK9
	 zGhZmTMm6s6J0FPVLF/r0jtGbUZVZxsz0ZmDHW0raDpnYURwRPeM72Em6Bt0gK1b+J
	 5uCho5JhvOpIfwE8JUSfRgHgMZfhe2H1GM4fcSVjW5TBAL4toK4QxqmcmtRGUFXIiw
	 fQjXJh0ar5JrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 074/238] ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address
Date: Sun, 24 Mar 2024 19:37:42 -0400
Message-ID: <20240324234027.1354210-75-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index f18da2b70fdc9..b636faaddc510 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -125,7 +125,7 @@ phy_port3: phy@2 {
 
 		switch@10 {
 			compatible = "qca,qca8334";
-			reg = <10>;
+			reg = <0x10>;
 			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 
 			switch_ports: ports {
-- 
2.43.0


