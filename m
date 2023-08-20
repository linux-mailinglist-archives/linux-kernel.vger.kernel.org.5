Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605B3781CA2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 08:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjHTGZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 02:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjHTGZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 02:25:23 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912F62A3A4;
        Sat, 19 Aug 2023 22:25:13 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76d873c6e8aso156573785a.1;
        Sat, 19 Aug 2023 22:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692509112; x=1693113912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8LyaQ7oU9VWxzPM0ZkIDX36hxN7jVO1qAMTjMceAauI=;
        b=OjJywNdMBckIguEQkY0LO07+EIB7V+6fzVd2GeIsHCn0nxFW/mcO+XuGpke9PTqIgP
         D7e2G/7uR5MftQlpE3CBoNwm63QjfTnIuPEh2dgBuZwyuasfGzhSfOmC0fM+BRQuTAQO
         +dxGKGGWNhoMMZt0XOCETiO7qtRmgIHbbnzuYpIDpGhjIamklPWUSXcRnMCU+IhuSmnW
         Vc1lY+0bnP1qhNx38jq9a9QWFcxoh4dqPVRWKauQyxApDS9UcOsnrcVJ97YzR88pk/YC
         F51FVft0db6wXuodeTl8EcCbMnVSgc+yOHy+6Y0YwYO8J9M5ycJdcF2ETcvCptWAaXAL
         9ujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692509112; x=1693113912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LyaQ7oU9VWxzPM0ZkIDX36hxN7jVO1qAMTjMceAauI=;
        b=CnS/lNvx+9zJ+t/83s/d7I5GgQP3ykH/nbUcm0+tGSZosxDRapkeQQkp6DN6Nc+sru
         KIL+6re09CgWtKeNYlbCyrsbL6WKD4eoD59xQkbTfeu3YzAGferhzUYWfxQ+NI5FeDOd
         Gyxy2ChTAjfdJiV80UmJv4FA5ZTK6pH0cw9+FaqEGjoTrzd0AIPTxkiOB3x1v15/yQ5v
         0OfMWdxfFZwzTYoRoqrhFdy0DLH5nYXk2E9wbxWtP8yEzBrdn4yk9jFxErEqIZRCp9J5
         S27nrQTTV5MV7d9duBRkfxQiC+f+eA9KGNoqSk7ZMo1FMw4dxGqLI5xMCBvN16LBb5bf
         yaaw==
X-Gm-Message-State: AOJu0YxFEAt2/v1vL+4Du8MbiyHv5t0P7OBPlxi7nAl/CdZL+UFrExaH
        zqPAfAqjyisSoUboN1gZuV4=
X-Google-Smtp-Source: AGHT+IHmiDN79XXJbMYkN449EzB1GLvqqNw0J2hoPM/ZB45dIu9F687gntJ0/0QN1oJqF6B+an9Qkg==
X-Received: by 2002:a05:620a:e9e:b0:76c:97b1:33b5 with SMTP id w30-20020a05620a0e9e00b0076c97b133b5mr3832997qkm.12.1692509112605;
        Sat, 19 Aug 2023 22:25:12 -0700 (PDT)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id c16-20020a05620a165000b0076da29c4497sm307750qko.112.2023.08.19.22.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 22:25:12 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abdelalkuor@geotab.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add support for TPS25750
Date:   Sun, 20 Aug 2023 01:23:14 -0400
Message-Id: <cover.1692507038.git.abdelalkuor@geotab.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 is USB Type-C and PD controller. The device is
highly configurable using App Customization online Tool 
developed by TI to generate loadable binary.

TPS25750 supports three modes; PTCH, APP, and BOOT. A configuration
can only be applied when the controller is on PTCH mode.

The controller attempts to load a configuration from EEPROM on
I2Cm bus. If no EEPROM is detected, then the driver tries to load
a configuration on I2Cs bus using a firmware file defined
in DT.

The driver implements the binary loading sequence which 
can be found on pg.53 in TPS25750 Host Interface Technical
Reference Manual (Rev. A) https://tinyurl.com/y9rkhu8a

The driver only supports resume pm callback as power management is
automatically controlled by the device. See pg.47 in TPS25750
datasheet https://tinyurl.com/3vfd2k43

v3:
 - PATCH 1: Fix node name
 - PATCH 2: Upload tps25750 driver patch
v2:
 - PATCH 1: General properties clean up

Abdel Alkuor (2):
  dt-bindings: usb: Add ti,tps25750
  USB: typec: Add TI TPS25750 USB Type-C controller

 .../devicetree/bindings/usb/ti,tps25750.yaml  |   81 ++
 drivers/usb/typec/Kconfig                     |   13 +
 drivers/usb/typec/Makefile                    |    1 +
 drivers/usb/typec/tps25750.c                  | 1065 +++++++++++++++++
 drivers/usb/typec/tps25750.h                  |  162 +++
 5 files changed, 1322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tps25750.yaml
 create mode 100644 drivers/usb/typec/tps25750.c
 create mode 100644 drivers/usb/typec/tps25750.h

-- 
2.34.1

