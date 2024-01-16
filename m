Return-Path: <linux-kernel+bounces-28099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3542382FA2E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338101C2611D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE62629F5;
	Tue, 16 Jan 2024 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWTwXwnR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA50328DB;
	Tue, 16 Jan 2024 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435142; cv=none; b=tXl5+W3bCthhLHv3TKzsfYeMWap7xGFoIAV7+VwLcNEkWvROEtwbWfLHV69sReEkjWLei3GE7erKCuW9IoveUBzBKlxcdatu+5fBa9YaCMIiHKPnTUP4Ckb256Qd5u7MxLyZy8xCQWXAb/EDvYQNPEzWMWukoVECooixhDUnjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435142; c=relaxed/simple;
	bh=ekug/SuTMSgvxjnirki4WpgFMEILSON0MitIGfBMEyo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=AF5aBLiRbN75ksBWbL2RpjghwngJnsr3PvUCRN8OQsKzgencwf41Q3wiw91FUJThA7aLBQlV41UdVSwSbRht+q77ulUvjm9ZTDqdMnvhhkJ5NNd/8ne604xPRvhNhthnwz53poc79oV7EdwizxnY1x1EyUWTHA0TpJVew3aZsrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWTwXwnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFE6C433C7;
	Tue, 16 Jan 2024 19:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435142;
	bh=ekug/SuTMSgvxjnirki4WpgFMEILSON0MitIGfBMEyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FWTwXwnRFx7PlbbTKcNiB16UT2hGJUTGcpJ+8EYcVKLARHN34vDP1YOl97RUEZx3u
	 lXWAu0XBI98ml9Ogg1RGndzRF+kWwVQ98L+YWQCDReWPv0ett0OLegtCfYIq1eOJhQ
	 L8xPqlyflz5BaSd2IQVwEdd48HPZIOIG06o0PKin41nckPardJGYdlVcHsVW+7IL2S
	 PX2kQ2sQKobaetBnA/wOGzJ8CDFCKbQNAze2ZO2kYmk0Del/lDD5AcoRLteUBsy2aX
	 NhMAKyGcpZ5rT0/5WTQJ4vZQqKrLxWjtIMvTf5W64oHhlihRrbpw8I5xVJtRv8E2X7
	 vXHYBQwSYLd0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 12/47] ARM: dts: imx7s: Fix nand-controller #size-cells
Date: Tue, 16 Jan 2024 14:57:15 -0500
Message-ID: <20240116195834.257313-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 4aadb841ed49bada1415c48c44d21f5b69e01299 ]

nand-controller.yaml bindings says #size-cells shall be set to 0.
Fixes the dtbs_check warning:
arch/arm/boot/dts/nxp/imx/imx7s-mba7.dtb: nand-controller@33002000:
 #size-cells:0:0: 0 was expected
  from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 35ee179e5ae3..5b960849c3ab 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1264,7 +1264,7 @@ dma_apbh: dma-controller@33000000 {
 		gpmi: nand-controller@33002000{
 			compatible = "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
 			reg-names = "gpmi-nand", "bch";
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.43.0


