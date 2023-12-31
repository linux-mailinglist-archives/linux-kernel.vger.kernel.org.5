Return-Path: <linux-kernel+bounces-13727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C3A820BB9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364821F212BE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04BD8F74;
	Sun, 31 Dec 2023 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdhN8Reb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080168F57;
	Sun, 31 Dec 2023 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce0efd60ddso1592161a12.0;
        Sun, 31 Dec 2023 07:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704035549; x=1704640349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQ3gts5DeG3AEZVfFZjp7LgA4Q4AdeMKho3AyDhAyJM=;
        b=KdhN8RebiHHLyKQTjeDcGzzwv/37YFGYOpXkpGOLHXowrYU/yBZzYDMWweSz9/7NFu
         RitAZLB7tBKvuBl31EeJyzbueeasR7GTp/XfM9nAsKDOWdwwHD5TdqTY2rLLqVeqVj7P
         vFxGYa+GWZIJayBSQbW1+/Tm+o36dlqocYTx+vVZQJVe3cjg82R1/lU15PqPckeBRAFn
         Xm7n+u4Om3jV0yK47EGIZSptlvzkfpcFfeT2RWixr/b5L6IpeRmths4IyoBK22IEB+dQ
         L+W1fs2RXVEnX47qr+pKy1aqdz2hp7TzoWdk3qKSXCTDnbYoFlkoYUjnKu0AHesZNNr3
         AehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704035549; x=1704640349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQ3gts5DeG3AEZVfFZjp7LgA4Q4AdeMKho3AyDhAyJM=;
        b=Fd3xyPCQEHJJZwpLDICqCHBjKLZs0NXc8KTBSqN4b2icekjaTWOjOUKK92sOWFlOGh
         ZrpHF8r0Lg4E2JvH07lpKrjU/CuMODZGKLfzVqSjxXb6YugPS4p2rAf5pZ2ecVGU/WAY
         2J52PgJ/sAXfBrCO4jAxV7mkDOzdKUkgfjbPLpZ9iKgm2eLGArX+a75D6neR2tDRWCF9
         Z7WO9Fkfwm5i5cVAtmR0WrmZV2C2JVexFGDMeCPKRVae8SvjwyIdaqqV3VEidxTJ9kmF
         /Rf9IrFZprQ/9og6BYdX5nVCMvN2ErGB9g2DiDM+of5kGTgXf5kbTIDghmnIaLMiK+J6
         QUvQ==
X-Gm-Message-State: AOJu0YxvLZQVXBgDsWwjN3k+OUH8+QWnUM2VH+g8zYcFY/+NF4OP3V6v
	cmhgQjiI5UFv5jFu2i7pmgo=
X-Google-Smtp-Source: AGHT+IGBB6t3FuQ8QHq8Y7Xn/0fTrRbyfKnwRVaCWJpDClar+fRlIaXHT2rMc6fCLi/Q2cjIWZNPaA==
X-Received: by 2002:a17:903:1208:b0:1d4:a24c:4be0 with SMTP id l8-20020a170903120800b001d4a24c4be0mr1607599plh.133.1704035549240;
        Sun, 31 Dec 2023 07:12:29 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:2643:6273:f90:f77e])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001d058ad8770sm18775011plh.306.2023.12.31.07.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 07:12:28 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: sfr@canb.auug.org.au,
	liujianfeng1994@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	sigmaris@gmail.com,
	knaerzche@gmail.com
Subject: [PATCH v3 1/2] arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
Date: Sun, 31 Dec 2023 23:11:11 +0800
Message-Id: <20231231151112.3994194-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231231151112.3994194-1-liujianfeng1994@gmail.com>
References: <20231231151112.3994194-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enables Hantro G1 video decoder in RK3588's
devicetree.

Tested with FFmpeg v4l2_request code taken from [1]
with MPEG2, H.264 and VP8 samples.

[1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/multimedia/ffmpeg/patches/v4l2-request/ffmpeg-001-v4l2-request.patch

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 5fb0baf8a..ab2792162 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -640,6 +640,26 @@ i2c0: i2c@fd880000 {
 		status = "disabled";
 	};
 
+	vpu: video-codec@fdb50000 {
+		compatible = "rockchip,rk3588-vpu", "rockchip,rk3568-vpu";
+		reg = <0x0 0xfdb50000 0x0 0x800>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		clock-names = "aclk", "hclk";
+		iommus = <&vdpu_mmu>;
+		power-domains = <&power RK3588_PD_VDPU>;
+	};
+
+	vdpu_mmu: iommu@fdb50800 {
+		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg = <0x0 0xfdb50800 0x0 0x40>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
+		clock-names = "aclk", "iface";
+		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		power-domains = <&power RK3588_PD_VDPU>;
+		#iommu-cells = <0>;
+	};
+
 	vop: vop@fdd90000 {
 		compatible = "rockchip,rk3588-vop";
 		reg = <0x0 0xfdd90000 0x0 0x4200>, <0x0 0xfdd95000 0x0 0x1000>;
-- 
2.34.1


