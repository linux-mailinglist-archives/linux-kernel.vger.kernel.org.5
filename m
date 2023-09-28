Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7C97B237C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjI1RPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1RO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:14:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7750BE5;
        Thu, 28 Sep 2023 10:14:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8808C433C7;
        Thu, 28 Sep 2023 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695921298;
        bh=Tw/MBuqJbVhiahwI6Oee4TQln3rp94ykoKAprce0/ro=;
        h=From:To:Cc:Subject:Date:From;
        b=r5qCzk+rPVHtWc/EEbQL6oIpiG4dGv8t1ICFQP1GjEdl7w+TfNkQd0M73Qus8ngV+
         NmUYHbyaoI2aX48wzQaW+kCrJezTfySz10bY+QqY7r+mlAyRe5wkwUFy3q7xYM85lX
         eObkO0OVHsq76nyhuRG1E7fQqJV3TZ3Qd2HtQId0yYqSPHAS/vj+Z30gAu78VFrfu7
         IQxRurbNS/cr1mP6hX9fksfEziEcRqFlsDnh5o4DHnX8tRd7YlwD9w/LhPHrpDgd+F
         ciR2097/18ttEoKMuh9wtx543l9wtIlfV1nSCSZYkpremZ+6d+/gj/VYt9JNk7lK+E
         VJGSEQ62PEQ2w==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, linux-riscv@lists.infradead.org
Subject: [PATCH 0/2] pwm: add driver for T-THEAD TH1520 SoC
Date:   Fri, 29 Sep 2023 01:02:52 +0800
Message-Id: <20230928170254.413-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T-HEAD SoCs such as the TH1520 contain a PWM controller used
among other things to control the LCD backlight, fan and so on.
Add the PWM driver support for it.

Since the clk part isn't mainlined, so SoC dts(i) changes are not
included in this series. However, it can be tested by using fixed-clock.

Jisheng Zhang (2):
  dt-bindings: pwm: Add T-HEAD PWM controller
  pwm: add T-HEAD PWM driver

 .../devicetree/bindings/pwm/pwm-thead.yaml    |  44 +++
 MAINTAINERS                                   |   1 +
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-thead.c                       | 289 ++++++++++++++++++
 5 files changed, 346 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-thead.yaml
 create mode 100644 drivers/pwm/pwm-thead.c

-- 
2.40.1

