Return-Path: <linux-kernel+bounces-115912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C80889891
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB27D1C317A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE55386607;
	Mon, 25 Mar 2024 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYSe3BA4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB41482E6;
	Sun, 24 Mar 2024 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322102; cv=none; b=er7bg/zg4BGCbA81tN5TRG6i4Z5RwyIojaNCM6ZX531b6KnWr7F+Z8QAgxq7HeDDo0H4Qu64EjyRId4pTvlKQ3jurIp1yTAUgGeSIN4M3vwn+tbzZBcf72z8AjB+WTwlQPc2+wntVzGUbP5NpbPcnuHeOAatciQfZiCWSfE/DQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322102; c=relaxed/simple;
	bh=sHtN40JvDFTt2XNwSm8S+WPSShk14dHW8olqtlUGZOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQHjKQHJKSJs0UsCpxllkBYVDAToPeensMgrP7rR7p/PqLOCe1O/0plkDhSN2dYw+dUTAYkLC+nTQB8xXYWvP9FCDZTNz0vjICVEAhD36l0Ih0Z7j2PYY4JTonatsS0blZ7LoN6fagM6wX5H7ydZOBXVGZGpPF/XHX+Foy50G4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYSe3BA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7302C43394;
	Sun, 24 Mar 2024 23:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322102;
	bh=sHtN40JvDFTt2XNwSm8S+WPSShk14dHW8olqtlUGZOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYSe3BA4WibJ3514nJhIabuY8NQRmPIVfmEvxzPmk9hyo/0RRQmyPMR28pRHYZFJT
	 cD7z4TAKppl9+RuF0wb2t2B6U1upWPQIl82c2v0VnPFrmtngd6qoGf+8YtayLsKHHv
	 J0+w+G/VvkRzi5D5OQlZPhIL6zcDE6gm+t15wxwLQ7YCXGwKK2xERmAPr6aOLCL1bt
	 vEk1VD4AmNBjAmo52loTMoQyfXGbKvO0VRXOvgr3C+llIknShSPi3bErOxHQUKJNgB
	 Kxa0CRqS/pdbLFv5XtWC605wHWE3SfwS1d12v75jSzz3IH6Gqi8EKIMt3yGSOtPx7Y
	 2/B1Wjv+c+aMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 177/451] ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address
Date: Sun, 24 Mar 2024 19:07:33 -0400
Message-ID: <20240324231207.1351418-178-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michal Vokáč <michal.vokac@ysoft.com>

[ Upstream commit 023bd910d3ab735459f84b22bb99fb9e00bd9d76 ]

This change does not have any functional effect. The switch works just
fine without this patch as it has full access to all the addresses
on the bus. This is simply a clean-up to set the node name address
and reg address to the same value.

Fixes: 15b43e497ffd ("ARM: dts: imx6dl-yapp4: Use correct pseudo PHY address for the switch")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index cb1972f8e8d27..a655b945bf2df 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -128,7 +128,7 @@ phy_port3: phy@2 {
 
 		switch@10 {
 			compatible = "qca,qca8334";
-			reg = <10>;
+			reg = <0x10>;
 			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 
 			switch_ports: ports {
-- 
2.43.0


