Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05669786E25
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbjHXLky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241057AbjHXLkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:40:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A096E1987;
        Thu, 24 Aug 2023 04:40:49 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bc63e0d8cdso76685011fa.2;
        Thu, 24 Aug 2023 04:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692877247; x=1693482047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUBPftbqiVDHPFOQPydkZ4vgpp9Vl66RXM1E4eqnDFs=;
        b=XVNVisAYzFTW7+/m1W01itYhKhboMCitrCdEtMNkEO0Urd5h1pROw/hrX1K5lDp94b
         5Wuo+7FY3IN8YJbgRXNUVRxLCTnyyk14nMVzf3+yVjQDplXQxfVJWA8To9duw3Ey9iqv
         CvEk2vE0EwiHV9qSQ3S/sFTpkqYVUpXH3W9dBRpq/rc3RqyyLLBH+M6Pb1KsH0JOQPf/
         9QxyRNMEns0v4iP6DjgTruBxR0NxaV/SFvGvG6ya+wpO7/pMg48I5gYkKbpuypmOWKcd
         EjrD3CAdnoZyeSty7e0DAoMnsBQOXe4bPCmvciY3m7aec267sQ6LydvRBV+mEyKPAUFs
         Wn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692877247; x=1693482047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUBPftbqiVDHPFOQPydkZ4vgpp9Vl66RXM1E4eqnDFs=;
        b=YWT4c/2uhbGScv06uwugX5xr/yUtTe5ngIeXKMaH0/ToSJmMaKF3S+bVnWqgK4fzNT
         wm3ejWY62g8yFJqC5jkoFXKa3mMsFz2uMD04Fx2NaAk45oCZdtAh/1sZGxRkkIrRlJPw
         /n/L1ig1FgN0GC1MnbiJJGOElf3C33z1o0ZLn5tsgMBHkAaskJh4nybgvnXdYKN6BR1X
         ZsUadeOIO7EbRRb3njQSvnfDtldBwNTStS9chrpo7Fmr9RbVCksQUB7ux+kFxhuFYBYl
         9IyQPP1wc0Uys2FsfHghqNANowPsoQd4O7pccnvPr4PkEIxBI/d8Jdc+m4vjWmMAkN+x
         +n6w==
X-Gm-Message-State: AOJu0YyWpU7km5MFfUZfDlpMPusVcS0gk9PB637NFR4lxpgCnGi9zyJu
        /g1fzSN4YpikOQXd3PwfwDMFCI/mBQjYdQU=
X-Google-Smtp-Source: AGHT+IEjEXjcTrhVknpjRsjFOnmLOykW5okJzmpKyLYFRnIsDAMt738D7JOkHqHLGYF3nIO298FHyA==
X-Received: by 2002:a2e:88cb:0:b0:2bc:be3c:9080 with SMTP id a11-20020a2e88cb000000b002bcbe3c9080mr8558507ljk.27.1692877247191;
        Thu, 24 Aug 2023 04:40:47 -0700 (PDT)
Received: from localhost.localdomain (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.gmail.com with ESMTPSA id o17-20020a2e0c51000000b002ba053e1f9bsm534568ljd.35.2023.08.24.04.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:40:46 -0700 (PDT)
From:   Aleksandr Shubin <privatesub2@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Aleksandr Shubin <privatesub2@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v6 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date:   Thu, 24 Aug 2023 14:40:24 +0300
Message-Id: <20230824114038.891493-1-privatesub2@gmail.com>
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

Hi,

This series adds support for PWM controller on new
Allwinner's SoCs, such as D1, T113s and R329. The implemented driver
provides basic functionality for control PWM channels.

v2:
 - fix dt-bindings
 - fix a remark in the driver

v3:
 - fix dt-bindings
 - fix sunxi-d1s-t113.dtsi

v4:
 - fix a remark in the driver

v5:
 - dropped unused varibale in the driver
 - fix dt-bindings

v6:
 - add apb0 clock

Aleksandr Shubin (3):
  dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
    controller
  pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
  riscv: dts: allwinner: d1: Add pwm node

 .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  87 +++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun20i.c                      | 328 ++++++++++++++++++
 5 files changed, 438 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sun20i.c

-- 
2.25.1

