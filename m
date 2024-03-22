Return-Path: <linux-kernel+bounces-111116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC2E88681E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEDDAB24606
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE571754B;
	Fri, 22 Mar 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKSSFatA"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861217541;
	Fri, 22 Mar 2024 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095523; cv=none; b=mINajCRa26rv3C2undq0oqLE1NgOpP5iH1IB6sc+1B/57shlw1vhO8oRp/TuYM/lLR99xtbJrflxsO2LocC72b2gnM9b7w0RXjHntbe7S+Td1mWsRvnLabBPaNgUzWpMtDCwsc4HVO2oxMgadsIHfzliDUIiinK/7rYGEC7N2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095523; c=relaxed/simple;
	bh=rd+p0dVu4TA+0VkP+DxfWT2f83gmcmxQREG7HALIvfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r/Ogsr7bPV3j3YVNvAQlSKddtsv1rWrqUBWMKozbCudKKjLI1rP5YP//wYD2gCJhpc8SrXCebsriGVzVY4sjHdGcj2rZXhqWQu3JpkN4ddILOYvWDlbryg7RqeHXIajpoo+DQ1qWewmxgAd/DPORD76ywpBUFD3iyF4R185hLh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKSSFatA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e00d1e13acso11203805ad.0;
        Fri, 22 Mar 2024 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711095522; x=1711700322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yy+KHNUW+coF6cF93OFhp/xRFqCnGtKs15mHnvutaYM=;
        b=gKSSFatAf8J+4Ivu4b1PmTKfXGqdp4Q5MYuWiqMWa4X+O8sfAGbaRBEypOYkIOXF2R
         5vKi0fFCs5Fj794tZD28u/DCIa79JV9X1xzrtvPRUlRM6syZ//pjiVeLBLzK4Slm9vyN
         3INK0+uYDO+abAXBzRteAadR+1aNe2bMeV7GsRJt/wl1ItlDl/ETAOZ31OXWeElMd2WN
         wx5KZ44X6jqql9ocCrvha+Tk5S4TuZyLCH8Uc64HzgrgNUavU/c1RYsq7KKQZQjuOsjH
         6bhwBJSxb1umOI+NGxd2TlUH2VGZ7EliIQZi8uFGk9dkGjK9RxS8SbbGbLMeOFQ2+c3/
         FdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095522; x=1711700322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yy+KHNUW+coF6cF93OFhp/xRFqCnGtKs15mHnvutaYM=;
        b=gIaVTmNQGgvCLxoFdiZ88gm+eA8hS4CWsBayffVUnUmGlZ7yo8AuoTypLIbKnvCBKW
         buTK9DzXFuWnDnARgDQc1OOCVrPN66gQKnmxsU7wZdwqRY2C89Hic2B2qHjupAEkfgTC
         EzbPOkl9t9PzdKc916qZMQFNEqvg0UrJbGmxQcGVUpSzMTc4XNs9mt8bcaGOI8ATXz56
         mM4v5ipXGa4K6IRZDyOr/yU8/Ixpbcf4jv+PPSAd1aYQzwrBaMUKb8ZwKIoodSOaoiv4
         HdX7r4qZCWWiwS3XcusaRpsr9l93QYOn2y7IXzje59qxWFYaeYC2Kg65YJuRYlaFX1mk
         Vasg==
X-Forwarded-Encrypted: i=1; AJvYcCW71eSkhZIluE6WFIKgsvzKAbwjl9nExvZ4n4oWOQkEejgQOeu/IFphDtTPd+OO7zcNRFm4qS5Io8DH6xU7DiwN3gB+YE1VRJn+W9n0bSdwwbqQh4bGNp1bEo5+0+a5BwoPKTM6XIf0hqVnoxMUSPpITgH4BNIdJ9CTadtkp2Gq/oraUg==
X-Gm-Message-State: AOJu0YzAgJMT1d2RU3SCeqys9Ax18XVc2lCwdW75MkH6E55NGo/tf9er
	dXvYNel7K7s1g/PVMfhLIvmA01wKLLCM3CoGkFPC4+DxJJSGv5DGqC3+zVl3OYI=
X-Google-Smtp-Source: AGHT+IGtZSQd4OGDi6oKa3A/VMJZUn6iI84Lg9soIxe7ueMP2K9ls9aPaWHsCdIhDoSHLxi++tYQ8Q==
X-Received: by 2002:a05:6a21:3997:b0:1a3:55d2:1489 with SMTP id ad23-20020a056a21399700b001a355d21489mr2312813pzc.7.1711095147442;
        Fri, 22 Mar 2024 01:12:27 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s128-20020a625e86000000b006e749161d40sm1132564pfb.113.2024.03.22.01.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:12:26 -0700 (PDT)
From: baneric926@gmail.com
X-Google-Original-From: kcfeng0@nuvoton.com
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kwliu@nuvoton.com,
	kcfeng0@nuvoton.com,
	DELPHINE_CHIU@wiwynn.com,
	Bonnie_Lo@wiwynn.com
Subject: [PATCH v5 0/2] hwmon: Driver for Nuvoton NCT7363Y
Date: Fri, 22 Mar 2024 16:11:56 +0800
Message-Id: <20240322081158.4106326-1-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ban Feng <kcfeng0@nuvoton.com>

NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.

Changes since version 4:
- add Datasheet information and refine words in yaml and rst files
- remove fan-common.yaml since it is already in hwmon-next
- refine the commit messages
- modify the type of returned value in some functions
- refine lock/unlock in nct7363_write_pwm and accessing
  HVAL/LVAL registers
- refine nct7363_init_chip
- add range check in nct7363_present_pwm_fanin
- add i2c_device_id table
- add nct7362 to of_device_id and i2c_device_id table

Changes since version 3:
- Cherry-pick the fan-common.yaml in [1]
- Fix "checkpatch --strict" report
- Replace BIT_CHECK() with BIT()
- Fix CamelCase defines or variables
- Drop enum chips
- Drop all local caching and just read values through regmap
- Drop chip auto-detection since it increases boot time

[1]: https://patchwork.kernel.org/project/linux-hwmon/patch/
     20240221104025.1306227-2-billy_tsai@aspeedtech.com/

Changes since version 2:
- Cherry-pick the fan-common.yaml in [1]
- Fix nct736x typo and add unevaluatedProperties

[1]: https://patchwork.kernel.org/project/linux-hwmon/patch/
     20231107105025.1480561-2-billy_tsai@aspeedtech.com/

Changes since version 1:
- Modify NCT736X(nct736x) to NCT7363Y(nct7363)
- Convert to devm_hwmon_device_register_with_info API
- All ID tables are next to each other and should be consistent
  between i2c_device_id and of_device_id
- Ref. fan-common.yaml and modify properties (nuvoton,pwm-mask/
  nuvoton,fanin-mask) to (pwms/tach-ch)
- Convert to devm_regmap_init_i2c API
- Remove unused function (watchdog timer)
- Fix uninitialized symbol which is reported by kernel test robot

Ban Feng (2):
  dt-bindings: hwmon: Add NCT7363Y documentation
  hwmon: Add driver for I2C chip Nuvoton NCT7363Y

 .../bindings/hwmon/nuvoton,nct7363.yaml       |  66 +++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/nct7363.rst               |  33 ++
 MAINTAINERS                                   |   8 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/nct7363.c                       | 396 ++++++++++++++++++
 7 files changed, 516 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
 create mode 100644 Documentation/hwmon/nct7363.rst
 create mode 100644 drivers/hwmon/nct7363.c

-- 
2.34.1


