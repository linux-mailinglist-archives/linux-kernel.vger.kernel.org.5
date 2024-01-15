Return-Path: <linux-kernel+bounces-25847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BEA82D6AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336FE281AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC0FF51B;
	Mon, 15 Jan 2024 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5kX0zqd"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03098EAE7;
	Mon, 15 Jan 2024 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9344f30caso5681133b3a.1;
        Mon, 15 Jan 2024 02:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705313131; x=1705917931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ//Ume4cKU0XBJl4XFsVMEeQipDNvrkP5O8JhW2P+A=;
        b=c5kX0zqdbUv9DQ6e43H7fYZVpjNnWA2TkNVdvDo6xlDnGHzImGsuAHT3NbIUUokOK/
         YgMZb0fw5sw/dTE8cF9jfZFczXEJRM6UykKFvpfYRlozUH6sldvz8ilMasS32oBdoBYL
         lR+kSAhalLw9lal6cfOWoMIru/bywi8VMSOlP3FyXT+Fi9SatCMWsEwh+hoMKRDOgYKz
         PeNM8flmYFGwTGoNiksARf1sPxpT9Du1w+6XZsMygROirug+XKl+gyZu9c896m4GL0ei
         iqOrov/+67S5XsCwuxJb5Vwby8x0vaoW68QhDqJWnkLbXKCTJUzXggh1dXvJVCy4//44
         1uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313131; x=1705917931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJ//Ume4cKU0XBJl4XFsVMEeQipDNvrkP5O8JhW2P+A=;
        b=n/zFNxAtbtmPdEKKhJ7Xop2XNS5ehRpQI/Qiv8RSFzbYr9LqSIkbbFG5PjuxtEpoFY
         YXxh5Vy/qghtnTRF0T0LWCC/Qi+yrB+v7NVX9M/p77pbvokIADWeCL3ymk7G9F8xwpRN
         sCtTeSYqZpnV3IcypAlcmYfIP2VTBfgMgHVvANbl3T9ed+FVAC1e268+5IMSdPn5zOQD
         mQ/5wfo3Y+/qduN7EbfTwoFgib5C5kUYHWpAmmEpoc/Z8t4Z6KULvRmmVRCrBhl4Y6Go
         H6GcWfrKg2yCer5A9Tgy+VAD0txfzcRbE0GmU15KtRu3IrUZkUW7+acPc+D6G7v/fzDX
         wbAg==
X-Gm-Message-State: AOJu0YyiuWpQ18tKQomiYFS3uTMe5Yu5gCptsv4rQjkrq3VFgVsAKNow
	AonvCRwC0hEm8gz22eHmAZs=
X-Google-Smtp-Source: AGHT+IHUU+y7APDBX696xOHg/QH2IAbBmLmFJsGYqruQCmtTG/xwfOSx8GzQUEQvmWq+c6UoDG0MHA==
X-Received: by 2002:a05:6a00:1408:b0:6d9:b9ba:fc7b with SMTP id l8-20020a056a00140800b006d9b9bafc7bmr6365741pfu.33.1705313131147;
        Mon, 15 Jan 2024 02:05:31 -0800 (PST)
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id d10-20020a65424a000000b005cda7a1d72dsm6870712pgq.74.2024.01.15.02.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:05:30 -0800 (PST)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	corbet@lwn.net,
	broonie@kernel.org,
	naresh.solanki@9elements.com,
	vincent@vtremblay.dev,
	patrick.rudolph@9elements.com,
	luca.ceresoli@bootlin.com,
	bhelgaas@google.com,
	festevam@denx.de,
	alexander.stein@ew.tq-group.com,
	heiko@sntech.de,
	jernej.skrabec@gmail.com,
	macromorgan@hotmail.com,
	forbidden405@foxmail.com,
	sre@kernel.org,
	linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	chou.cosmo@gmail.com,
	cosmo.chou@quantatw.com
Subject: [PATCH v4 0/3] hwmon: Add driver for Astera Labs PT5161L retimer
Date: Mon, 15 Jan 2024 18:05:15 +0800
Message-Id: <20240115100518.2887549-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver implements support for temperature monitoring of Astera Labs
PT5161L series PCIe retimer chips.

LINK: [v1] https://lore.kernel.org/all/20231205074723.3546295-1-chou.cosmo@gmail.com/

v4:
  - Rebased

v3:
  - Revise pt5161l.rst
  - Revise the style of comments
  - Remove unused pec_enable
  - Add back safe access wide registers
  - fix build warning

v2:
  - Add "asteralabs,pt5161l" to trivial-devices.yaml
  - Change naming PT516XX/pt516xx to PT5161L/pt5161l
  - Separated debugfs files for health status
  - Revise the style of comments
  - Remove unused defines
  - Remove including unused header files
  - Remove unnecessary debugging messages
  - Revise the data parsing for a big-endian system
  - Use read_block_data instead of accessing wide registers
  - Remove the debugfs files when the device is unloaded
  - Add acpi_match_table

Cosmo Chou (3):
  dt-bindings: vendor-prefixes: add asteralabs
  dt-bindings: trivial-devices: add Astera Labs PT5161L
  hwmon: Add driver for Astera Labs PT5161L retimer

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/pt5161l.rst               |  42 ++
 MAINTAINERS                                   |   7 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/pt5161l.c                       | 670 ++++++++++++++++++
 8 files changed, 735 insertions(+)
 create mode 100644 Documentation/hwmon/pt5161l.rst
 create mode 100644 drivers/hwmon/pt5161l.c

-- 
2.34.1


