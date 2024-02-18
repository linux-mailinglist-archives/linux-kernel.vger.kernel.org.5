Return-Path: <linux-kernel+bounces-70185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60DF859482
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17241C21608
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8355B1879;
	Sun, 18 Feb 2024 04:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llY3yu4x"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1F17F0;
	Sun, 18 Feb 2024 04:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708229821; cv=none; b=MnYp4knUrbOKNNnXiJJCrt0/hkZXBbHNlJjKKmr7r/DqUq7MWzPHYz1u7MpuATX29eCLB+/Fn5EvxcnlGOct3xkUvbVpzH1tor58mVcxdRrz9NbUkDg22YcNDvPonsVfXgw8Iwm61yWvZooQCWIp5ZEFwm//QBqI93vy2Y/HNQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708229821; c=relaxed/simple;
	bh=GGwTQ7oDkHq/bblsAleSlBoacbGn7kDqsaeOU9UPrGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IT0JCf1gXC8DJYAPu9yijjpl+O3K5f0Ly0yUcPdr0Eq4vNUOiO8g5WKQV0tV0HRzwGInjmejgd612/u4XgOKbtUUGaQj3A6k4EyMOYp8THdzf/SOFTnqEBBr7WtASUTvFwNnKOetZy74Nw+1wVJ9X1n1k9Oad2uHleYKTlndNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llY3yu4x; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6818f3cf006so18572416d6.2;
        Sat, 17 Feb 2024 20:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708229819; x=1708834619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PunEQITxN6EegaLM3f1D8lckcVz+K5TsGj0+zF389Go=;
        b=llY3yu4xSYEgDd/MOZ9aCZe+lDEVAaZuB2bj4jmPY1Ynmos6dz+a6eL/4puV3ILpIx
         zH4+vftVRXs+5G1c7KczinSaJe031bssPCFM1SU5h+N/MV+oq6I/exjUu6Rtwvjb/Pcl
         DlZJsKwJRmy7traOIu3zrC2EntV6aALs3p+t/6zcc3/JNBu4J9yD21cFBWLTLB+oa6b9
         A83VKG1nuDZdXDTQpJPWSk6ToH7INbeCn+RYfJFp11uawesRnBq6WoAnZX2kSEEk52v7
         1jN7jizIULmAjVhxE1KNkSQT+fQHN1GYpw8ZXpwW3CqgvQU/mXyUT+l9KH42f0/2NZMi
         votA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708229819; x=1708834619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PunEQITxN6EegaLM3f1D8lckcVz+K5TsGj0+zF389Go=;
        b=sKZhojrKeluvzTM3B7jZfJ3miCCHGrvfBjDv0zb/UHmnSrvBcv+1tetjzkAf4QWr21
         kQa5aA2+DjqjM3tyYPaTPgvNS4A6GhHUs1kfQ+vu1mxerDWzK34mqCPxJNH4S9sbB/O5
         a1iWSPde52hFUxaN3jNDATQlwqCv1S6O7E1M2MeTI9WNo9z2+nWFv7AtuzajVzjroOuL
         Oe60yT6t26NVp4IfJoT9FV278/eIuyLrRqPvq9i3RIBp6xPmgVXP6ebKyL+kmdVEiu56
         NdSeSUo2RlAXpOOJVTZW1ln76RgWCtKrSOanFGYpLiTdOLqGQXzHHUxvb2zc8RrQbdLR
         JJnw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0sAR2P/BKmPYQz8HlM8eC7SMaOyKTjGYKJ1SNToZ6wexMBf+tpO4XaV7mnT1GA0nbS/i/cpzklQj8GgiJtLEcKOra9kuMAyRqcFtYUctGsVPg2y2zF3uyT6G4fEpo2JAQRWZVci84g==
X-Gm-Message-State: AOJu0YxVd2e5yCXvdwdLI2SCIv4w04fB8C8/56mILIQIhWlwQIfOnVam
	31VrZ44nDUV05WAtFuZnm/cl0ZUBQ5OuBBIYIoFiluqOs6CfwS5d
X-Google-Smtp-Source: AGHT+IFB4qqdJNluST8zuNqUvuR7+FTW5VakP8ZhltfV1yKAyDfYaAzqM7sUhqCRUrd1xL+ZGJnwZQ==
X-Received: by 2002:a05:6214:d6f:b0:68c:8772:7dee with SMTP id 15-20020a0562140d6f00b0068c87727deemr13105676qvs.43.1708229818983;
        Sat, 17 Feb 2024 20:16:58 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:dde9:2f2d:61e4:7364])
        by smtp.gmail.com with ESMTPSA id or31-20020a056214469f00b0068eeebc4656sm1713621qvb.139.2024.02.17.20.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 20:16:58 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
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
	Lucas Stach <l.stach@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/6] soc: imx8mp: Finish support for HDMI
Date: Sat, 17 Feb 2024 22:16:38 -0600
Message-ID: <20240218041649.1209173-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX8M Plus has an HDMI controller, which depends on several
other systems.  The Parallel Video Interface (PVI) and the
HDMI-TX are already in the Linux-Next staging area 20240209, but
the HDMI PHY driver and several device trees updates are still needed.

This series is adapted from multiple series from Lucas Stach with
edits and suggestions from feedback from various attemps, but it
since it's difficult to use and test them independently,
I merged them into on unified series.  The version history is a
bit ambiguous since different components were submitted at different
times and had different amount of attempts. 

The previous attempt I did used the wrong starting point for the PHY,
so this update includes a newer starting point with tags from that version
and fixes from various people's feedback.  I hope I caught them all, but
I apologize if I missed something. Any tags from the previous attempt I
made were intentionally dropped, because of the significant change,
but I kept tags from the newer version I grabbed from patchwork.

Because several items from the last attempt were merged, this
series is only focussed on adding the HDMI PHY driver, and enabling
the power domain, irqsteer interrupt controller, and HDMI pipeline
in the device tree. The version numbers are a bit strange since
these all got pulled from various attempts with different versions,
but I wanted to push them together as a series to complete the pending
work.

This series restarted at V4 based on the version of the PHY driver and
the other drivers and power-domain changes have been applied already.
 

V5 primarily updates feedback from the PHY driver itself, but a small
   adjustment was made to the register size in the device tree. 
Adam Ford (1):
  arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module

Lucas Stach (5):
  dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
  phy: freescale: add Samsung HDMI PHY
  arm64: dts: imx8mp: add HDMI power-domains
  arm64: dts: imx8mp: add HDMI irqsteer
  arm64: dts: imx8mp: add HDMI display pipeline

 .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     |  62 ++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 145 ++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/phy/freescale/Kconfig                 |   6 +
 drivers/phy/freescale/Makefile                |   1 +
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c  | 720 ++++++++++++++++++
 6 files changed, 935 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
 create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c

-- 
2.43.0


