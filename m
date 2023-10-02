Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9F17B55C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbjJBOez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbjJBOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:34:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD2BD9;
        Mon,  2 Oct 2023 07:34:49 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-503065c4b25so25347096e87.1;
        Mon, 02 Oct 2023 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696257288; x=1696862088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JRo8zWXIbTH+MSsgpdMHHBi0K2uZ9yNCkZLz05HTkLE=;
        b=IzoLUZuRbbG/1JR06RvP8SCYxdeURYASMPUdei2/l/o84dC7RdJEiI6/f2JSbhwiwP
         5E5I8My/wZbDBtfNCnqG16+TcoAfFh0LCqIN2mmO58JsVz7BWUjQ36E5HPkSc1ogk1dt
         H0LtC6UpHENvf4zpfvDa/iHrz7wXxwMt4tfrtlFnRkYqF6g4k7EOLxqwTNYW3SrUKB4b
         xtvBMYjipk4a6yjh1K4EyVdh9KemLa6FhtUKWKFJ3B/V86V6GnfSIY8DOe9WiweFJ7+g
         qJbHPgsXZochv00wKjpxhxIkQaXiWXbeuTl8oTv81I1+vzoas38twzfoxFQF3eBjwXj+
         /Brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696257288; x=1696862088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRo8zWXIbTH+MSsgpdMHHBi0K2uZ9yNCkZLz05HTkLE=;
        b=rxSL6QO4V8nEzR43qyV0fyFjO+REHfi1mr56JjFnjh4Yo5PhNuGlbbp4Sd0/z0sS2X
         XLhiguNZVrSK62guD+g/RFgoHY+6Xks6sUAsQATUnH1Lj4oSbohzIzKc1WVSBJacibIJ
         WqxwD/aoRQyQ3xKt37hPhV8Vf8MRKq35ujAVU+1LE+yyp/EtVMt2m6GydQnkH3W780KZ
         4XpFW6eJfYmurAILUom4wTdsviM8Q6QKkG49EgVBvkHEALCZKi6y7vsUwnExt0VQ1RfG
         Cw3ZazDHh/XCp0QTk6gkDmaQ6jt2HBHvKgAC0M/I9nvUxsAxVmV3dSzfKUTL93ribWof
         z2RQ==
X-Gm-Message-State: AOJu0YyKqVtCZwavjPZOILkYnMv2T1IZoWo+gXKrjG/cVMCqi5rhVCOF
        cz/vemGdCuK2s0RTY/4+H/M=
X-Google-Smtp-Source: AGHT+IGwJn8GhGMJFPG4WZYvPHFRKQvx5LlaU+/vQduxSEbireFYq96lWqu+zy/REw5BiwvxHGfi0Q==
X-Received: by 2002:a05:6512:3134:b0:502:fe11:a694 with SMTP id p20-20020a056512313400b00502fe11a694mr9225535lfd.45.1696257287690;
        Mon, 02 Oct 2023 07:34:47 -0700 (PDT)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id e8-20020ac25468000000b004faa2de9877sm4751642lfn.286.2023.10.02.07.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:34:47 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Add MCTP-over-KCS transport binding
Date:   Mon,  2 Oct 2023 17:34:38 +0300
Message-Id: <20231002143441.545-1-aladyshev22@gmail.com>
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

