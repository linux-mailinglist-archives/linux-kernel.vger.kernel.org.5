Return-Path: <linux-kernel+bounces-143603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9348A3B52
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10075B21823
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17393208BC;
	Sat, 13 Apr 2024 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4vPFtaZ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4921C6A0;
	Sat, 13 Apr 2024 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712990806; cv=none; b=oelr4vLSzswGtUsHU3Ef63sQLtJvowiCSNLWUzhsPU2LVOBqKIBCMLDYhM4qOzpHh2p0BratRkE/SKGWqNAcFOHPYUc4QsrzXKPgpYePr6V7zmGSXsw2xjB0vetJsFzsP0KU8F4MA6WFOx7TsSJ8MtZLvAeZCf7F4G0bP6Qdztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712990806; c=relaxed/simple;
	bh=XbtrCJeH1sLdoyCCqia+/5GzGrwZABwnokufR4xmlxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I296/CJkqwz9xn0/0RxkB+noXRDaOzW4hUXmrT/6L24todAC8tdQAMFFMav5A6LLau1plA4wp8HSCDDTrlzib3T52UCS3EA0evNaxyKG3Zo5ii2qIb4thjRD5ePZB1uQnMS1XAebpOyecwJi5UbMHC/rs+hGqJoX7haTnoTGPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4vPFtaZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e411e339b8so12654155ad.3;
        Fri, 12 Apr 2024 23:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712990804; x=1713595604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IX8+yKbNfiVsthYW7XKH1eWLYDaubrEtnopoFEYRG3Q=;
        b=b4vPFtaZvLvbBWMZJr7kS4qcw6Mu7W1iVVRHJmuDZTkYHb0o2T/l32f6wOX6J3qnk6
         hAyH2bvzblZDrXPJxd24ixLjpfzb3KYuvmNxUbfSgkVhr9U4h2Xh6dK1cGiqR7i35/e1
         l3J0gJ1Hwg6jDbr/1dquZmciT57hAGGjF75JcF2aYfo7mJH19BGgeBCk0nLsun5EDKIH
         BlmwBYkJqqxDN/rN9HQOkszB5W2l9G+yXyzgXeBy3CnLOKHItrTUMfnYnt6eumQ4v8Tz
         TD69kpsZrYvRrEvLZpFzqnpWBgs9/Bleg1zecVyGU4693Y5E5qC6VjOVEDeDaM5v25V7
         q7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712990804; x=1713595604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IX8+yKbNfiVsthYW7XKH1eWLYDaubrEtnopoFEYRG3Q=;
        b=FOI8bGS2IAxQJok4t2FJgzZehlQKZqACJ4qftdzaEo7k9IKwsc/pMC2xG4KleavbdQ
         ZBxwQzs1/dlcix/nVdaAiKDFoUKKQ4ByWG91dSsHUBS3uCfvgOIVIP7KFptxUJtCiORW
         hkOm2+ABhfnMnHHAVVhbCYmQDhsN6AhfmJv6MpYmHK3uoMmXDzfhOp1GJIhMPaCDQbYu
         73fWCmvdMUptyIMDwwLZgEJ4P9gLYx1ZNvnIfKeUxcoraIedoI3cQWmamDAI6XUIxIXE
         eAabnzx/LG5onTa/9CnWq3uDAv7VsY+1ExDEqwqsMFypFIGGhBxhthqwVIfNzJzc8tK1
         ARAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX51cv1yfEOY3akNPBFJpvlDWIBCTpKYcpS4LYeVXtXs12n1/yQ8VVR3y20c+Mbnx8zub0c8gP5NdnEcPuadlYeb53N+iaw/sDzrWHM+BYE3F7/bksswV2yKGuUmCSgujr0kBdYaKFcwVA=
X-Gm-Message-State: AOJu0YyuDMVeYDjzZ1INuj9Q6A5cPqCbS1vymlumkqUYoZVbZBRVULd+
	8X/VQajoMrg6Cm6Ttkba2ogJ+zgrz64Jim68zt+LsCVzI/axlgqyB6u1JAw+nvQ=
X-Google-Smtp-Source: AGHT+IG2v1voZ4jUtk3gwJ5t0BpkvC2xmQ/vb0BVsmZQK2jxHhHV6XnEiC/lD631JMGbseAEcE8mfw==
X-Received: by 2002:a17:902:a98a:b0:1e3:de79:35d1 with SMTP id bh10-20020a170902a98a00b001e3de7935d1mr4309333plb.23.1712990803645;
        Fri, 12 Apr 2024 23:46:43 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902780600b001e2a7e90321sm4096693pll.224.2024.04.12.23.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 23:46:42 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	sfr@canb.auug.org.au,
	liujianfeng1994@gmail.com
Subject: [PATCH v5 1/2] arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
Date: Sat, 13 Apr 2024 14:46:07 +0800
Message-Id: <20240413064608.788561-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413064608.788561-1-liujianfeng1994@gmail.com>
References: <20240413064608.788561-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Hantro G1 video decoder in RK3588's devicetree.

Tested with FFmpeg v4l2_request code taken from [1]
with MPEG2, H.264 and VP8 samples.

[1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/multimedia/ffmpeg/patches/v4l2-request/ffmpeg-001-v4l2-request.patch

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index ac5bd630f..de823f461 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1072,6 +1072,27 @@ power-domain@RK3588_PD_SDMMC {
 		};
 	};
 
+	vpu: video-codec@fdb50000 {
+		compatible = "rockchip,rk3588-vdpu121", "rockchip,rk3568-vpu";
+		reg = <0x0 0xfdb50000 0x0 0x800>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vdpu";
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
 	av1d: video-codec@fdc70000 {
 		compatible = "rockchip,rk3588-av1-vpu";
 		reg = <0x0 0xfdc70000 0x0 0x800>;
-- 
2.34.1


