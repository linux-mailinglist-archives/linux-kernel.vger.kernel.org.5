Return-Path: <linux-kernel+bounces-28147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A66B82FAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF0D1F24BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E401515B960;
	Tue, 16 Jan 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcaE9NLE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C83A15B312;
	Tue, 16 Jan 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435275; cv=none; b=TxKtlA3jOUCugHP4maH+rz7Z/eHSaDS0vNsnDSDdP9jaxGsMgTRjyRCY87QWpuMwz8gCJQqZIyr44HrPZ3QVXhKaLsgVOpX3Na03m30tQON5XBWsAM+WY/bYrYoXACx8W04gTKHEXuLqcHXwXaBM1vFHu95jnduxym/rimHPx4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435275; c=relaxed/simple;
	bh=BBfdpFty9amT/lULqV83gz715JNzpCSShhvgDHeRtig=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Ocj1vqYkIeA3saI/qp6JVEmnvyQD9kY+mOZ2V4UtNP0JVwIGMQtyLvSeoVirzj9TLnploFfrJiM+MlpfLf+5tdtAxnhhaxZL9bOOcJ3KQRKU/btNBe6AWBRo+oRg55qJxE3FX1VOLzO5I9Tx/tv4R3huFyn8Ui9ia/31XXJt/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcaE9NLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2D9C433F1;
	Tue, 16 Jan 2024 20:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435275;
	bh=BBfdpFty9amT/lULqV83gz715JNzpCSShhvgDHeRtig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tcaE9NLEAA6kc5WsaLcHImQclvrAezv2UonmYw/8F0YSgFjCnw1qGHGFoAMmgNCIM
	 OP5UXY47JZwEglTgZWTo0aICAh92mtbmvM7Fx4PeP6ThgbA8BAz06gJVdcp4rVd0st
	 m80I0YfgMcWfDtfUeB7T8yet2Xf0m69HosB3E+8fRcbhtymRdWerof8DgCf8dCWuuL
	 LigNresuEwsLr90/IDqJuwOKNKlem1AqQ8EXsBhuZR7OBdtziFicyrSDpfr+Eba6d0
	 z87OFopcQBNd5HGPFCjxqZuEMM2nNVy6OPH+fFvgau2p0WBb/id5ijw/hjjDB5nVhT
	 jO04MhZACh/BQ==
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
Subject: [PATCH AUTOSEL 5.10 11/44] ARM: dts: imx7s: Fix nand-controller #size-cells
Date: Tue, 16 Jan 2024 14:59:40 -0500
Message-ID: <20240116200044.258335-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 31ccf65d159b..b4cab6a21437 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1235,7 +1235,7 @@ dma_apbh: dma-controller@33000000 {
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


