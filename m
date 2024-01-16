Return-Path: <linux-kernel+bounces-28111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5EF82FA50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC3C1F27334
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514F2153BF7;
	Tue, 16 Jan 2024 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBeyzJc4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91936153BE2;
	Tue, 16 Jan 2024 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435163; cv=none; b=WkB6WjYz95dtw7pQ2YkumxK1H+Q1RtJVVgByllbrZOy8saqjXMsIOfb7H8FaIFUuHVvjoulg0JfM1z4/ycazejOkpZQQ0tuDmYHRsHcWJByc5cIGIpkDHOEYVEuDqRWsJq8FomxgfIou7tZyEabaR+Vi7WQlMs0iuYkXG0tI7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435163; c=relaxed/simple;
	bh=9E9z2CbkY9yg+TY3BVRNcvlKsSvz9/h6QYlgnq/A7nI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Gm2/U3/LIb/v7rWKFV8lNlOQ4TT70Uwi8HpCnawuVfCOTg6QCq/tS1zA19MmRgQ01OpHk4q9Q+T7HdXvgVHpo9q75/6bksCEYjhooGExIczEI25G+00GHOa2jV+5E6Jf2YziNkn8C0pJt23y+wIRqYpkJpydxe2N0jwCLra4BpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBeyzJc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B72BC43390;
	Tue, 16 Jan 2024 19:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435163;
	bh=9E9z2CbkY9yg+TY3BVRNcvlKsSvz9/h6QYlgnq/A7nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBeyzJc4f3Cj9FgBiwWACgeEA0+m3tltMh60hEHbAsPyO1tMS/4Q6VikeYm8Xeeo1
	 huS9wHX2fjG4XDAqQPtNO+I5naIAoQPKcQj/t736Uz8GMtPDqIkEckVc4uG/wHIfPU
	 HMupD7YBx1xag+PAklBXb6IJvWrp22zQtKBTOOrjtGXgtbKkJUydiJYCv4dUiMSXNX
	 vc3b6JwrHl8A5n37n4R9HqDpQ+sT8P/fLr1vsEGl5MAgErB6IS80AE24TTYkrI9amF
	 KFHxouDWiVLw4bg3cdNzjPpP9RJwWU3wnz+Bnn7psTzOnoMVqfEpZSfkWWzlunIVRU
	 s5e4iDhS0WjCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 24/47] ARM: dts: imx27: Fix sram node
Date: Tue, 16 Jan 2024 14:57:27 -0500
Message-ID: <20240116195834.257313-24-sashal@kernel.org>
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

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 2fb7b2a2f06bb3f8321cf26c33e4e820c5b238b6 ]

Per sram.yaml, address-cells, size-cells and ranges are mandatory.

Pass them to fix the following dt-schema warnings:

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx27.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index fd525c3b16fa..247617d6d41e 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -588,6 +588,9 @@ weim: weim@d8002000 {
 		iram: sram@ffff4c00 {
 			compatible = "mmio-sram";
 			reg = <0xffff4c00 0xb400>;
+			ranges = <0 0xffff4c00 0xb400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
-- 
2.43.0


