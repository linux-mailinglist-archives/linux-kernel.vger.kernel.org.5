Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB97DDB24
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbjKACvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345164AbjKACvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:51:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5AFA4;
        Tue, 31 Oct 2023 19:51:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28035cf6a30so2540887a91.3;
        Tue, 31 Oct 2023 19:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698807093; x=1699411893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAvlH2KKSrgrOdp41LsORT+PHUNYgAsuoXWvSfHMDqM=;
        b=TmSVvKr7KbVFUA+jmXmYu2Ir0a5pYRbX+WVFbIQks3/yf9BE/IbbmbjchOw1ME3B8H
         8dnDH3jY/9VjpHSLlGowUrwvs8nmLne7SM2MdAGOPiCDhGXvsch0GKI5yyqejXkYk9jH
         rwYGBMMclBCqi6Tnh8yf2XArp6+LP9ZT1eGD+Oz+LgXZeXYjSYDnj9KR2OmAKwE8NuIt
         0fUbBY3RBv2hA0O+jI+acdLKMcgXQYBYR+rTD5JWebYrlDvSeEvtUNleuvbz9QNqbatl
         1E+krX4/hcYPNIEBVgSOuq0UmdDHoYrLxzPVEXLlOaul3JOhOjhm34iYtEuJyi+NG3Ni
         grxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698807093; x=1699411893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAvlH2KKSrgrOdp41LsORT+PHUNYgAsuoXWvSfHMDqM=;
        b=wl6CWpaimmeOMI0KfnNy9i70d5gay9itaySFVOII7mSm5IK0M+fCrDv3la6CK0auBk
         +ZTPScdVV6mQDEPhMYskGb5X1q9YctmNgMlJru8lqQvzbjuF+DMM2lpUEV53B5Tx1pX7
         Q8NvFvKwmRHsFnHv/MsXdlXZDSIt+0JyyYuPllKICrrPiY8Nv40Ikh5VxCg+WHwhwBTw
         /TofpXe7uqgCssw5bbm7aJd954G4irhaOIbmFgCMv01ogIpxwDHhn1pCK3vmtVLCkSca
         +Nqp/YS+fseNyytX9BMbWTiYuKH2yNjFpMlDk72G8/C01E0qYOO3hSAMtMdmm1OkehjX
         an2A==
X-Gm-Message-State: AOJu0YyIn0lxQWfY7o1rTlKhiYLGNMmIXZFJWWPvYUAJB7t05C78MQ/8
        rfTcN3E9uhaKjZV0BTsto2s=
X-Google-Smtp-Source: AGHT+IHDiK+kZAPBfUWvpNEUmF0l7IRvXNVXjxBE/GV8owTQaN1gy4eztarC4rUfXA6xBi8Z1I8l/w==
X-Received: by 2002:a17:90a:ead7:b0:27d:3073:88fc with SMTP id ev23-20020a17090aead700b0027d307388fcmr11170032pjb.41.1698807092965;
        Tue, 31 Oct 2023 19:51:32 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.130.202])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090b068600b002809074eb3esm1709685pjz.21.2023.10.31.19.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 19:51:32 -0700 (PDT)
From:   Jim Liu <jim.t90615@gmail.com>
To:     JJLIU0@nuvoton.com, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, andy@kernel.org, benjaminfair@google.com,
        brgl@bgdev.pl, jim.t90615@gmail.com, robh@kernel.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v7 0/3] Add Nuvoton NPCM SGPIO feature
Date:   Wed,  1 Nov 2023 10:51:07 +0800
Message-Id: <20231101025110.1704543-1-jim.t90615@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC.
Nuvoton NPCM SGPIO module is combine serial to parallel IC (HC595)
and parallel to serial IC (HC165), and use APB3 clock to control it.
This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
NPCM7xx/NPCM8xx have two sgpio module each module can support up
to 64 output pins,and up to 64 input pin, the pin is only for gpi or gpo.
GPIO pins have sequential, First half is gpo and second half is gpi.

Jim Liu (3):
  dt-bindings: gpio: add NPCM sgpio driver bindings
  arm: dts: nuvoton: npcm: Add sgpio feature
  gpio: nuvoton: Add Nuvoton NPCM sgpio driver

 .../bindings/gpio/nuvoton,sgpio.yaml          |  86 +++
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   |  24 +
 drivers/gpio/Kconfig                          |   8 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-npcm-sgpio.c                | 649 ++++++++++++++++++
 5 files changed, 768 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
 create mode 100644 drivers/gpio/gpio-npcm-sgpio.c

-- 
2.25.1

