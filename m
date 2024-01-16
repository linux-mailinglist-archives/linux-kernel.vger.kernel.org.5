Return-Path: <linux-kernel+bounces-27966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC0382F872
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE6FB25C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406D9133401;
	Tue, 16 Jan 2024 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhYx6Uq8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A5132C33;
	Tue, 16 Jan 2024 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434699; cv=none; b=TnJv6uUDQ773vBsagXDsrARY83I9TIEb6xcjX41lNf0NGFxR1MKRtdSl5d5ULz8V9227DO1N89t0zg4PAuVrrHpU2wBp0CVTUsupwT8yAgfwoRbOwKMfQUsL9hAyzrePR198EzaPN3cQ0FghBYd52GL2LLFPgz+eeWthiE2el6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434699; c=relaxed/simple;
	bh=WclNoHYwOWS/9SSjNOOeuSrJfawfTcQjmvfKt/iKBiw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=sKU/LIZrE/LnLmPCL1erXSnsx45sMpAjuTdo95xcvidlgcbav1RHLc5pTTH3K915Bg9g+1YiYWGttPBZTF25oQnahJ15kq29AeaXIU7QGxu/2F7aV3CljY8RfGKXDanermzT0sLXdJqZ71ULTuU2PMfqYSM3vyLo6sb7v3ADXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhYx6Uq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A246C43390;
	Tue, 16 Jan 2024 19:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434699;
	bh=WclNoHYwOWS/9SSjNOOeuSrJfawfTcQjmvfKt/iKBiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhYx6Uq8QanwxIrVHU5EbQ+F3nc/pUuotx7Z0sYk/h2f8VBC7hmZpdZS61DymPHLv
	 +BKPQnFagyW6UMHm5djOMQNuHToTYsNZMBy8tjRnQAAmO+qcnG18Wf+rRe8D+KJAmN
	 nlrV9y/QfiFSSsaIIu916robquP5X7z1T2efzlsghANgrEJ8K1M6FiM/2D2Vy81P6O
	 SAguRYCIaySgWAlBOgclFbhFacPRUHREUwBr0Mvv39HOguxBFgWY8DcqI8L7o2WtXE
	 m9pwrL56aXPd/XTklTf+VgGYKqCFhivHS5SCnKNmPDb1YnfHHwdhEcFF/Gt8tLj67h
	 fL9Zpk10FHMiA==
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
Subject: [PATCH AUTOSEL 6.6 055/104] ARM: dts: imx25/27-eukrea: Fix RTC node name
Date: Tue, 16 Jan 2024 14:46:21 -0500
Message-ID: <20240116194908.253437-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 68c711b882c262e36895547cddea2c2d56ce611d ]

Node names should be generic. Use 'rtc' as node name to fix
the following dt-schema warning:

imx25-eukrea-mbimxsd25-baseboard.dtb: pcf8563@51: $nodename:0: 'pcf8563@51' does not match '^rtc(@.*|-([0-9]|[1-9][0-9]+))?$'
	from schema $id: http://devicetree.org/schemas/rtc/nxp,pcf8563.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx25-eukrea-cpuimx25.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx25-eukrea-cpuimx25.dtsi b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-cpuimx25.dtsi
index 0703f62d10d1..93a6e4e680b4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx25-eukrea-cpuimx25.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-cpuimx25.dtsi
@@ -27,7 +27,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
index 74110bbcd9d4..4b83e2918b55 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi
@@ -33,7 +33,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
-- 
2.43.0


