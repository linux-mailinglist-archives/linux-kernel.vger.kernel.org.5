Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC74477BA1D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjHNNdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjHNNcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:32:52 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AA6D1;
        Mon, 14 Aug 2023 06:32:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe9f226cdbso2782094e87.0;
        Mon, 14 Aug 2023 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692019969; x=1692624769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jFB+OiQyX+/XOrvqOgAzluwmxlG/0gir8mZMAan80sw=;
        b=U/rESK8k1FcKUXYvqdeMCVajTRetZeGOxB+NAqre7b5Avu8pjh1fznhzzqdL7+jXRM
         7iOeud9RvZs0+jpxBHfZnfdUQmbeaWfyPzGTeZqkcMT63XFi6QEJRhneB4eUE+IsIm+L
         WCdzRTSJ67MsAmYPdnkbwmvhp3MhYPlShrtJBqBly7E1yHp/3ypR7L5BB55G3pzIdVih
         ow1hpaxh95eoq3qPBvs2lsDwDs975vvxisoBF0tNhy6v7Hl1dVOIKAF0WCiYc8hVW2hW
         yt3+Ui6aMWk2PiMzlamcz5mEasUhcGS1nnW1YKxx/thPPWBmiTxE7hjm1/fJ6c+C/EMv
         pd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019969; x=1692624769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFB+OiQyX+/XOrvqOgAzluwmxlG/0gir8mZMAan80sw=;
        b=X+6D1xJbPQoAvn72hvyymvh7mMcytEpy5Cv3MKknp5IIhako47bWcQ9KdugOehpfJx
         YKnI2VUfgIzGwhOWlFnZGtWEkrPG3EfK8wBCdq1RDqVNR3NIutN3n4P0hLU5GLP35dlL
         lYuTqAYmCYW6OGFMwiiUfDhfRkB9Bjse9r8IEATkOM1XuzgmSCIIl7f3f7s1w8S3KxQK
         RkyR2CebvDRJ4SReaLjF1BFMPvZ4sDiDRE52esxJid9R5deUv5fUzo4bdKGhrk/23CgZ
         sfnmF/QByu12mM/6XC2qPMfw+BzO9jRjKnbdfAVxeoW7fzJV+gYe4QZGUJabW5IPIFZ8
         ESOw==
X-Gm-Message-State: AOJu0YwJq+DRW70cQBu3jp0kkfVO7ppme+ByemgmKTD3Z105NcSIdR3T
        XaEffyHvheq8paUVs583wwNTSV7eZ16C9+Y=
X-Google-Smtp-Source: AGHT+IGvM+UlcUf8ntbiSxA6/SMSxnY9ei7EEuEEOrWYCEafQ/pnVMuFaoNipOnzOCOeqUFUMFKAgg==
X-Received: by 2002:ac2:58c6:0:b0:4fe:85c:aeba with SMTP id u6-20020ac258c6000000b004fe085caebamr5580767lfo.21.1692019969086;
        Mon, 14 Aug 2023 06:32:49 -0700 (PDT)
Received: from localhost.localdomain (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.gmail.com with ESMTPSA id eo12-20020a056512480c00b004f858249932sm1990566lfb.90.2023.08.14.06.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:32:48 -0700 (PDT)
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
        Andre Przywara <andre.przywara@arm.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date:   Mon, 14 Aug 2023 16:32:15 +0300
Message-Id: <20230814133238.741950-1-privatesub2@gmail.com>
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

Aleksandr Shubin (3):
  dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
    controller
  pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
  riscv: dts: allwinner: d1: Add pwm node

 .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  85 +++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  11 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun20i.c                      | 323 ++++++++++++++++++
 5 files changed, 430 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sun20i.c

-- 
2.25.1

