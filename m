Return-Path: <linux-kernel+bounces-113110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF643888188
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FD46B245F1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD49158D92;
	Sun, 24 Mar 2024 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ7dCvSY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7C7158D7C;
	Sun, 24 Mar 2024 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319917; cv=none; b=VqZciZcLYDU9DUDdEtXaAmUQnlRtGhtBWCyJqScmOHHcD7XE1NcNqyHZD3rnNlqDs2WCsJDIpA4Nqd5rGOJkXQoN2f6mQLggA1sKtoTEQPBLQO5F34+kgt9ssqi4Sh5XqOGQvLmaaJ4MTB3R6SKmf0jtc6WepfLGVlK4f1IGQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319917; c=relaxed/simple;
	bh=Fsph2RHRgiCvLe/wmjnW94kS4ttpaddfA6Xw96Bl6SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5SFYfK34Xpn3t53JZ0m5GqVYL8uh9dE4BXKtNg+z7nkU/+h2LUxTSttOI3PQDKtu6M/7YhfYGQ8TPLraQBE59XC78iJSfG68TbbuSFEVVCKHV5ln4k8q+FOvqgQgdAXLZxbpVjIXmRBN/1ApLyR/9pJEmHivtGT/TIOiJ8IyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ7dCvSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5155C433C7;
	Sun, 24 Mar 2024 22:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319917;
	bh=Fsph2RHRgiCvLe/wmjnW94kS4ttpaddfA6Xw96Bl6SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJ7dCvSYwY1aMVel2RyswRSM+3/sOJCRB12CJ9j/lSHNpvYLXYXEYHC1pUEL8cSbM
	 9Ti8/qBnoAx+lncK2yRZhR7KdgUmgbJnmuXZVRTGWtiC2P6HkT3OoXj5Ksh7XejN40
	 XADKJ2BNobDLqifCn1LFUj6iE8+5McRAafk00wFDunxBo1fXEwybRw+YDfHG1ydA4I
	 KlaG1SESpksXWjT6OQ0CQWdOcpoCFvHVu+RZKkBeyiEfMGrBP3S8BFxwMAJCJYU4Ug
	 U6+h9+H2p/mGHNNCvhuKFsnEBQqmZBKo+Qc19vm42YK4cu7VvmqZqrbovlkI1ONmf0
	 k8hnLMQaJxN1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Devarsh Thakkar <devarsht@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 223/715] arm64: dts: ti: Add common1 register space for AM65x SoC
Date: Sun, 24 Mar 2024 18:26:42 -0400
Message-ID: <20240324223455.1342824-224-sashal@kernel.org>
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
index fcea544656360..5b2d4365b9111 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -1019,9 +1019,10 @@ dss: dss@4a00000 {
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


