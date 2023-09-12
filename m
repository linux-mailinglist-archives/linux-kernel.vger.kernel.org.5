Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577BA79CA68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjILIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjILIoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:44:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D35E79
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:44:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso58830465e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694508252; x=1695113052; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2e/x2gLpMdeQRhTiKGWz3mptC+8fCI7XlwMOw0yH/5Y=;
        b=nGoylnZ7aDpwzYmqAtLENcCHg994CkmW2SWflTnogC61kJ4csKvEazNz83frazVzDW
         yQmasLw5I3pHfTKSmqhnj1Qm2Qkg7Dz1EqxAWsp7hm2TFv6lGXdj9WWW3Adttl3wSIGV
         uXVSytvdDT9uNMbRFxcTnnJ04BWpxj2Ixp8TQHX2Y1a2pHifubaJgHsKadb49neMRRt+
         gaN7tejaw0173qXrycwC2lfrjJ0fm+QwJ61qF4Obfk4idsX1pnnkMkm1WbWIWVRPCXsY
         OWujENaaUMSMTwh9H9fS+UsRNy8K2HSw9JJYuhfXwQhKwnO01r5o5TIL24D49/H+pxLR
         DXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508252; x=1695113052;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2e/x2gLpMdeQRhTiKGWz3mptC+8fCI7XlwMOw0yH/5Y=;
        b=MM1TvMY/8mGByJ3k8Aa2BT1RmJpLMWoL3s5pQnNOzBy6nC1xwgJynTc+6eIkYPWlmx
         x/yYdioG1l+ZNDplZsYpnNDeiB3MNI2CVgxpSpahhT+7bAEZikr+9zX5Z6jT5XudgrIv
         Bw1wgGKQ3DlawmXJnr6IvdoQiLoCRzYnVVXMBPLmgJfg/bCo0SsQyCBeNDKjGKZ08SJF
         LnhZ/1kT5L9Rayv6rnbjHew9PlqC4vM3dP4Ex/aOEEb7eMQ4hJgH6oO3VOKxVxXpaNoq
         Bhyryno/CciWggDnIlbriMnKjFrpD7B9tNA/5Dx0eg7No0tD7t3EpxHleB5UHZ70RpjG
         ykUg==
X-Gm-Message-State: AOJu0Yyk4n7LLztxiUSxNPBMnVTwlySwB5dL/ymzyIAUmOzguvtkDd2Z
        BYigKlO03jcLbQKMJAUD9AZOvA==
X-Google-Smtp-Source: AGHT+IE+dU/F3WnFMx0sfgCBWU84TUB0AWE5qYLX9vaoDmM3ChahOIjqEeQUQVJnC1Ekal77bkvRAA==
X-Received: by 2002:a05:600c:28c:b0:402:cd60:8aa9 with SMTP id 12-20020a05600c028c00b00402cd608aa9mr9641044wmk.20.1694508252130;
        Tue, 12 Sep 2023 01:44:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id c7-20020a7bc847000000b003fe2bea77ccsm12301348wml.5.2023.09.12.01.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:44:11 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v6 0/4] Input: add initial support for Goodix Berlin
 touchscreen IC
Date:   Tue, 12 Sep 2023 10:44:06 +0200
Message-Id: <20230912-topic-goodix-berlin-upstream-initial-v6-0-b4ecfa49fb9d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANYkAGUC/53PwW6EIBAG4FfZcC4NIAjsqe/R9AA46iQWDLhmm
 43vXtxL03hpPf6TyffPPEiBjFDI9fIgGVYsmGIN7cuFhNHFASh2NRPBRMNa1tIlzRjokFKHd+o
 hTxjpbS5LBvdJMeKCbqLeWQ0GgullIJXyrgD12cUwVizepqkO5ww93p/d7x81j1iWlL+ep6x8n
 /6zdeWUUemYltwbB333VtdcTq8pD2RvWMUZVVRVtL4+Axwsg4PanFGbqvZMaR3AdZrZgyrPqLK
 qzEodpLEeuD6o6kc1jP9RVbuqrVDCNkrZ5pe6bds3veES60YCAAA=
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4403;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ZwsPOIUjuxLpDRo0z6hswc7hSp9m6aWP/mpgABoH2fE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlACTY5ce/FzKKxuEz14nHG0aoyB+Ujv8rkNE5Gdi2
 6gr2Qw2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZQAk2AAKCRB33NvayMhJ0RITD/
 wNC9jJBwouOtS7wZ+hRV5bGq7ORUF0Rg9h2H2qQH/9dcbbPNMI1NJdlnjSVHnTR6S5Kn6y5RUPequD
 GS4+Os/t6zrTc0q4r23IdKWT88ry82gKdv234+qpnUMXWa6oEDVjnNjzkE3IBT7aVmP0fjXqDuPQIi
 9JeDY1UAiazsaBAxvyUPOIEGDCtbSPKSQ9Tmo32rERK9s+TVWAcu/xQjaQo+S3JQqLyX+EBtrUeVXp
 2hv24pcVL//mT6BGr/2Hji+nST7E4LJSp7ZgJ6wE3vguGX38BVU35hM+G18VmfROUHYEiUL/C9qcZp
 Twzi9oo1/qyI8xXOeMo9MZrqxRmTAc6zkE+YD5KfUMib4FRNUvHvUZ70G0/vz0w5hEEKT5nYIo67E9
 H1No5y7xY7Kze5PuHb9LoNUtH5Tz1vbC3kXTtbdkVABKeXJrK71/+xkhojBIwkEjqAD/3A4D48Q/G/
 /HyRv3ENnbxGzmHLrFixFz79nyg759bnD7ytFl7sDQQ/GB4uePPQFW6HGR6wYgto+jysAdM7yQ4TxC
 rNeYN5nxa3W4UXYdC52CLI2qOEE5C10HQOSLQ1ObVRAyqa6fl+3ndH1iEeD+WwKZGdd7lM4vMwK2Ew
 gVjLH/Tk7RDZTuWMH9L7p7akcQAvO57RyHe7nGFqSpEWdzIY0CTMuwZK1nFg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These touchscreen ICs support SPI, I2C and I3C interface, up to
10 finger touch, stylus and gestures events.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550 MTP & QRD touch panel.

The current implementation only supports BerlinD, aka GT9916.

Support for advanced features like:
- Firmware & config update
- Stylus events
- Gestures events
- Previous revisions support (BerlinA or BerlinB)
is not included in current version.

The current support will work with currently flashed firmware
and config, and bail out if firmware or config aren't flashed yet.

[1] https://github.com/goodix/goodix_ts_berlin
[2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v6:
- rebased on v6.6-rc1
- changed commit message prefix to match the other Input commits
- Link to v5: https://lore.kernel.org/r/20230801-topic-goodix-berlin-upstream-initial-v5-0-079252935593@linaro.org

Changes in v5:
- rebased on next-20230801
- Link to v4: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v4-0-0947c489be17@linaro.org

Changes in v4:
- Core updates:
 - drop kconfig depends, deps will be handled by _SPI and _I2C
 - change power_on() error labels
 - print errors on all dev_err() prints
 - remove useless default variable initialization
 - switch irq touch checksum error to dev_err()
 - add Jeff's review tag
- I2C changes
 - change REGMAP_I2C Kconfig from depends to select
 - add Jeff's review tag
- SPI changes
 - add select REGMAP to Kconfig
 - added GOODIX_BERLIN_ prefix to defines
 - switched from ret to error
 - add Jeff's review tag
- Link to v3: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org

Changes in v3:
- Another guge cleanups after Jeff's review:
 - appended goodix_berlin_ before all defines
 - removed some unused defines
 - removed retries on most of read functions, can be added back later
 - added __le to ic_info structures
 - reworked and simplified irq handling, dropped enum and ts_event structs
 - added struct for touch data
 - simplified and cleaned goodix_berlin_check_checksum & goodix_berlin_is_dummy_data
 - moved touch_data_addr to the end of the main code_data
 - reworked probe to get_irq last and right before setip input device
 - cleaned probe by removing the "cd->dev"
 - added short paragraph to justify new driver for berlin devices
 - defined all offsets & masks
- Added bindings review tag
- Link to v2: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org

Changes in v2:
- Huge cleanups after Jeff's review:
 - switch to error instead of ret
 - drop dummy vendor/product ids
 - drop unused defined/enums
 - drop unused ic_info and only keep needes values
 - cleanup namings and use goodix_berlin_ everywhere
 - fix regulator setup
 - fix default variables value when assigned afterwars
 - removed indirections
 - dropped debugfs
 - cleaned input_dev setup
 - dropped _remove()
 - sync'ed i2c and spi drivers
- fixed yaml bindings
- Link to v1: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org

---
Neil Armstrong (4):
      dt-bindings: input: document Goodix Berlin Touchscreen IC
      Input: add core support for Goodix Berlin Touchscreen IC
      Input: goodix-berlin - add I2C support for Goodix Berlin Touchscreen IC
      Input: goodix-berlin - add SPI support for Goodix Berlin Touchscreen IC

 .../bindings/input/touchscreen/goodix,gt9916.yaml  |  95 ++++
 drivers/input/touchscreen/Kconfig                  |  31 ++
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/goodix_berlin.h          | 159 ++++++
 drivers/input/touchscreen/goodix_berlin_core.c     | 581 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  69 +++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 173 ++++++
 7 files changed, 1111 insertions(+)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

