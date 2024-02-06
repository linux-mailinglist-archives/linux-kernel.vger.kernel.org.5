Return-Path: <linux-kernel+bounces-54968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9340884B59E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF9128884F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA6A12B142;
	Tue,  6 Feb 2024 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIZwU5YA"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A78F54;
	Tue,  6 Feb 2024 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224087; cv=none; b=KwsmGRkIIt5pqVaG3hhctVb5p5ozmJCLS35/t1eH68uO5UlHkbAdsf6j4jI9mjsIkfkkfCXTsUZGaEvbU7+Acd58OFeJiAmcdh9X8wxvBKMSJc0+/7OKHUah+0X99jAbwrUNaSUKr06kwZy+vFOJMDNjLjSkLs8TS/rIPzz5zh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224087; c=relaxed/simple;
	bh=UJK9GaRRL6kPl4S1uDuZgmL4Sfxeyuf4N9Zx7KregaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BPKpqlyZm6r0IEoj9x/EgZewF6uc1ejcPdFKgnD0LZgJ/kqq1V04GYb+P1OboCETmg+fq0r9d2I2rYyNOPI/4WrVapRNQIAtD/BzfxJ45FXMw9CEBL2UPtWUQR4L9pEu54M8ij0utiJxJRYN+7QOI1FtIo6hLTA6EYGoajK0tjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIZwU5YA; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dc20645871so381918a12.1;
        Tue, 06 Feb 2024 04:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707224085; x=1707828885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0eqgiERDvSpiSPKxHB5iRsf+0A8lyd+pOORVaquNyS8=;
        b=PIZwU5YAWUy4moHX3hLNVgYEVRBma7p0s15BPWfVV9R9KBOfLWzOHeJkXUxuS+lJhm
         ivNo4GBiofbgSG6znqTQ7SzN4zm82zu8KhnGp8O67quURPIobD8sPvDuVpIVXqa5ViQS
         0vEpa5ZeBp+ipAS7GSLr1LVpJ8AOA7yD0DLmWAE3SGlHkriZWIFM6sbrhrK+eGCgNLlU
         gMX2S+TNRoEPU7La4doBfhyvNSv4+J3mSpTTNTf/akIiB4OckJqh8/cgKpRb7GCYk8ay
         uTR+hqmhoG6ox/AgCNdhdllvqlG91jSQZVFd3zOAdGDDmKaNykS7UynYxQGAZ1mYmEUe
         08yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224085; x=1707828885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eqgiERDvSpiSPKxHB5iRsf+0A8lyd+pOORVaquNyS8=;
        b=oP7yfxRbIWD+Wb5rzhbW1/dr/Cx1wzn7ZVIgkA0aTpIpQyp2MtVslQ2dpSHEbm2zjS
         KYbYxgueiNQ7U1Xsj8ltU+nreBmSohS4fp6wpssgjAipkgExsCFWncWnt2+yqHrizE7W
         UiXjk/7ZUzrRAuVhD5j8V6BYQ+ZfbmcZTPnKag4aoJ6IGbC2t9UPNyOXDQ6bNenh/5iu
         3S4znnc8hTsbtsh5oV8anXxTSRm3x6UfNTS611nMDBkI9XowLi3nGmwldomew4ej5cYa
         1TApL/F+J9VfcfwcQUFXJvsX+0cDxXCrsiaEup5yzHwt1MWU5tHWWsWeSZwT3NYD+CC4
         S8mg==
X-Gm-Message-State: AOJu0YywryI0A2+AM+cYCGf8gp2LH0fL/uJr7iT2lW/Aon8mw2oo+aUN
	HTsWp8Pows0TW4mc6EA3feYxwA4Nhy1vgFbwCeGF18R7/zmpNWMw
X-Google-Smtp-Source: AGHT+IE6L3CJfxfSxtvuYXs2E1wg/gin9wFyGLDNWpoQxHLmvyHWnH6GtHWi4lgGQlaDgGEXHrAZAg==
X-Received: by 2002:a62:ce0c:0:b0:6e0:44fd:687c with SMTP id y12-20020a62ce0c000000b006e044fd687cmr3697847pfg.6.1707224084394;
        Tue, 06 Feb 2024 04:54:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXR8oib6yggmJvpyZigTsA0Wi4OrDybUkU8+YBb9gaWRJXqYqywO0vE0hbEcTrPtqB5hnxTOEkqkdH37r8sle/v1RVs0JNvTf5LwFNFnyuskQ5phXZ0aHLz+UEHOF5ms7ZPOkQOoUW5p+hU/mfMudS0Ds6x/jsjLnyz1Hs6Be5XzWaNzBMgqK+yPgewtNA7iVvMasvGOeemAWXpkE7kXHS7y0V72NG8fJLyeNWfXxbGJ/8aaDI4eDE+e9JGpDuge+2YoiG3eH+sKpQLHHkn5xjuxx8l0zn4wtvI14gbNvLcMkkQYLhDKaGu2yS6qv/IT2dIy8aoZUuvOp5qy1lccW4mi3Kn+uY+OlrlTc4iyMJtKAqwXH1IA75lze43U+3991LaR7gwEp/mqK+Xq2UkXseIkbgxcWorQOgXqAGjuc/sbRwisYpCANpvr38MmabaGp3ZhSFWeoptQjnBuux3tzsckN7tTxCQ3yjVWuuEXmdm6fMRoAqb0tMmthQCIt5rCDLqAAuC2d2fm20lP1bq7Ybo7mwFG4w+2QHcIgiqsW+ry0Bp3ZSVxRP5EvZkINHoGFvXPpV/nSETb/HTu9AU8Gz24NjAa1vf7jidRaeU/0X7DskAFiIl+lysCB1h1POCPSQ9Dzppo3SkwU+cWz12oyLpPD+vQ2WSZjDzxJHqYMC2VRG4Y8rxxK4RnoDu1BaBBtrVnz98poma5JS9K9oSX1byuBO3jXuvqfZ6pYySanfeFYeb/o1/bS42fT7nRcPRNVTXrwqIDXZPv7OvhsZ7E9m/f8EH6WDWaYRppsjRNd9kYh62eMCJ0roKy26wyEnnYwYiX3B1og==
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a001aca00b006dae568baedsm1795590pfv.24.2024.02.06.04.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 04:54:43 -0800 (PST)
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
Subject: [PATCH v6 0/1] hwmon: Add driver for Astera Labs PT5161L retimer
Date: Tue,  6 Feb 2024 20:54:19 +0800
Message-Id: <20240206125420.3884300-1-chou.cosmo@gmail.com>
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

v6:
  - Remove unnecessary return value checking
  - Correct the available size for simple_read_from_buffer()

v5:
  - Fix warning and check messages of 'checkpatch --strict'
  - Without resubmitting the applied patches

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

Cosmo Chou (1):
  hwmon: Add driver for Astera Labs PT5161L retimer

 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/pt5161l.rst |  42 ++
 MAINTAINERS                     |   7 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/pt5161l.c         | 667 ++++++++++++++++++++++++++++++++
 6 files changed, 728 insertions(+)
 create mode 100644 Documentation/hwmon/pt5161l.rst
 create mode 100644 drivers/hwmon/pt5161l.c

-- 
2.34.1


