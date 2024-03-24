Return-Path: <linux-kernel+bounces-114212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C560F888924
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC33288B76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A13158D97;
	Sun, 24 Mar 2024 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vA7tUz+P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983913792B;
	Sun, 24 Mar 2024 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321551; cv=none; b=h7JnrGRtdVlBEWTclVQJ1dXHT5/8VioGgxjiRfo749LkPdx/G8wZlU7cuD7PzBTJXQtytrkwZKmd6qk9m5hGmj76vMqu3eg2OCbAzw276Kr9PeFLbJQLzvbk1PhBVR9TZy+nSleJyQvnVeMJs67lUJj74XgNGaEaAAwPsOoPpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321551; c=relaxed/simple;
	bh=wPy3lN9HwuEVnsMDePAyiIG0fyWowzYQFWhLYgHqdgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9Qj4MlFe2UZVd0GGLwwUas37zf+YlQKFAiZ5ejd5QocVQDQS3UX0ga3BcZ1TLdN0Za4ZkpDF7uBW+hGRw5rJkSyvux2OLPTaScytjhFtnpESW84009w0mbY8tHx4GKDdQFF6b8CD+Hjb60BK3Ze8M9BhhioLY2+O/W1fFYoDlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vA7tUz+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C1AC43394;
	Sun, 24 Mar 2024 23:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321550;
	bh=wPy3lN9HwuEVnsMDePAyiIG0fyWowzYQFWhLYgHqdgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vA7tUz+P2TTeY//dkR2Qn60bkwVFMtJS3locNNr9lwIyPXt//osPLpmxhFpNvmKGv
	 qSDzU1SNkgCBBtGy/K0cyoiwMiyfZNvAsZ39FJzwr4rb3o6FYgVPNFSV9fznOOlRG8
	 cSXRUrm3oRm8WhjSRUej6rKmC78idNNaNZuWy/NbiEJO6ePieobh7RwaRN7I7u67Dd
	 r0TJTgQUsDO4OVZOY6KAm4W0cJa3vQcQMPOHTkFw0s8hPm7WpwjEx09vLaz6CC8F6B
	 kdag32eXIRLqRKTOL6DWDfTTX/yl2cunGrtUr0IvdnZ1lojifTV2MvYo/gqcV+TWw3
	 kiDvKUunYkPsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 279/638] arm64: dts: rockchip: fix reset-names for rk356x i2s2 controller
Date: Sun, 24 Mar 2024 18:55:16 -0400
Message-ID: <20240324230116.1348576-280-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit 0fc19ab75acde78558bd0f6fe3e5f63cf8ee88b0 ]

The dtbscheck reports a warning for a wrong reset-names property for
the i2s2 controller on rk356x socs.

The other controllers on the soc provide tx and rx directions and hence
two resets and separate clocks for each direction, while i2s2 only
provides one reset. This was so far named just "m" which isn't part of
the binding.

The clock-names the controller uses all end in "tx", so use the matching
"tx-m" reset-name for the i2s controller.

Fixes: 755f37010f3e ("arm64: dts: rockchip: RK356x: Add I2S2 device node")
Acked-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240227173526.710056-2-heiko@sntech.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 3cd097adb3686..820c98dbccc0a 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -1117,7 +1117,7 @@ i2s2_2ch: i2s@fe420000 {
 		dmas = <&dmac1 4>, <&dmac1 5>;
 		dma-names = "tx", "rx";
 		resets = <&cru SRST_M_I2S2_2CH>;
-		reset-names = "m";
+		reset-names = "tx-m";
 		rockchip,grf = <&grf>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s2m0_sclktx
-- 
2.43.0


