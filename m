Return-Path: <linux-kernel+bounces-113114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 810B2888192
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20BF2B23198
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999D115A4A3;
	Sun, 24 Mar 2024 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0CbkE7t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E515A487;
	Sun, 24 Mar 2024 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319921; cv=none; b=pskPb0fyjWhdzqfXBGZ0N5VNHwvUyVMXlju/kpaQ/MwhPVmWHKe0IBW5hEeV+e7RVwLjlutCLBjCbdUH/yETJVwHmIukcXDefdn8GHugJ+CqYKnWNZGg/WHeV9nho9Lcrss9bT4aF3nxrYTUKGMN8SiinYrWx6jov8VDzv76lsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319921; c=relaxed/simple;
	bh=SSauXZUCi0ZbV1EEAVHKrppW6w6f8R/euJkogkXNDF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIQeVqvAAZQPnfvh8a7qy+7cKe3GtVCpJi0jl0HLz8NPlIvSwM8B8Ebn41F4nafcegoPQYV6c+s/tXHDlyrX/QMegTGQSEctgjn0tz58YommnXJYJXcIOcPT1gJVtoqXOUAnDuObuQOSG4OksXhYGRL+dourdbZXQ+xOKoWWcSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0CbkE7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D697C433F1;
	Sun, 24 Mar 2024 22:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319921;
	bh=SSauXZUCi0ZbV1EEAVHKrppW6w6f8R/euJkogkXNDF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0CbkE7tGKlC6p5NiUdNMHa2v6v/OgH4MtQPzcOVc81dTg5O9hHDUDoP+GDlgboua
	 XRwSd0vbgO7Uu6hKQdJYzQsMwpcucW8lBNOMJUwYyX5k2Hno359irNyqwbbdcAPXGY
	 9BD5a5deAC7ygxjc8YrlD34BroLsxUzS8DSEcLBSFwAdjvh5yM0QOs49fXWiSE0bMx
	 lHu0vq73bE3IGZcgUNBzPciFE444F/MXHJ+xnpbI5ZKNcRqv07ZnhJwkIQ/KBvnW2Z
	 nEYSLXTyKm41N9p0GICSa0lZ5HJDepPUDl3xliM5Kq+G0oB7Jik1vI22z33tRl6zrH
	 Qb4xBXT5T207w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Davis <afd@ti.com>,
	Peter Rosin <peda@axentia.se>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 227/715] arm64: dts: ti: k3-j721e: Fix mux-reg-masks in hbmc_mux
Date: Sun, 24 Mar 2024 18:26:46 -0400
Message-ID: <20240324223455.1342824-228-sashal@kernel.org>
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

From: Andrew Davis <afd@ti.com>

[ Upstream commit 3d585389d454e147187684e492a0eb8f56adf311 ]

Change offset in mux-reg-masks property for hbmc_mux node
since reg-mux property is used in compatible.

While here, update the reg region to include 4 bytes as this
is a 32bit register.

Fixes: 2765149273f4 ("mux: mmio: use reg property when parent device is not a syscon")
Suggested-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20240215141957.13775-1-afd@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index a74912d9e4daf..c463e23ced04e 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -353,9 +353,9 @@ fss: bus@47000000 {
 
 		hbmc_mux: mux-controller@47000004 {
 			compatible = "reg-mux";
-			reg = <0x00 0x47000004 0x00 0x2>;
+			reg = <0x00 0x47000004 0x00 0x4>;
 			#mux-control-cells = <1>;
-			mux-reg-masks = <0x4 0x2>; /* HBMC select */
+			mux-reg-masks = <0x0 0x2>; /* HBMC select */
 		};
 
 		hbmc: hyperbus@47034000 {
-- 
2.43.0


