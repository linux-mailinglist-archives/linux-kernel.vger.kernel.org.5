Return-Path: <linux-kernel+bounces-51196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811F8487A5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5406B2616F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DB060892;
	Sat,  3 Feb 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Thr5BXqE"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847E605BD;
	Sat,  3 Feb 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979245; cv=none; b=YQcTK4papG5CkMn8gxxTBIN8LANbUP4AXrIem+F87b6yxx3Bh+P0o8KJVKKV9D1y5mees1QAtn0Cs/7HVNkaBkwaRzfFqpH2Oynq0K5a8urOqTQByWB/zGawm+SOgajNUWCYNK0hUzrt9Y3d6FqjPZacKRkfjaPhEiIW4UqlqLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979245; c=relaxed/simple;
	bh=fgIPsj/1tK70Vcv4WrE/oy6r2RXF2E+B593o08QXYTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBC4RVJoqAQ58NsUY+/Qgjx5qMUsn3i3FacNXBv6nbge8jlkCFvYO21lEoDjyfVHBvdYXVc7Y7ka+gwe1vcAIIpFsxP9pfEi8TB/vEWtSv8zAPhRaPW8rkpxAFiBo88/ThXzZ5bbSU4upsKZana3MPJz7ZRKpCSa/L1yT/M6eBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Thr5BXqE; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-363a7ba0b8aso10111755ab.0;
        Sat, 03 Feb 2024 08:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706979243; x=1707584043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtGhKs15Hj8i5RJ5ho6JwLU0TmKEm52r/T9AweQyD3U=;
        b=Thr5BXqEzrub8S2Xud2TNmJcxEq1fga6ZC7TTkvXgS36zf/4LgU1AHgVazmQKG1PUD
         2nMwjO/G8sSJQvhbfFb20L66hS9Qa4QV5z299CzuUKSqjz++Q5X6VQWTSVqxBaVmvw6G
         8oeR04NsqsQ2c08y8tl+sMmYj1t8Zj/Mew05Va/z9oJ6aR5+w/YTVo9uug6Si+T9OKjD
         4F6OfNd4ZVb/oz2tPpE1Dary/uarQtkUO90tHgc8mTCBUbNKNyTnXtAMthbIT6GSryQe
         hCxIyl5FV4L25eMyJ3QOBBRAFLuJmbTJxXfZt5/UQ9iKLAfoiY2g/Ye6ycX+QYLFfZTR
         AELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706979243; x=1707584043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtGhKs15Hj8i5RJ5ho6JwLU0TmKEm52r/T9AweQyD3U=;
        b=oUhhxZLm7pNhlytUadd/sqm/8nithvkEsKdjIKwFZinSfCmktqctLysTBtxXRndD8x
         2h2+JZx188pEWkIQnLYkslHOsQoqFyl0Dp64y4L67R6oCOese91RmHEflSPQvZ0MBRB0
         fqHakKKj8ut+BqV6yRsu6LbsybAtMrCphtZUpwfcwiKRxj7m+XtQkHrZK3qYb8E4Q4e7
         ELOQnSHDOcopP5elj3czN5rNa9/wsw/i2+2aQZWdj6G8J4w/kPAxDWjz3JI+HeK3p5Jm
         9pDEi20xdL1ixAToTT9bEvR218vFX5l173wnJnIsWHO/BiefnTIlVq6aQVZ94wOF/wCo
         79GA==
X-Gm-Message-State: AOJu0YyWJkPH7KH4otBJmS5R3lFwEaaxNjmIP8/VCueHMwOZf3IHiL5e
	InMzQ99/zZ8JeL5OX8lbaRK+cLjoCvXPvW5Zvkr+F3AaqXDl16vD
X-Google-Smtp-Source: AGHT+IEtUlUuWsf9Gbr9GJbRlc1FEcGkrsmzLVx90UiAKNG3C5GbacaJqKTLB3V+VnaauWFjXUN5Nw==
X-Received: by 2002:a92:d3cf:0:b0:363:81df:3d3 with SMTP id c15-20020a92d3cf000000b0036381df03d3mr5301076ilh.4.1706979243145;
        Sat, 03 Feb 2024 08:54:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/UwDB46wLoYIFz3O6l5HXVdZUTuSGDGGNGDOBmA1nI1v32qlpxeuKPfkKPapsxAKPEyV6GPHaDnimTNr3DbJrYuloAkEnRbdSF2fb4CuRVyDXSHYK2eHAj/DTf82WRn6QOBFR5iwj2elDQNofClJ97c127Khba7hPCHaIlPasYNq2qlgRpAe3cwfen4EiVjlNaH4EfMYkZWjk/HYMl0zDZBa/UgXs6nqfuXwFARAOWRxFGSFfyowwZVJF3kfGTotEIkCx2VRUu5lOCSshBDa2s1TZVeZklv0lOBCQgeq2YYhVWTR0bj49etVariQ5188+WbNbo6s3wS0WDD27C7xTyep7AKf1ozf5xpunMCecoMQIZdeooVqkuvOeAarWQ6LbtFZldbUz1p4tfaiY/RL+R3e0HKdB0SEQfup7eprMSVdd2qtIMqi64bzq74UM3/P4HgBRcZlf16SZeUZ8oGeBnGKvp3E1GToJqiOk8A8K9SyHSsQXKJX/rVYQ/tfwLPDt3RTCtGUJZ7rmlNxDJXZu5etd7fWDAcCIJgiT3rXAlT4YRnFwWtdICYcfItQokTzmrNE5QZXYdSP6oc2uAkMUfqd2rYHvSzQpoi53MwL+SYArEuvYM5+ePpPj0XleBmwr6Q2aWPhEQiNFbT0UJFo9vkFus0VAOYDq4KJSKXXDvtp03Q8q6nfhzdIbf/ty5SeTXaiDo7vGDKgOARera2E+oLcjiw2QSr+7HzADqONxj94o8TWoUIjFN/+o6mvZbmaT5dwL95LBBD48M0cEGfDvHAF9Q6eaPC1CthonwR93ceLtw5fmr1u4ReEB9ENscdoRdfFjzMp26HdZhHmF7Kwb2AVHcafwsOLyjSdRUgGR2Ystz8uLQGuHxLwwS/pViR3hkiRxruq+4cKnGxmOnLyOgIUOL1Z93q2KFjHW9hJ9d0ntICMUPEbe4O/xrJzko/4NAo
 zKTMm/HRtldmfyvTUtcKEXGp1JpMp5rUj4zBHe5CyHWYwb8SeNSFH+sXwQPOBCSupIPgOw3CnTspR5lOggwYfaNWyhC7GD4aoUU0Irb4Dj7KPDYSGx7gRih9Mw4rrejlDGk57IACnM1O8zQE8s/o48ubKXEXq0CzXFZbAioDyJSkJ4R4u613NpycCar9bMYqVgC10=
Received: from aford-System-Version.lan ([2601:447:d002:5be:d9b2:bb4f:5531:6aa9])
        by smtp.gmail.com with ESMTPSA id t30-20020a05663836de00b00470b29b82b1sm1086256jau.154.2024.02.03.08.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:54:01 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	alexander.stein@ew.tq-group.com,
	frieder.schrempf@kontron.de,
	Lucas Stach <l.stach@pengutronix.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Liu Ying <victor.liu@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V8 06/12] arm64: dts: imx8mp: add HDMI irqsteer
Date: Sat,  3 Feb 2024 10:52:46 -0600
Message-ID: <20240203165307.7806-7-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203165307.7806-1-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com>
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
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 5c54073de615..5e51a766f3d9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1399,6 +1399,19 @@ hdmi_blk_ctrl: blk-ctrl@32fc0000 {
 						     "hdcp", "hrv";
 				#power-domain-cells = <1>;
 			};
+
+			irqsteer_hdmi: interrupt-controller@32fc2000 {
+				compatible = "fsl,imx-irqsteer";
+				reg = <0x32fc2000 0x44>;
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
 
 		aips5: bus@30c00000 {
-- 
2.43.0


