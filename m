Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFF7E1BD5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjKFIVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjKFIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:21:10 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A13B0;
        Mon,  6 Nov 2023 00:21:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so4721410a12.2;
        Mon, 06 Nov 2023 00:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699258865; x=1699863665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6CAxeD9k/h7Ij3442H7AYa1Ial+ZqnbCmUdyG4+O9qI=;
        b=d2EsxuDUMwQih7luHLoCo04oleWYM7lpaOrwWeBrv9hJDf8yntqMxZIISjDFJv0x30
         piNsIzM4zn7iFmxYgie2d46ClIGhh8VuFVcvf4vQ3kAGB41bs3YBPnXS8jC9ajo+Fg4U
         mYSi1+seSMhGEv9ecjTlKtsM/dsLwelchRYjlFXyph/Yvq2jodcnExAc6yejCS+0LfNo
         789RCO90B7wEWcKll3Ne8DC8lVYkwD3eCvYRsoZ1EWIboq9SYbV/5QT0sMAF2oQP3HPN
         l0Dagu6ztit2vuquTawmIN+R0T9A0D70FKEt8oeKGq4nyCHcsMB2688bOCGhQyiAN9bH
         5sdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699258865; x=1699863665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CAxeD9k/h7Ij3442H7AYa1Ial+ZqnbCmUdyG4+O9qI=;
        b=hgOILu84SOUGWimZgxiOJfU7bRSK47Wb3joyjKCR4OBOChCmoDekTqmLNFhXzHnCyV
         QFTe4s9C8Ja5ennFFgLwxUaomt2Fq/NPovv/hKsjmG9aFRktycNEA/o7bxsuHzIxISeX
         RqAZwBrXpTUxr9tkruy+Kq2gnl/GdclIeKjQe8tKmlUnYReN8BtA1WbNp7YsEE0yve86
         FY3lEaYWf2cxnUuoJuRRMGtP3EZWaONL8wFTm7n9RpQvpgWCh3WAIRjnbKgr/lnauYQc
         q48XzQdua/MK5Tqs/NFFoVcn2HX0UlLZ1/HqExvgtCdWxySZyR9za60JJ85xqY5BURAS
         VVWA==
X-Gm-Message-State: AOJu0Yy6D2uWSQLNDavH5fpD4wWBIFtTwHSCqvyc0BaqA0qtqyWz6AmC
        oQPTeLZSNImoQ72Eu1nAruQ=
X-Google-Smtp-Source: AGHT+IEIYqQsEYTTsY8a3PXAfXadOiOQg4SuI9aS+6yMBAVnI0NRrUeqTn7uvZ/zGgiTiFl2Vz1scg==
X-Received: by 2002:a05:6402:22a9:b0:53f:25c4:357b with SMTP id cx9-20020a05640222a900b0053f25c4357bmr22742422edb.4.1699258865104;
        Mon, 06 Nov 2023 00:21:05 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-109.cust.vodafonedsl.it. [188.217.59.109])
        by smtp.gmail.com with ESMTPSA id x1-20020a50ba81000000b005434e3d8e7bsm4221884ede.1.2023.11.06.00.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:21:04 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     sakari.ailus@linux.intel.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, mhecht73@gmail.com,
        linuxfancy@googlegroups.com, laurent.pinchart@ideasonboard.com,
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
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v13 0/3] media: i2c: Add support for alvium camera
Date:   Mon,  6 Nov 2023 09:20:55 +0100
Message-Id: <20231106082102.368937-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/media/i2c/alvium-csi2.c               | 2637 +++++++++++++++++
 drivers/media/i2c/alvium-csi2.h               |  488 +++
 7 files changed, 3228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h

-- 
2.34.1

