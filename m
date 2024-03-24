Return-Path: <linux-kernel+bounces-113182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587C288821C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2651C2249D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87B3177A89;
	Sun, 24 Mar 2024 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBkhexMq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F05A7B9;
	Sun, 24 Mar 2024 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319984; cv=none; b=can3dyQJFXZC24n/B59sko9r8jO/nvSoB6/EwORmMwarIlmiNnKcE5EyceGdFrL7UM60ZP6PuSueYcejl6bk1/gj+QW9VKKwFeV8HpEFr2ZJiPs/U7XVl08fCpDemLDNvOZuEkMo02hED8rjKHx4wIXtHTd/3R1jX69b1drWrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319984; c=relaxed/simple;
	bh=GLZteGuO3mk6l7Mu/yJVfor6rpFiIEd8o6TuZwT2rCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFLd9Btgg++ZSiB1y18zC/uDrzu8svqFY7K803gR8R7Q0o0f+Dqa2qCfZd18HWVY/bmmh9iVh/4SDIy8Y4gehTdbvq6S1pMWq1+cEaMN2QDuH4qWkRbVFLNVgzIiR64t57hrv8LsMzqte4kom2j4D0e2S5Dn12uN6gy9VaArsZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBkhexMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF708C43394;
	Sun, 24 Mar 2024 22:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319984;
	bh=GLZteGuO3mk6l7Mu/yJVfor6rpFiIEd8o6TuZwT2rCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GBkhexMq8anokMCTaGjfA7z7nZL9VyUzV3gw1CcHqu+wmWVj8LLI3xZ7JRkccfRT/
	 yrEjmrNm2/g437G/VLR4q3A9uhPuk3LOKjDIJPWXQsE05ELaJMUGbEnDQFn1vSuvoT
	 bgsjoWvvQcaKi+Igtx4NKH9Z4soOYCd6UCAegWvx+FPyxLcgecAiO+IhYTMOYRQwJo
	 9qafojVMDx4ax0eIoQtgZ8qeKu6bHLFo9VLkaAVACmkCGDRFxT2R/hme+9JLJ6Znm7
	 r3GsoHmpm5G6yy4Wnkpik6Erqy4C8IffOhK5V1l7qzS98I25JZaFTWmmdM4bDGTsI2
	 prwD5Ag+3cLLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 291/715] riscv: dts: starfive: jh7100: fix root clock names
Date: Sun, 24 Mar 2024 18:27:50 -0400
Message-ID: <20240324223455.1342824-292-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 7921e231f85a349d5927b26c812c86e03f4cd37b ]

JH7100 clock controller driver depends on certain root clock names.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdWw0dteXO2jw4cwGvzKcL6vmnb96C=qgPgUqNDMtF6X0Q@mail.gmail.com/
Fixes: f03606470886 ("riscv: dts: starfive: replace underscores in node names")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index 8bcf36d07f3f7..5d499d8aa8044 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -116,6 +116,7 @@ cpu-crit {
 	osc_sys: osc-sys {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
+		clock-output-names = "osc_sys";
 		/* This value must be overridden by the board */
 		clock-frequency = <0>;
 	};
@@ -123,6 +124,7 @@ osc_sys: osc-sys {
 	osc_aud: osc-aud {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
+		clock-output-names = "osc_aud";
 		/* This value must be overridden by the board */
 		clock-frequency = <0>;
 	};
@@ -130,6 +132,7 @@ osc_aud: osc-aud {
 	gmac_rmii_ref: gmac-rmii-ref {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
+		clock-output-names = "gmac_rmii_ref";
 		/* Should be overridden by the board when needed */
 		clock-frequency = <0>;
 	};
@@ -137,6 +140,7 @@ gmac_rmii_ref: gmac-rmii-ref {
 	gmac_gr_mii_rxclk: gmac-gr-mii-rxclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
+		clock-output-names = "gmac_gr_mii_rxclk";
 		/* Should be overridden by the board when needed */
 		clock-frequency = <0>;
 	};
-- 
2.43.0


