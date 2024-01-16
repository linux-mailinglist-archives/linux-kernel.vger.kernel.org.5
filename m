Return-Path: <linux-kernel+bounces-28188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB42C82FB56
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7F71F2499E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6323E164189;
	Tue, 16 Jan 2024 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoM7f/yV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C441C89;
	Tue, 16 Jan 2024 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435409; cv=none; b=i+NA3Xd63fPppFQkEA85psOljGq4Ox51vHIlZd20JtuCc1efoDn5Ab9uBKfBlmyz0qkSDXI8/uphZSxWD839YdRp6sx8CHQcjmHaz+9Nnm1MsER+lmszvHXIU0KxZu6Z1aVHG+QM0+byW5GpkyrPYZuDnbl5jQRrbhHemZDWWms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435409; c=relaxed/simple;
	bh=/ZJma29JDsSASiM6uvuLLGHM2gsrnSezKadeXzBlFBo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=hOY5HpkMu24dkJ078urzs7y3xDZrn8v284oHCuw5/2wMFi7Qi2f1u+AT5s0sVfBxCmnCdlicb4hHgy/nrz4VcOrC3uGNleEedaedHXa2uOK1fDVYRagXTVs1s6WMMV4VRfCMdZQCi5bCd5uuD4I8aWy96a5vD7q9RllgoSw6CJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoM7f/yV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DD5C4166A;
	Tue, 16 Jan 2024 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435409;
	bh=/ZJma29JDsSASiM6uvuLLGHM2gsrnSezKadeXzBlFBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoM7f/yVPKLBXHN92V/5P+SEtTp0I6kbk9gNqcjBCp+kelkZHWC2yk3U/aCKt8NEA
	 AvgDWJcaOxw8Tvqf324zAT/ZyD7uijJGFEcMg3qOFCRkX51aTRIK6E0lGp0lcRepOd
	 aUORG7MEPoXg1g+J4O5zIe/gJSrXtDBxiuSR+vK2b4YXBj0kIxSHhtJXV2W3RJxSTO
	 0QsV8RAv8rpNuvkN6CpEaHqhR9zl4MhdGnSS8WWW3XnNMHDTrzpnZ9upO49qoDvNiV
	 3wjC9MhLh8kAMeZCV52DwRAg80k/i2XbcQfZBnn2UnSZi+vAOMkTq/sZ/yq1cb4EFo
	 AAa7SVtZJYX1Q==
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
Subject: [PATCH AUTOSEL 5.4 08/31] ARM: dts: imx7s: Fix lcdif compatible
Date: Tue, 16 Jan 2024 15:02:17 -0500
Message-ID: <20240116200310.259340-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 33e9c210fd2f..a7ed880b12fc 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -769,7 +769,7 @@ csi_from_csi_mux: endpoint {
 			};
 
 			lcdif: lcdif@30730000 {
-				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
+				compatible = "fsl,imx7d-lcdif", "fsl,imx6sx-lcdif";
 				reg = <0x30730000 0x10000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
-- 
2.43.0


