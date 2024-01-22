Return-Path: <linux-kernel+bounces-32486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009A2835C41
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C22AB23D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D0A18C38;
	Mon, 22 Jan 2024 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG68kBUD"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50BF17729;
	Mon, 22 Jan 2024 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910706; cv=none; b=bewVIbRP4/AHEk/OR5i4WnkvhCLaomNuCOWL+1DMHiJSnjQyF2XU1HGT5AK/3gKYSIVrj3F+qobqALI/nLFv4OlhurqiS96Dq4IC/Cg3ynNaD1jKHnHKqID/Si7HvofhezkVeVW4ChnNxU5eMzZW8trKm4Gooft8tDIUagjua0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910706; c=relaxed/simple;
	bh=N3WQRXFO15VCEBO5IuOncnN4FTzCjrq5s3JgJO7VMjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=koFb/OMMl7ogKvfR9chgXAISGD2mBXJyiz5HS1f57g8V/6NWOxXzJivlUz6V5aLLFs6BPLM2Ib2RvnxqvCsL3SOBQAeyFtgL3PCT5JME7Mjb6SLH5pyi6jdEqf7Ad/DUe+lymisAUcESfPBdToiPcLiLETGAZKraohZM6HXuEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG68kBUD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2901ac9ba23so1252180a91.3;
        Mon, 22 Jan 2024 00:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705910704; x=1706515504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3G/nUgZ8nqnJBaq446Ylsx7WALmJQMmykwv3P5etgPU=;
        b=FG68kBUD+4GdGKOZeRfyYqYE4g0styLYleDO0+zZihNagXsI7rZmLJZnpx2wc2Qmq9
         JSn5AWbAR0Eo6gL1o+IyW69tdYePbxk3Jnu0mwJOnnTcJe9FIOJapPZsW7/a2AUkyNTb
         JVjLaFu/0+2W+Isej2btuB5AVxTs5yFvRyHeq+6RBukPJpnMtqMJrx7t4nuY7aAYJxj5
         JuOhKz6TZIpOJP1VWxIktH9Yq+riZTXO0MOc/cnkjwXZlwv0H68ckm1dcJ28lVV64jD1
         PcgFXF/2jwLJyusD8usxcxskKX2kPrKPKSYm2D9byOzEz9zLuYO5ouByUNQwcLc36Qm2
         7h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705910704; x=1706515504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3G/nUgZ8nqnJBaq446Ylsx7WALmJQMmykwv3P5etgPU=;
        b=lvcUi1rZiUryGMAJCLOfDq2i33gYkKhvGazZ2NN63O6GWxcK+rBaPiqg+F7dpKGHaM
         d3KjyOiuznUvau/2DQtbhZd3+JPLATU9PgCnGRVoOOo95+dHar2udlUD09FCt0C+zbgQ
         zhimeWqivuhbdozsuPxgjjZhNAnUaKMhbPPTNYH/SNv90xP1M1cYMcCUGuN/krtt7gNe
         N4plaJIusBZ+0GSfYPXIzMypoH7OgAeFCgwHaEzTUFKh6lwatvuNkrDNbeAqrtlmjOxq
         hvGx4gcS+oO0PAFWI5pQA2XXQ162ShZj7u0+qC7UnTEu6Eu/fGhCuFSliZAhadZr6HGY
         Ok6A==
X-Gm-Message-State: AOJu0YxAI8jvMFQlpglB7dsGSN3NoiU6cp/LkR5+ZXh+HHG2ueC+aNoa
	u6WPdVDxU6hyzew3GSfN6Z0GhId/M5MkF1kRhWICRoNLbY/8AKZI
X-Google-Smtp-Source: AGHT+IG6xuGCNNzdkl15x7pKZdJp2BUopy0hpxkX5tBlZhkWuue0fZnqs7Tt6Q5i6iecg23byAgWJQ==
X-Received: by 2002:a17:90a:e547:b0:290:2d2:6a8 with SMTP id ei7-20020a17090ae54700b0029002d206a8mr1006803pjb.58.1705910703702;
        Mon, 22 Jan 2024 00:05:03 -0800 (PST)
Received: from localhost ([46.3.240.101])
        by smtp.gmail.com with ESMTPSA id sy14-20020a17090b2d0e00b0028c89122f8asm8956224pjb.6.2024.01.22.00.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:05:03 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org
Subject: [PATCH v7 0/3] riscv: rtc: sophgo: add rtc support for CV1800
Date: Mon, 22 Jan 2024 16:04:57 +0800
Message-ID: <20240122080500.2621-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Real Time Clock (RTC) is an independently powered module
within the chip, which includes a 32KHz oscillator and
a Power On Reset/POR submodule. It can be used for time
display and timed alarm generation.

Power On Reset/POR submodule only using register resources
so it should be empty. The 32KHz oscillator only provides
pulses for RTC in hardware.

Changes since v6:
- completely delete POR dt node
- remove syscon tag
- use devm_regmap_init_mmio() replace
  syscon_node_to_regmap

v6: https://lore.kernel.org/all/20240115160600.5444-1-qiujingbao.dlmu@gmail.com/

Changes since v5:
- remove unnecessary lock
- fix cv1800_rtc_alarm_irq_enable()
- remove duplicate checks
- using alrm->enabled instead of unconditionally
  enabling
- remove disable alarms on probe
- using rtc_update_irq() replace mess of alarm
- remove leak clk
- useing devm_rtc_allocate_device() and
  devm_rtc_register_device() instead old way
- add judgment for rtc_enable_sec_counter()
- add POR nodes in DTS. This POR device shares
  the register region with the RTC device

v5: https://lore.kernel.org/all/20240108072253.30183-1-qiujingbao.dlmu@gmail.com/

Changes since v4:
- remove POR dt-bindings because it empty
- remove MFD dt-bindings because SoC does
  not have MFDs
- add syscon attribute to share registers
  with POR

v4: https://lore.kernel.org/all/20231229090643.116575-1-qiujingbao.dlmu@gmail.com/

Changes since v3:
- temporarily not submitting RTC driver code
  waiting for communication with IC designer
- add MFD dt-bindings
- add POR dt-bindings

v3: https://lore.kernel.org/all/20231226100431.331616-1-qiujingbao.dlmu@gmail.com/

Changes since v2:
- add mfd support for CV1800
- add rtc to mfd
- using regmap replace iomap
- merge register address in dts

v2: https://lore.kernel.org/lkml/20231217110952.78784-1-qiujingbao.dlmu@gmail.com/

Changes since v1
- fix duplicate names in subject
- using RTC replace RTC controller
- improve the properties of dt-bindings
- using `unevaluatedProperties` replace `additionalProperties`
- dt-bindings passed the test
- using `devm_platform_ioremap_resource()` replace
  `platform_get_resource()` and `devm_ioremap_resource()`
- fix random order of the code
- fix wrong wrapping of the `devm_request_irq()` and map the flag with dts
- using devm_clk_get_enabled replace `devm_clk_get()` and
  `clk_prepare_enable()`
- fix return style
- add rtc clock calibration function
- use spinlock when write register on read/set time

v1: https://lore.kernel.org/lkml/20231121094642.2973795-1-qiujingbao.dlmu@gmail.com/

Jingbao Qiu (3):
  dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
  rtc: sophgo: add rtc support for Sophgo CV1800 SoC
  riscv: dts: sophgo: add rtc dt node for CV1800

 .../bindings/rtc/sophgo,cv1800-rtc.yaml       |  53 +++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |   7 +
 drivers/rtc/Kconfig                           |   7 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-cv1800.c                      | 406 ++++++++++++++++++
 5 files changed, 474 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
 create mode 100644 drivers/rtc/rtc-cv1800.c


base-commit: e3d3fe7e7bf08820a83c9d9a4c38c7b29a2927f1
-- 
2.43.0


