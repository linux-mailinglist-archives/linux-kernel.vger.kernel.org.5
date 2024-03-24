Return-Path: <linux-kernel+bounces-113730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322FD888642
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63C11F23EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2F41EAD25;
	Sun, 24 Mar 2024 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdsTiaFq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147AD1D6846;
	Sun, 24 Mar 2024 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320718; cv=none; b=VKO+gvv+Wtw4Y8R+Be9zUQQ2PH/2LpzqD5jhpwJ0TzW0qhwWpSChdYYvNUQj8H7GVVFcCm7aVb96v06D8+7WQATWl89B4Y0ug6OTgCft8GZeqxBVgTNm1LjDZh44a6PoNDtvoie2jk56FvxOQ9/Tcuqg7vjzLeS9/Ag8VyFRfII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320718; c=relaxed/simple;
	bh=hqBbDuRgdmrUloL1U9utTYvFeiQt+JTbYKGUkQT9D1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpFG43VJkKwK1NzeYeQ5H8906vbVW61gRu8f3iuWFy1ggxPPSrjOInf3TkeL6LZiAhg+ZJkuLqVrU50S7HzkgUd5YB4sSS/W3XmA/JmhGvvtI3tHidOi8jy0rfizJ1Jw9HfBBZFl7YxglbqvxsPSag5mtOQZnP+dAN/kpYRykPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdsTiaFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED501C43390;
	Sun, 24 Mar 2024 22:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320716;
	bh=hqBbDuRgdmrUloL1U9utTYvFeiQt+JTbYKGUkQT9D1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MdsTiaFq/MG+8VZHzdsiVzOoJ71Xyq/m3yybuQYDTkyjXf4YqOpfatz4T/KO9oaPj
	 /3WJSYsCrlzLKLy0j9XXJ3Fn0Xs+R0pdYnFs6B9fG2IhSKK3AF2C/xHknOHjtk5pOZ
	 x4I2q+IsinEt0vxE1+S9i+ZOmz2R1/wRg6UXIBg+v0AkUbGVdaCtEvlUtZxyN4pNtA
	 x0kydkATKuyYy8hW+7wMG2jBco8iQR0/Xn3jnWgtZ8BGOmUEgSkcQrc1bu1aQkQUeF
	 C5U3RUeHKx+s9xUZiUzg4AiwuEpsfgyxm8VtZBZEUSLAPUHpYdVPKF0Wz0HBnMfjqW
	 lnrfRf/+H5ruQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jai Luthra <j-luthra@ti.com>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 279/713] arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS
Date: Sun, 24 Mar 2024 18:40:05 -0400
Message-ID: <20240324224720.1345309-280-sashal@kernel.org>
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

From: Jai Luthra <j-luthra@ti.com>

[ Upstream commit 90a67583171f213711de662fab9f8d24a2d291a9 ]

The INTR module for DMASS1 (CSI specific DMASS) is outside the currently
available ranges, as it starts at 0x4e400000. So fix the ranges property
to enable programming the interrupts correctly.

Fixes: 29075cc09f43 ("arm64: dts: ti: Introduce AM62P5 family of SoCs")
Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Link: https://lore.kernel.org/r/20240220-am62p_csi-v2-1-3e71d9945571@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62p.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 84ffe7b9dcaf3..4f22b5d9fb9f0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -71,7 +71,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* SA3 sproxy data */
 			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
 			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* SA3 sproxy config */
-			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMSS */
+			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06408000>, /* DMSS */
 			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
 			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
 			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
-- 
2.43.0


