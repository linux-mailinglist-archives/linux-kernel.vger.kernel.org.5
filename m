Return-Path: <linux-kernel+bounces-38069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A079C83BA95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E552897F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05830125D9;
	Thu, 25 Jan 2024 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiD0CLZe"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D933A12B8B;
	Thu, 25 Jan 2024 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167319; cv=none; b=BSIcgxaAAzjQ40D0/ytOK/azs+0e+EgEBVDEARTJvOvuXQM1sX61MR6EbwKvVG4eQmhoe3SyVTV7n1+uWOb9kiuP7W7apAIQ5vXiBP9kyADMvad/gkxGI1iT8M6exvR7OdVup8yRbGUJrmZA3laSRei0EHjnbfK2sUpGz1A7MeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167319; c=relaxed/simple;
	bh=o9E9ecVEg59roajJUTj0tBIXTNYmbmyw1ntarzjaXAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yx55hq76ynC80P7givKCvQJtKvRBVE2oankMnNMwsX5GKt4fIClC34HONDiFdgb6/uwL5vdfZybJdx5Bo2TjpwNoAd+9bFWcn4erTrbLFLFIONWmvXNm/aKJwE7OX7/BP9emliiE29fFhzEtg/ze7jrvQULEzjFlk4zhNbezAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiD0CLZe; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so7995460e87.0;
        Wed, 24 Jan 2024 23:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706167315; x=1706772115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qk5axihAKFS9+0dIUTMZ/jrL2YTkFropx3eyJ2mG6qU=;
        b=JiD0CLZehC+EyE9M7l3PfHStqEovN71UjUT5+Wq0/0IZXhJh2i0/P69juxYmLwMI1U
         akCC877PnrPb6yA86nhai3LyEOTUEAOYhabrQSJid/MVLO5gp3h93+x6CutXhXIghRwA
         pcHWREJ+GpZ61+HfonruPeBtju9UdMQi4xsbMvqZ7YUdz6QyXQqRay1pq/HJDZrO9iz6
         2B8aBpjxtnGaM1hYD4GfAmdrJDfgabqO6VGjUS0uhvIE3OdWr+08WDAYqv8EOxN9/s8p
         cLhwg/D6JoqQgrwmf6ZLiJ6t+hjYJghBiMOI8mp/an1p1gFvQSgqAoybsK+UFJuDXoKf
         KdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706167315; x=1706772115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qk5axihAKFS9+0dIUTMZ/jrL2YTkFropx3eyJ2mG6qU=;
        b=cQC1l5xxQeCIhOsbLAJqx1v5SHfQP844ZnGnkW5L1d72mOZYqiGTyTwyf+v0fd4Uio
         QfgRELzOE5aIEZ0iXFvDv9wzSXyxGxwM0Roj9LsYsUp1I0bUqf2APApu3MC7MvDjlNj+
         FA6em18daZ+x8GfBJ7vghnghoJ26ETiRfA1DoWqS71tRL/jkBK37eLRp+II6O8JXMDpg
         2AzTjv4Kb4S3mfWeZJnslX5YiHNycZYgEUj15fAC2uehUEcds/mG5ztO49b09Uyjh1WJ
         pZUl6uXUYcue8D2EnvRZFGFctYWHEPAxrnBUBcvFIkUX/5Y0Cw8aYwGeaOWEwXRkawlx
         OGtA==
X-Gm-Message-State: AOJu0Yw/BxeCuPUCx81kcAXmYCA/ONSPrXd0/lCeEBrm34G5SpgcL44X
	CgBbpY+Em7SK4RZnunSNfyFIP+4x7UlyOZYAtEKiAw4k///XUGk8hbUaRLJD+UNn4nQ=
X-Google-Smtp-Source: AGHT+IFTxwPgOv3/EtmvxxaaVICzQhm+m2RVQrsyK4AF0mtOzgJAMENWDpCC6bgpZ+U8d52vHyPnhw==
X-Received: by 2002:a05:6512:3687:b0:50e:8ead:3889 with SMTP id d7-20020a056512368700b0050e8ead3889mr182905lfs.75.1706167315214;
        Wed, 24 Jan 2024 23:21:55 -0800 (PST)
Received: from localhost.localdomain ([188.162.200.139])
        by smtp.gmail.com with ESMTPSA id x37-20020a056512132500b0050e75f9e8c8sm2780070lfu.98.2024.01.24.23.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 23:21:54 -0800 (PST)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	John Watts <contact@jookia.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v7 3/3] riscv: dts: allwinner: d1: Add pwm node
Date: Thu, 25 Jan 2024 10:19:43 +0300
Message-Id: <20240125072032.1151383-4-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125072032.1151383-1-privatesub2@gmail.com>
References: <20240125072032.1151383-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

D1 and T113s contain a pwm controller with 8 channels.
This controller is supported by the sun20i-pwm driver.

Add a device tree node for it.

Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 5a9d7f5a75b4..435a1e66aa6a 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -145,6 +145,18 @@ uart3_pb_pins: uart3-pb-pins {
 			};
 		};
 
+		pwm: pwm@2000c00 {
+			compatible = "allwinner,sun20i-d1-pwm";
+			reg = <0x02000c00 0x400>;
+			clocks = <&ccu CLK_BUS_PWM>,
+				 <&dcxo>,
+				 <&ccu CLK_APB0>;
+			clock-names = "bus", "hosc", "apb0";
+			resets = <&ccu RST_BUS_PWM>;
+			status = "disabled";
+			#pwm-cells = <0x3>;
+		};
+
 		ccu: clock-controller@2001000 {
 			compatible = "allwinner,sun20i-d1-ccu";
 			reg = <0x2001000 0x1000>;
-- 
2.25.1


