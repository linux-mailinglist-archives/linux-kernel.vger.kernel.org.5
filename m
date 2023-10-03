Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDF37B6DC7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbjJCQA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjJCQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:00:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BD1D9;
        Tue,  3 Oct 2023 09:00:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b2a3fd5764so194216866b.3;
        Tue, 03 Oct 2023 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696348847; x=1696953647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tya8R8jajAVNKTmm7MpxZgEwNbrudUVhY+NFvCiehCY=;
        b=mlnnDgc/Hih6wUyLdLL6ivxKEPNz68Gr7+McI/XaSbkHWZkkEWstS8+y8cGao+yj/Q
         Epusy93GNME3RWpvc2MHb0ChfrOgLE1ZCqAaL6Q9yrKw/rWYb8fA53R2IZacRlwlC4l7
         CEzEhvRtjDhpq/6SqCKeQpuBiDX8lCJnH/l59Jb2fdghaLoI5bYnYVkcbIgXhPRo/M7U
         GYi401pv8qgvuWv2y8mp8C0EM03vdRZI/TNZxbX0NK6Ve9Bewlsn3U0yxI8bSJWX5Dq/
         IwLodMpAlKHK5UTYrc3YecwXIWlxaZ9AF6Ide3ZvoQK61SSbZVYG0Tqi0108WUaMxBAa
         2jCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348847; x=1696953647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tya8R8jajAVNKTmm7MpxZgEwNbrudUVhY+NFvCiehCY=;
        b=TJueEtKsvp835N65U3Z2SpFaSEt1qXT74UfeGAHWxjywoxuWW7yuVHuddudtHZ7x0T
         knocgAocHkYiPaZHBgXXXO+DFifqy+Y3Hbqn09+2/RWwwc0a6xcTL0KjXMzWR4juEajn
         Ow9ueYqhmIWD2MoezgdnaEMrMJl3crCJL7HsJOCvfp9HYA/rCum5omHVmi59JvSr4Evy
         J2wVfImDIBpbbFEMrskgJmU/64cSg+tRS0M/SklTGfiKA9llmk1Rg2s39Q4ZxsBxSbn8
         6Q7sTwZRlmlf19uze3G2YVaDCtqB7EujChGJ4b/EjDw5yRIQoMuIB4mIrqiqLQ/7f/VI
         Z6rQ==
X-Gm-Message-State: AOJu0YxQjTXmNjPFs6biezV6PbH75kv+BBx+V9Tmd+R3/CO+SPXPTE+K
        jFX2+wJQ8FEuNuZFgHmyLKI=
X-Google-Smtp-Source: AGHT+IEoCs23E0emLt/nhkXHXXPsnxPofv0LnszoKnH5N2mKQ+GQhP/aQGbwF+lcgQNdB4SQBQ21jg==
X-Received: by 2002:a17:906:104e:b0:9ae:4e81:4580 with SMTP id j14-20020a170906104e00b009ae4e814580mr13802807ejj.66.1696348846113;
        Tue, 03 Oct 2023 09:00:46 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id jo3-20020a170906f6c300b0099df2ddfc37sm1270526ejb.165.2023.10.03.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:00:45 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v10 00/14] Add TPS25750 USB type-C PD controller support
Date:   Tue,  3 Oct 2023 11:58:33 -0400
Message-Id: <20231003155842.57313-1-alkuor@gmail.com>
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
- Add device data to accommodate different implementations

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

- In pm resume callback, patch mode needs to be checked and the binary
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

v10:
 - PATCH 1,2:
    - No changes
 - PATCH 3:
    - Add Reviewed-by
 - PATCH 4:
    - Move 0004-USB-typec-tps6598x-Load-TPS25750-patch-bundle.patch to patch 6
    - Reorder 0009-USB-typec-tps6598x-Refactor-tps6598x-port-registrati.patch
      to be patch 4
    - Add Reviewed-by
 - PATCH 5:
    - Move 0005-USB-typec-tps6598x-Check-for-EEPROM-present.patch to patch 6
    - Add device data for tps6598x and cd321x
 - PATCH 6:
    - Add tps25750 support and enable it by aggregating the following patches from v9:
      0004-USB-typec-tps6598x-Load-TPS25750-patch-bundle.patch
      0005-USB-typec-tps6598x-Check-for-EEPROM-present.patch
      0006-USB-typec-tps6598x-Clear-dead-battery-flag.patch
      0007-USB-typec-tps6598x-Apply-patch-again-after-power-res.patch
      0008-USB-typec-tps6598x-Add-interrupt-support-for-TPS2575.patch
      0010-USB-typec-tps6598x-Add-port-registration-for-tps2575.patch
      0011-USB-typec-tps6598x-Enable-sleep-mode-for-tps25750.patch
 - PATCH 7:
    - Move 0012-USB-typec-tps6598x-Add-trace-for-tps25750-irq.patch to patch 7
 - PATCH 8:
    - Move 0013-USB-typec-tps6598x-Add-power-status-trace-for-tps257.patch to patch 8
    - Remove power status trace prototype from device data
 - PATCH 9:
    - Move 0014-USB-typec-tps6598x-Add-status-trace-for-tps25750.patch to patch 9
    - Remove status trace prototype from device data
	
v9:
 - PATCH 1: 
    - Add Reviewed-by
 - PATCH 2..7:
    - No changes
 - PATCH 8:
    - Move of_device_id to its original place
    - Move device data structs to the top of of_device_id
    - Use device_get_match_data to get device data
 - PATCH 9:
    - No changes
 - PATCH 10:
    - Move device data structs to the top of of_device_id
 - PATCH 11,12:
    - No changes
 - PATCH 13,14:
    - Move device data structs to the top of of_device_id
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

Abdel Alkuor (9):
  dt-bindings: usb: tps6598x: Add tps25750
  USB: typec: tsp6598x: Add cmd timeout and response delay
  USB: typec: tps6598x: Add patch mode to tps6598x
  USB: typec: tps6598x: Refactor tps6598x port registration
  USB: typec: tps6598x: Add device data to of_device_id
  USB: typec: tps6598x: Add TPS25750 support
  USB: typec: tps6598x: Add trace for tps25750 irq
  USB: typec: tps6598x: Add power status trace for tps25750
  USB: typec: tps6598x: Add status trace for tps25750

 .../devicetree/bindings/usb/ti,tps6598x.yaml  |  81 ++-
 drivers/usb/typec/tipd/core.c                 | 626 ++++++++++++++++--
 drivers/usb/typec/tipd/tps6598x.h             |  36 +
 drivers/usb/typec/tipd/trace.h                |  92 +++
 4 files changed, 764 insertions(+), 71 deletions(-)

-- 
2.34.1

