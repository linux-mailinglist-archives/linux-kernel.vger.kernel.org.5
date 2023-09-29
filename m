Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB41D7B3531
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjI2OcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjI2OcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:32:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD710CE8;
        Fri, 29 Sep 2023 07:31:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b275afb6abso164525266b.1;
        Fri, 29 Sep 2023 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997915; x=1696602715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=et/0hI7eloXpfKr3HRtoG3/NWnoM3qRd9cvK/7WGxCU=;
        b=Sv0L+yigxvpui4mWm89GpgeBi6+Ol/uDiRk/meGDbBdahduQAW83DcNrUPKgdoJV8E
         lVYpGNHqfDJy9P/n7FXGSsvJYTQ/7NchM/IFww9nNP57HqZHqX4SyHzC9gG1pvKoI7tp
         Zy0cSKfGuDiDmdHP8QBpC4uhWimnphNBJuZ2sYIpriZFXb/yJv75c1yH7SlyuroatqC2
         i4R3bKNi68t6L/fkB2ApwPy+nJwKnH9qNM1XcpokCraTF4MKaQYoHJfh7/QuchNkk3ay
         0CDSoPyD6NHmMasL87R6NrbYKyQ9NrtJzbDHUtMA0rXG8JGi98xYp/1OCQNMGZSr9A3Z
         dq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997915; x=1696602715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=et/0hI7eloXpfKr3HRtoG3/NWnoM3qRd9cvK/7WGxCU=;
        b=KSJSEmmMoKU5g/WsBwTKOGg7PNgMR+njmLlG7/A6tIm43u7dAfc9afuMmwP9TEMlOz
         Xe3wjjjDWQBngqhMwfGPk545DPZDsIy2WxQHlz1tBwDJVen0jrS4HRwEhaqJIPQURMg2
         1Rb1DQ7HEYkt1MPPPiWnfGcXf0eK6GRvGvKXjhWManAfJrgSswb4FQIC2sMa+W1vtCpT
         7ASYlodWXJaQ+CF3vraEdT4jLOxcnWCvvU9DOs176zSekUY44kkDxfRV8PvzFBJPnYI6
         2HB2Op/Avt2k752zAHHMmhlsh96iQLF/vag9L+eac+ylogUFyW+l6D2eiWBNfT2BNFf1
         c/oA==
X-Gm-Message-State: AOJu0YwhEMMl/IT5e5yx2wHgxYA1Wi4zEwDxXVwtvV4K7Zt7v3BV/ARz
        HKrDLDYCTunEE9KmNPFI2uY=
X-Google-Smtp-Source: AGHT+IF1EOfp/a9dNMtOIaZL08JxiWgI8+Nba9Dp9Ae85pGd5xTZ/ALpuEcHD2vDkpDyIN6DafvNuQ==
X-Received: by 2002:a17:906:20d8:b0:9ae:659f:4d2f with SMTP id c24-20020a17090620d800b009ae659f4d2fmr4067983ejc.26.1695997914771;
        Fri, 29 Sep 2023 07:31:54 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b0099293cdbc98sm12660105ejp.145.2023.09.29.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:31:54 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v8 00/14] Add TPS25750 USB type-C PD controller support
Date:   Fri, 29 Sep 2023 10:30:41 -0400
Message-Id: <20230929143055.31360-1-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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

v8:
 - PATCH 1: 
    - Define reg-names at top-level
 - PATCH 2:
    - Add Reviewed-by
 - PATCH 3:
    - Revert mode check return
 - PATCH 4:
    - Return mode when mode is checked
    - Use device_is_compatible instead of of_device_is_compatible
 - PATCH 5,6:
    - No changes
 - PATCH 7:
    - Use device_is_compatible instead of of_device_is_compatible
 - PATCH 8,9:
    - No changes
 - PATCH 10:
    - Change tps->cb to tps->data
 - PATCH 11,12:
    - No changes
 - PATCH 13,14:
    - Change tps->cb to tps->data

v7:
 - PATCH 1: 
    - Define reg at top-level
    - Remove description from reg-names
 - PATCH 2..7: Add tps6598x to the subject
 - PATCH 8:
    - Add tps6598x to the subject
    - Create tps25750 interrupt handler
 - PATCH 9..11: Add tps6598x to the subject
 - PATCH 12: 
    - Add driver name to commit subject
    - Call trace_tps25750_irq directly from tps25750 interrupt
      handler
 - PATCH 13-14: Add tps6598x to the subject
      
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
  USB: typec: tsp6598x: Add cmd timeout and response delay
  USB: typec: tps6598x: Add patch mode to tps6598x
  USB: typec: tps6598x: Load TPS25750 patch bundle
  USB: typec: tps6598x: Check for EEPROM present
  USB: typec: tps6598x: Clear dead battery flag
  USB: typec: tps6598x: Apply patch again after power resume
  USB: typec: tps6598x: Add interrupt support for TPS25750
  USB: typec: tps6598x: Refactor tps6598x port registration
  USB: typec: tps6598x: Add port registration for tps25750
  USB: typec: tps6598x: Enable sleep mode for tps25750
  USB: typec: tps6598x: Add trace for tps25750 irq
  USB: typec: tps6598x: Add power status trace for tps25750
  USB: typec: tps6598x: Add status trace for tps25750

 .../devicetree/bindings/usb/ti,tps6598x.yaml  |  81 ++-
 drivers/usb/typec/tipd/core.c                 | 637 +++++++++++++++---
 drivers/usb/typec/tipd/tps6598x.h             |  36 +
 drivers/usb/typec/tipd/trace.h                |  92 +++
 4 files changed, 770 insertions(+), 76 deletions(-)

-- 
2.34.1

