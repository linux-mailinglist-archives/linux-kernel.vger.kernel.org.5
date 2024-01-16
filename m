Return-Path: <linux-kernel+bounces-28216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C213A82FBB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50FB1C26EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FAF16A2D0;
	Tue, 16 Jan 2024 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXNA8F67"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C772D4F1FE;
	Tue, 16 Jan 2024 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435483; cv=none; b=cOXvJaeF2yrBxMbU8ERpmAjQ+//TpiKRqFXGbYBwW4P90xWvPCHIwuZzSBUgwBHo8q+vflsjg7TKHd/4V4o1V+U0XqXcVUr5S/2Qseh35IDF1A41kLE2CSPaKVSmpxYllUTrM0ovhnUUN5NqkQ3W8ITsndhBANzvZTdXMMk9YgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435483; c=relaxed/simple;
	bh=BoyZwHexvERldwxIRCsmteyIZajdYFVcQDx9WiF+kfo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=bKdgcM5CoYeCUFuhLYkrOUE80VTYSuN0OQ+g07GhfReDZAy8DKQKQ6EKb2Na0+TYF+m5cT27gpIWQUX3iMmX7wrP2HHsV++6SbT/ynB0YZQzDBstVFqKz+gJoOlYg7hm7onm86QHhb3h0+zL9CBjce/jPzP4FTydPJcG40w8wO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXNA8F67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D63C43390;
	Tue, 16 Jan 2024 20:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435483;
	bh=BoyZwHexvERldwxIRCsmteyIZajdYFVcQDx9WiF+kfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXNA8F67/IXc5DV5hcVyWrV9zn9YSzraTGvo0AjWhtTJmQqH0mvjzIEOK+iyLAuJa
	 /LwQz4kFh6AO0Tb6TJQKfOpc6Qzk+xXf4XgCeoosFLN8+A5t2MFdslxSCOOt2WKPwl
	 Mibta3mCX/8Wg1LsAykCW8IHqiewSdRwO574W34mfFpUSZY8OL3zjLBOeTg7vfZgXg
	 gxihy6poaBWH1N6GvwaUazE5NamOv0Ku4Lyz7r5NqWzCd+beqLqYED9lm0DK66rjV/
	 7SaO9FjxjCpr026MSJVZmE3NeEKNcqa89Jb5m3PIVTKMpknOIct5Eanq+beyZ8oQeD
	 Z0HF68cCOiLWA==
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
Subject: [PATCH AUTOSEL 4.19 05/22] ARM: dts: imx7s: Fix nand-controller #size-cells
Date: Tue, 16 Jan 2024 15:03:59 -0500
Message-ID: <20240116200432.260016-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200432.260016-1-sashal@kernel.org>
References: <20240116200432.260016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index ebe954f94e09..c62cf9fea481 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1094,7 +1094,7 @@ dma_apbh: dma-apbh@33000000 {
 		gpmi: gpmi-nand@33002000{
 			compatible = "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
 			reg-names = "gpmi-nand", "bch";
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.43.0


