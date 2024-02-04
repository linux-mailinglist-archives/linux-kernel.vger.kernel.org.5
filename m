Return-Path: <linux-kernel+bounces-51421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51821848B08
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0709D1F224E4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF590567D;
	Sun,  4 Feb 2024 04:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WezNAy1k"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9845F7465;
	Sun,  4 Feb 2024 04:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707021711; cv=none; b=NdzV3MwBJvMaBYsFtjbCFtmk4XdmOwLrsPwozYV2O1ZCi61XD7zZWuD4xIz+5Z4ZLQT9nmNi1qBM2nxiIO6bWCBtn9/CduALJHDIJuyh3J2hoJmH5NLQd9DdYtG3rOv8j51xWzBXyid3DQrTdHfBfVANAoumVFuEX4P8RYNSWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707021711; c=relaxed/simple;
	bh=5CIQZqU/kTFql5U7w0IfdvvLCXcwQ0T/TQR5IS2Nuc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EaMNAEQrSVxhSFppaV3EkoDv/IZPnj17KDu1B6VsUPDjRCinm8qmp5hV9s47h3iQI8ezbtGJXoJXG4sef7ZD/68UW37tcdj8niffCtsf7TmG+qY2HfnD6Y6q+tSq+ibfBA4zEzRLiUtule23H8zw9o/m/N0Qih7jkKciObWaZfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WezNAy1k; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-219122781a3so1563029fac.0;
        Sat, 03 Feb 2024 20:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707021708; x=1707626508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgmHFz+Xk+6A9/RwIzoD4Dc9GjLBm+z4wSxjnBlgbxc=;
        b=WezNAy1kJQNlgm08LOmia47PdkBygapAyrv+YgsFIcaC6j2it0JRs1QUCfbODvuzas
         VefYFR16G3u4KMeCXAkqzZe00aBATieY0sHygPze/cvpESENsJzgT78E+2fbLJiT0VHZ
         KNXwUGWsw+wdUSuKw1F7YYSSjDEniealXVona6ZuqDI/uI5s+I0B9vpuj4zV4rQIDstw
         +4XJ2aMSgZxjuGuqq9QGC6UUgPz0HY6IbSpqgZvVSngxlIvW8lAURJI+PUOkK0lmWpjT
         41GdSf+x9U4Hqn/rFm1SDCqoDgGqbIehhvuuJzTDUog5SK8CT5sCpbZHrPQmJzFGpsyy
         9XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707021708; x=1707626508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgmHFz+Xk+6A9/RwIzoD4Dc9GjLBm+z4wSxjnBlgbxc=;
        b=Rmzfbh/Uc7HSXzLr18T53uMdySbpFEUTpkHT7bKd4P18gP4VJTSAD32x/ectiw535A
         wRFrmab6WQh6IFVroCDPbUaf7ClxoQFX2Iu9gtQZgJnhEMdzZzAYogkvkqckDJ045fDk
         DswaCcrZOmYfDfvfxqm3g910gPyBAtPR3WMyzzggVS4DoUyk9kPEfheGGZUz3B0S9GpE
         6SwoIu0kvFzYAqh8cstTZFR/sIC+KPZsXQIS98F2ukssL/+NOWxlH2pK9b8Zkc57z0dv
         bkjtLibXGuH4mc6UiyN8KPX78e1ulOUGdg+V+10XoNvWTil60MsVzhzgUlEAChN6rc6T
         d+dw==
X-Gm-Message-State: AOJu0YzRQmuu2mvRBrRfgEZCbh5Y2ut21o6tO8IaKSVK+ljAWG4ABg70
	Jy9QfURW9ygxutDb3u7bgC75RZqHx+SzE4fVCgXAtokluYTwFxqt
X-Google-Smtp-Source: AGHT+IFFM4Vp1BsRD2dVg3okDLnZ1VXXZcFiiPAV/eHbmsfRJl7TYPlNqChh88xjqbfTwufiRWx9lA==
X-Received: by 2002:a05:6358:d3a6:b0:176:6144:2f12 with SMTP id mp38-20020a056358d3a600b0017661442f12mr7086743rwb.28.1707021707949;
        Sat, 03 Feb 2024 20:41:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUvyQx6zoriB7VAb/IDCS0btlyL7AGBm+GaaObRwS03V+4J8iVYSA2KO3/rIhk1rPjy3R/D//0EBUoa/yqCOzmvvfpe6RLj4kdhyuZo6HvC3QX3fHoZOodkavTIHpgvNs4BWUh1yuz4qMozAvr9D6CTX2lT/9SpVzDqpuWewKyyPeFQwUd4PKgrQB0TKYsJiP+LD8oCtet4Pxr9wxMgQuDwZpmPd8iAS3mcd7ryytaTEpLXchfIvX9SUflbJNsNpM3C7WLWroz0xV2hCmX5g2tLUtOHQbWScNJypMwfGonRp9Y4osTViuBSDxtC/MyA8mZkKRnbCj1C7LULgap65bz0yjt1fYWzj9KuujANhQAtBlwobJ2Un95bQ2QJ6fpbV6lWXMkZGW0ocAtRDDKa1r8vY1WUG4GG5K/fxlmA
Received: from localhost ([46.3.240.105])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090aa40c00b002962f35fb42sm2463096pjp.48.2024.02.03.20.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 20:41:47 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v8 0/2] riscv: rtc: sophgo: add rtc support for CV1800
Date: Sun,  4 Feb 2024 12:41:41 +0800
Message-Id: <20240204044143.415915-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Changes since v7:
- pass checkpatch.pl --strict
- using u32 replace uint32
- using devm_kzalloc(*) replace
  devm_kzalloc(sizeof())
- sort header files alphabetically
- delete unnecessary header files
- fix wrap error
- drop dependent description
- using hardware automatic calibration replace
  software calibration. see documentation 197 page

v7: https://lore.kernel.org/all/20240122080500.2621-1-qiujingbao.dlmu@gmail.com/
documentation: https://github.com/milkv-duo/duo-files/blob/main/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf

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

Jingbao Qiu (2):
  dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
  rtc: sophgo: add rtc support for Sophgo CV1800 SoC

 .../bindings/rtc/sophgo,cv1800-rtc.yaml       |  53 ++++
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-cv1800.c                      | 244 ++++++++++++++++++
 4 files changed, 308 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
 create mode 100644 drivers/rtc/rtc-cv1800.c


base-commit: 14688f1a91e1f37bc6bf50ff5241e857f24338e0
-- 
2.25.1


