Return-Path: <linux-kernel+bounces-27876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A9782F716
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5569D2859B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9D46EB5F;
	Tue, 16 Jan 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8FxST3E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853C6E2BC;
	Tue, 16 Jan 2024 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434414; cv=none; b=WvfMYHnBh6dQHQRNCWWJPnp4uO8huGpcvwJxR0AKiLE+5FC/X9osFRavbflU8/qPvNB8r4wi5a+sTdG/H9Mr2LA+RFYpaAaGoLLkuTEO5GtqR9Jnpe9ns6lV/5Ys5HZSb6jlMliypkvXA8ob9d7zzjfx/EOtWtf3sXV88VS+B0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434414; c=relaxed/simple;
	bh=nGHY1WKzTqPdqg3P8pbhZCk7xp1yaqoB8FolSVNnx1M=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=jZW5GmY7TWY/kE84KcPKzsudqH33Qm2U2evcLUkxd+A2SxxQEPLNCxnSSCi4q0NN8AjnakTDTvDDocq0SWmkWS/AIiDVGqKOIgajvXe6+olS3pdk4QLdxbv9D2Nf080O/yzpdBFNyH3A+rc6+/Y/KqkNloqqRAMMVWizAvPYXvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8FxST3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57186C43394;
	Tue, 16 Jan 2024 19:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434413;
	bh=nGHY1WKzTqPdqg3P8pbhZCk7xp1yaqoB8FolSVNnx1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8FxST3Ek6FLmoZ0PZbGf33/UE/ocWR4GM/Xvc3p4/sKgKP/vgriL41Xe80wx3SI/
	 9T8BJVb5lkvrDAmMe1SmM1YwNo+Y5t/wgiAtQS22LSdIgR3nGQ3sKQh3pW4r8qDY7m
	 PmmEVmXzkFgEd6KTflwp8sa0RxWa33OHUp+5KzR0G3RW5w+vjOzZbS/cQDeOq8xQPa
	 oUbMHuWmxr0lN3B09oBe16oaU0a0P3eg8/rhgfVF+31MyDTxPmQJpCLV/Zrwbupo+2
	 XeNYslPgtc89nn8DLAAoePXR7QdG2GsLn38ZdnMX0P9HQSvmtA2TiPjYr0n0Sn3O4a
	 H5NOQWXQJ3tLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	orsonzhai@gmail.com,
	zhang.lyra@gmail.com,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 102/108] arm64: dts: sprd: Add clock reference for pll2 on UMS512
Date: Tue, 16 Jan 2024 14:40:08 -0500
Message-ID: <20240116194225.250921-102-sashal@kernel.org>
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

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

[ Upstream commit 829e3e70fe72edc084fbfc4964669594ebe427ce ]

Fix below dtbs_check warning:

'clocks' is a dependency of 'clock-names'

Link: https://lore.kernel.org/r/20231221092824.1169453-2-chunyan.zhang@unisoc.com
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/sprd/ums512.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
index 024be594c47d..7984492ef651 100644
--- a/arch/arm64/boot/dts/sprd/ums512.dtsi
+++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
@@ -291,6 +291,7 @@ anlg_phy_gc_regs: syscon@323e0000 {
 			pll2: clock-controller@0 {
 				compatible = "sprd,ums512-gc-pll";
 				reg = <0x0 0x100>;
+				clocks = <&ext_26m>;
 				clock-names = "ext-26m";
 				#clock-cells = <1>;
 			};
-- 
2.43.0


