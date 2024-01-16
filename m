Return-Path: <linux-kernel+bounces-28260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDD882FC39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11E628C790
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B9938395;
	Tue, 16 Jan 2024 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgXzkrqx"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35673839E;
	Tue, 16 Jan 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437686; cv=none; b=UUMlfYpBlQ/ZjqLeciICypPDz5poujBstoE14rwpTXJT5Mn72E9N1LiYv2P8eDFkgjciJFBJRf12LQTNOeIs1jKThXYWZYBE8pE2vMbioavAmcPhpYVUgkCfcz2w047HJlQq9HJGQM1de6qmKDXd8mvI8sz4kphPKeB4zcypoMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437686; c=relaxed/simple;
	bh=8Epi2BmwuRR1jJjMxHuvQypLnY+hkT/Xyn+UQAsftfg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=kYvAlyZBuaCrVztyYs/G1YiZeIS/w4PntCZ5Ngkc9R0wg4fbjmyAaOx0o9VMo2VonzCkhpdHAFetEKGVBE7igWOKqy+RkjOrRsQ0PlBpn8fPqd3+oZh03BOqVE/bivthuXunMz8f6CQUELDS1I0rraSK59WIGggwdTEFmf1MxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgXzkrqx; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7810827e54eso718561185a.2;
        Tue, 16 Jan 2024 12:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705437681; x=1706042481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StKRXgnZGREhQExaCuJaYVjX3Jya2+71hiETmJNExMg=;
        b=QgXzkrqx+cYFRj4SIJGsbZqqsk9qCN0CUBc/CGrsSqDx5x2viqLJ80uVLTFdDCl/CA
         SSNk1cpQUDz6BLch2Ainf/TSF2KsPXKrnCkHZm/ejsSgBEeFLc9ILdFHIBUl9ex5brx3
         d36Mkm999yX4QodKxFGA1JknqpPCOIVfXM6C1dVpshjuPqAOHxS+cfTy5JoJYiyOudZ7
         t9flIRE44pD2+85cDfgmSvNY0LMUrHosfywUfanD13gpQoLEFxwr2RDhwaVk+zK+e5eR
         M/TYj2vMjBM9khIJBMreCYKS1C9+n7hj5XNsVFI24Egn76WGH3AJH35JQUHLy/yaPCSg
         YHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705437681; x=1706042481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StKRXgnZGREhQExaCuJaYVjX3Jya2+71hiETmJNExMg=;
        b=J9ZJA8hwVvsClquH/J+wdzwNQTqKAYbK7mlhjkfPW4VgynnLL770ysA5jemQZUDByp
         fNck/xjGdeWzWu5ves9oU+pOaaaqh/UlSion/iAkvAS29B96teNwJoS9RXb07SdbVFhN
         /q9R6Q+hdh06InXj0oTVKnl+aCkZUPFEO45QaXAWMhKqfc5fA1821a9clyyv8TKs69rF
         AxRbCXQ3JF0iLxc4w0S3VQC5ZugL2+7ToPHSucZXbUdi+nZlHpcBk/vbSPoIcm7aTKFN
         Q8jyJJi7ix+NLGtd5BtYV2J3wZ9cw6qdyvAU3Aic9mojIazTH56/5b+2YuU2HL2dRVja
         SUwQ==
X-Gm-Message-State: AOJu0Yy+zXAbZXxwqMpDFJWtX3U91CsRpTVhLsTaFIyFUjF+VYhPSA1g
	FXxXpSxQSbgec8QpjA01zkH8LbTHAO0=
X-Google-Smtp-Source: AGHT+IH3Ja1QEZGR+NYI54PmP6WRhDaXVNnXOfiQFtZpqhul+4levY2faChY02X4/rctxREEh2F8Ew==
X-Received: by 2002:a05:6214:262c:b0:680:3ac:2415 with SMTP id gv12-20020a056214262c00b0068003ac2415mr10417737qvb.120.1705437681591;
        Tue, 16 Jan 2024 12:41:21 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d10-20020a0cfe8a000000b0067f454b5307sm4419061qvs.108.2024.01.16.12.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 12:41:20 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 2/2] arm64: dts: rockchip: rock-pi-e: fix location of snps properties
Date: Tue, 16 Jan 2024 15:41:02 -0500
Message-ID: <20240116204103.29318-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.43.0.76.g1a87c842ece3
In-Reply-To: <20240116204103.29318-1-twoerner@gmail.com>
References: <20240116204103.29318-1-twoerner@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A number of snps (Synopsys) properties are not in their correct location.

Fixes: b918e81f2145 ("arm64: dts: rockchip: rk3328: Add Radxa ROCK Pi E")
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
index 096cfa19036e..0739b8fec86e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
@@ -150,8 +150,11 @@ &gmac2io {
 	phy-mode = "rgmii";
 	phy-supply = <&vcc_io>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&rgmiim1_pins>;
+	pinctrl-0 = <&rgmiim1_pins>, <&eth_phy_reset_pin>;
 	snps,aal;
+	snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 50000>;
 	snps,rxpbl = <0x4>;
 	snps,txpbl = <0x4>;
 	tx_delay = <0x26>;
@@ -165,13 +168,10 @@ mdio {
 
 		rtl8211: ethernet-phy@1 {
 			reg = <1>;
-			pinctrl-0 = <&eth_phy_int_pin>, <&eth_phy_reset_pin>;
+			pinctrl-0 = <&eth_phy_int_pin>;
 			pinctrl-names = "default";
 			interrupt-parent = <&gpio1>;
 			interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <50000>;
-			reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
-- 
2.43.0.76.g1a87c842ece3


