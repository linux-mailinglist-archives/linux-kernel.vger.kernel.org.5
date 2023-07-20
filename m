Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90C75B324
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjGTPkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjGTPkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:40:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92B3CE;
        Thu, 20 Jul 2023 08:40:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51f90f713b2so1344412a12.1;
        Thu, 20 Jul 2023 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689867618; x=1690472418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JI0piZU5sNjEYOXtdBH6ZjBT6nk63W7wJyW7LaZcAw=;
        b=d220ek6DDrJpviwj2v3MvP4MDu1DRqLVXv7KbJKRsH9ksrVGRfjy8BteOLK2WGAEXU
         gGJdaqAA+DfiKQjgmX7o/GpiiA1jjlsxxwUgKtL4/Wz+ToTaJRdcIimvBWc8kkJtAGQH
         qlk0OWRRZMYIYVvP0wpgpGmGG43TuvpVVZT/+UgzoBTrbKV6yg1L7LCoakvBpg1LSOgP
         98JMbdwhQ0VDFjpG5CKnIa2RUQizLtMkVIWZD8IhT6uEaIFJ+MawXN4/V1M67YelZGeV
         ts0bCZt5hUr3Yr3TLBQqUuvzFGYTJQf53AHHJvjR6yr2OmD9OR049O44JFiDIVHFB2Wi
         FIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867618; x=1690472418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JI0piZU5sNjEYOXtdBH6ZjBT6nk63W7wJyW7LaZcAw=;
        b=S1ZNi8gmwIolJ0H0x1tesUR7JcnVURD2yd6l5iu40uzxkx49OOsI/WLTrpXzTCEus7
         K018eKOQFoYndpgsYyevaNgow0YDORYhlQDVrSzLGOJVXmdQSX744oNcuZ032OEV3OJn
         FBW5Ap7MU20ZD1fygQO3yIj7ICr/pCwGeL6iEVEi6dRRpVfnP7WEFlMZDaVq7z74+XQp
         sJ9qxuIvU4AexgZoCHH0gnxc9u5BEEvT5PLla+OvvjJOx9ozTKQ3K6SAYxgEBRJWh3uj
         Dl8GMLV89XHJA9HjgK4eATnLXn/zselH2v7O4tK7duPH6u8qBd0QIAUcd7XtpR+Covbt
         CtQQ==
X-Gm-Message-State: ABy/qLYdB3sw6Zj5106gUJ9+c2pO2OgmMKTEQi5c6oibcrBoCP6on9y2
        2mLLEX7PUB9hP6Kmm62rlgmShR35E680kA==
X-Google-Smtp-Source: APBJJlE5f16VHOvYjpCJqnm4n99jMhq4cr3qZiNnRezHz9n5zHWVOF2ucs2oReoDIUaIDB77reDuhA==
X-Received: by 2002:a17:906:113:b0:991:d5ad:f1a7 with SMTP id 19-20020a170906011300b00991d5adf1a7mr5646390eje.51.1689867618106;
        Thu, 20 Jul 2023 08:40:18 -0700 (PDT)
Received: from colla-nuc.fritz.box (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id qx4-20020a170906fcc400b00987e2f84768sm869484ejb.0.2023.07.20.08.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:40:17 -0700 (PDT)
Received: from colla-nuc.fritz.box (localhost [127.0.0.1])
        by colla-nuc.fritz.box (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 36KFeGIJ119642;
        Thu, 20 Jul 2023 17:40:16 +0200
Received: (from colla@localhost)
        by colla-nuc.fritz.box (8.15.2/8.15.2/Submit) id 36KFeGPf119641;
        Thu, 20 Jul 2023 17:40:16 +0200
From:   Andrea Collamati <andrea.collamati@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrea Collamati <andrea.collamati@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?q?=5BPATCH=20v3=200/2=5D=20add=20MCP4728=20I2C=20DAC=20driver=E2=80=8B?=
Date:   Thu, 20 Jul 2023 17:40:01 +0200
Message-Id: <cover.1689857295.git.andrea.collamati@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v2->v3:
- fix wrong i2c_device_id array indentation
- removed double blank line in Kconfig
- added description in dt-bindings
- use uppercase letters for device name

Changes v1->v2:
- fix mcp4728_remove prototype
- improve indentation
- various fixes suggested by checkscript.pl
- removed unused of_device_id.data field
- removed unuseful mcp4728_data.id field
- various fixes suggested by dt_binding_check

Andrea Collamati (2):
  dt-bindings: iio: dac: add mcp4728.yaml
  iio: add MCP4728 I2C DAC driver

 .../bindings/iio/dac/microchip,mcp4728.yaml   |  48 ++
 drivers/iio/dac/Kconfig                       |  11 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/mcp4728.c                     | 638 ++++++++++++++++++
 4 files changed, 698 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
 create mode 100644 drivers/iio/dac/mcp4728.c

-- 
2.34.1

