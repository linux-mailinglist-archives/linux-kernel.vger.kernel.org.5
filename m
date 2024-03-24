Return-Path: <linux-kernel+bounces-113035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7F28880F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7E0280E5F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F7213BAE3;
	Sun, 24 Mar 2024 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw+IKGZV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719705102B;
	Sun, 24 Mar 2024 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319845; cv=none; b=Y1sZMc6ljy/5VJmhtjTix55QTVx08eJgD2hjG2vRquRDDcKoV71libvJcD+H6tF2b8JdNsulAbqMF7RJUG6iq3uvjEGe0y7J1UjRGvWEg7Kn7ZxJXtUzRJnTP0tFTk18Yugb0ycYEo550Ad58GRzSrcB0FHjwHAjFlOnWe4qFck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319845; c=relaxed/simple;
	bh=i8WxCooOi6vx5cFxryVnmLSk4xFvJqunsS2uEQTcELQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmdknFOHCjC8L1k2bpUe58JXLEbLI+PB91flGvQFkv0PIvtGl6GSrzgxfHQY20GamEwl8hdU8xkN8wYlv8nsZHch/0BorX5WvH4U/+tHIOLI/AhY2l1v1T0IbpPa2chUKsa0yW8pPGUuzzDKP3qQKxxI5gOywSVIRMK45bs6ZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw+IKGZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58893C433B2;
	Sun, 24 Mar 2024 22:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319845;
	bh=i8WxCooOi6vx5cFxryVnmLSk4xFvJqunsS2uEQTcELQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jw+IKGZVy3S1eXLg8MGiwHfzKbrkx2lOZiF3IUGyUYfaz2g9psyWynrtUpVjKS//n
	 UrjcSi60uK2qDe0Zy7wCSccK2tGmZVof6i4HzAkPqRY0oGfQX6pf8VQ1kb9Cqdh5kZ
	 JxLkmOnmjHdKn3Cr/ovAjx/06bxkQMlFKagaDDNyqCtH1gIRLAPyN8PbRVlNTevkm9
	 0OFiFGuvEZdMJxNNxlhdqT7AYuYuq8gU0KcOJBrBa7MjhXUiwBal6mW9jpTbcbOJCX
	 Kd4vedZZbjdywz7lEKhIfbU8UeFROlxIeOGeXYRRWLwo2zkUocaqymJXQ9Ihx+UZaB
	 92Rff9t/h6vRA==
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
Subject: [PATCH 6.8 148/715] arm64: dts: ti: k3-am69-sk: remove assigned-clock-parents for unused VP
Date: Sun, 24 Mar 2024 18:25:27 -0400
Message-ID: <20240324223455.1342824-149-sashal@kernel.org>
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
index 8da5915798688..370980eb59b02 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -918,13 +918,9 @@ &dss {
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


