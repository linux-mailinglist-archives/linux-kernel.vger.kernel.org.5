Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81704781F90
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjHTTis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjHTTip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:38:45 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162741BD9;
        Sun, 20 Aug 2023 12:32:51 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58c5642701fso30503057b3.0;
        Sun, 20 Aug 2023 12:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692559970; x=1693164770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1q9ksZXGx9cXmR47rVp5qzEPJFyOpXFFD3HDKE+iG5M=;
        b=hvp7wGkgVvBbMh5bu3CDNAbxvnZaqXaUY4NVgQSnYFic7SD4AL6hLKcsuX+toB2WTz
         qdC1/lJ366Lp/t3ziau+LCAcz8Q5KXsgcdCK81dBeuqBEE/iB1+wy09Sp4qCfsuoWDeK
         p3IjI6u3uSt9HbPauv4AO+i0Ic7/xbOZ/d1ha0scEN8QA/Z9iulBSDHAsjC7S5ueiRgd
         QYa23fn2yOX2eO16rIqMUS1UETRFSdpi9xlOjHZn8oDB8mHqN+ogsSyzpIr8JER/4AY+
         y+9MOAKM9YnSVDww1F12clMOn35YTAQQoQmgydyGpqQAY0hFxqkgq0IGDJefHrbkim4A
         tWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692559970; x=1693164770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1q9ksZXGx9cXmR47rVp5qzEPJFyOpXFFD3HDKE+iG5M=;
        b=aIzswbekUvT23VrXTAZhIWU9p0VfpQBRGVzArZOipmvFIlV4OTVhbqkZLLnPnqphQI
         xW2KDMKH4Q/lsv1+WWwCMMEMa29VpfmbQM5M21vINMqF3ks/LKt/WqdFD2RsAn3d7dCo
         i/kEYZVOaUFOM8x61gjFJDXELmh0YJ2doZFSG9QPSMPPyRlvYdB0qa2SW1l90+nJKH0z
         4wF6w4TdTen1L+lHVOgkoov/+QEkqTBOa4R/mNvc7f5U2viYmNSp5xRkJ8ALpQqTyqMy
         93WJNijrQA2mMHJ8nRwmG5UI3zGc+NkmffDJ4aOoaBLKwpl0T4BWfSc8CChjdapxAm/E
         jZ2Q==
X-Gm-Message-State: AOJu0YyoYkHCq7XoJuxat/TPAk9QMfoptJK9XPK8U1kZGthuDg//XBB0
        T8J6jpDAUfkdwdt848VRaN4=
X-Google-Smtp-Source: AGHT+IF90wSLGTeXZ5Bi6Vc8FoNylo1VMF8m+A3OMI1Ozs1N4HSGYsEiRtTQvQFjz7f0qmkoTJLQBA==
X-Received: by 2002:a81:6e89:0:b0:58c:8b7e:a1ce with SMTP id j131-20020a816e89000000b0058c8b7ea1cemr5478891ywc.46.1692559970150;
        Sun, 20 Aug 2023 12:32:50 -0700 (PDT)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id c16-20020a0cf2d0000000b0063d0159e1f6sm2308042qvm.109.2023.08.20.12.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 12:32:49 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abdelalkuor@geotab.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abdel Alkuor <alkuor@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 0/2] Add support for TPS25750
Date:   Sun, 20 Aug 2023 15:32:25 -0400
Message-Id: <cover.1692559293.git.alkuor@gmail.com>
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

v4:
 - PATCH 1: No change
 - PATCH 2: Fix comments style and drop of_match_ptr
v3:
 - PATCH 1: Fix node name
 - PATCH 2: Upload tps25750 driver patch
v2:
 - PATCH 1: General properties clean up
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Abdel Alkuor (2):
  dt-bindings: usb: Add ti,tps25750
  USB: typec: Add TI TPS25750 USB Type-C controller

 .../devicetree/bindings/usb/ti,tps25750.yaml  |   81 ++
 drivers/usb/typec/Kconfig                     |   13 +
 drivers/usb/typec/Makefile                    |    1 +
 drivers/usb/typec/tps25750.c                  | 1077 +++++++++++++++++
 drivers/usb/typec/tps25750.h                  |  162 +++
 5 files changed, 1334 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tps25750.yaml
 create mode 100644 drivers/usb/typec/tps25750.c
 create mode 100644 drivers/usb/typec/tps25750.h

-- 
2.34.1

