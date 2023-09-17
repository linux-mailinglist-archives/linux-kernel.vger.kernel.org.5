Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816497A3669
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjIQP11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbjIQP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:27:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F3911F;
        Sun, 17 Sep 2023 08:27:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3214de9cd8bso230129f8f.2;
        Sun, 17 Sep 2023 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964421; x=1695569221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itAnQtUK0esq7xPW/PIltIlBTpoKhniXVdlB9pgFqig=;
        b=fpcmbzioRagxHtRRBJqwPgMcM5eEUjASlnE4sGUhQKLKouuNeMEJe6jVKLb36Yw+3c
         Pnb03qaFZE343cTmm5WgnuvNWJhq6EwxCoI74pUcKUldEiyCaoX26lfPvN41JZjan6Jc
         P7H80jFNdsvHpD9kRND3HN+4b/2iIvg2GxIrNfr9r/vbSRszfj7NCvKja9vrNnCARb/s
         rdP6gSaEA6QV9qvIivjpopByu+zgcf81h9OnUH+tDccKmuITDQx4ywZSJ7RmXs+VlpeR
         8BdpfIYj0Kja5D7tvsAPMvKkjPM/q5xcq2/yul79//1uDoGhi58gt2Kq/B0OsWu16+DV
         +rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964421; x=1695569221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itAnQtUK0esq7xPW/PIltIlBTpoKhniXVdlB9pgFqig=;
        b=r4MjzYvzib8d5YPD4pge/uqEew1YnWqjLqXrGPLsklFtHmdSwA48uuzqRVRgAeEyVy
         owCnCcyTXr3W3FqWZ9BAIdZylnUnExSor79NzYD/KbZvuxUHz7WjaQQd3QSdGRUlZKb8
         ftxTz6iOWiyHc/4/GJug0WIqN0iCSZnK8OO1XFzA1ixByuTy4TopG+rCGlk4JAciTLbW
         LLaof8LKi8jY/2ElhOSk0w3is0kX9bkDi66RFnnrLyRpkZNRuNDMapKzFg9qbD5QmoBB
         DZlnqGbefOZ+maNBlifvdVNUSrldufQ/O1Z7Doqu7NOHPYr5nWD5WpF2bPHrnlDWLxJE
         xaZw==
X-Gm-Message-State: AOJu0Yye9jt9A08lcMULo3+zgXLlFU2SKnZ+zBu1tilaL0hfIo6K2uAd
        XNo14HqMtlJuyX2/YnNsf80=
X-Google-Smtp-Source: AGHT+IHukKtw2b9SH5a5yatF3/vlsOtq0OzgkV4iDDaL+tlI2m6aiInWnEoKVXTTzZ8SIA5rrVCllA==
X-Received: by 2002:a05:6000:118d:b0:316:efb9:101d with SMTP id g13-20020a056000118d00b00316efb9101dmr6956862wrx.25.1694964421068;
        Sun, 17 Sep 2023 08:27:01 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:00 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: [PATCH v5 00/15] Add TPS25750 USB type-C PD controller support
Date:   Sun, 17 Sep 2023 11:26:24 -0400
Message-Id: <20230917152639.21443-1-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

v5:
 - PATCH 1: Add tps25750 bindings to tps6598x
 - PATCH 2: Remove tps25750 driver and incorperate tps25750
 	    into tps6598x driver
v4:
 - PATCH 1: No change
 - PATCH 2: Fix comments style and drop of_match_ptr
v3:
 - PATCH 1: Fix node name
 - PATCH 2: Upload tps25750 driver patch
v2:
 - PATCH 1: General properties clean up

Abdel Alkuor (15):
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
  USB: typec: Do not check VID for tps25750

 .../devicetree/bindings/usb/ti,tps6598x.yaml  |  70 +++
 drivers/usb/typec/tipd/core.c                 | 570 +++++++++++++++---
 drivers/usb/typec/tipd/tps6598x.h             |  36 ++
 drivers/usb/typec/tipd/trace.h                |  84 +++
 4 files changed, 683 insertions(+), 77 deletions(-)

-- 
2.34.1

