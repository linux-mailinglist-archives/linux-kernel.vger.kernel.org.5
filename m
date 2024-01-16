Return-Path: <linux-kernel+bounces-27840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF5282F69F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4E61C233A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA28047F40;
	Tue, 16 Jan 2024 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G14vVpwz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C341C86;
	Tue, 16 Jan 2024 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434346; cv=none; b=GkX0qHNAM6DB+VFZ7G8tO0PjIRcBaCC0JYm0ebVj+z3qnXk7cjnsQF/dl22f2u2bc9MOGJtiPr3+edcFtKlB07lDh99m5EcPEdcF270pnACgBPf2/aVQR/HcDpTckhlNTKhSZHTlDlve+US7NG4SyJ0nIijIu3sqt2+Gv+EIMdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434346; c=relaxed/simple;
	bh=arElsaYX5SkhFivEekp6V5p95usKRlSKuiPhQlJ5Lgo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=WiOGmn9mj8I3UPt6T1WfXbGk3R3/lj37OmLWBP3554SKsr2KqkAaafei0AmOdrUCWOG8Epwl8pwp7zLSd2UwNFsSqEJWqUUgSsdt2AQVvBnpQ64miTxleP9bnAuQ7/RKhdOIMujkwgo7TAQKfLWutSvQ8beUR0b/BCAC6SoeDAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G14vVpwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D51C433F1;
	Tue, 16 Jan 2024 19:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434345;
	bh=arElsaYX5SkhFivEekp6V5p95usKRlSKuiPhQlJ5Lgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G14vVpwz8lbDFhQq7nHbUGCqqKBX+jAxANg2MOm/n7H2jqHLP8dTdsPfpDhqgXxKS
	 vwaQk8wPO78pg57TXPClVicSd1DKQ/JJpUe+VOqru4pBw4HiOOInyy+AZL0HtwdGYF
	 oXiWuh6+3l+MJTWTbVgkBhiQIMJ1cM14hplrJyMGjMinQxCWiwCxI1gvxubVmqtMYI
	 oA5pLsMa06ZfLcHYxwU3SodqofnD6CBP14/DKnflhP+SomSopa3HypAGNFWHwZfY5a
	 rsyKtQ60nTetkpnbrCyQmBULmUHWhwhGwtsm2Uwa9yklsiyacf+5/B7Ztl5FZwk9OG
	 vuEnX8tIqXwoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 069/108] ARM: dts: imx27-apf27dev: Fix LED name
Date: Tue, 16 Jan 2024 14:39:35 -0500
Message-ID: <20240116194225.250921-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit dc35e253d032b959d92e12f081db5b00db26ae64 ]

Per leds-gpio.yaml, the led names should start with 'led'.

Change it to fix the following dt-schema warning:

imx27-apf27dev.dtb: leds: 'user' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts b/arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts
index f047a8487073..849306cb4532 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts
@@ -47,7 +47,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		user {
+		led-user {
 			label = "Heartbeat";
 			gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
-- 
2.43.0


