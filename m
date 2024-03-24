Return-Path: <linux-kernel+bounces-115648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A75B9889D00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6F52A21EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB8235080D;
	Mon, 25 Mar 2024 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBznk7pb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C44137755;
	Sun, 24 Mar 2024 23:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321520; cv=none; b=UhvFVhZ9qxDP/OLovxN7aJ8skCvJWP6BQQd05oN/sUyOZJrshPZYqKItwQb2yu1YubCLPV6S45YDsnAA0IrCqghFxDpihJvbbVzc1lVZrf1EBFUyarXcOBkQddzw81xL6zOPO58CNLSQNuBYQppCMTwvfw/M9vYwH7ULPQsUmDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321520; c=relaxed/simple;
	bh=3vBkS9Gb5bMU7t+X5bW6HHzb6ryNszPzQam/sDNgvrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=am0xhnETkgTTjFSscf8dFBsRoEMKZMVsC6T/qbK+0l9IuHzyRvou5qlaATchaLvzjcE2vh7OhjlpJn0Si28oLpicqffx/7WTbVszivSE+xj5v/mwOwqp9Vvx/75lZXCwrbsWd4Ek7PCmqu+qojHFO83+MIlYXfldJRalouA/poA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBznk7pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03013C43390;
	Sun, 24 Mar 2024 23:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321518;
	bh=3vBkS9Gb5bMU7t+X5bW6HHzb6ryNszPzQam/sDNgvrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qBznk7pbvFpiYHKXjhHRjsij9J7Y93gVD8Jd5XG8dL2KQiFPappTMSLaHp2uMMPml
	 2lI0w+G6odQpl0B3KnEHKR/XoI8LggE187vsslIEcBzdGveti5bZQ82p4690es4Xx8
	 HQ2GQ0TxSmsox7OkcVKA1iKLlsOpeH3TldX4O0sk1MJb/CQ58x6LQaW3bVFEokouBP
	 jLwrZ6rcERm72k8d4vif5kp0KPAvDkFbxUrTpAZaNgYLzc+u9pjnmxSrzHenR+JkXB
	 LXp1G2xPfaL5YyT3xniJfP2yGrc7/o7GC1GbdpRoM1L4SVl27YvZsYVjRN6hBZKDBa
	 n/RzWHQdpDMhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Devarsh Thakkar <devarsht@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 245/638] arm64: dts: ti: Add common1 register space for AM65x SoC
Date: Sun, 24 Mar 2024 18:54:42 -0400
Message-ID: <20240324230116.1348576-246-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Devarsh Thakkar <devarsht@ti.com>

[ Upstream commit 1a5010eade10b409d353b770d97b548b0fbdf5d7 ]

This adds common1 register space for AM65x SoC which is using TI's Keystone
display hardware and supporting it as described in
Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml

Fixes: fc539b90eda2 ("arm64: dts: ti: am654: Add DSS node")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Link: https://lore.kernel.org/r/20240216062426.4170528-3-devarsht@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index c98068b6c122a..57befcce93b97 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -1013,9 +1013,10 @@ dss: dss@4a00000 {
 		      <0x0 0x04a07000 0x0 0x1000>, /* ovr1 */
 		      <0x0 0x04a08000 0x0 0x1000>, /* ovr2 */
 		      <0x0 0x04a0a000 0x0 0x1000>, /* vp1 */
-		      <0x0 0x04a0b000 0x0 0x1000>; /* vp2 */
+		      <0x0 0x04a0b000 0x0 0x1000>, /* vp2 */
+		      <0x0 0x04a01000 0x0 0x1000>; /* common1 */
 		reg-names = "common", "vidl1", "vid",
-			"ovr1", "ovr2", "vp1", "vp2";
+			"ovr1", "ovr2", "vp1", "vp2", "common1";
 
 		ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
 
-- 
2.43.0


