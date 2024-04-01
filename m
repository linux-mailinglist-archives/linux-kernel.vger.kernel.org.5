Return-Path: <linux-kernel+bounces-126724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37660893BFD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B10A7B21774
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B56D44C84;
	Mon,  1 Apr 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyHGyyd0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486146522;
	Mon,  1 Apr 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980662; cv=none; b=LpLYSXG5I91KA+rnWTqvxudmfL3ZObc3WUKFpLWscZA3lPpamnhqvBvYuS36YI8AIP3nedrHUvibav0RanwF4WJM0fXymQxJHNGXjJbYfGxKBDLtJACLXF1ggKLKrMRXG8q14tQ2KWUjE53VohfsdBdHXpxtefmtb23/gYQ8NOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980662; c=relaxed/simple;
	bh=3IhEI31adVQyJnQgos7lx4Y8uAe5C7BrjsP9gYlW+08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gnPQLGFgk/089kGtsABcIAnR9E2B4KXhgLsrDB9i1vKwdi2gEFfTCKZfPvkkORVixjNnyZwIoYPJ3gywsndQLRy891iQenKLqUG4c787klnTK3b7IQYNY+hfbrUKR4bUaweTb2BSyUnlb34Fi9UqpNSeMkuO7pZjooj6bNAIm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyHGyyd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1C9C43143;
	Mon,  1 Apr 2024 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980662;
	bh=3IhEI31adVQyJnQgos7lx4Y8uAe5C7BrjsP9gYlW+08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyHGyyd0fcI5ofmXib2tNCPeVjERhs6HuXa8G9KdGbU23Bl/FpzERzT7tQ7Ju/IWy
	 tZb8kTO+KZgEirl/mLQoY/8iFaNzaj0Qen4ecioEN91T0ihWCAECrcGi9hJ/fcVEEc
	 Mwi1LV5Vq9W7imy7aoaGPvNCGfpGRqRVpYOrOePvb6Ynop4X0SYI7Kzw+y5SVifDu+
	 d1C4lwMHQeTo4CnEx1dO9YbrN4FKt113VLIT2OcNSGZy17Y/CtmvIhO3SS+9/dTdrE
	 /rVfj3F5XVjm3+KOQ9NaG487RS4MPvPrg7kGPur/Ojoyh1Pl8uLGjkyJu0R2IhQ5rn
	 eSCXN6SXfYahg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/6] arm64: dts: marvell: cn9130-db: drop unneeded flash address/size-cells
Date: Mon,  1 Apr 2024 16:10:47 +0200
Message-Id: <20240401141051.98233-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401141051.98233-1-krzk@kernel.org>
References: <20240401141051.98233-1-krzk@kernel.org>
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

  cn9130-db.dtsi:313.10-336.4: Warning (avoid_unnecessary_addr_size): /cp0/config-space@f2000000/spi@700680/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
index 6eb6a175de38..01d6645ddba7 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
@@ -311,8 +311,6 @@ &cp0_spi1 {
 	reg = <0x700680 0x50>;
 
 	flash@0 {
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		/* On-board MUX does not allow higher frequencies */
-- 
2.34.1


