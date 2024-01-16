Return-Path: <linux-kernel+bounces-27838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C5382F699
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B601C240AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA9941C9B;
	Tue, 16 Jan 2024 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLSRB6tW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4809F41C86;
	Tue, 16 Jan 2024 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434342; cv=none; b=sk6Nnmda7MMPEu3G4+BBiCVQfGADlhflxZgbLnDocAQvlTshcAzg53A3Zs5OmMyKlQKN6N3ZFIdWj2mkTVl3fmlRDgSB8iwrFglIeTNyB8E4OxlYfq3vRmWJi2/7LjGC7IOhrODHvx7Vxzhj+wkL/ZdmGoJbd5tNWXk+UNWjrCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434342; c=relaxed/simple;
	bh=mHejoVzjgqDATyhahypnvy/IWXOFgwujvly5c+Kz0us=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=W0Kz7lwP8gbMnQFZPBK8vj25D+w/sbvOBwcKh786iX2ka6h5w9CBpJ0UxqD5i+Z6mvIq76YGKeGi855zd1o3NFtzds+WyUM7J1xs+QauGOfoNzv3FtjmMpbnw8xJztdZSVdiaKtRwBbxnW1MKOo22cXO5zbvNmjDSlqF1i9GIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLSRB6tW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9FBC43394;
	Tue, 16 Jan 2024 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434341;
	bh=mHejoVzjgqDATyhahypnvy/IWXOFgwujvly5c+Kz0us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RLSRB6tWXLt1yy1LkRZX4Jo8hczxUU2TjysT9LWcZG4xkJmlm8ySARzivzaDd8BtV
	 V5lLamFUpt3a8cLnjs2k6RXuKbvcsf0MbhcvWGt0BM/d7/SzlhAAEmiEWjCojHkESS
	 TNx6Hma4w2cUrWwRWp6X3bBVhPiGkOuwn9SyA+v5DaTRE4oEAJ/UY+2GQUKUFH9QT+
	 6oCBQCexmGrItglRAWD3yWRz4RA5BVySSaCano1RjFKv9f8jtf0gkx9HCBoizQybpX
	 47/ttnIgRbG0H7URMkxYyJMrwVsKs4xEitHVvduNZQIlRskeu+EjWe9lOML3a/qll1
	 oTsKIgbzgeMVA==
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
Subject: [PATCH AUTOSEL 6.7 067/108] ARM: dts: imx25: Fix the iim compatible string
Date: Tue, 16 Jan 2024 14:39:33 -0500
Message-ID: <20240116194225.250921-67-sashal@kernel.org>
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

[ Upstream commit f0b929f58719fc57a4926ab4fc972f185453d6a5 ]

Per imx-iim.yaml, the compatible string should only contain a single
entry.

Use it as "fsl,imx25-iim" to fix the following dt-schema warning:

imx25-karo-tx25.dtb: efuse@53ff0000: compatible: ['fsl,imx25-iim', 'fsl,imx27-iim'] is too long
	from schema $id: http://devicetree.org/schemas/nvmem/imx-iim.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx25.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx25.dtsi b/arch/arm/boot/dts/nxp/imx/imx25.dtsi
index 534c70b8d79d..f65c7234f9e7 100644
--- a/arch/arm/boot/dts/nxp/imx/imx25.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx25.dtsi
@@ -542,7 +542,7 @@ pwm1: pwm@53fe0000 {
 			};
 
 			iim: efuse@53ff0000 {
-				compatible = "fsl,imx25-iim", "fsl,imx27-iim";
+				compatible = "fsl,imx25-iim";
 				reg = <0x53ff0000 0x4000>;
 				interrupts = <19>;
 				clocks = <&clks 99>;
-- 
2.43.0


