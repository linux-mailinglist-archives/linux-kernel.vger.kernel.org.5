Return-Path: <linux-kernel+bounces-115337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C48893AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130541F2EAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474FB1E5F72;
	Mon, 25 Mar 2024 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPd3SxM7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555B57EF11;
	Sun, 24 Mar 2024 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320467; cv=none; b=soasyB5IXagdBwpZ6tB5Ugl1iR/faUmXuuHYusrD8U7aV1szIstMsMh5SCBMRsnr5UgTOn1MHm1FaJe/H0LZxCXM0bPSxEnrjQedM6ULeY89pdMDqeXjEX37i9wPqJXOB8VOP4mKryGl6lLghs55rjanUCmLtHzVr3LDNT9Sy+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320467; c=relaxed/simple;
	bh=IsMtaPO2nRbjGtVcG7DjgE1BW1fqCgoEtlxwZS2MSXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQlQ1+lyS6/ll9oyJ78/NY+0D2aMUOD9dcqJKfm6wUCwD6gyV4Msum4h2Rcv4VXXw4iQXgHJPyQOsdDe+AyHmWTc2nFGSmA22YjwR8ppalXxWLb0tIq4p+EQ1O+G9QbHkvhcYQ9w22aZfpbqPS0U0eCd56kC9Jt3tmQDly6C3/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPd3SxM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F72C43390;
	Sun, 24 Mar 2024 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320467;
	bh=IsMtaPO2nRbjGtVcG7DjgE1BW1fqCgoEtlxwZS2MSXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vPd3SxM7n0EM1HgOOfiV0bDNUggiECI2lR1KtyM5NyRYCEnVFr425I8/nfFxoq0Xt
	 z8eMXS52EMwr/UXOvBK1+t4vpNeT66mMezyqc66mJx+xMuXXFXdwO6LYUr5qcqkNA0
	 jQQ+Bl3OoUrjzrjZ2F6h13lBVcIfifZ0qMZ1ZwrnlCijYpPcUOdhLeOQv4MxSnmv8P
	 0ifiClJgL4+LkA702/0cRNFFUslBeMHk4tVfOJJg0qXPE/s09f5/VgO70jKZyOfZFD
	 +nRRv3BfFe/bsXuEnVakpQpmaRS966Z0hPSwdITTS0XHiL+qS7f/0OQBwx2+kNrX12
	 OmuPX1e7NAN9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 026/713] arm64: dts: rockchip: mark system power controller on rk3588-evb1
Date: Sun, 24 Mar 2024 18:35:52 -0400
Message-ID: <20240324224720.1345309-27-sashal@kernel.org>
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

From: Sebastian Reichel <sebastian.reichel@collabora.com>

[ Upstream commit fc4657971be31ae679e2bbeee2fb8e93a7a063eb ]

Mark the primary PMIC as system-power-controller, so that the
system properly shuts down on poweroff.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20240117191555.86138-1-sebastian.reichel@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index b9d789d57862c..bbbe00bcd14e7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -351,6 +351,7 @@ pmic@0 {
 			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
 		pinctrl-names = "default";
 		spi-max-frequency = <1000000>;
+		system-power-controller;
 
 		vcc1-supply = <&vcc5v0_sys>;
 		vcc2-supply = <&vcc5v0_sys>;
-- 
2.43.0


