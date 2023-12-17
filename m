Return-Path: <linux-kernel+bounces-2537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEF8815E9D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6CD28335D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7956412B8B;
	Sun, 17 Dec 2023 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKmCCQ1x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742D12B7F;
	Sun, 17 Dec 2023 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ce72730548so1991978b3a.1;
        Sun, 17 Dec 2023 03:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702811397; x=1703416197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+EtlZiwlm8KczOLlitJXiVEJHfbSu/VD6TJIFG6u3g=;
        b=NKmCCQ1xTxAnV1KaakqJCKJpjE31XY7yMCP4z2+MlXfPgESTnBcDPAKCEoMZYQ2sz9
         uKG/XhnjkApJ2ydTQcYBt6CtMTzYZsDgz0V6A28MtqnL/7Q32BTq/dMo135yDDkKKWQ6
         SPYQeWBrLskklZBDfR8ZvrlSgq0/ChpyVAjNsP1T4vkWhIVl019td2cP7dJ17wg+L9VY
         VVoTUx/OeovDBDmvxEW0xGaXGGPLroUL2avQZ45NA+Zlt1r9kFHBxyzbAxW4vo9KuULR
         WdQIMqgU0pSs1hxxNcGkk+DLF+SvtBw2NGhw3eVCINVqlq18PRwzqX4xdoc/kaqDF+oz
         vA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702811397; x=1703416197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+EtlZiwlm8KczOLlitJXiVEJHfbSu/VD6TJIFG6u3g=;
        b=RiV65ZRpb0QLMMmMGT5s0JmGa4ZblYLeH9ROjznth/fDDaPvZbVX5spYqQRv+/k7l/
         m4XEJ7DCQvsnC7x6MDVNZpl9hCv9sYaP/WLAOl+UCuBq7ufEoqzTXLFt+TIsdOo7Ovgz
         1CUrau2B+jAou6Y2TdCm6wonB/uK+3hJ37Qk37ie0WYxrw2/exh/5IHuYyY9ncmKrqym
         3WlMl6RkjfJ1n/qNBTX+Zv73bdsCKgiyspb+GZaMnKpl4JCWEIKdkebMxUAXxMcAmyEU
         /L5WWd444BF00eEIHSJiLSKhTK6pBXkA0EVtkjjsPzcrjAdJm6WpKci8GMcyd/V4TTAm
         hh3Q==
X-Gm-Message-State: AOJu0YxIf0fuKh8HXdJiTK5L7Ln/JI8GHPiaTUqP8EwZNlsQTmfA6NNr
	QjHezu/5RR30/4p8wNTGlCs=
X-Google-Smtp-Source: AGHT+IFsZLc8+AH/LNmidkz/F6vMB7TgSOPB/fvu8X4pUlf/tSmLZK4iHAZwwbHxM/0UPpQehQHTxg==
X-Received: by 2002:a05:6a00:4b4a:b0:6ce:2731:e86f with SMTP id kr10-20020a056a004b4a00b006ce2731e86fmr16473766pfb.54.1702811396604;
        Sun, 17 Dec 2023 03:09:56 -0800 (PST)
Received: from localhost ([2404:7ac0:4b9b:50b6:60f7:12fd:f360:3ff8])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78645000000b006d6bd97ba73sm412351pfo.159.2023.12.17.03.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 03:09:56 -0800 (PST)
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
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v2 0/3] riscv: rtc: sophgo: add rtc support for CV1800
Date: Sun, 17 Dec 2023 19:09:49 +0800
Message-Id: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds rtc support for Sophgo CV1800.

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

Jingbao Qiu (3):
  dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
  rtc: sophgo: add rtc support for Sophgo CV1800 SoC
  riscv: dts: sophgo: add rtc dt node for CV1800

 .../bindings/rtc/sophgo,cv1800-rtc.yaml       |  47 ++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |   7 +
 drivers/rtc/Kconfig                           |   6 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-cv1800.c                      | 400 ++++++++++++++++++
 5 files changed, 461 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
 create mode 100644 drivers/rtc/rtc-cv1800.c

-- 
2.25.1


