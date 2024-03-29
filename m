Return-Path: <linux-kernel+bounces-124496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97ED8918E9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53032815FE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81FE13E6B1;
	Fri, 29 Mar 2024 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smdlgXEg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0037130E3B;
	Fri, 29 Mar 2024 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715240; cv=none; b=hLZFmlAeibmtI67KOwdXiV/wiqA69wdut4cTC/R0/NO7o+Db2tNPkEzOVqwLPS3Uh3twq89x07d0cGKfL2/wCZApFgbsYkP6boN8sN8gOv9vVAP8GBP5opoiNF2FOdogwIXu9HBERuHhT3dEvne5Rj2gQb3rsluLMX2keDfqUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715240; c=relaxed/simple;
	bh=2gqVGTZ904sc2aHtPgRVQkP+4lTybSnIMocv/VUbipE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4YhkMsr6UhgzaOcr2iQzjtcuoXx8mT9xK8UpR2WCy4Svi3Dlw3P4XtRFIrXEfjguICaNn/BivkiGbhPHJyfoJpoVbSHT32mK48sB25zKy1U3yKlNU2HK7mhLKenBrSczJJiNicmbvKg4z7oQIt7atiOy4jBrWtCCWjI1Gokx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smdlgXEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1B4C43330;
	Fri, 29 Mar 2024 12:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715239;
	bh=2gqVGTZ904sc2aHtPgRVQkP+4lTybSnIMocv/VUbipE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smdlgXEgaYid0+tj66p2NVGx0M5Iq/kXyFtpL/WhOuc6bHPKmudL47pPD6sw/RtQd
	 iZePT1Ky+6utvAZfuzAjC1LTtBc/amoBpSbYTtXah80lIsxI4W2363m/vjWqXJjpUD
	 JTdaPWIuvQpPv9OW1FLVPuUTr82/3EZza7++qGo8E/zy0VrpBFW/nagnW5dbJfarxb
	 r2HQmkl9tnMwFntrSM0KxGZDZ+gSiun3jPD8gMP/yzVKXAG+4VDTuSMAng6JXLmnvb
	 /YAp4YT+i1fGvfeNHaWGktoUz8iP2lJEt/YRUwv51q/We0NXU9e/voReDHLVvBmJFJ
	 NMbYN+TlAqo8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aradhya Bhatia <a-bhatia1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>,
	nm@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 15/68] arm64: dts: ti: Makefile: Add HDMI audio check for AM62A7-SK
Date: Fri, 29 Mar 2024 08:25:11 -0400
Message-ID: <20240329122652.3082296-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Aradhya Bhatia <a-bhatia1@ti.com>

[ Upstream commit cff6dd01a68fe9a8aaab724ef4e21f37eff609e9 ]

HDMI audio can be enabled over AM62A-SK using the same DT overlay that
is used for AM625 / AM62-LP SK-EVMs.

Add the sk.dtb + hdmi-audio.dtbo combination for AM62A7-SK as well, to
check for overlay applicability during DTBS compile tests.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Link: https://lore.kernel.org/r/20240201125452.1920623-4-a-bhatia1@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 52c1dc9103087..a0304fcd6b5ea 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -101,6 +101,7 @@ k3-am62a7-sk-csi2-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-ov5640.dtbo
 k3-am62a7-sk-csi2-tevi-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
+k3-am62a7-sk-hdmi-audio-dtbs := k3-am62a7-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
@@ -118,6 +119,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am62-lp-sk-hdmi-audio.dtb \
 	k3-am62a7-sk-csi2-imx219.dtb \
 	k3-am62a7-sk-csi2-ov5640.dtb \
+	k3-am62a7-sk-hdmi-audio.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
 	k3-j721e-evm-pcie0-ep.dtb \
-- 
2.43.0


