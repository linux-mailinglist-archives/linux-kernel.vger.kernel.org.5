Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B7D7D4B82
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjJXJHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJXJHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:07:00 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FC5E8;
        Tue, 24 Oct 2023 02:06:58 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5859d13f73dso2599477a12.1;
        Tue, 24 Oct 2023 02:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698138418; x=1698743218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yDL40uP+kAC3ujsM0EdFsGaQpPzT9QQURdIX1zfn8SM=;
        b=Wu7DaDCnLS8i3gqtPJ3OCJzSxZCuHg49i81i7Ceo3kYIrHDyMtg1gO8a95W7jPMqL1
         wHz1v/qH1VZ0zqQHh+zvbrcyEL6cxOQ4rkmLdFfm0f8Y6rXecAgaE1G1078KV6n+ZKTW
         L3bXsGzbjKLxvD4kzbEHpodG+KEhuDxSjZh3/LbMCnKm8kOu5gGwFtxQZJBYnuUK3cRC
         hZaFZeAuxcIz95ZBfAC2GX2a9O37SP0LiuMOIWP/sDjmawk7aQwTo4v/YKZQbVJ0/h8G
         vALYiRNQMsmhUa/Xq+BuljmYApmNQScdCvDpRBIpAbmWelM6kTR4Slcq47xqGbwX0FV2
         mtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698138418; x=1698743218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDL40uP+kAC3ujsM0EdFsGaQpPzT9QQURdIX1zfn8SM=;
        b=Lnj4CEGRoxFyyndLDAUKZQSNAEpgklGCBBVbtcF7xPANMpFQydngebuqSPEDlCbD1z
         olunthskcz1e0EWwnhXjqpCZwHycUnWq/ro2nA3li1xeST5H7PRZ5N8R0lpjTjP67EE8
         SciCULal3InbRZ/1OciOpXm6QzhpZG1eJbw6EJA3TI3cswQVHzg/R5HgrFLEJmYCnH79
         SXx0qJ/p++65AaXG/4/rwvDWGdLBWK+T5oTVUlKMDzQAaB6a5Y+8sGE9MuF/f5fEPBgH
         Ug+rH7QilgdERKPGAELWc9xaH318gVe4Y8odlNWh4agLdSe5lOwBN/DPO9VAdDZOOFYN
         5x1A==
X-Gm-Message-State: AOJu0Yyjihgq/jPKONEOoC9AK1hAHQWUZGIwnPv1LEfE7kKMO8dY46/F
        o9GOMslgaMqiGOTzGXMTZ3o=
X-Google-Smtp-Source: AGHT+IGPI0C1cwkNW52VsX90UmIRRS7/kDnveimVHYzyudFdRLFzW3L08ZWGf9t+sYXuJduWkE/VYw==
X-Received: by 2002:a05:6a21:1448:b0:17a:d173:42f1 with SMTP id oc8-20020a056a21144800b0017ad17342f1mr1464806pzb.44.1698138418256;
        Tue, 24 Oct 2023 02:06:58 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.144.223])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902d91800b001c9ab91d3d7sm7055324plz.37.2023.10.24.02.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 02:06:57 -0700 (PDT)
From:   Jim Liu <jim.t90615@gmail.com>
To:     jim.t90615@gmail.com, JJLIU0@nuvoton.com, linus.walleij@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v6 0/3] Add Nuvoton NPCM SGPIO feature
Date:   Tue, 24 Oct 2023 17:06:28 +0800
Message-Id: <20231024090631.3359592-1-jim.t90615@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/gpio/gpio-npcm-sgpio.c                | 650 ++++++++++++++++++
 5 files changed, 769 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
 create mode 100644 drivers/gpio/gpio-npcm-sgpio.c

-- 
2.25.1

