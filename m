Return-Path: <linux-kernel+bounces-27799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D9E82F613
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B7287663
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2133B24B43;
	Tue, 16 Jan 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWMElQJl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777A24B35;
	Tue, 16 Jan 2024 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434224; cv=none; b=aJmHXL6DNIKCgnKIWspryMMI/TUGFdzVb5BsYNlBXgOcpkzk/AwHyPKlntzErQgoX2+l9Ssh8CNeMYn3z0r1AwVIjCsoXhhYGCSKGutQ1GVYlpKyQLyxQMS/krIWba2TbKf9xxVX7lJJyrCkXP7p9QemRyzwyLumExXBX+zcPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434224; c=relaxed/simple;
	bh=gwC6cIyv8irpKqceDLrdba98Riouet4jemmeWc8++YY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ONGhBU9vg2LFgwBuSuO5KtDPJF/xgMaCrMCy7nP6NYT1RH8xjepANec1SHUoMyDOUis3jh5W5cbkOhjwHACIjkzr89pLkPUTMW0KT+atCqHy7vOxZyFGiYpHWSrXTmg8f2XNVnVAWSuBi4sN+iaUl79E97uJHH6kHV/w+Ar2PKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWMElQJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B786DC43390;
	Tue, 16 Jan 2024 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434223;
	bh=gwC6cIyv8irpKqceDLrdba98Riouet4jemmeWc8++YY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWMElQJlThFcZD3zmr18YVhZOXEWnaF8JR89/WV3XrPzfIYZ3IpxPAYLdTKRivUeN
	 MygLh9B7mMi9PSXJ7U9/4oJ6k3UBmPcp/1Rk7TQA4e8wq8yeuKTcVGsnJMM9boaHgH
	 vMs9jMvMAf6FEa1nmxqLqLkIip67P5DzP4c6GWPktfYHnrJqNoTUFbkAva3jgcxC2O
	 rUYvOzjrpSUuXEpjQ3dVFebAa0DA6ZZhlImFD1b8zugOttXK/dbp5RPvqIUn3rxcJ8
	 kUboqW6eo2WnzGyvlzdGCv+DnR1hKxNGQ31UCLPHyj5z9Ts8y5Nk+pVTbDWjFZkJR/
	 t5nYhlG/YAgJg==
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
Subject: [PATCH AUTOSEL 6.7 029/108] ARM: dts: imx7s: Fix lcdif compatible
Date: Tue, 16 Jan 2024 14:38:55 -0500
Message-ID: <20240116194225.250921-29-sashal@kernel.org>
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

[ Upstream commit 5f55da4cc37051cda600ea870ce8cf29f1297715 ]

imx7d-lcdif is compatible to imx6sx-lcdif. MXSFB_V6 supports overlay
by using LCDC_AS_CTRL register. This registers used by overlay plane:
* LCDC_AS_CTRL
* LCDC_AS_BUF
* LCDC_AS_NEXT_BUF
are listed in i.MX7D RM as well.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index 9f216d11a396..3bd33255266e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -815,7 +815,7 @@ csi_from_csi_mux: endpoint {
 			};
 
 			lcdif: lcdif@30730000 {
-				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
+				compatible = "fsl,imx7d-lcdif", "fsl,imx6sx-lcdif";
 				reg = <0x30730000 0x10000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
-- 
2.43.0


