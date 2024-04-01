Return-Path: <linux-kernel+bounces-126720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341F7893BF5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68B91F2206E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5151D481AA;
	Mon,  1 Apr 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTrbP0GT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BA4501D;
	Mon,  1 Apr 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980633; cv=none; b=ZnCVCWtqXNcYtjglUJWDXBwfdSzdKEEtLz9tOozTzvBn5oFVg4bjXlDSamXOQSn4veraqt98S/1NYsNuYjLmE3Ul/C2gQbe4I4yoTaeoTkkcNqidp7q/iJPCM3DY0YdIhGsnt7GGYgJSJq0qFGNDb+AGcdmFQa+7l+NSlkWqMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980633; c=relaxed/simple;
	bh=+3Qc0b2nf3TtY60DbxFwN5jVCrWoQrm/ZEJj3Y2C5mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMo1cW0/VRONcJHfb0ydGvm3pQpGK3h0JPKroFRbJmQIF2d7mXcCoYzs6Mmb7eUjQns9NAI7Ol1ohSEDAs0MxqNxCpKrjj/ZtsZnVj4kwDVkAC4cK8enbhQa6bc/huwFdjuB9+rbH1jXCn36lGj//njfR8ST7scoezTANky28V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTrbP0GT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A722EC433F1;
	Mon,  1 Apr 2024 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980633;
	bh=+3Qc0b2nf3TtY60DbxFwN5jVCrWoQrm/ZEJj3Y2C5mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTrbP0GToae4bESfZ55+LAxm0zc69lp3wTZCG8vnl7nPeTJLAl6GK9E7knZvsg1GD
	 Q2EtX0iRnFwPOMy2LO0GSH91KpRylhuaR8PgXjNosogbKzNiLvcn03uKw8cA+RpVjH
	 8RE2rYuoKz81ief4aOjwswlY3FzTgc3L4F2QHHgsS0WgJkCtJOZjhWLtCOhEv7cRwX
	 sUCflCWLJO26KhUk4TgNHqNnzw60HSoV4YmZzKRj0nQMvLaG5+7XzKJ6acQc3rO6Z+
	 OSQkEbqJQ4a2vgF/V9SrZF2mds574FB0Sy2Mp3f97OwM0v2GbAO4S4MnL+MxBVBnTq
	 /MvGqw1tZB19g==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/4] arm64: dts: stratix10: socdk_nand: drop unneeded flash address/size-cells
Date: Mon,  1 Apr 2024 16:10:23 +0200
Message-Id: <20240401141025.98125-2-krzk@kernel.org>
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

  socfpga_stratix10_socdk_nand.dts:171.10-200.4: Warning (avoid_unnecessary_addr_size): /soc@0/spi@ff8d2000/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
index 81d0e914a77c..7c53cb9621e5 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -169,8 +169,6 @@ rtc@68 {
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


