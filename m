Return-Path: <linux-kernel+bounces-162996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EBA8B6321
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A621C21AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015DF14265E;
	Mon, 29 Apr 2024 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tVRWTzwk"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7C140383
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421086; cv=none; b=csUIouVIbjIwkTt3uPW5pOC+BBLiSZLk7F3Nd099rAYskDfDCv6JZLmM31FEvkMV61gGIil83OZeumCrRy1ZTyCz+9cHU1OVM2nRvZUatnOtsizv8NIah1CuYiWBgJsMkOslUMlmQ8OHOspQaSBmBaGqtkLz9hc/NU1i4r/ftrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421086; c=relaxed/simple;
	bh=13Fr4UEwIC36RkZaWaqe5teByY2xo8qLUQtGfXoOolQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YdQfB6HlVwC38jZKmlYKeYYVWfmvGjx1DXDLHHrIgPhCcvftTGwMc4fil0P9cER3KVH2GKs6FV1lDaMoLfCUAvtmEDhIa3li4zY57l76AcUUlI4zZpAq0DYSQx0OMWrFh2g4gk/DfMDWyTS5RIxjQ45OyqqmgvQBvrc/UjI0xrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tVRWTzwk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a55b93f5540so663218166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714421082; x=1715025882; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IW2Cb8PzWQGoPtLIM4Yb+ZUUwep8epdxp3AM6wmQKqM=;
        b=tVRWTzwkPhHfvA6ewS4smjKPvB5zj1FuvMR/zH8zi+QVUYOHAYuehtWKMRQEftIq/f
         m57MbMAdE6qjwukAXdudX/yiKyOED1uGhYcpu8qgqcIVJFf0VvK+Pw2g5aC1moAtyrpD
         fkdgxvcxb3GqqlcW3elPEH23cGF3FQ5IUZxNOJ92ftECeBarVjMs9AAxVNGV+pxU3jaV
         JKv0lp/IBe2AkfOex/Zdt2p/f0FdZzzmr1f7eBtJhUor892dVikjhXg6se2ZLyfAT95P
         goQJxgr1+UrYZk0cLSwf8DKcE88vBhOzDvFDyIGSofDhh6oG7/Ps6EblLI3nGhXonsz6
         9ZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421082; x=1715025882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IW2Cb8PzWQGoPtLIM4Yb+ZUUwep8epdxp3AM6wmQKqM=;
        b=ePc3cCGQelf2ZtWfWAcL1KErUZr2qpZpO3f8E/e4bLnIOtqrVbD7QaxTVVRo1aixtU
         /lhgHUMqLSiIJCIMurbB0tL9ZOV7bW0m4xjnSk3iMNo3VtWT/pzevxoo8NWYvGh7pWrN
         StWYPjvSemOixX5UJUwB5sQWfGnuol8vXvQ9XtmKr1Q8zfjMiCI/GGWmGKZmPsoJxVE3
         zHjvj2ko1ngK9LubiAiKdkZcVuP6bFs3SCEtbsRKT1ZSERu8t8sC2CGSkdlfCDhqK+m+
         NLH/8ZlrUqtIE9ri88PoSVyJvMBsjloDns7I7ry3JfY85xMrf8HKfbjkF5HdqYUPZDVG
         TTgg==
X-Forwarded-Encrypted: i=1; AJvYcCUj+a388Hse/ansZBlNsUG5sd6nvUg18kwWOVZ+VEnXsBI4ijmXlm+zBEgLHU+Y501/MSldjvjP+RQtxcWwk55CeGi9AzNWEjjkU0bb
X-Gm-Message-State: AOJu0YwFgXPrhL796s6fNwTZjJagVyGUv+ipVlhcAP+SVnpBzhx0sXD/
	BhxuCgi/60qi38MpL0izilgqhW+caBYIMborGS3tHmMnPbctnytdU82UKsLB0BQ=
X-Google-Smtp-Source: AGHT+IE14D8OoNzwAbKSNbb5L61qf1k+kwXM1y+Y2LualqXyLuCm1k7MomGB+iu8DonSoJQnLykbpQ==
X-Received: by 2002:a17:906:1283:b0:a58:e4d9:618b with SMTP id k3-20020a170906128300b00a58e4d9618bmr414644ejb.19.1714421082255;
        Mon, 29 Apr 2024 13:04:42 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id ld4-20020a170906f94400b00a5906d14c31sm1140887ejb.64.2024.04.29.13.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:04:41 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 29 Apr 2024 21:04:39 +0100
Subject: [PATCH 2/4] arm64: dts: exynos: gs101: specify bus clock for
 pinctrl_peric[01]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240429-samsung-pinctrl-busclock-dts-v1-2-5e935179f3ca@linaro.org>
References: <20240429-samsung-pinctrl-busclock-dts-v1-0-5e935179f3ca@linaro.org>
In-Reply-To: <20240429-samsung-pinctrl-busclock-dts-v1-0-5e935179f3ca@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

This bus clock is needed for pinctrl register access to work. Add it.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index f2c7c2a4ce1c..8d4216cbab2e 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -370,6 +370,8 @@ sysreg_peric0: syscon@10820000 {
 		pinctrl_peric0: pinctrl@10840000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x10840000 0x00001000>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_GPIO_PERIC0_PCLK>;
+			clock-names = "pclk";
 			interrupts = <GIC_SPI 625 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
@@ -914,6 +916,8 @@ sysreg_peric1: syscon@10c20000 {
 		pinctrl_peric1: pinctrl@10c40000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x10c40000 0x00001000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_GPIO_PERIC1_PCLK>;
+			clock-names = "pclk";
 			interrupts = <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 

-- 
2.44.0.769.g3c40516874-goog


