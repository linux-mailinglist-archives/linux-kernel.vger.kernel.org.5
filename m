Return-Path: <linux-kernel+bounces-121929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A09188EF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 968A0B22122
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817F612D748;
	Wed, 27 Mar 2024 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="VR8kDsBc"
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7214E2D9;
	Wed, 27 Mar 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569404; cv=none; b=MY69trweyMw5UpcmDAirXtq6FEzB7oJ1Mh2FGXrrFgwt/EwDhSDIkYiGM+WSVi/XyLMy9Tbv8pe+q4cvzdgRIyVoW1KiGUuCXm4OCZBA/p7SY9wNkbbe8l20PW6aXJZNruVoA5Ng26cyEUrUmKD3o+cMYivSeQrqdi4+lktQJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569404; c=relaxed/simple;
	bh=axd3a0fX0rgtyK/RmzGt3WlUIVH/eX2dB52K53T7X8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+9clCqLWt1uDKIxirFhgeWY4v5CKjltRDpXd2X91UcaaGnZqF5tUILNm2FawWGVlo5Ts1empcKMq8NmRQ6FgsKEwh6NjjCMyJ2NXr1JB5Ki1sjV7Ve5E9UTjJVbky10bsVlJu1dbzot0emRWTynk7z5TttLAfe4ivtxvdjq4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=VR8kDsBc; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PbW/dVoNioC9H6nvXtciGc7SM7HI15MyzienCfKIkR4=; b=VR8kDsBcDbAEnaXTexmEIWas1t
	b2KR+fJi/XsXdOE1V5MMnZVMxq+8uMaUz04wzmN+wb13IgLK02yZtNeDGVjG4pQ4+iBemvahrXXOK
	a/xmDMbSeXX0Yk6BIByz4W0CW7/q17x1DsyiZ0cm3FVdQ4PC16h7Y09OoYOfY19fi6Y7aDtSX5eFZ
	GE+u8lB2OrlJRt4fHmCWrFTJxLwXjnfRFFmmk9R14VMxi8vsH0qTPEAVsfnN49ILe0VQqDUYjC5mO
	GSpfupQcYcfrrzfGw2j3qWsENzLylLIXG0vNrUkEsfp+VhUcE2LlHSjKbXnNC2QDJzSVRC+Anc4nD
	Tu8HyuKw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1rpYvT-000Isr-4F; Wed, 27 Mar 2024 20:27:07 +0100
Received: from [185.209.196.215] (helo=homedev.localdomain)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1rpYvS-000Iyc-EA; Wed, 27 Mar 2024 20:27:06 +0100
From: Folker Schwesinger <dev@folker-schwesinger.de>
To: Vinod Koul <vkoul@kernel.org>,
	Yogesh Hegde <yogi.kernel@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Ruehl <chris.ruehl@gtsys.com.hk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Folker Schwesinger <dev@folker-schwesinger.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Christopher Obbard <chris.obbard@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: Add enable-strobe-pulldown to emmc phy on ROCK 4C+
Date: Wed, 27 Mar 2024 20:26:38 +0100
Message-ID: <20240327192641.14220-3-dev@folker-schwesinger.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327192641.14220-1-dev@folker-schwesinger.de>
References: <20240327192641.14220-1-dev@folker-schwesinger.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27227/Wed Mar 27 09:33:27 2024)

Commit 8b5c2b45b8f0 disabled the internal pull-down for the strobe line
causing I/O errors in HS400 mode for various eMMC modules.

Enable the internal strobe pull-down for the ROCK 4C+ board. Also re-enable
HS400 mode, that was replaced with HS200 mode as a workaround for the
stability issues in:
2bd1d2dd808c ("arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+").

Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe line in dts")
Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
index 7baf9d1b22fd..972aea843afd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
@@ -151,6 +151,7 @@ &cpu_b1 {
 };
 
 &emmc_phy {
+	rockchip,enable-strobe-pulldown;
 	status = "okay";
 };
 
@@ -549,7 +550,8 @@ &saradc {
 &sdhci {
 	max-frequency = <150000000>;
 	bus-width = <8>;
-	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
 	non-removable;
 	status = "okay";
 };
-- 
2.44.0


