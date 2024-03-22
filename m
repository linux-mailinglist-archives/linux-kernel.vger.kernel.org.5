Return-Path: <linux-kernel+bounces-110954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7961E886635
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E4D1F244C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BBD101C1;
	Fri, 22 Mar 2024 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl3gClSV"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44A4FBF2;
	Fri, 22 Mar 2024 05:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711085391; cv=none; b=HWaT5aPwY/N3rVde0Xm8p90t44GnaDokEhUUfoMoZRNkHYYBAsJQgkY64jCpfQJMHj1RyWAM4wbSmz4utTAX/Me+s3vm/gRgR4RwKZwYm9JEGtNfBvq0OFSNXvCGZq2vxf+vw6X9eXosPHitiFi3Q/hl2NyasmOxsS7D40Eh0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711085391; c=relaxed/simple;
	bh=pdeOuks3LIs3Mh9ph/rGzJ+Io0OhwyHsCvVWeoBP/6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yt4gJiZBl0jwhetG7KUQjWO013mwhFml9p4iK/lIboo7dY/bRueKr/Tqor07LzCdu9WOyTiV/sdYpDY7nNL8sKlM0+vKl3BeQOXTufJX44QcFWnpPEhBQ4tDxG5bPWBA2elYZn5QhNotFM2l4WBbQyZU/3Zhytf7O17xWjzMOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bl3gClSV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e00d1e13a2so10274365ad.0;
        Thu, 21 Mar 2024 22:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711085388; x=1711690188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nQtnYW8cekda2E01DVGVjSk0pOF2YP92IFRmmPrICQ=;
        b=Bl3gClSVwlVkpbF0gV8e4tw6MU27TY5MlCCnKiGBbFMqldqoyPWn6LmqzsYcamaXra
         HgNqQlwuFPsF69T/01pGUsx+/Et/hXGbBB1qJ2IjoEWajvg2SRgW5GAdDvDAg+ilRCsO
         frbaMYSUMLS+f6bFNTfHW27u+rTv/It2DaDROJXO6mdXHJ0s/dUQd/KfVMkAAUeDpCKL
         EoUinoXJ1k/SB+k+Pf2I8QUnip7TdnckInHkXNUCLYBQmyCEazxjoitA2RUI6EeRGscL
         frs12L9Kh3VVIxvt1pCKAVc7h5IMi8x0tp4Jjs9peTipkCIKAydfqeGaxW5oxlgykeVb
         Bw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711085388; x=1711690188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nQtnYW8cekda2E01DVGVjSk0pOF2YP92IFRmmPrICQ=;
        b=IMKXDb9c47yOf9x45QBVPEnpfKymz8w8edoFq3ayQnApVq7TCfxuY+NvUeZ87VRqiF
         WLXw9MUCoLK7cy11aLEVapDiZsvRMSeDyU6Myz1vkhzrbJXzUehBLYK1+j6FKm0spwEt
         AGBJ5QC8XWfSNKvQ4hSFdiM6mJwQcs/5Tt93Ru2wFyWSNt06hguOO0g+kgsafVUmyuBx
         UvoXo1PptISRzzw8aYdDP3aRnBC0DkXGW5LanWFlHzteZLd6qVoskAAg4fEowlOKJzxs
         TgrdZmG25sbNF+FggC2aZRh2uNgqOr8EuReLkTB1BzOBpFqhdN0hzXrNA3kclPTRsxb1
         nG/w==
X-Forwarded-Encrypted: i=1; AJvYcCV50TrGZeJAqhvQvZkEHyuUbnBMWH6KhytrmgQYwSSrPkLrOhWowjQTQ/j+iT56fm8Ekg6vxzFRrxfqne0aUCbXhno8KXN2H4gfpmT3AUtYbqVJM2OjtnqS/hCiGUmyraGQnUwh0QXD9hg=
X-Gm-Message-State: AOJu0YxjVuDTmCX4DxP83DkfINrhbGKX5YDWkD298x9nOY1DNwirQo/4
	PBEfikLIBYeH1kVyn2H00nInhGRIAHWzLjEoNtvnFR30B42AjpskStoFwrqkI2bk9Q==
X-Google-Smtp-Source: AGHT+IGWRWK0tGZwBaGff9HXSl9tVqTjf0FaaPeLL1/J/kZHM6H1XF3+uirsjSMrdpkZZK+QcAFgFg==
X-Received: by 2002:a17:903:2450:b0:1dd:a50c:1fdd with SMTP id l16-20020a170903245000b001dda50c1fddmr1873946pls.65.1711085388034;
        Thu, 21 Mar 2024 22:29:48 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902d38500b001dffa622527sm882978pld.225.2024.03.21.22.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 22:29:47 -0700 (PDT)
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
	jacob-chen@iotwrt.com,
	ezequiel@vanguardiasur.com.ar,
	mchehab@kernel.org,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au
Subject: [PATCH v1 2/2] arm64: dts: rockchip: Add RGA2 support to rk3588
Date: Fri, 22 Mar 2024 13:29:15 +0800
Message-Id: <20240322052915.3507937-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322052915.3507937-1-liujianfeng1994@gmail.com>
References: <20240322052915.3507937-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3588 also features a RGA2 block. Add the necessary device tree
node.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 87b83c87b..8f130177b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -387,6 +387,17 @@ psci {
 		method = "smc";
 	};
 
+	rga: rga@fdb80000 {
+		compatible = "rockchip,rk3588-rga", "rockchip,rk3288-rga";
+		reg = <0x0 0xfdb80000 0x0 0x180>;
+		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_RGA2>, <&cru HCLK_RGA2>, <&cru CLK_RGA2_CORE>;
+		clock-names = "aclk", "hclk", "sclk";
+		resets = <&cru SRST_RGA2_CORE>, <&cru SRST_A_RGA2>, <&cru SRST_H_RGA2>;
+		reset-names = "core", "axi", "ahb";
+		power-domains = <&power RK3588_PD_VDPU>;
+	};
+
 	spll: clock-0 {
 		compatible = "fixed-clock";
 		clock-frequency = <702000000>;
-- 
2.34.1


