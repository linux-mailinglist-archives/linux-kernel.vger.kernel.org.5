Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDF67B69F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjJCNPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjJCNPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:15:15 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD73BF;
        Tue,  3 Oct 2023 06:15:12 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c1854bebf5so10981851fa.1;
        Tue, 03 Oct 2023 06:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696338911; x=1696943711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D3fi78NvQEfjOfWzfX4wAjQLrovVfB04wfletul8KM0=;
        b=S9GmHOvAhFD9hQer6A8ULWnVm7H8SfV2h07OdO45w1ORexZHOBUCQ2QG7xwPdFKta/
         tz72ww9BaMgrA0zCZVmAylKC6zr2UcNQNIUaGRFgmHTcisMr73F4uGF6K32FCnO0HHz3
         jyrg9Ruw9nvHCwp+X4k5JpJ6iR7dcVct6SCrnpUsxtiTPz6yAJlamTslLjaNSDw8Z7CN
         OffJf8n6uWUGFdi8qiyV1HYGPEzaCx90h+sJenqzgc+4u1IQya0WIo78Wodm4kUuNdvR
         V68UUzGtK/kgBTtJ+1cBwdAsqC+hSKhCBr6aSrAjhFaWn77gtSIYDUfQmZ/ulYQszJP+
         oJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696338911; x=1696943711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3fi78NvQEfjOfWzfX4wAjQLrovVfB04wfletul8KM0=;
        b=nAyfEjGDm/2LMiioEbNydCwHMQ9mhVF1+Ax6UwXIcV2xBUkoI10EIlUNkx+40kyKvW
         5TPikUgtn75518lPGKHI4ceZ1mFl31VTavGrN+EgRxgbIa/Gsx7VALWvm7rXP8FlX5FX
         bGUBAbeMB5bXTjUozYcltRVmbEVo/IP+Sw03pf3GWh506nmLTWoLe/OsGgnIX8731CrH
         MpKE6FrauOHtTUbOhvRs8X4nUmki3V6IlOl13a+x1jIeQ6icVHXSOwfbpr4ZWqp6lXqU
         ZiXBYn3SHxekVfXWs8HAjJS1Tz5eC8B4AbFO84mN4I2XHpvIGCIOIPlcPeGAOhjKt7af
         NenQ==
X-Gm-Message-State: AOJu0YwTmVYcTqpt9Ml0p71WecB5fQuYuNZAlZI4tM5l+ix5O4f3XFy4
        zOy+07yieLdr6rSeC7AWmKk=
X-Google-Smtp-Source: AGHT+IGtOe4J8GfD2HhulRf4hZgg+Q4XRQ/Bo4dVYtzPaSqmA5wmNUiaHv9t6UFcrUVi5fzVNQWg5w==
X-Received: by 2002:a2e:3a07:0:b0:2c0:ff6:984a with SMTP id h7-20020a2e3a07000000b002c00ff6984amr11636722lja.50.1696338909804;
        Tue, 03 Oct 2023 06:15:09 -0700 (PDT)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id t25-20020a2e7819000000b002b9de06f119sm228657ljc.67.2023.10.03.06.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 06:15:09 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     minyard@acm.org, joel@jms.id.au, andrew@aj.id.au,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        aladyshev22@gmail.com, jk@codeconstruct.com.au,
        matt@codeconstruct.com.au, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org
Subject: [PATCH v3 0/3] Add MCTP-over-KCS transport binding
Date:   Tue,  3 Oct 2023 16:15:02 +0300
Message-Id: <20231003131505.337-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds a MCTP KCS transport binding, as defined by the DMTF
specificiation DSP0254 - "MCTP KCS Transport Binding".
A MCTP protocol network device is created for each KCS channel found in
the system.
The interrupt code for the KCS state machine is based on the current
IPMI KCS driver.
Since the KCS subsystem code is now used both in IPMI and MCTP drivers
the separate patchsets move KCS subsystem includes to a common folder.

Tested:
PLDM communication between the HOST and BMC was tested with both
components implemented via open-source software:
- The HOST (UEFI firmware) part was based one the edk2 [1] and
edk2-platforms [2] code,
- The BMC part was based on the openbmc [3] distribution.

The testing process and all the necessary utilities are described in
the [4] repository.

[1]: https://github.com/tianocore/edk2
[2]: https://github.com/tianocore/edk2-platforms
[3]: https://github.com/openbmc/openbmc
[4]: https://github.com/Kostr/PLDM

Changes v2 -> v3:
 - use 'dev_err_probe' correctly

Changes v1 -> v2:
 - correct warning found by kernel test robot
 - use 'i2c_smbus_pec' library function for PEC calculation
 - several code style corrections based on Jonathan Cameron comments
Original patchset can be found here:
https://lwn.net/ml/linux-kernel/20230928123009.2913-1-aladyshev22@gmail.com/

Konstantin Aladyshev (3):
  ipmi: Move KCS headers to common include folder
  ipmi: Create header with KCS interface defines
  mctp: Add MCTP-over-KCS transport binding

 drivers/char/ipmi/kcs_bmc.c                   |   8 +-
 drivers/char/ipmi/kcs_bmc_aspeed.c            |   3 +-
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c         |  73 +--
 drivers/char/ipmi/kcs_bmc_npcm7xx.c           |   2 +-
 drivers/char/ipmi/kcs_bmc_serio.c             |   2 +-
 drivers/net/mctp/Kconfig                      |   8 +
 drivers/net/mctp/Makefile                     |   1 +
 drivers/net/mctp/mctp-kcs.c                   | 594 ++++++++++++++++++
 include/linux/ipmi_kcs.h                      |  80 +++
 .../char/ipmi => include/linux}/kcs_bmc.h     |   0
 .../ipmi => include/linux}/kcs_bmc_client.h   |   3 +-
 .../ipmi => include/linux}/kcs_bmc_device.h   |   3 +-
 12 files changed, 693 insertions(+), 84 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-kcs.c
 create mode 100644 include/linux/ipmi_kcs.h
 rename {drivers/char/ipmi => include/linux}/kcs_bmc.h (100%)
 rename {drivers/char/ipmi => include/linux}/kcs_bmc_client.h (97%)
 rename {drivers/char/ipmi => include/linux}/kcs_bmc_device.h (96%)

-- 
2.25.1

