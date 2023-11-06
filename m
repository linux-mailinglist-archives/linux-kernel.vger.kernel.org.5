Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7224F7E1C50
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjKFIeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjKFIeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:34:06 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64A3134
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:34:01 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so55689331fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259640; x=1699864440; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm5rid7mjwCNr4nlqTPTaNaM7kofJfwmruUy5+bkQmI=;
        b=bUsMMjbK267ObGp50QtKfow++1G7HrmXhFBZPNkdrQLYiA1sFTCmIzaoTL5qTTW/ME
         UC0i9qh68ypjN4tBAA5Cu1W83X3h2aXnZuYptItTziXUZfOppFT9D7sR4Awu8Jtvc8XP
         gG8WkIOEIFyOAuwIFNReYTocMPmRSdemCeKX0088Uk8xaFrF94+evS86VilN6ESFUNUo
         Ss0zmstYon33+fGk8TbKyOepwU6nYZr6o2Eo1IyWlfbuDlGIwG2EmftBc+mvLqJX7dsV
         ItPHS9ddAvYX3UgaXdLcq9llbxxAVEW36OhaFJp12FQgqAB2x6yYDBzTILeZNhEeHefi
         8Ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259640; x=1699864440;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mm5rid7mjwCNr4nlqTPTaNaM7kofJfwmruUy5+bkQmI=;
        b=vUunhGV1yrQ+NrURRInUSAioiAXvBrJLokYiw6chEIvi/yKO7R4SHBDehDJAXOZpTa
         HP0FQOkhbm01zomQp/g7PV8J+YbHU1e9aexSRspHlcuelGCVxupMfqQuq6c7XheQqe2B
         EE3VodMVDiPqnASO8sgzIFsMijqPshFCWg6RRlCABtdN509hK8NCpR97ysguAEW1KwGy
         X1puvMEIZaDdNTRhbM9tybPotfbqXkJNGWtG13xlQdYjKJAuFPgYgr4w3ID7SROAaczt
         bElQZWKzRfYVqBezxQjKlODLQQkAK8zyIPGNBiGUzcLWqWIjOklRQSawgvo8Rb9rnVE9
         xPIw==
X-Gm-Message-State: AOJu0Yzz/WcueJixAbSnoh3F8QxS4/2y21uqzRy/EL8Qhdo3Tirl/y85
        57aIamk50aEwvbClA2mN5CcENA==
X-Google-Smtp-Source: AGHT+IGoTWEyT6HVdMtC4llNjlm1QvL8fsEH5/qr9TMXsBi4pI9M6VNsJa9UHAH0BzWTM+Rl4mJY7g==
X-Received: by 2002:a2e:8217:0:b0:2c5:1eb6:bd1e with SMTP id w23-20020a2e8217000000b002c51eb6bd1emr21126708ljg.43.1699259640019;
        Mon, 06 Nov 2023 00:34:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q24-20020a7bce98000000b0040648217f4fsm11132991wmj.39.2023.11.06.00.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:33:59 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v11 0/4] Input: add initial support for Goodix Berlin
 touchscreen IC
Date:   Mon, 06 Nov 2023 09:33:55 +0100
Message-Id: <20231106-topic-goodix-berlin-upstream-initial-v11-0-5c47e9707c03@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPOkSGUC/53RwW7DIAwG4Fepch4TJhBgp73HtAMQ0yJloSJp1
 Knqu8/pYe3EJevRv9BnY1+aCUvCqXnbXZqCS5pSHqkAeNk14eDGPbLUU9AILlre8Y7N+ZgC2+f
 cpzPzWIY0stNxmgu6L5bGNCc3MO+sRoPBRBkaorybkPnixnAgbDwNA4XHgjGdb80/Pqk+pGnO5
 fs2ywJr+s+uCzDOpONagjcOY/9Oz1zJr7nsm7XDIp5RBami8/QZBLQcK7V9Rm1JjVxpHdD1mtt
 Klc+oklRupQ7SWI+gK1XdVcNho6pWVVuhhG2Vsm2ldnfVgtiodqR6iSE6aaO39bX0rwqcb1U1q
 TQqgRAVGlOp5lFtN6qGVNBAhwAusO8q1T6oYute7aq2kZZgjAZVq8Af2a3DAl2LGYMYBCoI3P9
 xr9frD26VVB73AwAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5857;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ttpiHUDF47l7SK01ElAmxepIn36Eltv4gp2vS9qopj4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKT0NKp6bxX4upG12YZhgBmsTDD7i04tWrGbgH5k
 t8EPHfOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUik9AAKCRB33NvayMhJ0S77D/
 wN/Ww9knKwYrIEyXA7cbfOD2+BfkqxT/CgstZG5PfHEvej+0C2neKd9/T6Lya/0B+S+Lt4dmRSrvJv
 6BR5IpyefgHtXoHho8510PFC+dd8NuBIBO87HqaWBUDlmXVkTFKCpXbjTdsWbSYaHmmv34QiTL+tiP
 avspMjuGsQ/OS2LUroTt/0tXjXDKfQW0t6UhuoDW1g6KRwAHRl+6VQVYzWgt9O41OoVmbwnw7g73+l
 JHlSyEPPNYLW4gtrU0DX+j51w4JH+/vKq9NCSsYzp9DATSPqSfHjxbSeSHZouud4HQbQ7MDFfDCAjJ
 aUXg8bHHWgzXZNDnQeTBtg1zqhaoCOaiYLAxoeUeXVkg8vFjFqKCb0ZrcXjWytjmYsvpnWArS32ll8
 LmRtgMUvjheAlJtcUlF+BkqUrEc6LH+7SV29RzxXo2tdingr2Wcth92hOR69qfvWPGydah53li9dba
 16KZPKkNKPiKzGfOQDUpUle6SHDm6OpBE2FW+fRx0lCVPJK0shI7470j8x6wRnMloQ6vVpPsDQX7hp
 XXOJh17PRJtSp7jeXY9m6kGDo7BOAzOmo9o7eQ/FSODn76EdTmfy/zVwTiEpouiRAMGFZU+ayScMdH
 3Z7r6JrkWPLIR3NNwI6V8/SUrVR8bVMJwdwl3ddY5UCMYGHdkwAZw1LUdCuw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
base-commit: 2030579113a1b1b5bfd7ff24c0852847836d8fd1
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

