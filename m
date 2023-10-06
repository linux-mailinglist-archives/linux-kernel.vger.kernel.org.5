Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382747BB4A9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjJFKC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjJFKCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:02:25 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3F7AD;
        Fri,  6 Oct 2023 03:02:23 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c131ddfc95so23676581fa.0;
        Fri, 06 Oct 2023 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696586541; x=1697191341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ktL+I01NTaZsZ6v/JRIqW6LdHu2rTqqgaRhir8MBsc=;
        b=H78SdxDPsTsFzhFgxmfWyWbboIaJdFopLTzyePenz+oGrqhmXbdiqHibkCcUWaNBPD
         ihnzJkvb62MgSoMlsmQj5n7F1sGyhdbG9OVvRQoaABFcVh1OoJ+pOahpwm5O2GVX12/b
         6dooQZ8TupBu29G1K8jg+UaKxvQsHvJZzjEJnxRfiXaZkGYratbdlaFo9cYyzUKA11Ks
         o6jy6detTHVc+bVx7fovi9gT+t6gz3uizYNKsXhUXg0KFW2oBH6VeULFu3aF6qCCXYdm
         UENHHvk9vpPVZdEayaVgNw5GB+3Ik/lLmKhF7Lpv2l7DnlekPKyZq8uDN6ueX0zsfBjB
         WLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696586541; x=1697191341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ktL+I01NTaZsZ6v/JRIqW6LdHu2rTqqgaRhir8MBsc=;
        b=UVhTypvfqu75OW2uDe7S2dI9kOoI52F55ulMxWIoNXn3ZVZE+ako1Zah+aZNBjTQyW
         GVlre6aMP36pdrm1M6hfSFZcIp5GFxk62uHqICgEY0VWMe+PGWEr/+hfW5cmKAVaudMt
         FXfqkH+oF7nSfFn7uLuowSAIypZdk47VOT57cmF56LhhuN3hBLYGvMXZsjrgnwuGtYCT
         9Hh85FVMdW8UWBCWe+cqD3wx5PS8m+H9fyNJt/8ru4wrG2RFn2NvZG23C1xGwX1EU4Jx
         bx+LWFaLSG52CycDZ9b0XvMEarznKtyGC8gzK5K0mugorbcMBbuMbyNQMu/LdoS23ORY
         e3Gw==
X-Gm-Message-State: AOJu0YwPDjqXFoxm2kXKopWtuBKmovKpweLBWByLwpscb07s7exYBAf1
        zXd7Xa4D6T1JMnZa7atM4R0=
X-Google-Smtp-Source: AGHT+IHaRqD4DeoB0LFomJ3p3asSCL0QydjpRcHT/wndYgqlLfX//Z7aKLjPnDZygv7OoEPADcdwSQ==
X-Received: by 2002:a2e:9053:0:b0:2c0:3284:64d5 with SMTP id n19-20020a2e9053000000b002c0328464d5mr5922469ljg.47.1696586541184;
        Fri, 06 Oct 2023 03:02:21 -0700 (PDT)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id x12-20020a2e9dcc000000b002bcedacd726sm713674ljj.25.2023.10.06.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:02:20 -0700 (PDT)
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
Subject: [PATCH v4 0/3] Add MCTP-over-KCS transport binding
Date:   Fri,  6 Oct 2023 13:02:11 +0300
Message-Id: <20231006100214.396-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes v3 -> v4:
 - drop 'inline' keyword

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

