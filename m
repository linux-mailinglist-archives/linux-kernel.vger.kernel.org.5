Return-Path: <linux-kernel+bounces-75127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1943685E39F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91BF5B23164
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBCD83CB7;
	Wed, 21 Feb 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxTXyMRz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6B8172A;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533681; cv=none; b=J9V9AA5dkADcDGewghWI05DxVdjvIkSCztVucoZLODFxDEaoXa0DaK/3SJry4eYV5C3sZ0fG0l6cyaazMAmkQQsHPcdbSbg3PW1msZv00KHGFsMLNK1BaWgHJE24j3HGVs4G5vcHLFfhBIRtk7J7UktDNA1Tub+ubaRCgFKQVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533681; c=relaxed/simple;
	bh=iXlnN86FBtHze7pc7TT1EzncHtGJddooON9T6JhruhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7M6T/n0tzxscOfuIBqRtB0fZ5oCADZ5mFNPHcwdVhdWdoQNdABWzUARfvD3gNdCMWVfTzsiDW51XFv+JUSZg4tsCllhanBwQME1dMzvYProMOZNl5/z7c42HxNYOK4LtGgwou1n1336SWvNcIZEjnDi93XRgzwVb52dHPtT7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxTXyMRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C120C43330;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708533681;
	bh=iXlnN86FBtHze7pc7TT1EzncHtGJddooON9T6JhruhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pxTXyMRzHODhCs8m3WPDg1yVwqJx9/JRGrBWLV1vleIAqUZZ7vPvT3Rcuj+6WSZHJ
	 Nk5ieMU/YYpxeEF5Uwh9KqZDXfZZIrpAerbzkxjJNEvThsGhjyVGYX7DlWoBuWCyvJ
	 kcsquEhHlEx2MYAmSEmYck9WLdYrfuF6n/VnK3tNrA4k9nPkgKXwdO8OkIYi1Q4HCt
	 vJEHxvCzGBk6vvFk8B6JIImNVsAgWAr6fahIYOhG24JTaIG2PAbdS6EphTeu5zZSji
	 ig5l4cX538hFQYkOGaULM/YDl803RDtJ0p7Q12bZYuQ332Kfr7AHLTMOY2XYq+n4mu
	 c1faigvXrvYzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453EEC54790;
	Wed, 21 Feb 2024 16:41:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 22 Feb 2024 00:41:07 +0800
Subject: [PATCH v3 4/8] arm64: dts: hisilicon: fix include path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-clk-mv200-v3-4-f30795b50318@outlook.com>
References: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
In-Reply-To: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708533664; l=950;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=zO+w8jqaXi8Ww2B8vF6SfS+3nCbKAcDggVh4EP/9jpU=;
 b=/zpgyb2aPCEvtAZM8P8wB2YLiMdL3+rPSs9RR8eprCxJZflDp5FlJCGz6DZwBdVesZ59D0bfU
 eLLy8gUqeBYDznG+OfKhtU8+1mxf88705t7+iBjPjQzmdz1c5XsFRgd
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The generic histb-clock.h header is now deprecated. Fix it by including
individual binding header files directly instead.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index ed1b5a7a6067..1e6a8a8829b1 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -5,7 +5,8 @@
  * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
  */
 
-#include <dt-bindings/clock/histb-clock.h>
+#include <dt-bindings/clock/hisilicon,hi3798cv200-crg.h>
+#include <dt-bindings/clock/hisilicon,hi3798cv200-sysctrl.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy.h>

-- 
2.43.0


