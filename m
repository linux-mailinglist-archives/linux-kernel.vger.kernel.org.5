Return-Path: <linux-kernel+bounces-128507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BECF895BCC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9CA289317
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEE415B561;
	Tue,  2 Apr 2024 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSh7EaSx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348515B557;
	Tue,  2 Apr 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082772; cv=none; b=gZfeFccPbtzFjc/c9ihEHkQn/XbUUu4rthqoDY4B2bX70AYIwt+6/+aAWqjMJoPQumxJYaz3A7XiSjjYa9dhU6r+F4G34IkpCR0/WGGdvMD7ranekLuf3FFKx5Gmwh1YjcAgI8Z3Pp9diJn4veFj5bj7Dw8gWTGoZmRvatjBz28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082772; c=relaxed/simple;
	bh=HH+V/3H6awlr40M37OnQraPrX1kzaiQ7vKPiegtxqzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K3MiOijZzgixQl0LgYMt87bmtRYZyfI3ey0GGUsKzjyS9uEKl7AlXAQPyvnVPVLg4Dg+t89bYLyOmdXVRmVtv2IG3ATwJR1AHzA+sn8P+w9bQDCt7ZNSUHZAtjnp35nopF/QDHClgTuQRzgsL3sj2Iq3raPKedAFg33Z2KCt0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSh7EaSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57615C43390;
	Tue,  2 Apr 2024 18:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712082772;
	bh=HH+V/3H6awlr40M37OnQraPrX1kzaiQ7vKPiegtxqzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSh7EaSx7pR+liXOFW/xSmNayY4bSw6V623LoWlzL57G0E0ggitK5v3qlAEv48w5p
	 Gln6HnXhoeK74m1FsTJY6ZBXfFPXq4pWzLhIQCsX1mLJA23F6be3Kt2TVUDl9c9V6Z
	 d4G4Y3j7fo4nx7JWsKf4Ys7gh+ehzNJiSq0yGPXyoC9S6cHL31118j303+BPScZHJe
	 lhdWXw0ThVfJBxkPLxt8rbB0vEv4DaxzjNv6fevlxfN3eqxU9FFyqKCr99aoBlWV4g
	 va1PZJnKnl9ivzMnlUnjHs3x8NmJkE8OwOizvfZh64seSh7DWnKaX6RUeW3NtY8FNX
	 4Tuwzvh3CXRKA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] arm64: dts: marvell: turris-mox: drop unneeded flash address/size-cells
Date: Tue,  2 Apr 2024 20:32:39 +0200
Message-Id: <20240402183240.49193-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402183240.49193-1-krzk@kernel.org>
References: <20240402183240.49193-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flash node uses single "partition" node to describe partitions, so
remove deprecated address/size-cells properties to also fix dtc W=1
warnings:

  armada-3720-turris-mox.dts:218.10-255.4: Warning (avoid_unnecessary_addr_size): /soc/internal-regs@d0000000/spi@10600/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index f1a9f2234359..54453b0a91f9 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -216,8 +216,6 @@ &spi0 {
 	assigned-clock-rates = <20000000>;
 
 	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <20000000>;
-- 
2.34.1


