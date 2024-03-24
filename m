Return-Path: <linux-kernel+bounces-113726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EEF888E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB9D1F30B13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30CD1DCC8E;
	Sun, 24 Mar 2024 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+JugOsH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DCA1DC7EC;
	Sun, 24 Mar 2024 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320709; cv=none; b=EMJpJgctmgiOrbU0e4e3J0Lq297J7Hf3sDN1rPZNTlisjAEhJVnEP2OcxLf4rCfTIe3plgjON5Pu+2IynOh6fL8Dr68Go4OLjKNxanpMoYnnsYjcWHJd4y4kBdysAf084Kp7LamaOfXBiNaf/cytQ2Yh7xKmSR8Suzkl8AHm8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320709; c=relaxed/simple;
	bh=UhipjQvNWfeeujAdzDwbZqGmfdqnpiMVNNRI02gZzEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3eLt9G1aVj+oZXM0zbnFqspDX4yLrAh7CGQCSgTyWkPMUqoOg9b8ttiZBEjGsckXurxKuew6vXCB9H3Cof4o18D2yBaJO35tTyTBKD4IPEgDbGatwiB4mPZtQaOVaSB8+Z+4b+W9bsSYpy8RinkfCLeLgeFzQcwxWgleFs6LOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+JugOsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3556CC43394;
	Sun, 24 Mar 2024 22:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320707;
	bh=UhipjQvNWfeeujAdzDwbZqGmfdqnpiMVNNRI02gZzEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+JugOsHZSBBm0ul4FsuBPdHyim+QHmGzcWGmFhS83j5yt+ubxUiw5OmHKpsLVYaH
	 DaG+2+yEEocULoANM7+KgsZkQVz+8CtsVO1FWDMh5sRmZhV/rnG5IakqqjROMQKOzL
	 fpS3lcr10XAPqzu2n+Pht2BZ18yO3FXbRSu74Fo5j4WJthDZA1eMZLGKsxH0DGok7+
	 kd5cqGThDewW2JiD8QRYhv6JiEglAMTXntCbGLwEq8y72CFWik/sUPkPPi3mBx6/Fp
	 Iu+yrCKKAlXACpcyFr5A1d3q7X2i5GTzOZOZK0XLytfGqEz5U7h2rs4CXrBOlOeIKf
	 3yyyktqspoFvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bhavya Kapoor <b-kapoor@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 270/713] arm64: dts: ti: k3-j7200-common-proc-board: Remove clock-frequency from mcu_uart0
Date: Sun, 24 Mar 2024 18:39:56 -0400
Message-ID: <20240324224720.1345309-271-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Bhavya Kapoor <b-kapoor@ti.com>

[ Upstream commit 0fa8b0e2083d333e4854b9767fb893f924e70ae5 ]

Clock-frequency property is already present in mcu_uart0 node of the
k3-j7200-mcu-wakeup.dtsi file. Thus, remove redundant clock-frequency
property from mcu_uart0 node.

Fixes: 3709ea7f960e ("arm64: dts: ti: k3-j7200-common-proc-board: Add uart pinmux")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Link: https://lore.kernel.org/r/20240214105846.1096733-3-b-kapoor@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 53594c5fb8e8f..7a0c599f2b1c3 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -211,7 +211,6 @@ &mcu_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
-	clock-frequency = <96000000>;
 };
 
 &main_uart0 {
-- 
2.43.0


