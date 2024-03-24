Return-Path: <linux-kernel+bounces-113105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7439C88817E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE62882A5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AEF157E87;
	Sun, 24 Mar 2024 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddYfXdL8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF4B157E6B;
	Sun, 24 Mar 2024 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319913; cv=none; b=D9INBBa4jBskigtOWiPS3XgOHgAW98ghVX9cfB8e4JeV6CvPD6dUuqJszqmuFdsRP2T48PDtBkasP878aw2HR3evkfNJFKzhNTW3NOe2Fs4tjIOR/NnXvx+CFkaYVWe3feREW+H4cfEEls5n/GvAB4OjHJIAP0dyq3Z3Pq1Srd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319913; c=relaxed/simple;
	bh=UhipjQvNWfeeujAdzDwbZqGmfdqnpiMVNNRI02gZzEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpaiIA+Bt2HdIqFvMeQQwGwZtpo5F2cC4PjA+T3gmY58i2mOuBfoaJjklvViEGdGLDEXEvwe448EGiS/olSpuycrpbLW1SJzJd9vMilrOuaICH9eNE7GDKOBv+4fcKxnaRuCHTRVrjqEkKtCQ/H1tsBaIZX9hwmsAuoUwxlwIgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddYfXdL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F855C433F1;
	Sun, 24 Mar 2024 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319912;
	bh=UhipjQvNWfeeujAdzDwbZqGmfdqnpiMVNNRI02gZzEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddYfXdL8xI1czYBZX7zyHQKRwtyadc0vdMDvhvu6wff9UYM9rJ42PbD67UIC3G5eS
	 ZtvrJiZ6f/7J0A0xW7ve5pqQUnpcXgbSNqJyiRSX5m5AgG3+PqBEunRGWwQ/xMfR6p
	 JBKxH0fOTdy4ylBYItJ9os3SuXIcKm/rCGrVCQK1XxChtWPlYuAjd+vuuaeYD29ALU
	 c8Go9CGkWZE4mWcIaxRJpyB3aO5j5TGRi2ecfvLLRySUhJuILtBdcs3rJ+A8Moar1t
	 7HQonFnm3TA4gSXu47qFoFUaHzVMaiye4BuWgX2SoVuveFJNk1i2tCrcjde77dzeFw
	 VhDVLVQzm9fQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bhavya Kapoor <b-kapoor@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 218/715] arm64: dts: ti: k3-j7200-common-proc-board: Remove clock-frequency from mcu_uart0
Date: Sun, 24 Mar 2024 18:26:37 -0400
Message-ID: <20240324223455.1342824-219-sashal@kernel.org>
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


