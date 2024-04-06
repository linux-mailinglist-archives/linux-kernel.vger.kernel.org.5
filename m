Return-Path: <linux-kernel+bounces-133828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93DB89A95C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95B11C21D35
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEF92209B;
	Sat,  6 Apr 2024 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL0cAt0p"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F05FC19;
	Sat,  6 Apr 2024 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712385273; cv=none; b=JcNYpoRIOYaSWIKiY+ILlFKECbjby8RhcY3Pgqr00DqhfGkvP7Rg/kzyC7xONmhsW+qz74n3eJTnHz1P30tEzORNlcqatAKBYIbO4rJgfe0ZTMjgVtBPNU7Zvzij5XP7QcuqJjPDU6AGKT3GAugsv6OfzdVahW+4E3RezrTsziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712385273; c=relaxed/simple;
	bh=AG0MAab/lRPGXeVxF+74QX66/sODwWFllD6zet+ILvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BWqINpEBvqyqN3k/88nQBWK0MaOVgcrboKXD3o3OpMb1PEIiiD7Ui51eDZESiypS0RFOaKZ4eWE3waJqENVpJ09ZAGHYnyWLp6p/3px9m7D/Bh4pBaepy7yaw+3Cp+ONvNOSsjPzA0xY6DctMATj47cfQ4wjtAB6sKg60EmTGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eL0cAt0p; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a2e5d86254so1630942a91.1;
        Fri, 05 Apr 2024 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712385270; x=1712990070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HXg1HzMY1ws0HrUT2NKFnF8qZY/gmV174Rp18+QBW4Y=;
        b=eL0cAt0p7PeGjoiDug80uMi3nDEzNJK9g8mWEZcvfc+qxyZqPM+VW7VPRXNJoasB3B
         +5EO+x88FiNbTUjysrhavoh/oK6AiOy36CCS+/PoRvtPmMFF3RUTPO88k8nNUQuqm8Bp
         6eGHR1+40IL0ziC402m8Ud0m6rXFCbjFIMMWv4VtQM3Xg0rA2BnvkJR+3uD3CEwAeXyE
         9VePsgTLdMll6AdPvg559GNK0pNfOkmpSxqWlDgBgQ4Wi8QgMrbo15Ph5yUFJ80R+ict
         gDJ/J2Fl+kRBUezwkKoOcLAnQ+KbfFQaONqYzqDBGToqfpuFRkb3aVV8Kf5jWqIOi9bp
         Z0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712385270; x=1712990070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXg1HzMY1ws0HrUT2NKFnF8qZY/gmV174Rp18+QBW4Y=;
        b=cciLXdBxbFDGFWOR1ei0qO3sJWiggKU8NNTueRbjCTfj3h0j8bbPXOV+KEcv1JJC+j
         p73O9LbvMBEeNHB/qYhLHMp+irqpCEBA8jab7CSyMfflb3EQw82UGzXX+nmwgcQ6d7Ul
         mOqSQrqnU4LolJ+Gjrq0xZyb2lDnuVOeYnEKXpeUPKFtfeyvhgc+jE4F0ki2g4YbRdTz
         xmfrWjFW28x6ZyIKoWT9jpfxjfszrxcdqvgEzkQmYz/1HWnqSoINQUuMPsgQXYacS0pe
         9Ozlq63KiAsdT0LC/JyQqpCMrukyl0SUMVeCvTnyXVCm2giyNwP7fgEI3l7NC4elpriG
         e3DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUDWgPb74XJy2xIRpANPKGar0qIxje0B4Fbkc9vRlFDEeYBzdOGbNQ99tXzKxBeZjaMgFRtXJoJFKggkNFeD1O7VZLVMzOQ0Ic5HQOpTaL4ncRV5pDel4wAKvebeVxqpTRGWfqGXGgYUN63++5a87SkwXpOReLAZs7Z0PMWDXQeRoq+g==
X-Gm-Message-State: AOJu0YzqemrEs1OpFMxxv2YO8cOkm9e+eo1/n3uBLRSf33pJjD7lOl/W
	yYtc1HEF3YjwymB3qgh43sBC7QXdf6FTKCwM7XwnVjJ78fOs60UC
X-Google-Smtp-Source: AGHT+IGDyqBgNFFll4mE4oRSotvuKucjZDNVPTEEuoznkPGqJXeFtlRNdg2zCa20QKWjdZdYJc5HcA==
X-Received: by 2002:a17:90a:c293:b0:2a2:fec9:1bbd with SMTP id f19-20020a17090ac29300b002a2fec91bbdmr6076126pjt.17.1712385269834;
        Fri, 05 Apr 2024 23:34:29 -0700 (PDT)
Received: from localhost ([46.3.240.101])
        by smtp.gmail.com with ESMTPSA id ei24-20020a17090ae55800b002a386a4d6b0sm2367991pjb.6.2024.04.05.23.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 23:34:29 -0700 (PDT)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: u.kleine-koenig@pengutronix.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	inochiama@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v6 0/2] riscv: pwm: sophgo: add pwm support for CV1800
Date: Sat,  6 Apr 2024 14:34:11 +0800
Message-Id: <20240406063413.3334639-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sophgo CV1800 chip provides a set of four independent
PWM channel outputs.
This series adds PWM controller support for Sophgo cv1800.

Changes since v5:
- delete the OE function because we plan to use the counter subsystem
  instead of capture, so there is no need to reuse this code.
- fix set polarity reverse error.

v5: https://lore.kernel.org/all/20240314100131.323540-1-qiujingbao.dlmu@gmail.com/

Changes since v4:
- drop filename
- fix macro
- optimize cv1800_pwm_set_polarity()
- optimize cv1800_pwm_set_oe()
- add comment for cv1800_pwm_set_oe()
- use ticks replace tem
- fix duty_cycle larger than period_val
- use devm_clk_rate_exclusive_get() replace
  clk_rate_exclusive_get()
- map linux polarity to register polarity 

v4: https://lore.kernel.org/all/20240304085933.1246964-1-qiujingbao.dlmu@gmail.com/

datasheet Link: https://github.com/milkv-duo/duo-files/blob/main/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
page 614

Changes since v3:
- use macro instead of npwm number
- add support for polarity feature
- add support for Output-Enable/OE feature

v3: https://lore.kernel.org/all/20240223082014.109385-1-qiujingbao.dlmu@gmail.com/

Changes since v2:
- use 0x08 instead of macro
- split if statements based on conditions
- in order to round up, first calculate the
  number of high-level cycles, then subtract
  it from the PERIOD to obtain the number of HLPERIOD
- use new pwmchip_alloc() API instead of old style

v2: https://lore.kernel.org/all/20240212121729.1086718-1-qiujingbao.dlmu@gmail.com/

Changes since v1:
- drop full stop from subject
- re-order maintainers and description
- pass checkpatch.pl --strict
- fix naming errors
- add "Limitations" section
- use a driver specific prefix for all defines
- using bool instead u32 in cv1800_pwm_enable
- check and set state->polarity
- use mul_u64_u64_div_u64
- use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
- using macro definitions instead of shift operations
- remove shift operation on 0
- use priv replace cv_pwm
- hardcode npwm
- set atomic to true
- remove MODULE_ALIAS

v1: https://lore.kernel.org/all/20240207055856.672184-1-qiujingbao.dlmu@gmail.com/

Jingbao Qiu (2):
  dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
  pwm: sophgo: add pwm support for Sophgo CV1800 SoC

 .../bindings/pwm/sophgo,cv1800-pwm.yaml       |  45 +++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-cv1800.c                      | 296 ++++++++++++++++++
 4 files changed, 352 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
 create mode 100644 drivers/pwm/pwm-cv1800.c

-- 
2.25.1


