Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC9B80C9A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjLKMX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjLKMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:23:02 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17819194;
        Mon, 11 Dec 2023 04:22:37 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1d0897e99e0so24342115ad.3;
        Mon, 11 Dec 2023 04:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702297356; x=1702902156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IQcvSnsM7JavnmPF12NfssHoIsVHQjXItCQk6VIN4nQ=;
        b=dPiAiuLx4laXNeDcu9kXZYQE5UFQ5fA+6/rVysXt+iGPdmPPi4u9WrI49lij4r7ztF
         VV0XenvdSQrkT3e8AvuZXXOsxMdE3E70i7H5SqYap6WyxksMm6ZEDqmiUxguqVFybRQE
         BbRlhPbDhh+JjhPjhq7sQY1KihTRcnlgBx+U/n/xXq06KFMpUsDSM88H05Vm8uJj+8oX
         yqfLYOmk+1jDtu8C9Tke3TsZbV15lFrHPYIzZ2K9YmJnyKOPpCV2ZIfxa81/fnqlj7Gn
         coN3eGKla3H98UyBFgcXHY1TEG+UG7ZVggghqfpA0yw8V8iFE5EPRPrtqSPhP+ft2pJX
         Vdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297356; x=1702902156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQcvSnsM7JavnmPF12NfssHoIsVHQjXItCQk6VIN4nQ=;
        b=BZ8nVXZuoBZTh5DRuDI+KVqs2ykvoIljGhrQ6N83sUumPcIKbHfpfqbAPI5dJp0vYE
         w4IGFm0KUb6EReS8n9xkv7klyGotssi4DoEw7AoOxvZADBxZK9koqF0kU7YVpyNB5RaM
         ejMxSm9IEMeDNnvCEcm94r/KKvk0LY3/Z30YCkeHiFHq0pmX0ooMQn1vWEdw8gI619lQ
         G73mKvRGsBx6On/pXQ2DGUXLcDAZCPTUJZlIySMSkY+s1j8WCkI5qVy0rz84GSxoYmQc
         ZDGw2qA3gdXR38yqCaiuwVmBjNFf2+DYdDI8xwjIefPT4O1j7EjCmpfwME9CjZSYiqWm
         PBNA==
X-Gm-Message-State: AOJu0YzLfkU8XUEJfWXEj+PJUpe8kNmqxMrjHAme9jcclSlRvZHkxrR8
        +fLG0E9mpzAH+6bIu6dmcxdpq84q7XAzWB+Y
X-Google-Smtp-Source: AGHT+IGeVtrJ6el2C/T3eyYfdtyjBM1zxk7RCTju5WCHZQlolTyy8ERUrHvD/rnl2zQwLLa6EuK9Xg==
X-Received: by 2002:a17:902:6b0a:b0:1ce:5f67:cfd3 with SMTP id o10-20020a1709026b0a00b001ce5f67cfd3mr2005190plk.18.1702297355707;
        Mon, 11 Dec 2023 04:22:35 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.110.72])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902a70d00b001cf6453b237sm6494068plq.236.2023.12.11.04.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:22:35 -0800 (PST)
From:   Li peiyu <579lpy@gmail.com>
To:     jic23@kernel.org
Cc:     javier.carrasco.cruz@gmail.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li peiyu <579lpy@gmail.com>
Subject: [PATCH v6 0/4] iio: humidity: Add driver for ti HDC302x humidity sensors
Date:   Mon, 11 Dec 2023 20:22:01 +0800
Message-Id: <20231211122201.9598-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HDC302x integrated capacitive based relative
humidity (RH) and temperature sensor.
This driver supports reading values, reading the maximum and
minimum of values and controlling the integrated heater of
the sensor.

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
changes in v6:
	sensor driver:
	  - Drop offset for humidity channel.
	  - Use put_unaligned_be16 to assign the 14-bit heater value.
	  - Remove error message if devm_action_or_reset() fails.
	  - Add eror message if devm_iio_device_register() fails.
	dt-bindings:
	  - remove items before "- const: ti,hdc3020".
	  - add vdd-supply to required.
changes in v5:
	iio ABI:
	  - Document _TROUGH as an info element.
	sensor driver:
	  - Correct heater enable/disable commands
	  - Rearrang header files in alphabetical order.
	  - Change .info_mask_separate to BIT(IIO_CHAN_INFO_RAW). 
	  - Add details to mutex comment.
	  - Add error handling for chan->type in read_raw call.
	  - Remove error message for devm_iio_device_register.
changes in v4:
	iio core:
	  - Add an IIO_CHAN_INFO_TROUGH modifier for minimum values.
	iio ABI:
	  - Document the new _TROUGH modifier.
	sensor driver:
	  - Add MAINTAINERS.
	  - Use new IIO_CHAN_INFO_TROUGH modifier.
	  - Support the complete heater range.
	  - Remove measurement values from the data structure.
	  - Use guard(mutex)(...), make the code simpler
	  - Removed buffer mode and direct mode conversion code
	  - Minor coding-style fixes.
	dt-bindings:
	  - removed unnecessary example
	  - add vdd-supply to the example
changes in v3:
	sensor driver:
	  - Removed the custom ABI
	  - Give up calculating values in the driver
	  - Use read_avail callback to get available parameters
	  - Changed the scope of the lock to make the code more concise
	  - Fixed the code format issue
	dt-bindings:
	  - Use a fallback compatible
changes in v2:
	sensor driver:
	  - Added static modification to global variables
	  - change the methord to read peak value
	dt-bindings:
	  - change the maintainers to me.
	  - hdc3020,hdc3021,hdc3022 are compatible,I've changed the dirver.
	  - change the node name to humidity-sensor.

---
Javier Carrasco (2):
      iio: core: introduce trough modifier for minimum values
      iio: ABI: document temperature and humidity peak/trough raw attributes

Li peiyu (2):
      dt-bindings: iio: humidity: Add TI HDC302x support
      iio: humidity: Add driver for TI HDC302x humidity sensors

 Documentation/ABI/testing/sysfs-bus-iio            |  13 +-
 .../bindings/iio/humidity/ti,hdc3020.yaml          |  55 +++
 MAINTAINERS                                        |   8 +
 drivers/iio/humidity/Kconfig                       |  12 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/hdc3020.c                     | 473 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   1 +
 include/linux/iio/types.h                          |   1 +
 8 files changed, 563 insertions(+), 1 deletion(-)
 ---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a

Best regards,
