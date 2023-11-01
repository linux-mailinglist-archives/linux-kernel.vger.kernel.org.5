Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ACA7DE0FC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 13:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjKAMWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 08:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjKAMWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 08:22:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A39DC;
        Wed,  1 Nov 2023 05:22:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso4661675e9.0;
        Wed, 01 Nov 2023 05:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698841327; x=1699446127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BjWwvbx9iT+mOBKUh+zz5yK4NcqWVClh7zBDqkGGYrU=;
        b=fskwgSImzt0ZRa9VFHxbSrsmfapXCiSlu/eo7e1NNaQC9MFXL2/r90x23lklFzlH+g
         YEaRJcoKTvXIb9aXL3tRgnF1im+4Po/hliQpJPcUf+/xopPVTK22Xvsnva9Zk8nk70h+
         voNTPX3AipqXCGk6l2vqD7Qxeh1al79125WHjKUAYIgq+/S8DDgNYprw2BOxqlrKZl97
         LpUhtaalPF4Th1Txao3uWSK3A3yBAawq9p+S5ca+jx5yv87+GzY9BfLQB8CkQZ+RVjh9
         dKd3x2pjEQbaaVyOm6xf5jd5Kz8SqTk6OZkxhewVVWoZ4gW/RUZDDK5H2odOW2FhfoZb
         Xrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698841327; x=1699446127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjWwvbx9iT+mOBKUh+zz5yK4NcqWVClh7zBDqkGGYrU=;
        b=leuMQFoWYM8K5v4AgiNQ129uqKmV5PStk3p1VzHQtCU2gz48lwNcAApa0EVe43EAtn
         RwzzME8iLfek6Eite18sGc878YpG4xE5y+dKvNk+5RTveMODYwf3ps/uhuHL73Dxos74
         E9ZHEqsHjPviRcVhl/Ep5oNGCk1w+vAX6gZjCJz7tK6fk+aLkPPGmSa437HXhqKVz0RA
         uhSOKNEkw0tqdfaU9xYirtbH6JzX+0/Cvd7bYnI8zppewIwZ3wXKdZCn+7QMS7kPQFxm
         mnzszPeAL8qKUiic7JfNmeCQzZeZZADNjsfySPt5yVAPyvIVRJxJzFLTu2N4GCXwoJXz
         qP0A==
X-Gm-Message-State: AOJu0YwxsTC78KBibIv2b1RrKYAHESOWdUwN6wtFDeO2bNvjm+fwzUOZ
        gav+sDUMpZ0vbfwwD2QKww+GicRf39U=
X-Google-Smtp-Source: AGHT+IGH5wP44nEykO6DSElILkiSjiNtZSoYMhZe3XrlNAILhlXGRH2S4S7sIy+qUgAI0AH49E8Zhw==
X-Received: by 2002:a5d:64a7:0:b0:32f:8a45:937f with SMTP id m7-20020a5d64a7000000b0032f8a45937fmr8537847wrp.2.1698841326758;
        Wed, 01 Nov 2023 05:22:06 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-109.cust.vodafonedsl.it. [188.217.59.109])
        by smtp.gmail.com with ESMTPSA id i17-20020a5d6311000000b0031ad5fb5a0fsm4024582wru.58.2023.11.01.05.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 05:22:06 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        mhecht73@gmail.com, sakari.ailus@linux.intel.com,
        christophe.jaillet@wanadoo.fr,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v12 0/3] media: i2c: Add support for alvium camera
Date:   Wed,  1 Nov 2023 13:21:54 +0100
Message-Id: <20231101122200.1203499-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/media/i2c/alvium-csi2.c               | 2638 +++++++++++++++++
 drivers/media/i2c/alvium-csi2.h               |  488 +++
 7 files changed, 3229 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h

-- 
2.34.1

