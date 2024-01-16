Return-Path: <linux-kernel+bounces-28198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE882FB7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399B328A5D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D9766B29;
	Tue, 16 Jan 2024 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6h2nyio"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6682165F9F;
	Tue, 16 Jan 2024 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435428; cv=none; b=Zp9DA5Tf1Qc9iCOcK0KYTuz5vUr1b20FZWkFB8kzeh0kVc9Bntlm1+8Kxb381Gxp3gdtiOdwHzwSko+imCawd0VjII323Mi9Oct5wtnHTuZbZ+BcIGwNFgk5rTtBWb9VkPUkF8aUm6b8CezJ4iK78s4Eb5rkoIFGEBPVpOcQ3FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435428; c=relaxed/simple;
	bh=WMCIAVVpv7YNKfvEM440k/VohIHfAGzHfVZ6wGNGHSU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=TOBzY1DeHduqe/SSpb3ZcZj6gMirWS3pku93hcGNYJ4a8o4ZlG98TjLPfsyMqAx+lceb4piX+BwT7CarUU5lmdcaroCunV2uRg7zxU3dWrFvaGh5+4rAwsHiYCZ4LMpf+4TqojErbj0BxcRg/8Doofz+qA7y5jlvGBGpA4Deuk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6h2nyio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84056C433F1;
	Tue, 16 Jan 2024 20:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435428;
	bh=WMCIAVVpv7YNKfvEM440k/VohIHfAGzHfVZ6wGNGHSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6h2nyioxjwY8vedTkr6nZoBIGzPEiJeUtSUzCvfu1f5/ATbOLlkewqqTcv46Brg9
	 Kahgham42Hlf42PkHb9JZkHftXly8rV/fh06agGLgZuhS3JWnZLXLxx+rGw0adgWwa
	 I5V5z8fWSoq2gUeazOHv0E0xDo4PWHrIbCvyiSCpVJJIqWNY8Ncu53852NuxtQSXPX
	 VCQG9qyAu44wMjTLlvu4LXykg+EA8XRr9ANUJhr3v5y9U13nFSVWWKD5cn9LMfFHn6
	 dn02CCOKS59s6DwoBSk0B2qr/YVR+txui1YJPQQRdn8K9A1Ny9RRiMSH5gw+84b0/r
	 v4TYhTDkBmNSA==
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
Subject: [PATCH AUTOSEL 5.4 18/31] ARM: dts: imx1: Fix sram node
Date: Tue, 16 Jan 2024 15:02:27 -0500
Message-ID: <20240116200310.259340-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit c248e535973088ba7071ff6f26ab7951143450af ]

Per sram.yaml, address-cells, size-cells and ranges are mandatory.

The node name should be sram.

Change the node name and pass the required properties to fix the
following dt-schema warnings:

imx1-apf9328.dtb: esram@300000: $nodename:0: 'esram@300000' does not match '^sram(@.*)?'
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
imx1-apf9328.dtb: esram@300000: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
imx1-apf9328.dtb: esram@300000: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
imx1-apf9328.dtb: esram@300000: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx1.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index b30448cde582..a74870d03a67 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -268,9 +268,12 @@ weim: weim@220000 {
 			status = "disabled";
 		};
 
-		esram: esram@300000 {
+		esram: sram@300000 {
 			compatible = "mmio-sram";
 			reg = <0x00300000 0x20000>;
+			ranges = <0 0x00300000 0x20000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
-- 
2.43.0


