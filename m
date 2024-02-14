Return-Path: <linux-kernel+bounces-64911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC959854492
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7171F2AD66
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8F410A31;
	Wed, 14 Feb 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="Me3G5LOv"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ECD12B69;
	Wed, 14 Feb 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901472; cv=none; b=AamBg39XB3B7IzuZtuzYzfdywZVgYBH2olN3ZebdV7plY+RYjB52DPPCfaVyGz5zk4rX07OHWSC7Z7zrEFfakg8rywDDXPEeb6tjch40eZWapakV0Z0kTG2ghA59LnWG38Irv4DAgkcbERXznRTVopqzEvwUsMQ7Qtd1t0uyf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901472; c=relaxed/simple;
	bh=k2Ua0BUioff6yVOPjfAMB6cmw2YUod1OM6YS1kOR0l4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CGggJpKcILq4W/+0XDX+wrs8TrTz5h6v51/sOCStl7L1M+B8L7CKRdAm8jkOSJjn7/7Wp9WKYJAQ9VQOp+mApvotHk4b99EAU2ciiuOO5GqxdMSXZEeePsKeC/OxlarWNPgh1qXDSPXTJKtoUuyjHTd2K6p63Dlx4OS9GDStV+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=Me3G5LOv; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1707901463;
	bh=dSH5M/hZskQhXXQ7gwJpwqRlm8EjLoGmoPzajteF/A0=;
	h=From:To:Cc:Subject:Date:From;
	b=Me3G5LOv5e06zvpXVriQkwtce2FQXZ0w1IDjqmddlNTBwsjouxNcwNECTkKbFzPkZ
	 DPeZhgN6CginrzcnJTvfX/VVVBVed23FAVUJC6NlNhLcbh+PXktTI3i1wYiuL3ULxr
	 S7rbRmuUrL0R26Vq8FjRqLeg4bHgoFsN89H1AnFg=
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
	by uho.ysoft.cz (Postfix) with ESMTP id 2A610A01B3;
	Wed, 14 Feb 2024 10:04:23 +0100 (CET)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2 1/2] ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address
Date: Wed, 14 Feb 2024 10:03:27 +0100
Message-Id: <1707901408-17084-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This change does not have any functional effect. The switch works just
fine without this patch as it has full access to all the addresses
on the bus. This is simply a clean-up to set the node name address
and reg address to the same value.

Fixes: 15b43e497ffd ("ARM: dts: imx6dl-yapp4: Use correct pseudo PHY address for the switch")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
changes in v2:
- Reword the commit message so it is clear that this patch does not
  fix a functional problem.

 arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
index cfb0fc924b42..5763f8253d51 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
@@ -143,7 +143,7 @@
 
 		switch@10 {
 			compatible = "qca,qca8334";
-			reg = <10>;
+			reg = <0x10>;
 			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 
 			switch_ports: ports {
-- 
2.1.4


