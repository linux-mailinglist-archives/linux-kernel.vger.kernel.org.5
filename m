Return-Path: <linux-kernel+bounces-4854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7478182E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 418ADB234E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A5711C9D;
	Tue, 19 Dec 2023 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpENd2kJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693F312B7B;
	Tue, 19 Dec 2023 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c699b44dddso1311247a12.1;
        Tue, 19 Dec 2023 00:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702972841; x=1703577641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uw+kYnYNk9hZHNMOrj4qxXorwiwE6kTW/ev0nql9iYg=;
        b=LpENd2kJinqIUBvQH6zWgY7xMeglwJ2B7JPqPBVvZKixremFeRRda8RkTeacYCH1fh
         I47ekL8zRVB9mYOWwm02Q1ze1S3AxrOMvtOuS1D7yIq66SYyCVvInV+q9t+lyQx6AVzb
         rkL1EAYVtZLOZ04gK15/d372otvDT2uMydFzJpPt6CC7mGF970vbtpOUL3hE1ncijjKQ
         8zeGHwV/tfCaNefaVUFQv8srv6up8c8e/KispnMsaVZUEoBkoL6r9bq/P2bCYt/yWRGt
         8QZWY6EU62u4NVvQzBhXPcMCIPwsVqqBrlfw6gNWF6FoP3z0KgE6RWq4nAXMdyIbox6a
         nzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702972841; x=1703577641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uw+kYnYNk9hZHNMOrj4qxXorwiwE6kTW/ev0nql9iYg=;
        b=In0iJIsFj3SFG62/pwDJh98MQA9lod+f5CUndLUx6uI/FtiL+TkCHXQVWm2mZQPOQb
         R4DI1y0H2PSIt3WNz4wwBes50b7wkwBLoejubVMjgPNR9JY8nCZ5ZxDN8eiHEiy9Qb7D
         FT1GQ8WkcDDB5XvEbKgo4+JG4/YVZ1c6Y9KpF1I4veET6oBVO+mYIDdyEibPJ2Tk6ty5
         jx0vXNnVeQ4i7sAnQqI/5PnagoTdTmmeg5ZEUQb7nLncJ3ClcE3PEG8ntHX3a4xtcT45
         45KhFFkNxPOPmeSfyg3Ah7p1TkUWlGC6J3kCuBj7ekeLeDAFQNqCkThvI4F//hjjWDKC
         6eag==
X-Gm-Message-State: AOJu0YxyrrWvZpKr5kb+qrq7i8FrBvJyYJ0l1TRwuuBkANubGXjzkBvv
	syT1R7dPOrhLJItpkoV3bpaQHRKabU2plQ==
X-Google-Smtp-Source: AGHT+IHDS5YCYIfRlrtW0Hkq+K/JcbqTDdBHtWGryLIVehkw0TtH79JKy50MoK5i0ZaTlsIS8OeNNw==
X-Received: by 2002:a05:6a20:7fa6:b0:18f:dde5:7211 with SMTP id d38-20020a056a207fa600b0018fdde57211mr8990952pzj.7.1702972840569;
        Tue, 19 Dec 2023 00:00:40 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jl13-20020a170903134d00b001d0b410271fsm20261005plb.218.2023.12.19.00.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:00:40 -0800 (PST)
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
Subject: [PATCH v2 0/2] hwmon: Driver for Nuvoton NCT7363Y
Date: Tue, 19 Dec 2023 16:00:19 +0800
Message-Id: <20231219080021.2048889-1-kcfeng0@nuvoton.com>
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
  hwmon: Driver for Nuvoton NCT7363Y

 .../bindings/hwmon/nuvoton,nct7363.yaml       |  62 +++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/nct7363.rst               |  33 ++
 MAINTAINERS                                   |   8 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/nct7363.c                       | 515 ++++++++++++++++++
 7 files changed, 631 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
 create mode 100644 Documentation/hwmon/nct7363.rst
 create mode 100644 drivers/hwmon/nct7363.c

-- 
2.34.1


