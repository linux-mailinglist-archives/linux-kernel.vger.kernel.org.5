Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223E1783D97
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjHVKJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjHVKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:09:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC7B1B2;
        Tue, 22 Aug 2023 03:09:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5694a117254so2956062a12.0;
        Tue, 22 Aug 2023 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692698994; x=1693303794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ciBMl2mGlvJS8T/gem3eugoi/TfUw2kLIEzMHtRsdoE=;
        b=CSrMA5TOdHZkHbbFJxKNjMZAJ/XAcH1JNp5SJpTzrSbL73h6mK90JJ+7xI6yMh7IIL
         6UfV+qMnUVXI54y1Qsk8umnSqXdXZpEqtNs4dUzcZwceALJkgcWsA8Us8hcgg13XWIOO
         bwUzNj41EhBOgd1xNia+jJuylmvuHIFWPg70BlIkZyZRaXxxavqW72HzjQf19Bk2TIxh
         ZK4wKz0AEi5bs2HK9bX0xPTaxWFzv+sy0S198Y2uYTgjdvdHSw1in7OGwPL45A6ZS6RJ
         EJK2Yqf3xsy4j9fTUmWdfscQSscWtZJ5zp5wyD1PzEBc0Zg4zq8n/FRs5PkQ9t+4248G
         U++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692698994; x=1693303794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciBMl2mGlvJS8T/gem3eugoi/TfUw2kLIEzMHtRsdoE=;
        b=kKMySRqJFRXbYiHCjlPwfEJg+bg1xCRZa/X9c0pcfrREiiqMEzzsGHXoI1VkP1Ek0I
         xMTKo6d8YzXXFEPBAMpPrQrweNLIiLo8FxME1CI01CDUaKL+ASziSuAYvBTzbcWIK1eo
         YamKXowsk1NxYOZeAvhPmkTWVo5eMfeF92idKpx2PWEJTi1im10vpDpD5qCT1/IZGSWW
         birtIZQcf0727MTGkP7nwulMIcF7Ef36ACZP7/6oufGrN4Ewu3cKdF+Ke8heXxI8dAgD
         GzP8RDhEv9mi90LALl3UR8ezkhLZhFOyVa1NUb8zg8VGmGdEWX35GxcFm8ZiaxDqmSLP
         ZKpg==
X-Gm-Message-State: AOJu0YwM3RXd4jql2EWs7uqWRWpPaDmE3xiVczvm99qjnI3+7PAS/3Fx
        +dAHeQG3ZANugRyd0dGrucE=
X-Google-Smtp-Source: AGHT+IGSerZFofQPgjY14zgyWFezCNbK6HY1sMG0ymXiakVVjmqX42aeOVMSfFL/pcbDq7QLWvB9Gw==
X-Received: by 2002:a17:90a:34c9:b0:268:3ea0:7160 with SMTP id m9-20020a17090a34c900b002683ea07160mr7775296pjf.0.1692698994436;
        Tue, 22 Aug 2023 03:09:54 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090a948a00b00263cca08d95sm9278975pjo.55.2023.08.22.03.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 03:09:53 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v3 0/3] Add support for Nuvoton ma35d1 rtc controller
Date:   Tue, 22 Aug 2023 10:09:45 +0000
Message-Id: <20230822100948.1366487-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

