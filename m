Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D1175A3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGTB26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGTB24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:28:56 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52372690;
        Wed, 19 Jul 2023 18:28:33 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8ad9eede0so1919835ad.1;
        Wed, 19 Jul 2023 18:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689816513; x=1690421313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RLL2tr+LIqX1NO/Pc6Wrphl4U7IYBQOy7XNovYEZclQ=;
        b=GPSmmtDPWNsIkTZDwpeml90XUUsdUDNJLkiIu7LZuUkn/gywuhX58ThYa/svu0oz+z
         sdV3nprLThqbBBFc/9TgUzZY45eDde3YlmYZCVhugTuH54XKHfTtB25pwNW/UK+p1YVa
         vUsPO4qXqk+AjR/dy1+4roSJ26nLT587NiVZmEIBwTKVdDR8Ok27yR/vL4rjIZ1XhOH9
         VICMuvFIiBRzoCT1XxLDTHogttTNCCQijGbXY3MHAcICmlVI5co1xBLJbbQTKdvOX9Ns
         xox8heOEOr86J0ZD8mgwKXRyygJvK8gOZONSOxB8hi5qExMcwOLCngYs82t6BdYcEFxv
         z3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689816513; x=1690421313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLL2tr+LIqX1NO/Pc6Wrphl4U7IYBQOy7XNovYEZclQ=;
        b=eBp3nk9+WDYq73FLCHZz7EEdYNHHZGKoaVKpGDly4htA0JpOuMtEUsuQt/mlq5sqQ/
         C8AtDXy7vkRq0RW/jxEHJW7+xoARGqfH2aEwjiK9QxF6U4qgsmTNWHv5o1lcQoSTWh5N
         I3wSdZBfUeuk/YQTKpa7OFt43elDm7hoWkGPtA8AHh+Rztn+YMzYXsTmnGiGOGSZyo+N
         OynVWDrVwW0AK1Sn6r3tVE74Hua5mP+LzLZZ1MDUqALZ8HW7ki7ubN5oMub8kOs4ejYJ
         aF9DO5mIbPMz1nYAiGoMUvYVj2/E+bwvemcXkl1WAC3mWDSX/UKvY1otcY3ksW+jfJ4u
         U+Jg==
X-Gm-Message-State: ABy/qLb07EZqgzv4nZvdNY1I3Qp5bZsKgtSn2AD+27cHZDglJWsuKju9
        B1Alx5lXr4Il4uXPDwF01GA=
X-Google-Smtp-Source: APBJJlH7o+eExptczkCECKURCD9Em0bpUiO2dPHusBQmDrgRDRdwQxGXlsePstVPgqTqvEZNkiOSfg==
X-Received: by 2002:a17:902:cecd:b0:1b2:1a79:147d with SMTP id d13-20020a170902cecd00b001b21a79147dmr2551275plg.2.1689816513179;
        Wed, 19 Jul 2023 18:28:33 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jc18-20020a17090325d200b001b1a2c14a4asm4673998plb.38.2023.07.19.18.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 18:28:32 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 0/3] Add support for nuvoton ma35d1 rtc controller
Date:   Thu, 20 Jul 2023 01:28:23 +0000
Message-Id: <20230720012826.430026-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Jacky Huang (3):
  dt-bindings: rtc: Document nuvoton ma35d1 rtc driver
  arm64: dts: nuvoton: Add rtc for ma35d1
  rtc: Add driver for nuvoton ma35d1 rtc controller

 .../bindings/rtc/nuvoton,ma35d1-rtc.yaml      |  45 +++
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |   4 +
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |   4 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |   8 +
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ma35d1.c                      | 371 ++++++++++++++++++
 7 files changed, 444 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
 create mode 100644 drivers/rtc/rtc-ma35d1.c

-- 
2.34.1

