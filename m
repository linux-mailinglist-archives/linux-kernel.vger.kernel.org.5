Return-Path: <linux-kernel+bounces-115398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF81B8893CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CE8291BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5D21D6861;
	Mon, 25 Mar 2024 02:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0hgrQBi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB41DC80A;
	Sun, 24 Mar 2024 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320713; cv=none; b=JEecrSD45ta59mS7Vb0zT3QmXYON2C+vFpP0JBMRGtGjztTllEjfuR+oxBgP/XsbOZSp082alGySnLKzzNhpsPdwy7ubMnqXXJMBsHG9ro+hbUzq74io9nMadqOYuhwia6Ntbx9rOwhSr6lsvGq/IBtuCqtkCwMixbuLgyk4cY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320713; c=relaxed/simple;
	bh=xZCKW/24TgRh7+E7gd9pRTBVZMgGEG5kgKUeClJxXso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDGCZDh3k2b+2gXNHPTp9RoJLaXncFzUy6h7WRPZc02twMmPJ6C6obpIJt2dkXfyh69banrP3Tvnr14PEaOx/GQmlbRN4P3Fl9pijWmWBnAExmVvOAnqyF4Dxbv8k+3RkIYKXSq7SHFIBlrLiDhDCwuFXw1/Cf/DcrzzyvwYSZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0hgrQBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C048BC43390;
	Sun, 24 Mar 2024 22:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320713;
	bh=xZCKW/24TgRh7+E7gd9pRTBVZMgGEG5kgKUeClJxXso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0hgrQBid+jtvjw5b2DWQwPxOoIm9lzptNIv29HyG/vvJC7gKtg2496X0GUeabKe4
	 IvVnPDeSb1rUx+BI3yDdbWOP05CYY/8akcyzbrE/ALBIpDIUuNxv4HuLyYP8tiukTE
	 q0lBa0Zm8AcOdIL2iYF2EsKswii7ShgOYZ9uJYa4N5buVY2LY84acRrgexeiJJmj4H
	 VVOfmTlszyK5IugKGTLRbG9ihpTNE0izEs9h2v0dYspRa7l1iQT2Pk8Uo3foZwkZs1
	 P+6gt+mN7sLr8Vm3CfgEYz5bwMfAW51yEr4QNHy28Z1OoHreM+kVSjBwujtoLJOEP1
	 cxTGzmrduW5Ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Devarsh Thakkar <devarsht@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 276/713] arm64: dts: ti: Add common1 register space for AM65x SoC
Date: Sun, 24 Mar 2024 18:40:02 -0400
Message-ID: <20240324224720.1345309-277-sashal@kernel.org>
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
index 29048d6577cf6..fa2304a7cb1ec 100644
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


