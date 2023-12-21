Return-Path: <linux-kernel+bounces-8191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7481B35B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171C3B236D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C922351037;
	Thu, 21 Dec 2023 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NAac0Ov0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B154F5E8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55435a07fd6so172058a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 02:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703153769; x=1703758569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e4JFHYci+V3luhkXhhHRIy5zeJUOwtYsr3299HW+LRg=;
        b=NAac0Ov0zKsTtzZZh/J/we9wUjPont0lKmzNydg1BISuuj8hgPhrzWiMJLIMMSo9es
         zRD9XYM3QzbKdDsSbU1Jja8GldzobYVjE6H1rGCOOeVfMmx5rUEOvEm/fEblDQv39k8A
         EGMQ6Q1GjS0K8TVkgO5I0ksRI5Ol5vYNdXkt7I+cYuXRHa3w/KiZspK9fsDQQ9CmKl2J
         6qwB7G34+mVKVnqv124Ck+VGmnRE0JQJ8Duas9Er1tOnP0Gv7f0+1KufdedMW+fb3cGp
         /lx4gbDHgm48JuJ9hrJHq33phRN+Ex9UDaLDQHc50+Ss8fu7Ptk6cjG1DHW6RrD5r9tg
         lHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703153769; x=1703758569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4JFHYci+V3luhkXhhHRIy5zeJUOwtYsr3299HW+LRg=;
        b=AZpfRduxycVfKGMTejfE+lkJ7BhxdfAu1Aar5XWVv06Le/WTcgUjsOiTr0hIq2ux+N
         5S0WZwc8u3KJPqVkhDMA7iigTwDT8xuLfWXIDdvk2xZQZBbON88p/7Ajz+EHjEQPFdFK
         zk1ajagPk8deqKLX6kxGN8Grs4kM0DfV7BMluLIstsTmGxfNa5baQbrHcGvtGtMVkSSC
         lkLvkVzRRnzcwrIY70Y+qhS37CUt6Ip9/OyIs8rBU7ZFigZWIpzd/ntQmB8gzbcoGEOi
         GcFcYnWr1C2MF7v79Q6M9ZWZ+DTUxJCOiHGdYviMJlPcHyN8Wodq9JvsClyeQjF5CcC2
         pt0Q==
X-Gm-Message-State: AOJu0Yzf7jEBtvDQSrqnQldP7KRlyFNw/WkXqbZqcDdYeR6P6eS/1Dtf
	K9EDUG5blYfvok7T0q3qejVCee4Y3obaIQsn0LMpyg==
X-Google-Smtp-Source: AGHT+IGHJIo+/xtR4/sf5Ls5VqcvbKgjx0YZl6mliy24uXe3pckW1SHv6SbBkCcMr/z5auN4LgzRmw==
X-Received: by 2002:a50:a6d1:0:b0:553:2b99:ce52 with SMTP id f17-20020a50a6d1000000b005532b99ce52mr3895145edc.37.1703153769637;
        Thu, 21 Dec 2023 02:16:09 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm962868eda.44.2023.12.21.02.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:16:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] w1: drivers for v6.8
Date: Thu, 21 Dec 2023 11:16:02 +0100
Message-Id: <20231221101602.15826-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.8

for you to fetch changes up to 93c4bb3666a3d463c73a66ab3cc78a4c4b83631a:

  w1: ds2433: add support for ds28ec20 eeprom (2023-12-20 09:25:25 +0100)

----------------------------------------------------------------
1-Wire bus drivers for v6.8

1. Add new AMD AXI 1-wire host driver for AMD programmable logic IP
   core.
2. Add support for Analog Devices DS28EC20 EEPROM to existing DS2433
   driver.
3. Few cleanups in W1 GPIO driver.

----------------------------------------------------------------
Kris Chaplin (2):
      dt-bindings: w1: Add AMD AXI w1 host and MAINTAINERS entry
      w1: Add AXI 1-wire host driver for AMD programmable logic IP core

Marc Ferland (5):
      w1: ds2490: support block sizes larger than 128 bytes in ds_read_block
      w1: ds2433: remove unused definitions
      w1: ds2433: introduce a configuration structure
      w1: ds2433: use the kernel bitmap implementation
      w1: ds2433: add support for ds28ec20 eeprom

Rob Herring (1):
      w1: amd_axi_w1: Explicitly include correct DT includes

Uwe Kleine-König (3):
      w1: gpio: Don't use platform data for driver data
      w1: gpio: Drop unused enable_external_pullup from driver data
      w1: gpio: rename pointer to driver data from pdata to ddata

 .../devicetree/bindings/w1/amd,axi-1wire-host.yaml |  44 +++
 MAINTAINERS                                        |   8 +
 drivers/w1/masters/Kconfig                         |  11 +
 drivers/w1/masters/Makefile                        |   1 +
 drivers/w1/masters/amd_axi_w1.c                    | 396 +++++++++++++++++++++
 drivers/w1/masters/ds2490.c                        |  25 +-
 drivers/w1/masters/w1-gpio.c                       | 118 +++---
 drivers/w1/slaves/w1_ds2433.c                      | 162 +++++++--
 include/linux/w1-gpio.h                            |  22 --
 9 files changed, 659 insertions(+), 128 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
 create mode 100644 drivers/w1/masters/amd_axi_w1.c
 delete mode 100644 include/linux/w1-gpio.h

