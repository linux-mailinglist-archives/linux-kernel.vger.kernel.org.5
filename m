Return-Path: <linux-kernel+bounces-9241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E981C2C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E211F23350
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CA510EA;
	Fri, 22 Dec 2023 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up2AH3AI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5EA41;
	Fri, 22 Dec 2023 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35d77fb7d94so5527415ab.0;
        Thu, 21 Dec 2023 17:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703208867; x=1703813667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gzd2Vq49cs2OXoA1p9yPTdJ8jRds9If5/Ztk+9Dsun0=;
        b=Up2AH3AIz6SVj6nBwA8ZlT+cD0EOnrc3Sw7JX89xWBe41TExxRQCoA78CC+88qhKjl
         AevC9ZMroaJho2YAwFz5/LsubieponcIXbifbDB8E6DpZwiJ2JRrqakAmePvjScvksTu
         4GPCFxk3s1ITCiCCAOj8Tb+jF0SxrefuJSWfxA4ZXg/0MRw/2IN1HIQJS1WTGes/3bB8
         kpmEZkIkoWUbBwsfYR4+PGvpcE2Iy2IzG290k8+ttXctwK40zyMd6hShFSMJQ4kgWNRM
         dGsx4Mo29kWhIeE2cOILY0fY2ffw6R+VfrM7uDmbtmLnEmZIbifnJGoCu34/2kTohwxb
         OQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703208867; x=1703813667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gzd2Vq49cs2OXoA1p9yPTdJ8jRds9If5/Ztk+9Dsun0=;
        b=jdxoqwG94daA6rnrsZXSuR0M50sv8JncooHz5RU6gTODyzaAYpzu0qSvTCRo6d+PUN
         6/52yM+uZfUTRM+qTyARQbNcKcqmZzj35PjoM4NSYUErX57Dv9kjxDvoBhS3YhPrxelo
         gzE4LnFve9Xavm+LwiCT8lv452kw552Cln/SpFBckiy3gBLU7uhmLUPgDRbokJxCkcm2
         +8zpEfgFpy54/suMD9KmXVJ2iE4PQagY0NwLJDzW6yq9C3W5Yl6kT3mcISMxV/gLD279
         yxKZdL9EfqYhKBxn478Wfkq54Wz1p1io0X6HPXrrR/RFqgiBet5cwnOSFsuE7ZSZdF7W
         RRAg==
X-Gm-Message-State: AOJu0YxOkN89EYQ1IW9wUr+p2rtzH6rFwTZSM29N7jtMqFSM3MJ5VlSr
	OY0Cq2QZCdGJKD2AVsDyA+S3YQonqMkfPg==
X-Google-Smtp-Source: AGHT+IEVj9D/whIu1FDqQtMmMPwJ51/a3mthgT8d8o+mlufUBen02S7Yk+XNPAXA0+012GUgSPnmRA==
X-Received: by 2002:a92:c267:0:b0:35f:daa8:5caf with SMTP id h7-20020a92c267000000b0035fdaa85cafmr793821ild.30.1703208867182;
        Thu, 21 Dec 2023 17:34:27 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001d3d8e718c6sm2258634plg.282.2023.12.21.17.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:34:26 -0800 (PST)
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
	Bonnie_Lo@wiwynn.com,
	naresh.solanki@9elements.com,
	billy_tsai@aspeedtech.com
Subject: [PATCH v3 0/3] hwmon: Driver for Nuvoton NCT7363Y
Date: Fri, 22 Dec 2023 09:33:49 +0800
Message-Id: <20231222013352.3873689-1-kcfeng0@nuvoton.com>
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
  hwmon: Driver for Nuvoton NCT7363Y

Naresh Solanki (1):
  dt-bindings: hwmon: fan: Add fan binding to schema

 .../devicetree/bindings/hwmon/fan-common.yaml |  76 +++
 .../bindings/hwmon/nuvoton,nct7363.yaml       |  63 +++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/nct7363.rst               |  33 ++
 MAINTAINERS                                   |   8 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/nct7363.c                       | 515 ++++++++++++++++++
 8 files changed, 708 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
 create mode 100644 Documentation/hwmon/nct7363.rst
 create mode 100644 drivers/hwmon/nct7363.c

-- 
2.34.1


