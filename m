Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FD67DC75C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343717AbjJaHe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjJaHeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:34:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBF9C0;
        Tue, 31 Oct 2023 00:34:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9d23be183c6so392953866b.0;
        Tue, 31 Oct 2023 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698737661; x=1699342461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4R7qfxkAUts+GNkbc9ZQgh8+ApqKGaySjT2ogtTRziw=;
        b=Bls5EoWYJIGLtedlJSboGHI8zDgSzONz48UZWXBatJzWyhPbsuauaibA013sEXahhU
         SNBifGpI9tzOgoQWZwEmO5a2Fhkf1E/OwNoreznzHGS3glMdKSp4wOlOjBS7g/LMvZSW
         SjPRaxrXDsOy9l1IrPGeRf1F2oETPZtGqTlZwm1j8xVvNZotoE33jCZKnE8qNx5Ft4Rk
         mRtCJsy8HxOVSllz4QP2LBoJ4VmYCY1BsFzqBTuSHzeSgBNeiBAQakhhqZNuJKJLlOpM
         MkhHXyp/s7VLprESgb13KYoJ44xyZwlwqplbRpIy6GwX0FtCmAlL0sxRHYZtNSNExx6K
         C4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698737661; x=1699342461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4R7qfxkAUts+GNkbc9ZQgh8+ApqKGaySjT2ogtTRziw=;
        b=FPM6NrxXEo9/wqYGVVzgCPjl4f64O76oLkaaXDdtuqZaqHAm2+rKbV0TRq0GLj76jP
         I+np+IoTEaUj2Y0tsxYznhmQBbbMNaXF/IoSdZf/CyyOAI7L6O0rw09QIXiZhAv52hdt
         5YuPp4WRqHasnMMP6yzsxhYdoaSf59/FUjdqICvBgO2R7qwRo1HyRYN4D6PFwxAJA5ue
         4lks+l7iuChyNig2tPsBSW1sqecP2ucU7qMuvQaryPcgpKRX6I2gddno0c4Uejy5nrE2
         7d65TiTVUooGKWMR43dT/3mXP8RtJWamdPrxYmK92HdiayAfCgYvFdoNZ8dI2W9CLesp
         wRRw==
X-Gm-Message-State: AOJu0Yzi1SPHTEMH5ItuWTzx83W8S5Uxh43iVABfugyfCkh1QEabIZTQ
        Ud5cdvOqXFWIIam/5xCl/WQ=
X-Google-Smtp-Source: AGHT+IHcmKrf2PleLqmWF2EUy9U0uM+ZXcdlG/AOqH6ipFhsij000srtN7dxEq4ic96whomyci7H1A==
X-Received: by 2002:a17:907:9621:b0:9c7:5651:9018 with SMTP id gb33-20020a170907962100b009c756519018mr10213943ejc.68.1698737660988;
        Tue, 31 Oct 2023 00:34:20 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-109.cust.vodafonedsl.it. [188.217.59.109])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170907984d00b009d51f9d54edsm486845ejc.126.2023.10.31.00.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 00:34:20 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        mhecht73@gmail.com, sakari.ailus@linux.intel.com,
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
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v11 0/3] media: i2c: Add support for alvium camera
Date:   Tue, 31 Oct 2023 08:34:11 +0100
Message-Id: <20231031073417.556053-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/media/i2c/alvium-csi2.c               | 2630 +++++++++++++++++
 drivers/media/i2c/alvium-csi2.h               |  488 +++
 7 files changed, 3221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h

-- 
2.34.1

