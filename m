Return-Path: <linux-kernel+bounces-12673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F04881F8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44F41F24285
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B03883A;
	Thu, 28 Dec 2023 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWZ5jh9y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5ADDCE;
	Thu, 28 Dec 2023 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d2e6e14865so28594555ad.0;
        Thu, 28 Dec 2023 05:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703769421; x=1704374221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOHuqM4F/gVoKxBS/slc+DUydkCrv1+Pt87gLb5xJoo=;
        b=MWZ5jh9yZSaehe2sWp56QK3V1aaGfqQvcdCSfisUdEGYT2LWbH+VB3KgvqkQ+FpZBy
         oG1C39X50JgBR7/zBzYlUPZfiBPJDphie4JBJVecebVLHr17wNMeEsqxdfw90Qxd0P1e
         +Egn4di/Cp0FqZ7zoTk5TzSbY0X+S/sHKV0uVLbTmqcSERjQteDS4tK+mSbhHFr/dL9X
         R6QPop8hRrv430T6lfV3XlRHlRsNz0DwqtQvL9zjkT2jNOErHzpPzRnzZMtuGW0htk08
         XcdPxFx9XsY/vAnUXBfBB3xg093Kpa/MOoYKiCO4Mj1ZwtWlfZiAnMU2pR/EDxfWeTAx
         IILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703769421; x=1704374221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOHuqM4F/gVoKxBS/slc+DUydkCrv1+Pt87gLb5xJoo=;
        b=jdr9sSF+bl3vAK3IzvjDk7KcS6qcczRvzwJauTyUMuHgrdIzGcjnznveKIbZ3HtLNa
         FxIoR+aCsXGegMWejJOmojNK0ISGGS/nmkfFycLhGJyKGkwJO75Q4+KtdZGcd/Jd4jwE
         0c3wuWtMpv5bZdOPa4bOY6quZ8wW/HaRUzKRIVSdnFyrE6iuJ5UIL8JFWpaVDfTKkDO1
         0VvO/A6DcdrllOQXH8fQMeV89NOKWi22gGrpfmH1f69ymOrJL5IDegF+NdpiTvH1NI6/
         nl1/idBPlagegU1oyYU7aKiD+hN3XNuOkR24FkiBHmoquNYJRZw9/03fZkXISuEg9yVL
         wPRg==
X-Gm-Message-State: AOJu0YwHeBnAIV5gRJPntGC4oVjLRPwmW6oxyNdEwBxWRPfRXUMta4pK
	czEz3cewEcxMgz9u3LVWeQ4=
X-Google-Smtp-Source: AGHT+IHvUsAwqSISFkKD1q5Fd4VOygs5kVC7ixxcSE+3BDhaHyTfFWCWW9C2vOMKZbZAHKCAuX0wFw==
X-Received: by 2002:a17:902:b598:b0:1d4:2e75:9b65 with SMTP id a24-20020a170902b59800b001d42e759b65mr3648629pls.108.1703769421504;
        Thu, 28 Dec 2023 05:17:01 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:3708:559:ea20:9883])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001d0b4693539sm13864221plx.189.2023.12.28.05.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 05:17:01 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sfr@canb.auug.org.au
Cc: liujianfeng1994@gmail.com,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
Date: Thu, 28 Dec 2023 21:16:16 +0800
Message-Id: <20231228131617.3411561-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228131617.3411561-1-liujianfeng1994@gmail.com>
References: <20231228131617.3411561-1-liujianfeng1994@gmail.com>
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
index 5fb0baf8a..5da668184 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -640,6 +640,26 @@ i2c0: i2c@fd880000 {
 		status = "disabled";
 	};
 
+	vpu: video-codec@fdb50400 {
+		compatible = "rockchip,rk3588-vpu";
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


