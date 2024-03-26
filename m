Return-Path: <linux-kernel+bounces-119733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABCE88CC82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2031F2CF76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F44A13CC6B;
	Tue, 26 Mar 2024 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxQWBkHE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC513C813;
	Tue, 26 Mar 2024 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479444; cv=none; b=sWkhk8HdTnt9JRFp6f+eIa7Xpf1pZHiW5+2CIPfdoNTN8TV1+jn2w90THOh+JMk9qzplCTJ4A2hqFgkaYaiceq6qB9qj9hI36H7gN8xt/Lm+4zeOLDSX86xtkvx6WQvyLovXRlsWdbINX6NEAfDCuSsbO6ox35nX1LCfL6/oiWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479444; c=relaxed/simple;
	bh=t92rMDfisU2O183WicZRvvThqnLcj0E2zhg0sRyx/uA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rzbKuejXHPFvZ/mVpEKIH1mPuvskx8C3XHlVhmErXiONivCxJcFg6DsswGtE/cREDH+90/rAwvVzR8/He/84Bv6Z9GqERaK6tnrHHPPoD6TAIAJFSGX5QRiIIl1n9O51ZyUJtJZUgVMWfGDtS1cGdXajhXbNWyJy11NyWCmBosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxQWBkHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9F70C43330;
	Tue, 26 Mar 2024 18:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711479444;
	bh=t92rMDfisU2O183WicZRvvThqnLcj0E2zhg0sRyx/uA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lxQWBkHE48NtOCNCYUMMn4GNtDMNqVx0YIxT9+GwVFAmFk2Jy32/hlFbq96lBba9b
	 vuqJjKTu5OHyzHGWwylh05mfq+xheI8sSFEo0XpOG96PiYoMI6UnMvHidBtTMYj5ym
	 ao1oMynsE/KpI4e78dA8NK0lWqep3aqTPbY6JxDouNhLSOvDB9/LfAPTnod7kCSRxX
	 Nm5N4MYJYjnEZPWzsLHPddIE6dUnnydCU98EQ07dH3lpd1nXw4DhVey5JoVCpK9piB
	 ZXrKBmVZRk5I4CrcDPkwQt9hcfu4CXpbND5w9/vvWTOohNr5X+8N3FWcDaOQf2+ehD
	 XF7l6Q4b7gTnQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF2ECD1284;
	Tue, 26 Mar 2024 18:57:23 +0000 (UTC)
From: Folker Schwesinger via B4 Relay <devnull+dev.folker-schwesinger.de@kernel.org>
Date: Tue, 26 Mar 2024 19:54:37 +0100
Subject: [PATCH 3/3] arm64: dts: rockchip: Remove enable-strobe-pulldown
 for NanoPi4 boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-rk-default-enable-strobe-pulldown-v1-3-f410c71605c0@folker-schwesinger.de>
References: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
In-Reply-To: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Chris Ruehl <chris.ruehl@gtsys.com.hk>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Christopher Obbard <chris.obbard@collabora.com>, 
 Alban Browaeys <alban.browaeys@gmail.com>, 
 Doug Anderson <dianders@chromium.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Jensen Huang <jensenhuang@friendlyarm.com>, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Folker Schwesinger <dev@folker-schwesinger.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=724;
 i=dev@folker-schwesinger.de; h=from:subject:message-id;
 bh=fmO1sP9nAwWwIfDKXcaV6YI0IH/hcl1UfJExvs0KGtI=;
 b=owGbwMvMwCXG5FBoZNu1u5bxtFoSQxqz1KSLdfclJe/cdDUz+/2kl+1vlNncrZtWMwXdsI2zz
 Obt51PvKGVhEONikBVTZGHNy9jCnFm+1Lrr52uYOaxMIEMYuDgFYCJlxowMUxteL/2zjlHg1162
 50fY9v/3D+Q+G9j4zG9K5kYTttqjXowMV2buML48c6NI60+fT5tf/Q9o/dhVHZW/LE7hbpPWpuD
 v7AA=
X-Developer-Key: i=dev@folker-schwesinger.de; a=openpgp;
 fpr=056E68B4036977A53B8AF9EB024071323D8ABB7D
X-Endpoint-Received: by B4 Relay for dev@folker-schwesinger.de/default with
 auth_id=144
X-Original-From: Folker Schwesinger <dev@folker-schwesinger.de>
Reply-To: dev@folker-schwesinger.de

From: Folker Schwesinger <dev@folker-schwesinger.de>

The Rockchip eMMC PHY driver enables the internal strobe pulldown by
default. So, remove the enable-strobe-pulldown property from the
NanoPi4 series boards DTS.

Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index b7f1e47978a6..38af91b9e756 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -168,7 +168,6 @@ &cpu_l3 {
 };
 
 &emmc_phy {
-	rockchip,enable-strobe-pulldown;
 	status = "okay";
 };
 

-- 
2.44.0



