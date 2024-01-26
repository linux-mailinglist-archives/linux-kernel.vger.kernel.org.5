Return-Path: <linux-kernel+bounces-40111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 516F183DA6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846511C21085
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7AB1B7F7;
	Fri, 26 Jan 2024 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4yc541M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EBE1B7E8;
	Fri, 26 Jan 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706274001; cv=none; b=N3Yoq1vT7LY71gyhaMo8gCjmZp65Gbfgk/OYy3fZRPQto4eo6weoktp8w0Ae4dJr6UtAViZNAkvOsiluu4K5QbllOM2mkWY5B0QqOeehSOEFuQOT2D2bQVmCULIuRODaucRX0qph1XC1F3DJuseqtn8AAfp3iHqEnPNma5+awYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706274001; c=relaxed/simple;
	bh=eh/r7bLiG2ewx2BxWDgtR/LX/zo08ToBq3IPFhfP/kI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tUd9ALzwPKXgV0UFgLGmzAdzeqR/zZrwpfyHZ2A2k8fv6kwBzPPnU1eSUwLnhJJsVz4jijlCvQthGz+dCsrhyuapwsWeOexeKsJ1CWXBDRIEV5zLHdup2pQ2bij7wRfJ+96tBhLBE7HNf89BZIK1nXbdWa/meoVLxZA0c+0brrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4yc541M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4179AC433F1;
	Fri, 26 Jan 2024 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706274001;
	bh=eh/r7bLiG2ewx2BxWDgtR/LX/zo08ToBq3IPFhfP/kI=;
	h=From:To:Cc:Subject:Date:From;
	b=S4yc541MawbI5TGCpoh8k6vWLuBkddYAYxUA58A+xazhwK7/EN3TRUsWOiQcDyExN
	 tJJbZWb/X8LSL/DZAz1kLGSU7qUvgNxHHMAzOGhzwxyx2lZWNxvMaXoQNTIOoW+8bV
	 Ov9nxsfZ0dppG09hWQkkBRreTP/Worbh0V6UwAgqNroDMMjtDuUkuNeC9gerfIGlji
	 8ok6ln1ZudgHq90uyaw39JtdG3m7ley2ULwcvpPL9LckUJbGxxatMvxn0mkJ11IjAk
	 0HNU7PUsGxxtTV+F+F3x760wY8dthVurcc9SOTL2QvT5wjjdRnuFdmA3D7rFkhj6FX
	 WZJuIygur4Vpg==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com
Cc: afd@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/2] arm64: dts: ti: am62: Add USB support for k3-am62p
Date: Fri, 26 Jan 2024 14:59:49 +0200
Message-Id: <20240126125951.18585-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series first adds device nodes for USB0_PHY_CTRL and USB1_PHY_CTRL
in the wkup_conf node and fixus up the USB nodes to use the newly
added nodes.

Then it adds USB support for AM62P5-SK board.

cheers,
-roger

Roger Quadros (1):
  arm64: dts: ti: k3-am62/a/p: use sub-node for USB_PHY_CTRL registers

Vignesh Raghavendra (1):
  arm64: dts: ti: k3-am62p: add the USB sub-system

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi    |  4 +-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi  | 10 +++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   |  4 +-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 10 +++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 46 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 10 +++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts     | 67 +++++++++++++++++++++
 7 files changed, 147 insertions(+), 4 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.34.1


