Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3807D114A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377435AbjJTOOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377482AbjJTOOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:14:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A6819E;
        Fri, 20 Oct 2023 07:14:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b95622c620so135988266b.0;
        Fri, 20 Oct 2023 07:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697811268; x=1698416068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JD6mwhJo/tCFNUNjBKLMUK7FnEMFViJbfce3FCLQYtQ=;
        b=InkirstUr6E8D1dE9yUQ4MJafSx2exke+1vbcYqZN/UMEnvgWFe/1Mj0XAjtAqiRiz
         iDPXouySnaGHIPSb3ZFVcI1qpNCgDIajfI6K05xDUFf50s7a75dQLDkt85xs8sIc6+d5
         7T4M/Vw1Tbz3/oy6dunLkyL6DmONL08p4GdzFvtdiMX9mT8i1Z5/QkDP6V5zHVpYB61M
         rwdl9HKtB4T3mTHCRNyGhYTBocRM+d/MGE6KEOVbPuWoIHgiKl5d7JyQ4X2CodylBqHY
         jUOGGxTuec31oOjwd0yQW0XNwZYfCV8hsMMqzeoA82svu5bI/FVECN8DN7kLYbJ1IP4f
         qRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697811268; x=1698416068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JD6mwhJo/tCFNUNjBKLMUK7FnEMFViJbfce3FCLQYtQ=;
        b=vyyXcjy+h1A/CXC5w09XsGGJXaDVlRhlxWEZJkDZdcLpzG2vS0X5kAaaoNwHfb5LqH
         26Db+6s9ZvO9GfcyhYN3vFgkccvhPxf4mZNp7xAB+gDDd7lz1DWBEuIQTEF0+7jvnbPo
         PN8nJoSIAZH+KX5sm8Um/KuTDAOeEG4OhND8dzNJTiJywfDYOKKimdanYgbJ7FPWKd87
         /TOwrsZFDaB1HcB7uq9p5e2sitsotsG6xvjcIfkwBM8XpgzjBQe61c5KJdqgAisIL2c1
         oXVVkzq1QMB7zquZp2l9S3kpJjFkMxM1GiJcOEjS1LvhjbYkdpuA5LH6CE4UhTwmcVfP
         FCtQ==
X-Gm-Message-State: AOJu0YxolzKQiwg7zZCYiQWr/CfwtdDYv04lfCJEOovUFQl4uM5ld4vr
        iq5IN2syTU/5k/9jtIl0F+o=
X-Google-Smtp-Source: AGHT+IGmERrWAay7b+If8tZoAmQ4S1RFkTpTIwEll3L/kV+G3BUQR3yqTiTtQf3iRMsSXt4vd4rJ6g==
X-Received: by 2002:a17:907:3183:b0:9bd:7f40:caa5 with SMTP id xe3-20020a170907318300b009bd7f40caa5mr1208771ejb.77.1697811268005;
        Fri, 20 Oct 2023 07:14:28 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-109.cust.vodafonedsl.it. [188.217.59.109])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090671c600b009ada9f7217asm1562914ejk.88.2023.10.20.07.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 07:14:26 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     sakari.ailus@linux.intel.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, mhecht73@gmail.com,
        linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v10 0/3] media: i2c: Add support for alvium camera
Date:   Fri, 20 Oct 2023 16:13:48 +0200
Message-Id: <20231020141354.2500602-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series add support for Allied Vision Alvium camera.
The Alvium camera is shipped with sensor + isp in the same housing.
The camera can be equipped with one out of various sensor and abstract
the user from this. Camera is connected via MIPI CSI-2.

Driver use latest V4L2_CCI_I2C API.

https://www.alliedvision.com/en/products/embedded-vision-solutions/

Tested the following alvium models:
 - alvium 1500 C-500c
 - alvium 1800 C-2050c
 - alvium 1800 C-1240c
 - alvium 1800 C-040c
 - alvium 1800 C-052c
 - alvium 1800 C-240m

Note:
 - Driver is rebased on top of [1], commit [2].

Thanks & Regards,
Tommaso

 - [1] https://git.linuxtv.org/sailus/media_tree.git/log/
 - [2] media: Documentation: LP-11 and LP-111 are states, not modes (c9a1b0b583db)

Tommaso Merciai (3):
  dt-bindings: vendor-prefixes: Add prefix alliedvision
  media: dt-bindings: alvium: add document YAML binding
  media: i2c: Add support for alvium camera

 .../media/i2c/alliedvision,alvium-csi2.yaml   |   81 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    9 +
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/alvium-csi2.c               | 2666 +++++++++++++++++
 drivers/media/i2c/alvium-csi2.h               |  489 +++
 7 files changed, 3258 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h

-- 
2.34.1

