Return-Path: <linux-kernel+bounces-113683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22674888E43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70E91F2F26B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDBA1E1683;
	Sun, 24 Mar 2024 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ8Ix4Ze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745BF1D8BD9;
	Sun, 24 Mar 2024 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320647; cv=none; b=GIcio6Fh0zFM+9669nuMoIIJkVaN3vne9U9sxBB6q7FDTaCjA344YmkIik+Er3lBTLwRM+fNnM1i0LmAtsd+S+F9Wt2YA59iQ6vc6QawSsDBxb0myZW3Tn1Nc0S/mn2XrK0IyTgWh9/rdu771Rw6UEa2fFW85INcqHUjMNnLb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320647; c=relaxed/simple;
	bh=PRDR/PMenEpU2rk6usu6sYB/5zgkZIR5qd7nhUTXkT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRpMrQoIJ6X1a1hCpE+L8DerGeM9fHzf36Eb4IETskUeNNOFdTAUlvPSDL5WLDdQz2zi9wST8kGQYSwdVTGgS1aF1xumsla5jkdBLOoktS81Vf9PMS+OmyOUtfT3fUIDeghOsiTYPZ7b3cost/10iEmeeTJEoqG189yy9KhN2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ8Ix4Ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05733C433F1;
	Sun, 24 Mar 2024 22:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320646;
	bh=PRDR/PMenEpU2rk6usu6sYB/5zgkZIR5qd7nhUTXkT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZ8Ix4ZejDJ7xsE5Ja9Mjpx/vJwPvYZ2cibj8UV1AywsOjLSzBAM5F47RJwGG/biq
	 NLv72ryyA8kwtBTOUmnH+RUpfJ5ryE/JU3MUzwxCxVWcVOrXgjonyzpeVgHHh10IGB
	 RtI97+9EhqMvJqcKnFUu0KpgcvV9PidDIvEsAtg0I5NobQkLtZqkdY2w8wBPc4IMpg
	 eINGrB1sstMGHNJ9xxsrGKFPYxBB8RoCocAC60FkpzovqEweuuuqU/UX3Tsbla3F8a
	 cTWSgwHiEND6Fv/LqHSduSuSPvnIi0az+5ucBR/lZ6ZZHrnqP2wsxn6MBWK1thNmMp
	 nNKR4/fbYr2tA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jayesh Choudhary <j-choudhary@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Enric Balletbo i Serra <eballetbo@redhat.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 207/713] arm64: dts: ti: k3-am69-sk: remove assigned-clock-parents for unused VP
Date: Sun, 24 Mar 2024 18:38:53 -0400
Message-ID: <20240324224720.1345309-208-sashal@kernel.org>
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

From: Jayesh Choudhary <j-choudhary@ti.com>

[ Upstream commit cfdb4f7ffdb855c1a3d274dc7757e780dcbf2d55 ]

VP2 and VP3 are unused video ports and VP3 share the same parent
clock as VP1 causing issue with pixel clock setting for HDMI (VP1).
The current DM firmware does not support changing parent clock if it
is shared by another component. It returns 0 for the determine_rate
query before causing set_rate to set the clock at default maximum of
1.8GHz which is a lot more than the maximum frequency videoports can
support (600MHz) causing SYNC LOST issues.
So remove the parent clocks for unused VPs to avoid conflict.

Fixes: 6f8605fd7d11 ("arm64: dts: ti: k3-am69-sk: Add DP and HDMI support")
Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Tested-by: Enric Balletbo i Serra <eballetbo@redhat.com>
Link: https://lore.kernel.org/r/20240201142308.4954-1-j-choudhary@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 9868c7049bfb9..fafa09d6dcc64 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -824,13 +824,9 @@ &dss {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dss_vout0_pins_default>;
 	assigned-clocks = <&k3_clks 218 2>,
-			  <&k3_clks 218 5>,
-			  <&k3_clks 218 14>,
-			  <&k3_clks 218 18>;
+			  <&k3_clks 218 5>;
 	assigned-clock-parents = <&k3_clks 218 3>,
-				 <&k3_clks 218 7>,
-				 <&k3_clks 218 16>,
-				 <&k3_clks 218 22>;
+				 <&k3_clks 218 7>;
 };
 
 &serdes_wiz4 {
-- 
2.43.0


