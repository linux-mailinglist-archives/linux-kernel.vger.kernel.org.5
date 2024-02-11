Return-Path: <linux-kernel+bounces-61020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACED850C52
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F7D1F25E06
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996CE17BBF;
	Sun, 11 Feb 2024 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8Jnfb+O"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF42182CC;
	Sun, 11 Feb 2024 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693493; cv=none; b=pLnK/t1UjFbN7/HY60H8ruKJv741AlS+Slw0vxbRZSZphmioOH6IS5/NYi+yTQe3Ww1xzFDiLNLzkAQFImZ8w1yoe2zygpGvI+WCAe/YzxpHwKGKK+vEtpML544s0Tk1EeAxiX8Rqa7eqbMw5NDoqcefRD/nx8t0iO9mx+LaHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693493; c=relaxed/simple;
	bh=5LJw9tbUFFx//Doz3YDQi3OWMiWP/7Qg8Dk2LX8C2lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oly1ZjOq2QEh0O+sa4Tz1fFHXDxMy5L5vyAdi/7LjVkIoFBbMpS2Ol8rhsTKaiv5P/uk+N6BZckwmnuu5JwS437kQTTLx/QKF8/Ltn65Xo+7ukkSI3wlb/CV6X1Lgwg2zxqqJ4cGO0Vz5Q/dnCVKOHx+tDaYY2vyWKtSudS/pSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8Jnfb+O; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68ca560ecb1so12453136d6.1;
        Sun, 11 Feb 2024 15:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707693491; x=1708298291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EKPHC7eRAxe4TJwvAVqqhtu+JWvDyGiDsI/tK7iWepo=;
        b=F8Jnfb+Of7d/Ectqbiy5IEZmv0kpiOzG+nEP0hwwWPs21qWkBGvvgYx8ETyRElBZOV
         /y3rp7fT8hqJursqk7t2EFE+aBOjs/xrJ0ifaHeVsS3XbalvFTVHxbjjVQHTlpesuoMe
         sCRBVaT4AM8rpLHPfaYBu+2G+/q3JlvGspbc+sLuGzid/6Qz3PdEE2UkV8VWFkXLlvOd
         OxoIhc5AzhUHrvurAW4fiF+D5qvfQNfX44NzS/jbEzMHBiEcwLRCPP0M2DpYxlgikQll
         Ug6l00/0tUlDob1MfHSejG1ydz3KMN3d+WGCNz0ZAdXICMtCONOezm4ji9pcbE34dmOo
         lGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693491; x=1708298291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKPHC7eRAxe4TJwvAVqqhtu+JWvDyGiDsI/tK7iWepo=;
        b=tNUW/skdAv0rwiJ9RnZ1GfdS9mv6pO5sW2II11AEmS4iLHH3IPio9mK0n2H6t+i+Sf
         LZdTTdDRc0s+obh2o7zCmahbjOSK8EmgBPAd90s72q2SWH8yePKE+wpht7AFM2SL/c3b
         5S7eY8IsdLELJS4FB9XFv/499WZSm1p3/8QrzefkW/MwwrfMwiyy5gCSScGfynuW6G8U
         lKQXs05dI4aPQBLPwOviD1BJUxsO6mPt4CuCUFzk2t18wiq2FSbbO9XbHlc5lM//E5hx
         TQ0liGZ9skb/Uvld0fFHK1SoeU1Sra3bce8zE7wXW7eoKrJtiTcHVdoRxhBRtixlTDi3
         N5sg==
X-Forwarded-Encrypted: i=1; AJvYcCUTQ797G7trNM4u3LaKkt0NIwwOhjbZIearmU9JESIeNpIt11sMZ/DNiw1e6W3I/98XIuOuuZ1YwYarzgt9qQ8KeeVQG7RtIvCnynN/IBowp0RP2Ksz7I983jNselk686fkHZ18l0NTTg==
X-Gm-Message-State: AOJu0Yyqpt1pq5U9IjmaUyxgqIWHc+IOzEuInjfgu2Pfqk0QPcN7sK2K
	V95+eYcAoF2rRML6THfb2Ivu5Ia+llOMDNRSnOVlXDWB52K3vn8o
X-Google-Smtp-Source: AGHT+IG5GkWmFyApwglImpGkODWzlv/SxnRxN3T+I678W5JF6ed8Cti3KLJJ3FBFM9NpHbVvQQoU0Q==
X-Received: by 2002:a0c:f0cc:0:b0:68c:50a8:9 with SMTP id d12-20020a0cf0cc000000b0068c50a80009mr5547570qvl.44.1707693490972;
        Sun, 11 Feb 2024 15:18:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJUtfM0FPkALPHeEaWJm+uECTsiu5AvBA9rS/JiyTmwVj3e7wzHIldKEriLtWbEH2HDPBtravzjdzczaNIVAIRMUfETkX/1Py7auAvj8FgaYM200IuLi6W8OtAd5VUTHvzRVzUHeUNNlXqbDuOSn/TQ6b8AwCokRtA+aIbE8brSysRD9XJEnP/7onlO6JvSJynWCDZIV1R+bP4z3SWCI2WNhfj2iDGA65OyDMaGUtYUFMha/1GsGBKasgzzPP8kcdDfzsbYm490Z1SiJmoy0fImNjMV0Jr4sbTtMuKh0jwAprZ9p6FE++WMie74NUjLoBsosqOPuldIchmiNBVTYb+GAw6Blpb91ScGAPqhq53o1dEvoJYD8KWFGfCoAwgCZEX9+GlYKvBxV7hvomc8au5CNkOP7QhxaBxCwhpg0qdTdDPKyRU6qTP/Qo=
Received: from aford-System-Version.lan ([2601:447:d002:5be:c8c4:8542:9142:2184])
        by smtp.gmail.com with ESMTPSA id j4-20020a0cf504000000b0068c80f69ce8sm3106982qvm.142.2024.02.11.15.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:18:10 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mn-beacon: Remove unnecessary clock configuration
Date: Sun, 11 Feb 2024 17:18:02 -0600
Message-ID: <20240211231802.188843-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 8208181fe536 ("clk: imx: composite-8m:
Add imx8m_divider_determine_rate") the lcdif controller has
had the ability to set the disp_pixel_clk rate which propagates
up the tree and sets the video_pll rate automatically.

As such, there is no need to define it in the board file.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
index 35b8d2060cd9..bbd80896db96 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
@@ -99,8 +99,6 @@ adv7535_out: endpoint {
 };
 
 &lcdif {
-	assigned-clocks = <&clk IMX8MN_VIDEO_PLL1>;
-	assigned-clock-rates = <594000000>;
 	status = "okay";
 };
 
-- 
2.43.0


