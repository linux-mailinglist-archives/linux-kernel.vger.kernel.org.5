Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85567F6FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjKXJaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXJaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:30:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B969130;
        Fri, 24 Nov 2023 01:30:16 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so2286050a12.2;
        Fri, 24 Nov 2023 01:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818215; x=1701423015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTLi63yxvI2hAeNdVd7eWh+ex8w0Y3/NocaKGFnahv0=;
        b=UI4txSvH000xyMnKX/M8OvWuTPF6OQlCwEOGh56gmdZwzZUMIo+/UXeduMWzUEhkTg
         t2xGFlVXh4YmVDKq1wA5VOqVYwYneKw4rdlEGlUEcUtiB9ceRNeT1I7lY84aNk8lkbNq
         RxaxFLtuSddqe+rO8eVTpI/7ujiTtLFQJ49ugLEpiG1NCpSVaj6dk42qERPjbCRpT4Va
         FJPvwLBdAaP6BBP8ezLMgssCob2OSdTKDR8djxEVVDdEBkLHRqtYgXYfb0ot2BuaOxCR
         lVwmtuyN6z+81nMpqhe0oudUZrgM5356KWC17XPDD15JGoRqN190w5uOoxbcI/PqpvdF
         kR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818215; x=1701423015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTLi63yxvI2hAeNdVd7eWh+ex8w0Y3/NocaKGFnahv0=;
        b=jxp56YKjXTZPpLpQ5EPts0O3A854TAuIBoSAxa1NI/sAFaIHLr4gGUV+fyzEoYbFEM
         ygcM8nnGPpF2v/xBaExxbas/hBmkUcchW9XYgM2Cje/kUCT2NGT0pG+SAzeExww2CZ08
         mA5KQszkzvpsuZf+FxXWItRUq2f/JkuJYhRDJI75mYN7mYmHbWXI2TAqJrggFhOuRe+h
         1kn/DPZWxGTl3EDfGrp4Lb8CEcV2QCYLj4KtBU9f1AF8d3Y6ci+j5XUK/VjkVFodd5e8
         6dcO5AvDwo8eBoz+BjptQe42sxzjZkuhl9TEWutf+UsMG5OhfW/QC2NrHoEgAYgpAMqg
         ibzg==
X-Gm-Message-State: AOJu0YzfiRavg4XBW5j+e3YE+E6DpTosoY7Fu45z1oL0HLpaxzYPy9p6
        6fdj/m09wvNQoorqRvaFcH8=
X-Google-Smtp-Source: AGHT+IGPti/ZJ8SMLxBE6yNQ/JfwqQ7RjyBC2eII7omRB0bJTYxSO1nP8qAue4ekyc4Zxt2dIgvtMQ==
X-Received: by 2002:a17:906:74d1:b0:a02:9174:629f with SMTP id z17-20020a17090674d100b00a029174629fmr1412930ejl.55.1700818214341;
        Fri, 24 Nov 2023 01:30:14 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-2-39-142-131.cust.vodafonedsl.it. [2.39.142.131])
        by smtp.gmail.com with ESMTPSA id k9-20020a170906578900b009fee12d0dcdsm1856307ejq.15.2023.11.24.01.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:30:13 -0800 (PST)
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
        Bingbu Cao <bingbu.cao@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v14 0/3] media: i2c: Add support for alvium camera
Date:   Fri, 24 Nov 2023 10:30:04 +0100
Message-Id: <20231124093011.2095073-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
 - [2] media: Documentation: Initialisation finishes before subdev registration (f7af8049dd07)

Tommaso Merciai (3):
  dt-bindings: vendor-prefixes: Add prefix alliedvision
  media: dt-bindings: alvium: add document YAML binding
  media: i2c: Add support for alvium camera

 .../media/i2c/alliedvision,alvium-csi2.yaml   |   81 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    9 +
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/alvium-csi2.c               | 2532 +++++++++++++++++
 drivers/media/i2c/alvium-csi2.h               |  483 ++++
 7 files changed, 3118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h

-- 
2.34.1

