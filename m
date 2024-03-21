Return-Path: <linux-kernel+bounces-110264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B1C885C41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0B91F24A24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA3E1272BF;
	Thu, 21 Mar 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDxLU/Hh"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FC641775;
	Thu, 21 Mar 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035676; cv=none; b=UoLKd4GuCaBNa2T2T4dJDF4DYfUgMcW9lr7Vz5tWzq2jJFuzXBglTqaN/5iQKfSh8ByKrX714OXYgzbGGdkrGkFQFf5GhRvCRUyZr55JCR+4ktapSsL/sBgf9ZgbAA50dgghLUyMlEaAcu+7SEphU7QgQy6IxNGgxiIXyb1Xsq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035676; c=relaxed/simple;
	bh=1tXzIQqeVghPRbcRUP2yLJurLlrEsCWJrrB199RVdZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFMytugA8Nb/9dU/Ms1TjTAgmaTBlAo+e7JFwq8IwEWtrqjzC2q8b50Gi+9G5JKv6+99vqwGCQbr+iG+sRxSfCRhr1Diz26EpEWr/a75+vr0jp0HSO7YUiPipiAOyoUVcOy9IXsqihcRl0ZhEi1msRp571u0eFUHEtGdH7DvziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDxLU/Hh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a46ce2bd562so152560466b.2;
        Thu, 21 Mar 2024 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711035672; x=1711640472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5BWYJUTrFZc4IzWvfu7rsC6QGv6V0lgilNTT92/bTSE=;
        b=fDxLU/HhMaM6SQkoVQHlrTCcLXaAKj3PoW0dWv7NXrFKGc5Kdr/gSVqTaQh9ikJ21a
         /2ghk+Yb39Q6fG59X4pZIQwphPP44UvBvJJX8Bh6tg8xknJAHKUemzRu1m+c+PIN3/Xv
         K8szMDC/kl+eaiOy7Tl+zNdOG5ctYHR6mdcaSoMWo+10cEypMh9muh8PgQhG3hmpXHXR
         QFJiS3SBCyyRtqJHVUV+PLfJcT23MBTnhvYbPaz0d3ZVmC9tetNAKwd4VRDf85Y5PFq3
         T4Jli2poZ68t+LH4dct5Wd/tE3NmcHR0CwQaEudgP8+ZDMGSc/iX6mWHhoG6OSdvHzVY
         Sm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035672; x=1711640472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BWYJUTrFZc4IzWvfu7rsC6QGv6V0lgilNTT92/bTSE=;
        b=lZ72NmT5EwbrPbVnNPf1ZHsWJVc5DJ+nUdreHJiLEdlr94y/z8Aw+ciCWmXnAqQPYb
         uii1vIDePTmFqIxD6eV7RGZYwoTwYTsYYFkCghv+OR08GWVgUX4XkC28s2rCXfFPFWyt
         e+rpkbfWKoaIFaS3K7Aq9sa8x6W8uOC6dXVcFBWru9uQBIY3vMDjDZvICfIurmVwPpMj
         BbTBHglzHmJ0cZ8+VdQVkttEZAZCfuidkxDGfg0ZjT5VBStojrvf88sEW2tLtZCeq2zQ
         kv3M7n4IT2gweNZBYWlBUZFehPUx0AGlZHV5LzJZMttR4RFulCINcvXkShUVGz5RUSvl
         LmGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIyRuunmwsMZRjk9SULO3IlEGlPgQPSGyTtV7v71DkfZ0xZKN4jrJ/oEJaqWCFgCBd/5Zn14KS1M+wkF5qIvKXS7yUG6fhnmPAICeiiigTghis6o93VojH0JY9CuGsLOp/7l99ClBguPEDgDJteziZhtvM4QqLtl3oChphaCqnLntUhWVI5/annIhKtWxFdPyGGH8j/K2RK9w0Atc0TggaNQ==
X-Gm-Message-State: AOJu0YxH46sSMThIB0eVxeUz2jBwVZYMK71AEiaMjc4K3pvuI3FO59GI
	OBCuiP1J8a590pm/iyNwlZ7/LhY0wQA29XOYy19P1oabSxUI5rcwwtRycbuyf/M=
X-Google-Smtp-Source: AGHT+IFqj+XX53X3qzQVK8gOG3eglXmFmD7208zZjw/2sioO578sxzn/K3QoFQdAdgAVlKTXd2omkw==
X-Received: by 2002:a17:906:4889:b0:a46:d304:fd0d with SMTP id v9-20020a170906488900b00a46d304fd0dmr7594403ejq.11.1711035672430;
        Thu, 21 Mar 2024 08:41:12 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::11c2])
        by smtp.googlemail.com with ESMTPSA id wy3-20020a170906fe0300b00a46b10861acsm36851ejb.208.2024.03.21.08.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 08:41:11 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 0/4] NXP S32G3 SoC initial bring-up
Date: Thu, 21 Mar 2024 16:41:02 +0100
Message-Id: <20240321154108.146223-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series brings up initial support for the NXP S32G3 SoC,
used on the S32G-VNP-RDB3 board [1].

The following features are supported in this initial port:

  * Devicetree for the S32G-VNP-RDB3 
  * UART (fsl-linflexuart) with earlycon support
  * SDHC: fsl-imx-esdhc (SD/eMMC)

== Changes since v2 ==:

  * split each dt schema doc change into a seperate patch
  * removed unnedeed IRQ from SCMI node
  * add mmc bus-width to S32G-VNP-RDB3 board dts file
  * fixed comments in arm-v8 timer interrupt mappings
 

[1] https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3

Wadim Mueller (4):
  dt-bindings: arm: fsl: Document NXP S32G3 board
  dt-bindings: serial: fsl-linflexuart: add compatible for S32G3
  dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G3 support
  arm64: dts: S32G3: Introduce device tree for S32G-VNP-RDB3

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../bindings/mmc/fsl-imx-esdhc.yaml           |   4 +
 .../bindings/serial/fsl,s32-linflexuart.yaml  |   3 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi      | 237 ++++++++++++++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |  45 ++++
 6 files changed, 296 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32g3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts

-- 
2.25.1


