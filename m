Return-Path: <linux-kernel+bounces-113709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531B888862B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81B21F24B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EE91E6F47;
	Sun, 24 Mar 2024 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc2FlOOJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4631DB429;
	Sun, 24 Mar 2024 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320694; cv=none; b=II5MIYMvASq5fnoA7OPU7X03bnxWjdEMCO6bQWAT5+zI+HP+jEq7VcqsM7ETTTooOmdn1GucH0vOQ4dwU9Y5frjuJk9jgiyIHbobU2dZVfWmCw3cXQOgfxneBmpXqq6XkEjvCa9J/3fuifgk/r6WOGYXa9JhdL9eMB3nZ2YZNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320694; c=relaxed/simple;
	bh=e4NVZsD3oUex1Q/qH+ecWwZcdZS8RG9y9dWVkrUXMGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scB9IZ68RIxHi4UdNmPxtmN+AoM7q0mU01rjKgZllNsG1mRJus2pfsqFbTepQDkoQxA+eUDWCmwuNhFbf1qI3Vyg764Ag4KrtZ0opPHRxALqtb4IQQ38MPPhWcixgJKJuAS4bmrrEw3oyh7Rv0bGUwtBM31PYsfoFYgD5xVzxHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc2FlOOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016F6C43399;
	Sun, 24 Mar 2024 22:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320693;
	bh=e4NVZsD3oUex1Q/qH+ecWwZcdZS8RG9y9dWVkrUXMGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tc2FlOOJPm6lLiBkR8VNPzXt+sn5jl0kuERLzwJEaDPiXvw3cZIDkKGRTbQLNsA7w
	 xg++sUyfhXxBCFL6oFdP11moEE7ONwSxBfuh4SHKo9eg3RQ43IXFOW6Tx8JFzJp+25
	 GCaxVmIUhNxQeJfIuxpGYxrX6+2IJmbvIVpY5BpatZxk5Asvy7TKbbipX7y8C8CrEz
	 g7AGFtVLJsua5ZinFBdv6v+2u53j6Eh5wBijLK9p1TD0GTl6NmbGgwn/By/vs1gwmf
	 7D3mPpshlXxEI3qo6U/5B1u/0RfYCWv5FV8bQsMR9ROX7tN5/ZcbKE7f6Czjm/n/U9
	 Idbd+mbSjj+Kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roger Quadros <rogerq@kernel.org>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 256/713] arm64: dts: ti: am65x: Fix dtbs_install for Rocktech OLDI overlay
Date: Sun, 24 Mar 2024 18:39:42 -0400
Message-ID: <20240324224720.1345309-257-sashal@kernel.org>
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

From: Roger Quadros <rogerq@kernel.org>

[ Upstream commit 8ada14cafc5e185c668198617cd1ab4f1d8d325a ]

Add the overlay dtbo file to a Makefile target so it can be
picked by the dtbs_install command.

Fixes: b8690ed3d1d1 ("arm64: dts: ti: am65x: Add Rocktech OLDI panel DT overlay")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Link: https://lore.kernel.org/r/20240208-for-v6-9-am65-overlays-2-0-v2-1-70bae3e91597@kernel.org
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 77a347f9f47d5..c1513f0fa47fd 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-idk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board-rocktech-rk101-panel.dtbo
 
 # Boards with J7200 SoC
 k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo
-- 
2.43.0


