Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935B27ABE66
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjIWHkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjIWHkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:40:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE78196;
        Sat, 23 Sep 2023 00:40:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-323168869daso727046f8f.2;
        Sat, 23 Sep 2023 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454834; x=1696059634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3HDLNMMaSBTWyhWgiy3Qz21HVTULiC/0+MSuHMERno=;
        b=R72yJ4s431/dAhU1AGL/JRBSb3oSKlBPrPqCmYzJ3ZTrmfZRFBDV7kgScyNzlKvMwX
         VAIcuG7N4nMDodk/PrNprrthBLaM1r45IHI3GmmCBUfqaMEMrOfvceSGJ7pZ0ctRqOKg
         ytgla5aZ7HORiXmYhneCyKw/987+ENHcbOSudkpgDCNNKEGOdinjDmOm5IHsLSw4osDs
         vy/zM5BF2BfYIIq6CwixtlmwBU9fqPq94dk50ctgHt25DZjch/+LfJHKaUWDWq5dFi5C
         7N0TRK5Qx81t7+QUdDV7ZglFeHCBJ//LkZd2+8gLcJM1pN2I8mO5o5DuRK+54QSC/mZJ
         U8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454834; x=1696059634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3HDLNMMaSBTWyhWgiy3Qz21HVTULiC/0+MSuHMERno=;
        b=wxUa48WnbcPhhnZX88PjnO2mi5cPFxgtTvjWRNxKRX47Y6XZmSbyQeyy/RTd2FCjVx
         OmKW7eVaQQrNd49cyc0fQ6NGvY/E63PsRNGDTXMtp95/8SO490cVYoQAwzXQ/oIAyE69
         T90mECE/R0wqEAvsgGG8PinxKhbxR4N05003ruxVPu5XOZirCf3CMC3ysaHbTuQsEtSb
         dqsy6JUAypbOMJxasJParxq/8rXBHZJHcDpWQvNx7bWFJa15sRQX7513pUQCOyKc2eja
         t8PjZUjLJdaer1XBRe5WjDGiPGz2yOynS1sAMS3rj0W3RANGNTIFUg0jW0P9LYKmdELq
         PCmA==
X-Gm-Message-State: AOJu0Yy8wGQmAI0IN1EdRSYy0h0srJqynsaP8/nOW6Tbptx/U1NCwCHp
        ugQTMglmwKbsMdI/DOQa32g=
X-Google-Smtp-Source: AGHT+IHZFWaILx1L6dEysgc0psPA33NSZgI387Ij2Uk+VX/AMVr5OqhY7Yqh3fNMQVh5Nyas00Posw==
X-Received: by 2002:adf:f488:0:b0:317:5168:c21f with SMTP id l8-20020adff488000000b003175168c21fmr1364865wro.31.1695454833508;
        Sat, 23 Sep 2023 00:40:33 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:33 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v6 00/14] Add TPS25750 USB type-C PD controller support
Date:   Sat, 23 Sep 2023 03:39:45 -0400
Message-Id: <20230923073959.86660-1-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 USB type-C PD controller has the same register offsets as
tps6598x. The following is a summary of incorporating TPS25750 into
TPS6598x driver:

- Only Check VID register (0x00) for TPS6598x and cd321x, as TPS25750 doesn't
  have VID register.

- TypeC port registration will be registered differently for each PD
  controller. TPS6598x uses system configuration register (0x28) to get
  pr/dr capabilities. On the other hand, TPS25750 will use data role property
  and PD status register (0x40) to get pr/dr capabilities as TPS25750 doesn't
  have register 0x28 supported.

- TPS25750 requires writing a binary configuration to switch PD
  controller from PTCH mode to APP mode which needs the following changes:
  - Add PTCH mode to the modes list.
  - Add an argument to tps6598x_check_mode to return the current mode.
  - Currently, tps6598x_exec_cmd has cmd timeout hardcoded to 1 second,
    and doesn't wait before checking DATA_OUT response. In TPS25750, patch 4CCs
    take longer than 1 second to execute and some requires a delay before
    checking DATA_OUT. To accommodate that, cmd_timeout and response_delay will
    be added as arguments to tps6598x_exec_cmd.
  - Implement applying patch sequence for TPS25750.

- In pm suspend callback, patch mode needs to be checked and the binary
  configuration should be applied if needed.

- For interrupt, TPS25750 has only one event register (0x14) and one mask
  register (0x16) of 11 bytes each, where TPS6598x has two event
  and two mask registers of 8 bytes each. Both TPS25750 and TPS65986x
  shares the same bit field offsets for events/masks/clear but many of
  there fields are reserved in TPS25750, the following needs to be done in
  tps6598x_interrupt:
  - Read EVENT1 register as a block of 11 bytes when tps25750 is present
  - Write CLEAR1 register as a block of 11 bytes when tps25750 is present
  - Add trace_tps25750_irq
  - During testing, I noticed that when a cable is plugged into the PD
    controller and before PD controller switches to APP mode, there is a
    lag between dr/pr updates and PlugInsertOrRemoval Event, so a check
    for dr/pr change needs to be added along TPS_REG_INT_PLUG_EVENT check

- Add TPS25750 traces for status and power status registers. Trace for
  data register won't be added as it doesn't exist in the device.

- Configure sleep mode for TPS25750.

v6:
 - PATCH 1: Use reg property for patch address
 - PATCH 2: Use tps6598x_exec_cmd as a wrapper
 - PATCH 3: Return current mode and check it directly
 - PATCH 4:
    - Don't check VID for tps25750 as the VID register doesn't exist
    - Remove is_tps25750 flag from tps6598x struct
    - Get patch address from reg property
 - PATCH 5: Update eeprom macro to use TPS instead
 - PATCH 6: No changes
 - PATCH 7: Check tps25750 using is_compatiable device node
 - PATCH 8: Create tipd callbacks factory 
 - PATCH 9: No changes
 - PATCH 10: Add port registration to tipd data factory
 - PATCH 11: Use tps25750_init instead of tps25750_apply_patch in resume
    	     as it initializes sleep mode
 - PATCH 12: Add trace irq to tipd callbacks factory
 - PATCH 13: Add trace power status to tipd data factory
 - PATCH 14: Add trace status to tipd data factory
v5:
 - PATCH 1: Add tps25750 bindings to tps6598x
 - PATCH 2: Remove tps25750 driver and incorperate tps25750
 	    into tps6598x driver
 - PATCH [3..15]: Incorporating tps25750 into tps6598x driver
v4:
 - PATCH 1: No change
 - PATCH 2: Fix comments style and drop of_match_ptr
v3:
 - PATCH 1: Fix node name
 - PATCH 2: Upload tps25750 driver patch
v2:
 - PATCH 1: General properties clean up

Abdel Alkuor (14):
  dt-bindings: usb: tps6598x: Add tps25750
  USB: typec: Add cmd timeout and response delay
  USB: typec: Add patch mode to tps6598x
  USB: typec: Load TPS25750 patch bundle
  USB: typec: Check for EEPROM present
  USB: typec: Clear dead battery flag
  USB: typec: Apply patch again after power resume
  USB: typec: Add interrupt support for TPS25750
  USB: typec: Refactor tps6598x port registration
  USB: typec: Add port registration for tps25750
  USB: typec: Enable sleep mode for tps25750
  USB: typec: Add trace for tps25750 irq
  USB: typec: Add power status trace for tps25750
  USB: typec: Add status trace for tps25750

 .../devicetree/bindings/usb/ti,tps6598x.yaml  |  70 ++
 drivers/usb/typec/tipd/core.c                 | 632 +++++++++++++++---
 drivers/usb/typec/tipd/tps6598x.h             |  36 +
 drivers/usb/typec/tipd/trace.h                |  92 +++
 4 files changed, 749 insertions(+), 81 deletions(-)

-- 
2.34.1

