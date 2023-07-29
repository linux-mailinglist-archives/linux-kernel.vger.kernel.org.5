Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E33A767F78
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjG2Nnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG2Nnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:43:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E033ECA;
        Sat, 29 Jul 2023 06:43:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686b9920362so2219415b3a.1;
        Sat, 29 Jul 2023 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638218; x=1691243018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbtLma1T2CR1OS6BhEpG9M60IGb1m30I8WL7RFprIGQ=;
        b=SDcMg4mCE1YxrcJ94C4lEdIP87ty02Dnnl7hxvKP2R7H/WNzkQv57cWjHwWil4gute
         BwLbmYqkwXZrAzQH15VPJ7ZCrK4W3MJLKVRv7mP1tUUYF2Chfye2wiwqJYw/tXYZ+W5b
         8cMzFC8dddVWbb2nr9v3jIUbSkrmzL0XPvsGAyGQWK5mziIeq/jcjWvI0vOLCB9dZVRP
         U4Xml5x63Hmb2stMKAaFwSS5ihu1CxfCVzOwmabRcd82cbf1hlig0jxtBwIM0CrcxJHR
         u+IukWKRDgtLUO2XBvnv2kMF0j+c7jxMatI5cRslbhRGADaauRw0VFqK/QRsGX88lb0Y
         2P/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638218; x=1691243018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbtLma1T2CR1OS6BhEpG9M60IGb1m30I8WL7RFprIGQ=;
        b=PabvFoF1FacVvi7m8lfwAolryr+NGq4/a8ig4OmRgUHjF+fwdQJZuI8OlQOPx4Al9W
         hIWqHkChcZfBkg27eLI6IwFJEnoXt3LAshMZXR5aalQ9YEYsTJpuTnrpTDxDktefBD8s
         TnTCIyJ0Lu5QQsrF8MghowilFy48/P3z9j4hCijGSOr7RQXXx4biowaijGPNo6y7EGcG
         iv7BpUdLn6Gh6iNjqPhh0LdgEM5OXJkcGoOvBHJE9rp65mFKgxwt9//OJhWXQFoQvxTa
         Qj+xAhpR1jwcEOTx4aLKM1H4iRmnTdiyh40a9ggJYmuribfqd/lBbqjSS2gpLsNx+AFV
         7u3g==
X-Gm-Message-State: ABy/qLbJ3+I+gLoRwONhaJXRbmEyYkAIDdKk1O2REnBSwXo3/IZbEtpF
        9L2Eg7/BtDOBcR8A75Pb6HLcSqc10epyPw==
X-Google-Smtp-Source: APBJJlHOk6K173rI5KQoDx5QpI80BdhSKlXCjh4y6P8Ri7NH5wyEMXzvPGaUbUzn5eGQp8UgycI0ig==
X-Received: by 2002:a05:6a20:7da1:b0:134:16a3:83ad with SMTP id v33-20020a056a207da100b0013416a383admr4927585pzj.57.1690638217869;
        Sat, 29 Jul 2023 06:43:37 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:43:37 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 00/17] MIPS: loongson32: Convert all platform devices to DT
Date:   Sat, 29 Jul 2023 21:43:01 +0800
Message-Id: <20230729134318.1694467-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all platform devices to devicetree.
Remove all the obsolete code of platform device.
Adapt the common code to support devicetree.
Update Kconfig and Makefile files accordingly.
Update and rename the defconfig.

Keguang Zhang (17):
  MIPS: loongson32: Get the system type from DT
  MIPS: Modify the Loongson1 PRID_REV
  MIPS: dts: Add basic DT support for Loongson-1 boards
  MIPS: loongson32: Modify Loongson-1B/1C related Kconfig options
  MIPS: loongson32: Adapt the common code to support DT
  MIPS: loongson32: Convert platform IRQ driver to DT
  MIPS: loongson32: Convert UART platform device to DT
  MIPS: loongson32: Convert Ethernet platform device to DT
  MIPS: loongson32: Convert GPIO platform device to DT
  MIPS: loongson32: Convert GPIO LED platform device to DT
  MIPS: loongson32: Convert USB host platform device to DT
  MIPS: loongson32: Convert RTC platform device to DT
  MIPS: loongson32: Convert watchdog platform device to DT
  mips: dts: loongson1b: Add PWM timer clocksource
  MIPS: loongson32: Remove all the obsolete code of platform device
  MIPS: configs: Update and rename loongson1b_defconfig
  MIPS: configs: Update and rename loongson1c_defconfig

 arch/mips/Kconfig                             |  62 ++--
 arch/mips/boot/dts/Makefile                   |   1 +
 arch/mips/boot/dts/loongson/Makefile          |   3 +
 arch/mips/boot/dts/loongson/loongson1.dtsi    | 161 ++++++++++
 arch/mips/boot/dts/loongson/loongson1b.dtsi   | 201 ++++++++++++
 arch/mips/boot/dts/loongson/loongson1c.dtsi   | 144 +++++++++
 arch/mips/boot/dts/loongson/lsgz_1b_dev.dts   |  88 ++++++
 arch/mips/boot/dts/loongson/smartloong_1c.dts |  84 +++++
 ...gson1c_defconfig => lsgz_1b_dev_defconfig} |  71 ++++-
 ...on1b_defconfig => smartloong_1c_defconfig} |  70 ++++-
 arch/mips/include/asm/cpu-type.h              |   3 +-
 arch/mips/include/asm/cpu.h                   |   3 +-
 arch/mips/include/asm/mach-loongson32/dma.h   |  21 --
 arch/mips/include/asm/mach-loongson32/irq.h   | 107 -------
 .../include/asm/mach-loongson32/loongson1.h   |  50 ---
 arch/mips/include/asm/mach-loongson32/nand.h  |  26 --
 .../include/asm/mach-loongson32/platform.h    |  26 --
 .../include/asm/mach-loongson32/regs-mux.h    | 124 --------
 arch/mips/kernel/cpu-probe.c                  |   6 +-
 arch/mips/loongson32/Kconfig                  |  41 +--
 arch/mips/loongson32/Makefile                 |  14 +-
 arch/mips/loongson32/common/Makefile          |   6 -
 arch/mips/loongson32/common/irq.c             | 191 ------------
 arch/mips/loongson32/common/platform.c        | 287 ------------------
 arch/mips/loongson32/common/prom.c            |  42 ---
 arch/mips/loongson32/common/setup.c           |  26 --
 arch/mips/loongson32/common/time.c            |  23 --
 arch/mips/loongson32/init.c                   |  83 +++++
 arch/mips/loongson32/ls1b/Makefile            |   6 -
 arch/mips/loongson32/ls1b/board.c             |  57 ----
 arch/mips/loongson32/ls1c/Makefile            |   6 -
 arch/mips/loongson32/ls1c/board.c             |  23 --
 arch/mips/loongson32/proc.c                   |  20 ++
 33 files changed, 941 insertions(+), 1135 deletions(-)
 create mode 100644 arch/mips/boot/dts/loongson/loongson1.dtsi
 create mode 100644 arch/mips/boot/dts/loongson/loongson1b.dtsi
 create mode 100644 arch/mips/boot/dts/loongson/loongson1c.dtsi
 create mode 100644 arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
 create mode 100644 arch/mips/boot/dts/loongson/smartloong_1c.dts
 rename arch/mips/configs/{loongson1c_defconfig => lsgz_1b_dev_defconfig} (59%)
 rename arch/mips/configs/{loongson1b_defconfig => smartloong_1c_defconfig} (59%)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/dma.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/irq.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/loongson1.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/nand.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/platform.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-mux.h
 delete mode 100644 arch/mips/loongson32/common/Makefile
 delete mode 100644 arch/mips/loongson32/common/irq.c
 delete mode 100644 arch/mips/loongson32/common/platform.c
 delete mode 100644 arch/mips/loongson32/common/prom.c
 delete mode 100644 arch/mips/loongson32/common/setup.c
 delete mode 100644 arch/mips/loongson32/common/time.c
 create mode 100644 arch/mips/loongson32/init.c
 delete mode 100644 arch/mips/loongson32/ls1b/Makefile
 delete mode 100644 arch/mips/loongson32/ls1b/board.c
 delete mode 100644 arch/mips/loongson32/ls1c/Makefile
 delete mode 100644 arch/mips/loongson32/ls1c/board.c
 create mode 100644 arch/mips/loongson32/proc.c


base-commit: f11a9967413281b49690d864795e7c5f8f8e4fda
-- 
2.39.2

