Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4021076B482
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjHAMP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjHAMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:15:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1275319B6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:15:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so59671875e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690892150; x=1691496950;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy69UTLPaMkgS867f19KBpP2TanFCy8uIWGJpynTc4M=;
        b=dQcrKPIR1YSzeSBcWpFUlzV+txmJlH/J0DF9T/2uJe790esSjDcFQtB3E+kMbBLzM9
         rzA7ChQORoIodjwM75v1oOVgAcQSOpuMZC7YtnnlHBQKKnrsub476uqiFrqJ6XWCl+62
         5dMSBrIlznogy10YKqOc5iQKchYvJXvz/zTvXbtUy3JMIqB3ewbmApUMTRgaWH9zxgkG
         AJQV7/gs50s62NA3BJNU+4lmUXaCNg8Ij0xinPbKaOTs1stqq24lGIzvcVqWHvgxLXyr
         7bVifE4NJSK3SzrVrPEOJih0WP8RlH3oxFIMa7EcZqikGnTQ6zZWHT6jDbeilsHyqJ3s
         9iRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690892150; x=1691496950;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cy69UTLPaMkgS867f19KBpP2TanFCy8uIWGJpynTc4M=;
        b=QXjkaG+gZ3uCmR4TydYdjc0Eq+x5mN9GPWNdG6TD2vTxfFzftFNBLU3eH42nuIKfUi
         lU0AiGckhKnmz90hiGyllHnMYoLpxtJmxA8S/UPLXfHmjrRNTZERnsfCJ3B108sOXINb
         ctR7Fq2vJBSggwMwAHyawBPPo3irA2HoHGKbhvcq7ydg28Ym7Szr7HQ79VhJ4xtHOdeL
         B9a0wG2hZBNhM9tN0CAUMaVznUxnyjgr1Myt3VlOWHKjROmjxhFR78t24t02yedl0eYs
         D05RfCEE2BR+aW4V/0yAQdX2mTrwwHF1fTJWspmrAw+7eC9vpnm0ONeK8EwF0ddbUVq6
         SOWg==
X-Gm-Message-State: ABy/qLaLrrHTqZzsBjlJYEuseweO2FxCsgF3ZrZ1OOHA94lmTNe0dViy
        lgO233zPd9tW5XfSoblylA2BBQ==
X-Google-Smtp-Source: APBJJlHfsFDHbaVf5nw4nEKhNpQnCwdEhr0FZNS+Kg1ebtodpF2mL9GQO6oQaQou5KmslFA2N0zRkQ==
X-Received: by 2002:a5d:65d0:0:b0:317:5f04:bc00 with SMTP id e16-20020a5d65d0000000b003175f04bc00mr2153616wrw.27.1690892150441;
        Tue, 01 Aug 2023 05:15:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm15874351wrq.115.2023.08.01.05.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:15:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 0/4] input: touchscreen: add initial support for Goodix
 Berlin touchscreen IC
Date:   Tue, 01 Aug 2023 14:15:44 +0200
Message-Id: <20230801-topic-goodix-berlin-upstream-initial-v5-0-079252935593@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHD3yGQC/53PwW7DIAwG4FepOM8TEBpCT3uPaQcgTmIpgwjSq
 FOVd5/b29TTcvwt6/vtu6hYCKu4nO6i4EaVcuJwfjuJOPk0IlDPWWipG9nKFta8UIQx555uELD
 MlOC61LWg/wZKtJKfIXhnscPYDSYKpoKvCKH4FCfG0nWeebgUHOj27P784jxRXXP5eZ6yqcf0n
 62bAgnGS2tU6DwO/Qev+ZLfcxnFo2HTR1TNqm4DP4MKncQXtTmiNqwO8mxtRN9b6V5Uc0Q1rEp
 nbDSdC6jsH3Xf9183mgEy8AEAAA==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4187;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fd+qneyPqfEMIXH5ohAYLPVreAieRi3VQmuuDjoYVWE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkyPdzBMtMLU60jmuVK4dlZe/mNUKoOddka5KNT1Fk
 ey8MSCeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZMj3cwAKCRB33NvayMhJ0bMNEA
 CYq3UHf9Vd1i8mW4nvJcBEYz22xRV9AULjK0H2YQEx8q7LPFI2JixBNSO6RGNwHN10xZYh5K07mIyO
 ulJ3S571loPaYpBnIJbAzI/ezrCGvgVcuFroLRxUmXgNbSNoFpwTDx4H30Bv8nyzh/G95s/KQftePq
 JNwrh+e4+xAai4nGtE90AldT9/qRB6vmH27mMrKrc0xjT/jOcViXaEgIIDPAObA7Vk05K8wRiVQpTG
 +vrlMvLj8g9D+RghbbMPoo3KXyruy+yC8X+LWUlV08qANwEWc0ZAttwsQb1YUtSJjS/Z1y8tH/5NQe
 +oq/NKEC9kMovHqCeytRXGuVlOt/VS8BZyikphsiLHSh1E/99qOoo1Yx2JKk6Dc7W/L2NFvFltzmml
 nFsLo8Lvji78Ag0KEMn5uNN/jpCfQzanciHxZn3N6bZbaiZs9mOqLHIGRqmh7z66plmd/z6PM+Z0xG
 IlThS9+CzgvXQ0C7udzInsWNhxY+fwfy50Q9s28AuHJcMeQLOKifON2EzlAMMlfh36yo1kf9zhYYbZ
 052mrBR2O4o+C2F4G2zjecxe9z6XhinyrO8i/My0uCo1PlZpSoO3MhH68kiU2dS+1/tXvNrLT/fgSm
 djRCOGUkWXAqS6KZGuHN73rbjXEu1vs6cF/urSZKOut1vTvLVDsEkmz4I2Lw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
      input: touchscreen: add core support for Goodix Berlin Touchscreen IC
      input: touchscreen: add I2C support for Goodix Berlin Touchscreen IC
      input: touchscreen: add SPI support for Goodix Berlin Touchscreen IC

 .../bindings/input/touchscreen/goodix,gt9916.yaml  |  95 ++++
 drivers/input/touchscreen/Kconfig                  |  31 ++
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/goodix_berlin.h          | 159 ++++++
 drivers/input/touchscreen/goodix_berlin_core.c     | 581 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  69 +++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 173 ++++++
 7 files changed, 1111 insertions(+)
---
base-commit: a734662572708cf062e974f659ae50c24fc1ad17
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

