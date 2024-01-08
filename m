Return-Path: <linux-kernel+bounces-19134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65022826883
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F61281CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAD98BED;
	Mon,  8 Jan 2024 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEvEfP6I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBABBB642;
	Mon,  8 Jan 2024 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3f29fea66so2218095ad.3;
        Sun, 07 Jan 2024 23:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704698579; x=1705303379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KL7gT6puPppmRM1GkmcMzs34cYrfX1sUZhG5f+PKXuU=;
        b=cEvEfP6IKlCXmJnV662Xszfwv6IQHkt5VYEqh4r8whL7khUs3eNfKD/30ni817rNMT
         KbOmCQ7rrNO0IrMI5xYBwwhiGfStAZVNYDDqsHXwmCYLWrsYZeAvaya/AYfo9yzfQvly
         5a04m7eIL8CdbXAx5ktNw9MqzSMMbhq3eV4mUF43S8HlhQQSik1eQSamcidNh0dx3YBu
         ewh6Ng/mNliQfW+JFM8ZX1Mp5jP09YDVRMO9Xy9CrpH++l0d/n2U0QHkqhWbwYETLotJ
         Ns/017+JGtrnOI1nKOvFVlvFaznaWq7TAscynlgYWdLTieWm6EZKq5L+qANroCuGXhbS
         qfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704698579; x=1705303379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KL7gT6puPppmRM1GkmcMzs34cYrfX1sUZhG5f+PKXuU=;
        b=doXM0wHt0G4g5QiMlh73tVZ9UILN+UsVHQw8idnQDer9G3yfC3RLGLIXGXoB+CLAW1
         L4r3nvhtQDZCTDz1iRXFlIBSaJIbAoqH+jUEluvLPbZVKVT0Mpi+Pk/OWHTqg58DLPvT
         y4KRNulFbXfM5C4O8m4zvBfuWICbhJjvu6VB2zxRGHSxb48hNqCHLoKq/9tzhYO5IL9N
         fH0IvCjBsbDN2Xic6prX6D/dw1IT69+HUNsQtLm+TCMi3fdwF3uwGglihRdBfwBPxF4E
         +XeTanBPZ90xfW8rXH/IvCvCO/JJqq19uQfwXfnAf+g/mmeHNXw7n0aqPT0XrdKbkiI1
         vGjw==
X-Gm-Message-State: AOJu0YxupKAnqJATX6FqftSUlAWOhAysd5E2GyCoLUVLCEsfX/gIbzez
	XvcteDJftlSMz2GoseVDNE0=
X-Google-Smtp-Source: AGHT+IHerh2T7NqW3Km+xaQexJgE0/20k8yDrEK+JEJuAb6XnQTKLMJIrdIbYrZvzwpQ+g/sWFaMQA==
X-Received: by 2002:a17:902:db0b:b0:1d4:a31d:f260 with SMTP id m11-20020a170902db0b00b001d4a31df260mr1146867plx.74.1704698578476;
        Sun, 07 Jan 2024 23:22:58 -0800 (PST)
Received: from localhost ([39.70.12.102])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709026b4700b001d083fed5f3sm5524212plt.60.2024.01.07.23.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 23:22:58 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/1] dt-bindings: riscv: sophgo: add RTC for CV1800
Date: Mon,  8 Jan 2024 15:22:52 +0800
Message-ID: <20240108072253.30183-1-qiujingbao.dlmu@gmail.com>
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

Jingbao Qiu (1):
  dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC

 .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml


base-commit: 92c255c7157a07614f3e1df4eb63fbd49bc738e0
-- 
2.43.0


