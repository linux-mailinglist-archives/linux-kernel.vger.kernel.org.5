Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481257C4E17
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbjJKJFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjJKJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:05:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E831F9C;
        Wed, 11 Oct 2023 02:05:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9b70b9656so11441385ad.1;
        Wed, 11 Oct 2023 02:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697015115; x=1697619915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bosxL+8et3E8ZP6PazhMinI/ihrJEatAni1oUF+fH1M=;
        b=BUSPYfcknw6g+HNqoRxtLfV3bXxrgwSPpW0rDeSfMHpUM2mDAGtFEXDDYoBfylmq5I
         Gv86MjILpst/+/FXOZP4GdgZY/NbjYApqoS8w6O1PVFzLdZScWRi437GNBzAQXLt/erz
         8/WeUGCRlpBQovRrbZIVld/FqLFlYgRzn+R6ow3qa3Pwlhu8VW9NQX9wflwr3wvJ4Acc
         5D6pi7gJWAGZtywB9iME5CvcX/iinmV37kOajQwQCLb0bFJbYViqwJKcFShG3luoekHE
         2Bg+8C6jAum3upUGo54I3KaakhInjuHkZM1iL0JFKuJgRuWihRYBm0Ml/duHzFpP2BKj
         e7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697015115; x=1697619915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bosxL+8et3E8ZP6PazhMinI/ihrJEatAni1oUF+fH1M=;
        b=QPcua4p0l8yZd+kVyKj8F5lp+dfOSAipGH8Ov2h5VP/0Qs0yhfkNEKSWkcQEXesDxf
         ppQSX6PxnFJr8RHAhBVQoaF1p8w+/zA9QONnerT+LSWokvZ1xjhz6j/p8a+ujM0pJbTt
         Zp6MBts9YOwHBVWpcAed2zoIgMUIfFjLp+g4evNA0cERVoSincorja/hGkFXTEkJsMlX
         gYdGlMbpwsTjtn7DV+Ams2qJvz4locl2wngcBRpDBxlHVcMplcXaQFerwbHdNuDNnS7H
         gY3gYmhrWGdfoLAtY/TrEdQCq4W4lK2heR+98DbwaO2Mld93c3XAdPoa8mlsGoF75Gww
         gdXA==
X-Gm-Message-State: AOJu0YwyYpNvlxik6HDrYN3q2zHqb4FPcfYjAfi8O+2gfTqUTbA4TCpn
        M1lQXsb7VfEY1xlL3/xDd0o=
X-Google-Smtp-Source: AGHT+IFRUykmbXsKgpu7miP1944x4RothTBFt0RMyulPs0mCWdyP/ti6UAcufO/wIJrf40ewm3z7ZQ==
X-Received: by 2002:a17:902:e743:b0:1c8:a132:a00f with SMTP id p3-20020a170902e74300b001c8a132a00fmr10865378plf.12.1697015115383;
        Wed, 11 Oct 2023 02:05:15 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001c61df93afdsm13346699plg.59.2023.10.11.02.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 02:05:15 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 0/4] Add support for nuvoton ma35d1 pin control
Date:   Wed, 11 Oct 2023 09:05:06 +0000
Message-Id: <20231011090510.114476-1-ychuang570808@gmail.com>
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

This patch series adds the pin control and GPIO driver for the nuvoton ma35d1
ARMv8 SoC. It includes DT binding documentation, the ma35d1 pin control driver,
and device tree updates.

This pin control driver has been tested on the ma35d1 som board with Linux 6.6.

Jacky Huang (4):
  dt-bindings: reset: Add syscon to nuvoton ma35d1 system-management
    node
  dt-bindings: pinctrl: Document nuvoton ma35d1 pin control
  arm64: dts: nuvoton: Add pinctrl support for ma35d1
  pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver

 .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       |  180 ++
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  |    3 +-
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |   83 +-
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |   86 +-
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  175 +-
 drivers/pinctrl/nuvoton/Kconfig               |   22 +
 drivers/pinctrl/nuvoton/Makefile              |    2 +
 drivers/pinctrl/nuvoton/pinctrl-ma35.c        | 1239 ++++++++++++
 drivers/pinctrl/nuvoton/pinctrl-ma35.h        |   50 +
 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c      | 1797 +++++++++++++++++
 include/dt-bindings/pinctrl/ma35d1-pinfunc.h  |   38 +
 11 files changed, 3665 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.c
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.h
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c
 create mode 100644 include/dt-bindings/pinctrl/ma35d1-pinfunc.h

-- 
2.34.1

