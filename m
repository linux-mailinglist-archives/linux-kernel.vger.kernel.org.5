Return-Path: <linux-kernel+bounces-27800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AFB82F617
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3243A2878B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAE1250E0;
	Tue, 16 Jan 2024 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLE6v6Sv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6FD24B4F;
	Tue, 16 Jan 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434225; cv=none; b=FqqNqXqi1px2nIJkq3lJ1gLBbNnZavjipk/ylfOKH/X8kRKdblYqM3O5Gedtn4caU24xh/BC0Oy9ypVlNH0GOhjUUAYRsbNRUcuC83ZM28V69PsYjLDC4OQTP+fR36n+9AgSqbGo5okqHhGblPweSexQntxa/tujw7cqt8/uzfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434225; c=relaxed/simple;
	bh=npP87G8ku+YAiiVgPnau4596gdaadZlwZC8t10eOr60=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=pF/nCI5cfalfwCjw1+cOxBEIYbsY+Z0x0yJli6EolaYffjeiRphgY8P7VucfJlwLip8qXm86T/S0RsAwd463Lirh62g5NLsvB0jYjkslIGazOnkZFMn6AHoDqnuxGqAbs73Kyw/Wxy7qXv/jmg3sInJZ2PcuY+3UseV6nKUeFcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLE6v6Sv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D45C43394;
	Tue, 16 Jan 2024 19:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434225;
	bh=npP87G8ku+YAiiVgPnau4596gdaadZlwZC8t10eOr60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLE6v6SvUoDzppzi6rRNIPVfsMMnuv0YOaOEdPcsTiLZlNtFXA7we/QTQjikdaslw
	 XZoh0ySZDVbxeenVoK5guI8qpCD0W0uwFNuPqA/qFpf90mzsPeSeRxH1jOMeIKvT6P
	 I149vkImTwqbmYjBDcEIhrOCtNuxHz2JMEnh8t4HgG9Kev5ojV98mUFa5oGShtPlAL
	 flcYcNzlFtGDwOhMxyG+dzChqnfLIPz1rSf0bsFr4cRWIyLpZlc3BvY2p3i/1ia+vY
	 RDbBgXl718WQ3QvnUoRYlPd3ppAG9v9njGGdq3f2Z9p676FzHTNKO6PMCrvNB9AH7K
	 Ux/tFqlqYYgHw==
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
Subject: [PATCH AUTOSEL 6.7 030/108] ARM: dts: imx7s: Fix nand-controller #size-cells
Date: Tue, 16 Jan 2024 14:38:56 -0500
Message-ID: <20240116194225.250921-30-sashal@kernel.org>
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
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index 3bd33255266e..4569d2b8edef 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -1279,7 +1279,7 @@ dma_apbh: dma-controller@33000000 {
 		gpmi: nand-controller@33002000 {
 			compatible = "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
 			reg-names = "gpmi-nand", "bch";
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.43.0


