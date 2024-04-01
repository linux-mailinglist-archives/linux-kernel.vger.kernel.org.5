Return-Path: <linux-kernel+bounces-126725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20BF893BFF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90E81C212F1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B692C4CDF9;
	Mon,  1 Apr 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgOcXGi9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EAC4CB4A;
	Mon,  1 Apr 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980666; cv=none; b=JoFtSv3JvYE3DwlOpYSO/mrnHg7Rkmo1I/GK/GuwsWMT/F75PP1CbyXfnQLHU9We8+1RJXb2J+vbhaxByN7+OzkOzvdRs9HVMX/44tYxPkLw2GZ9N53H5mtK7i5cMYF1fYpTcDA3sSZ3DUIRyk9t8hjfbFX0IcqPilULdVeIWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980666; c=relaxed/simple;
	bh=ONm/7OL1tjxeYrGF4Zwe1bnTn4Rgbm7dEO98VGNmguM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SIOczUGTyRzTOiryU/YZajOkWkj41vr4qVBsDMnPaiu5x3uvYC0ls38ce68xn1gyaa/6QqLFz+YfFNiIepHvICcpPmR3ubBjJQMgF1//Ia8EN20lBtzUE1zdScAKdZlIdHkThJMXlR5DknMpllIptTdMvzwxutRAJFkhZrPjiEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgOcXGi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A60C433F1;
	Mon,  1 Apr 2024 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980665;
	bh=ONm/7OL1tjxeYrGF4Zwe1bnTn4Rgbm7dEO98VGNmguM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgOcXGi9Uua51uuhIl+/BvM35cM8MCRhkmarbNEhMEQmhUYikvXm7L5xxK6dic+zf
	 nFKOSSbKZk0eG8ZG6sm6/2nqb25HVFwmoxv6aRGPmV8wzS9Xbss0NhF3xokNUvsasL
	 Ta5mKzGkzVTgnSzYqb5JRMqVdxVAZ62sWj/NcnadQuYbuLOkwqQZ0rL04lPH4it4ll
	 PQ7WPIN1FZntBnjo+PtYTa4AUpHECh3Yrrmj2bIMmgsCmiskqklBxIM0g49MG3DIpK
	 6EHy4M2Rs9tO0um0zvsyREXB6CstKmIMen425vKCmqmYxM2J1EfDyvmct8MvjdbD9J
	 3E+1pKf7Xj3JA==
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
Subject: [PATCH 3/6] arm64: dts: marvell: cn9131-db: drop unneeded flash address/size-cells
Date: Mon,  1 Apr 2024 16:10:48 +0200
Message-Id: <20240401141051.98233-3-krzk@kernel.org>
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

  cn9131-db.dtsi:140.10-163.4: Warning (avoid_unnecessary_addr_size): /cp1/config-space@f4000000/spi@700680/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
index ff8422fae31b..8f2523786cfb 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
@@ -138,8 +138,6 @@ &cp1_spi1 {
 	reg = <0x700680 0x50>;
 
 	flash@0 {
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		/* On-board MUX does not allow higher frequencies */
-- 
2.34.1


