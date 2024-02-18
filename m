Return-Path: <linux-kernel+bounces-70189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB23685948C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15263B21C9F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F58CEAF1;
	Sun, 18 Feb 2024 04:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kma4sGQ2"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74178D294;
	Sun, 18 Feb 2024 04:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708229831; cv=none; b=jtJQi3Fj+duAREVRUrmAmT80XqXveFemZT/83Jbc59Yel4Y7yWSgt1Q6WIXZVFTm1b0ZxI/XTbuqzPKRIRBd5n66aN7jL37/KwMjI1kR72cwkFRZw46eGQayo7UQSmc8mUZNMZhRi9BOMVBxJmFXgpPIX18NNrioj0pZ/zVfVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708229831; c=relaxed/simple;
	bh=M3i1guTLpZh4lkgLxNaiu+dzmFgPJcWE2zu5EHpYswQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGx4oY5kqnky2+OrBcBC0ci6lnhO35Ca+z3tEc2aWvlfaAWTcg714bSK2aofTpa4Aoc/LhsoMElyWkIzi0mWgECUMLplsrK4RSBnWmJ4wd2Ea/bUB7qrGP6c659nIXgCwkxNneLVpi5SHH2wmQLbmNE+gMs8RF8Vd3YtxX4q8DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kma4sGQ2; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-785d567fa26so131919485a.3;
        Sat, 17 Feb 2024 20:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708229829; x=1708834629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TgNxlY3gvRRH7nZvWiloXYULfJ7EBapssXw7kKBQCg=;
        b=kma4sGQ2ibqx6Lwv1IIMu2YCz3gzLZEpwYz3cEO2BrSdlFU9yX2egUDibzGiyRHj46
         lYTDLfTCXeWdLhEC44l8rfknsXReI6Dn3FJ49toiWkFg0MeWXoTKdm3h5qIppsZid9qs
         kzdmsJfyfUWyWuiU78vat989K0Sth10AdfBzRy3WeVYKz3cRMxQX4089k3rDJRVEP3TW
         IELb6D9k4KAS/qsj926W6iT6m8gRHeMre8krFVTNRS1wtXYMfEAnVfI0nsO66MHnTxy0
         ri5cU5srBseMqzHwNpu5XIT9r9AmZUzhjXESlOXejKChRRlXcKnKwgWKykwrAPAZJjuO
         cW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708229829; x=1708834629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TgNxlY3gvRRH7nZvWiloXYULfJ7EBapssXw7kKBQCg=;
        b=e5MCch7fwlBIOD/auakrBpUoPQLZ6zF3aR6RmH2V9obk3TK2IKFiPwqdA6hVIszofn
         m3oJjdugg+7q2Uo+5eyhoEokL0v5AHqupJJCEPz/fHT3zyHYs7N9eQDA4RlP/PAsVyZb
         jBFNvPSBwwisU5UqekhQXmvmvc6lRLC1BlozdyaHydzNWiOsxklevS7u9uHMNGP3zN0I
         VJIZoJQ9V3/Srzw4+5TYtlcZoxRHwDuq4tRQJi6fKBtwOMSvT/0XxPmmbOLw77uAJGrV
         sJqQHrKESUoOeAylCoAqVoGWj9dV1upzzrwHliZcFi2c59hFZHSrRdHF4QjCAjri8NXd
         oIZw==
X-Forwarded-Encrypted: i=1; AJvYcCXFlP2n7rDWVl4Tdb0J+G3d/PAWfgv4ZFf2sL4L9ejyoLrUSPrJb+BMZ93b8IlBrLJoO+ptIRBDzfuN8B1JUYQROlLlIy4R3y9Y0Il10p30GBJACxBXVn0UAfp24HY8VosQA30GDFFuNA==
X-Gm-Message-State: AOJu0YxpN5IGOuHKmSq7la3/fIF97XX6OBwjVxChD1gS2Xvp3Mh2zt1m
	N8Wo3JtUgblmZvGS4G4JPVMrq8Z8SzPV/ISXwsosZDr/NUDVRAjK
X-Google-Smtp-Source: AGHT+IE3LTX6FdxcmywHLwce1/DIOjULt90UZD1jHNFOrPnlFwig8FEHTUySRtMSIIUiW/Ulb/hCig==
X-Received: by 2002:a0c:ca12:0:b0:68f:6be:9f94 with SMTP id c18-20020a0cca12000000b0068f06be9f94mr2698300qvk.12.1708229829221;
        Sat, 17 Feb 2024 20:17:09 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:dde9:2f2d:61e4:7364])
        by smtp.gmail.com with ESMTPSA id or31-20020a056214469f00b0068eeebc4656sm1713621qvb.139.2024.02.17.20.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 20:17:08 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Marek Vasut <marex@denx.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 4/6] arm64: dts: imx8mp: add HDMI irqsteer
Date: Sat, 17 Feb 2024 22:16:42 -0600
Message-ID: <20240218041649.1209173-5-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218041649.1209173-1-aford173@gmail.com>
References: <20240218041649.1209173-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

The HDMI irqsteer is a secondary interrupt controller within the HDMI
subsystem that maps all HDMI peripheral IRQs into a single upstream
IRQ line.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Marek Vasut <marex@denx.de>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
V5:  Increase size to 4KB to match the ref manual

V2:  Add my (Adam) s-o-b and re-order position under AIPS4
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 0730d4cf9bc4..cbb15ded4a74 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1927,6 +1927,19 @@ hdmi_blk_ctrl: blk-ctrl@32fc0000 {
 						     "hdcp", "hrv";
 				#power-domain-cells = <1>;
 			};
+
+			irqsteer_hdmi: interrupt-controller@32fc2000 {
+				compatible = "fsl,imx-irqsteer";
+				reg = <0x32fc2000 0x1000>;
+				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				fsl,channel = <1>;
+				fsl,num-irqs = <64>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>;
+				clock-names = "ipg";
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_IRQSTEER>;
+			};
 		};
 
 		pcie: pcie@33800000 {
-- 
2.43.0


