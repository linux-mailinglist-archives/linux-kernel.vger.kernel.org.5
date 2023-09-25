Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CE57AD100
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjIYHDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjIYHDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:03:09 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015D6BF;
        Mon, 25 Sep 2023 00:03:01 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6c0a3a2cc20so3669852a34.0;
        Mon, 25 Sep 2023 00:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695625381; x=1696230181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8aDz349SKKv9+MQGXfZ+z1/ikbG1yq6pnD7zJlqgtSM=;
        b=J+V3bpzy0mNtOz/q0k1jWsD9mRigO9qiVssqo/nhUe6grIYErEltxSTD0aj4g9BNE+
         ZKXTlu3D7EoTdw/Iz21WglGGPpZ7RBj+4egF56I31/swnKnNR6o5OZqcF0mqNZJkoE0S
         zeNL3sSW5tEwrtl2n2JaRGXYskJB0cLESiIbDvFAxLM3DQvz0LZkuThpvNTS6OrrJ8rI
         hbjpQupjTn8IG09LyWQi9uqxZK+ZWPqgWSm24njc6uuMIHUUxm2pfKv556SBuMlTp9jI
         XVSa9VnO25aL6d1kxJxxJcEKzLC1vjoGq8Vw52LbusTeDlSC5rgbV+LCr+CfdmD2NCSg
         npeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695625381; x=1696230181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aDz349SKKv9+MQGXfZ+z1/ikbG1yq6pnD7zJlqgtSM=;
        b=QYn2C6nNfU1eptX2TYheTu9H7V+1GIleDcjsBGkYF8YLqOOtveHBTOYFBUeKU4T8J7
         /6s2yaMDXSvhGMBRBNy2RYN5LVG/pJLH+UDuJd5xEznCNJvjDNUVxIdyhUI0b4SL2mug
         2p2wGhm9J+5nXyxWFtWQmbIFoIRmPgtrT1e2cBkprjtTBDVrSmHUahL7dkqfr6Q23IWA
         j45BpeuJ0jfpFO2RQ9oLBDK3DWFW9v4dOMm3+muIF72y3i9dq+3l2WyrG5cu8S4W6fIn
         Ml47YjewjYKvcOqLd5v29dfzL9ebSeBF6QeJqqpeOabSymM6L05tzFSaIEEQZl3zerP4
         TC3g==
X-Gm-Message-State: AOJu0YxT/gO66eZuaL3NkpNk2+yPfZZcr8kAyljik3RJ43GEopDUlFhd
        EXWvAiRG40sVIsKeTq0/rnYqKBL7JiA=
X-Google-Smtp-Source: AGHT+IFdlgHAsFON54gDD32JbB0ZiUi6gzdiPWTk7C0UUN14dZBZKnXI5ekgKJs1JogFAj7YhKfQMQ==
X-Received: by 2002:a05:6830:c9:b0:6be:fe1e:c13 with SMTP id x9-20020a05683000c900b006befe1e0c13mr7754598oto.0.1695625380989;
        Mon, 25 Sep 2023 00:03:00 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y5-20020a62b505000000b0068ffb8da107sm7349833pfe.212.2023.09.25.00.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 00:03:00 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v4 0/3] Add support for Nuvoton ma35d1 rtc controller
Date:   Mon, 25 Sep 2023 07:02:48 +0000
Message-Id: <20230925070251.28-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

This patch series adds the rtc driver for the nuvoton ma35d1 ARMv8 SoC.
It includes DT binding documentation, the ma35d1 rtc driver, and device
tree updates.

The ma35d1 rtc controller provides real-time and calendar messaging
capabilities. It supports programmable time tick and alarm match
interrupts. The time and calendar messages are expressed in BCD format.

This rtc driver has been tested on the ma35d1 som board with Linux 6.5-rc2.
It passed the rtctest and rtc-range 2000 ~ 2099.

v4:
  This version is actually a resend of v3.
  - Updated drivers/rtc/Kconfig due to this file was modified in the
    recent mainline update.

v3:
  - Update ma35d1 rtc driver
    - Renamed "TICKIEN" to "UIEN" as their functional equivalence.
    - Eliminated the usage of 'struct ma35_bcd_time' and associated
      ma35d1 bcd functions; instead, opted to directly utilize the
      "bin2bcd()" function
    - Employed "ma35d1_alarm_irq_enable()" to accommodate the
      "alrm->enabled" feature
    - Revised the probe sequence and implemented a check to verify if
      the rtc was initialized
    - Other minor fixes

v2:
  - Updated nuvoton,ma35d1-rtc.yaml
    - Modified patch title and fixed typo
    - Added reference to rtc.yaml
    - Used unevaluatedProperties instead of additionalProperties
  - Modified rtc driver
    - Used dev_err_probe()
    - Removed ma35d1_rtc_remove()
    - Made other minor fixes

Jacky Huang (3):
  dt-bindings: rtc: Add Nuvoton ma35d1 rtc
  arm64: dts: nuvoton: Add rtc for ma35d1
  rtc: Add driver for Nuvoton ma35d1 rtc controller

 .../bindings/rtc/nuvoton,ma35d1-rtc.yaml      |  48 +++
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |   4 +
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |   4 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |   8 +
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ma35d1.c                      | 324 ++++++++++++++++++
 7 files changed, 400 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
 create mode 100644 drivers/rtc/rtc-ma35d1.c

-- 
2.34.1

