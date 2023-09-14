Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719067A09A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbjINPsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbjINPsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:48:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D1E99;
        Thu, 14 Sep 2023 08:48:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so999237f8f.1;
        Thu, 14 Sep 2023 08:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694706482; x=1695311282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ONgl35cyTuTloZEtJw37EUccE7G4fFk4/1kXTlAThVg=;
        b=A7kjyFYYUFkJnjkRuZVDUN7T8WNHjXjKoPW3+i/MOwC+BSy6yJKSuTAN7WPBa/+gyg
         p3flOppSTXGiUEraJVkjC4dG4y0kJsWnip86DIaRr1hzq6ee7Pt0P4SsWxaBN8FvvRZz
         NYvgZnm3idZLxdEe9guvp+IIhMu4/h/yv8uts5dlDk0qfyMEcFC9apqR0rKhrAGxYe64
         I5XZxFcIVaNMOXaUwS+jEQEMNSZSe6/97z3mT7olIFh+hGd/A+mTwQS5dVVRMCCDMurT
         Z3T0szVGJNTJu+DEyvFXFOkUW80iRNLgjnE0MDGdgtKL8HLXrafOWGnM/5yXvwiDCJq8
         sf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694706482; x=1695311282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONgl35cyTuTloZEtJw37EUccE7G4fFk4/1kXTlAThVg=;
        b=wEuHJAKUF1jzsTYzREumNg6/0NuY9lkDL/3BDWh8iTn+UyfrqVxOn/gc+lVBOLcK39
         MfyFE9wtrKp8XeCJVOs8glm0yY3rofvFThtTjukBVX6zRcYVDB8NjDsYt0VrvtHf++d8
         bomUDMbNFRZUIqpmDdaDFtJFmzD3M9l8r5OI8tblYSJUmterSfvQLeSrPrLS2ZDA3Y2u
         rbPyVlDw6U82PUfuuzVi/lzuSGm6olQ8juEuy+/4eYV7Ff/M+Niiv6zaQefULMQhYDcH
         MQZ3ZXICQumXVl+hWMecbXvmbDwYnxQ4aQ9isXHVMeL3/liN/wUV4TsjJ83Rtyc6N5oY
         bV3w==
X-Gm-Message-State: AOJu0YzIbEIz0HDRxjw/DCSVLURQqkb9gZCWkG4hiZ9tHPgBYWkPBeBZ
        XnrQNJPaSdeViuqEGiF45ps=
X-Google-Smtp-Source: AGHT+IH8JftPMCQzejNi3579EryjIIi2ielENx0BePtQ+HJX1wxhOxxg8PIsva0nRaybUDOrPKzt8A==
X-Received: by 2002:adf:ce04:0:b0:317:ef76:b776 with SMTP id p4-20020adfce04000000b00317ef76b776mr5094389wrn.68.1694706481548;
        Thu, 14 Sep 2023 08:48:01 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-54-79.cust.vodafonedsl.it. [188.217.54.79])
        by smtp.gmail.com with ESMTPSA id f13-20020adff44d000000b0031c79de4d8bsm2071169wrp.106.2023.09.14.08.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:48:01 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        linuxfancy@googlegroups.com, hdegoede@redhat.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Martin Hecht <martin.hecht@avnet.eu>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v8 0/3] media: i2c: Add support for alvium camera
Date:   Thu, 14 Sep 2023 17:47:52 +0200
Message-Id: <20230914154758.1795663-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Back on topic :).

This series add support for Allied Vision Alvium camera.
The Alvium camera is shipped with sensor + isp in the same housing.
The camera can be equipped with one out of various sensor and abstract
the user from this. Camera is connected via MIPI CSI-2.

I have rebase v8 on top of media-stage branch [1].
Test was done taking as refence last build tooling from
HVerkuil[2]. Thanks to this tool I'm able to fix the following
warnings:

drivers/media/i2c/alvium-csi2.c:398:18: warning: incorrect type in assignment (different base types)
drivers/media/i2c/alvium-csi2.c:398:18:    expected unsigned short [usertype] minor
drivers/media/i2c/alvium-csi2.c:398:18:    got restricted __le16 [usertype]
drivers/media/i2c/alvium-csi2.c:399:18: warning: incorrect type in assignment (different base types)
drivers/media/i2c/alvium-csi2.c:399:18:    expected unsigned short [usertype] major
drivers/media/i2c/alvium-csi2.c:399:18:    got restricted __le16 [usertype]
drivers/media/i2c/alvium-csi2.c:416:21: warning: incorrect type in assignment (different base types)
drivers/media/i2c/alvium-csi2.c:416:21:    expected unsigned short [usertype] minor
drivers/media/i2c/alvium-csi2.c:416:21:    got restricted __le16 [usertype]
drivers/media/i2c/alvium-csi2.c:417:21: warning: incorrect type in assignment (different base types)
drivers/media/i2c/alvium-csi2.c:417:21:    expected unsigned int [usertype] patch
drivers/media/i2c/alvium-csi2.c:417:21:    got restricted __le32 [usertype]
drivers/media/usb/siano/smsusb.c:53:38: warning: array of flexible structures

drivers/media/i2c/alvium-csi2.c:2665 alvium_probe() warn: missing error code? 'ret'
drivers/media/i2c/alvium-csi2.c:2671 alvium_probe() warn: ignoring unreachable code.
drivers/media/usb/siano/smsusb.c:53:38: warning: array of flexible structures.


Driver use last v4l2 CCI API.
This driver has been tested on the following scenario:

 alvium-csi2 -> imx8mp-evk (isi pixel pipeline)

Thanks & Regards,
Tommaso

[1] - https://git.linuxtv.org/media_stage.git/tree/Documentation/devicetree/bindings/vendor-prefixes.yaml
[2] - https://git.linuxtv.org/hverkuil/build-scripts.git

Tommaso Merciai (3):
  dt-bindings: vendor-prefixes: Add prefix alliedvision
  media: dt-bindings: alvium: add document YAML binding
  media: i2c: Add support for alvium camera

 .../media/i2c/alliedvision,alvium-csi2.yaml   |   97 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    9 +
 drivers/media/i2c/Kconfig                     |   11 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/alvium-csi2.c               | 2761 +++++++++++++++++
 drivers/media/i2c/alvium-csi2.h               |  474 +++
 7 files changed, 3355 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h

-- 
2.34.1

