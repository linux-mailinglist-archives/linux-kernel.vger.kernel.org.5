Return-Path: <linux-kernel+bounces-82491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2127A868549
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10802860F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1C84A21;
	Tue, 27 Feb 2024 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXa000Oz"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D3B1847;
	Tue, 27 Feb 2024 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995422; cv=none; b=DJ1nxYHXR/YboqfVBw49IpB5Spuf7D1Kl9FD6lmmytA6EsnX7cu5KN+sEsLNuWIo/gm5rhixa+HWHHY2OURQHCyxEermxg2uTPiMq91mJ3aBqUUlp55otmLVn9XrGCyRjAWmQfr8ttbb4oT9RiSE4zsYu6bhLLTTm363ouLZHKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995422; c=relaxed/simple;
	bh=Rpstasz6qy5asuH/ldMOofvDaUhuD9+siwLcWOuJaC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rh2SAKE0WziPvEOJTU9H1t6rmLKKrq0eHb0t9SxzDMcK/rf3bT5v9IMRKXXom2PbBn3OzLk3WGeu1JDnYdYwOH97vDNqun2EZuAy1l58GQnbmtTpKsTbpfK/ZdiXV4/PF6issGXOlPIryOh+Lnbh/GFW7SE0XBC46Ebf08dJGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXa000Oz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so2799247a12.3;
        Mon, 26 Feb 2024 16:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708995420; x=1709600220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWOqPITH8/D/rm9Piee283eHAkgF3ezgjvokn+PRZ8I=;
        b=eXa000OzWsZE9/wtEOwGV3tJ2cQMYFnuFqQZtNT1kjEseq7uQllk9GKpzTlr0SY1jZ
         nxhbfti5T9wClU6/nXktvR22QOkeVmzqnljQ156GfGA1kMibTPTJTI8ffLdiugIQVUo6
         2FR/dhpvoy5pGU07x9ZZ8dl/zU8Js7yZikJ8R3/vRofnJQ3NfJMcn9fOuJseH2grK9bM
         teb90nWYgQQZCOWg30S3egblVkr76UgM3A6UWQiFuJis2ub6RflCuF+vfby/L7ZLD69z
         nKxeb3TQj1+DgM5x3k2WG0CAkMqGH5f0T7cQtUyy8zeBxcXiZaQpK/QF4DeAjij1MMO0
         gK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995420; x=1709600220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWOqPITH8/D/rm9Piee283eHAkgF3ezgjvokn+PRZ8I=;
        b=fksBdRnz8dYfkTMF2gN2szYukT0deK2s6i8Al4JyMDYEhPdPRemNtcUSsGGCt4Tmvo
         ftCbCMhtk0JnITpnjH8rr14E9eHXXGhoI2lbq9cd2BAWLPXW7uDqkZwT+Xl4qxzmT+g5
         Dwl20MT/xfF138whXPqh/2sn13sTofMATbf+t0/yKWnNlChPtDoezwp0jWuqq7oSztSp
         5ZX+UJi96ibEEgVgLKTyEyKTyGfBSoNlFJUwggkpR2odqneJHKmAg7HDaJ9xvEOTet43
         lOHNEoUzwKc305WbsQ2H9omUmpRx7NORg9UZImVGFddO/6NEvaNfemDcQPXnHS7yFXVe
         E4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCX2vRgl2f6G4oCa3cwPVlbALa1yHd9PeSF69FtQVAYj7Qi7p4EltHmVMYeoztVY4hT6oG85rm+FXTUCyWvvKJoeSqjyAqYbUsYxz+5LcCwIZRLKGsF3bYqxab734grzerLVyNyTmoUTcIA5pkFqhVDMEI50nPgPw3MyFYRHjFL65MqqNA==
X-Gm-Message-State: AOJu0Yzh6veWx0gwexfm/S+2HorhC5qtWBtsTHiODgrlTo/ptHNBS2PR
	MG4mneLdAuUhr8xLj/mhTjYdMtxXPecwVd9K9GbZU4YxH+nnjE/G
X-Google-Smtp-Source: AGHT+IFi5e/RLc/BtrFNtrv1ceMqXDqLPgjk0Fze9Pvw/xHtkjf+4uFWRAv/dagnTOmwpr9Lwd2C2A==
X-Received: by 2002:a17:902:f690:b0:1dc:5dc0:9ba with SMTP id l16-20020a170902f69000b001dc5dc009bamr9461638plg.26.1708995419555;
        Mon, 26 Feb 2024 16:56:59 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b001db3361bc1dsm289253plg.102.2024.02.26.16.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:56:59 -0800 (PST)
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
Subject: [PATCH v4 0/3] hwmon: Driver for Nuvoton NCT7363Y
Date: Tue, 27 Feb 2024 08:56:03 +0800
Message-Id: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
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
  hwmon: Driver for Nuvoton NCT7363Y

Naresh Solanki (1):
  dt-bindings: hwmon: fan: Add fan binding to schema

 .../devicetree/bindings/hwmon/fan-common.yaml |  78 ++++
 .../bindings/hwmon/nuvoton,nct7363.yaml       |  63 +++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/nct7363.rst               |  33 ++
 MAINTAINERS                                   |   8 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/nct7363.c                       | 412 ++++++++++++++++++
 8 files changed, 607 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
 create mode 100644 Documentation/hwmon/nct7363.rst
 create mode 100644 drivers/hwmon/nct7363.c

-- 
2.34.1


