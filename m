Return-Path: <linux-kernel+bounces-105100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E191287D91B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EE228224F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 07:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D941111CAF;
	Sat, 16 Mar 2024 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifDm0Swl"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC60DFC12;
	Sat, 16 Mar 2024 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710573164; cv=none; b=MtMdgUEx6cIyWKDtfpXxW2JGkg1RaRxlvMpOVLgdZjFZB507TWNRbyAItsbDanuFlUpVr0GieSVYxkAu33zg44tLBz4y+qYZLn5T92/1DPtssRVPUxL2dS09S1hCrdAVqMUJtsIH13xrdLhMjZtMpyTbvuUUPZOrFnv9Me4lXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710573164; c=relaxed/simple;
	bh=/5ZaAmi9nAP7wFQdsTcx2bMbReW10EESIxEGYAjvzeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSc5Q2ucCdjcL2xE85tsKVnFPO6iNdz5QSDMn5a59PEDzfR8TlzvhQW/eh552vlTppJyds7+S16j+LtYqOrtcb89F5nZVdMNuOuI3VAkSQuMLOzr6+3BzIAEtXSgZemvaXK2MRXxHRm6Qq5qBLWIrx2VkHzG/eweK6Av0dyj1/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifDm0Swl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso1581007b3a.1;
        Sat, 16 Mar 2024 00:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710573161; x=1711177961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WfTnsIFEuG8lVPtUR0bn2tpdb2JUvvKpjMk2+P97Ks=;
        b=ifDm0SwlXfBAvLgSSdt65j6I5tLz7UxVXGh/jBSuyNgh1EzbTlz9OOv2POdBjKXnFv
         x7MZ9+t8Ka0NiNhKPSxwAr6enucXg4FFJT/33CBn1/vzchQtfr49bLOFvZ/tSMyAXXBA
         gucH+9iD06cFgpGwxaCfSmiRxjRnwsfAU/Do+hJyrbrzDSYPxJOv5GiAKfXrj9nlAYTL
         UXkNS/c9uWypUoAwbt3h887luahQ6t0Pd/ALlCJPvoxWm+Llg349IWwtJk7gJdXBk+T/
         Ex2hkl5JZZkpMNlbCnd1FD5C8A7yAo+6w+qcUNNNpLQbG+XK9xGx5NSATQ9noBJQ8F95
         +6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710573161; x=1711177961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WfTnsIFEuG8lVPtUR0bn2tpdb2JUvvKpjMk2+P97Ks=;
        b=BXEXef9R54nHEA1N5sxZPU3zJUVWAkV9S+84Fug2g4SxptRSdghuqWX/j0WmYBmoqh
         9ZupmZwgJamhurIVudY4XwfMgxz15WV2Gj66RlOyGvnkaY/GvDDMV0mfxkjUTJdNtCh1
         TDcqN+nSDu2/nyMHOfQ0IP38R7k6XprtdAuXw6gHw0qTNVAt2V3J/Gc8ilQ1yCHMoSN3
         +Hb7b0WCy0OXf79pZPGY5Vf/phiDNepklp8NL80YXRD7badI8QGAn13D2uLbvF/pfjDc
         MvGvjONRigc61p+vO7rQHJzUoEfRpHxQ7d/3Cofk3ImVHXXAfba+4pinjVbTg9q0hYGv
         4Dwg==
X-Forwarded-Encrypted: i=1; AJvYcCXp7hvrLhtI6SJi3DHumyctkpIL4BHdDl7l2mDQ8RSV2vschKDHUVmoQ4NPP8FfD7gAb6OX0ZD4Dz1bWAnp//n9FL4wkX/Gw5TPC5nihZ0QAyaq707hIG4v/H+dJrwSwF+faKa3C3KOkPU=
X-Gm-Message-State: AOJu0YyDTWtzKjRaesteUZAh7R+s6XCq1mwrRGNbxjyZBAaS1IBkRckA
	G4oFvDRE0RIOlbGEi+SjdhfHKjnaV0KiqvNUhuc+MPpjDGc0Q+gdSeW1Jms0jbeiFg==
X-Google-Smtp-Source: AGHT+IFL5CgUsQN+Z1dVTAuRhw5i9MmY2cG5v18vyAsPVCoaLVoPGrjaT+eycv7n/u4Q483kimhe8Q==
X-Received: by 2002:a05:6a00:23c2:b0:6e6:66b1:654f with SMTP id g2-20020a056a0023c200b006e666b1654fmr8829865pfc.15.1710573161198;
        Sat, 16 Mar 2024 00:12:41 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id x18-20020aa784d2000000b006e5a915a9e7sm4574651pfn.10.2024.03.16.00.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 00:12:40 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au
Subject: [PATCH v4 1/2] arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
Date: Sat, 16 Mar 2024 15:10:59 +0800
Message-Id: <20240316071100.2419369-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316071100.2419369-1-liujianfeng1994@gmail.com>
References: <20240316071100.2419369-1-liujianfeng1994@gmail.com>
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
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 87b83c87b..2e411c80a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -646,6 +646,26 @@ i2c0: i2c@fd880000 {
 		status = "disabled";
 	};

+	vpu: video-codec@fdb50000 {
+		compatible = "rockchip,rk3588-vdpu121", "rockchip,rk3568-vpu";
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


