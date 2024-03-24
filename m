Return-Path: <linux-kernel+bounces-114023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF370888F18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A6128A5AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A369815B123;
	Sun, 24 Mar 2024 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhx+wykr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8312FB23;
	Sun, 24 Mar 2024 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321300; cv=none; b=rha6qbzC2kpdK0d46pmcBYn3snzhZGZKf40/nVdhSfXP5cuzKs39FaGvngxhCxVKFpntaS+90mRiHzF8xpPJNCrOVzmy3nNe5X+vr0h0ghb8r3071t2+/x9dDiv6kkUM5+2P01H6ju75Jd9Eppf6iXMOJSUf9TeVxsnOpw9c3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321300; c=relaxed/simple;
	bh=2BdqdFEP9DNIj4Ti/gNcxrXdKA23Zc1z1zE0/5TQH0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2Kw5h5adDr9QvMlohJ5YRnfxWTyuizaOHGpGGz5mgeUw+VF/Q6vD6fsVFKOYKvsgnWwWzL9/yoyhdtGPSo4EmvSDiZyO6jco4FhNmYbEOxfdEFU74V4tcUXXNpOC8VYW285qmsHaKPmj/h5n+e8SV/nIsxxbpy61f8DbVg4Go0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhx+wykr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B45C433C7;
	Sun, 24 Mar 2024 23:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321299;
	bh=2BdqdFEP9DNIj4Ti/gNcxrXdKA23Zc1z1zE0/5TQH0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vhx+wykrgUUz6HZT8pMHcdVisPk1R6lavShNCI+oXE2O/w8csaRNLcLet4WZ8XTsT
	 1tH6lKd70nyRK7u6GLPUCM5O9LztAklFQtFRoW3N2yWxVq+EQRV14IFL5qnHnJOkxL
	 Ehz5QHTDIXrKgdrUOzhhgP13sXBYDc2VgRleoXj5UI1zoBshQaXUfldJDMbVTXLfaR
	 DO7FAOfvtkDmYLZ7Dquz1AwK582utKh0njEunBQMLMb4hXbd7eFWhxHNuK4CcG2YWO
	 DuoonJzmYOe1dB3TJsH/aV78Nu77wLXSNEK8rF/C4x2hDymGXpSgKr9K1fR4VQ8HE3
	 PU01XxyxFZVew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 022/638] arm64: dts: rockchip: mark system power controller on rk3588-evb1
Date: Sun, 24 Mar 2024 18:50:59 -0400
Message-ID: <20240324230116.1348576-23-sashal@kernel.org>
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
index 229a9111f5eb0..fa8286a325af7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -215,6 +215,7 @@ pmic@0 {
 			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
 		pinctrl-names = "default";
 		spi-max-frequency = <1000000>;
+		system-power-controller;
 
 		vcc1-supply = <&vcc5v0_sys>;
 		vcc2-supply = <&vcc5v0_sys>;
-- 
2.43.0


