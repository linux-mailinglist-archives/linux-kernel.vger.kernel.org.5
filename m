Return-Path: <linux-kernel+bounces-7200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D56681A31C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900D31C241B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B43B40C1D;
	Wed, 20 Dec 2023 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5mCWkjQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8F03FE32;
	Wed, 20 Dec 2023 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6da5d410432so3855625a34.2;
        Wed, 20 Dec 2023 07:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703087528; x=1703692328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UAcKiHpe6juqfS47pCojmHTEkJCyatRjFVyT2trlCyw=;
        b=Y5mCWkjQDs3IJAOLdo0NEHE3Cpd7frjRuThavPcsDk9u9UhGM8nVWtSRTL++gAmTPP
         hbL2yQJE1OuTS/ZBx1vq3eZnWdMzUSW48TeQW/dtAb4KLVB3Cp/5dTYpAKQRWK8KjBNL
         YIj0cRJEQkkpb1Hb1GUln2K92O2dD9HqOo9xNG+wudFIxw30dxq+GEdE3VUmz7wZuQUH
         5eLjrvkW7wh95zMprsX5eUDBPMjvEW8qx5TGDs4vWij6Kbi2hSvPcRF5FfHZHO5UC44P
         x7fnE7TIsU8ecJwenPcZp9h5Oe1CTJahnvEaLn8JC0WUiYZskX0UBuh+WFnMInX46rSI
         0VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703087528; x=1703692328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAcKiHpe6juqfS47pCojmHTEkJCyatRjFVyT2trlCyw=;
        b=k+7ISR0H0jGn/FxFsWiC1/dNwzKhgigZaDlUjux1nXi0fDoz39GdZEOvbrYRJu87YY
         JgeGhWxVRWu3LuHWep5oYexCjh6DMOm9KS6sKkuaP3pfs+8xON4Gd2tZ8Fq12nTD+4vo
         hUgWrXcCXqWvwKACPXkLA5FWru6GxiFi9CMaHYlDdT7BD/Wye3BKnx1WvMgRrRzoMhNJ
         HgzqgFVKrrKOAkv767uboYboIly2/HgkBWxhiUWs3gFs7V0Quwz8V1kDCXHYMXeKeWlY
         A2zsQn/e8RwRpwVqjC5/wnjG7hQtgHRhaHmX7uqxJRjxiLoeh7nDSXXDw2nBL49yOCVM
         yx7A==
X-Gm-Message-State: AOJu0YzCJDgvq3/hzIdZfG1h8wMWvRn20PZF/SYy9p1igmiottsGbpvS
	5nzVegKdd6U1FgQzN2In0EY=
X-Google-Smtp-Source: AGHT+IFLclNYyqTDtU6o+bSm9uEZVQL+q90o7t8TOZ/DDzP7tOnE73/eZg3wGAGZC6u8LmfCXj0Saw==
X-Received: by 2002:a9d:73d1:0:b0:6db:abf8:83b3 with SMTP id m17-20020a9d73d1000000b006dbabf883b3mr1158074otk.34.1703087528256;
        Wed, 20 Dec 2023 07:52:08 -0800 (PST)
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id y188-20020a6364c5000000b00588e8421fa8sm4840847pgb.84.2023.12.20.07.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:52:07 -0800 (PST)
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
Subject: [PATCH v3 0/3] hwmon: Add driver for Astera Labs PT5161L retimer
Date: Wed, 20 Dec 2023 23:51:39 +0800
Message-Id: <20231220155142.3060255-1-chou.cosmo@gmail.com>
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


