Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419C5760F87
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjGYJkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjGYJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:40:39 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAEA99;
        Tue, 25 Jul 2023 02:40:38 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-565f3881cbeso3671292eaf.2;
        Tue, 25 Jul 2023 02:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690278038; x=1690882838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPWRUM32s+W+NzJlw5xle7BrQSCJzLbYMkNbUmW2VZM=;
        b=qlngjdYSw3kOyLjGy8BltQSYFrmRJnTsSV7SAwlwaT1k/w43g0ygOMQc7PQyU2Fjhq
         dItLCtX9G619yf03JAxpj5SrcFA94gGX+/lo3icEHUtS4vwarmmThTlIw+KG4a3vxo3k
         KgDeIgeXgyVggRJ5XXV0/9lX/KW16bNFMtVyiGPmblsov6F6wge4WI6hmGFYimSrtwUW
         OyEIRHFQfa5N47JhbB4o1Djw3jVcQpegFX7Ss+IrHtbklQmeCCTYMXtfp++8zl2F7YIv
         rXRBK0Muw3rtA6k3/Tuv0ERgg12iZ+nRymRIAC0GwV5QNhfFcVZYl2DmH0BHCRh3xqRm
         iEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690278038; x=1690882838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPWRUM32s+W+NzJlw5xle7BrQSCJzLbYMkNbUmW2VZM=;
        b=J1Tar6owCPghdelq4zKemaDZYFH6WdqDxkW2olkxp0sueDnABBnI64gH/rktdoIpT/
         /D2CJl+GJVyEG5Twbpljt+8GaX8VODRhbH56jQeCSaNgd+0hVO4NnTEdZ1GwZ5wWE8XW
         YqQT8qtNZUG2nXKh3Q2Pkubmls0Y7GriDG5UQJunFgvqnd++NlRF/6wK5nlXNmbU/tX4
         iq/20mWDvUcnE9DGFBCv1EdN+n1TJccbQCzbeoWCc0alyYn9l1nsnvRnCdCQh5j3aucS
         Q/eJs+4IiouOxXFvvSvDcqyBLlh+rfYVbd4wu8dlNURi+o6dxjEXIO0wlRn7hmrejqA7
         cS/A==
X-Gm-Message-State: ABy/qLbXH3Xgyd9qfne2AKu6KPRAmZOm6Kobuwv5iFOgoZLbqomuE0Jp
        VdYn7krZrBr2TmMcxagnGfYgh/gAXKQ=
X-Google-Smtp-Source: APBJJlGEhpE4ZG6DHBRqr+w+pBzzUV9wuj+8xw33qdcVwNG1H7ZlQgHPvrn+wko5UauyLH47nGKD5A==
X-Received: by 2002:a05:6358:c19:b0:129:c6d6:ce40 with SMTP id f25-20020a0563580c1900b00129c6d6ce40mr9963624rwj.15.1690278037942;
        Tue, 25 Jul 2023 02:40:37 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id l24-20020a62be18000000b0064f7c56d8b7sm9121132pff.219.2023.07.25.02.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 02:40:37 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v2 0/3] Add support for Nuvoton ma35d1 rtc controller
Date:   Tue, 25 Jul 2023 09:40:27 +0000
Message-Id: <20230725094030.32877-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

This patch series adds the rtc driver for the nuvoton ma35d1 ARMv8 SoC.
It includes DT binding documentation, the ma35d1 rtc driver, and device
tree updates.

The ma35d1 rtc controller provides real-time and calendar messaging
capabilities. It supports programmable time tick and alarm match
interrupts. The time and calendar messages are expressed in BCD format.

This rtc driver has been tested on the ma35d1 som board with Linux 6.5-rc2.

v2:
  - Updated nuvoton,ma35d1-rtc.yaml
    - Modified patch title and fixed typo
    - Added reference to rtc.yaml
    - Used unevaluatedProperties instead of additionalProperties
  - Modified rtc driver
    - Used dev_err_probe()
    - Removed ma35d1_rtc_remove()
    - Made other minor fixes

Jacky Huang (3):
  dt-bindings: rtc: Add Nuvoton ma35d1 rtc
  arm64: dts: nuvoton: Add rtc for ma35d1
  rtc: Add driver for Nuvoton ma35d1 rtc controller

 .../bindings/rtc/nuvoton,ma35d1-rtc.yaml      |  48 +++
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |   4 +
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |   4 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |   8 +
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ma35d1.c                      | 355 ++++++++++++++++++
 7 files changed, 431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
 create mode 100644 drivers/rtc/rtc-ma35d1.c

-- 
2.34.1

