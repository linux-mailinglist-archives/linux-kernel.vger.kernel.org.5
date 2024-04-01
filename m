Return-Path: <linux-kernel+bounces-126722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5AB893BF9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E271C20C03
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1240D4AEEA;
	Mon,  1 Apr 2024 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZrH/g4M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E34AED1;
	Mon,  1 Apr 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980638; cv=none; b=CAj3Y4iJr7VOVR3+1I2S0gjQd+sZM9FHbz/hTG36wGOwt8Q1dxIv3nLaAtWKzPVdvKXum/PO73UyIZJZdYRhv8nXFiMVXhYKlNSuujzfeeKk5xEQMcXK9Ki8//D6Uc7whoz1RYxLMl7+fCrri9WlB07baJTcVWcXi796poMDV0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980638; c=relaxed/simple;
	bh=Vc7RoNzIIhqz3cEik7q+jldp+Dpkulw+lDFJ9hSu5Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H7W3U3u4IqdjFfcni2OOMW+C8pnHA4i6I216bhpyJKYMgF8MncJGNSfdlg8ESldOP9E2vw339dB3oSiOqV+HD6yM5PG28VGywcBsoZ9C2ItPAMwU3XRR3Fi6W59ozqog1OjhEGMYzTiaFSPcyN+H7LMf8EFhHzMDraqcQjIYP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZrH/g4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223E2C433A6;
	Mon,  1 Apr 2024 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980637;
	bh=Vc7RoNzIIhqz3cEik7q+jldp+Dpkulw+lDFJ9hSu5Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZrH/g4MXW2Vz0ah7J+w0QXuXD/DrbxnYFAKLo0A+52fDIZG1tQsMuDl/RF/5rYbV
	 zJETv82sJOEH5iPbAFFEQHdLKPPGOMj+5k+cic1Cmk/nV93GsULxRznLb611r/Gbdv
	 6T8HpUWBoRkK/XTxTWHk42UCCticRXIjRM2WLf6kXMsKU8v37SVW7DYoSx5Y9sdE3v
	 fiUDjnpVqcr1eqjg86s2jMC//aBCe6qvpqq8x0B8cKoelS/R5wW0mfdEs9mZY/eeTJ
	 pVy9S49leEkDmxf+FZIa0CZ9eUX48iKuCYKiKitfshKFmE+m2ik54+FPxPA0q2lo+t
	 xngz5S7n3Q14w==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/4] arm64: dts: n5x: socdk: drop unneeded flash address/size-cells
Date: Mon,  1 Apr 2024 16:10:25 +0200
Message-Id: <20240401141025.98125-4-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401141025.98125-1-krzk@kernel.org>
References: <20240401141025.98125-1-krzk@kernel.org>
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

  socfpga_n5x_socdk.dts:85.10-114.4: Warning (avoid_unnecessary_addr_size): /soc@0/spi@ff8d2000/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
index 2d70a92c2090..7952c7f47cc2 100644
--- a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
@@ -83,8 +83,6 @@ &osc1 {
 &qspi {
 	status = "okay";
 	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "micron,mt25qu02g", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <100000000>;
-- 
2.34.1


