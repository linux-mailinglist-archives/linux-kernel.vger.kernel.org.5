Return-Path: <linux-kernel+bounces-1111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9849814AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9C71F21AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D52C31721;
	Fri, 15 Dec 2023 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eg04Tt0l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE6DDAD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7DAF93F2BA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702651149;
	bh=RndXzFv9dRc3apfX7gXyeZVRNhEetAJ/uCjHbnQO3fY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=eg04Tt0l7q40yCOrJM3ra/4+dA3KXpXRil5b/p4n0vGaHJofAMQefStlycK6r9AJa
	 0rjO7aVLvd16AV3cuPG5TAMdANEUUEdvHzt23qmteoxHqIjGfM/5SMahjdY6SPOqkm
	 0tvLz+1hfi19uEFHQ3R00cRR5qp5lT4KSbHn4QgYVL0gw1gM9q+BOQ7q8eZ56ubTRU
	 3rZgBzVBQOnDFvULVy9Y6fakmcjHt9VpXE6nnHFQ6M5jlyDjmtispoW7gWOJePT8zf
	 xaCkcmHzGBhkJPil2tpT427HWOUw9zPBMx+IDcrRDx965XKNmpXnG4GzvB3UXaCnFS
	 Rnu18YfhX3qDw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a22f129e5acso43415166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702651149; x=1703255949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RndXzFv9dRc3apfX7gXyeZVRNhEetAJ/uCjHbnQO3fY=;
        b=XLFtMs8hgGEt8vNhBZEwuwP4wvqQ5PeQsXaSjqqk6v18w/zbbNbufrElcHJ1DHAROc
         bfjoPNkiR2fZYRitA0oILE15a0xp0repGMUMCFcq3VZkGIsd5fNR3pMU2C7AjHMViipi
         mXgSNBJ2jt1o7MmWYn1gsvwKjrN8xR7GbyOkIiIqlHDYwb+iwPcLlyYmW8MGYKJY1bP3
         ktPxf5yyVU6RFMjPN64ares1xrCn66tSEw9/GRScJB5k7VPMVP//NRBB8W2mK3GQqAhI
         c3ZiISNoVwykdEJlOgulE8Nh7VwO9F8i7h6PEOtwIcdK+SvODr6fTCTQSdztvGAWAlOx
         tHqQ==
X-Gm-Message-State: AOJu0Yw2jVQXUIvPNqB65rgjNXiEuFnAPWxJ64vIz9ZUUoEG9NMybgNJ
	99kDktMcViNuncRLiZCjIg07BZRz2Ah+IRYT4KJ7kf0zZDKTXEMUBthZvu62OMLm6DXe44G9nwb
	o1w1Xyhq2yYlUuKC52h8FsTDeFq0tZ6VSfMV0ERNbQQ==
X-Received: by 2002:a17:906:f5a3:b0:a1f:5c21:a577 with SMTP id cm35-20020a170906f5a300b00a1f5c21a577mr7202627ejd.152.1702651149201;
        Fri, 15 Dec 2023 06:39:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3QbInfkk0AitjzXyJOwIcvtQstPOCuRyy+iC+Mz5KWzxJEUlBa6uywj+At/OAf/HstQ4J2g==
X-Received: by 2002:a17:906:f5a3:b0:a1f:5c21:a577 with SMTP id cm35-20020a170906f5a300b00a1f5c21a577mr7202607ejd.152.1702651148915;
        Fri, 15 Dec 2023 06:39:08 -0800 (PST)
Received: from stitch.. ([152.115.213.158])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1db955c809sm10789122ejc.73.2023.12.15.06.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:39:08 -0800 (PST)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Hoan Tran <hoan@os.amperecomputing.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v1 0/8] Add T-Head TH15020 SoC pin control
Date: Fri, 15 Dec 2023 15:38:58 +0100
Message-Id: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a pin control driver for the T-Head TH1520 RISC-V SoC used on
the Lichee Pi 4A and BeagleV Ahead boards and updates the device trees
to make use of it.

It can be easily tested using my th1520 branch at

  https://github.com/esmil/linux.git

..which also adds the MMC, PWM, ethernet and USB drivers that have
been posted but are not upstream yet.

Jisheng: I've added this driver to the generic TH1520 entry in
MAINTAINERS like you did with your USB driver. Let me know if that's not
ok and I'll create a separate entry for this driver with me as
maintainer.

Drew: The last patch is purely based on reading the schematics. It'd be
great if you could give it a spin on real hardware.

/Emil

Emil Renner Berthing (8):
  dt-bindings: pinctrl: Add thead,th1520-pinctrl bindings
  pinctrl: Add driver for the T-Head TH1520 SoC
  riscv: dts: thead: Add TH1520 pin control nodes
  dt-bindings: gpio: dwapb: allow gpio-ranges
  riscv: dts: thead: Add TH1520 GPIO ranges
  riscv: dts: thead: Adjust TH1520 GPIO labels
  riscv: dts: thead: Add TH1520 pinctrl settings for UART0
  riscv: dtb: thead: Add BeagleV Ahead LEDs

 .../bindings/gpio/snps,dw-apb-gpio.yaml       |   2 +
 .../pinctrl/thead,th1520-pinctrl.yaml         | 156 ++++
 MAINTAINERS                                   |   1 +
 .../boot/dts/thead/th1520-beaglev-ahead.dts   |  83 ++
 .../boot/dts/thead/th1520-lichee-pi-4a.dts    |  28 +
 arch/riscv/boot/dts/thead/th1520.dtsi         |  53 +-
 drivers/pinctrl/Kconfig                       |   9 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-th1520.c              | 796 ++++++++++++++++++
 9 files changed, 1113 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
 create mode 100644 drivers/pinctrl/pinctrl-th1520.c

-- 
2.40.1


