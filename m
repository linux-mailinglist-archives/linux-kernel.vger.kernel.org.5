Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3573775033
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjHIBPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjHIBPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:15:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA319A8;
        Tue,  8 Aug 2023 18:15:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bbf8cb694aso53407125ad.3;
        Tue, 08 Aug 2023 18:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691543748; x=1692148548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPWRUM32s+W+NzJlw5xle7BrQSCJzLbYMkNbUmW2VZM=;
        b=r6+cYmz7a9GuR4hKSjvtbYHXQ4uSc8zORRE7EPwV9JSIlZuij60Qe5TTdFTgbTfO0V
         rG1ibU41ckM+vDvqqamY+nfE+6oBdEN/Q33IzfNQHqR98uwwY8wg63IOi0m9SHliTdKF
         J+Lt/epF6QWs2YIAkePiGzsIJIkfJ1FhWnydtUJWs7UjB42SCKM5TBlhzqDJUD1ayAbn
         1isR6Yn9S51vHybdTymTQneQcoMflPeL1F1cIGrtnPfdY73uAPyuGxefgVR8cM9TKAVV
         D9njbPUBeHDlg3e7dR9dCxgbG2EukehnZ7A4kg4ABwyBKicB+sAq8FO8xr+KlG4gxoVj
         Eocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543748; x=1692148548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPWRUM32s+W+NzJlw5xle7BrQSCJzLbYMkNbUmW2VZM=;
        b=ZrGMjuYXetiZzAzF2qG13xNP64qTL5VCbaZKbvzhU2gNSTwsSVAO00bj6KpEsQT688
         giG6gTnECKww+iw1BGjzrZzdk5e5uwMZz8MlK+luAnOpSiK/7q4sLuQ8/mc+nQ0yYNzr
         2SnkSeYvexeh38A2UzZUluYlzU0h9zBe9SDx/R3bZPc+Y5EVSCxCmf8uxkA+RmQ39MML
         Xi5F/ScIRlSFkycOBI4QJsooSfW/spndIZdGvFacVTvBJWFN3wZaJHe8LazjQjQBU/S8
         7DH4j2iEEEmeU+rAk4V+t4Ee38aZqNv59NjYc+qk6qA+a4jBoLgS3lwNaYQ5SpLAt7gl
         uyHA==
X-Gm-Message-State: AOJu0YwOipaOMhgNV52N9bnJFL3DBEDdCpLwU+c9/lkgKzaimZOOs7Ci
        JCpw+8GYnBy2bV8G3ueMn6U=
X-Google-Smtp-Source: AGHT+IEaH6Ei7SipTX4Eq714C4AvTEUatqG0ziqy/qoVCZL7cJePyRr90iRzJHRUaWUZ1RmGxLyl5g==
X-Received: by 2002:a17:902:7793:b0:1b8:6cae:3570 with SMTP id o19-20020a170902779300b001b86cae3570mr1377591pll.11.1691543747719;
        Tue, 08 Aug 2023 18:15:47 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709028c9600b001bc68602e54sm5730449plo.142.2023.08.08.18.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:15:47 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [RESEND PATCH v2 0/3] Add support for Nuvoton ma35d1 rtc controller
Date:   Wed,  9 Aug 2023 01:15:39 +0000
Message-Id: <20230809011542.429945-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

