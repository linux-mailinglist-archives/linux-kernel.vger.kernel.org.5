Return-Path: <linux-kernel+bounces-11467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC5481E6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E1E1F22900
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557A04D597;
	Tue, 26 Dec 2023 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg91eduB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A204D118;
	Tue, 26 Dec 2023 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d45629a37eso8489025ad.2;
        Tue, 26 Dec 2023 02:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703585080; x=1704189880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1CUlK5GWpbi34to/D5VO9Fxv3S6uw4NY832Uic4+4Js=;
        b=Qg91eduBhtjZs7uCi/PkTK7iW2CPyJzDhntuBWslOs5FxnvWl1KSGzF8TqRNtHu//5
         ReNLXplnWhv/LwiWGLycOWO+gz6e1Fc4oE50ENFwbKUaDHDBkbvKGSZ9GeQeE+lKIRUL
         /S3+mLBmORvm6Rh12UOQzvfZtrbIcC5v3nwleXnxMmb+rrCi1zTlrY0JI0KFzFhuASjJ
         bkxn6y1BBHB7TWRCaX5uc/Rq0Dd9HJaSZ0uOyvS45iJtjgZsWW9afYZOtUvHm3Eo+qWW
         lT2QmdJtTp2+Vks94Vqrf2xTIyxEQfEkgOEes8dEYp4Qi38ewSWj+OyYIod++iCZkRb6
         RE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703585080; x=1704189880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CUlK5GWpbi34to/D5VO9Fxv3S6uw4NY832Uic4+4Js=;
        b=iGAYCvOk6l4qMtIrcw/MXoEYkcRUM5d9W3R9tKWpymU6vFNtHsL887kHeDC9JrIOfU
         n8LTcXZJM5kErfDifftysYHEKDnG49sg+OCCt2CnhtO9h4d8G7ciqWCayAdhEjvC8v0e
         Xfl7FgB9Umg1R6m4iAiTRgdP/AIyFtDezVLLwdvpiaBF+xUhgkv4HsjExpEXnNPxM7rx
         TJeBnKYMJGYTxKFNvA9PxG8PgXvJ02OI76Bynl6EbQI/c1o6qblEPXnf8tlXjAxwcd7k
         pd4PNFdhknbRMYaHv25YQvJi0bsuIHO2viMkMZVXhatvlHi1iytsCGQdZiZEpMoAOjOO
         eHbg==
X-Gm-Message-State: AOJu0Yxz1GmpavJEbPPPzLcbTZ5PNHeioKUOmpQjdmQpJ01F5WOzJaWI
	+i7FnxY+fz29vhMYZx3LQVQ=
X-Google-Smtp-Source: AGHT+IEeHwdHS+0pMSSnOm6TXt3AkkjOHQ+9z+r0gUx+hgjkbs6xYNQSsAWHMd5DpvxxmN8oWytnMw==
X-Received: by 2002:a17:902:bd94:b0:1d3:f285:816c with SMTP id q20-20020a170902bd9400b001d3f285816cmr7319451pls.25.1703585079460;
        Tue, 26 Dec 2023 02:04:39 -0800 (PST)
Received: from localhost ([46.3.240.106])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d30200b001d3961217a1sm9682272plc.102.2023.12.26.02.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:04:39 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	conor+dt@kernel.org,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v3 0/4] riscv: rtc: sophgo: add mfd and rtc support for CV1800
Date: Tue, 26 Dec 2023 18:04:27 +0800
Message-Id: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch serises are to add rtc driver and providers by writing
and reading syscon registers for the CV1800 RISC-V SoC. And add
documentation and nodes to describe System Controller(syscon).

This patch series depends on the clk patch support for Sophgo CV1800 SoC
patch series which can be found at below link:
https://lore.kernel.org/all/IA1PR20MB495354167CE560FC18E28DC5BB90A@IA1PR20MB4953.namprd20.prod.outlook.com/

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

Jingbao Qiu (4):
  dt-bindings: mfd: sophgo: add MFD subsys support for Sophgo CV1800
    series SoC
  dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
  rtc: sophgo: add rtc support for Sophgo CV1800 SoC
  riscv: dts: sophgo: add rtc dt node for CV1800

 .../bindings/mfd/sophgo,cv1800-subsys.yaml    |  51 +++
 .../bindings/rtc/sophgo,cv1800-rtc.yaml       |  45 ++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |  11 +
 drivers/rtc/Kconfig                           |   6 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-cv1800.c                      | 417 ++++++++++++++++++
 6 files changed, 531 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sophgo,cv1800-subsys.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
 create mode 100644 drivers/rtc/rtc-cv1800.c


base-commit: dc0684adf3b6be6b20fec9295027980021d30353
-- 
2.25.1


