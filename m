Return-Path: <linux-kernel+bounces-104959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6894187D694
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17F8B20AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0BA5786A;
	Fri, 15 Mar 2024 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW76ZLRK"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037154F84;
	Fri, 15 Mar 2024 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541714; cv=none; b=pGhqENxicpodVh4jvW6umfYdRgxEB1g3k7PhIkFwfAtdzIMgv8QUGGaDjXh/GKNt7Og0PjaJH/A5TejH+srd8g4+Kds7moFyVTGnXxxlfaJs8fwYfCNbiRVJBDz4OhVdvxdqoehNfiQT6JqD8lgKwCvNHb+ZzNqTDztEmgQrWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541714; c=relaxed/simple;
	bh=zsuC/t+XdTuI/DjTEsIPVcUIbRmD9P+ZPy8rJ5VJJMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZwedTSKHFIN4rNmpc1j3q9TCAdGf/4PwJU+FxVSNQaXKYoiH+DFy+0jsRLi+rvyooYs81hjyGQrAAWx+/Cuw639YZ5pM0XuKRSlX8geZjnJLk0fc1wRYFKe7rCJGyrMPB82SXHRn21EoPHROp4v58CgpviebhpB4so67pnISlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW76ZLRK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so3907151a12.1;
        Fri, 15 Mar 2024 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710541709; x=1711146509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKMrVBH/fNSeezyhVeqSE7P3QRxBY9UAa0c3DLVNqYA=;
        b=UW76ZLRKNL7o/We0EqD4hyFsLnDpLI48gmx5e0+OpeO182dfVJo/0vkeCGFVaHZkgk
         f63klHAGXagZ6WEUUeMJZ9zQCY7CwotQ61wr8Tn3EONRIwtdGdJrSZdywnLFhLPLCwnb
         YxphRPfH7g/8dT0k8U4AeaCiRzrptL16N9xRKQS2Xw0GYV5EqyEGh+AukH9DoZdcBPJP
         V7Rn/EnAv4dAJ0qd6NYJzhB8K5sS25+Adt1vePYsmjmPWUAGNxjm9wcVBEU1TgqSQ2ES
         9Pqx9nJYsDjC+NW+PTKDKvuSt6GEssvXVVY88u+VHR8eXDugZ32gkr2hPzQ83IdKWsTr
         Rbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710541709; x=1711146509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKMrVBH/fNSeezyhVeqSE7P3QRxBY9UAa0c3DLVNqYA=;
        b=Pv5gPvCiDj5LeOr6w4EzUdigptXSJLr3wxmvMN9FkZUHYNFc4vJn6N4eaiofYIzqxZ
         NmYAxILzbNrZibBKZHEI7jhIADRQPYbWFjD/wx9dA170P7pmYBG4TvOcWRcu+qKc3Cqu
         QqfJ0z4WWDVDMrD0BeGIBsVT7f+Xy9WcZsPM6Ie4Yeeoh27KGwX2EMh/y5ZDAHQah8L9
         aNwtOs2r6X73Ni9oKAoOdbUETx4pNeZkkiJAZFpyP+hGyLb5RhOl1Grd9DhgB2N27zMf
         Js3z0+0FLTdDGesOtchoNpKvTFRG+Wcy82SjZFmGk0v1XXdg9vjfGm19m4V69sfHRvsX
         KBJA==
X-Forwarded-Encrypted: i=1; AJvYcCWWFvyQIYug/yLY/xkBv0zQ/Qkjw8QhcE6D//Utp2uSeloAXI/AaQp7Ery/MTGh7DrhInMi+EOQ8ehWjQFcbdEKLulOPQvXXoiY0p0oNAfRzZ68ypGfAHBdIAtRBiE8N6RyH8PhKKbBE1J+RFi7I/VGh7mOLYFPSN1CD1d7fmEcbCJzpIv80YA6zmLL8HsFiLfv8HMdGF0MudU1Dw==
X-Gm-Message-State: AOJu0YytRePbdtRLH2eif01A5PkpMfov+NHKrd2Ygg+tZ5ay+Qw6jADO
	7yy1S0QHAMWIgboxLWL0Pq9/MCjm/h+J2qmDa5B2tYh2MNlgpd/S
X-Google-Smtp-Source: AGHT+IHMiOXqAu3IOFZbWybq/E7AHBFjYPqnN6JICZlEg0O6rLl7kC8XY7jGhpfuWwf3jwEHz5Vu5g==
X-Received: by 2002:aa7:d792:0:b0:568:231e:31dd with SMTP id s18-20020aa7d792000000b00568231e31ddmr4054551edq.30.1710541708964;
        Fri, 15 Mar 2024 15:28:28 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::f845])
        by smtp.googlemail.com with ESMTPSA id el9-20020a056402360900b005684173e413sm2039833edb.72.2024.03.15.15.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 15:28:27 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Johannes Zink <j.zink@pengutronix.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Swee Leong Ching <leong.ching.swee@intel.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-clk@vger.kernel.org
Subject: [PATCH 0/3] NXP S32G3 SoC initial bring-up
Date: Fri, 15 Mar 2024 23:27:46 +0100
Message-Id: <20240315222754.22366-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series brings up initial support for the NXP S32G3 SoC (8 x cortex-a53), used on the S32G-VNP-RDB3 board [1].

The following features are supported in this initial port:

  Devicetree for the S32G-VNP-RDB3 
  UART (fsl-linflexuart) with earlycon support
  SDHC: fsl-imx-esdhc (SD/eMMC)
  Ethernet: synopsys gmac/stmac. This is based on a patch series provided by Chester Lin in [2]


[1] https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3
[2] https://patchwork.kernel.org/project/netdevbpf/patch/20221031101052.14956-6-clin@suse.com/#25068228

Wadim Mueller (3):
  arm64: dts: S32G3: Introduce device trees for S32G-VNP-RDB3
  net: stmmac: Add NXP S32 SoC family support
  dt-bindings: net: add schema for NXP S32 dwmac glue driver

 .../bindings/net/nxp,s32-dwmac.yaml           | 130 +++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   5 +-
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi      | 352 ++++++++++++++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |  57 +++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 drivers/net/ethernet/stmicro/stmmac/common.h  |   3 +
 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 313 ++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   9 +
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |   3 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   5 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   7 +
 .../dt-bindings/clock/nxp,s32-scmi-clock.h    | 158 ++++++++
 include/linux/stmmac.h                        |   9 +
 15 files changed, 1063 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
 create mode 100644 arch/arm64/boot/dts/freescale/s32g3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
 create mode 100644 include/dt-bindings/clock/nxp,s32-scmi-clock.h

-- 
2.25.1


