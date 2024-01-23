Return-Path: <linux-kernel+bounces-36031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CB4839A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A657B2433B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5868418E02;
	Tue, 23 Jan 2024 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILAYXPk3"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1384BEACC;
	Tue, 23 Jan 2024 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042178; cv=none; b=G94bAzC549EuOVQDIuhg5Cxkgmex5oTFS7ED6WWDD2zkRHTDBrvj6U/dX/CTJhOWh5HDa9jMsSCZ4OT6aGFyzYpNI0Ekcr8V+vPowuPJ9hy6fc7Eq5JHsnaKkBRe1c+gsAB+Hfmttn2tyrv74kAauff9Ya1g+vzk/cXNKpDuBlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042178; c=relaxed/simple;
	bh=R8nbQPilcuK/zTa/Qd5mtxOQqvhrM5GRqlCnYSJHc+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGltZks9RuXQ5OFWeF6nOP3jR0qP9n0XWaQnpcB7R4URiTLP5xjbFDjtEIeJKqbzLvIdEl326fky/dcHsuIO7YCbBMIVkCssKen80IIQFJte0Q7UHYx3ih0PwHUo4BQ+829E+SgdVBr0jhsx3KMEp2B3aqzBEYhd1yOXQE5uHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILAYXPk3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so2831615a12.1;
        Tue, 23 Jan 2024 12:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706042175; x=1706646975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X9gXtJ2jH9YgV610FJCPLMZwxMN7PK1ETxRA0Am1hs=;
        b=ILAYXPk3wsuilV3WtbMplrOnHzHlpMFtwuuXPWj3CrndzaCKTgM1dGgw1U7ubAuCvU
         NLFkDiMhDNx4qaJEMCdbQDv2XCJ4vpf6N5u9QpJGxg+QRxU9HKEiU0pA/Iy+QvPKYueq
         dYN7JJXCF5u/4AjJ74ktAmFNhp5kdcQuVZAEjZq18fAc2g6ZYBSqCOx9TFz/t481/JVS
         wlkhQkmZAU1DHybpKnXBMYlKq2fNAFuF50raYS9mM5PgZ6rIfcC9Jn3vdm8/DSUZ63D8
         E7BmYRgdYdd4a0IVxBoHNSoY3Z305IEe/siRsuKi1MYjSnC8hRnSLbtdfy4/+T9VVEwz
         9HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706042175; x=1706646975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X9gXtJ2jH9YgV610FJCPLMZwxMN7PK1ETxRA0Am1hs=;
        b=dKRHKhN/lLyp1+g22GCFlHM8IamG829Ei+rqXxhtiv3zFglhAyTUR0QLfM+sB6ZzD5
         JqTZsI1S6Qo4vzH4Vc4KCoz2Hu07VkYGSQ1S0t4tift8DEo2sNOJEkJrsdWdgxlCMB/p
         BWw2Oa8/ZATexen9dmDgZ9fruvED8b9QC4yuBArTIWV9A9/DyS9uPHcDEI6h5rvmKgnv
         lBBsuemKvlkb0Kv0PWml3RwnRXFiW9Au7GDT7jPTUr6PUGlhpGsOir/iI1PLEx+FL3/m
         RDy0UKQpcfmRh8P9hPkpukI9FgefdM76dCIc3cb89+WsKN6kf3dvDAl5JAu6pLCYhrtM
         8E+g==
X-Gm-Message-State: AOJu0YyUsQ7Vb/EYoEDMZ451qBfoLWMPSBMu0KhMPkC5M1o92pe0wkV1
	lTOzgFTWe6mila9YHE3yWb+FrFZvENyNEf+hVZBLrZmkyDukyfhL
X-Google-Smtp-Source: AGHT+IEBud7qVwePH3W33ERffWKlSW8HhnW8wAGuWlzwewouDmc22jxeuSBnxaAX31sX+yjIkZP3RQ==
X-Received: by 2002:a05:6402:2706:b0:55c:a632:7f85 with SMTP id y6-20020a056402270600b0055ca6327f85mr156487edd.45.1706042175168;
        Tue, 23 Jan 2024 12:36:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:aa27:2d00::d069])
        by smtp.gmail.com with ESMTPSA id h26-20020aa7c95a000000b005590dc6a4f6sm13227886edt.80.2024.01.23.12.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:36:14 -0800 (PST)
From: Mehdi Djait <mehdi.djait.k@gmail.com>
To: mchehab@kernel.org,
	heiko@sntech.de,
	hverkuil-cisco@xs4all.nl,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	alexandre.belloni@bootlin.com,
	maxime.chevallier@bootlin.com,
	paul.kocialkowski@bootlin.com,
	michael.riesch@wolfvision.net,
	laurent.pinchart@ideasonboard.com,
	Mehdi Djait <mehdi.djait.k@gmail.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v13 3/3] arm64: dts: rockchip: Add the px30 camera interface
Date: Tue, 23 Jan 2024 21:36:04 +0100
Message-ID: <11db20c1db566b79d751ef20d9416236f802f155.1706041950.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706041950.git.mehdi.djait.k@gmail.com>
References: <cover.1706041950.git.mehdi.djait.k@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mehdi Djait <mehdi.djait@bootlin.com>

The px30 has a video capture component, supporting the BT.656
parallel interface. Add a DT description for it.

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index d0905515399b..a8eb5371235b 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1280,6 +1280,18 @@ isp_mmu: iommu@ff4a8000 {
 		#iommu-cells = <0>;
 	};
 
+	cif: video-capture@ff490000 {
+		compatible = "rockchip,px30-vip";
+		reg = <0x0 0xff490000 0x0 0x200>;
+		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
+		clock-names = "aclk", "hclk", "pclk";
+		power-domains = <&power PX30_PD_VI>;
+		resets = <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN>;
+		reset-names = "axi", "ahb", "pclkin";
+		status = "disabled";
+	};
+
 	qos_gmac: qos@ff518000 {
 		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff518000 0x0 0x20>;
-- 
2.43.0


