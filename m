Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C1A7D3A44
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjJWPEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjJWPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:03:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB2AE8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:03:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40859dee28cso16702395e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698073430; x=1698678230; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXmp4I3uvpxbm0ipdb6KWErtCpbOovB/CwKRgnvI79w=;
        b=sbyUbEp8T9PKfmJCb/WttAFq+02tvSrbwMnhqKQC3zpmGnVnJ0rND7Y7kDHFT0TGpn
         iBMBAm9jQ1GZRmt0qkq4umT2ZRPWoJ4JIIZJ+jdLJq72BymfTgVHG33DJ2qbYVihVvB8
         1tVmR3+Vm7mQ/PloNb0xxVR3h205xEHgmqoxPu/bfFPfGiWawwl/c98xs9sjhcvNk1v8
         WKPP+yWwqYf6sQX+AqEwADE55HMXwlGRDBb64HvUS1SuvTMl6h3/pT3cNf3eAmL6g5hw
         3DGMkKqgQ8H2zRAK76K561UGkoNqhlNP4WP5RLooeePgdsPC6yuERqV0Hg3IjhhKxxSj
         emGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698073430; x=1698678230;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXmp4I3uvpxbm0ipdb6KWErtCpbOovB/CwKRgnvI79w=;
        b=YoyWqyJ0oE9Dgvj50UZqHesW5GnuTDDvbbGPCtPtZu+Jd3BYcBhCmzPFow4ZgJxUlR
         z2CyopaXIJeImGvpcWqE/eDtWahb451YxpMxagByepwkdpDEPkb3s4lr3EKQrTVMeUw7
         j7r46bq9oNHlsjj85J7+dw72fZzIjTB3IGla7fSumYcuomWkGjGe3hiXMT3ZDTdZ121y
         tdoQuAIbDMfwk6uhME3G04jFAyTvPv/N0EckBPjyAy6ptvW7/ULDF6RW+gvOtY4bBFy/
         /8sGsOdqkyj6aqh1XHxxKtroJSH5ahHgwCjYOjlscvryUo4JJwiFkLIQBLJq6kcSD84c
         CWqA==
X-Gm-Message-State: AOJu0YxiWAe83Pt7hVxhf59vJOzhTS1RRX71cqMAbumQwD4pW+Nal25m
        7uuykq11VKIQ0QhjZ57gM0wCJw==
X-Google-Smtp-Source: AGHT+IGiZzbbLaHo26LYPn1zH3l3ShOA76v4rLw9T1Pa/dBRwd8nmyRiw8wZuy+iGqLlUNpFOvK3pg==
X-Received: by 2002:a05:600c:4e91:b0:409:773:cf5d with SMTP id f17-20020a05600c4e9100b004090773cf5dmr1063792wmq.28.1698073430476;
        Mon, 23 Oct 2023 08:03:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600c150c00b0040586360a36sm14235016wmg.17.2023.10.23.08.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 08:03:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v10 0/4] Input: add initial support for Goodix Berlin
 touchscreen IC
Date:   Mon, 23 Oct 2023 17:03:44 +0200
Message-Id: <20231023-topic-goodix-berlin-upstream-initial-v10-0-88eec2e51c0b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFCLNmUC/53RzW7DIAwH8FepOI+JzwA77T2mHYCYFikLFUmjT
 lXffU4PaycuWY+20O9v7AuZoGaYyNvuQiosecplxIKzlx2JBz/ugeYeG0QwIVnHOjqXY450X0q
 fzzRAHfJIT8dpruC/aB7znP1Ag3cGLESbVCRIBT8BDdWP8YDYeBoGbB4rpHy+hX98Yn3I01zq9
 22Wha/df6YunDKqPDOKB+sh9e/4zNfyWuqerAmLeEYVqIou4GeAg2PQqPIZVaKamDYmgu8Nc42
 qnlEVqswpE5V1AbhpVH1XLeMbVb2qxgktnNTayUbt7qrjYqPaoRoUxOSVS8G11zK/Kmdsq2pQx
 VER5EmDtY1qH1W5UbWocsPxEJwJ6LtGdQ+q2LpXt6oy4RKsNVz/Va/X6w8ulRaSnwMAAA==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5482;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=TOKd5Htic2U0f6lJ+FhEACAi4YMaYwuHiHqxdLPe7Cw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlNotT/39T+NYq/ARoXrOWk8my0uu0kEv7GfXc4wLP
 Iju1vGWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTaLUwAKCRB33NvayMhJ0UOfD/
 9+20l6pDvtLwaGnkH6fCYzKfpGuLQ0suXHZUUUpkv1BHoPixTNdz+R/49MgtNSARyj/OansW91RxRj
 k2SVryAehWQTo5QZdk7ZJ7Lk77yV9vivqGJ9X/A+T8Do5oG1u3V8jKvIXZ+KjlkHI37H/ihc0ESshY
 3kQ73kEHTRWTllZytK5VJuloqwcP5IuXSF0AN06o4nyZu6aUeuzR4RwsUqQINGgoziiFSoQ+N0iYW1
 C7nWB4yw2whYYmDhBNM78DsQsymTnvcbV/poodGnMxPkt1mWdR2c/BZujTnwZ9o2WtwHaEHJKCgRQp
 OZz5MVx+KcX7WnpB/3nI2GRAOaayICvoyQ9qCsRakkqIG7HIP3GZTYSyZy5ZmmaT9vsE0NaywZ9Y5G
 vuMKbrV+9jTcoiV5WlnyVgdfZB31lH3eAFM98h4gaYikkBpl/CSttfutp0uJvYodMJaB77p58xUEk/
 zQvo9HZPW2g+j8Td7BtGiYxlAywhcsa/z+NcRlW97pAdNJJ8sw/hT9YL2IhTIB9DGiAVb823A/TBVP
 M556GVIhq2YydhL3edVQBeHN30giHt0p8Ok40F8c8aVLkt4C6SNsjGfJZDKLph/Di/FJONH9tny19O
 mFlFRIXHbOKkJho1CdSr/094sIdC6a3HaHjB9WK7o7Q3VXLEp/qGK44eaEMQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Changes in v10:
- Fix according to Dmitry's review:
 - move goodix_berlin_get_ic_info() afe_data to heap
 - merge the goodix_berlin_parse_finger() loops and skip invalid fingers instead of returning
 - remove unwanted goodix_berlin_touch_handler() "static" for buffer
 - only call goodix_berlin_request_handle_reset() if gpio was provided
 - use "error = func(); if(error) return error;" instead of "return func()" when function handles multiple error cases
- Link to v9: https://lore.kernel.org/r/20231021-topic-goodix-berlin-upstream-initial-v9-0-13fb4e887156@linaro.org

Changes in v9:
- Rebased on next-20231020 
- Link to v8: https://lore.kernel.org/r/20231003-topic-goodix-berlin-upstream-initial-v8-0-171606102ed6@linaro.org

Changes in v8:
- Add missing bitfield.h include in core
- Link to v7: https://lore.kernel.org/r/20231002-topic-goodix-berlin-upstream-initial-v7-0-792fb91f5e88@linaro.org

Changes in v7:
- rebased on v6.6-rc3
- Link to v6: https://lore.kernel.org/r/20230912-topic-goodix-berlin-upstream-initial-v6-0-b4ecfa49fb9d@linaro.org

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
 drivers/input/touchscreen/goodix_berlin_core.c     | 594 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  74 +++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 177 ++++++
 7 files changed, 1133 insertions(+)
---
base-commit: 2030579113a1b1b5bfd7ff24c0852847836d8fd1
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

