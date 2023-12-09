Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11D080B2C8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 08:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjLIHdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 02:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLIHdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 02:33:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5806D10D9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 23:33:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3316c6e299eso2869719f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 23:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702107226; x=1702712026; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxkqkUsR5M3YIKHz3RRqm0cTT8ZB57WOsfLsJaEubxo=;
        b=QCupg5Fr2Q9//ECt1xygOsCCqEo7sMDMkY4rvjJqNeVd+2tt0MZd+FaoxiHboiNkRT
         BS1VuWep4PTDT2ghFtqpJKqprFRaXpDfTl3ztnr/HFnKcOndapH/f7IHYx7jDKN2u64f
         HRbYMG6wEiNqicAh/Gd8M/HOq12aX4bEdA+TlzdT1fuBr86Rl4Pwm/ui+OwOuxAlVbsi
         EwJj5gw1eWORyMqcQymACQvzPDNdJzAz/RNPzxlUIItPZ3eJvitv0/ucWhPAzZVo83Bk
         ybaGUVGtvu94WAzOvOnhedTlNlg4RvpeQEuDL52lXdljn7CWHcDYHMlRfrDI2d3GVCeT
         zFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702107226; x=1702712026;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxkqkUsR5M3YIKHz3RRqm0cTT8ZB57WOsfLsJaEubxo=;
        b=oBTaDBvdDTE0BU3ebX/ZcmcdBRRWiZn4d1WFTj7mFlRXQ30Rz0YTiLvscr0DVfOhZa
         JdVPNPXjhJUe1WzE16+5bIHhi5MdtrCHe5xXMLln6bCfA0ZRch41b8gcb46BOe1cCY22
         KVpIA77jLOSunbrf/ldY8VReG0vKeCh+2Iq97uUAHRQ1eIz0zyu+I02AY/KGmVic0SKg
         1P2veU/5B8ZhHVATFAUG/oydJu1/QoP/oFO+x7tDV6VtamXxIFHbyZqdFSvcjg5NdpdL
         MDVjc/zHpvvklDj9JJoFfeAkWfKViLkp8fHZa1+v7hL6IH/Y0pbVo/JgqAeJUfosr59o
         xRMw==
X-Gm-Message-State: AOJu0YxYTeOYDaZ4I1jct+n2gSwcAndSmYG8I7peWn6glc2/e1+PIXss
        H+vm54+U+LQdB68yzNEFVix/8w==
X-Google-Smtp-Source: AGHT+IF2jqQYbZZzPsvLVqaZfcMk6OgaeWe2ue6Cec83pkT9E046sLZZA1pe1kZhywah/9ELCE+dOw==
X-Received: by 2002:a05:6000:c90:b0:333:3a1e:436c with SMTP id dp16-20020a0560000c9000b003333a1e436cmr435971wrb.129.1702107225757;
        Fri, 08 Dec 2023 23:33:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d56c3000000b003334520e49bsm3577803wrw.53.2023.12.08.23.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 23:33:45 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v12 0/4] Input: add initial support for Goodix Berlin
 touchscreen IC
Date:   Sat, 09 Dec 2023 08:33:38 +0100
Message-Id: <20231209-topic-goodix-berlin-upstream-initial-v12-0-eaffaeb53fb5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFIYdGUC/53TwW7DIAwA0F+pch6TTSDATvuPaQcgTouUJRVJo
 05V/31OD2snLlmPWOjZ2PhSTZQTTdXb7lJlWtKUxoEPKF92VTz4YU8itRyoJMgaGmjEPB5TFPt
 xbNNZBMp9GsTpOM2Z/JdIQ5qT70XwzpClaDsVK6aCn0iE7Id4YGw49T0Hj5m6dL4l//jk8yFN8
 5i/b7UsuEb/mXVBAUJ5MAqD9dS173zN5/F1zPtqzbDIZ1TJqmwCP4aQHFCh1s+oNasdaGMi+da
 AK1T1jKpYBadMVNYFQlOo+q5awI2qXlXjpJau1trVhdrcVYdyo9qwGhTFzivXBVdOy/yqCLBVN
 axyqQxip8naQrWPar1RtayiQR4EgqS2KVT3oMqtfXWrWnfcBGsN6lJFeGS3Fos8LWEtUZSkMUI
 o3ft6IW5fr3W/dFSGnAET4e8/uF6vP0eFYY9PBAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6029;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nOpNhadeTTZERTvvS7Ms1uk9GFfmZvsx12kWFVrtUPI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBldBhWmja9HRb1+SwgcgVFLO+pfdILsh9n7J9DwSMY
 vqpT3cyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXQYVgAKCRB33NvayMhJ0fazEA
 CH67OpN0QfbTV/CiFS8/ZlaXeKNjqYHlkmmmnkkCi3CbQnR6LzAnK+vp4jw4nBFO4yRl8/TkmCRHDA
 m6urmjprUg9RtTGVHPKFgsZhSXiYDTkO07YufBZe4SoAPQmPVaS5qsaPh/sL3fTq4XqI6ubKdVWm7t
 Q1jDPsfAGBUAVP5YjTCspq1CVZISNP6fKSDwv6R8Wvda+M41DBCSVEyXc76TcSSld5SLyxQWqbcsz3
 IYflddRtb3NX5TGNshQIE+kIOr1qNfiDg9cX4ISXPfdDKADjKVgCJ9iltPgdV5YRRNfLQQ6REpmNmU
 T86ncIQgAxdtNEC227tHPy7dWr4OL5jvqtt56dSiG07fqjIxqNIiDPIVqhgC6IuUVibibEB7LLFE2l
 BpINI106s6KYRnx8svmvlt/FxdTixwP7UNH4Ni9uSUNEtENUjoWdNPTcgyODqLgbXfgVkzM1LMnast
 w/bGZwWI4O+zL6W1JTZlXV8ABByyO4znbr1S9ErPKw91V/dGpYHNn/9vuDVuYl7rLv9+EQ3qX9OrJ3
 RZCIQ3MW3wPEkRSR18RSkJXxOHpRoCLRctqQOBxpvdFxM3+RCq0AAxfcch4cHKztP7EzDPDL1ZUNoN
 DH5pIOBLm/IDEW8lv9fKO+3lPfIe1uFecB4nTRWrmKZHjcjajWN2J1ag33bw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These touchscreen ICs support SPI, I2C and I3C interface, up to
10 finger touch, stylus and gestures events.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550/SM8650 MTP & QRD touch panel.

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
Changes in v12:
- Rebased on next-20231208
- Link to v11: https://lore.kernel.org/r/20231106-topic-goodix-berlin-upstream-initial-v11-0-5c47e9707c03@linaro.org

Changes in v11:
- Fixes according to Jeff's review:
 - s/dev_info/dev_err/ in goodix_berlin_get_ic_info()
 - remove spurious return instead of goto in goodix_berlin_get_ic_info()
 - added back dropped msleep() in goodix_berlin_request_handle_reset()
- Link to v10: https://lore.kernel.org/r/20231023-topic-goodix-berlin-upstream-initial-v10-0-88eec2e51c0b@linaro.org

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
 drivers/input/touchscreen/goodix_berlin_core.c     | 595 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  74 +++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 177 ++++++
 7 files changed, 1134 insertions(+)
---
base-commit: bc63de6e6ba0b16652c5fb4b9c9916b9e7ca1f23
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

