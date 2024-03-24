Return-Path: <linux-kernel+bounces-115893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFB1889889
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F35E1C26F76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B45226D40;
	Mon, 25 Mar 2024 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYJLJzZt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC43F1474AC;
	Sun, 24 Mar 2024 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322085; cv=none; b=YSzpSwSPifKspb/UrGTkNEIXDx2CRBJUw8q520+5fwori0MLW550KNEnT7Zu7xXRqXPrJj8Z7Xt9it1Dz1+97NX/HPqTuyV15Op8XNKaqaxl+e5V/m5cU5NknyvhdY76GnoSoUSKJhU3EneSCJlrJCRQpgBX4TkauKyr0zUN9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322085; c=relaxed/simple;
	bh=UZAYXkfvvB/QGOL6+hIBVYFS/RefZKckd0oTyPYTS9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oqhjg+E3tbNKdJF1G+5pTVOe4mUo1SP08iNHtlfKW8rL3FKhdTr7mZhF26J2B2WRwxm0xiZ8vYlbIAwY0Gjo7MNOaJXD+G46Z+oJL/WvWQRs8U2GYm2pMRZo/9lOaCrP4RZj4cU/f/udVDuJmJgDi1AakLjhEjqV2OXTXxPEfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYJLJzZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5C6C433F1;
	Sun, 24 Mar 2024 23:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322085;
	bh=UZAYXkfvvB/QGOL6+hIBVYFS/RefZKckd0oTyPYTS9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYJLJzZtTeLOgIbLAd9ch7iPzuNi4GKN/vMunzRrO5/87t/4uCgEnntR4VCxlmmvr
	 ZMK985MJXxeGmRpSWgrVCaQ9Hoftpr3rs4b8R3BVIXS2R6gOHDV0I/OfJ4ekd4T1zw
	 K/6dim3rgQl46gOtXhJUJDVF1c6L5aryZvLOp3OGTOiYyUWTw2X6sqVoVugoUJMwby
	 e1h5ShWx4cmemYcJ375a9p+7NENg78G0BM9Oft7z/BLzigwmpO597efhH0ZN19OMFW
	 ke18Xq8fpOjbngEn/YrxeI870yF29Wyg2yGYPYQR+DblWBtlyTi0dmCT+NFoTCUMrO
	 2B+gtYafXt7zQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 159/451] arm64: dts: qcom: sm8150: correct PCIe wake-gpios
Date: Sun, 24 Mar 2024 19:07:15 -0400
Message-ID: <20240324231207.1351418-160-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 7c38989d0f7a35c83e7c4781271d42662903fa8d ]

Bindings allow a "wake", not "enable", GPIO.  Schematics also use WAKE
name for the pin:

  sa8155p-adp.dtb: pcie@1c00000: Unevaluated properties are not allowed ('enable-gpio' was unexpected)

Fixes: a1c86c680533 ("arm64: dts: qcom: sm8150: Add PCIe nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240108131216.53867-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index b829a9ebc5670..9dccecd9fcaef 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1823,7 +1823,7 @@ pcie0: pci@1c00000 {
 			phy-names = "pciephy";
 
 			perst-gpios = <&tlmm 35 GPIO_ACTIVE_HIGH>;
-			enable-gpio = <&tlmm 37 GPIO_ACTIVE_HIGH>;
+			wake-gpios = <&tlmm 37 GPIO_ACTIVE_HIGH>;
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie0_default_state>;
-- 
2.43.0


