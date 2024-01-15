Return-Path: <linux-kernel+bounces-26214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEB282DCE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96C01C21D07
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2654E179A8;
	Mon, 15 Jan 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2/cTZ3S"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954C17735;
	Mon, 15 Jan 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28be8ebcdc1so5886299a91.0;
        Mon, 15 Jan 2024 08:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705334766; x=1705939566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yDa16CVmSfs+N/D++bcE7PtMkJn0aFkGKpqTBxiLGsQ=;
        b=L2/cTZ3SFqh+QfzKCvu9u+OuK4YEShFfgKf+tQQXZBgMeOkPKPN49Apb7f9gV4chgT
         nA3g05Ssn8Zp27ooBNPIvX5a5gx6ZwF0XtwJnfHMpq+qkak9OVImEt5HNSGCwCHsk9Uf
         /3jKJe81kiE5s/CN5EhC/kR5cZAZLgfJuBfLs/eToDAf0dYnE7h91w9OCC/JUVoGhNGc
         9TD9F6WkeoweSpbJv2Lv/7ienI3Yl/8h2bXTgCWne1XHyGJLCP0yvpJsbHFUhjdrWd2+
         NGLXb5AkyeZQqEwMuGG90faEABWxXcFOkKZas6yEp+nT2Ou1JwPX1tY1laJUv7D4k3K9
         Mg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334766; x=1705939566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDa16CVmSfs+N/D++bcE7PtMkJn0aFkGKpqTBxiLGsQ=;
        b=v4LvO/EqDsCB9mw0IfzBwhCiB2m4elrfghIMaIIwAoOMbcabNWER1fxyNR7YYacUKK
         Qg3I8Cfonn0vAEdNFCoVls355YOhAOACv4NYhhN2JCwfNlzgqHycS7YebuLi51YX2yf0
         XVyLBJghrsykwzsxhshbyuNz5HyeHt0dCmNz7pf7MAbSmBaS62JhfPfhZbGP0AJpmB7H
         ftFP5C6YJ5ms1ARPeUUj2CMAs+s9Fexlkf+DLVYPBjegAqCA9avtjzcWHIZaozu0n2Dd
         TlWf0kAWbf60sznTjUcd7c6BhdOW8rd1G+0F3D8/bRhhn7pYn6+sv/PRN1l6/I3O7tir
         gNjA==
X-Gm-Message-State: AOJu0YyD7KryRsnRvncM7BiSy11ku2cb9v8xJfNHfuJbCZ1Y2fsyKY/v
	lber4nR8flqJCf6y7x03P/U=
X-Google-Smtp-Source: AGHT+IFJtE0KE+EoKxq7n4ougV/OrUqltD5x3+pgimBp47DSgYBBvcKSSCZGIhA8medm7ns1Q5Q18w==
X-Received: by 2002:a17:90b:1e12:b0:28c:f9d8:14e2 with SMTP id pg18-20020a17090b1e1200b0028cf9d814e2mr2927632pjb.84.1705334765968;
        Mon, 15 Jan 2024 08:06:05 -0800 (PST)
Received: from localhost ([124.131.233.112])
        by smtp.gmail.com with ESMTPSA id li16-20020a17090b48d000b0028e55789456sm2313340pjb.24.2024.01.15.08.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:06:05 -0800 (PST)
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
	dlan@gentoo.org,
	inochiama@outlook.com
Subject: [PATCH v6 0/3] riscv: rtc: sophgo: add mfd and rtc support for CV1800
Date: Tue, 16 Jan 2024 00:05:57 +0800
Message-ID: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
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

 .../bindings/rtc/sophgo,cv1800-rtc.yaml       |  55 +++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |  12 +
 drivers/rtc/Kconfig                           |   7 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-cv1800.c                      | 397 ++++++++++++++++++
 5 files changed, 472 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
 create mode 100644 drivers/rtc/rtc-cv1800.c


base-commit: e3d3fe7e7bf08820a83c9d9a4c38c7b29a2927f1
-- 
2.43.0


