Return-Path: <linux-kernel+bounces-28259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C9682FC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13CD2B2699B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184E51EB52;
	Tue, 16 Jan 2024 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqVUde53"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4938395;
	Tue, 16 Jan 2024 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437683; cv=none; b=V+w8bwlwipFFH5pW4xm3KZeXkDJawG33CBNUnEN5uw2tJbWHJlvrmxKqcrV91m/mJ8IQ/RxYUKSgCkRtsLrjcb86TMP9qkGBPG/WhwwcSEu2zj+3mO4n7lkHtLJZscwQ35Y6XTQLLBusK/NY0473un4g8QrBaxrIyrmvKxIjrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437683; c=relaxed/simple;
	bh=XCvYWP355Fhaawn/5OW3KCqVRZ0sq76+8/0cmtgC4+E=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=rS0r9tUvDgGTgVotPadpUFQqGiUyXXlpzzoH2HJd+QEWu1m2KGReSPTo6NGsneXKtqOG/SgbUP+SDU66MMaQyNWorsAXve55N0C1sqTIv3Nsy26wT9o7Yr2nrELAX7mdYhaf+DxXzo5o0ntevRnRplCJDt3A3EU93mBsa3qpDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqVUde53; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-429be9fe952so39550531cf.0;
        Tue, 16 Jan 2024 12:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705437680; x=1706042480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKvjgEuWJbSxEFFzQ1IdsdgMBmwT8jOSBvK770lzRTk=;
        b=gqVUde53KYqc4NgXkb4CK3vTrbAdbfO89o/6v3jyHWpbZwklI6HD0jJO09jB8oIs8s
         OklonKEvIEWwotZqlcGi/JEWUTbKWGEcfRbwE/mPWAzXbLQvAaZli+J1EgPmgvDyR9md
         iKAcNCecj2UKkCJ9GUpvSoVEylgW6AyiU6S4ckpGtd3jZMSof5U4N3LqxbtRqqRcL44l
         97QvLYeQj5hwjWuhk1mgeAHKiCFoRKP2nylphwlOre/bV2P66tlI5VK9w1FRpR8CR/GM
         joO4LX2M13MIZwj7hbWqo+Gvd3CXL9K2dwT3WvP8kw2ta7HVlJRTPBBcj5nWsu/f+7an
         dguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705437680; x=1706042480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKvjgEuWJbSxEFFzQ1IdsdgMBmwT8jOSBvK770lzRTk=;
        b=p2vRzbQHaUSpdpQurqw4EW66+NHGHPXl1QTbP+FfUaoS2EmIPO8iFUKH7aSxUfbgfC
         RaZEsCBtnrTcIjQbZMBvwSFMULkWfNb7EIBwoZnl7/qll3kyFEdbOcVr1e6hkhnNrOph
         ySssQHjOMk/BOxQavYUX1xvmPiFoyPBFgGaaG7IS00OOAn4i5t+rko9ZI8zMujOCC3w2
         Xl/e0wtebOyPBlW2LfA0VTF4ji1LK/wm/Pa81A32/VtjAL0CjNFA7/RBnIVr2EzAp+tP
         7JHCzANP9j42OUZf/IntgCzYBRDSeSDVlsyJaEGF43pAnNy8hkNe2NIMAlUkI+cuMfG6
         J7vg==
X-Gm-Message-State: AOJu0Yzt6CiZ7a5RpaakmHfy1OaHfD2QFy1lgmnRYPO3/cnR5w0/XsG6
	oitxRpRSynM5d7LJCzyrp1j64RSKA/A=
X-Google-Smtp-Source: AGHT+IGKcQ/SAihBdD6ihNwYRSNgO2+0Zfozh06Nmkz6o8mmNBZYDS1QuN1HRT5DTCFw6RwZ6BJ8AQ==
X-Received: by 2002:ad4:5bc3:0:b0:681:78b8:1058 with SMTP id t3-20020ad45bc3000000b0068178b81058mr844835qvt.49.1705437679920;
        Tue, 16 Jan 2024 12:41:19 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d10-20020a0cfe8a000000b0067f454b5307sm4419061qvs.108.2024.01.16.12.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 12:41:19 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 1/2] arm64: dts: rockchip: rock-pi-e: adjust phy-handle name
Date: Tue, 16 Jan 2024 15:41:01 -0500
Message-ID: <20240116204103.29318-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.43.0.76.g1a87c842ece3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rock-pi-e currently comes in 4 board spins, the latest one (v1.21)
swaps out the Realtek 8211e PHY for an 8211f PHY. Therefore modify the
phy-handle name to be more generic.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
index 018a3a5075c7..096cfa19036e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
@@ -146,7 +146,7 @@ &gmac2io {
 	assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
 	assigned-clock-parents = <&gmac_clkin>, <&gmac_clkin>;
 	clock_in_out = "input";
-	phy-handle = <&rtl8211e>;
+	phy-handle = <&rtl8211>;
 	phy-mode = "rgmii";
 	phy-supply = <&vcc_io>;
 	pinctrl-names = "default";
@@ -163,7 +163,7 @@ mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		rtl8211e: ethernet-phy@1 {
+		rtl8211: ethernet-phy@1 {
 			reg = <1>;
 			pinctrl-0 = <&eth_phy_int_pin>, <&eth_phy_reset_pin>;
 			pinctrl-names = "default";
-- 
2.43.0.76.g1a87c842ece3


